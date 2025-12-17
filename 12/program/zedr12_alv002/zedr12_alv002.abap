
*&---------------------------------------------------------------------*

*& Report ZEDR12_ALV002

*&---------------------------------------------------------------------*

*&

*&---------------------------------------------------------------------*




REPORT ZEDR12_ALV002.



DATA : BEGIN OF GS_STUDENT,

  ZCHECKBOX TYPE C,               " #### ### ## ##

  ZCOLOR TYPE C LENGTH 4,         " ### ### ## ## ## (### LENGHT 4)



  ZCODE LIKE ZEDT12_001-ZCODE,    "####

  ZPERNR LIKE ZEDT12_001-ZPERNR,  " ####

  ZKNAME LIKE ZEDT12_001-ZKNAME,  " ##

  ZENAME LIKE ZEDT12_001-ZENAME,  " ###

  ZGENDER LIKE ZEDT12_001-ZGENDER," ##

  ZMAJOR LIKE ZEDT12_002-ZMAJOR,  " ##

  ZMNAME LIKE ZEDT12_002-ZMNAME,  " ###



  END OF GS_STUDENT.

DATA GT_STUDENT LIKE TABLE OF GS_STUDENT.



" ## ####. FUNCTION 'REUSE_ALV_GRID_DISPLAY'## ###

DATA GS_FIELDCAT TYPE SLIS_FIELDCAT_ALV.

DATA GT_FIELDCAT TYPE SLIS_T_FIELDCAT_ALV.





START-OF-SELECTION. " ### F8 ### SELECT## #### ##

  PERFORM GET_DATA.

  PERFORM MODIFY_DATA.

END-OF-SELECTION. " ### F8 ### SELECT## #### ### #

  PERFORM ALV_DISPLAY.








*&---------------------------------------------------------------------*

*&      Form  GET_DATA

*&---------------------------------------------------------------------*




FORM GET_DATA .

  SELECT  A~ZCODE

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

*&      Form  MODIFY_DATA

*&---------------------------------------------------------------------*




FORM MODIFY_DATA .

  " ###### #### ## ## ###

  " ##### ## ##

  " ## ##

  "+ ### 002 ### ##### #.

  CLEAR GS_STUDENT.

  LOOP AT GT_STUDENT INTO GS_STUDENT.

    IF GS_STUDENT-ZENAME IS INITIAL.




*    IF GS_STUDENT-ZCODE = 'SSU-01'.  " ####




      GS_STUDENT-ZCOLOR = '@0A@'.   " ###. TYPE GROUP ICON ##

    ENDIF.



    MODIFY GT_STUDENT FROM GS_STUDENT INDEX SY-TABIX.

    CLEAR GS_STUDENT.

  ENDLOOP.

ENDFORM.








*&---------------------------------------------------------------------*

*&      Form  ALV_DISPLAY

*&---------------------------------------------------------------------*




FORM ALV_DISPLAY .

  PERFORM FIELD_CATALOG.



  CALL FUNCTION 'REUSE_ALV_GRID_DISPLAY'

    EXPORTING

      IT_FIELDCAT = GT_FIELDCAT

    TABLES

      T_OUTTAB = GT_STUDENT.

ENDFORM.








*&---------------------------------------------------------------------*

*&      Form  FIELD_CATALOG

*&---------------------------------------------------------------------*




FORM FIELD_CATALOG .

  CLEAR : GS_FIELDCAT, GT_FIELDCAT.

  GS_FIELDCAT-COL_POS = 1.

  GS_FIELDCAT-FIELDNAME = 'ZCODE'.

  GS_FIELDCAT-seltext_m = '####'.

  GS_FIELDCAT-KEY = 'X'.  " ###. ## ##. #### # ##.

  APPEND GS_FIELDCAT TO GT_FIELDCAT.



  CLEAR : GS_FIELDCAT.

  GS_FIELDCAT-COL_POS = 2.

  GS_FIELDCAT-FIELDNAME = 'ZPERNR'.

  GS_FIELDCAT-seltext_m = '####'.

  GS_FIELDCAT-KEY = 'X'.

  APPEND GS_FIELDCAT TO GT_FIELDCAT.



  CLEAR : GS_FIELDCAT.

  GS_FIELDCAT-COL_POS = 3.

  GS_FIELDCAT-FIELDNAME = 'ZKNAME'.

  GS_FIELDCAT-seltext_m = '##'.

  APPEND GS_FIELDCAT TO GT_FIELDCAT.



  CLEAR : GS_FIELDCAT.

  GS_FIELDCAT-COL_POS = 4.

  GS_FIELDCAT-FIELDNAME = 'ZENAME'.

  GS_FIELDCAT-seltext_m = '###'.

  APPEND GS_FIELDCAT TO GT_FIELDCAT.



  CLEAR : GS_FIELDCAT.

  GS_FIELDCAT-COL_POS = 5.

  GS_FIELDCAT-FIELDNAME = 'ZGENDER'.

  GS_FIELDCAT-seltext_m = '##'.

  APPEND GS_FIELDCAT TO GT_FIELDCAT.



  CLEAR : GS_FIELDCAT.

  GS_FIELDCAT-COL_POS = 6.

  GS_FIELDCAT-FIELDNAME = 'ZMAJOR'.

  GS_FIELDCAT-seltext_m = '##'.

  APPEND GS_FIELDCAT TO GT_FIELDCAT.



  CLEAR : GS_FIELDCAT.

  GS_FIELDCAT-COL_POS = 7.

  GS_FIELDCAT-FIELDNAME = 'ZMNAME'.

  GS_FIELDCAT-seltext_m = '###'.

  APPEND GS_FIELDCAT TO GT_FIELDCAT.



  CLEAR : GS_FIELDCAT.

  GS_FIELDCAT-COL_POS = 8.

  GS_FIELDCAT-FIELDNAME = 'ZCHECKBOX'.

  GS_FIELDCAT-seltext_m = '####'.

  GS_FIELDCAT-CHECKBOX = 'X'.

  GS_FIELDCAT-EDIT = 'X'.

  APPEND GS_FIELDCAT TO GT_FIELDCAT.



  CLEAR : GS_FIELDCAT.

  GS_FIELDCAT-COL_POS = 9.

  GS_FIELDCAT-FIELDNAME = 'ZCOLOR'.

  GS_FIELDCAT-seltext_m = '##'.

  GS_FIELDCAT-ICON = 'X'.

  APPEND GS_FIELDCAT TO GT_FIELDCAT.

ENDFORM.