#!/usr/bin/env ruby
#encoding: utf-8
require_relative 'treasureKind.rb'

module Game
    class Treasure
        # Inicialización
        def initialize (name, goldCoins, minBonus, maxBonus, type)
            @name = name
            @goldCoins = goldCoins
            @minBonus = minBonus
            @maxBonus = maxBonus
            @type = type
        end

        # Métodos públicos
        def getName
            @name
        end

        def getGoldCoins
            @goldCoins
        end

        def getMinBonus
            @minBonus
        end

        def getMaxBonus
            @maxBonus
        end

        def getBasicValue
            getMinBonus
        end

        def getSpecialValue
            getMaxBonus
        end

        def getType
            @type
        end

        # Métodos auxiliares
        def to_s()
            case @type
            when ARMOR
                tipo = "Armadura"
            when BOTHHANDS
                tipo = "Arma de dos manos"
            when ONEHAND
                tipo = "Arma de una mano"
            when SHOE
                tipo = "Calzado"
            when HELMET
                tipo = "Casco"
            when NECKLACE
                tipo = "Collar"
            end
            
            "#{@name} (#{tipo}) [+#{@minBonus}, ++#{@maxBonus}] (#{@goldCoins}$)"
        end

    end
end
