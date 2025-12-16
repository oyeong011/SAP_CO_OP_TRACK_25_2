
*&---------------------------------------------------------------------*

*& Report ZEDR09_007

*&---------------------------------------------------------------------*

*&

*&---------------------------------------------------------------------*




REPORT ZEDR09_007.






*=========================================================================

* SORT : ### ### ## ### key### SORT

* - ## ## ###, ## ##### #### sort# ### ## #### insert# # ##

*========================================================================






DATA : BEGIN OF GS_STUDENT,"### ##

  ZCODE TYPE C LENGTH 10,

  ZKNAME TYPE C LENGTH 20,

  ZENAME TYPE C LENGTH 20,

END OF GS_STUDENT.



DATA : GT_STUDENT LIKE TABLE OF GS_STUDENT. "###### ##






* ### ## ###




GS_STUDENT-ZCODE = 'ssu-02'.

GS_STUDENT-ZKNAME = '###'.

GS_STUDENT-ZENAME = 'LEE'.




* body# ### (append)




APPEND GS_STUDENT TO GT_STUDENT.



GS_STUDENT-ZCODE = 'ssu-01'.

GS_STUDENT-ZKNAME = '###'.

GS_STUDENT-ZENAME = 'KANG'.

APPEND GS_STUDENT TO GT_STUDENT.



GS_STUDENT-ZCODE = 'ssu-03'.

GS_STUDENT-ZKNAME = '###'.

GS_STUDENT-ZENAME = 'SONG'.

APPEND GS_STUDENT TO GT_STUDENT.






* SORT### #### ##### (### ## ##)

* SORT GT_STUDENT. - ASENDING# ####

* SORT GT_STUDENT ASCENDING.




SORT GT_STUDENT DESCENDING.






*=========================================================================

* SORT BY : SORT# ##, #### KEY# #### ## ## #### # ## #### ##.

*========================================================================



* SORT GT_STUDENT BY ZKNAME. - ##### ##### ASCENDING




SORT GT_STUDENT BY ZKNAME DESCENDING.






*=========================================================================

* SORT BY : ## ### #### ### ##.

* #### ## ####(ZKNAME)# ##, id# ## ### ##

* -> ZKNAME ## ## #### ### ZCODE# ##### ##

*========================================================================




GS_STUDENT-ZCODE = 'ssu-04'.

GS_STUDENT-ZKNAME = '###'.

GS_STUDENT-ZENAME = 'LEE'.

APPEND GS_STUDENT TO GT_STUDENT.





SORT GT_STUDENT BY ZKNAME ZCODE DESCENDING.








*=========================================================================

* LINES : ####### #### ## ## # ##

* - ## SY-INDEX# ### ## ##### ## ####, ######.

*========================================================================






DATA : BEGIN OF GS_LINE, "### ##

  COL1 TYPE C,

  END OF GS_LINE.



DATA : GT_LINE LIKE TABLE OF GS_LINE. "###### ##



DATA : GV_LINE TYPE i. "### ## ##



GS_LINE-COL1 = SY-INDEX.




* WRITE : / GS_LINE-COL1. "### ####, 0#




APPEND GS_LINE TO GT_LINE.



GS_LINE-COL1 = '2'.

APPEND GS_LINE TO GT_LINE.



GS_LINE-COL1 = '7'.

APPEND GS_LINE TO GT_LINE.



DESCRIBE TABLE GT_LINE LINES GV_LINE. "GV_LINE# GT_LINE#### ## ##(LINES)# ##



WRITE : / GV_LINE. "## : 3