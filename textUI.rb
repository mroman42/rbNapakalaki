#!/usr/bin/env ruby
#encoding: utf-8
require 'curses'
require_relative 'napakalaki.rb'


module UserInterface

    class TextUI
        include Singleton
        NP = Game::Napakalaki.instance

        def initialize
            @turn = 0
        end

        def clearScreen
            system "clear"
            printHeader
            puts "\nTurno: #{@turn}\n"
        end

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
            puts "\nJugador actual:\n#{NP.getCurrentPlayer}\n"
        end

        def printCurrentMonsterStatus
            puts "\nMonstruo actual:\n#{NP.getCurrentMonster}\n"
        end

        def menu(msg, *options)
            puts msg
            
            index = 0
            for o in options
                index = index + 1
                puts "[#{index}]: #{o}"
            end
        end

        def selectionMenu
            menu("Elegir acción:\n",
                 "Comprar niveles",
                 "Combatir",
                 "Huir")
            
            case gets.strip
            when "1"
                buyLevels
            end
        end
        
        def yesNoQuestion(message)
            puts "#{message} (y/n)"
            c = gets.chomp

            while c != 'y' and c != 'n'
                c = gets.chomp
            end

            return c == 'y'
        end

        def buyLevels
            # Escribir
            # Imprime información relevante a la compra de niveles            

            if (yesNoQuestion("¿Comprar niveles?"))
                NP.buyLevels(NP.getVisibleTreasures, NP.getHiddenTreasures)
            end
        end

        def main
            # Presentación del juego
            system "clear"
            printHeader

            # Lee los jugadores
            players = readPlayers
            NP.initGame players

            # Bucle principal del juego
            begin
                # Anuncia el nuevo turno
                clearScreen
                
                # Escribe status de jugador y monstruo actual
                printCurrentPlayerStatus
                printCurrentMonsterStatus
                
                # Compra de niveles
                selectionMenu

                # Combate
                result = NP.combat
                
                # Pasa al siguiente turno
                NP.nextTurn
                @turn = @turn+1
            end while not NP.endOfGame(result)
        end

    end

    if __FILE__ == $0
        TextUI.instance.main
    end

end
