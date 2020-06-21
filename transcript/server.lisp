(in-package #:amherst-utils)

(defvar *acceptor* (make-instance 'hunchentoot:easy-acceptor :port 4242))

(hunchentoot:define-easy-handler
    (easy-demo :uri "/gpa-calculator"
	       :default-request-type :post)
    (transcript)
  (with-html-output-to-string (*standard-output* nil :prologue t)
    (:html
     (:head (:title "Amherst College GPA Calculator"))
     (:body
      (:h2 "Paste your transcript below:")
      (:form :method :post
	     (:div (:input :type "submit"))
	     (:textarea :name "transcript"
			:rows 25 :cols 50
			(str (or transcript "Paste your transcript"))))
      (:p "Your gpa is: " (fmt "~$" (calculate-transcript-gpa transcript)))))))

(defun start-server ()
  (unless (hunchentoot:started-p *acceptor*)
    (hunchentoot:start *acceptor*)))
