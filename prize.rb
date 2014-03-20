#!/usr/bin/env ruby
#encoding: utf-8

module Game

  # Premio al conseguir una victoria.
  class Prize
    
    # Inicialización
    def initialize (treasures, levels)
      @treasures = treasures
      @levels = levels
    end
    
    # Getters
    attr_reader :treasures
    attr_reader :levels

    def to_s()
      "#{@treasures} treasures and #{@levels} levels."
    end

  end
end
