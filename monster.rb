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

    def getBadConsequence
      	@bad
    end
    
    def getPrize
      	@prize
    end

    # Métodos auxiliares
    def to_s()
      	"#{@name} (lv. #{@level}) \nPrize: #{@prize.to_s()}\n Bad: #{@bad.to_s()}\n"
    end
  end

end

