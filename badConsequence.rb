#!/usr/bin/env ruby
#encoding: utf-8
require_relative 'treasureKind.rb'

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
        def isEmpty
            @death == false && @levels == 0 && @nVisibleTreasures == 0 && @nHiddenTreasures == 0
        end 

        def kills
            @death
        end

        def getText
            @text
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

	# En los siguientes dos métodos, hay que usar que hay dos posibles BadConsequence que trabajan con tesoros, los que conocen los objetos que quitan y los que sólo conocen la cantidad.
    # Para saber si un tesoro está contenido, tenemos que ver si está en la lista de tesoros(conoce los tesoros) o está vacía pero la cantidad de tesoros que quita no es nula(no conoce los tesoros)

        def substractVisibleTreasure(treasure)
            if(@specificVisibleTreasures.include? treasure || (@specificVisibleTreasures.empty? && @nVisibleTreasures != 0))
                @specificVisibleTreasures - treasure
                @nVisibleTreasures -= 1
            end
        end

	    def substractHiddenTreasure(treasure)
            if(@specificHiddenTreasures.include? treasure || (@specificHiddenTreasures.empty? && @nHiddenTreasures != 0))
                @specificHiddenTreasures - treasure
                @nHiddenTreasures -= 1 
            end
        end

    # En este método, se usan los tres BadConsequence posibles: 
        def adjustToFitTreasureLists(visible, hidden)        
    #    ·si es mortal, es mortal.
            if @death
                return BadConsequence.new_death(@text, @death)

    #    ·si no conoce los tesoros(o no hay), trabaja con las cantidades(no puedes quitar más tesoros de los que tiene).
            elsif (@specificVisibleTreasures.empty? && @specificHiddenTreasures.empty?)
                nVTreasures = [visible.size, @nVisibleTreasures].min
                nHTreasures = [hidden.size, @nHiddenTreasures].min

                return BadConsequence.new_indet_tr(@text, @levels, nVTreasures, nHTreasures)

    #    ·si conoce los tesoros, trabaja con los tesoros(no puedes quitar los tesoros que no tiene)
            else
                listVisibleTreasures = visible & @specificVisibleTreasures
                listHiddenTreasures = hidden & @specificHiddenTreasures

                return BadConsequence.new_det_tr(@text, @levels, listVisibleTreasures, listHiddenTreasures);
            end
        end 


        # Métodos auxiliares
        def to_s
            "#{@text} \n\t" + (@death ? "DEATH." : 
                               "#{@levels} levels, #{@nHidden} hidden treasures, #{@nVisible} visible treasures." 
                               ) + "\n"
        end

    end


    # Deshabilitando el constructor por defecto
    BadConsequence.instance_eval { undef :new }

end


