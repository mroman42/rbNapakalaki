#!/usr/bin/env ruby
#encoding: utf-8
require_relative 'BadConsequence.rb'
require_relative 'Prize.rb'
module 'Napakalaki'
  class Monster
    def initialize(nombre, nivel, buenrollo, malrollo)
      @name = nombre
      @level = nivel
      @victory = buenrollo
      @defeat = malrollo
    end

    attr_reader :name, :level, :victory, :defeat

    def to_s()
      puts "El monstruo #{@name} de nivel #{@level} te da #{victory.to_s()} si le ganas y si pierdes:\n#{defeat.to_s()}\n"
    end
  end
end

