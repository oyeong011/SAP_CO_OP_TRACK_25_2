
*&---------------------------------------------------------------------*

*& Report ZEDR21_PRACTICE002

*&---------------------------------------------------------------------*




REPORT ZEDR21_PRACTICE002.



"----------------------------------------------------------

" DATA ##

"----------------------------------------------------------

DATA : GT_ZEDT21_001 LIKE TABLE OF ZEDT21_001,

       GT_ZEDT21_002 LIKE TABLE OF ZEDT21_002,

       GT_ZEDT21_004 LIKE TABLE OF ZEDT21_004.



DATA : GS_ZEDT21_001 TYPE ZEDT21_001,

       GS_ZEDT21_002 TYPE ZEDT21_002,

       GS_ZEDT21_004 TYPE ZEDT21_004.



" ## ## ##

DATA : GV_WORST_RANK  TYPE i,

       GV_CURR_MAJOR  TYPE ZEDT21_004-ZMAJOR21,

       GV_WARN_FLAG   TYPE c LENGTH 1,

       GV_MAJOR_FLAG  TYPE c LENGTH 1.



" ## ###/###

DATA : BEGIN OF GS_WRITE,

         ZCODE21  LIKE ZEDT21_001-ZCODE21,

         ZKNAME21 LIKE ZEDT21_001-ZKNAME21,

         ZCHG     TYPE c LENGTH 10,     " ####

         ZTEL21   LIKE ZEDT21_001-ZTEL21, " ### ####

         ZWARN    TYPE c LENGTH 10,     " ####

       END OF GS_WRITE.



DATA : GT_WRITE LIKE TABLE OF GS_WRITE.



"----------------------------------------------------------

" ### ####

"----------------------------------------------------------

SELECT * FROM ZEDT21_001 INTO TABLE GT_ZEDT21_001.

SELECT * FROM ZEDT21_002 INTO TABLE GT_ZEDT21_002.

SELECT * FROM ZEDT21_004 INTO TABLE GT_ZEDT21_004.



" ## # ## ##

SORT GT_ZEDT21_001 BY ZCODE21.

DELETE ADJACENT DUPLICATES FROM GT_ZEDT21_001 COMPARING ZCODE21.



SORT GT_ZEDT21_002 BY ZCODE21.

DELETE ADJACENT DUPLICATES FROM GT_ZEDT21_002 COMPARING ZCODE21.



SORT GT_ZEDT21_004 BY ZCODE21 ZPERNR21 ZSEM21 ZEXAM21.

DELETE ADJACENT DUPLICATES FROM GT_ZEDT21_004 COMPARING ZCODE21 ZPERNR21 ZSEM21 ZEXAM21.



CLEAR: GS_ZEDT21_001, GS_ZEDT21_002, GS_ZEDT21_004.



"----------------------------------------------------------

" ## LOOP (### ## ##)

"----------------------------------------------------------

LOOP AT GT_ZEDT21_004 INTO GS_ZEDT21_004.



  AT NEW ZCODE21.

    GV_WORST_RANK = 9999.

    CLEAR: GV_CURR_MAJOR, GV_WARN_FLAG, GV_MAJOR_FLAG.



    " ## #### ##

    READ TABLE GT_ZEDT21_001 INTO GS_ZEDT21_001

         WITH KEY ZCODE21 = GS_ZEDT21_004-ZCODE21.

  ENDAT.



  " ## # ## ## (SWITCH)

  DATA(lv_rank) = SWITCH i( GS_ZEDT21_004-ZGRADE21

                              WHEN 'A' THEN 6

                              WHEN 'B' THEN 5

                              WHEN 'C' THEN 4

                              WHEN 'D' THEN 3

                              WHEN 'F' THEN 1

                              ELSE 6 ).



  " ## ## ##

  IF lv_rank < GV_WORST_RANK.

    GV_WORST_RANK = lv_rank.

  ENDIF.



  " ###(D/F ### ###)

  IF GS_ZEDT21_004-ZGRADE21 = 'D' OR GS_ZEDT21_004-ZGRADE21 = 'F'.

    GV_WARN_FLAG = 'X'.

  ENDIF.



  " ## ## # ### ## ## ##

  GV_CURR_MAJOR = GS_ZEDT21_004-ZMAJOR21.



  AT END OF ZCODE21.

    " ## ## ##

    READ TABLE GT_ZEDT21_002 INTO GS_ZEDT21_002

         WITH KEY ZCODE21 = GS_ZEDT21_004-ZCODE21.



    " ## ## ##

    IF sy-subrc = 0 AND GS_ZEDT21_002-ZMAJOR21 <> GV_CURR_MAJOR.

      GV_MAJOR_FLAG = 'X'.

    ELSE.

      GV_MAJOR_FLAG = ' '.

    ENDIF.



    " ## # ##

    CLEAR GS_WRITE.

    GS_WRITE-ZCODE21  = GS_ZEDT21_004-ZCODE21.

    GS_WRITE-ZKNAME21 = GS_ZEDT21_001-ZKNAME21.



    IF GV_MAJOR_FLAG = 'X'.

      GS_WRITE-ZCHG = '####'.

    ENDIF.



    IF GV_WARN_FLAG = 'X'.

      GS_WRITE-ZWARN  = '####'.

      GS_WRITE-ZTEL21 = GS_ZEDT21_001-ZTEL21. " #### #### ##

    ENDIF.



    APPEND GS_WRITE TO GT_WRITE.

  ENDAT.



ENDLOOP.



SORT GT_WRITE BY ZCODE21.



"----------------------------------------------------------

" ## LOOP (# ##)

"----------------------------------------------------------

LOOP AT GT_WRITE INTO GS_WRITE.

  AT FIRST.

    WRITE :/ '------------------------------------------------------------------------------------'.

    WRITE :/ '|  ####  |         ##      |   ####     |     ####      |    ##    |'.

    WRITE :/ '------------------------------------------------------------------------------------'.

  ENDAT.



  WRITE :/ '|', (10) GS_WRITE-ZCODE21,

           '|', (17) GS_WRITE-ZKNAME21,

           '|', (14) GS_WRITE-ZCHG,

           '|', (17) GS_WRITE-ZTEL21,

           '|', (10) GS_WRITE-ZWARN, '|'.



 WRITE :/ '------------------------------------------------------------------------------------'.

ENDLOOP.