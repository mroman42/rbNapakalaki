#!/usr/bin/env ruby
#encoding: utf-8
require_relative 'badConsequence.rb'
require_relative 'prize.rb'

module Game
  
  class Monster

    # Inicializador
    def initialize(name, level, bad, prize)
      	@name = name 
      	@level = level
      	@bad = bad
      	@prize = prize
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
    
    # Métodos auxiliares
    def to_s
      	"#{@name} (lv. #{@level}) \n\tBuen rollo: #{@prize.to_s()}\n\tMal rollo: #{@bad.to_s()}\n"
    end
  end

end

