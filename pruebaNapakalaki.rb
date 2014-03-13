#!/usr/bin/env ruby
#encoding: utf-8
require_relative 'monster.rb'

module Napakalaki

  class PruebaNapakalaki

    def main ()
      #Declaración de los monstruos. 
      monsters = Array.new()

      #Monstruos añadidos por orden de aparición en el guión. 
      # 3 Byakhees de bonanza.
      bad = BadConsequence.new_det_tr("Pierdes tu armadura visible y otra oculta.", 0, [ARMOR], [ARMOR])
      prize = Prize.new(2,1)
      monsters.add(Monster.new("3 Byakhees de bonanza", 8, bad, prize))

      # Chibithulhu
      bad = BadConsequence.new_det_tr("Embobados con el lindo primigenio te descartas de tu casco visible.", 0, [HELMET], [])
      prize = Prize.new(1,1)
      monsters.add(Monster.new("Chibithulhu", 2, bad4, prize)) 

      # El sopor de Dunwich
      bad = BadConsequence.new_det_tr("El primordial bostezo contagioso. Pierdes el calzado visible.", 0, [SHOE], [])
      prize = Prize.new(1,1)
      monsters.add(Monster.new("El sopor de Dunwich", 2, bad, prize))

      # Ángeles de la noche ibicenca
      bad = BadConsequence.new_det_tr("Te atrapan para llevarte de fiesta y te dejan caer en mitad del vuelo. Descarta 1 mano visible y 1 mano oculta.", 0, [ONEHAND], [ONEHAND])
      prize = Prize.new(4,1)
      monsters.add(Monster.new("Ángeles de la noche ibicenca", 14, bad, prize))

      # El gorrón en el umbral
      bad = BadConsequence.new_det_tr("Pierdes todos tus tesoros visibles.", 0, [ARMOR, BOTHHANDs, ONEHAND, ONEHAND, SHOE, SHOE, HELMET, NECKLACE], [])
      prize = Prize.new(3,1)
      monsters.add(Monster.new("El gorrón en el umbral", 10, bad, prize)) 

      # H.P. Munchcraft
      bad = BadConsequence.new_det_tr("Pierdes la armadura visible.", 0, [ARMOR], [])
      prize = Prize.new(2,1)
      monsters.add(Monster.new("H.P. Munchcraft", 6, bad, prize))

      # Bichgooth
      bad = BadConsequence.new_det_tr("Sientes bichos bajo la ropa. Descarta la armadura visible.", 0, [ARMOR], []) 
      prize = Prize.new(1,1)
      monsters.add(Monster.new("Bichgooth", 2, bad, prize))

      # El rey de rosa
      bad = BadConsequence.new_indet_tr("Pierdes 5 niveles y 3 tesoros visibles.", 5, 3, 0)
      prize = Prize.new(4,2)
      monsters.add(Monster.new("El rey de rosa", 13, bad, prize))

      # La que redacta en las sombras. 
      bad = BadConsequence.new_indet_tr("Toses los pulmones y pierdes 2 niveles.", 2, 0, 0)
      prize = Prize.new(1,1)
      monsters.add(Monster.new("La que redacta en las sombras", 3, bad, prize))

      # Los hondos verdes
      bad = BadConsequence.new_death("Estos monstruos resultan bastante superficiales y te aburren mortalmente. Estás muerto.")
      prize = Prize.new(2,1)
      monsters.add(Monster.new("Los hondos verdes", 7, bad, prize))

      # Semillas Cthulhu
      bad = BadConsequence.new_indet_tr("Pierdes 2 niveles y 2 tesoros ocultos.", 2, 0, 2)
      prize = Prize.new(2,1)
      monsters.add(Monster.new("Semillas Cthulhu", 4, bad, prize))

      # Dameargo
      bad = BadConsequence.new_det_tr("Te intentas escapar. Pierdes una mano visible.", 0, [ONEHAND], [])
      prize = Prize.new(2,1)
      monsters.add(Monster.new("Dameargo", 1, bad, prize)) 

      # Pollipólipo volante
      bad = BadConsequence.new_indet_tr("Da mucho asquito. Pierdes 3 niveles.", 3, 0, 0)
      prize = Prize.new(1,1)
      monsters.add(Monster.new("Pollipólipo volante", 3, bad, prize)) 

      # Yskhtihyssg-Goth
      bad = BadConsequence.new_death("No le hace gracia que pronuncien mal su nombre. Estás muerto.")
      prize = Prize.new(3,1)
      monsters.add(Monster.new("Yskhtihyssg-Goth", 12, bad, prize)) 

      # Familia feliz.
      bad = BadConsequence.new_death("La familia te atrapa. Estás muerto.")
      prize = Prize.new(4,1)
      monsters.add(Monster.new("Familia feliz", 1, bad, prize)) 

      # Roboggoth
      bad = BadConsequence.new_det_tr("La quinta directiva primaria te obliga a perder 2 niveles y un tesoro 2 manos visible.", 2, [BOTHHANDS], [])
      prize = Prize.new(2,1)
      monsters.add(Monster.new("Roboggoth", 8, bad, prize)) 

      # El espía ciego.
      bad = BadConsequence.new_det_tr("Te asusta en la noche. Pierdes un casco visible.", 0, [HELMET], [])
      prize = Prize.new(1,1)
      monsters.add(Monster.new("El espía ciego", 4, bad, prize)) 

      # El Lenguas
      bad = BadConsequence.new_indet_tr("Menudo susto te llevas. Pierdes 2 niveles y 5 tesoros visibles.", 2, 5, 0)
      prize = Prize.new(1,1)
      monsters.add(Monster.new("El Lenguas", 20, bad, prize)) 

      # Bicéfalo 
      BadConsequence bad = BadConsequence.new_de("Te faltan manos para tanta cabeza. Pierdes 3 niveles y tus tesoros visibles de las manos.", 3, [ONEHAND, ONEHAND, BOTHHANDS], [])
      prize = Prize.new(1,1)
      monsters.add(Monster.new("Bicéfalo", 20, bad, prize)) 
   

      # Filtros sobre los monstruos.
      puts "Monstruos de nivel mayor a 10:\n #{nivelSuperior(monsters, 10).to_s}"
      puts "Monstruos que sólo quitan niveles:\n #{pierdenSoloNiveles(monsters).to_s}"
      puts "Monstruos con ganancia de un nivel o más:\n #{ganaMasDeUnNivel(monsters).to_s}"    
    end

    def nivelSuperior (listado, nivel)
      listado.select {|monster| monster.level >= nivel}
    end

    def pierdenSoloNiveles (listado)
      listado.select {|monster| (monster.bad.levels >= 0) && (monster.bad.death() == false) && (monster.bad.nVisible == 0) && (monster.bad.getnHidden == 0)}
    end

    def ganaMasDeUnNivel (listado)
      listado.select {|monster| monster.prize.levels > 1}
    end

    def pierdeTesoros (listado, tesoros)
      listado.select { |monster| (tesoros - (monster.bad.visible + monster.bad.hidden)).empty? }
    end
    
  end

  if __FILE__ == $0
    puts "Ejecutando..."
  end
    
end
