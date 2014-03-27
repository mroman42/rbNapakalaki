#!/usr/bin/env ruby
#encoding: utf-8
require_relative 'monster.rb'
require_relative 'treasure.rb'
require "singleton"

module Game

  class CardDealer
    include Singleton

    def initialize()
      @unusedMonsters = nil
      @usedMonsters = nil
      @unusedTreasures = nil
      @usedTreasures = nil
    end


    private

    def initTreasureCardDeck()
    end

    def initMonsterCardDeck()
    end

    def shuffleTreasures()
    end

    def shuffleMonsters()
    end


    public

    def nextTreasure()
    end
    
    def nextMonster()
    end
    
    def giveTreasureBack()
    end

    def giveMonsterBack()
    end

    def initCards()
    end

    def self.main ()
      #Declaración de los mazos. 
      monsters = Array.new()
      tesoros = Array.new()

      #Monstruos añadidos por orden de aparición en el guión. 
      # 3 Byakhees de bonanza.
      bad = BadConsequence.new_det_tr("Pierdes tu armadura visible y otra oculta.", 0, [ARMOR], [ARMOR])
      prize = Prize.new(2,1)
      monsters.push Monster.new("3 Byakhees de bonanza", 8, bad, prize)

      # Chibithulhu
      bad = BadConsequence.new_det_tr("Embobados con el lindo primigenio te descartas de tu casco visible.", 0, [HELMET], [])
      prize = Prize.new(1,1)
      monsters.push Monster.new("Chibithulhu", 2, bad, prize)

      # El sopor de Dunwich
      bad = BadConsequence.new_det_tr("El primordial bostezo contagioso. Pierdes el calzado visible.", 0, [SHOE], [])
      prize = Prize.new(1,1)
      monsters.push Monster.new("El sopor de Dunwich", 2, bad, prize)

      # Ángeles de la noche ibicenca
      bad = BadConsequence.new_det_tr("Te atrapan para llevarte de fiesta y te dejan caer en mitad del vuelo. Descarta 1 mano visible y 1 mano oculta.", 0, [ONEHAND], [ONEHAND])
      prize = Prize.new(4,1)
      monsters.push Monster.new("Ángeles de la noche ibicenca", 14, bad, prize)

      # El gorrón en el umbral
      bad = BadConsequence.new_det_tr("Pierdes todos tus tesoros visibles.", 0, [ARMOR, BOTHHANDS, ONEHAND, ONEHAND, SHOE, SHOE, HELMET, NECKLACE], [])
      prize = Prize.new(3,1)
      monsters.push Monster.new("El gorrón en el umbral", 10, bad, prize)

      # H.P. Munchcraft
      bad = BadConsequence.new_det_tr("Pierdes la armadura visible.", 0, [ARMOR], [])
      prize = Prize.new(2,1)
      monsters.push Monster.new("H.P. Munchcraft", 6, bad, prize)

      # Bichgooth
      bad = BadConsequence.new_det_tr("Sientes bichos bajo la ropa. Descarta la armadura visible.", 0, [ARMOR], []) 
      prize = Prize.new(1,1)
      monsters.push Monster.new("Bichgooth", 2, bad, prize)

      # El rey de rosa
      bad = BadConsequence.new_indet_tr("Pierdes 5 niveles y 3 tesoros visibles.", 5, 3, 0)
      prize = Prize.new(4,2)
      monsters.push Monster.new("El rey de rosa", 13, bad, prize)

      # La que redacta en las sombras. 
      bad = BadConsequence.new_indet_tr("Toses los pulmones y pierdes 2 niveles.", 2, 0, 0)
      prize = Prize.new(1,1)
      monsters.push Monster.new("La que redacta en las sombras", 3, bad, prize)

      # Los hondos verdes
      bad = BadConsequence.new_death("Estos monstruos resultan bastante superficiales y te aburren mortalmente. Estás muerto.")
      prize = Prize.new(2,1)
      monsters.push Monster.new("Los hondos verdes", 7, bad, prize)

      # Semillas Cthulhu
      bad = BadConsequence.new_indet_tr("Pierdes 2 niveles y 2 tesoros ocultos.", 2, 0, 2)
      prize = Prize.new(2,1)
      monsters.push Monster.new("Semillas Cthulhu", 4, bad, prize)

      # Dameargo
      bad = BadConsequence.new_det_tr("Te intentas escapar. Pierdes una mano visible.", 0, [ONEHAND], [])
      prize = Prize.new(2,1)
      monsters.push Monster.new("Dameargo", 1, bad, prize)

      # Pollipólipo volante
      bad = BadConsequence.new_indet_tr("Da mucho asquito. Pierdes 3 niveles.", 3, 0, 0)
      prize = Prize.new(1,1)
      monsters.push Monster.new("Pollipólipo volante", 3, bad, prize)

      # Yskhtihyssg-Goth
      bad = BadConsequence.new_death("No le hace gracia que pronuncien mal su nombre. Estás muerto.")
      prize = Prize.new(3,1)
      monsters.push Monster.new("Yskhtihyssg-Goth", 12, bad, prize)

      # Familia feliz.
      bad = BadConsequence.new_death("La familia te atrapa. Estás muerto.")
      prize = Prize.new(4,1)
      monsters.push Monster.new("Familia feliz", 1, bad, prize) 

      # Roboggoth
      bad = BadConsequence.new_det_tr("La quinta directiva primaria te obliga a perder 2 niveles y un tesoro 2 manos visible.", 2, [BOTHHANDS], [])
      prize = Prize.new(2,1)
      monsters.push Monster.new("Roboggoth", 8, bad, prize) 

      # El espía ciego.
      bad = BadConsequence.new_det_tr("Te asusta en la noche. Pierdes un casco visible.", 0, [HELMET], [])
      prize = Prize.new(1,1)
      monsters.push Monster.new("El espía ciego", 4, bad, prize)

      # El Lenguas
      bad = BadConsequence.new_indet_tr("Menudo susto te llevas. Pierdes 2 niveles y 5 tesoros visibles.", 2, 5, 0)
      prize = Prize.new(1,1)
      monsters.push Monster.new("El Lenguas", 20, bad, prize)

      # Bicéfalo 
      bad = BadConsequence.new_det_tr("Te faltan manos para tanta cabeza. Pierdes 3 niveles y tus tesoros visibles de las manos.", 3, [ONEHAND, ONEHAND, BOTHHANDS], [])
      prize = Prize.new(1,1)
      monsters.push Monster.new("Bicéfalo", 20, bad, prize) 




      #Tesoros añadidos por orden de aparición en el guión.
      # ¡Sí, mi amo!
      tesoros.push Treasure.new("¡Sí, mi amo!", 0, 4, 7, HELMET) 

      # Botas de investigación
      tesoros.push Treasure.new("Botas de investigación", 600, 3, 4, SHOE)

      # Capucha de Cthulhu
      tesoros.push Treasure.new("Capucha de Cthulhu", 500, 3, 5, HELMET)

      # A prueba de babas verdes
      tesoros.push Treasure.new("A prueba de babas verdes", 400, 3, 5, ARMOR)

      # Botas de lluvia  ́acida
      tesoros.push Treasure.new("Botas de lluvia  ́acida", 800, 1, 1, BOTHHANDS)

      # Casco minero
      tesoros.push Treasure.new("Casco minero", 400, 2, 4, HELMET)

      # Ametralladora Thompson
      tesoros.push Treasure.new("Ametralladora Thompson", 600, 4, 8, BOTHHANDS)

      # Camiseta de la UGR
      tesoros.push Treasure.new("Camiseta de la UGR", 100, 1, 7, ARMOR)

      # Clavo de rail ferroviario
      tesoros.push Treasure.new("Clavo de rail ferroviario", 400, 3, 6, ONEHAND)

      # Cuchillo de sushi arcano
      tesoros.push Treasure.new("Cuchillo de sushi arcano", 300, 2, 3, ONEHAND)

      # Fez Alópodo
      tesoros.push Treasure.new("Fez Alópodo", 700, 3, 5, HELMET)

      # Hacha prehistórica
      tesoros.push Treasure.new("Hacha prehistórica", 500, 2, 5, ONEHAND)

      # El aparato del Pr. Tesla
      tesoros.push Treasure.new("El aparato del Pr. Tesla", 900, 4, 8, ARMOR)

      # Gaita
      tesoros.push Treasure.new("Gaita", 200, 1, 5, BOTHHANDS)

      # Insecticida
      tesoros.push Treasure.new("Insecticida", 300, 2, 3, ONEHAND)

      # Escopeta de 3 cañones
      tesoros.push Treasure.new("Escopeta de 3 cañones", 700, 4, 6, BOTHHANDS)

      # Garabato místico
      tesoros.push Treasure.new("Garabato místico", 300, 2, 2, ONEHAND)

      # La fuerza de Mr. T
      tesoros.push Treasure.new("La fuerza de Mr. T", 1000, 0, 0, NECKLACE)

      # La rebeca metálica
      tesoros.push Treasure.new("La rebeca metálica", 400, 2, 3, ARMOR)

      # Mazo de los antiguos
      tesoros.push Treasure.new("Mazo de los antiguos", 200, 3, 4, ONEHAND)

      # Necro-playboycón
      tesoros.push Treasure.new("Necro-playboycón", 300, 3, 5, ONEHAND)

      # Lanzallamas
      tesoros.push Treasure.new("Lanzallamas", 800, 4, 8, BOTHHANDS)

      # Necro-comicón
      tesoros.push Treasure.new("Necro-comicón", 100, 1, 1, ONEHAND)

      # Necronomicón
      tesoros.push Treasure.new("Necronomicón", 800, 5, 7, BOTHHANDS)

      # Linterna a 2 manos
      tesoros.push Treasure.new("Linterna a 2 manos", 400, 3, 6, BOTHHANDS)

      # Necro-gnomicón
      tesoros.push Treasure.new("Necro-gnomicón", 200, 2, 4, ONEHAND)

      # Necrotelecom
      tesoros.push Treasure.new("Necrotelecom", 300, 2, 3, HELMET)

      # Porra preternatural
      tesoros.push Treasure.new("Porra preternatural", 200, 2, 3, ONEHAND)

      # Tentáculo de pega
      tesoros.push Treasure.new("Tentáculo de pega", 200, 0, 1, HELMET)

      # Zapatillas deja-amigos
      tesoros.push Treasure.new("Zapatillas deja-amigos", 500, 0, 1, SHOE)

      # Shogulador
      tesoros.push Treasure.new("Shogulador", 600, 1, 1, BOTHHANDS)

      # Varita de atizamiento
      tesoros.push Treasure.new("Varita de atizamiento", 400, 3, 4, ONEHAND)
    end

  end
 
end
