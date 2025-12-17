
*&---------------------------------------------------------------------*

*& Report ZEDR09_008

*&---------------------------------------------------------------------*

*&

*&---------------------------------------------------------------------*




REPORT ZEDR09_008.






* ====================================================================

* internal table LINE ## 3## ##

* - INSERT : ####### ### ##

* - APPEND : ####### '###'### ### ## (## ###) (##)

* - COLLECT : ## '#'# ### ##### SUM# ##,

*             ## ## ### ### ##

* ====================================================================



* ====================================================================

* INSERT : ####### ### ##

* - ## ###### #### ## APPEND# ##, ##### ### ## ##

* ====================================================================






DATA : BEGIN OF GS_STUDENT, "### ##

  ZCODE TYPE C LENGTH 10,

  ZKNAME TYPE C LENGTH 20,

  ZENAME TYPE C LENGTH 20,

END OF GS_STUDENT.



DATA : GT_STUDENT LIKE TABLE OF GS_STUDENT. "### ### ##



CLEAR : GS_STUDENT. "## ### #### ## #, #### CLEAR# ### #!

GS_STUDENT-ZCODE = 'SSU-02'.

GS_STUDENT-ZKNAME = '###'.

GS_STUDENT-ZENAME = 'LEE'.

INSERT GS_STUDENT INTO TABLE GT_STUDENT.



CLEAR : GS_STUDENT.

GS_STUDENT-ZCODE = 'SSU-01'.

GS_STUDENT-ZKNAME = '###'.

GS_STUDENT-ZENAME = 'KANG'.

INSERT GS_STUDENT INTO TABLE GT_STUDENT.



CLEAR : GS_STUDENT.

GS_STUDENT-ZCODE = 'SSU-03'.

GS_STUDENT-ZKNAME = '###'.

GS_STUDENT-ZENAME = 'SONG'.

INSERT GS_STUDENT INTO TABLE GT_STUDENT.






* INDEX# ###, ### ### ### ##!




CLEAR : GS_STUDENT.

GS_STUDENT-ZCODE = 'SSU-09'.

GS_STUDENT-ZKNAME = '###'.

GS_STUDENT-ZENAME = 'KIM'.

INSERT GS_STUDENT INTO GT_STUDENT INDEX 2. "### ## ##, ## ## TABLE ##






* ====================================================================

* COLLECT : ## '#'# ## ## ##

* - ## ## ## ## ###, ## #### ## + ### ### #### ##

* - ## ## ## ####, ### # ##

* ====================================================================






DATA : BEGIN OF GS_STUDENT_02, "### ##

  ZCODE TYPE C LENGTH 10,

  ZKNAME TYPE C LENGTH 20,

  ZENAME TYPE C LENGTH 20,

  ZSUM TYPE I, "COLLENT ### ## ### ##

END OF GS_STUDENT_02.



DATA : GT_STUDENT_02 LIKE TABLE OF GS_STUDENT_02. "###### ##






* ## collect 3## 3# ## key## #### ## ### ## ####.




CLEAR : GS_STUDENT_02.

GS_STUDENT_02-ZCODE = 'SSU-02'.

GS_STUDENT_02-ZKNAME = '###'.

GS_STUDENT_02-ZENAME = 'LEE'.

GS_STUDENT_02-ZSUM = '20000'.

COLLECT GS_STUDENT_02 INTO GT_STUDENT_02.



CLEAR : GS_STUDENT_02.

GS_STUDENT_02-ZCODE = 'SSU-01'.

GS_STUDENT_02-ZKNAME = '###'.

GS_STUDENT_02-ZENAME = 'KANG'.

GS_STUDENT_02-ZSUM = '10000'.

COLLECT GS_STUDENT_02 INTO GT_STUDENT_02.



CLEAR : GS_STUDENT_02.

GS_STUDENT_02-ZCODE = 'SSU-03'.

GS_STUDENT_02-ZKNAME = '###'.

GS_STUDENT_02-ZENAME = 'SONG'.

GS_STUDENT_02-ZSUM = '30000'.

COLLECT GS_STUDENT_02 INTO GT_STUDENT_02.






* ## collect 1##, SSU-03 ## ### ## ZSUM# ## ## ## ###. ###?!




CLEAR : GS_STUDENT_02.

GS_STUDENT_02-ZCODE = 'SSU-03'.

GS_STUDENT_02-ZKNAME = '###'.

GS_STUDENT_02-ZENAME = 'SONG'.

GS_STUDENT_02-ZSUM = '80000'.

COLLECT GS_STUDENT_02 INTO GT_STUDENT_02.



break-point.







break-point.