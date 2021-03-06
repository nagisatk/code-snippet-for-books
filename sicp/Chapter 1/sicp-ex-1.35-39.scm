#lang scheme
(define tolerance 0.00001)
(define (fixed-point f first-guess)
  (define (close-enough? v1 v2)
    (display "current guess is ")
    (display v1)
    (display ", next:")
    (newline)
    (< (abs (- v1 v2)) tolerance))
  (define (try guess)
    (let ((next (f guess)))
      (if (close-enough? guess next)
        next
        (try next))))
  (try first-guess))
; Exercise 1.35
(define (gold-div)
  (fixed-point  (lambda (y) (+ 1.0 (/ 1.0 y)))
                1.0))
(gold-div)
(newline)
; Exercise 1.36
(define (power-self-1000)
  (fixed-point  (lambda (x) (/ (log 1000) (log x)))
                1.5))
(power-self-1000)

; Exercise 1.37
(define (cont-frac n d k)
  (define (iter count)
    (if (= count k)
        (/  (n count) (d count))
        (/  (n count)
            (+ (d count) (iter (+ count 1))))))
  (iter 1))
(cont-frac  (lambda (i) 1.0)
            (lambda (i) 1.0)
            11)
(display "another")
(newline)
(define (frac-cont n d k)
  (define (iter count result)
    (if (= count k)
      result
      (iter (+ count 1) (/ (n count) (+ (d count) result)))))
  (iter 1 (/ (n k) (d k))))
(frac-cont  (lambda (i) 1.0)
            (lambda (i) 1.0)
            11)

; Exercise 1.38
(define (e)
  (+  2
      (cont-frac  (lambda (n) 1.0)
                  (lambda (d)
                          (if (= (remainder d 3) 2)
                              (* (+ (/ (- d (remainder d 3)) 3) 1) 2)
                              1))
                  10)))
(e)

; Exercise 1.39
(define (tan-cf x k)
  (define (sq x n)
    (if (= n 1)
      x
      (* x x)))
  (define (oddnum n)
    (- (* n 2) 1))
  (define (iter count)
    (if (= k count)
        (/  (sq x count) (oddnum count))
        (/  (sq x count) (- (oddnum count) (iter (+ count 1))))))
  (iter 1))
(display "tan(pi/4) ~= ")
(tan-cf 0.785 100)

(define (tan x k)
  (define (sq n)
    (if (= n 1)
      x
      (* x x)))
  (define (oddnum n)
    (- (* n 2) 1))
  (define (iter count result)
    (if (< count 1)
      result
      (iter (- count 1) (/ (sq count) (- (oddnum count) result)))))
  (iter (- k 1) (/ (sq k) (oddnum k))))
(display "tan(pi/4) ~= ")
(tan 0.785 200)
