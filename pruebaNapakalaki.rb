#!/usr/bin/env ruby
#encoding: utf-8
require_relative 'Monster.rb'
module Napakalaki
  class PruebaNapakalaki
    if __FILE__ == $0
      #Declaración de los monstruos. 
      #Declaración de los monstruos. 
      @monsters = []

      #Ejemplos del guión. 
      #El rey de rosa
      @bad = BadConsequence.new_indet_tr("Pierdes 5 niveles y 3 tesoros visibles.", 5, 3, 0)
      monsters.add(Monster.new("El rey de rosa", 13, bad, Price.new(4,2)))

      #Ángeles de la noche ibicenca
      bad = BadConsequence.new_det_tr("Te atrapan para llevarte de fiesta y te dejan caer en mitad del vuelo. Descarta 1 mano visible y 1 mano oculta.", 0, [:onehand], [:onehand]);
      monsters.add(Monster.new("Ángeles de la noche ibicenca", 14, bad, Prize.new(4,1)))

      #Monstruos añadidos por orden de aparición en el guión. 
      #3 Byakhees de bonanza.
      bad = BadConsequence.new_det_tr("Pierdes tu armadura visible y otra oculta.", 0, [:armor], [:armor])
      monsters.add(Monster.new("2 Byakhees de bonanza", 8, bad, Prize.new(2,1)))

      #Chibithulhu
      bad = BadConsequence.new_det_tr("Embobados con el lindo primigenio te descartas de tu casco visible.", 0, [:helmet], [])
      monsters.add(Monster.new("Chibithulhu", 2, bad4, Prize.new(1,1))) 

      #El sopor de Dunwich
      bad = BadConsequence.new_det_tr("El primordial bostezo contagioso. Pierdes el calzado visible.", 0, [:shoe], [])
      monsters.add(Monster.new("El sopor de Dunwich", 2, bad, Prize.new(1,1)))

      #El gorrón en el umbral???
      bad = BadConsequence.new_det_tr("Pierdes todos tus tesoros visibles.", 0, [:armor, :bothhands, :onehand, :onehand, :shoe, :shoe, :helmet, :necklace], [])
      monsters.add(Monster.new("El gorrón en el umbral", 10, bad, Prize.new(3,1))) 

      #H.P. Munchcraft
      bad = BadConsequence.new_det_tr("Pierdes la armadura visible.", 0, [:armor], [])
      monsters.add(Monster.new("H.P. Munchcraft", 6, bad, Prize.new(2,1)))

      #Bichgooth
      bad = BadConsequence.new_det_tr("Sientes bichos bajo la ropa. Descarta la armadura visible.", 0, [:armor], []) 
      monsters.add(Monster.new("Bichgooth", 2, bad, Prize.new(1,1)))

      #La que redacta en las sombras. 
      bad = BadConsequence.new_indet_tr("Toses los pulmones y pierdes 2 niveles.", 2, 0, 0);
      monsters.add(Monster.new("La que redacta en las sombras", 3, bad, Price.new(1,1)));

      # Los hondos verdes

      BadConsequence bad10 = BadConsequence.new_de("Estos monstruos resultan "
      + "bastante superficiales y te aburren mortalmente. "
      + "Estás muerto.", true);
      Prize price10 = new Prize(2,1);
      monsters.add(Monster.new("Los hondos verdes", 7, bad10, price10)); 

      # Semillas Cthulhu

      BadConsequence bad11 = BadConsequence.new_de("Pierdes 2 niveles y 2 tesoros "
      + "ocultos.", 2, 0, 2); 
      Prize price11 = new Prize(2,1); 
      monsters.add(Monster.new("Semillas Cthulhu", 4, bad11, price11)); 

      # Dameargo 

      tvp.clear(); 
      tvp.add(TreasureKind.ONEHAND); 
      BadConsequence bad12 = BadConsequence.new_de("Te intentas escapar. "
      + "Pierdes una mano visible.", 0, tvp, thp); 
      Prize price12 = new Prize(2,1); 
      monsters.add(Monster.new("Dameargo", 1, bad12, price12)); 

      # Pollipólipo volante

      BadConsequence bad13 = BadConsequence.new_de("Da mucho asquito. Pierdes "
      + "3 niveles.", 3, 0, 0); 
      Prize price13 = new Prize(1,1); 
      monsters.add(Monster.new("Pollipólipo volante", 3, bad13, price13)); 

      # Yskhtihyssg-Goth

      BadConsequence bad14 = BadConsequence.new_de("No le hace gracia que pronuncien "
      + "mal su nombre. Estás muerto.", true); 
      Prize price14 = new Prize(3,1); 
      monsters.add(Monster.new("Yskhtihyssg-Goth", 12, bad14, price14)); 

      # Familia feliz. 

      BadConsequence bad15 = BadConsequence.new_de("La familia te atrapa. Estás muerto."
      , true); 
      Prize price15 = new Prize(4,1); 
      monsters.add(Monster.new("Familia feliz", 1, bad15, price15)); 

      # Roboggoth

      tvp.clear(); 
      tvp.add(TreasureKind.BOTHHANDS); 
      BadConsequence bad16 = BadConsequence.new_de("La quinta directiva primaria "
      + "te obliga a perder 2 niveles y un tesoro 2 manos visible.", 2
      , tvp, thp); 
      Prize price16 = new Prize(2,1); 
      monsters.add(Monster.new("Roboggoth", 8, bad16, price16)); 

      # El espía ciego. 

      tvp.clear(); 
      tvp.add(TreasureKind.HELMET); 
      BadConsequence bad17 = BadConsequence.new_de("Te asusta en la noche. "
      + "Pierdes un casco visible.", 0, tvp, thp); 
      Prize price17 = new Prize(1,1); 
      monsters.add(Monster.new("El espía ciego", 4, bad17, price17)); 

      # El Lenguas

      BadConsequence bad18 = BadConsequence.new_de("Menudo susto te llevas. Pierdes "
      + "2 niveles y 5 tesoros visibles.", 2, 5, 0); 
      Prize price18 = new Prize(1,1); 
      monsters.add(Monster.new("El Lenguas", 20, bad18, price18)); 

      # Bicéfalo

      tvp.clear(); 
      tvp.add(TreasureKind.BOTHHANDS); 
      BadConsequence bad19 = BadConsequence.new_de("Te faltan manos para tanta cabeza."
      + " Pierdes 3 niveles y tus tesoros visibles de las manos.", 3, tvp, thp);
      Prize price19 = new Prize(1,1); 
      monsters.add(Monster.new("Bicéfalo", 20, bad19, price19)); 
   
    end
  end
end
