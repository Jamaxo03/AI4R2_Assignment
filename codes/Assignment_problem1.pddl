(define (problem q1-immediate-heating)
  (:domain domestic-service-robot)

  (:objects 
    k1 - kettle
    h1 - heater
    d1 - dispenser
    
    cup1 cup2 - cup
    tea1 tea2 - tea-bag
  )

  (:init
    (handempty)
    
    (heater-empty h1)
    (dispenser-empty d1)
    
    (on-table k1)
    (= (temperature k1) 20)
    (= (water-volume k1) 0) 
    
    (cup-empty cup1)
    (cup-empty cup2)
    (= (temperature-cup cup1) 20)
    (= (temperature-cup cup2) 20)

    (ingredient-available tea1)
    (ingredient-available tea2)
  )

  (:goal
    (and
      (beverage-ready-warm-tea cup1)
      (beverage-ready-warm-tea cup2)
    )
  )
)