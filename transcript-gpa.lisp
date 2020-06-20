(in-package #:amherst-utils)

(defvar *equivalency-scale*
  '((A+ . 4.00)
    (A . 4.00)
    (A- . 3.67)
    (B+ . 3.33)
    (B . 3.00)
    (B- . 2.67)
    (C+ . 2.33)
    (C . 2.00)
    (C- . 1.67)
    (D . 1.00)
    (F . 0.00)))

(defun letter-grade-to-gpa (letter)
  (cdr (assoc letter *equivalency-scale* :test 'string=)))

(defun half-course-p (course)
  (str:containsp "H" (getf course :number)))

(defun extract-grades (transcript)
  (loop for course in (parse-transcript transcript)
	collect (getf course :grade)))

(defun convert-grades (grades)
  (mapcar #'letter-grade-to-gpa grades))

(defun mean (elements)
  (/ (reduce '+ elements) (length elements)))

(defun calculate-transcript-gpa (transcript)
  (mean (convert-grades (extract-grades transcript))))

