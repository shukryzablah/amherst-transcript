(in-package #:amherst-transcript-tests)
(def-suite app
  :description "Testing the application."
  :in master)
(in-suite app)

(test placeholder
  "Placeholder test."
  (is (= 5 5)))
