#!/usr/bin/env ruby
#encoding: utf-8
require_relative 'badConsequence.rb'
require_relative 'prize.rb'

module Game

  class Monster

    # Inicializador
    def initialize(name, level, bad, prize, levelChangeAgainstCultistPlayer=0)
      	@name = name
      	@level = level
      	@bad = bad
      	@prize = prize
        @levelChangeAgainstCultistPlayer = levelChangeAgainstCultistPlayer
    end

    # Métodos públicos
    def getName
      	@name
    end

    def getLevel
      	@level
    end

    def getPrize
      	@prize
    end

    def getBadConsequence
      	@bad
    end

    def getBasicValue
        getLevel
    end

    def getSpecialValue
        (@level + @levelChangeAgainstCultistPlayer)
    end

    # Métodos auxiliares
    def to_s
        levelVsCultist = ""

        if(@levelChangeAgainstCultistPlayer < 0)
            levelVsCultist = "(#{@levelChangeAgainstCultistPlayer})"
        elsif(@levelChangeAgainstCultistPlayer > 0)
            levelVsCultist = "(+#{@levelChangeAgainstCultistPlayer})"
        end

      	"#{@name} (lv. #{@level}#{levelVsCultist}) \n\tBuen rollo: #{@prize.to_s()}\n\tMal rollo: #{@bad.to_s()}\n"
    end
  end

end
