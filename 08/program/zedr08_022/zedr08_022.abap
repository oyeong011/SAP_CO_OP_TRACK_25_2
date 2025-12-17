
*&---------------------------------------------------------------------*

*& Report ZEDR08_022

*&---------------------------------------------------------------------*

*&

*&---------------------------------------------------------------------*




REPORT ZEDR08_022.



TABLES : ZEDT08_001.



DATA : T_ZCODE TYPE RANGE OF ZCODE,

       S_ZCODE LIKE LINE OF T_ZCODE.



DATA : GS_STUDENT TYPE ZEDT08_001.

DATA : GT_STUDENT LIKE TABLE OF GS_STUDENT.



DATA : GS_FIELDCAT TYPE SLIS_FIELDCAT_ALV.

DATA : GT_FIELDCAT TYPE SLIS_T_FIELDCAT_ALV.

DATA : GS_LAYOUT TYPE SLIS_LAYOUT_ALV.






*SELECTION-SCREEN BEGIN OF BLOCK B1 WITH FRAME.

*  SELECT-OPTIONS : S_ZCODE FOR ZEDT08_001-ZCODE.

*  PARAMETERS : P_ZPERNR LIKE ZEDT08_001-ZPERNR.

*  PARAMETERS : P_ZGEN LIKE ZEDT08_001-ZGENDER MODIF ID SC1.

*SELECTION-SCREEN END OF BLOCK B1.






INITIALIZATION.

S_ZCODE-LOW = 'SSU-01'.

S_ZCODE-HIGH = 'SSU-99'.

APPEND S_ZCODE TO T_ZCODE.



AT SELECTION-SCREEN OUTPUT.

  LOOP AT SCREEN.

    IF SCREEN-GROUP1 = 'SC1'.

      SCREEN-INPUT = 0.

    ENDIF.

    MODIFY SCREEN.

  ENDLOOP.



START-OF-SELECTION.

  PERFORM GET_DATA.

  PERFORM MODIFY_DATA.

END-OF-SELECTION.

  PERFORM ALV_DISPLAY.



TYPES : BEGIN OF slis_fieldcat_main.

  INCLUDE TYPE slis_fieldcat_main0.

  INCLUDE TYPE slis_fieldcat_main1.

TYPES : END OF slis_fieldcat_main.



TYPES : BEGIN OF slis_fieldcat_alv_spec,

  key_sel(1) TYPE c,

  no_sum(1) TYPE c,

  sp_group(4) TYPE c,

  reprep(1) TYPE c,

  input(1) TYPE c,

  edit(1) TYPE c,

  hotspot(1) TYPE c,

  END OF slis_fieldcat_alv_spec.



TYPES : BEGIN OF slis_fieldcat_alv.

  INCLUDE TYPE slis_fieldcat_main.

  INCLUDE TYPE slis_fieldcat_alv_spec.

TYPES : END OF slis_fieldcat_alv.



TYPES : BEGIN OF slis_fieldcat_alv1.

  INCLUDE TYPE slis_fieldcat_main1.

TYPES : END OF slis_fieldcat_alv1.



" slis_t_fieldcat_alv# slis_fieldcat_alv ### ## # ## # ## ## ### #####.

" # #(Row)# ### ## ### #####.

TYPES : slis_t_fieldcat_alv TYPE slis_fieldcat_alv OCCURS 1.






*&---------------------------------------------------------------------*

*&      Form  GET_DATA

*&---------------------------------------------------------------------*

*       text

*----------------------------------------------------------------------*

*  -->  p1        text

*  <--  p2        text

*----------------------------------------------------------------------*




FORM GET_DATA .

  SELECT * FROM ZEDT08_001

    INTO TABLE GT_STUDENT.



  IF SY-SUBRC <> 0.

    WRITE :/ '#### #### ####.'.

    EXIT.

  ENDIF.



ENDFORM.




*&---------------------------------------------------------------------*

*&      Form  MODIFY_DATA

*&---------------------------------------------------------------------*

*       text

*----------------------------------------------------------------------*

*  -->  p1        text

*  <--  p2        text

*----------------------------------------------------------------------*




FORM MODIFY_DATA .



ENDFORM.






*&---------------------------------------------------------------------*

*&      Form  GET_DATA

*&---------------------------------------------------------------------*

*       text

*----------------------------------------------------------------------*

*  -->  p1        text

*  <--  p2        text

*----------------------------------------------------------------------*




FORM ALV_DISPLAY.



  PERFORM FIELD_CATALOG.

  PERFORM ALV_LAYOUT.

  PERFORM CALL_ALV.






*  CALL FUNCTION 'REUSE_ALV_LIST_DISPLAY'

*    EXPORTING

*      I_STRUCTURE_NAME = 'ZEDT08_001'

*    TABLES

*      T_OUTTAB = GT_STUDENT.




ENDFORM.




*&---------------------------------------------------------------------*

*&      Form  FIELD_CATALOG

*&---------------------------------------------------------------------*

*       text

*----------------------------------------------------------------------*

*  -->  p1        text

*  <--  p2        text

*----------------------------------------------------------------------*




FORM FIELD_CATALOG .



  CLEAR : GS_FIELDCAT, GT_FIELDCAT.

  GS_FIELDCAT-COL_POS = 1.

  GS_FIELDCAT-FIELDNAME = 'ZCODE'.

  GS_FIELDCAT-SELTEXT_M = '####'.

  GS_FIELDCAT-KEY = 'X'.

  GS_FIELDCAT-JUST = 'L'.

  APPEND GS_FIELDCAT TO GT_FIELDCAT.



  CLEAR : GS_FIELDCAT.

  GS_FIELDCAT-COL_POS = 2.

  GS_FIELDCAT-FIELDNAME = 'ZPERNR'.

  GS_FIELDCAT-SELTEXT_M = '####'.

  GS_FIELDCAT-KEY = 'X'.

  GS_FIELDCAT-JUST = 'C'.

  APPEND GS_FIELDCAT TO GT_FIELDCAT.



  CLEAR : GS_FIELDCAT.

  GS_FIELDCAT-COL_POS = 3.

  GS_FIELDCAT-FIELDNAME = 'ZMAJOR'.

  GS_FIELDCAT-SELTEXT_M = '##'.

  GS_FIELDCAT-JUST = 'R'.

  GS_FIELDCAT-NO_OUT = 'X'.

  APPEND GS_FIELDCAT TO GT_FIELDCAT.



  CLEAR : GS_FIELDCAT.

  GS_FIELDCAT-COL_POS = 4.

  GS_FIELDCAT-FIELDNAME = 'ZMNAME'.

  GS_FIELDCAT-SELTEXT_M = '###'.

  APPEND GS_FIELDCAT TO GT_FIELDCAT.



  CLEAR : GS_FIELDCAT.

  GS_FIELDCAT-COL_POS = 5.

  GS_FIELDCAT-FIELDNAME = 'ZSUM'.

  GS_FIELDCAT-SELTEXT_M = '####'.

  GS_FIELDCAT-CURRENCY = 'KRW'.

  GS_FIELDCAT-DO_SUM = 'X'.

  GS_FIELDCAT-NO_ZERO = 'X'.

  GS_FIELDCAT-NO_SIGN = 'X'.

  GS_FIELDCAT-EDIT = 'X'.

  GS_FIELDCAT-OUTPUTLEN = 20.

  GS_FIELDCAT-EMPHASIZE = 'X'.

  APPEND GS_FIELDCAT TO GT_FIELDCAT.



  CLEAR : GS_FIELDCAT.

  GS_FIELDCAT-COL_POS = 6.

  GS_FIELDCAT-FIELDNAME = 'ZWAERS'.

  GS_FIELDCAT-SELTEXT_M = '##'.

  APPEND GS_FIELDCAT TO GT_FIELDCAT.



  CLEAR : GS_FIELDCAT.

  GS_FIELDCAT-COL_POS = 7.

  GS_FIELDCAT-FIELDNAME = 'CRDATE'.

  GS_FIELDCAT-SELTEXT_M = '###'.

  GS_FIELDCAT-EDIT_MASK = '____-__-__'.

  APPEND GS_FIELDCAT TO GT_FIELDCAT.



ENDFORM.




*&---------------------------------------------------------------------*

*&      Form  CALL_ALV

*&---------------------------------------------------------------------*

*       text

*----------------------------------------------------------------------*

*  -->  p1        text

*  <--  p2        text

*----------------------------------------------------------------------*




FORM CALL_ALV .



  CALL FUNCTION 'REUSE_ALV_GRID_DISPLAY'

  EXPORTING

    IT_FIELDCAT = GT_FIELDCAT

  TABLES

    T_OUTTAB = GT_STUDENT.



ENDFORM.




*&---------------------------------------------------------------------*

*&      Form  ALV_LAYOUT

*&---------------------------------------------------------------------*

*       text

*----------------------------------------------------------------------*

*  -->  p1        text

*  <--  p2        text

*----------------------------------------------------------------------*




FORM ALV_LAYOUT .



  GS_LAYOUT-NO_COLHEAD = 'X'.

  GS_LAYOUT-ZEBRA = 'X'.



ENDFORM.