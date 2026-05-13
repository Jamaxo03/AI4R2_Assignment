(define (domain domestic-service-robot)

  (:requirements :strips :typing :numeric-fluents)

  (:types 
    kettle heater dispenser - object
  )

  (:predicates
    (handempty)
    (holding ?k - kettle)
    (on-heater ?k - kettle ?h - heater)
    (water-inside ?k - kettle)
    (heater-on ?h - heater)
    (is-boiled ?k - kettle)
  )

  (:functions
    (temperature ?k - kettle)
  )

  (:action pick-up-kettle
    :parameters (?k - kettle)
    :precondition (and (handempty) (not (holding ?k)))
    :effect (and 
      (holding ?k) 
      (not (handempty))
    )
  )

  (:action fill-kettle
    :parameters (?k - kettle ?d - dispenser)
    :precondition (holding ?k)
    :effect (water-inside ?k)
  )

  (:action place-on-heater
    :parameters (?k - kettle ?h - heater)
    :precondition (holding ?k)
    :effect (and 
      (on-heater ?k ?h)
      (handempty)
      (not (holding ?k))
    )
  )

  (:action turn-on-heater
    :parameters (?h - heater ?k - kettle)
    :precondition (and (on-heater ?k ?h) (water-inside ?k))
    :effect (heater-on ?h)
  )

  (:action heat-step
    :parameters (?k - kettle ?h - heater)
    :precondition (heater-on ?h)
    :effect (increase (temperature ?k) 20)
  )

  (:action check-boiled
    :parameters (?k - kettle)
    :precondition (>= (temperature ?k) 100)
    :effect (is-boiled ?k)
  )

  (:action turn-off-heater
    :parameters (?h - heater)
    :precondition (heater-on ?h)
    :effect (not (heater-on ?h))
  )
)