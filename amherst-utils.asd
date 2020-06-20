(asdf:defsystem "amherst-utils"
  :description "A collection of utilities specific to Amherst College."
  :version "0.1.0"
  :author "Shukry Zablah <shukryzablah@gmail.com>"
  :licence "MIT"
  :depends-on ("str")
  :serial t
  :components ((:file "package")
	       (:file "transcript-parser")
	       (:file "example")))