#!/usr/bin/env ruby
#encoding: utf-8
require_relative 'cultistPlayer.rb'

module Game

  class Cultist

    # Inicializador
    def initialize(name, gainedLevels)
      @name = name
      @gainedLevels = gainedLevels
    end

    def getBasicValue
      @gainedLevels
    end

    def getSpecialValue
      (@gainedLevels * CultistPlayer.getTotalCultistPlayers)
    end
  end

end
