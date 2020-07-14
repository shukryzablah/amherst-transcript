(in-package #:amherst-transcript)

(defvar *example-transcript* "
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

(parse-transcript *example-transcript*)

(calculate-transcript-gpa *example-transcript*)
