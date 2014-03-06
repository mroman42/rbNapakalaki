#!/usr/bin/env ruby
#encoding: utf-8
require_relative 'BadConsequence.rb'
require_relative 'Prize.rb'
module 'Napakalaki'
  class Monster
    def initialize(name, level, bad, prize)
      @name = name 
      @level = level
      @bad = bad
      @prize = prize
    end

    attr_reader :name
		attr_reader :level
		attr_reader :bad
		attr_reader :prize

    def to_s()
      puts "El monstruo #{@name} de nivel #{@level} te da #{victory.to_s()} si le ganas y si pierdes:\n#{defeat.to_s()}\n"
    end
  
	end
end

