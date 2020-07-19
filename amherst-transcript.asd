(asdf:defsystem "amherst-transcript"
  :description "Tool for Amherst students to understand their transcript."
  :version "0.2.0"
  :author "Shukry Zablah <shukryzablah@gmail.com>"
  :licence "MIT"
  :depends-on ("str" "clack" "lack" "http-body" "woo" "cl-who")
  :in-order-to ((asdf:test-op (asdf:test-op "amherst-transcript-tests")))
  :serial t
  :pathname "src/"
  :components ((:file "packages")
               (:file "parser")
               (:file "gpa-calculator")
               (:file "example")
               (:file "app")))
