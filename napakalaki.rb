#!/usr/bin/env ruby
#encoding: utf-8
require_relative 'monster.rb'
require_relative 'player.rb'
require_relative 'combatResult.rb'
require 'singleton'

module Game

  class Napakalaki
    include Singleton

    # Inicializador
    def initialize
      @players = nil
      @currentPlayer = nil
      @currentMonster = nil
    end


    # Métodos privados
    private

    def initPlayers(names)
      @players = names
    end

    def nextPlayer
    end


    # Métodos públicos
    public

    def combat
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

    def getCurrentPlayer
      @currentPlayer
    end

    def getCurrentMonster
      @currentMonster
    end
    
    def canMakeTreasureVisible(treasure)
    end

    def getVisibleTreasures
      @visibleTreasures
    end

    def getHiddenTreasures
      @hiddenTreasures
    end

    def nextTurn
    end

    def nextTurnAllowed
    end

    def endOfGame(result)
    end

  end

end
