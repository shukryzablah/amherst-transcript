(in-package #:cl-user)
(defpackage #:amherst-transcript
  (:use #:cl)
  (:import-from #:amherst-transcript.parser
                #:parse-transcript)
  (:import-from #:amherst-transcript.app
                #:*app*)
  (:import-from #:amherst-transcript.gpa-calculator
                #:calculate-gpa)
  (:export #:parse-transcript
           #:*app*))
(in-package #:amherst-transcript)
