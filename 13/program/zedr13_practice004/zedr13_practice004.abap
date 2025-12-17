
*&---------------------------------------------------------------------*

*& Report ZEDR13_PRACTICE004

*&---------------------------------------------------------------------*

*&

*&---------------------------------------------------------------------*




REPORT ZEDR13_PRACTICE004.



DATA : GS_STUDENT TYPE ZEDT13_001,

       GT_STUDENT LIKE TABLE OF GS_STUDENT.



RANGES : GR_ZCODE FOR ZEDT13_001-ZCODE.



CLEAR GR_ZCODE.

GR_ZCODE-SIGN = 'I'.

GR_ZCODE-OPTION = 'BT'.

GR_ZCODE-LOW = 'SSU-90'.

GR_ZCODE-HIGH = 'SSU-99'.

APPEND GR_ZCODE.



SELECT * FROM ZEDT13_001

  INTO CORRESPONDING FIELDS OF TABLE GT_STUDENT

  WHERE ZCODE IN GR_ZCODE.                                          "## #### #### ##"



IF GT_STUDENT IS NOT INITIAL.

  LOOP AT GT_STUDENT INTO GS_STUDENT.

    CALL FUNCTION 'CONVERSION_EXIT_ALPHA_INPUT'                     "CONVERSION_EXIT_ALPHA_OUTPUT# ##, 0## ### ### ##"

    EXPORTING

      INPUT         =  GS_STUDENT-ZPERNR

    IMPORTING

      OUTPUT        =  GS_STUDENT-ZPERNR.

  MODIFY GT_STUDENT FROM GS_STUDENT TRANSPORTING ZPERNR.            "ZPERNR# ##"

  ENDLOOP.



  INSERT ZEDT13_001 FROM TABLE GT_STUDENT ACCEPTING DUPLICATE KEYS. "## 1# ## ## ## ## ## #### ##### ##"



  IF SY-SUBRC = 0.

    WRITE : '##'.

  ELSEIF SY-SUBRC = 4.

    WRITE : '##'.

  ENDIF.

ENDIF.











          .