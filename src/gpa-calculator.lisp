(in-package #:cl-user)
(defpackage #:amherst-transcript.gpa-calculator
  (:use #:cl)
  (:import-from #:amherst-transcript.parser
                #:parse-transcript
                #:grade
                #:credits)
  (:export #:calculate-gpa))
(in-package #:amherst-transcript.gpa-calculator)

(defparameter *default-credits* 4)
(defparameter *equivalency-scale*
  '(("A+" . 4.00)
    ("A" . 4.00)
    ("A-" . 3.67)
    ("B+" . 3.33)
    ("B" . 3.00)
    ("B-" . 2.67)
    ("C+" . 2.33)
    ("C" . 2.00)
    ("C-" . 1.67)
    ("D" . 1.00)
    ("F" . 0.00)))

(defun get-grade-with-weights (courses)
  "Retrieve an alist of the grades and how much they count for (e.g. half credit)."
  (labels ((get-contribution (course)
             (cons (grade course) (/ (credits course) *default-credits*))))
    (mapcar #'get-contribution courses)))

(defun convert-grades (grades-with-weights)
  "Retrieve an alist of the gpa contribution and how much they count for (e.g. half credit)."
  (labels ((convert-grade (grade-with-weight)
             (cons (cdr (assoc (car grade-with-weight)
                               *equivalency-scale*
                               :test #'string=))
                   (cdr grade-with-weight))))
    (mapcar #'convert-grade grades-with-weights)))

(defun calculate-gpa (transcript)
  "Calculate the gpa on a 4.0 scale for a transcript text."
  (let ((grades-with-weights (convert-grades
                              (get-grade-with-weights
                               (parse-transcript transcript)))))
    (loop for (grade . weight) in grades-with-weights
         ; with course-count=0 and total=0
          summing weight into course-count
          summing (* weight grade) into total
          finally (return (/ total course-count)))))
