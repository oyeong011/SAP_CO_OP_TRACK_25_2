
*&---------------------------------------------------------------------*

*& Report ZEDR09_005

*&---------------------------------------------------------------------*

*&

*&---------------------------------------------------------------------*




REPORT ZEDR09_005.






* ===============================================================

* ~p24. internal #####? header, body ##### ##

* ===============================================================



* internal ###

* - #### ### #### ### # ## local table

* - DB# #### #### ####, ### #### local(### ##)# ####

* - work area(=structure)# abap ## #### se11(abap dictionary)# '##' ### # ### ## ## ##,

*   #### ## #### internal table ### ##.

* - ##? ## ###### work area(=structure) ~ abap dictionary, ~ header ##, ### #### ####?

*   ### body# header# append #### ## .(### ## ####..?)





* ### -> ### ###




DATA : GS_ZEDT09 TYPE ZEDT09_001. "### ##, ####

DATA : GT_ZEDT09 TYPE TABLE OF ZEDT09_001. " ### ### ##






* ## 6#### header(###)# ### ##




GS_ZEDT09-ZCODE = 'SSU-09'.

GS_ZEDT09-ZPERNR = '0000000009'.

GS_ZEDT09-ZKNAME = '###'.

GS_ZEDT09-ZENAME = 'KMJ'.

GS_ZEDT09-ZGENDER = 'F'.

GS_ZEDT09-ZTEL = '01072373114'.






* BREAK-POINT. " header ##



* append a to b , move a to b# ##### a => b ### ##

* ## ##(####)# ~> ### #### ##




APPEND GS_ZEDT09 TO GT_ZEDT09.






* BREAK-POINT. " ### ### ##



* - #### ZEDT09_001 #### ## #### #### ###### ####

* - ###. ### #### ## ####.



* ### ### 2## ### ##

* header ##




GS_ZEDT09-ZCODE = 'SSU-10'.

GS_ZEDT09-ZPERNR = '0000000010'.

GS_ZEDT09-ZKNAME = '###2'.

GS_ZEDT09-ZENAME = 'KMJ2'.

GS_ZEDT09-ZGENDER = 'F'.

GS_ZEDT09-ZTEL = '01072373114v2'.






* break-point.






APPEND GS_ZEDT09 TO GT_ZEDT09.






* break-point.



* ===============================================================

* p24 ~. internal table ## ## 2##

*   - 1. ##### ## internalTable ## (## ## #, ## ## ## #)

*   - 2. ##### ## internalTable ## => ## ##

* ===============================================================



* ##### ## internal table ### ## ####, ## ### ####.

* ### ## ##### ## # ### ## # ## ###.. #### ### ###.



* ##### ## ### ### ##.




DATA : GT_ZEDT09_WITH_HEADER TYPE ZEDT09_001 OCCURS 0 WITH HEADER LINE.




* => ### ####, ##### ## # ###, ### == body# == GT_ZED09_WITH_HEADER

* occurs 0 : #### ## 0# ###, append # ## ##






GT_ZEDT09_WITH_HEADER-ZCODE = 'SSU-09'.

GT_ZEDT09_WITH_HEADER-ZPERNR = '0000000009'.

GT_ZEDT09_WITH_HEADER-ZKNAME = '###'.

GT_ZEDT09_WITH_HEADER-ZENAME = 'KMJ'.

GT_ZEDT09_WITH_HEADER-ZGENDER = 'F'.

GT_ZEDT09_WITH_HEADER-ZTEL = '01072373114'.






* break-point.



* ### #### ##




APPEND GT_ZEDT09_WITH_HEADER TO GT_ZEDT09_WITH_HEADER. "APPEND GT_ZEDT09_WITH_HEADER# ##






* break-point. -

* ## ##### ## ### #### ### == ######, break-point## ### ##,

*      header# :  GT_ZEDT09_WITH_HEADER

*      body# :  GT_ZEDT09_WITH_HEADER[]





* ===============================================================

* p24 ~. internal table ## ## 2##

*   - 1. ##### ## internalTable ## => more (begin of ~ end of)

*        -> ### internal table# # ## ## 5~6## #### ## ## ### ## #### ### ##### ## ###

*           ### #### ##, ### ## ### #### #### #### #### ##

*           LIKE, TYPE #### #### #

*   - 2. ##### ## internalTable ##

* ===============================================================



* TYPE# # #

* - ### ##




DATA : BEGIN OF GS_STUDENT,

  ZPERNR TYPE ZEDT09_001-ZPERNR, "####

  ZCODE TYPE ZEDT09_001-ZCODE, "####

  ZKNAME TYPE ZEDT09_001-ZKNAME, "##

  ZENAME TYPE ZEDT09_001-ZENAME, "####

  ZGENDER TYPE ZEDT09_001-ZGENDER, "##

  ZTEL TYPE ZEDT09_001-ZTEL, "####

  ZMNAME TYPE ZEDT09_002-ZMNAME, "## -> ## #### table2

  END OF GS_STUDENT.






* - ### #####, internalTable ##




DATA : GT_STUDENT LIKE TABLE OF GS_STUDENT.



GS_STUDENT-ZCODE = 'SSU-09'.

GS_STUDENT-ZPERNR = '0000000009'.

GS_STUDENT-ZKNAME = '###'.

GS_STUDENT-ZENAME = 'MINJI'.

GS_STUDENT-ZGENDER = 'F'.

GS_STUDENT-ZTEL = '01072373114'.

GS_STUDENT-ZMNAME = '#######'.



APPEND GS_STUDENT TO GT_STUDENT.






* break-point.



* LIKE# # #




DATA : BEGIN OF GS_STUDENT_LIKE,

  ZPERNR LIKE ZEDT09_001-ZPERNR, "####

  ZCODE LIKE ZEDT09_001-ZCODE, "####

  ZKNAME LIKE ZEDT09_001-ZKNAME, "##

  ZENAME LIKE ZEDT09_001-ZENAME, "####

  ZGENDER LIKE ZEDT09_001-ZGENDER, "##

  ZTEL LIKE ZEDT09_001-ZTEL, "####

  ZMNAME LIKE ZEDT09_002-ZMNAME, "## -> ## #### table2

  END OF GS_STUDENT_LIKE.






* - ### #####, internalTable ##




DATA : GT_STUDENT_LIKE LIKE TABLE OF GS_STUDENT_LIKE.



GS_STUDENT_LIKE-ZCODE = 'SSU-09'.

GS_STUDENT_LIKE-ZPERNR = '0000000009'.

GS_STUDENT_LIKE-ZKNAME = '###'.

GS_STUDENT_LIKE-ZENAME = 'MINJI'.

GS_STUDENT_LIKE-ZGENDER = 'F'.

GS_STUDENT_LIKE-ZTEL = '01072373114'.

GS_STUDENT_LIKE-ZMNAME = '#######'.



APPEND GS_STUDENT_LIKE TO GT_STUDENT_LIKE.






* break-point.