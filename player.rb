#!/usr/bin/env ruby
#encoding: utf-8
require_relative 'dice.rb'
require_relative 'combatResult.rb'
require_relative 'treasure.rb'
require_relative 'badConsequence.rb'
require_relative 'treasureKind.rb'


module Game
    
    class Player
        
        # Inicializador
        def initialize(name)
            @dead = true
            @name = name
            @level = 1   #¿Necesario? Lo hace bringToLife
            @pendingBadConsequence = BadConsequence.new_indet_tr("",0,0,0)
            @hiddenTreasures = []
            @visibleTreasures = []

            bringToLife
        end



        # Métodos privados
        private

        def bringToLife()
            @dead = false
            @level = 1
        end

        def incrementLevels(increment)
            @level += increment
        end

        def decrementLevels(decrement)
            @level = [@level-decrement, 1].max
        end

        def setPendingBadConsequence(bad)
            @pendingBadConsequence = bad
        end

        def die()
            @hiddenTreasures.each {|treasure| CardDealer.instance.giveTreasureBack(treasure)}
            @hiddenTreasures.clean()
            @visibleTreasure.each {|treasure| CardDealer.instance.giveTreasureBack(treasure)}
            @visibleTreasure.clean()

            @dead = true
        end

        # Si el collar está visible, lo devuelve al mazo de tesoros.
        def discardNecklaceIfVisible
            @visibleTreasures.each do |treasure| 
                if (treasure.getType == TreasureKind.NECKLACE) 
                    CardDealer.instance.giveTreasureBack(treasure) 								
                    @visibleTreasures.remove(treasure)
                end
            end
        end

        def dieIfNoTreasures
            if (@visibleTreasures + @hiddenTreasures).empty?
                @dead = true
            end
        end

        def computeGoldCoinsValue(treasure)
            value = 0
            treasure.each {|t| value += getGoldCoins(t)}
            value 
        end

        def canIBuyLevels(levels)
            (levels + @level) < 10
        end



        # Métodos públicos
        public
        
        # Aplicamos el buen rollo al jugador, incrementando los niveles y obteniendo los tesoros. 
        # En caso de que con los tesoros obtenidos se superen los 4 ocultos, solo se obtendrán los restantes hasta llegar a 4. 
        def applyPrize(prize)
            incrementLevels(prize.getLevels)
            nPrize = prize.getTreasures

            [nPrize, 4 - @hiddenTreasures.size].min.times do
                @hiddenTreasures.add(CardDealer.instance.nextTreasure)
            end
        end

        # Combate contra un monstruo. Obtenemos los niveles del jugador y del monstruo, y aplicamos las reglas del juego. 
        def combat(monster)
            total_level = getCombatLevel
            monster_level = monster.getLevel
            # Ganamos
            if (total_level > monster_level)
                applyPrize(monster.getPrize)
                if (@level >= 10)
                    result = WINANDWINGAME
                else
                    result = WIN
                end
            else 
                escape = Dice.instance.nextNumber
                # Perdemos y no escapamos
                if (escape < 5) 
                    bad = monster.getBadConsequence
                    if (bad.kills)
                        die
                        result = LOSEANDDIE
                    else 
                        applyBadConsequence(bad)
                        result = LOSE
                    end    
                # Perdemos y escapamos
                else 
                    result = LOSEANDESCAPE
                end 
            end 

            discardNecklaceIfVisible
            result
        end    

        def applyBadConsequence(bad)
            decrementLevels(bad.getLevels)
            setPendingBadConsequence(bad.adjustToFitTreasureLists(@visibleTreasures, @hiddenTreasures))
        end

        # Hace visible un tesoro si es posible. Devuelve si el tesoro se ha hecho visible. 
        def makeTreasureVisible(treasure)
            if canMakeTreasureVisible(treasure)
                @visibleTreasures.push(treasure)
                @hiddenTreasures.remove(treasure)
                return true
            else
                return false
            end
        end
        
        # Comprueba si un tesoro puede hacerse visible.
        def canMakeTreasureVisible(treasure)
            type = treasure.getType

            # 1. Si es el collar, puede hacerse visible.
            if type == NECKLACE
                return true

            # 2. Si no es de mano(una o dos), se puede hacer visible si no hay otro del mismo tipo.
            elsif (type != ONEHAND and type != BOTHHANDS)
                return (!@visibleTreasures.include? treasure)

            # 3. Si es de mano, puede hacerse visible si no hay ya dos de una mano visibles o uno de dos manos. 
            else 
                return (!@visibleTreasures.include? BOTHHANDS and @visibleTreasures.count(ONEHAND) < 2)
            end 
        end
        
        
        # Elimina un tesoro visible. 
        # Primero lo elimina de la lista de tesoros visibles, y si quedan tesoros en el mal rollo, lo sustrae de él
        # llamando al método correspondiente. Después, devuelve el tesoro al mazo, y comprueba si al jugador le quedan tesoros. 
        def discardVisibleTreasure(treasure)
            @visibleTreasures.remove(treasure)

            if (@pendingBadConsequence != nil && !@pendingBadConsequence.isEmpty)
                @pendingBadConsequence.subtractVisibleTreasure(treasure)
            end 

            CardDealer.instance.giveTreasureBack(treasure)
            dieIfNoTreasures
        end


        # Elimina un tesoro oculto. 
        # Primero lo elimina de la lista de tesoros ocultos, y si quedan tesoros en el mal rollo, lo sustrae de él
        # llamando al método correspondiente. Después, devuelve el tesoro al mazo, y comprueba si al jugador le quedan tesoros. 
        def discardHiddenTreasure(treasure)
            @hiddenTreasures.remove(treasure)
            if (@pendingBadConsequence != nil && !@pendingBadConsequence.isEmpty)
                @pendingBadConsequence.subtractHiddenTreasure(treasure)
            end 
            CardDealer.instance.giveTreasureBack(treasure)
            dieIfNoTreasures
        end


        # Comprueba si puede comprar niveles. Si es así, lo hace y elimina los tesoros. 
        # Devuelve si se han comprado niveles o no. 
        def buyLevels(visible, hidden)
            levels = computeGoldCoinsValue(visible) + computeGoldCoinsValue(hidden)

            if canIBuyLevels(levels) 
                incrementLevels(levels)

                visible.each {|t| discardVisibleTreasure(t)}
                hidden.each {|t| discardHiddenTreasure(t)}

                return true
            end

            return false
        end


        # Calcula el nivel de combate del jugador
        def getCombatLevel
            combat_level = @level
            necklace = @visibleTreasures.include? NECKLACE

            @visibleTreasures.each do |treasure|
                if necklace
                    combat_level += treasure.getMaxBonus
                else
                    combat_level += treasure.getMinBonus
                end
            end

            combat_level
        end

        # Comprueba si el mal rollo pendiente está vacío, para saber si puede continuar. 
        def validState
            @pendingBadConsequence.isEmpty
        end

        # Inicializa los tesoros de un jugador, dependiendo del número sacado al tirar del dado. 
        def initTreasures
            bringToLife
            number = Dice.instance.nextNumber

            if (number == 1)
                @hiddenTreasures.add(CardDealer.instance.nextTreasure)
            elsif (number == 6)
                3.times do
                    @hiddenTreasures.add(CardDealer.instance.nextTreasure)
                end 
            else 
                2.times do
                    @hiddenTreasures.add(CardDealer.instance.nextTreasure)  
                end
            end
        end

        def isDead
            @dead
        end 

        def hasVisibleTreasures
            !@visibleTreasures.empty?
        end

        def getVisibleTreasures
            @visibleTreasures
        end

        def getHiddenTreasures
            @hiddenTreasures
        end


        # Métodos Auxiliares
        def to_s
            "#{@name}, con nivel #{@level}.\n\tTesoros visibles: #{@visibleTreasures}.\n\tTesoros ocultos: #{@hiddenTreasures}."
        end
    end

end
