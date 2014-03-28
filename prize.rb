#!/usr/bin/env ruby
#encoding: utf-8

module Game

  # Premio al conseguir una victoria.
  class Prize
    
    # Constructor
    def initialize (treasures, levels)
      @treasures = treasures
      @levels = levels
    end
    
    # Métodos públicos
    def getTreasures
      @treasures
    end
    
    def getLevels
      @levels
    end

    # Métodos auxiliares
    def to_s()
      "#{@treasures} treasures and #{@levels} levels."
    end

  end
end
