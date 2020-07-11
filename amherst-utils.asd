(asdf:defsystem "amherst-utils"
  :description "A collection of utilities specific to Amherst College."
  :version "0.1.0"
  :author "Shukry Zablah <shukryzablah@gmail.com>"
  :licence "MIT"
  :depends-on ("str" "clack" "cl-who")
  :serial t
  :components ((:file "packages")
               (:module "src"
                :serial t
                :components ((:file "parser")
                             (:file "gpa-calculator")
                             (:file "example")
                             (:file "server")))))
