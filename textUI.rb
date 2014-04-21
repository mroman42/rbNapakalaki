#!/usr/bin/env ruby
#encoding: utf-8
require_relative 'napakalaki.rb'

# ¿Hay que usar un require_relative aquí arriba? No son del mismo paquete. 

module UserInterface

    class TextUI
        include Singleton
        NP = Game::Napakalaki.instance

        def printHeader
            puts "-"*30
            puts "\tNapakalaki"
            puts "-"*30
        end

        def readPlayers
            puts "Introduzca el nombre de los jugadores:"
            line = gets.chomp
            players = line.split()
            return players
        end

        def printCurrentPlayerStatus
            puts "Jugador actual: #{NP.getCurrentPlayer}"
        end

        def main
            # Presentación del juego
            printHeader

            # Lee los jugadores
            players = readPlayers
            NP.initGame players

            # Escribe status del jugador actual
            printCurrentPlayerStatus
        end

    end

    if __FILE__ == $0
        TextUI.instance.main
    end

end


