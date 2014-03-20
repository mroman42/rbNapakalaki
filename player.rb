#!/usr/bin/env ruby
#encoding: utf-8

module Game
  
  class Player
    
    def initialize (name, level, dead)
      @name = name
      @level = level
      @dead = dead
    end

    def bringToLife()
      dead = false
    end

    def incrementLevels(l)
      level += l
    end

  end

end
