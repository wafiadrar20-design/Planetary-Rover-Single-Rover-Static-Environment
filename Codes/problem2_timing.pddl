;; ============================================================
;; Assignment D1-V1 — Q2 Problem 2: problem2_timing
;;  Three samples must be collected (one trip each) and
;;  delivered to base.
;; ============================================================

(define (problem rover-plus-timing)
  (:domain planetary-rover-plus)

  (:objects
    base site-A site-B - location
    sample1 sample2 - sample
  )

  (:init
    (at-rover base)
    (system-ok)

    (connected base site-A)   (connected site-A base)
    (connected site-A site-B) (connected site-B site-A)
    (connected base site-B)   (connected site-B base)

    (= (move-cost base site-A)   10)
    (= (move-cost site-A base)   10)
    (= (move-cost site-A site-B) 10)
    (= (move-cost site-B site-A) 10)
    (= (move-cost base site-B)   20)
    (= (move-cost site-B base)   20)

    (sample-at sample1 site-A)
    (has-sample site-A)
    (sample-at sample2 site-B)
    (has-sample site-B)

    (is-base base)

    (= (idle-drain-rate)    1)
    (= (move-drain-rate)    1)
    (= (critical-threshold) 5)
    (= (battery-level)     80)
  )

  (:goal
    (and
      (delivered sample1)
      (delivered sample2)
      (at-rover base)
    )
  )
)
