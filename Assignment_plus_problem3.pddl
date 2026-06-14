(define (problem safety-events)
  (:domain domestic-service-robot-plus)
  (:objects 
    k1 k2  - kettle
    h1 - heater
    d1 - dispenser
    c-water c-tea - cup
    drops1 - flavor-drop
    tea1 - tea-bag
  )
  (:init
    
    (handempty)
    (cup-empty c-water)
    (cup-empty c-tea)
    (= (temperature-cup c-tea) 20.0)
    (= (temperature-cup c-water) 20.0)
    (= (robot-cooldown) 0.0)
    (ingredient-available drops1)
    (ingredient-available tea1)

    
    (on-dispenser k1 d1)
    (dispenser-on d1)
    (= (water-volume k1) 900.0)
    (= (temperature k1) 20.0)

    
    (on-heater k2 h1)
    (heater-on h1)
    (= (water-volume k2) 500.0)
    (= (temperature k2) 99.0)
  )
  (:goal
    (and
      (beverage-ready-flavored-water c-water)
      (beverage-ready-warm-tea c-tea)
    )
  )
)