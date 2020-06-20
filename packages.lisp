(in-package #:cl-user)

(defpackage #:amherst-utils
  (:use #:common-lisp)
  (:import-from #:str
		#:containsp
		#:blankp
		#:trim
		#:words
		#:unwords
		#:lines
		#:digitp)
  (:export #:parse-transcript
	   #:calculate-transcript-gpa))
