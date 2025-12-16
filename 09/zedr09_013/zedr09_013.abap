
*&---------------------------------------------------------------------*

*& Report ZEDR09_013

*&---------------------------------------------------------------------*

*&

*&---------------------------------------------------------------------*




REPORT ZEDR09_013.






* =====================================================================

* Internal Table ### - AT ##

* 1. LOOP ## #, ## ##

* 2. LOOP ## # ## ## ## #, ### #

* =====================================================================



* =====================================================================

* 1. LOOP ## #, ## ##



* AT ### LOOP## ## ##, ## ### ### # #### ##

* 1) AT FIRST => LOOP# ### # # ##

* 2) AT LAST => LOOP# ## # # ##

* 3) AT NEW f1 => ### ## f1# ## #### ### ##

* 4) AT END OF f1 => ### ## f1 ## ### ##

* =====================================================================



* ## ### ##### ### ###, ######




DATA : BEGIN OF GS_STUDENT, "### ##

  ZPERNR LIKE ZEDT09_001-ZPERNR, "####

  ZCODE LIKE ZEDT09_001-ZCODE, "####

  ZKNAME LIKE ZEDT09_001-ZKNAME, "##

  ZENAME LIKE ZEDT09_001-ZENAME, "####

  ZGENDER LIKE ZEDT09_001-ZGENDER, "##

  ZGNAME TYPE C LENGTH 4, "####

  ZTEL LIKE ZEDT09_001-ZTEL, "####

END OF GS_STUDENT.



DATA : GT_STUDENT LIKE TABLE OF GS_STUDENT.






* ## ## 3# ### ##




CLEAR : GS_STUDENT, GT_STUDENT.

GS_STUDENT-ZPERNR = '0000000001'. "header ###

GS_STUDENT-ZCODE = 'SSU-01'.

GS_STUDENT-ZKNAME = '###'.

GS_STUDENT-ZENAME = 'KANG'.

GS_STUDENT-ZGENDER = 'M'.

GS_STUDENT-ZTEL = '01012345678'.

APPEND GS_STUDENT TO GT_STUDENT.



CLEAR : GS_STUDENT.

GS_STUDENT-ZPERNR = '0000000002'. "header ###

GS_STUDENT-ZCODE = 'SSU-02'.

GS_STUDENT-ZKNAME = '###'.

GS_STUDENT-ZENAME = 'LEE'.

GS_STUDENT-ZGENDER = 'M'.

GS_STUDENT-ZTEL = '01012345678'.

APPEND GS_STUDENT TO GT_STUDENT.



CLEAR : GS_STUDENT.

GS_STUDENT-ZPERNR = '0000000003'. "header ###

GS_STUDENT-ZCODE = 'SSU-03'.

GS_STUDENT-ZKNAME = '###'.

GS_STUDENT-ZENAME = 'SON'.

GS_STUDENT-ZGENDER = 'F'.

GS_STUDENT-ZTEL = '01033334444'.

APPEND GS_STUDENT TO GT_STUDENT.






* 1) AT FIRST : LOOP #, ####### ### ## ### # ##






CLEAR : GS_STUDENT.



LOOP AT GT_STUDENT INTO GS_STUDENT.

  GS_STUDENT-ZGNAME = '####'.



  AT FIRST. " LOOP# # ### #####, FIRST # ## ##

    GS_STUDENT-ZGNAME = '####'.

     "AT ## ###, ## ## * ##

     "FISRT ### ## ## ##

  ENDAT.

     "AT ## #####, * ### ####.

  CLEAR : GS_STUDENT.



ENDLOOP.






* 2) AT LAST : ####### ### ## ### # ##






CLEAR : GS_STUDENT.

LOOP AT GT_STUDENT INTO GS_STUDENT.

  GS_STUDENT-ZGNAME = '####'.



  AT LAST.

    GS_STUDENT-ZGNAME = '####'.

  ENDAT.



  CLEAR : GS_STUDENT.

ENDLOOP.






* 3) AT NEW ##1

* - LOOP# ### ## ## ## ## ## #, #### ##

* - #, ## #### #### ###, ### SORT# ####.

*    #, SORT# ## ## #### ## # ## ##, AT NEW# # #### ## # ### #



* ## ## 6# ### ##




CLEAR : GS_STUDENT, GT_STUDENT.

GS_STUDENT-ZPERNR = '0000000001'. "header ###

GS_STUDENT-ZCODE = 'SSU-01'.

GS_STUDENT-ZKNAME = '###'.

GS_STUDENT-ZENAME = 'DONG'.

GS_STUDENT-ZGENDER = 'M'.

GS_STUDENT-ZTEL = '01012345678'.

APPEND GS_STUDENT TO GT_STUDENT.



CLEAR : GS_STUDENT.

GS_STUDENT-ZPERNR = '0000000001'. "header ###

GS_STUDENT-ZCODE = 'SSU-01'.

GS_STUDENT-ZKNAME = '###'.

GS_STUDENT-ZENAME = 'DONG'.

GS_STUDENT-ZGENDER = 'F'.

GS_STUDENT-ZTEL = '01012345678'.

APPEND GS_STUDENT TO GT_STUDENT.



CLEAR : GS_STUDENT.

GS_STUDENT-ZPERNR = '0000000001'. "header ###

GS_STUDENT-ZCODE = 'SSU-01'.

GS_STUDENT-ZKNAME = '###'.

GS_STUDENT-ZENAME = 'DONG'.

GS_STUDENT-ZGENDER = 'A'.

GS_STUDENT-ZTEL = '01012345678'.

APPEND GS_STUDENT TO GT_STUDENT.



CLEAR : GS_STUDENT.

GS_STUDENT-ZPERNR = '0000000002'. "header ###

GS_STUDENT-ZCODE = 'SSU-02'.

GS_STUDENT-ZKNAME = '###'.

GS_STUDENT-ZENAME = 'LEE'.

GS_STUDENT-ZGENDER = 'M'.

GS_STUDENT-ZTEL = '01012345678'.

APPEND GS_STUDENT TO GT_STUDENT.



CLEAR : GS_STUDENT.

GS_STUDENT-ZPERNR = '0000000001'. "header ###

GS_STUDENT-ZCODE = 'SSU-01'.

GS_STUDENT-ZKNAME = '###'.

GS_STUDENT-ZENAME = 'KANG'.

GS_STUDENT-ZGENDER = 'M'.

GS_STUDENT-ZTEL = '01012345678'.

APPEND GS_STUDENT TO GT_STUDENT.



CLEAR : GS_STUDENT.

GS_STUDENT-ZPERNR = '0000000001'. "header ###

GS_STUDENT-ZCODE = 'SSU-01'.

GS_STUDENT-ZKNAME = '###'.

GS_STUDENT-ZENAME = 'DONG'.

GS_STUDENT-ZGENDER = 'F'.

GS_STUDENT-ZTEL = '01033334444'.

APPEND GS_STUDENT TO GT_STUDENT.



SORT GT_STUDENT BY ZCODE ZKNAME ZENAME ZGENDER.







CLEAR : GS_STUDENT.

LOOP AT GT_STUDENT INTO GS_STUDENT.

  GS_STUDENT-ZGNAME = '####'.



  AT NEW ZENAME.

    " ##, AT## ####, ZENAME #### ##### ## ### ####.

    GS_STUDENT-ZGNAME = '####'.

    " ## ### ### ####, ## ### ZGNAME## ####.

  ENDAT.

  CLEAR : GS_STUDENT.

ENDLOOP.








* 4) AT END OF ##

* - AT NEW ### ### ####, ### ### # ##

* - Field F1# ## #### #, AT### ##.

* - #, #### ### ### # or #### #### #### ## ### #### # / ### ##.



* ##### 3# ### ##!






CLEAR : GS_STUDENT.







SORT GT_STUDENT BY ZCODE ZKNAME ZENAME ZGENDER. "SORT# ## ## ##!



LOOP AT GT_STUDENT INTO GS_STUDENT.

  GS_STUDENT-ZGNAME = '####'.



  AT END OF ZENAME.

    GS_STUDENT-ZGNAME = '####'.

  ENDAT.



  CLEAR : GS_STUDENT.

ENDLOOP.










* =====================================================================

* AT ## ### #



* 1. AT NEW f1# AT END OF f1# ## ### '##'# ## ###, SORT ##



* 2. AT ## ## #, CHAR TYPE# ### ** ## ###, MODIFY# # ## ##!

* => LOOP# ### AT NEW / AT END OF ## ### ### #, # ### ## CHAR ###### ##### ***## ####

* => ### ## MODIFY##, ### ### #### ## # ##!



* =====================================================================






DATA : BEGIN OF gs_test,

  class TYPE c LENGTH 2, "# (###)

  name TYPE c LENGTH 10, "##

  score TYPE i,

END OF gs_test.



DATA : gt_test LIKE TABLE OF gs_test.






* data insert




CLEAR : gs_test.



gs_test-class = 'A1'.

gs_test-name = 'kim'.

gs_test-score = 90.

APPEND gs_test to gt_test.



CLEAR : gs_test.

gs_test-class = 'A1'.

gs_test-name = 'Lee'.

gs_test-score = 80.

APPEND gs_test to gt_test.



CLEAR : gs_test.

gs_test-class = 'A2'.

gs_test-name = 'Park'.

gs_test-score = 70.

APPEND gs_test to gt_test.



SORT gt_test BY class.







LOOP AT gt_test INTO gs_test.



  AT NEW class.

  " AT NEW ###! class '##'  ### char# *####, #### 0## ####



  gs_test-name = '>>> # # ##'.

  MODIFY gt_test FROM gs_test.

  " ### AT## ### modify###,, name# #######, ### #### 0## ##### ### ## #####



  ENDAT.



ENDLOOP.






* #### ##






CLEAR : gs_test.



LOOP AT gt_test INTO gs_test.

  WRITE : / gs_test-class, gs_test-name, gs_test-score.

ENDLOOP.






* # AT ## ## ### #### ###! - ### 0 ### ##

* data insert




CLEAR : gs_test, gt_test.



gs_test-class = 'A1'.

gs_test-name = 'kim'.

gs_test-score = 90.

APPEND gs_test to gt_test.



CLEAR : gs_test.

gs_test-class = 'A1'.

gs_test-name = 'Lee'.

gs_test-score = 80.

APPEND gs_test to gt_test.



CLEAR : gs_test.

gs_test-class = 'A2'.

gs_test-name = 'Park'.

gs_test-score = 70.

APPEND gs_test to gt_test.



SORT gt_test BY class.






* AT## -> MODIFY ## ##



* =====================================================================

* AT ## ### # (MODIFY ##!! )



* => AT NEW / AT END OF####, #### "#"# "##" ### "###"## ####!

*     ##, "###"# #### ***#, #### 0## ####







* =====================================================================






CLEAR : gs_test.





LOOP AT gt_test INTO gs_test.



  AT NEW class.

  " AT NEW ###! class '##'  ## (name, score) # ### ##



  gs_test-name = '>>> # # ##'.

  " # ##, name# #### score# ### #### 0# ##!

  MODIFY gt_test FROM gs_test TRANSPORTING name.



  ENDAT.



  MODIFY gt_test FROM gs_test.



  CLEAR : gs_test.

ENDLOOP.








* #### ##






CLEAR : gs_test.



WRITE : / , / , 'modify #### ## ##'.



LOOP AT gt_test INTO gs_test.

  WRITE : / gs_test-class, gs_test-name, gs_test-score.

ENDLOOP.