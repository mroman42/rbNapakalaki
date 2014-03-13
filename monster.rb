#!/usr/bin/env ruby
#encoding: utf-8
require_relative 'badConsequence.rb'
require_relative 'prize.rb'

module Napakalaki
  
  # Monstruo del juego.
  class Monster
    # Inicialización
    def initialize(name, level, bad, prize)
      @name = name 
      @level = level
      @bad = bad
      @prize = prize
    end

    # Getters
    attr_reader :name
    attr_reader :level
    attr_reader :bad
    attr_reader :prize

    def to_s()
      "#{@name} (lv. #{@level}) \nPrize: #{prize.to_s()}\n Bad: #{bad.to_s()}\n"
    end
  end

end

