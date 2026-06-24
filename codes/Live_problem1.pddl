(define (problem live1)
  (:domain domestic-service-robot-plus)

  (:objects 
    k1 - kettle
    h1 - heater
    d1 - dispenser
    c1 c2 c3 - cup
    f1 - flavor-drop
    t1 - tea-bag
    hb1 - herbal-bag
  )

  (:init

    (handempty)
    
    (on-table k1)
    (heater-empty h1)
    (dispenser-empty d1)
    
    (cup-empty c1)
    (cup-empty c2)
    (cup-empty c3)
    
    (ingredient-available f1)
    (ingredient-available t1)
    (ingredient-available hb1)
    
    (= (robot-cooldown) 0.0)
    
    (= (water-volume k1) 0.0)
    (= (temperature k1) 20.0)
    
    (= (temperature-cup c1) 20.0)
    (= (temperature-cup c2) 20.0)
    (= (temperature-cup c3) 20.0)
  )

  (:goal (and 
    (beverage-ready-flavored-water c1)
    (beverage-ready-warm-tea c2)
    (beverage-ready-hot-infusion c3)
  ))
)