;; ============================================================
;; Assignment D1-V1 — Q1 Problem 2: Non-Trivial Instance
;; 5 locations, 3 samples, 
;;  Three samples must be collected (one trip each) and
;;  delivered to base.
;; ============================================================

(define (problem rover-nontrivial)
  (:domain planetary-rover)

  (:objects
    base waypoint1 site-A site-B site-C - location
    sample1 sample2 sample3 - sample
  )

  (:init
    ;; --- rover starts at base ---
    (at-rover base)

    ;; --- map topology  ---
    (connected base waypoint1)
    (connected waypoint1 base)
    (connected waypoint1 site-C)
    (connected site-C waypoint1)
    (connected base site-A)
    (connected site-A base)
    (connected site-A site-B)
    (connected site-B site-A)
    (connected site-B site-C)
    (connected site-C site-B)

    ;; --- edge costs ---
    (= (move-cost base waypoint1)    15)
    (= (move-cost waypoint1 base)    15)
    (= (move-cost waypoint1 site-C)  20)
    (= (move-cost site-C waypoint1)  20)
    (= (move-cost base site-A)       10)
    (= (move-cost site-A base)       10)
    (= (move-cost site-A site-B)     10)
    (= (move-cost site-B site-A)     10)
    (= (move-cost site-B site-C)     15)
    (= (move-cost site-C site-B)     15)

    ;; --- sample placement ---
    (sample-at sample1 site-A)
    (has-sample site-A)
    (sample-at sample2 site-B)
    (has-sample site-B)
    (sample-at sample3 site-C)
    (has-sample site-C)

    ;; --- infrastructure ---
    (is-base base)

    ;; --- battery: tight budget ---
    (= (battery-level) 130)
  )

  ;; Goal: all three samples delivered, rover back at base
  (:goal
    (and
      (delivered sample1)
      (delivered sample2)
      (delivered sample3)
      (at-rover base)
    )
  )
)
