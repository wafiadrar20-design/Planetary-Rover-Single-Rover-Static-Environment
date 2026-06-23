;; ============================================================
;; Assignment D1-V1 — Q2 Problem 1: Idle Time
;; Same simple map as Q1-P1, but now idle drain is ON.
;; ============================================================

(define (problem rover-plus-simple)
  (:domain planetary-rover-plus)

  (:objects
    base site-A site-B - location
    sample1 - sample
  )

  (:init
    (at-rover base)
    (system-ok)

    (connected base site-A)  (connected site-A base)
    (connected site-A site-B) (connected site-B site-A)

    (= (move-cost base site-A) 10)
    (= (move-cost site-A base) 10)
    (= (move-cost site-A site-B) 10)
    (= (move-cost site-B site-A) 10)

    (sample-at sample1 site-A)
    (has-sample site-A)
    (is-base base)

    (= (idle-drain-rate)   1)   
    (= (move-drain-rate)   2)   

    (= (critical-threshold) 10)

    (= (battery-level) 80)
  )

  (:goal
    (and
      (delivered sample1)
      (at-rover base)
    )
  )
)
