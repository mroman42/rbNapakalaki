#!/usr/bin/env ruby
#encoding: utf-8
require_relative 'monster.rb'

module Game

  class Napakalaki
    include Singleton

    def initialize()
      @player = nil
      @currentPlayer = nil
      @currentMonster = nil
    end

    attr_reader :currentPlayer
    attr_reader :currentMonster

    def initPlayers(names)
    end

    def nextPlayer()
    end

    def combat()
    end

    def discardVisibleTreasure(treasure)
    end

    def discardHiddenTreasure(treasure)
    end
    
    def makeTreasureVisible(treasure) 
    end

    def buyLevels(visible, hidden)
    end

    def initGame(players)
    end

    def getCurrentPlayer()
    end

    def getCurrentMonster()
    end
    
    def canMakeTreasureVisible(treasure)
    end

    def getVisibleTreasures()
    end

    def getHiddenTreasures()
    end

    def nextTurn()
    end

    def nextTurnAllowed()
    end

    def endOfGame(result)
    end

  end

end
