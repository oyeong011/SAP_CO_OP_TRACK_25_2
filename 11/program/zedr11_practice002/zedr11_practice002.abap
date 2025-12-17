
*&---------------------------------------------------------------------*

*& Report ZEDR11_PRACTICE002

*&---------------------------------------------------------------------*




REPORT ZEDR11_PRACTICE002.






*----------------------------------------------------------------------

* 0) ##/##/### ##

*----------------------------------------------------------------------




CONSTANTS: C_RANK_A TYPE I VALUE 6,     " A (## ##)

           C_RANK_B TYPE I VALUE 5,     " B

           C_RANK_C TYPE I VALUE 4,     " C

           C_RANK_D TYPE I VALUE 3,     " D (## ##)

           C_RANK_F TYPE I VALUE 1.     " F (## ##)



CONSTANTS: C_SCALE  TYPE I VALUE 100.   " 100.00 # 10000 ###



" ## ### ####

DATA: GT_ZEDT001 TYPE TABLE OF ZEDT11_001,   " ##,###

      GT_ZEDT002 TYPE TABLE OF ZEDT11_002,   " ## ##

      GT_ZEDT004 TYPE TABLE OF ZEDT11_004.   " ##,###



" #### GS###

DATA: GS_ZEDT001 TYPE ZEDT11_001,

      GS_ZEDT002 TYPE ZEDT11_002,

      GS_ZEDT004 TYPE ZEDT11_004.



" ##/## ##

TYPES: BEGIN OF TY_WRITE,

         ZCODE  TYPE ZEDT11_001-ZCODE,

         ZKNAME TYPE ZEDT11_001-ZKNAME,

         ZCHG   TYPE C LENGTH 10, " ####

         ZTEL   TYPE ZEDT11_001-ZTEL," #### ##

         ZMEMO  TYPE C LENGTH 10," ####

       END OF TY_WRITE.



TYPES: BEGIN OF TY_SUM,

         ZGENDER TYPE ZEDT11_001-ZGENDER," ##(#)

         ZSUM_I  TYPE I, " ## ##(##)

       END OF TY_SUM.



DATA: GT_WRITE TYPE TABLE OF TY_WRITE,

      GS_WRITE TYPE TY_WRITE.



DATA: GT_SUM TYPE TABLE OF TY_SUM, " ## ###

      GS_SUM TYPE TY_SUM.



" ## ### ####(## ##,##,##)

DATA: GV_CURR_CODE   TYPE ZEDT11_004-ZCODE,

      GV_RANK_WORST  TYPE I,

      GV_GRADE_WORST TYPE ZEDT11_004-ZGRADE,

      GV_SUM_WORST_I TYPE I,

      GV_MAJOR_004   TYPE ZEDT11_004-ZMAJOR.



DATA: LV_RANK   TYPE I,

      LV_MALE   TYPE I, "## ##

      LV_FEMALE TYPE I.






*----------------------------------------------------------------------

* 1) ### ## (#### # SELECT ###)

*----------------------------------------------------------------------




SELECT * FROM ZEDT11_001

  INTO CORRESPONDING FIELDS OF TABLE GT_ZEDT001.



SELECT * FROM ZEDT11_002

  INTO CORRESPONDING FIELDS OF TABLE GT_ZEDT002.



SELECT * FROM ZEDT11_004

  INTO CORRESPONDING FIELDS OF TABLE GT_ZEDT004.






*----------------------------------------------------------------------

* 2) ##

*----------------------------------------------------------------------




SORT GT_ZEDT004 BY ZCODE ZPERNR ZSEM ZEXAM.






*----------------------------------------------------------------------

* 3) ## LOOP (# ## LOOP)

*----------------------------------------------------------------------




LOOP AT GT_ZEDT004 INTO GS_ZEDT004.



  AT NEW ZCODE.

    CLEAR: GV_RANK_WORST, GV_GRADE_WORST, GV_SUM_WORST_I, GV_MAJOR_004. "### ###

    GV_CURR_CODE = GS_ZEDT004-ZCODE.

  ENDAT.



  " ## # ## ####

  CLEAR LV_RANK.

  CASE GS_ZEDT004-ZGRADE.

    WHEN 'A'. LV_RANK = C_RANK_A.

    WHEN 'B'. LV_RANK = C_RANK_B.

    WHEN 'C'. LV_RANK = C_RANK_C.

    WHEN 'D'. LV_RANK = C_RANK_D.

    WHEN 'F'. LV_RANK = C_RANK_F.

    WHEN OTHERS. LV_RANK = C_RANK_A.

  ENDCASE.



  " ## ## ##(# #### ## #)

  IF GV_RANK_WORST = 0 OR LV_RANK < GV_RANK_WORST.

    GV_RANK_WORST  = LV_RANK.

    GV_GRADE_WORST = GS_ZEDT004-ZGRADE.

    GV_SUM_WORST_I = GS_ZEDT004-ZSUM * C_SCALE.  " 100.00 # 10000

    GV_MAJOR_004   = GS_ZEDT004-ZMAJOR.          " # ## ## ##

  ENDIF.



  AT END OF ZCODE.





    READ TABLE GT_ZEDT001 INTO GS_ZEDT001 WITH KEY ZCODE = GV_CURR_CODE.

    IF SY-SUBRC <> 0.

      CONTINUE.

    ENDIF.



    "## ## ##(READ COMPARING)

    CLEAR GS_ZEDT002.

    GS_ZEDT002-ZMAJOR = GV_MAJOR_004.            " #### ## ##



    READ TABLE GT_ZEDT002 INTO GS_ZEDT002 WITH KEY ZCODE = GV_CURR_CODE COMPARING ZMAJOR.



    DATA LV_CHANGED TYPE C VALUE ' '.

    IF SY-SUBRC = 0.

      LV_CHANGED = ' '." ## ## # ## ##

    ELSE.

      LV_CHANGED = 'X'. "

    ENDIF.



    "## # ##

    CLEAR GS_WRITE.

    GS_WRITE-ZCODE  = GV_CURR_CODE.

    GS_WRITE-ZKNAME = GS_ZEDT001-ZKNAME.

    IF LV_CHANGED = 'X'.

      GS_WRITE-ZCHG = '####'.

    ENDIF.



    "D/F ## # #### + #### ##

    IF GV_GRADE_WORST = 'D' OR GV_GRADE_WORST = 'F'.

      GS_WRITE-ZMEMO = '####'.

      GS_WRITE-ZTEL  = GS_ZEDT001-ZTEL.

    ENDIF.



    APPEND GS_WRITE TO GT_WRITE.



    "## ##(COLLECT)

    CLEAR GS_SUM.

    GS_SUM-ZGENDER = GS_ZEDT001-ZGENDER.    " ## ### ##

    GS_SUM-ZSUM_I  = GV_SUM_WORST_I.        " ## ##

    COLLECT GS_SUM INTO GT_SUM.



  ENDAT.



ENDLOOP.






*----------------------------------------------------------------------

* 4) ## LOOP (# ## LOOP)

*----------------------------------------------------------------------






LOOP AT GT_WRITE INTO GS_WRITE.



  AT FIRST.

    WRITE: '----------------------------------------------------------------------------------'.

    WRITE: / '|  ####    |     ##     |   ####   |     ####       |     ##     |'.

    WRITE: / '----------------------------------------------------------------------------------'.

  ENDAT.



  WRITE: / '| ', GS_WRITE-ZCODE, ' | ',

           GS_WRITE-ZKNAME, ' | ',

           GS_WRITE-ZCHG, ' | ',

           GS_WRITE-ZTEL, ' | ',

           GS_WRITE-ZMEMO, ' |'.

  WRITE: / '----------------------------------------------------------------------------------'.



  AT LAST.

    " #/# ## ##(### 0)

    CLEAR: LV_MALE, LV_FEMALE, GS_SUM.



    READ TABLE GT_SUM INTO GS_SUM WITH KEY ZGENDER = 'M'.

    IF SY-SUBRC = 0.

      LV_MALE = GS_SUM-ZSUM_I.

    ENDIF.



    CLEAR GS_SUM.

    READ TABLE GT_SUM INTO GS_SUM WITH KEY ZGENDER = 'F'.

    IF SY-SUBRC = 0.

      LV_FEMALE = GS_SUM-ZSUM_I.

    ENDIF.



    SKIP.

    WRITE: / '###  ### : ', LV_MALE.

    WRITE: / '###  ### : ', LV_FEMALE.

  ENDAT.



ENDLOOP.