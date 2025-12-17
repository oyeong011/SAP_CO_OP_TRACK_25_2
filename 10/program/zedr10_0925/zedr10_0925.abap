
*&---------------------------------------------------------------------*

*& Report ZEDR10_0925

*&---------------------------------------------------------------------*

*&

*&---------------------------------------------------------------------*




REPORT ZEDR10_0925.



DATA: BEGIN OF GS_STUDENT.

  include structure
ZEDT10_001
.

DATA: END OF GS_STUDENT.



DATA: GT_STUDENT LIKE TABLE OF GS_STUDENT,

      GV_ZKNAME LIKE ZEDT10_001-ZKNAME,

      GV_ZCODE LIKE ZEDT10_001-ZCODE,

      GV_FLAG,

      GV_LAST_NUM TYPE N LENGTH 2 VALUE '00',

      GV_DUMP_INIT_INDEX TYPE N LENGTH 2 VALUE '00'

      .



SELECTION-SCREEN BEGIN OF BLOCK B1.

  PARAMETERS: P_ZCODEN TYPE N LENGTH 2 DEFAULT '01'.

SELECTION-SCREEN END OF BLOCK B1.



CONCATENATE 'SSU-' P_ZCODEN INTO GV_ZCODE.



PERFORM HELL_O USING GV_ZCODE.



PERFORM GET_DATA USING    GV_ZCODE

                 CHANGING GV_ZKNAME. " USING# CHANGING# ### ### ### #### # ##.



WRITE:/ GV_ZCODE.

WRITE:/ GV_ZKNAME.



" PARAMETER INTERNAL TABLE

GS_STUDENT-ZCODE = GV_ZCODE.

PERFORM GET_DATA_FROM_STRUCT USING    GS_STUDENT

                             CHANGING GT_STUDENT.



PERFORM PRINT_TABLE USING GT_STUDENT.




*LOOP AT GT_STUDENT INTO GS_STUDENT.

*  WRITE:/ GS_STUDENT-ZCODE, GS_STUDENT-ZKNAME.

*ENDLOOP.






PERFORM GET_DATA_TO_TABLE USING GT_STUDENT.



PERFORM PRINT_TABLE USING GT_STUDENT.



SELECT SINGLE * FROM ZEDT10_001

  INTO GS_STUDENT WHERE ZCODE = 'SSU-01'.



PERFORM CREATE_DUMP CHANGING GS_STUDENT GV_DUMP_INIT_INDEX GV_LAST_NUM.



PERFORM DELETE_DUMP USING GV_DUMP_INIT_INDEX.




*&---------------------------------------------------------------------*

*&      Form  GET_DATA

*&---------------------------------------------------------------------*

*       text

*----------------------------------------------------------------------*

*  -->  p1        text

*  <--  p2        text

*----------------------------------------------------------------------*




FORM GET_DATA USING    value(P_ZCODE) LIKE GV_ZCODE

              CHANGING P_ZKNAME       LIKE GV_ZKNAME.



  " VALUE ### FORM ### ### ## ### ##.



  DATA: LV_ZCODE LIKE ZEDT00_001-ZCODE.



  SELECT SINGLE ZKNAME FROM ZEDT10_001

    INTO P_ZKNAME

    WHERE ZCODE = P_ZCODE.

ENDFORM.






*&---------------------------------------------------------------------*

*&      Form  GET_DATA_S

*&---------------------------------------------------------------------*

*       text

*----------------------------------------------------------------------*

*      -->PS_STUDENT  text

*      -->PT_STUDENT  text

*----------------------------------------------------------------------*




FORM GET_DATA_FROM_STRUCT  USING     PS_STUDENT STRUCTURE GS_STUDENT

                           CHANGING  PT_STUDENT LIKE GT_STUDENT.






*  PS_STUDENT-ZCODE = 'SSU-01'.






  SELECT SINGLE ZKNAME FROM ZEDT10_001

    INTO PS_STUDENT-ZKNAME

    WHERE ZCODE = PS_STUDENT-ZCODE.



  APPEND PS_STUDENT TO PT_STUDENT.



  SELECT SINGLE ZKNAME FROM ZEDT10_001

    INTO PS_STUDENT-ZKNAME

    WHERE ZCODE = PS_STUDENT.



  APPEND PS_STUDENT TO PT_STUDENT.



ENDFORM.






*&---------------------------------------------------------------------*

*&      Form  GET_DATA_TO_TABLE

*&---------------------------------------------------------------------*

*       text

*----------------------------------------------------------------------*

*      -->P_GT_STUDENT  text

*----------------------------------------------------------------------*




FORM GET_DATA_TO_TABLE  CHANGING    PT_STUDENT LIKE GT_STUDENT.






*  RANGES LR_STUDENT FOR GT_STUDENT-ZCODE.



*  LR_STUDENT-SIGN.






  SELECT ZCODE ZKNAME FROM ZEDT10_001

    INTO TABLE PT_STUDENT

    .

ENDFORM.





AT SELECTION-SCREEN OUTPUT.

LOOP AT SCREEN.

  IF SCREEN-NAME = 'P_ZCODE'.

    SCREEN-REQUIRED = '1'.

  ENDIF.

  MODIFY SCREEN.

ENDLOOP.



" ### ### ###.

include
zedr10_0925_hell_of01
.




*&---------------------------------------------------------------------*

*&      Form  PRINT_TABLE

*&---------------------------------------------------------------------*

*       text

*----------------------------------------------------------------------*

*      -->P_GT_STUDENT  text

*----------------------------------------------------------------------*




FORM PRINT_TABLE  USING    VALUE(PT_STUDENT) LIKE GT_STUDENT.

  DATA: PS_STUDENT LIKE ZEDT10_001.

  LOOP AT PT_STUDENT INTO PS_STUDENT.

    WRITE:/ PS_STUDENT-ZCODE, PS_STUDENT-ZKNAME.

  ENDLOOP.

ENDFORM.




*&---------------------------------------------------------------------*

*&      Form  DELETE_DATA

*&---------------------------------------------------------------------*

*       text

*----------------------------------------------------------------------*

*      -->P_GS_STUDENT  text

*----------------------------------------------------------------------*




FORM DELETE_DATA  USING    PS_STUDENT.

  DELETE ZEDT10_001 FROM PS_STUDENT.

  IF SY-SUBRC = 0.

    GV_FLAG = 'X'.

  ENDIF.

ENDFORM.




*&---------------------------------------------------------------------*

*&      Form  CREATE_DUMP

*&---------------------------------------------------------------------*

*       Max ## #### ### dump data base# #### #.

*----------------------------------------------------------------------*

*      <--P_GS_STUDENT  text

*      <--P_GV_LAST_ID  text

*----------------------------------------------------------------------*




FORM CREATE_DUMP  CHANGING PS_STUDENT LIKE GS_STUDENT

                           PV_DUMP_INIT_NUM TYPE N

                           PV_LAST_NUM TYPE N.

  " FIND LAST_NUM

  IF PV_LAST_NUM = '00'.

    SELECT MAX( ZPERNR )

      FROM ZEDT10_001

      INTO @DATA(LV_MAX).

    PV_LAST_NUM = LV_MAX.

    PV_DUMP_INIT_NUM = PV_LAST_NUM + 1.

    WRITE:/'MAX_ZPERNR', PV_LAST_NUM.

  ENDIF.



ENDFORM.




*&---------------------------------------------------------------------*

*&      Form  DELETE_DUMP

*&---------------------------------------------------------------------*

*       text

*----------------------------------------------------------------------*

*  -->  p1        text

*  <--  p2        text

*----------------------------------------------------------------------*




FORM DELETE_DUMP USING VALUE(PV_DUMP_INIT) TYPE N.

  DATA: LV_PERN TYPE ZEDT10_001-ZPERNR.

  CONCATENATE 'SSU-' PV_DUMP_INIT INTO LV_PERN.

  DELETE FROM ZEDT10_001 WHERE ZPERNR > LV_PERN.

ENDFORM.