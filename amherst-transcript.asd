(asdf:defsystem "amherst-transcript"
  :description "Tool for Amherst students to understand their transcript."
  :version "0.2.0"
  :author "Shukry Zablah <shukryzablah@gmail.com>"
  :licence "MIT"
  :depends-on ("str" "clack" "lack" "http-body" "woo" "cl-who")
  :serial t
  :components ((:file "packages")
               (:module "src"
                :serial t
                :components ((:file "parser")
                             (:file "gpa-calculator")
                             (:file "example")
                             (:file "server")))))