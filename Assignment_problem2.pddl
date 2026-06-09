(define (problem q2-ordering-matters)
  (:domain domestic-service-robot)

  (:objects 
    k1 - kettle
    h1 - heater
    ;; no dipenser
    
    cup1 cup2 - cup
    
    tea1 - tea-bag
    herbal1 - herbal-bag
  )

  (:init
    (handempty)
    
    (heater-empty h1)
    
    (on-table k1)
    
    (= (temperature k1) 20)
    (= (water-volume k1) 500) 
    
    (cup-empty cup1)
    (cup-empty cup2)
    (= (temperature-cup cup1) 20)
    (= (temperature-cup cup2) 20)

    (ingredient-available tea1)
    (ingredient-available herbal1)
  )

  (:goal
    (and
      (beverage-ready-warm-tea cup1)
      (beverage-ready-hot-infusion cup2)
    )
  )
)