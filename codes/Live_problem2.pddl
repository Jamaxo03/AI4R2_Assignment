(define (problem live2)
  (:domain domestic-service-robot-plus)

  (:objects 
    k1 - kettle
    ;; no heater
    ;; no dispenser
    c1 c2 c3 - cup
    t1 - tea-bag
    hb1 - herbal-bag
    hb2 - herbal-bag
  )

  (:init

    (handempty)
    
    (on-table k1)
    
    (cup-empty c1)
    (cup-empty c2)
    (cup-empty c3)
    
    (ingredient-available t1)
    (ingredient-available hb1)
    (ingredient-available hb2)
    
    (= (robot-cooldown) 0.0)
    
    (= (water-volume k1) 750.0)
    (= (temperature k1) 100.0)
    
    (= (temperature-cup c1) 20.0)
    (= (temperature-cup c2) 20.0)
    (= (temperature-cup c3) 20.0)
  )

  (:goal (and 
    (beverage-ready-hot-infusion c1)
    (beverage-ready-warm-tea c2)
    (beverage-ready-hot-infusion c3)
  ))
)