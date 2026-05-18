(define (domain domestic-service-robot)

  (:requirements :strips :typing :numeric-fluents)

  (:types 
    kettle heater dispenser cup - object
    flavor-drop tea-bag herbal-bag - ingredient
  )

  (:predicates
    ;; empty states
    (handempty)
    (heater-empty ?h - heater)
    (cup-empty ?c - cup)
    
    (holding ?k - kettle)
    (holding-ingredient ?i - ingredient)
    
    (on-table ?k - kettle)
    (on-heater ?k - kettle ?h - heater)
    (heater-on ?h - heater)
    
    (ingredient-available ?i - ingredient)
    (cup-filled-cold ?c - cup)
    (cup-filled-warm ?c - cup)
    (cup-filled-hot ?c - cup)
    (beverage-ready-flavored-water ?c - cup)
    (beverage-ready-warm-tea ?c - cup)
    (beverage-ready-hot-infusion ?c - cup)
  )

  (:functions
    (temperature ?k - kettle)
    (water-volume ?k - kettle)
  )
  
  (:action pick-from-table
    :parameters (?k - kettle)
    :precondition (and 
      (handempty) 
      (on-table ?k))
    :effect (and 
      (holding ?k) 
      (not (handempty))
      (not (on-table ?k)))
  )
  
  (:action place-on-table
    :parameters (?k - kettle)
    :precondition (holding ?k)
    :effect (and 
      (on-table ?k)
      (handempty)
      (not (holding ?k)))
  )

  (:action pick-from-heater
    :parameters (?k - kettle ?h - heater)
    :precondition (and 
      (handempty) 
      (on-heater ?k ?h) 
      (not (heater-on ?h)))
    :effect (and 
      (holding ?k) 
      (not (handempty))
      (not (on-heater ?k ?h)) 
      (heater-empty ?h))
  )
  
  (:action place-on-heater
    :parameters (?k - kettle ?h - heater)
    :precondition (and 
      (holding ?k)
      (heater-empty ?h))
    :effect (and 
      (on-heater ?k ?h)
      (handempty)
      (not (holding ?k))
      (not (heater-empty ?h)))
  )
  
  (:action pick-ingredient
    :parameters (?i - ingredient)
    :precondition (and 
      (handempty) 
      (ingredient-available ?i))
    :effect (and 
      (holding-ingredient ?i)
      (not (handempty))
      (not (ingredient-available ?i)))
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

  (:action turn-on-heater
    :parameters (?h - heater ?k - kettle)
    :precondition (and
      (handempty) 
      (on-heater ?k ?h)
      (> (water-volume ?k) 0)
      (not (heater-on ?h)))
    :effect (heater-on ?h)
  )

  (:action heat-step
    :parameters (?k - kettle ?h - heater)
    :precondition (and
      (heater-on ?h)
      (on-heater ?k ?h)
      (<= (temperature ?k) 100))
    :effect (increase (temperature ?k) 10)
  )

  (:action turn-off-heater
    :parameters (?h - heater ?k - kettle)
    :precondition (and
      (handempty) 
      (on-heater ?k ?h)
      (heater-on ?h))
    :effect (not (heater-on ?h))
  )
  
  (:action pour-cold
    :parameters (?k - kettle ?c - cup)
    :precondition (and 
      (holding ?k)
      (cup-empty ?c)
      (>= (water-volume ?k) 250)
      (<= (temperature ?k) 30))
    :effect (and 
      (decrease (water-volume ?k) 250)
      (cup-filled-cold ?c)
      (not (cup-empty ?c)))
  )

  (:action pour-warm
    :parameters (?k - kettle ?c - cup)
    :precondition (and 
      (holding ?k)
      (cup-empty ?c)
      (>= (water-volume ?k) 250)
      (> (temperature ?k) 30)
      (<= (temperature ?k) 65))
    :effect (and 
      (decrease (water-volume ?k) 250)
      (cup-filled-warm ?c)
      (not (cup-empty ?c)))
  )

  (:action pour-hot
    :parameters (?k - kettle ?c - cup)
    :precondition (and 
      (holding ?k)
      (cup-empty ?c)
      (>= (water-volume ?k) 250)
      (> (temperature ?k) 65)
      (<= (temperature ?k) 100))
    :effect (and 
      (decrease (water-volume ?k) 250)
      (cup-filled-hot ?c)
      (not (cup-empty ?c)))
  )
  
  (:action prepare-flavored-water
    :parameters (?c - cup ?i - flavor-drop)
    :precondition (and 
      (cup-filled-cold ?c)           
      (holding-ingredient ?i))
    :effect (and 
      (beverage-ready-flavored-water ?c)
      (handempty)
      (not (holding-ingredient ?i)))
  )

  (:action prepare-warm-tea
    :parameters (?c - cup ?i - tea-bag)
    :precondition (and 
      (cup-filled-warm ?c)           
      (holding-ingredient ?i))
    :effect (and 
      (beverage-ready-warm-tea ?c)
      (handempty)
      (not (holding-ingredient ?i)))
  )

  (:action prepare-hot-infusion
    :parameters (?c - cup ?i - herbal-bag)
    :precondition (and 
      (cup-filled-hot ?c)            
      (holding-ingredient ?i))
    :effect (and 
      (beverage-ready-hot-infusion ?c)
      (handempty)
      (not (holding-ingredient ?i)))
  )
)
