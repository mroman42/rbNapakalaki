#!/usr/bin/env ruby
#encoding: utf-8
require_relative 'treasureKind'

module Game

  # Perjuicio al producirse la derrota.
  class BadConsequence
    
    # Inicializador
    def initialize (text, levels, nVisible, nHidden, visible, hidden, death)
      @text = text
      @levels = levels
      @nVisibleTreasures = nVisible
      @nHiddenTreasures = nHidden
      @specificVisibleTreasures = visible
      @specificHiddenTreasures = hidden
      @death = death
    end



    # Constructores
    def self.new_det_tr(text, levels, visible, hidden)
      newObj=allocate
      newObj.send(:initialize, text, levels, visible.size, hidden.size, visible, hidden, false)
      newObj
    end

    def self.new_indet_tr(text, levels, nVisible, nHidden)
      newObj=allocate
      newObj.send(:initialize, text, levels, nVisible, nHidden, [], [], false)
      newObj
    end

    def self.new_death(text)
      newObj=allocate
      newObj.send(:initialize, text, 0, 0, 0, [], [], true)
      newObj
    end



    # Métodos públicos
    def isEmpty() 
      true
    end 

    def kills
      @death
    end

    def getLevels
      @levels
    end

    def getNVisibleTreasures
      @nVisibleTreasures
    end

    def getNHiddenTreasures
      @nHiddenTreasures
    end

    def getSpecificVisibleTreasures
      @specificVisibleTreasures
    end

    def getSpecificHiddenTreasures
      @specificHiddenTreasures
    end

    def substractVisibleTreasure(treasure)
    end

    def substractHiddenTreasure(treasure)
    end

    def adjustToFitTreasureLists(visible, hidden)      
    end 


    # Métodos auxiliares
    def to_s()
      "#{@text} \n\t" + (death ? "DEATH." : 
                         "#{@levels} levels, #{@nHidden} hidden treasures, #{@nVisible} visible treasures." 
                         ) + "\n"
    end

  end



  # Deshabilitando el constructor por defecto
  BadConsequence.instance_eval { undef :new }

end



