(define (problem plus)
  (:domain domestic-service-robot-plus)
  (:objects 
    k1 - kettle
    h1 - heater
    d1 - dispenser
    c-water c-tea c-infusion - cup
    drops1 - flavor-drop
    tea1 - tea-bag
    herbal1 - herbal-bag
  )
  (:init
    (handempty) 
    (heater-empty h1) 
    (dispenser-empty d1)
    (cup-empty c-water) 
    (cup-empty c-tea) 
    (cup-empty c-infusion)
    
    (on-table k1)
    (= (temperature k1) 20.0) 
    (= (water-volume k1) 0.0) 
    
    (= (temperature-cup c-water) 20.0)
    (= (temperature-cup c-tea) 20.0)
    (= (temperature-cup c-infusion) 20.0)
    
    (= (robot-cooldown) 0.0)

    (ingredient-available drops1)
    (ingredient-available tea1)
    (ingredient-available herbal1)
  )
  (:goal
    (and
      (beverage-ready-flavored-water c-water)
      (beverage-ready-warm-tea c-tea)
      (beverage-ready-hot-infusion c-infusion)
    )
  )
)