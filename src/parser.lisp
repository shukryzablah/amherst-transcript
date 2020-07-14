(in-package #:amherst-transcript)

(defun semester-line-p (line)
  (or (str:containsp "SPRING" line) (str:containsp "FALL" line)))

(defun empty-line-p (line)
  (str:blankp line))

(defun class-line-p (line)
  (and (not (semester-line-p line))
       (not (empty-line-p line))))

(defun parse-semester-line (line)
  (str:trim line))

(defun parse-class-line (line)
  (labels ((tokenize (line)
	     (str:words (str:trim line))))
    (destructuring-bind (dept num &rest name+grade) (tokenize line)
      (destructuring-bind (grade &rest reverse-name) (reverse name+grade)
	(list :department dept
	      :number num
	      :name (str:unwords (reverse reverse-name))
	      :grade grade)))))

(defun parse-transcript-line (line)
  (cond ((semester-line-p line) (parse-semester-line line))
	((class-line-p line) (parse-class-line line))
	(t (format t "Line isn't a semester line or class line: ~a" line))))

(defun parse-transcript (transcript)
  (let ((semester)
	(parsed)
	(result))
    (loop for line in (str:lines transcript) unless (empty-line-p line) do
      (progn (setq parsed (parse-transcript-line line))
	     (if (semester-line-p parsed)
		 (setq semester parsed)
		 (progn (setf (getf parsed :semester) semester)
			(push parsed result)))))
    (reverse result)))
