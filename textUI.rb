#!/usr/bin/env ruby
#encoding: utf-8
require_relative 'napakalaki.rb'

module UserInterface

    class TextUI
        include Singleton

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
    end

    if __FILE__ == $0
        ui = TextUI.instance
        np = Game::Napakalaki.instance

        # Presentación del juego.
        ui.printHeader

        # Lee los jugadores.
        players = ui.readPlayers
        np.initGame(players)
    end

end


