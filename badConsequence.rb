#!/usr/bin/env ruby
#encoding: utf-8
require_relative 'treasureKind'

module Napakalaki

  # Perjuicio al producirse la derrota.
  class BadConsequence
    
    # Inicializador
    def initialize (text, levels, nVisible, nHidden, visible, hidden, death)
      @text = text
      @levels = levels
      @nVisible = nVisible
      @nHidden = nHidden
      @visible = visible
      @hidden = hidden
      @death = death
    end

    # Getters
    attr_reader :text
    attr_reader :levels
    attr_reader :nVisible
    attr_reader :nHidden
    attr_reader :visible
    attr_reader :hidden
    attr_reader :death

    def to_s()
      "#{@text} \n\t" + (death ? "DEATH." : 
                        "#{@levels} levels, #{@nHidden} hidden treasures, #{@nVisible} visible treasures." 
                        ) + "\n"
    end
    
    #Nuevos constructores
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

  end


  #Deshabilitando el new por defecto
  BadConsequence.instance_eval { undef :new }

end



