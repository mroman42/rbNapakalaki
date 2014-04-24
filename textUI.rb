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

        def printCurrentMonsterStatus
            puts "Monstruo actual: #{NP.getCurrentMonster}"
        end

        def main
            # Presentación del juego
            printHeader

            # Lee los jugadores
            players = readPlayers
            NP.initGame players

            # Bucle principal del juego
            begin
                # Escribe status del jugador actual
                printCurrentPlayerStatus
                printCurrentMonsterStatus
                NP.nextTurn
                result = NP.combat
            end while not NP.endOfGame(result)
        end

    end

    if __FILE__ == $0
        TextUI.instance.main
    end

end


