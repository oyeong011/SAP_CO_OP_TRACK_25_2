
*&---------------------------------------------------------------------*

*& Report ZEDR09_010

*&---------------------------------------------------------------------*

*&

*&---------------------------------------------------------------------*




REPORT ZEDR09_010.






* =====================================================================

* LOOP# : ####### ##### "1"## ##

* - #### ## ## ### ###, # ####!

* - ## 3##

*   1) ## ##

*   2) WHERE ### ##

*   3) INDEX# ##

* =====================================================================



* ## ### ##### ### ###, ######




DATA : BEGIN OF GS_STUDENT, "### ##

  ZPERNR TYPE ZEDT09_001-ZPERNR, "#### - TYPE# ##? (#)

  ZCODE LIKE ZEDT09_001-ZCODE, "####

  ZKNAME LIKE ZEDT09_001-ZKNAME, "##

  ZENAME LIKE ZEDT09_001-ZENAME, "####

  ZGENDER LIKE ZEDT09_001-ZGENDER, "##

  ZGNAME TYPE C LENGTH 4, "####

  ZTEL LIKE ZEDT09_001-ZTEL, "####

END OF GS_STUDENT.



DATA : GT_STUDENT LIKE TABLE OF GS_STUDENT. "###### ##








* =====================================================================

* 1) ## ##

* LOOP AT ######A (INTO ###A).

* ENDLOOP.

* LOOP# # ## ####### #####, "1"## #### ### ## ### ### ##!

* =====================================================================



* LOOP# ### ## 3## ### ##




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

GS_STUDENT-ZTEL = '01011112222'.

APPEND GS_STUDENT TO GT_STUDENT.



CLEAR : GS_STUDENT.

GS_STUDENT-ZPERNR = '0000000003'. "header ###

GS_STUDENT-ZCODE = 'SSU-03'.

GS_STUDENT-ZKNAME = '###'.

GS_STUDENT-ZENAME = 'SON'.

GS_STUDENT-ZGENDER = 'F'.

GS_STUDENT-ZTEL = '01022223333'.

APPEND GS_STUDENT TO GT_STUDENT.






* ## LOOP#




LOOP AT GT_STUDENT INTO GS_STUDENT.

  " ##

ENDLOOP.






* =====================================================================

* ## LOOP# ## ##

* 1. ## ## #, ## ###

* 2. ## ## # & LOOP ### ##, ## ###

* => ###, ##### ### #### #### ### #### ##! (##### ## #, F5# ### ##)

* =====================================================================






CLEAR : GS_STUDENT.



LOOP AT GT_STUDENT INTO GS_STUDENT.

  IF GS_STUDENT-ZGENDER = 'M'. "### #### GS #### ###, GT# ##.

    GS_STUDENT-ZGNAME = '##'.

  ELSEIF GS_STUDENT-ZGENDER = 'F'.

    GS_STUDENT-ZGNAME = '##'.

  ELSE.

    GS_STUDENT-ZGNAME = '##'.

  ENDIF.



  CLEAR : GS_STUDENT.

ENDLOOP.










* =====================================================================

* 2) ### ##

* LOOP AT ######A (INTO ###A)

*                     WHERE FIELD = 'VALUE'.

* ENDLOOP.

* =====================================================================



* LOOP ## #, ZGENDER = 'F'# #### ##.




CLEAR : GS_STUDENT.






* break-point. " #####, ### # # ## #### ### ## #,

*  ## LOOP AT ### #### ### ### ## where #### ### ##### ###, ### ENDLOOP!

* => ## : LOOP ###### ZGENDER = 'F'# # ##






LOOP AT GT_STUDENT INTO GS_STUDENT

                   WHERE ZGENDER = 'F'.

  IF GS_STUDENT-ZGENDER = 'M'.

    GS_STUDENT-ZGNAME = '##'.

  ELSEIF GS_STUDENT-ZGENDER = 'F'.

    GS_STUDENT-ZGNAME = '##'.

  ELSE.

    GS_STUDENT-ZGNAME = '##'.

  ENDIF.



  CLEAR : GS_STUDENT.

ENDLOOP.






* =====================================================================

* 2) ### ##

* LOOP# WHERE####, LOOP ## IF## # ####!

* LOOP AT ######A INTO ###A.

*   IF ###-## = 'VALUE'.

*   ENDIF.

* ENDLOOP.

* =====================================================================






CLEAR : GS_STUDENT.






* ## ### ### IF### ####!








LOOP AT GT_STUDENT INTO GS_STUDENT.

  IF GS_STUDENT-ZGENDER = 'F'.

    GS_STUDENT-ZGNAME = '##'.

  ENDIF.



  CLEAR : GS_STUDENT.

ENDLOOP.










* =====================================================================

* 3) INDEX

* LOOP AT ######A (INTO ###A) FROM 1 TO 4.

* ENDLOOP.

* =====================================================================



* LOOP ## #, INDEX 2~3 #### ##




CLEAR : GS_STUDENT.






* break-point.

* ####

* => LOOP# ###### INDEX 2 ##

* => SY-TABIX # ##### index# ## ### (LOOP## ##### ####!)






LOOP AT GT_STUDENT INTO GS_STUDENT FROM 2 TO 3.

  IF GS_STUDENT-ZGENDER = 'M'.

    GS_STUDENT-ZGNAME = '##'.

  ELSEIF GS_STUDENT-ZGENDER = 'F'.

    GS_STUDENT-ZGNAME = '##'.

  ELSE.

    GS_STUDENT-ZGNAME = '##'.

  ENDIF.



  CLEAR : GS_STUDENT.

ENDLOOP.