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

        def yesNoQuestion(message)
            puts "#{message} (y/n)"
            c = gets.chomp

            while c != 'y' and c != 'n'
                c = gets.chomp
            end

            return c == 'y'
        end

        def main
            # Presentación del juego
            printHeader

            # Lee los jugadores
            players = readPlayers
            NP.initGame players

            # Bucle principal del juego
            turn = 0
            begin
                # Anuncia el nuevo turno
                puts "\n TURNO: #{turn} \n"

                # Escribe status de jugador y monstruo actual
                printCurrentPlayerStatus
                printCurrentMonsterStatus

                # Compra de niveles
                puts "Compra de niveles:"
                yesNoQuestion("¿Comprar niveles?")

                # Combate
                result = NP.combat

                # Pasa al siguiente turno
                NP.nextTurn
                
                turn = turn+1
            end while not NP.endOfGame(result)
        end

    end

    if __FILE__ == $0
        TextUI.instance.main
    end

end


