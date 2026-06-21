(define (problem plus)
  (:domain domestic-service-robot-plus)
  (:objects 
    k1 - kettle
    h1 - heater
    d1 - dispenser
    c-water - cup
    drops1 - flavor-drop
  )
  (:init
    (handempty) 
    (heater-empty h1) 
    (dispenser-empty d1)
    (cup-empty c-water)
    
    (on-table k1)
    (= (temperature k1) 100.0)
    (= (water-volume k1) 500.0) 
    
    (= (temperature-cup c-water) 20.0)
    (= (robot-cooldown) 0.0)

    (ingredient-available drops1)
  )
  (:goal
    (beverage-ready-flavored-water c-water)
  )
)