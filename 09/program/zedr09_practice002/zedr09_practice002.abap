
*&---------------------------------------------------------------------*

*& Report ZEDR09_PRACTICE002

*&---------------------------------------------------------------------*

*&

*&---------------------------------------------------------------------*




REPORT ZEDR09_PRACTICE002.






*===============================================================*

* ###/## ###

*===============================================================*

* ##### ###### ##




DATA: BEGIN OF GS_ZEDT001,

         ZCODE   TYPE C LENGTH 10,    "####

         ZPERNR  TYPE C LENGTH 10,    "####

         ZKNAME  TYPE C LENGTH 20,    "####

         ZENAME  TYPE C LENGTH 20,    "####

         ZGENDER TYPE C LENGTH 1,     "##

         ZTEL    TYPE C LENGTH 20,    "####

       END OF GS_ZEDT001.

DATA : GT_ZEDT001 LIKE TABLE OF GS_ZEDT001.






* #####-#### ###### ##




DATA: BEGIN OF GS_ZEDT002,

         ZCODE   TYPE C LENGTH 10,    "####

         ZPERNR  TYPE C LENGTH 10,    "####

         ZMAJOR  TYPE C LENGTH 5,     "##

         ZMNAME  TYPE C LENGTH 30,    "###

         ZMGUBUN TYPE C LENGTH 1,     "####

         ZSUM     TYPE P DECIMALS 2,   "###

         ZWAERS  TYPE C LENGTH 3,     "##

       END OF GS_ZEDT002.

DATA : GT_ZEDT002 LIKE TABLE OF GS_ZEDT002.






* ####### ###### ##




DATA: BEGIN OF GS_ZEDT004,

         ZCODE    TYPE C LENGTH 10,   "####

         ZPERNR   TYPE C LENGTH 10,   "####

         ZSCHOOL  TYPE C LENGTH 1,    "####

         ZSEM     TYPE C LENGTH 1,    "####

         ZEXAM    TYPE C LENGTH 1,    "####

         ZMAJOR   TYPE C LENGTH 5,    "##

         ZMNAME   TYPE C LENGTH 30,   "###

         ZSUM     TYPE P DECIMALS 2,  "### ####

         ZWAERS   TYPE C LENGTH 3,    "##

         ZGRADE   TYPE C LENGTH 1,    "## (A~F)

       END OF GS_ZEDT004.

DATA : GT_ZEDT004 LIKE TABLE OF GS_ZEDT004.






* ##### ###### ##




DATA : BEGIN OF GS_PRINT,

  ZCODE TYPE C LENGTH 10, "####

  ZKNAME TYPE C LENGTH 10, "####

  IS_TRANSFER TYPE C LENGTH 10, "####

  ZTEL TYPE C LENGTH 20, "####

  WARN TYPE C LENGTH 10, "####

 END OF GS_PRINT.

DATA : GT_PRINT LIKE TABLE OF GS_PRINT.






* ## ### ### ###### ##




DATA: BEGIN OF GS_TOTAL_BY_GENDER,

        ZGENDER TYPE C LENGTH 1,

        ZSUM    TYPE P DECIMALS 2,

      END OF GS_TOTAL_BY_GENDER.

DATA: GT_TOTAL_BY_GENDER LIKE TABLE OF GS_TOTAL_BY_GENDER.






* ## ##




DATA : GV_SUM_BY_M TYPE I. "### ###

DATA : GV_SUM_BY_F TYPE I. "### ###








*===============================================================*

* SELECT### ZEDT00_001, ZEDT00_002, ZEDT00_004 ###### ### ####

*===============================================================*

* #### ####




SELECT * FROM ZEDT00_001

INTO CORRESPONDING FIELDS OF TABLE GT_ZEDT001.



SELECT * FROM ZEDT00_002

INTO CORRESPONDING FIELDS OF TABLE GT_ZEDT002.



SELECT * FROM ZEDT00_004

INTO CORRESPONDING FIELDS OF TABLE GT_ZEDT004.





CLEAR : GS_PRINT.



SORT GT_ZEDT004 BY ZCODE ZGRADE DESCENDING. "####### ##, # #### ## ### ## ## ## ##

DELETE ADJACENT DUPLICATES FROM GT_ZEDT004 COMPARING ZCODE. "ZCODE### ####, ## ## ### ###








*===============================================================*

* LOOP# : ### ### ##

*===============================================================*




CLEAR : GS_ZEDT004.

LOOP AT GT_ZEDT004 INTO GS_ZEDT004.

  CHECK GS_ZEDT004-ZGRADE IS NOT INITIAL. "CHECK, ## #### ### pass



  MOVE-CORRESPONDING GS_ZEDT004 TO GS_ZEDT002.

  MOVE-CORRESPONDING GS_ZEDT004 TO GS_ZEDT001.



  "GT_ZEDT001## ZCODE, ZKNAME, ZTEL## ####

  READ TABLE GT_ZEDT001 WITH KEY ZCODE = GS_ZEDT004-ZCODE INTO GS_ZEDT001.

  IF sy-subrc = 0.

     MOVE GS_ZEDT001-ZCODE TO GS_PRINT-ZCODE.

     MOVE GS_ZEDT001-ZKNAME TO GS_PRINT-ZKNAME.

  ENDIF.



  " #### ##

  READ TABLE GT_ZEDT002 WITH KEY ZCODE = GS_ZEDT004-ZCODE INTO GS_ZEDT002 COMPARING ZMAJOR.

  IF sy-subrc = 2.

    GS_PRINT-IS_TRANSFER = '####'. "## ####, ####

  ENDIF.



  "#### : ## ### D ## F#,

  " 1) #### ## & 2) #### ##

  IF GS_ZEDT004-ZGRADE = 'D' OR GS_ZEDT004-ZGRADE = 'F'.

    GS_PRINT-WARN = '####'.

    GS_PRINT-ZTEL = GS_ZEDT001-ZTEL.

  ENDIF.



  "COLLECT# ### ### ## ##

  CLEAR : GS_TOTAL_BY_GENDER.

  IF GS_ZEDT001-ZGENDER IS NOT INITIAL.

    MOVE GS_ZEDT001-ZGENDER TO GS_TOTAL_BY_GENDER-ZGENDER.

    MOVE GS_ZEDT004-ZSUM TO GS_TOTAL_BY_GENDER-ZSUM.

    COLLECT GS_TOTAL_BY_GENDER INTO GT_TOTAL_BY_GENDER.

  ENDIF.



  APPEND GS_PRINT TO GT_PRINT.

  CLEAR : GS_ZEDT004, GS_ZEDT001, GS_ZEDT002, GS_PRINT.

ENDLOOP.








*===============================================================*

* WRITE### ## ##

*===============================================================*




CLEAR : GS_PRINT.

LOOP AT GT_PRINT INTO GS_PRINT.



  "### ## ###

  AT FIRST.

    WRITE : / sy-uline(74)."## #####(sy-uline)# #### ## ##

    " sy-vline# ###(|)# #### #####, ()## # ## #### ##

    WRITE: / sy-vline, (10) ' #### ' CENTERED, sy-vline , (13) ' ##  ' CENTERED, sy-vline, (10) '  ####  ' CENTERED, sy-vline, (15) '  ####  ' CENTERED, sy-vline, (10) ' ## ' CENTERED, sy-vline.

    WRITE : / sy-uline(74).

  ENDAT.



  "### ## ###

  WRITE : / sy-vline, (10) GS_PRINT-ZCODE CENTERED, sy-vline, (13) GS_PRINT-ZKNAME CENTERED, sy-vline, (10) GS_PRINT-IS_TRANSFER CENTERED, sy-vline, (15) GS_PRINT-ZTEL CENTERED, sy-vline, (10) GS_PRINT-WARN CENTERED, sy-vline.

  WRITE : / sy-uline(74).



  AT LAST. "### #### ##### #### ####

    READ TABLE GT_TOTAL_BY_GENDER INTO GS_TOTAL_BY_GENDER INDEX 1.

    GV_SUM_BY_M = GS_TOTAL_BY_GENDER-ZSUM * 100.



    IF sy-subrc = 0.

      WRITE : / '###### : ', GV_SUM_BY_M.

    ELSE.

      WRITE : / , 'GT_TOTAL_BY_GEDNER## ###### ## #####.'.

    ENDIF.



    READ TABLE GT_TOTAL_BY_GENDER INTO GS_TOTAL_BY_GENDER INDEX 2.

    GV_SUM_BY_F = GS_TOTAL_BY_GENDER-ZSUM * 100.



    IF sy-subrc = 0.

      WRITE : / '###### : ', GV_SUM_BY_F.

    ELSE.

      WRITE : / , 'GT_TOTAL_BY_GEDNER## ###### ## #####.'.

    ENDIF.

  ENDAT.

ENDLOOP.