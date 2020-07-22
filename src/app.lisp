(in-package #:cl-user)
(defpackage #:amherst-transcript.app
  (:use #:cl)
  (:import-from #:amherst-transcript.gpa-calculator
                #:calculate-gpa)
  (:export #:app))
(in-package #:amherst-transcript.app)

(defmacro with-page ((&key title) &body body)
  `(cl-who:with-html-output-to-string (s nil :prologue t :indent t)
     (:html
      (:head
       (:meta :charset "UTF-8")
       (:link :rel "stylesheet" :type "text/css" :href "/static/styles.css")
       (:title ,title))
      (:body ,@body))))

(defun main-page (environment)
  (declare (ignore environment))
  (let* ((example-transcript (uiop:read-file-string
                              (asdf:system-relative-pathname "amherst-transcript"
                                                             "example-transcript.txt")))
         (response-body (with-page (:title "Amherst College GPA Calculator")
                          (:header
                           (:h1 "Paste your transcript below:"))
                          (:form :method :post :action "/results"
                                 (:div (:input :type "submit"))
                                 (:textarea :name "transcript"
                                            :rows 25 :cols 50
                                            (cl-who:str example-transcript))))))
    `(200 (:content-type "text/html; charset=UTF-8") (,response-body))))

(defun results-page (environment)
  "Endpoint calculating the gpa for a given request environment."
  (let* ((gpa (calculate-gpa (cdr (assoc "transcript"
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
  (let ((path (getf environment :path-info)))
    (cond ((string= path "/") (main-page environment))
          ((string= path "/results") (results-page environment))
          (t (error-page)))))

(defun app-with-middlewares ()
  (lack:builder
   (:static :path "/static/" :root (asdf:system-relative-pathname "amherst-transcript" "src/"))
   #'app))

; clack roswell script will use the result of this form (which is an app)
(app-with-middlewares)
