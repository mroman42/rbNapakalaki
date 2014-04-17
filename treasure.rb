#!/usr/bin/env ruby
#encoding: utf-8
require_relative 'treasureKind.rb'

module Game
  class Treasure
    # Inicialización
    def initialize (name, goldCoins, minBonus, maxBonus, type)
        @name = name
        @goldCoins = goldCoins
        @minBonus = minBonus
        @maxBonus = maxBonus
        @type = type
    end

    # Métodos públicos
    def getName
        @name
    end

    def getGoldCoins
        @goldCoins
    end

    def getMinBonus
        @minBonus
    end

    def getMaxBonus
        @maxBonus
    end

    def getType
        @type
    end

    def to_s()
        "#{@name} (Coins. #{@goldCoins}) \nMin Bonus: #{@minBonus}\n Max Bonus: #{@maxBonus}\n"
    end

  end
end
