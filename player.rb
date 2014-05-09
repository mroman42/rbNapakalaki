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
            @level = 1
            @pendingBadConsequence = BadConsequence.new_indet_tr("",0,0,0)
            @hiddenTreasures = []
            @visibleTreasures = []

           initTreasures
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

        def die
            # Es necesario comprobar si están vacíos o son nil.  
            if !(@hiddenTreasures.empty? || @hiddenTreasures == nil)
                @hiddenTreasures.each {|treasure| CardDealer.instance.giveTreasureBack(treasure)}
                @hiddenTreasures.clear
            end
            if !(@visibleTreasures.empty? || @visibleTreasures == nil)
                @visibleTreasures.each {|treasure| CardDealer.instance.giveTreasureBack(treasure)}
                @visibleTreasures.clear
            end
            @dead = true
        end

        # Si el collar está visible, lo devuelve al mazo de tesoros.
        def discardNecklaceIfVisible
            @visibleTreasures.delete_if {|trs| trs.getType == NECKLACE}
        end

        def dieIfNoTreasures
            if (@visibleTreasures + @hiddenTreasures).empty?
                @dead = true
            end
        end

        def computeGoldCoinsValue(treasure)
            value = 0
            treasure.each {|t| value += t.getGoldCoins}
            value/1000
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
                @hiddenTreasures.push(CardDealer.instance.nextTreasure)
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
                @hiddenTreasures.delete(treasure)
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
                return !(@visibleTreasures.any? {|trs| trs.getType == type})

            # 3. Si es de una mano, puede hacerse visible si no hay ya dos de una mano visibles o uno de dos manos. 
            elsif (type == ONEHAND)
                has_two_onehand = (@visibleTreasures.select{|trs| trs.getType == ONEHAND}.size >= 2)
                has_bothhand = @visibleTreasures.any? {|trs| trs.getType == BOTHHANDS}
                return (!has_bothhand and !has_two_onehand)
            
            # 4. Si es de dos manos, puede hacerse visible si no hay ningún tesoro de mano equipado. 
            else 
                return !(@visibleTreasures.any? {|trs| trs.getType == ONEHAND or trs.getType == BOTHHANDS})
            end 
        end
        
        
        # Elimina un tesoro visible. 
        # Primero lo elimina de la lista de tesoros visibles, y si quedan tesoros en el mal rollo, lo sustrae de él
        # llamando al método correspondiente. Después, devuelve el tesoro al mazo, y comprueba si al jugador le quedan tesoros. 
        def discardVisibleTreasure(treasure)
            @visibleTreasures.delete(treasure)

            if (@pendingBadConsequence != nil && !@pendingBadConsequence.empty?)
                @pendingBadConsequence.substractVisibleTreasure(treasure)
            end 

            CardDealer.instance.giveTreasureBack(treasure)
            dieIfNoTreasures
        end


        # Elimina un tesoro oculto. 
        # Primero lo elimina de la lista de tesoros ocultos, y si quedan tesoros en el mal rollo, lo sustrae de él
        # llamando al método correspondiente. Después, devuelve el tesoro al mazo, y comprueba si al jugador le quedan tesoros. 
        def discardHiddenTreasure(treasure)
            @hiddenTreasures.delete(treasure)
            if (@pendingBadConsequence != nil && !@pendingBadConsequence.empty?)
                @pendingBadConsequence.substractHiddenTreasure(treasure)
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
            necklace = @visibleTreasures.any? {|trs| trs.getType == NECKLACE}

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
                @hiddenTreasures.push(CardDealer.instance.nextTreasure)
            elsif (number == 6)
                3.times do
                    @hiddenTreasures.push(CardDealer.instance.nextTreasure)
                end 
            else 
                2.times do
                    @hiddenTreasures.push(CardDealer.instance.nextTreasure)  
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
            "#{@name}, con nivel #{@level}."
        end
    end

end
