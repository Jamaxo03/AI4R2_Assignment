(define (problem ordering)
  (:domain domestic-service-robot)

  (:objects 
    my-kettle - kettle
    my-heater - heater
    cup1 cup2 - cup
    my-tea - tea-bag
    my-herbal - herbal-bag
  )

  (:init
    (handempty)
    (heater-empty my-heater)
    (on-table my-kettle)
    
    (= (temperature my-kettle) 20)
    (= (water-volume my-kettle) 500) 

    (cup-empty cup1)
    (cup-empty cup2)

    (ingredient-available my-tea)
    (ingredient-available my-herbal)
  )

  (:goal
    (and
      (beverage-ready-warm-tea cup1)
      (beverage-ready-hot-infusion cup2)
    )
  )
)