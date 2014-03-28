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
    end

    def dieIfNoTreasures
    end

    def computeGoldCoinsValue(treasure)
      return 0
    end

    def canIBuyLevels(levels)
    end



    # Métodos públicos
    public
    
    def applyPrize(prize)
    end

    def combat(monster)
    end

    def applyBadConsequence(badConsequence)
    end

    def makeTreasureVisible(treasure)
    end
    
    def canMakeTreasureVisible(treasure)
    end

    def discardVisibleTreasure(treasure)
    end

    def discardHiddenTreasure(treasure)
    end

    def buyLevels(visible, hidden)
    end

    def getCombatLevel
    end

    def validState
    end

    def initTreasures
    end

    def isDead
      @dead
    end 

    def hasVisibleTreasures
    end

    def getVisibleTreasures
    end

    def getHiddenTreasures
    end

  end

end
