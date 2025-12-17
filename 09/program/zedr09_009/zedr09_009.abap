
*&---------------------------------------------------------------------*

*& Report ZEDR09_009

*&---------------------------------------------------------------------*

*&

*&---------------------------------------------------------------------*




REPORT ZEDR09_009.






* =====================================================================

* INTERNAL TABLE ###

* 1. IF# << ### ## 5## ## #### #

* 2. LOOP# ##

* 3. LOOP# ## # ##

* =====================================================================



* =====================================================================

* 1. IF# (###)

* 1) IF ~ ENDIF (## 1#)

* 2) IF ~ ELSE ~ ENDIf (## 2#)

* 3) IF ~ ELSEIF ~ ELSE ~ ENDIF (## 3#)

* 4) IF ~ AND ~ ENDIF -> ###

* 5) IF ~ OR ~ ENDIF -> ###

* =====================================================================



* 1) IF ~ ENDIF




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



CLEAR : GS_STUDENT, GT_STUDENT.



GS_STUDENT-ZPERNR = '0000000001'. "header ###

GS_STUDENT-ZCODE = 'SSU-01'.

GS_STUDENT-ZKNAME = '###'.

GS_STUDENT-ZENAME = 'KANG'.

GS_STUDENT-ZGENDER = 'M'. "F# ### #, ## ### #### ####. (###### ####)

GS_STUDENT-ZTEL = '01012345678'.






* ### ## ### ##

*IF GS_STUDENT-ZGENDER = 'M'.

*  GS_STUDENT-ZGNAME = '##'.

*ENDIF.

*

*APPEND GS_STUDENT TO GT_STUDENT.



* 2) IF ~ ELSE ~ ENDIF

*IF GS_STUDENT-ZGENDER = 'M'.

*  GS_STUDENT-ZGNAME = '##'.

*ELSE.

*  GS_STUDENT-ZGNAME = '##'.

*ENDIF.

*

*CLEAR GT_STUDENT.

*APPEND GS_STUDENT TO GT_STUDENT.





*CLEAR : GS_STUDENT, GT_STUDENT.

*

*GS_STUDENT-ZPERNR = '0000000001'. "header ###

*GS_STUDENT-ZCODE = 'SSU-01'.

*GS_STUDENT-ZKNAME = '###'.

*GS_STUDENT-ZENAME = 'KANG'.

*GS_STUDENT-ZGENDER = 'UNDEFINED'. "###### ## '##' ZGNAME ##.

*GS_STUDENT-ZTEL = '01012345678'.

*

** 3) IF ~ ELSEIF ~ ELSE ~ ENDIF

*IF GS_STUDENT-ZGENDER = 'M'.

*  GS_STUDENT-ZGNAME = '##'.

*ELSEIF GS_STUDENT-ZGENDER = 'F'.

*  GS_STUDENT-ZGNAME = '##'.

*ELSE.

*  GS_STUDENT-ZGNAME = '##'.

*ENDIF.

*

*APPEND GS_STUDENT TO GT_STUDENT.



* 4) IF ~ AND ~ ENDIF (###)

*IF ( GS_STUDENT-ZGENDER = 'M' AND GS_STUDENT-ZKNAME ='###').

*  GS_STUDENT-ZGNAME = '##/###'.

*ENDIF.

*

*APPEND GS_STUDENT TO GT_STUDENT.



* 5) IF ~ OR ~ ENDIF (###)




IF ( GS_STUDENT-ZGENDER = 'M' ) OR ( GS_STUDENT-ZKNAME = '###').

  GS_STUDENT-ZGNAME = '##'.

ENDIF.



APPEND GS_STUDENT TO GT_STUDENT.








* =====================================================================

* 2. IF# ##

* 1) EQ equal =

* 2) LT less than <

* 3) GT greater than >

* 4) LE less or equal <=

* 5) GE greater than >

* 6) NE not equal !=

* =====================================================================






WRITE : / '1# - IF## WRITE# ##'.

DATA : num1 TYPE I VALUE 100,

       num2 TYPE I VALUE 120.



IF num1 LT num2.

  WRITE : / 'num1# num2## ##'.

ELSE.

  WRITE : / 'num1# num2## ## ##'.

ENDIF.



WRITE : / '2# - IF## WRITE# ##'.

DATA : num1_02 TYPE I VALUE 100,

       num2_02 TYPE I VALUE 120,

       num3_02 TYPE I VALUE 110.



IF ( num1_02 LT num2_02 AND num1_02 LT num3_02 ).

  WRITE : / 'num1# num2# num3## ##.'.

ELSE.

   WRITE : / 'num1# num2# num3## ## ##.'.

ENDIF.



WRITE : / '3# - ELSE## WRITE# ##'.

DATA : num1_03 TYPE I VALUE 100,

       num2_03 TYPE I VALUE 120.



IF num1_03 > num2_03.

  WRITE : / 'num1# num2## ##.'.

ELSE.

  WRITE : / 'num2# num1## ##'.

ENDIF.



WRITE : / '4# - num1, num2, num3 ## ### #### WRITE# ##'.

DATA : num1_04 TYPE I VALUE 100,

       num2_04 TYPE I VALUE 120,

       num3_04 TYPE I VALUE 10.



IF num2_04 > num1_04 AND num2_04 > num3_04.

  WRITE : / 'num2_04# ## # ####.'.

ENDIF.