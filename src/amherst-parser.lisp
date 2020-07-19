(defpackage #:parser
  (:use #:cl)
  (:import-from #:str
                #:containsp
                #:blankp
                #:trim
                #:words
                #:unwords
                #:lines
                #:digitp)
  (:export #:parse-transcript))

(in-package #:parser)

(defparameter *example-data*
  "                    FALL 2019
  COSC 257    Databases                    A
  COSC 450    Seminar in Computer Sci      A
  COSC 498    Senior Honors                A+
  FREN 207    Intro French Lit & Cult      B+
  STAT 490H   Theory Meets Practice        A
  STAT 495    Advanced Data Analysis       A

                   SPRING 2020
  COSC 355    Network Science              A+
  COSC 490    Metaprogramming              A
  COSC 499    Senior Honors                A+
  FREN 208    French Conversation          A        ")

(defclass course ()
  (name department semester grade)
  (:documentation "A university course."))
