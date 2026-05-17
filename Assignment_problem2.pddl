(define (problem ordering)
  (:domain domestic-service-robot)

  (:objects 
    my-kettle - kettle
    my-heater - heater
    ;;my-tap - dispenser
    cup1 - cup 
    cup2 - cup  
  )

  (:init
    (handempty)
    (on-heater my-kettle my-heater)
    (= (temperature my-kettle) 20)  
    (= (water-volume my-kettle) 500)
    (cup-empty cup1)
    (cup-empty cup2)
  )

  (:goal
    (and
      (cup-filled-warm cup1)
      (cup-filled-boiled cup2)
    )
  )
)