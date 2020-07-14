(in-package #:amherst-transcript)

(defun main-page (environment)
  (let ((response-body (cl-who:with-html-output-to-string (s nil :prologue t :indent t)
                         (:html
                          (:head
                           (:meta :charset "UTF-8")
                           (:title "Amherst College GPA Calculator"))
                          (:body
                           (:h2 "Paste your transcript below:")
                           (:form :method :post :action "/results"
                                  (:div (:input :type "submit"))
                                  (:textarea :name "transcript"
                                             :rows 25 :cols 50
                                             (cl-who:str *example-transcript*))))))))
    `(200 (:content-type "text/html; charset=UTF-8") (,response-body))))

(defun results-page (environment)
  "Endpoint calculating the gpa for a given request environment."
  (let* ((gpa (calculate-transcript-gpa (cdr (assoc "transcript"
                                                    (http-body:parse
                                                     (getf environment :content-type)
                                                     (getf environment :content-length)
                                                     (getf environment :raw-body))
                                                    :test #'string=))))
         (response-body (cl-who:with-html-output-to-string (s nil :prologue t :indent t)
                          (:html
                           (:head
                            (:meta :charset "UTF-8")
                            (:title "Amherst College GPA Calulator"))
                           (:body
                            (:p "Your gpa is: " (cl-who:fmt "~$" gpa)))))))
    `(200 (:content-type "text/html; charset=UTF-8") (,response-body))))

(defun error-page ()
  `(404 nil ("Oops... the URL was not found.")))

(defun app (environment)
  "The application returns a lambda list defining a response for a request."
  (cond ((string= (getf environment :path-info) "/") (main-page environment))
        ((string= (getf environment :path-info) "/results") (results-page environment))
        (t (error-page))))

(defparameter *server* nil "The running server, use server-* functions")

(defun server-start ()
  "Start the server, saving a reference to it."
  (unless *server*
    (setf *server* (clack:clackup #'app :server :woo))))


(defun server-stop ()
  "Stop the server, clearing the reference to it."
  (when *server*
    (clack:stop *server*)
    (setf *server* nil)))

(defun server-restart ()
  "Stop the server and start it again."
  (server-stop)
  (server-start))
