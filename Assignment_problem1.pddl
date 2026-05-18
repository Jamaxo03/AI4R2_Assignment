(define (problem multi-everything)
  (:domain domestic-service-robot)

  (:objects 
    k1 k2 - kettle
    h1 h2 - heater
    tap - dispenser
    
    cup1 cup2 cup3 - cup
    
    my-drops - flavor-drop
    my-tea - tea-bag
    my-herbal - herbal-bag
  )

  (:init
    (handempty)
    
    (heater-empty h1)
    (heater-empty h2)
    
    (on-table k1)
    (on-table k2)
    (= (temperature k1) 20)
    (= (water-volume k1) 0) 
    (= (temperature k2) 20)
    (= (water-volume k2) 0) 

    (cup-empty cup1)
    (cup-empty cup2)
    (cup-empty cup3)

    (ingredient-available my-drops)
    (ingredient-available my-tea)
    (ingredient-available my-herbal)
  )

  (:goal
    (and
      (beverage-ready-flavored-water cup1)
      (beverage-ready-warm-tea cup2)
      (beverage-ready-hot-infusion cup3)
    )
  )
)