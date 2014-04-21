#!/usr/bin/env ruby
#encoding: utf-8
require_relative 'dice.rb'
require_relative 'combatResult.rb'
require_relative 'treasure.rb'
require_relative 'badConsequence.rb'

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
            @level -= decrement
            if (@level < 1) 
                @level = 1
            end 
        end

        def setPendingBadConsequence(badConsequence)
            @pendingBadConsequence = badConsequence
        end

        def die()
            @hiddenTreasures.each {|treasure| CardDealer.getInstance.giveTreasureBack(treasure)}
            @hiddenTreasures.clean()
            @visibleTreasure.each {|treasure| CardDealer.getInstance.giveTreasureBack(treasure)}
            @visibleTreasure.clean()
            @dead = true
        end

        # Esta virguería que he hecho funciona? (JC) 
        def discardNecklaceIfVisible
            @visibleTreasures.each do |treasure| 
                if (treasure.getType == NECKLACE) 
                    CardDealer.getInstance.giveTreasureBack(treasure) 								
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

            min(nPrize, 4 - @hiddenTreasures.size).times do
                @hiddenTreasures.add(CardDealer.getInstance.nextTreasure)
            end
        end

        def combat(monster)
            total_level = getCombatLevel()
        end

        def applyBadConsequence(bad)
            decrementLevels(bad.getLevels)
            setPendingBadConsequence(bad.adjustToFiTreasureLists(@visibleTreasures, @hiddenTreasures))
        end

        # Hace visible un tesoro si es posible. Devuelve si el tesoro se ha hecho visible. 
        def makeTreasureVisible(treasure)
            if canMakeTreasureVisible(treasure)
                @visibleTreasures.push(treasure)
                @hiddenTreasures.remove(treasure)
                return true
            end
            return false
        end
        
        # Comprueba si un tesoro puede hacerse visible.
        # 1- Si es el collar, puede hacerse visible.
        # 2- Si no es de una mano, comprueba si ya hay uno visible.
        # 3- Si es de una mano, puede hacerse visible si hay menos de dos visibles. 
        def canMakeTreasureVisible(treasure)
            type = treasure.getType;

            if type == TreasureKind.NECKLACE
                return true

            elsif type != TreasureKind.ONEHAND
                @visibleTreasures.each do |treasure|
                    if treasure.getType == type
                        return false
                    end
                end
                return true

            else 
                number_of_onehands = 0
                @visibleTreasures.each do |treasure|
                    if treasure.getType == TreasureKind.ONEHAND
                        number_of_onehands += 1
                    end
                end
                return number_of_onehands < 2
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
            CardDealer.getInstance.giveTreasureBack(treasure)
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
            CardDealer.getInstance.giveTreasureBack(treasure)
            dieIfNoTreasures
        end


        # Comprueba si puede comprar niveles. Si es así, lo hace y elimina los tesoros. 
        # Devuelve si se han comprado niveles o no. 
        def buyLevels(visible, hidden)
            levels = computeGoldCoinsValue(visible + hidden)
            if canIBuyLevels(levels) 
                incrementLevels(levels)
                visible.each {|t| discardVisibleTreasure(t)}
                hidden.each {|t| discardHiddenTreasure(t)}
                return true
            end
            return false
        end


		# Funciona la forma de obtener si está el tesoro de tipo NECKLACE? 
        def getCombatLevel
            combat_level = @level
            necklace = false
            @visibleTreasures.each do |treasure|

				@visibleTreasures.each do |treasure| 
				    if (treasure.getType == TreasureKind.NECKLACE) 
			            necklace = true
                    end
                end

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
            number = Dice.getInstance.nextNumber
            if (number == 1)
                @hiddenTreasures.add(CardDealer.getInstance.nextTreasure)
            elsif (nuber == 6)
                3.times do
                    @hiddenTreasures.add(CardDealer.getInstance.nextTreasure)
                end 
            else 
                2.times do
                    @hiddenTreasures.add(CardDealer.getInstance.nextTreasure)  
                end
            end
        end

        def isDead
            @dead
        end 

        def hasVisibleTreasures
            @visibleTreasures.empty?
        end

        def getVisibleTreasures
            @visibleTreasures
        end

        def getHiddenTreasures
            @hiddenTreasures
        end

    end

end
