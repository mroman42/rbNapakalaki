#!/usr/bin/env ruby
#encoding: utf-8

require_relative 'treasureKind'


module Napakalaki

  # Perjuicio al producirse la derrota.
  class BadConsequence
    
    # Inicializador
    def initialize (text, levels, nVisible, nHidden, death)
      @text = text
      @levels = levels
      @nVisible = nVisible
      @nHidden = nHidden
      @death = death
    end

    # Getters
    attr_reader :text
    attr_reader :levels
    attr_reader :nVisible
    attr_reader :nHidden
    attr_reader :death
    
  end

end
