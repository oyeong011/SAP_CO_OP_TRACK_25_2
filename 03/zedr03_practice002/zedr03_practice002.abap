
REPORT ZEDR03_PRACTICE002.



"1. ## ##

"### ### ##

DATA : GS_ZEDT001 TYPE ZEDT03_001.

DATA : GS_ZEDT002 TYPE ZEDT03_002.

DATA : GS_ZEDT004 TYPE ZEDT03_004.

DATA : GT_ZEDT001 LIKE TABLE OF ZEDT03_001.

DATA : GT_ZEDT002 LIKE TABLE OF ZEDT03_002.

DATA : GT_ZEDT004 LIKE TABLE OF ZEDT03_004.



"### ### ##

DATA : BEGIN OF GS_WRITE,

  ZCODE TYPE ZEDT03_001-ZCODE,

  ZKNAME TYPE ZEDT03_001-ZKNAME,

  ZCHANGE TYPE C LENGTH 20,

  ZTEL TYPE ZEDT03_001-ZTEL,

  ZWARNING TYPE C LENGTH 20,

  END OF GS_WRITE.

DATA : GT_WRITE LIKE TABLE OF GS_WRITE.



"### ## ## ## ##

DATA : GV_MSUM TYPE I.

DATA : GV_FSUM TYPE I.

CONSTANTS : GV_K TYPE I VALUE 100.



"### ### ####

SELECT * FROM ZEDT03_001

INTO CORRESPONDING FIELDS OF TABLE GT_ZEDT001.

SELECT * FROM ZEDT03_002

INTO CORRESPONDING FIELDS OF TABLE GT_ZEDT002.

SELECT * FROM ZEDT03_004

INTO CORRESPONDING FIELDS OF TABLE GT_ZEDT004.



"### # ## # ## ## ###

SORT GT_ZEDT004 BY ZCODE ASCENDING ZGRADE DESCENDING.

DELETE ADJACENT DUPLICATES FROM GT_ZEDT004 COMPARING ZCODE.



"2. ## LOOP

CLEAR : GS_ZEDT004.

LOOP AT GT_ZEDT004 INTO GS_ZEDT004.

   CLEAR : GS_WRITE, GS_ZEDT001, GS_ZEDT002.



   "### ## ### CONTINUE. (## ## ### # ### ## ## ## # ## #)

   IF GS_ZEDT004-ZGRADE = ' '.

     CONTINUE.

   ENDIF.



   "## ## ##### ##

   IF ( GS_ZEDT004-ZGRADE = 'D' ) OR ( GS_ZEDT004-ZGRADE = 'F' ).

     GS_WRITE-ZWARNING = '####'.

   ENDIF.



   "## #### READ# ## ##

   MOVE-CORRESPONDING GS_ZEDT004 TO GS_ZEDT002.

   READ TABLE GT_ZEDT002 WITH KEY ZCODE = GS_ZEDT004-ZCODE INTO GS_ZEDT002  COMPARING ZMNAME.

   IF SY-SUBRC = 0.

   ELSE.

     GS_WRITE-ZCHANGE = '  ####'.

   ENDIF.



   "###, ### ## ### ##

   READ TABLE GT_ZEDT001 WITH KEY ZCODE = GS_ZEDT004-ZCODE INTO GS_ZEDT001.

   IF GS_ZEDT001-ZGENDER = 'M'.

     GV_MSUM = GV_MSUM + GS_ZEDT004-ZSUM.

   ELSE.

     GV_FSUM = GV_FSUM + GS_ZEDT004-ZSUM.

   ENDIF.





  "#### ### ### ####

   MOVE-CORRESPONDING GS_ZEDT001 TO GS_WRITE.



  "###### ### #### #### ### CLEAR

   IF GS_WRITE-ZWARNING NE '####'.

     CLEAR : GS_WRITE-ZTEL.

   ENDIF.



   "### #### # ####

   APPEND GS_WRITE TO GT_WRITE.

ENDLOOP.





"3. ## LOOP

LOOP AT GT_WRITE INTO GS_WRITE.

  AT FIRST.

    WRITE :/ '------------------------------------------------------------------------------------------------------'.

    WRITE :/ '|  ####  |         ##         |   ####           |     ####     |    ##              |'.

    WRITE :/ '------------------------------------------------------------------------------------------------------'.

  ENDAT.





  WRITE :/ '|', GS_WRITE-ZCODE, '|', GS_WRITE-ZKNAME,'|',GS_WRITE-ZCHANGE,'|', GS_WRITE-ZTEL, '|',GS_WRITE-ZWARNING,'|'.

  WRITE :/ '------------------------------------------------------------------------------------------------------'.

ENDLOOP.

"KRW# ##

GV_MSUM = GV_MSUM * GV_K.

GV_FSUM = GV_FSUM * GV_K.

WRITE :/ '###### :' , GV_MSUM.

WRITE :/ '###### :' , GV_FSUM.