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

    # Getters
    attr_reader :name
    attr_reader :goldCoins
    attr_reader :minBonus
    attr_reader :maxBonus
    attr_reader :type

  end
end
