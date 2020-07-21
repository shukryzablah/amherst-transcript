(in-package #:cl-user)

(defpackage #:amherst-transcript-tests
  (:use #:cl #:5am)
  (:export #:run!
           #:master))
(in-package #:amherst-transcript-tests)

(def-suite master
  :description "The master test suite.")
