(define (domain domestic-service-robot)

  (:requirements :strips :typing :numeric-fluents)

  (:types 
    kettle heater dispenser cup - object
  )

  (:predicates
    (handempty)
    (holding ?k - kettle)
    (on-heater ?k - kettle ?h - heater)
    ;(water-inside ?k - kettle)
    (heater-on ?h - heater)
    (is-boiled ?k - kettle)
    (cup-empty ?c - cup)
    (cup-filled-cold ?c - cup)
    (cup-filled-warm ?c - cup)
    (cup-filled-hot ?c - cup)
    (cup-filled-boiled ?c - cup)
  )

  (:functions
    (temperature ?k - kettle)
    (water-volume ?k - kettle)
  )

  (:action pick-up-kettle
    :parameters (?k - kettle ?h - heater)
    :precondition (and 
      (handempty) 
      (on-heater ?k ?h) 
      (not (heater-on ?h)))
    :effect (and 
      (holding ?k) 
      (not (handempty))
      (not (on-heater ?k ?h)) 
    )
  )

  (:action fill-kettle
    :parameters (?k - kettle ?d - dispenser)
    :precondition (and
      (holding ?k)
      (<= (water-volume ?k) 750))
    :effect (and
      (increase (water-volume ?k) 250)
      (assign (temperature ?k) 20))
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
    :precondition (and 
      (on-heater ?k ?h)
      (> (water-volume ?k) 0))
    :effect (heater-on ?h)
  )

  (:action heat-step
    :parameters (?k - kettle ?h - heater)
    :precondition (heater-on ?h)
    :effect (increase (temperature ?k) 10)
  )

  (:action turn-off-heater
    :parameters (?h - heater)
    :precondition (heater-on ?h)
    :effect (not (heater-on ?h))
  )
  
  (:action pour-cold
    :parameters (?k - kettle ?c - cup)
    :precondition (and 
      (holding ?k)
      (cup-empty ?c)
      (>= (water-volume ?k) 250)
      (<= (temperature ?k) 30)
    )
    :effect (and 
      (decrease (water-volume ?k) 250)
      (cup-filled-cold ?c)
      (not (cup-empty ?c))
    )
  )

  (:action pour-warm
    :parameters (?k - kettle ?c - cup)
    :precondition (and 
      (holding ?k)
      (cup-empty ?c)
      (>= (water-volume ?k) 250)
      (>= (temperature ?k) 40)
      (<= (temperature ?k) 60)
    )
    :effect (and 
      (decrease (water-volume ?k) 250)
      (cup-filled-warm ?c)
      (not (cup-empty ?c))
    )
  )

  (:action pour-hot
    :parameters (?k - kettle ?c - cup)
    :precondition (and 
      (holding ?k)
      (cup-empty ?c)
      (>= (water-volume ?k) 250)
      (>= (temperature ?k) 70)
      (<= (temperature ?k) 90)
    )
    :effect (and 
      (decrease (water-volume ?k) 250)
      (cup-filled-hot ?c)
      (not (cup-empty ?c))
    )
  )

  (:action pour-boiled
    :parameters (?k - kettle ?c - cup)
    :precondition (and 
      (holding ?k)
      (cup-empty ?c)
      (>= (water-volume ?k) 250)
      (>= (temperature ?k) 100)
      (<= (temperature ?k) 120)
    )
    :effect (and 
      (decrease (water-volume ?k) 250)
      (cup-filled-boiled ?c)
      (not (cup-empty ?c))
    )
  )
)
