#!/usr/bin/env ruby
#encoding: utf-8

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
    
    def applyPrize()
      
    end

    def combat(monster)
    end

    def applyBadConsequence(badConsequence)
    end

    def makeTreasureVisible()
    end
    
    def buyLevels(visible, hidden)
    end

    def validState()
    end

    def initTreasures()
    end

    def hasVisibleTreasures()
      
    end



  end

end
