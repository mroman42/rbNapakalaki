#!/usr/bin/env ruby
#encoding: utf-8
require_relative 'BadConsequence.rb'
require_relative 'Prize.rb'

module 'Napakalaki'
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
      puts "#{@name} (lv. #{@level}) \nPrize: #{prize.to_s()} \n Bad: \n#{bad.to_s()}\n"
    end
  
	end
end

