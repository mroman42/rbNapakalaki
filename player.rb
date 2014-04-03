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
      @pendingBadConsequence = nil
      @hiddenTreasures = []
      @visibleTreasures = []

      bringToLife
    end



    # Métodos privados
    private

    def bringToLife()
      dead = false
      level = 1
    end

    def incrementLevels(increment)
      level += increment
    end

    def decrementLevels(decrement)
      level -= decrement
    end

    def setPendingBadConsequence(badConsequence)
      @pendingBadConsequence = badConsequence
    end

    def die()
      dead = true
      hiddentreasures.clean()
      visibletreasure.clean()
    end

    def discardNecklaceIfVisible
      visibleTreasures-[NECKLACE]
    end

    def dieIfNoTreasures
      die if (visibleTreasures + hiddenTreasures).empty?
    end

    def computeGoldCoinsValue(treasure)
      treasure.getGoldCoins()
    end

    def canIBuyLevels(levels)
    end



    # Métodos públicos
    public
    
    def applyPrize(prize)
      incrementLevels(prize.getLevels())
    end

    def combat(monster)
      total_level = getCombatLevel()
    end

    def applyBadConsequence(badConsequence)
    end

    def makeTreasureVisible(treasure)
    end
    
    def canMakeTreasureVisible(treasure)
    end

    def discardVisibleTreasure(treasure)
      visibleTreasures - treasure.getType()
    end

    def discardHiddenTreasure(treasure)
      hiddenTreasures - treasure.getType()
    end

    def buyLevels(visible, hidden)
    end

    def getCombatLevel
      combat_level = level;

      visibleTreasures.each {|treasure|
        if(visibleTreasures.include?(NECKLACE))
          combat_level += treasure.getMaxBonus();
        else
          combat_level += treasure.getMinBonus();
        end
      }

      combat_level
    end

    def validState
    end

    def initTreasures
    end

    def isDead
      @dead
    end 

    def hasVisibleTreasures
      visibleTreasures.empty?
    end

    def getVisibleTreasures
      @visibleTreasures
    end

    def getHiddenTreasures
      @hiddenTreasures
    end

  end

end
