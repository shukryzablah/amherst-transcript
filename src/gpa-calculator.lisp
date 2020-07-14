(in-package #:amherst-transcript)

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

(defun whole-course-p (course)
  (str:digitp (getf course :number)))

(defun get-course-weight (course)
  (cond ((half-course-p course) 0.5)
	((whole-course-p course) 1)
	(t (format t "No support for course weight in ~a:" course))))

(defun extract-grades-with-weights (transcript)
  (loop for course in (parse-transcript transcript)
	collect (cons (getf course :grade)
		      (get-course-weight course))))

(defun convert-grades (grades)
  (loop for pair in grades
	do (setf (car pair) (letter-grade-to-gpa (car pair)))
	collect pair))

(defun calculate-contribution (grade)
  (* (car grade) (cdr grade)))

(defun calculate-contributions (grades)
  (mapcar #'calculate-contribution grades))

(defun count-courses (grades)
  (loop for grade in grades summing (cdr grade)))

(defun calculate-transcript-gpa (transcript)
  (when transcript
    (let ((grades (convert-grades
		  (extract-grades-with-weights transcript))))
    (/ (reduce #'+ (calculate-contributions grades))
       (count-courses grades)))))
