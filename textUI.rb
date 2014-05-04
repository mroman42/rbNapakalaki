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

        def selectionMenu
            puts "Elegir acción:\n"
            puts "[1]: Comprar niveles"
            puts "[2]: Combatir"
            puts "[3]: Huir"

            case gets.strip
            when "1"
                puts "Compra de niveles:"
                if (yesNoQuestion("¿Comprar niveles?"))
                    NP.buyLevels(NP.getVisibleTreasures, NP.getHiddenTreasures)
                end
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
