
*&---------------------------------------------------------------------*

*& Report ZEDR12_ALV001

*&---------------------------------------------------------------------*

*&

*&---------------------------------------------------------------------*




REPORT ZEDR12_ALV001.



DATA: BEGIN OF GT_STUDENT OCCURS 0,

  ZCODE LIKE ZEDT12_001-ZCODE, "####

  ZPERNR LIKE ZEDT12_001-ZPERNR,  " ####

  ZKNAME LIKE ZEDT12_001-ZKNAME,  " ##

  ZENAME LIKE ZEDT12_001-ZENAME,  " ###

  ZGENDER LIKE ZEDT12_001-ZGENDER," ##

  ZMAJOR LIKE ZEDT12_002-ZMAJOR,  " ##

  ZMNAME LIKE ZEDT12_002-ZMNAME,  " ###

  END OF GT_STUDENT.



DATA: GS_FIELDCAT TYPE SLIS_FIELDCAT_ALV.

DATA: GT_FIELDCAT TYPE SLIS_T_FIELDCAT_ALV.



START-OF-SELECTION. " ### F8 ### SELECT## #### ##

  PERFORM GET_DATA.

END-OF-SELECTION. " ### F8 ### SELECT## #### ### #

  PERFORM ALV_DISPLAY.




*&---------------------------------------------------------------------*

*&      Form  GET_DATA

*&---------------------------------------------------------------------*

*       text

*----------------------------------------------------------------------*

*  -->  p1        text

*  <--  p2        text

*----------------------------------------------------------------------*




FORM GET_DATA .

  SELECT A~ZCODE

         A~ZPERNR

         A~ZKNAME

         A~ZENAME

         A~ZGENDER

         B~ZMAJOR

         B~ZMNAME

    FROM ZEDT12_001 AS A

    INNER JOIN ZEDT12_002 AS B

    ON A~ZCODE = B~ZCODE

    INTO CORRESPONDING FIELDS OF TABLE GT_STUDENT.

ENDFORM.




*&---------------------------------------------------------------------*

*&      Form  ALV_DISPLAY

*&---------------------------------------------------------------------*

*       text

*----------------------------------------------------------------------*

*  -->  p1        text

*  <--  p2        text

*----------------------------------------------------------------------*




FORM ALV_DISPLAY .



  CALL FUNCTION 'REUSE_ALV_FIELDCATALOG_MERGE'

    EXPORTING

      I_PROGRAM_NAME      = SY-REPID   "## #### #### #### ### ##

      I_INTERNAL_TABNAME  = 'GT_STUDENT'

      I_INCLNAME          = SY-REPID

    CHANGING

      CT_FIELDCAT         = GT_FIELDCAT.



  CALL FUNCTION 'REUSE_ALV_GRID_DISPLAY'

  EXPORTING

    IT_FIELDCAT = GT_FIELDCAT

  TABLES

    T_OUTTAB = GT_STUDENT.



ENDFORM.