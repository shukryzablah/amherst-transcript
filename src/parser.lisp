(in-package #:cl-user)
(defpackage #:amherst-transcript.parser
  (:use #:cl)
  (:import-from #:alexandria
                #:lastcar)
  (:export #:parse-transcript
           #:grade
           #:credits))
(in-package #:amherst-transcript.parser)

(defclass amherst-course ()
  ((name
    :initarg :name
    :documentation "The name of the course.")
   (department
    :initarg :department
    :documentation "The department the course is listed under.")
   (semester
    :initarg :semester
    :documentation "The semester the course was taken.")
   (number
    :initarg :number
    :documentation "The course number")
   (grade
    :initarg :grade
    :accessor grade
    :documentation "The final letter grade.")
   (credits
    :initarg :credits
    :accessor credits
    :documentation "The number of credits the course counts for."))
  (:documentation "A university course from an Amherst College."))

(defmethod print-object ((course amherst-course) stream)
  (print-unreadable-object (course stream :type t)
    (with-slots (name number department semester) course
        (format stream "~A, ~A~A, ~A" name department number semester))))

(defmethod initialize-instance :after ((course amherst-course) &key)
  "From the course number we can calculate course credits."
  (let ((number (slot-value course 'number)))
    (setf (slot-value course 'credits)
          (cond ((str:containsp "H" number) 2)
                ((str:containsp "D" number) 8)
                (t 4)))))

(defun parse-course-line (line semester)
  (let ((tokens (str:words line)))
    (destructuring-bind (department number &rest name) (butlast tokens)
      (let ((grade (lastcar tokens)))
        (make-instance 'amherst-course :name (str:unwords name)
                                       :department department
                                       :number number
                                       :semester semester
                                       :grade grade)))))

(defun semester-line-p (line)
  "Test if line declares semester."
  (or (str:containsp "SPRING" line) (str:containsp "FALL" line)))

(defun empty-line-p (line)
  "Test if line is empty."
  (str:blankp line))

(defun course-line-p (line)
  "Test if line represents a course."
  (and (not (semester-line-p line))
       (not (empty-line-p line))))

(defun parse-transcript (transcript-text)
  "Parse a transcript text into a list of course objects."
  (loop for line in (str:lines transcript-text) with semester
        if (semester-line-p line)
          do (setq semester (str:trim line))
        else
          if (course-line-p line)
            collect (parse-course-line line semester)))
