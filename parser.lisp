(defvar *transcript* "
                   FALL 2016                             
  CHEM 151    Introductory Chemistry       B+             
  COSC 112    Intro Comp Science II        B              
  FYSE 125    Giving                       B              
  MATH 211    Multivariable Calculus       B              
                                                          
                   SPRING 2017                            
  COSC 211    Data Structures              B+             
  MATH 272    Linear Algebra W Applicat    A-             
  PHIL 111    Philosophical Questions      B+             
  PHYS 124    Maxwellian Synthesis         B+             
                                                          
                    FALL 2017                             
  COSC 171    Computer Systems             A-             
  COSC 311    Algorithms                   A-             
  PHIL 213    Logic                        B+             
  STAT 360    Probability                  A-             
                                                          
                   SPRING 2018                            
  COSC 383    Computer Security            A              
  FREN 101    Elementary French            A              
  PHIL 310    Ethics                       A              
  STAT 230    Intermediate Statistics      A              
  STAT 231    Data Science                 B+             
                                                          
                    FALL 2018                             
  COSC 247    Machine Learning             A-             
  COSC 283    Networks                     A-             
  FREN 103    Intermediate French          A-             
  MATH 221    Trans Theoretical Math       A              
  STAT 320    Statistics Communication     A              
                                                          
                   SPRING 2019                            
  COSC 365    Performance Evaluation       A              
  COSC 401    Theoretical Foundations      B+             
  FREN 205    Language and Literature      A              
  MATH 252    Cryptography                 A              

  STAT 370    Theoretical Statistics       A-             
                                                          
                    FALL 2019                             
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
  FREN 208    French Conversation          A        
")

(ql:quickload "str")

(defun semester-line-p (line)
  (or (str:containsp "SPRING" line) (str:containsp "FALL" line)))

(defun empty-line-p (line)
  (str:blankp line))

(defun class-line-p (line)
  (and (not (semester-header-p line))
       (not (empty-line-p line))))

(defun parse-semester-line (line)
  (str:trim line))

(defun parse-class-line (line)
  (labels ((tokenize (line)
	     (str:words (str:trim line))))
    (destructuring-bind (dept num &rest name+grade) (tokenize line)
      (destructuring-bind (grade &rest reverse-name) (reverse name+grade)
	(list :department dept
	      :number num
	      :name (str:unwords (reverse reverse-name))
	      :grade grade)))))

(defun parse-transcript-line (line)
  (cond ((semester-line-p line) (parse-semester-line line))
	((class-line-p line) (parse-class-line line))
	(t (format t "Line isn't a semester line or class line: ~a" line))))

(defun parse-transcript (transcript)
  (let ((semester)
	(parsed)
	(result))
    (loop for line in (str:lines transcript) unless (empty-line-p line) do
      (progn (setq parsed (parse-transcript-line line))
	     (if (semester-line-p parsed)
		 (setq semester parsed)
		 (progn (setf (getf parsed :semester) semester)
			(push parsed result)))))
    (reverse result)))
