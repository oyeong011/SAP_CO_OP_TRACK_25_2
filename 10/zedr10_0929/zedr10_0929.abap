
*&---------------------------------------------------------------------*

*& Report ZEDR10_0929

*&---------------------------------------------------------------------*

*&

*&---------------------------------------------------------------------*




REPORT ZEDR10_0929 MESSAGE-ID ZEDM10.



WRITE: 'DEBUGGING'.

ULINE:/.



TABLES: ZEDT10_001.



DATA: BEGIN OF GS_STUDENT,

         " ## ###(ZEDT10_001)## ### ##

         zcode    TYPE zedt10_001-zcode,    " ####

         zpernr   TYPE zedt10_001-zpernr,   " ####

         zkname   TYPE zedt10_001-zkname,   " ## ##

         zgender  TYPE zedt10_001-zgender,  " ##

         ztel     TYPE zedt10_001-ztel,     " ####



         " ## ##(ZEDT10_004)## ### ##

         zmajor   TYPE zedt10_004-zmajor,   " ##

         zmname   TYPE zedt10_004-zmname,   " ###

         ZSUM     TYPE zedt10_004-zSUM,  " ### ##

END OF GS_STUDENT.



DATA: GT_STUDENT LIKE TABLE OF GS_STUDENT.



SELECTION-SCREEN BEGIN OF BLOCK B1 WITH FRAME.

  SELECT-OPTIONS: S_ZCODE FOR ZEDT10_001-ZCODE.

  PARAMETERS: P_ZPERNR LIKE ZEDT10_001-ZPERNR,

              P_ZGEN   LIKE ZEDT10_001-ZGENDER.

SELECTION-SCREEN END OF BLOCK B1.



SELECTION-SCREEN BEGIN OF BLOCK B2 WITH FRAME.

  PARAMETERS: p_check AS CHECKBOX MODIF ID sc1.

SELECTION-SCREEN END OF BLOCK B2.



" ### ##

INITIALIZATION.

  S_ZCODE-LOW = 'SSU-01'.

  S_ZCODE-HIGH = 'SSU-99'.

  APPEND S_ZCODE.



AT SELECTION-SCREEN OUTPUT.

  LOOP AT SCREEN.

    IF SCREEN-GROUP1 = 'SC1'.

      SCREEN-REQUIRED = '1'.

    ENDIF.

    MODIFY SCREEN.

  ENDLOOP.



" ## ##

START-OF-SELECTION.

  IF S_ZCODE IS INITIAL.

    MESSAGE I000.

  ENDIF.



  PERFORM GET_DATA.



  IF GT_STUDENT IS INITIAL.

    MESSAGE I001.

    EXIT.

  ENDIF.



END-OF-SELECTION.

  PERFORM WRITE_DATA.




*&---------------------------------------------------------------------*

*&      Form  GET_DATA

*&---------------------------------------------------------------------*

*       text

*----------------------------------------------------------------------*

*  -->  p1        text

*  <--  p2        text

*----------------------------------------------------------------------*




FORM GET_DATA .

  IF P_ZGEN IS INITIAL.

    SELECT

      a~zcode a~zpernr a~zkname a~zgender A~ZTEL

      B~zmajor SUM( b~ZSUM ) AS ZSUM

      INTO CORRESPONDING FIELDS OF TABLE GT_STUDENT

      FROM ZEDT10_001 AS A

      INNER JOIN ZEDT10_004 AS B

      ON A~ZCODE = B~ZCODE AND A~ZPERNR = B~ZPERNR

      WHERE A~ZCODE IN S_ZCODE

      GROUP BY

      a~zcode a~zpernr a~zkname a~zgender A~ZTEL

      B~zmajor.



  ELSE.



    SELECT

      a~zcode a~zpernr a~zkname a~zgender A~ZTEL

      B~zmajor SUM( b~ZSUM ) AS ZSUM

      INTO CORRESPONDING FIELDS OF TABLE GT_STUDENT

      FROM ZEDT10_001 AS A

      INNER JOIN ZEDT10_004 AS B

      ON A~ZCODE = B~ZCODE AND A~ZPERNR = B~ZPERNR

      WHERE A~ZCODE IN S_ZCODE

      AND   A~ZGENDER = P_ZGEN

      GROUP BY

      a~zcode a~zpernr a~zkname a~zgender A~ZTEL

      B~zmajor.

  ENDIF.



  DATA: LV_S LIKE GS_STUDENT.

  LOOP AT GT_STUDENT INTO LV_S.

    CASE LV_S-ZMAJOR.

      WHEN 'A'.

        LV_S-ZMNAME = '####'.

      WHEN 'B'.

        LV_S-ZMNAME = '####'.

      WHEN 'C'.

        LV_S-ZMNAME = '###'.

      WHEN 'D'.

        LV_S-ZMNAME = '#####'.

      WHEN 'E'.

        LV_S-ZMNAME = '#####'.

      WHEN 'F'.

        LV_S-ZMNAME = '###'.

      WHEN 'G'.

        LV_S-ZMNAME = '###'.

      WHEN 'H'.

        LV_S-ZMNAME = '###'.

    ENDCASE.

    MODIFY GT_STUDENT FROM LV_S

      TRANSPORTING ZMNAME

      WHERE ZCODE = LV_S-ZCODE.

  ENDLOOP.



ENDFORM.




*&---------------------------------------------------------------------*

*&      Form  WRITE_DATA

*&---------------------------------------------------------------------*

*       text

*----------------------------------------------------------------------*

*  -->  p1        text

*  <--  p2        text

*----------------------------------------------------------------------*




FORM WRITE_DATA.



  IF GT_STUDENT IS INITIAL.

    MESSAGE '### #### ####.' TYPE 'I'.

    RETURN.

  ENDIF.



  LOOP AT gt_student INTO gs_student.

    WRITE: / gs_student-zcode,

            15 gs_student-zpernr,

            30 gs_student-zkname,

            50 gs_student-zmname,

            90 gs_student-zsum.

  ENDLOOP.



ENDFORM.








*Messages

*----------------------------------------------------------

*

* Message class: Hard coded

*   ### #### ####.