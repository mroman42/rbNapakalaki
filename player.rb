#!/usr/bin/env ruby
#encoding: utf-8
require_relative 'dice.rb'
require_relative 'combatResult.rb'
require_relative 'treasure.rb'

module Game
  
  class Player
    
    def initialize(name)
      @name = name
      @level = 1
      @dead = false
      @pendingBadConsequence = nil
      @hiddenTreasures = []
      @visibleTreasures = []
    end

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
      ## Setter?? 
    end

    def die()
      dead = true
      hiddentreasures.clean()
      visibletreasure.clean()
    end

    def computeGoldCoinsValue(treasure)
      return 0
    end

    def canIBuyLevels(levels)
    end



    public

    attr_reader :level
    attr_reader :visibleTreasures
    attr_reader :hiddenTreasures
    
    def applyPrize(prize)
    end

    def combat(monster)
    end

    def applyBadConsequence(badConsequence)
    end

    def makeTreasureVisible(treasure)
    end
    
    def buyLevels(visible, hidden)
    end

    def getCombatLevel()
    end

    def validState()
    end

    def initTreasures()
    end

    def isDead()
      dead
    end 

    def hasVisibleTreasures()      
    end

    

  end

end
