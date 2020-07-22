(defsystem "amherst-transcript"
  :description "Tool for Amherst students to understand their transcript."
  :version "0.4.0"
  :author "Shukry Zablah <shukryzablah@gmail.com>"
  :licence "MIT"
  :depends-on ("alexandria"
               "str"
               "clack"
               "lass"
               "lack"
               "http-body"
               "woo"
               "cl-who")
  :in-order-to ((test-op (test-op "amherst-transcript-tests")))
  :serial t
  :components ((:module "src"
                :serial t
                :components
                ((:file "parser")
                 (:file "gpa-calculator")
                 (:file "app")
                 (:file "amherst-transcript")
                 (:static-file "styles.css")))
               (:static-file "example-transcript.txt")))
