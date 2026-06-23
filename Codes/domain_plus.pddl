;; ============================================================
;; Assignment D1-V1 — Q2: Planetary Rover Domain (PDDL+)
;; ============================================================

(define (domain planetary-rover-plus)

  (:requirements
    :typing
    :numeric-fluents
    :continuous-effects
    :time
  )

  (:types
    location
    sample
  )

  (:predicates
    (at-rover ?l - location)
    (connected ?l1 ?l2 - location)
    (sample-at ?s - sample ?l - location)
    (carrying ?s - sample)
    (delivered ?s - sample)
    (is-base ?l - location)
    (has-sample ?l - location)
    (rover-active)
    (critical-battery)
    (system-ok)
  )

  (:functions
    (battery-level)
    (move-cost ?l1 ?l2 - location)
    (idle-drain-rate)
    (move-drain-rate)
    (critical-threshold)
  )

  ;; ===========================================================
  ;; PROCESS: idle-drain — always on
  ;; ===========================================================
  (:process idle-drain
    :parameters ()
    :precondition (and
      (> (battery-level) 0)
      (system-ok)
    )
    :effect (and
      (decrease (battery-level) (* #t (idle-drain-rate)))
    )
  )

  ;; ===========================================================
  ;; PROCESS: move-drain — only while moving
  ;; ===========================================================
  (:process move-drain
    :parameters ()
    :precondition (and
      (rover-active)
      (> (battery-level) 0)
      (system-ok)
    )
    :effect (and
      (decrease (battery-level) (* #t (move-drain-rate)))
    )
  )

  ;; ===========================================================
  ;; EVENT: battery-critical — fires when charge hits threshold
  ;; ===========================================================
  (:event battery-critical
    :parameters ()
    :precondition (and
      (<= (battery-level) (critical-threshold))
      (system-ok)
    )
    :effect (and
      (critical-battery)
      (not (system-ok))
    )
  )

  ;; ===========================================================
  ;; ACTION: start-move — rover leaves origin
  ;; ===========================================================
  (:action start-move
    :parameters (?from ?to - location)
    :precondition (and
      (at-rover ?from)
      (connected ?from ?to)
      (system-ok)
      (not (rover-active))
    )
    :effect (and
      (not (at-rover ?from))
      (rover-active)
      (decrease (battery-level) (move-cost ?from ?to))
      (at-rover ?to)
      (not (rover-active))
    )
  )

  ;; ===========================================================
  ;; ACTION: collect-sample
  ;; ===========================================================
  (:action collect-sample
    :parameters (?s - sample ?l - location)
    :precondition (and
      (at-rover ?l)
      (sample-at ?s ?l)
      (has-sample ?l)
      (system-ok)
    )
    :effect (and
      (not (sample-at ?s ?l))
      (carrying ?s)
    )
  )

  ;; ===========================================================
  ;; ACTION: deliver-sample
  ;; ===========================================================
  (:action deliver-sample
    :parameters (?s - sample ?base - location)
    :precondition (and
      (at-rover ?base)
      (is-base ?base)
      (carrying ?s)
      (system-ok)
    )
    :effect (and
      (not (carrying ?s))
      (delivered ?s)
    )
  )

)
