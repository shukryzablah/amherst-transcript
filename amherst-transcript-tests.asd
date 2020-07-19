(asdf:defsystem "amherst-transcript-tests"
  :depends-on ("amherst-transcript" "fiveam")
  :perform (test-op (o s)
                    (uiop:symbol-call :fiveam '#:run!
                       (uiop:find-symbol* '#:master
                                            :amherst-transcript-tests)))
  :pathname "tests/"
  :serial t
  :components ((:file "packages")
               (:file "suites")
               (:file "app")
               (:file "parser")))
