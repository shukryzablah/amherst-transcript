(in-package #:cl-user)
(defpackage #:amherst-transcript.app
  (:use #:cl)
  (:import-from #:amherst-transcript.gpa-calculator
                #:calculate-gpa)
  (:export #:*app*))
(in-package #:amherst-transcript.app)

(defmacro with-page ((&key title) &body body)
  `(cl-who:with-html-output-to-string (s nil :prologue t :indent t)
     (:html
      (:head
       (:meta :charset "UTF-8")
       (:meta :name "viewport" :content "width=device-width, initial-scale=1")
       (:link :rel "stylesheet" :type "text/css" :href "/static/styles.css")
       (:title ,title))
      (:body ,@body))))

(defun main-page (request)
  (declare (ignore request))
  (let* ((example-transcript (uiop:read-file-string
                              (asdf:system-relative-pathname "amherst-transcript"
                                                             "example-transcript.txt")))
         (response-body (with-page (:title "Amherst College GPA Calculator")
                          (:main
                           (:header
                            (:h1 "Transcript -> GPA"))
                           (:form :method :post :action "/results"
                                  (:label :for "transcript" "Paste your transcript (from ACDATA) below to calculate your gpa.")
                                  (:textarea :id "transcript"
                                             :name "transcript"
                                             :rows 25 :cols 50
                                             (cl-who:str example-transcript))
                                  (:input :type "submit"))))))
    `(200 (:content-type "text/html; charset=UTF-8") (,response-body))))

(defun results-page (request)
  "Endpoint calculating the gpa for a given request environment."
  (let* ((gpa (calculate-gpa (cdr (assoc "transcript"
                                         (lack.request:request-body-parameters request)
                                         :test #'string=))))
         (response-body (with-page (:title "Amherst College GPA Calculator")
                          (:main
                           (:header
                            (:h1 "Transcript -> GPA"))
                           (:p :id "gpa" "Your gpa is: " (cl-who:fmt "~$" gpa))))))
    `(200 (:content-type "text/html; charset=UTF-8") (,response-body))))

(defun error-page ()
  `(404 nil ("Oops... the URL was not found.")))

(defun app (environment)
  "The application returns a lambda list defining a response for a request."
  (let* ((request (lack.request:make-request environment))
         (path (lack.request:request-path-info request)))
    (cond ((string= path "/") (main-page request))
          ((string= path "/results") (results-page request))
          (t (error-page)))))

(defparameter *app*
  (lack:builder
   (:static :path "/static/"
            :root (asdf:system-relative-pathname "amherst-transcript" "src/"))
   #'app))

; clack roswell script will use the result of this form (which is an app)
*app*
