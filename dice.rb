#!/usr/bin/env ruby
#encoding: utf-8
require "singleton"

module Game
  class Dice
    include Singleton
    
    def nextNumber()
      1 + rand(6)
    end
  end
end

