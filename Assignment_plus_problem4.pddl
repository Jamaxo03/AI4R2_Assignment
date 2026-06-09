(define (problem plus)
  (:domain domestic-service-robot-plus)
  (:objects 
    k1 k2 - kettle
    h1 - heater
    d1 - dispenser
    c-tea c-infusion - cup
    tea1 - tea-bag
    herbal1 - herbal-bag
  )
  (:init
    (handempty) 
    (heater-empty h1) 
    (dispenser-empty d1)
    (cup-empty c-tea) 
    (cup-empty c-infusion)
    
    (on-table k1) 
    (on-table k2)
    (= (temperature k1) 20.0) 
    (= (water-volume k1) 0.0) 
    (= (temperature k2) 20.0) 
    (= (water-volume k2) 0.0) 
    
    (= (temperature-cup c-tea) 20.0)
    (= (temperature-cup c-infusion) 20.0)
    (= (robot-cooldown) 0.0)

    (ingredient-available tea1)
    (ingredient-available herbal1)
  )
  (:goal
    (and
      (beverage-ready-warm-tea c-tea)
      (beverage-ready-hot-infusion c-infusion)
    )
  )
)