#!/usr/bin/env ruby
#encoding: utf-8
require 'io/console'
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
            puts "Turno: #{@turn}\n"
            printCurrentPlayerStatus
            printCurrentMonsterStatus
        end

        def printHeader
            puts "-"*30
            puts "\tNapakalaki"
            puts "-"*30
        end

        def readPlayers
            puts "Introduzca el nombre de los jugadores:"
            line = gets.chomp
            players = line.split
            return players
        end

        def printCurrentPlayerStatus
            puts "\nJugador actual: #{NP.getCurrentPlayer}\n"
            printVisibleTreasures
            printHiddenTreasures
            printCurrentPlayerCombatStatus
        end

        def printCurrentPlayerCombatStatus
            puts "Nivel de combate: #{NP.getCurrentPlayer.getCombatLevel}\n"
        end

        def printCurrentMonsterStatus
            puts "\nMonstruo actual: #{NP.getCurrentMonster}\n"
        end

        def printCombatResult(result)
            puts "Combate contra #{NP.getCurrentMonster.getName}:"
            
            # Faltan otros casos del combate
            case result
            when Game::WIN
                puts "Has derrotado al monstruo."
            when Game::WINANDWINGAME
                puts "Has ganado el combate y el juego. ¡Enhorabuena!"
            when Game::LOSEANDESCAPE
                puts "Has logrado escapar del combate a salvo."
            when Game::LOSE
                puts "Has sido derrotado. Ahora se te aplicará el mal rollo del monstruo."
            when Game::LOSEANDDIE
                puts "Has sido derrotado y has muerto."
            else
                puts "Error en el combate."
            end
        end

        def menu(msg, *options)
            puts msg
            
            index = 1
            for o in options
                puts "[#{index}]: #{o}"
                index = index + 1
            end
        end

        def selectionMenu
            menu("Elegir acción:\n",
                 "Comprar niveles",
                 "Combatir",
                 )

            # Controla opciones del menú
            case respuesta = STDIN.getch
            when "1"
                clearScreen
                buyLevels
                selectionMenu
            when "2"
                clearScreen
            else
                clearScreen
                selectionMenu
            end
        end

        def selectionMenu2
            menu("Elegir acción:\n", 
                 "Equipar tesoros", 
                 "Pasar de turno",
                 )
            respuesta = 0

            # Controla opciones
            case respuesta = STDIN.getch
            when "1"
                clearScreen 
                equip
                selectionMenu2
            when "2"
                clearScreen
            else 
                clearScreen
                selectionMenu2
            end
        end
        
        def yesNoQuestion(message)
            puts "#{message} (y/n)"

            begin 
                c = STDIN.getch
            end while c != 'y' and c != 'n'

            return c == 'y'
        end

        def buyLevels
            #Compra de niveles. 
            # La idea que he tenido es: que te digan una serie de número de 0 a 9, de 0 a 5 serían los visibles (nil's incluidos) 
            # y del 6 al 9 ocultos. 
            # He copiado esto de arriba.
            puts "Dime los índices de los tesoros que quieres vender -- (0-5) visibles, (6-9) ocultos."
            line = gets.chomp 
            respuesta = line.split
            # NO FUNCIONA. Visibles y ocultos tienen que ser tesoros, no índices. 
            visibles, ocultos = respuesta.select{|item| item < 6}, respuesta.select{|item| item >= 6 && item < 10}.collect{|item| item % 6}

            if(!NP.buyLevels(visibles, ocultos))
                if (yesNoQuestion("No puedes venderlos, ¿quieres tiralos?")) # Es realmente necesario?
                    NP.discardVisibleTreasures(visibles)
                    NP.discardVisibleTreasures(ocultos)
                end
            else 
                puts "Compra realizada. Ahora tu nivel de combate es #{NP.getCurrentPlayer.getCombatLevel}\n"
            end 
        end
        
        def printTreasures(treasures)
            treasures.each_with_index do |treasure, index|
                puts "\t(#{index}): #{treasure}"
            end
        end

        def printVisibleTreasures
            puts "Tesoros visibles:\n"
            printTreasures(NP.getVisibleTreasures)
        end

        def printHiddenTreasures
            puts "Tesoros ocultos:\n"
            printTreasures(NP.getHiddenTreasures)
        end

        def equip
            begin
                # Escribe información relevante a la equipación de objetos
                puts "Equipación de objetos.\n"
                printVisibleTreasures
                printHiddenTreasures
                puts "\t(x): Salir"
                puts "Dime que tesoro oculto te quieres equipar:"
                
                # Pasamos el índice del tesoro que queremos equipar. 
                index = STDIN.getch
                if (index != 'x')
                    index = index.to_i
                    
                    clearScreen
                    if(NP.canMakeTreasureVisible(NP.getHiddenTreasures.at(index)))
                        puts "Tesoro #{NP.getHiddenTreasures.at(index).getName} equipado\n"
                        NP.makeTreasureVisible(NP.getHiddenTreasures.at(index))
                    else
                      	puts "No puedes equiparte #{NP.getHiddenTreasures.at(index)}\n"
                    end
                end 
            end while (index != 'x')
            clearScreen
        end

        # Método para ajustar el mal rollo. 
        def adjust
            while !NP.nextTurnAllowed
                discardVisibleTreasures
            end
        end

        def discardVisibleTreasures
            puts "Descarta tesoros visibles:\n"
            printVisibleTreasures
            
        end

        def discardHiddenTreasures
            
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
                
                # El jugador elige acción
                selectionMenu

                # Combate
                result = NP.combat
                printCombatResult result

                # Aplica mal rollo si pierde.   
                adjust if (result == Game::LOSE)
                selectionMenu2                

                # Pasa al siguiente turno
                while not yesNoQuestion("¿Pasar al siguiente turno?")
                end
                NP.nextTurn
                @turn = @turn+1
            end while not NP.endOfGame(result)
        end
    end

    if __FILE__ == $0
        TextUI.instance.main
    end

end


