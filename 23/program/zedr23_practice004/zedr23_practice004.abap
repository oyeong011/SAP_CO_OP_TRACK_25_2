
*&---------------------------------------------------------------------*

*& Report ZEDR23_PRACTICE004

*&---------------------------------------------------------------------*

*&

*&---------------------------------------------------------------------*




REPORT ZEDR23_PRACTICE004.



DATA : GT_DATA LIKE TABLE OF ZEDT00_001.



RANGES GR_ZCODE FOR ZEDT00_001-ZCODE.

GR_ZCODE-SIGN = 'I'.

GR_ZCODE-OPTION = 'BT'.

GR_ZCODE-LOW = 'SSU-90'.

GR_ZCODE-HIGH = 'SSU-99'.

APPEND GR_ZCODE.



SELECT * FROM ZEDT00_001

  INTO CORRESPONDING FIELDS OF TABLE GT_DATA

  WHERE ZCODE IN GR_ZCODE.



LOOP AT GT_DATA INTO DATA(line).

  CALL FUNCTION 'CONVERSION_EXIT_ALPHA_INPUT'

  EXPORTING

    INPUT         = line-ZPERNR

  IMPORTING

    OUTPUT        = line-ZPERNR.

  MODIFY GT_DATA FROM line.

ENDLOOP.



"INSERT ZEDT23_001 FROM TABLE GT_DATA.

MODIFY ZEDT23_001 FROM TABLE GT_DATA.



"IF SY-SUBRC = 0.

"  WRITE : /'Itable Insert ##'.

"ENDIF.