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

        def makeTreasureVisible(treasure)
        end
        
        def canMakeTreasureVisible(treasure)
        end
        
        # !!!!!!!!!
        def discardVisibleTreasure(treasure)
            @visibleTreasures - treasure.getType
        end
        # !!!!!!!!!
        def discardHiddenTreasure(treasure)
            @hiddenTreasures - treasure.getType
        end

        def buyLevels(visible, hidden)
        end


		# Funciona la forma de obtener si está el tesoro de tipo NECKLACE? 
        def getCombatLevel
            combat_level = @level
            necklace = false
            @visibleTreasures.each do |treasure|

				@visibleTreasures.each do |treasure| 
				    if (treasure.getType == NECKLACE) 
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
