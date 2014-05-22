#!/usr/bin/env ruby
#encoding: utf-8
require_relative 'monster.rb'
require_relative 'treasure.rb'
require "singleton"

module Game

    class CardDealer
        include Singleton

        # Constructor
        def initialize
            @unusedMonsters = []
            @usedMonsters = []
            @unusedTreasures = []
            @usedTreasures = []
            @unusedCultists = []
        end


        # Métodos privados
        private

        def initTreasureCardDeck
            #Tesoros añadidos por orden de aparición en el guión.
            # ¡Sí, mi amo!
            @unusedTreasures.push(Treasure.new("¡Sí, mi amo!", 0, 4, 7, HELMET)) 

            # Botas de investigación
            @unusedTreasures.push(Treasure.new("Botas de investigación", 600, 3, 4, SHOE))

            # Capucha de Cthulhu
            @unusedTreasures.push(Treasure.new("Capucha de Cthulhu", 500, 3, 5, HELMET))

            # A prueba de babas verdes
            @unusedTreasures.push(Treasure.new("A prueba de babas verdes", 400, 3, 5, ARMOR))

            # Botas de lluvia ácida
            @unusedTreasures.push(Treasure.new("Botas de lluvia ácida", 800, 1, 1, BOTHHANDS))

            # Casco minero
            @unusedTreasures.push(Treasure.new("Casco minero", 400, 2, 4, HELMET))

            # Ametralladora Thompson
            @unusedTreasures.push(Treasure.new("Ametralladora Thompson", 600, 4, 8, BOTHHANDS))

            # Camiseta de la UGR
            @unusedTreasures.push(Treasure.new("Camiseta de la UGR", 100, 1, 7, ARMOR))

            # Clavo de rail ferroviario
            @unusedTreasures.push(Treasure.new("Clavo de rail ferroviario", 400, 3, 6, ONEHAND))

            # Cuchillo de sushi arcano
            @unusedTreasures.push(Treasure.new("Cuchillo de sushi arcano", 300, 2, 3, ONEHAND))

            # Fez Alópodo
            @unusedTreasures.push(Treasure.new("Fez Alópodo", 700, 3, 5, HELMET))

            # Hacha prehistórica
            @unusedTreasures.push(Treasure.new("Hacha prehistórica", 500, 2, 5, ONEHAND))

            # El aparato del Pr. Tesla
            @unusedTreasures.push(Treasure.new("El aparato del Pr. Tesla", 900, 4, 8, ARMOR))

            # Gaita
            @unusedTreasures.push(Treasure.new("Gaita", 200, 1, 5, BOTHHANDS))

            # Insecticida
            @unusedTreasures.push(Treasure.new("Insecticida", 300, 2, 3, ONEHAND))

            # Escopeta de 3 cañones
            @unusedTreasures.push(Treasure.new("Escopeta de 3 cañones", 700, 4, 6, BOTHHANDS))

            # Garabato místico
            @unusedTreasures.push(Treasure.new("Garabato místico", 300, 2, 2, ONEHAND))

            # La fuerza de Mr. T
            @unusedTreasures.push(Treasure.new("La fuerza de Mr. T", 1000, 0, 0, NECKLACE))

            # La rebeca metálica
            @unusedTreasures.push(Treasure.new("La rebeca metálica", 400, 2, 3, ARMOR))

            # Mazo de los antiguos
            @unusedTreasures.push(Treasure.new("Mazo de los antiguos", 200, 3, 4, ONEHAND))

            # Necro-playboycón
            @unusedTreasures.push(Treasure.new("Necro-playboycón", 300, 3, 5, ONEHAND))

            # Lanzallamas
            @unusedTreasures.push(Treasure.new("Lanzallamas", 800, 4, 8, BOTHHANDS))

            # Necro-comicón
            @unusedTreasures.push(Treasure.new("Necro-comicón", 100, 1, 1, ONEHAND))

            # Necronomicón
            @unusedTreasures.push(Treasure.new("Necronomicón", 800, 5, 7, BOTHHANDS))

            # Linterna a 2 manos
            @unusedTreasures.push(Treasure.new("Linterna a 2 manos", 400, 3, 6, BOTHHANDS))

            # Necro-gnomicón
            @unusedTreasures.push(Treasure.new("Necro-gnomicón", 200, 2, 4, ONEHAND))

            # Necrotelecom
            @unusedTreasures.push(Treasure.new("Necrotelecom", 300, 2, 3, HELMET))

            # Porra preternatural
            @unusedTreasures.push(Treasure.new("Porra preternatural", 200, 2, 3, ONEHAND))

            # Tentáculo de pega
            @unusedTreasures.push(Treasure.new("Tentáculo de pega", 200, 0, 1, HELMET))

            # Zapatillas deja-amigos
            @unusedTreasures.push(Treasure.new("Zapatillas deja-amigos", 500, 0, 1, SHOE))

            # Shogulador
            @unusedTreasures.push(Treasure.new("Shogulador", 600, 1, 1, BOTHHANDS))

            # Varita de atizamiento
            @unusedTreasures.push(Treasure.new("Varita de atizamiento", 400, 3, 4, ONEHAND))
        end

        def initMonsterCardDeck

            #Monstruos añadidos por orden de aparición en el guión. 
            # 3 Byakhees de bonanza.
            bad = BadConsequence.new_det_tr("Pierdes tu armadura visible y otra oculta.", 0, [ARMOR], [ARMOR])
            prize = Prize.new(2,1)
            @unusedMonsters.push(Monster.new("3 Byakhees de bonanza", 8, bad, prize))

            # Chibithulhu
            bad = BadConsequence.new_det_tr("Embobados con el lindo primigenio te descartas de tu casco visible.", 0, [HELMET], [])
            prize = Prize.new(1,1)
            @unusedMonsters.push(Monster.new("Chibithulhu", 2, bad, prize))

            # El sopor de Dunwich
            bad = BadConsequence.new_det_tr("El primordial bostezo contagioso. Pierdes el calzado visible.", 0, [SHOE], [])
            prize = Prize.new(1,1)
            @unusedMonsters.push(Monster.new("El sopor de Dunwich", 2, bad, prize))

            # Ángeles de la noche ibicenca
            bad = BadConsequence.new_det_tr("Te atrapan para llevarte de fiesta y te dejan caer en mitad del vuelo. Descarta 1 mano visible y 1 mano oculta.", 0, [ONEHAND], [ONEHAND])
            prize = Prize.new(4,1)
            @unusedMonsters.push(Monster.new("Ángeles de la noche ibicenca", 14, bad, prize))

            # El gorrón en el umbral
            bad = BadConsequence.new_indet_tr("Pierdes todos tus tesoros visibles.", 0, 99, 0)
            prize = Prize.new(3,1)
            @unusedMonsters.push(Monster.new("El gorrón en el umbral", 10, bad, prize))

            # H.P. Munchcraft
            bad = BadConsequence.new_det_tr("Pierdes la armadura visible.", 0, [ARMOR], [])
            prize = Prize.new(2,1)
            @unusedMonsters.push(Monster.new("H.P. Munchcraft", 6, bad, prize))

            # Bichgooth
            bad = BadConsequence.new_det_tr("Sientes bichos bajo la ropa. Descarta la armadura visible.", 0, [ARMOR], []) 
            prize = Prize.new(1,1)
            @unusedMonsters.push(Monster.new("Bichgooth", 2, bad, prize))

            # El rey de rosa
            bad = BadConsequence.new_indet_tr("Pierdes 5 niveles y 3 tesoros visibles.", 5, 3, 0)
            prize = Prize.new(4,2)
            @unusedMonsters.push(Monster.new("El rey de rosa", 13, bad, prize))

            # La que redacta en las sombras. 
            bad = BadConsequence.new_indet_tr("Toses los pulmones y pierdes 2 niveles.", 2, 0, 0)
            prize = Prize.new(1,1)
            @unusedMonsters.push(Monster.new("La que redacta en las sombras", 3, bad, prize))

            # Los hondos verdes
            bad = BadConsequence.new_death("Estos monstruos resultan bastante superficiales y te aburren mortalmente. Estás muerto.")
            prize = Prize.new(2,1)
            @unusedMonsters.push(Monster.new("Los hondos verdes", 7, bad, prize))

            # Semillas Cthulhu
            bad = BadConsequence.new_indet_tr("Pierdes 2 niveles y 2 tesoros ocultos.", 2, 0, 2)
            prize = Prize.new(2,1)
            @unusedMonsters.push(Monster.new("Semillas Cthulhu", 4, bad, prize))

            # Dameargo
            bad = BadConsequence.new_det_tr("Te intentas escapar. Pierdes una mano visible.", 0, [ONEHAND], [])
            prize = Prize.new(2,1)
            @unusedMonsters.push(Monster.new("Dameargo", 1, bad, prize))

            # Pollipólipo volante
            bad = BadConsequence.new_indet_tr("Da mucho asquito. Pierdes 3 niveles.", 3, 0, 0)
            prize = Prize.new(1,1)
            @unusedMonsters.push(Monster.new("Pollipólipo volante", 3, bad, prize))

            # Yskhtihyssg-Goth
            bad = BadConsequence.new_death("No le hace gracia que pronuncien mal su nombre. Estás muerto.")
            prize = Prize.new(3,1)
            @unusedMonsters.push(Monster.new("Yskhtihyssg-Goth", 12, bad, prize))

            # Familia feliz.
            bad = BadConsequence.new_death("La familia te atrapa. Estás muerto.")
            prize = Prize.new(4,1)
            @unusedMonsters.push(Monster.new("Familia feliz", 1, bad, prize))

            # Roboggoth
            bad = BadConsequence.new_det_tr("La quinta directiva primaria te obliga a perder 2 niveles y un tesoro 2 manos visible.", 2, [BOTHHANDS], [])
            prize = Prize.new(2,1)
            @unusedMonsters.push(Monster.new("Roboggoth", 8, bad, prize))

            # El espía ciego.
            bad = BadConsequence.new_det_tr("Te asusta en la noche. Pierdes un casco visible.", 0, [HELMET], [])
            prize = Prize.new(1,1)
            @unusedMonsters.push(Monster.new("El espía ciego", 4, bad, prize))

            # El Lenguas
            bad = BadConsequence.new_indet_tr("Menudo susto te llevas. Pierdes 2 niveles y 5 tesoros visibles.", 2, 5, 0)
            prize = Prize.new(1,1)
            @unusedMonsters.push(Monster.new("El Lenguas", 20, bad, prize))

            # Bicéfalo 
            bad = BadConsequence.new_det_tr("Te faltan manos para tanta cabeza. Pierdes 3 niveles y tus tesoros visibles de las manos.", 3, [ONEHAND, ONEHAND, BOTHHANDS], [])
            prize = Prize.new(1,1)
            @unusedMonsters.push(Monster.new("Bicéfalo", 20, bad, prize))

            # Monstruos con sectarios. 

            # El mal indecible impronunciable. 
            bad = BadConsequence.new_det_tr("Pierdes 1 mano visible.", 0, [ONEHAND], [])
            prize = Prize.new(3,1)
            @unusedMonsters.push(Monster.new("El mal indecible impronunciable", 10, bad, prize, -2)

            # Testigos oculares. 
            bad = BadConsequence.new_indet_tr("Pierdes tus tesoros visibles. Jajaja.", 0, 99, 0)
            prize = Prize.new(2,1)
            @unusedMonsters.push(Monster.new("Testigos oculares", 6, bad, prize, 2)

            # El gran Cthulhu
            bad = BadConsequence.new_death("Hoy no es tu día de suerte. Mueres.")
            prize = Prize.new(2,5)
            @unusedMonsters.push(Monster.new("El gran Cthulhu", 20, bad, prize, 4)

            # Serpiente Político
            bad = BadConsequence.new_det_tr("Tu gobierno te recorta 2 niveles.", 2, [], []) 
            prize = Prize.new(2,1)
            @unusedMonsters.push(Monster.new("Serpiente Político", 8, bad, prize, -2)
        
            # Felpuggoth
            bad = BadConsequence.new_det_tr("Pierdes tu casco y tu armadura visible. Pierdes tus manos ocultas.", 2, [HELMET, ARMOR], [BOTHHANDS, ONEHAND]*4)
            prize = Prize.new(1,1)
            @unusedMonsters.push(Monster.new("Felpuggoth", 2, bad, prize, 5)
            
            # Shoggoth
            bad = BadConsequence.new_det_tr("Pierdes 2 niveles", 2, [], [])
            prize = Prize.new(4,2)
            @unusedMonster.push(Monster.new("Shoggoth", 16, bad, prize, -4)

            # Lolitagooth
            bad = BadConsequence.new_det_tr("Pintalabios negro. Pierdes 2 niveles.", 2, [], [])
            prize = Prize.new(1,1)
            @unusedMonsters.push(Monster.new("Lolitagooth", 2, bad, prize, 3)
            

        end

        # Método para añadir sectarios. 
        def initCultistCardDeck
            4.times do 
                @unusedCultists.push(Cultist.new("Sectario", 1)
            end
            2.times do
                @unusedCultists.push(Cultist.new("Sectario", 2)
            end
        end

        
        # Métodos para barajar los tesoros
        def shuffleTreasures
            @unusedTreasures.shuffle!
        end

        def shuffleMonsters
            @unusedMonsters.shuffle!
        end

        def shuffleCultists
            @unusedCultists.shuffle!
        end


        # Métodos públicos
        public

        def nextTreasure
            #swap si unusedTreasures está vacío. Barajamos después
            if (@unusedTreasures.empty?)
                @unusedTreasures,@usedTreasures = @usedTreasures,@unusedTreasures 
                shuffleTreasures
            end
            @unusedTreasures.pop
        end
        
        def nextMonster
            #swap si unusedMonsters está vacío. Barajamos despues. 
            if (@unusedMonsters.empty?)
                @unusedMonsters,@usedMonsters = @usedMonsters,@unusedMonsters 
                shuffleMonsters
            end
            @unusedMonsters.pop
        end

        def nextCultist
            #Simplemente extraemos otro sectario.
            @unusedCultists.pop
        end
        
        def giveTreasureBack(treasure)
            @usedTreasures.push treasure
        end

        def giveMonsterBack(monster)
            @usedMonsters.push monster
        end

        def initCards
            initTreasureCardDeck
            initMonsterCardDeck
            shuffleTreasures
            shuffleMonsters
            shuffleCultists
        end


        # Escribe los datos de CardDealer.
        def to_s
            "Mazo de monstruos: (#{@usedMonsters.size}/#{@unusedMonsters.size})\nMazo de tesoros: (#{@usedTreasures.size}/#{@unusedTreasures.size})"
        end

    end
   
end
