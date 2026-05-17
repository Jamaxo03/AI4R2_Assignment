(define (problem immediate)
  (:domain domestic-service-robot)

  (:objects 
    my-kettle - kettle
    my-heater - heater
    my-tap - dispenser
    cup1 - cup
  )

  (:init
    (handempty)
    (on-heater my-kettle my-heater)
    (= (temperature my-kettle) 20) 
    (= (water-volume my-kettle) 0)
    (cup-empty cup1)
  )

  (:goal
    (cup-filled-hot cup1)  
  )
)