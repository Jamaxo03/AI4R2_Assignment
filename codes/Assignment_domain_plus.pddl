(define (domain domestic-service-robot-plus)

  (:requirements :strips :typing :numeric-fluents :time)

  (:types 
    kettle heater dispenser cup - object
    flavor-drop tea-bag herbal-bag - ingredient
  )

  (:predicates

    (handempty)
    (heater-empty ?h - heater)
    (cup-empty ?c - cup)
    (dispenser-empty ?d - dispenser)
    
    (holding ?k - kettle)
    (holding-ingredient ?i - ingredient)
    
    (on-table ?k - kettle)
    (on-heater ?k - kettle ?h - heater)
    (on-dispenser ?k - kettle ?d - dispenser)
    
    (heater-on ?h - heater)
    (dispenser-on ?d - dispenser)
    
    (ingredient-available ?i - ingredient)
    (beverage-ready-flavored-water ?c - cup)
    (beverage-ready-warm-tea ?c - cup)
    (beverage-ready-hot-infusion ?c - cup)
  )

  (:functions
    (temperature ?k - kettle)
    (temperature-cup ?c - cup)
    (water-volume ?k - kettle)
    (robot-cooldown)
  )
  
  (:process robot-cooling-down
    :parameters ()
    :precondition (> (robot-cooldown) 0.0)
    :effect (decrease (robot-cooldown) (* #t 1.0)) 
  )
  
  (:action pick-from-table
    :parameters (?k - kettle)
    :precondition (and
      (<= (robot-cooldown) 0.0)
      (handempty) 
      (on-table ?k))
    :effect (and
      (assign (robot-cooldown) 1.0)
      (holding ?k) 
      (not (handempty))
      (not (on-table ?k)))
  )
  
  (:action place-on-table
    :parameters (?k - kettle)
    :precondition (and
      (<= (robot-cooldown) 0.0)
      (holding ?k))
    :effect (and 
      (assign (robot-cooldown) 1.0)
      (on-table ?k)
      (handempty)
      (not (holding ?k)))
  )

  (:action pick-from-heater
    :parameters (?k - kettle ?h - heater)
    :precondition (and
      (<= (robot-cooldown) 0.0)
      (handempty) 
      (on-heater ?k ?h) 
      (not (heater-on ?h)))
    :effect (and 
      (assign (robot-cooldown) 1.0)
      (holding ?k) 
      (not (handempty))
      (not (on-heater ?k ?h)) 
      (heater-empty ?h))
  )
  
  (:action place-on-heater
    :parameters (?k - kettle ?h - heater)
    :precondition (and
      (<= (robot-cooldown) 0.0)
      (holding ?k)
      (heater-empty ?h))
    :effect (and 
      (assign (robot-cooldown) 1.0)
      (on-heater ?k ?h)
      (handempty)
      (not (holding ?k))
      (not (heater-empty ?h)))
  )
  
  (:action pick-from-dispenser
    :parameters (?k - kettle ?d - dispenser)
    :precondition (and
      (<= (robot-cooldown) 0.0)
      (handempty) 
      (on-dispenser ?k ?d) 
      (not (dispenser-on ?d)))
    :effect (and 
      (assign (robot-cooldown) 1.0)
      (not (handempty))
      (not (on-dispenser ?k ?d)) 
      (holding ?k) 
      (dispenser-empty ?d))
  )
  
  (:action place-on-dispenser
    :parameters (?k - kettle ?d - dispenser)
    :precondition (and
      (<= (robot-cooldown) 0.0)
      (holding ?k)
      (dispenser-empty ?d))
    :effect (and 
      (assign (robot-cooldown) 1.0)
      (not (holding ?k))
      (not (dispenser-empty ?d))
      (on-dispenser ?k ?d)
      (handempty))
  )
  
  (:action pick-ingredient
    :parameters (?i - ingredient)
    :precondition (and
      (<= (robot-cooldown) 0.0)
      (handempty) 
      (ingredient-available ?i))
    :effect (and 
      (assign (robot-cooldown) 1.0)
      (not (handempty))
      (not (ingredient-available ?i))
      (holding-ingredient ?i))
  )

  (:action turn-on-dispenser
    :parameters (?d - dispenser ?k - kettle)
    :precondition (and
      (<= (robot-cooldown) 0.0)
      (handempty) 
      (on-dispenser ?k ?d)
      (< (water-volume ?k) 1000.0)
      (not (dispenser-on ?d)))
    :effect (and
      (assign (robot-cooldown) 1.0)
      (dispenser-on ?d)
      (assign (temperature ?k) 20.0)) 
  )
  
  (:process water-filling
    :parameters (?k - kettle ?d - dispenser)
    :precondition (and
      (dispenser-on ?d)
      (on-dispenser ?k ?d))
    :effect (increase (water-volume ?k) (* #t 100.0)) 
  )

  (:event stop-filling-safety
    :parameters (?k - kettle ?d - dispenser)
    :precondition (and
      (dispenser-on ?d)
      (on-dispenser ?k ?d)
      (>= (water-volume ?k) 1000.0))
    :effect (and
      (not (dispenser-on ?d))
      (assign (water-volume ?k) 1000.0))
  )
  
  (:action turn-off-dispenser
    :parameters (?d - dispenser ?k - kettle)
    :precondition (and
      (<= (robot-cooldown) 0.0)
      (handempty) 
      (on-dispenser ?k ?d)
      (dispenser-on ?d))
    :effect (and
      (assign (robot-cooldown) 1.0)
      (not (dispenser-on ?d)))
  )

  (:action turn-on-heater
    :parameters (?h - heater ?k - kettle)
    :precondition (and
      (<= (robot-cooldown) 0.0)
      (handempty) 
      (on-heater ?k ?h)
      (> (water-volume ?k) 0)
      (not (heater-on ?h)))
    :effect (and
      (assign (robot-cooldown) 1.0)
      (heater-on ?h))
  )

  (:process heating
    :parameters (?k - kettle ?h - heater)
    :precondition (and
      (heater-on ?h)
      (on-heater ?k ?h)
      (> (water-volume ?k) 0))
    :effect (increase (temperature ?k) (* #t 2.5)) 
  )
  
  (:event overheat-safety-switch-off
    :parameters (?k - kettle ?h - heater)
    :precondition (and 
      (heater-on ?h)
      (on-heater ?k ?h)
      (>= (temperature ?k) 100.0))
    :effect (not (heater-on ?h))
  )

  (:action turn-off-heater
    :parameters (?h - heater ?k - kettle)
    :precondition (and
      (<= (robot-cooldown) 0.0)
      (handempty) 
      (on-heater ?k ?h)
      (heater-on ?h))
    :effect (and
      (assign (robot-cooldown) 1.0)
      (not (heater-on ?h)))
  )
  
  (:process cooling-kettle
    :parameters (?k - kettle)
    :precondition (and
      (> (water-volume ?k) 0.0)
      (> (temperature ?k) 20.0))
    :effect (decrease (temperature ?k) (* #t 0.5))
  )

  (:process cooling-cup
    :parameters (?c - cup)
    :precondition (and
      (not (cup-empty ?c))
      (> (temperature-cup ?c) 20.0))
    :effect (decrease (temperature-cup ?c) (* #t 1.0))
  )
  
  (:action pour-water
    :parameters (?k - kettle ?c - cup)
    :precondition (and
      (<= (robot-cooldown) 0.0)
      (holding ?k)
      (cup-empty ?c)
      (>= (water-volume ?k) 250.0))
    :effect (and
      (assign (robot-cooldown) 1.0)
      (not (cup-empty ?c))
      (decrease (water-volume ?k) 250.0)
      (assign (temperature-cup ?c) (temperature ?k)))
  )
  
  (:action prepare-flavored-water
    :parameters (?c - cup ?i - flavor-drop)
    :precondition (and
      (<= (robot-cooldown) 0.0)
      (not (cup-empty ?c))            
      (holding-ingredient ?i)
      (<= (temperature-cup ?c) 30.0))
    :effect (and
      (assign (robot-cooldown) 1.0)
      (not (holding-ingredient ?i))
      (handempty)
      (beverage-ready-flavored-water ?c))
  )

  (:action prepare-warm-tea
    :parameters (?c - cup ?i - tea-bag)
    :precondition (and
      (<= (robot-cooldown) 0.0)
      (not (cup-empty ?c))            
      (holding-ingredient ?i)
      (> (temperature-cup ?c) 55.0)
      (<= (temperature-cup ?c) 65.0))
    :effect (and
      (assign (robot-cooldown) 1.0)
      (not (holding-ingredient ?i))
      (handempty)
      (beverage-ready-warm-tea ?c))
  )

  (:action prepare-hot-infusion
    :parameters (?c - cup ?i - herbal-bag)
    :precondition (and
      (<= (robot-cooldown) 0.0)
      (not (cup-empty ?c))            
      (holding-ingredient ?i)
      (> (temperature-cup ?c) 85.0)
      (<= (temperature-cup ?c) 95.0))
    :effect (and 
      (assign (robot-cooldown) 1.0)
      (not (holding-ingredient ?i))
      (handempty)
      (beverage-ready-hot-infusion ?c))
  )
)
