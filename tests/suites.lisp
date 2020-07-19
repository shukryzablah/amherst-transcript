(in-package #:amherst-transcript-tests)

(def-suite master
  :description "Master test suite for the amherst-transcript tools.")

(def-suite parser
  :description "Test suite for the parser tool."
  :in master)

(def-suite app
  :description "Test suite for the app."
  :in master)

(defun run-tests ()
  (run! 'master))
