#!/usr/bin/env ruby
#encoding: utf-8

module Game

  # Premio al conseguir una victoria.
  class Prize
    
    # Inicializador
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
      	"#{@treasures} tesoros y #{@levels} niveles."
    end

  end
end
