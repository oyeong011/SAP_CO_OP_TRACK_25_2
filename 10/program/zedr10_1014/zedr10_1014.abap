
*&---------------------------------------------------------------------*

*& Report ZEDR10_1014

*&---------------------------------------------------------------------*

*&

*&---------------------------------------------------------------------*




REPORT ZEDR10_1014.



CONSTANTS: C_CURR(3) TYPE C VALUE 'KRW'.



DATA:




*      GS_STUDENT LIKE ZEDT10_001,




      GS_STUDENT LIKE ZEDT10_004,

      GT_STUDENT LIKE TABLE OF GS_STUDENT.



DATA: GS_FIELDCAT TYPE SLIS_FIELDCAT_ALV,

      GT_FIELDCAT TYPE SLIS_T_FIELDCAT_ALV.



SELECTION-SCREEN BEGIN OF BLOCK B1 WITH FRAME.

SELECT-OPTIONS: S_ZCODE FOR GS_STUDENT-ZCODE MODIF ID SC1.

PARAMETERS: P_ZPERNR LIKE GS_STUDENT-ZPERNR.




*            P_ZGEN   LIKE GS_STUDENT-ZGENDER MODIF ID SC1.






SELECTION-SCREEN END OF BLOCK B1.



INITIALIZATION.

  S_ZCODE-LOW = 'SSU-01'.

  S_ZCODE-HIGH = 'SSU-99'.

  APPEND S_ZCODE.



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




*&---------------------------------------------------------------------*

*&      Form  GET_DATA

*&---------------------------------------------------------------------*

*       text

*----------------------------------------------------------------------*

*  -->  p1        text

*  <--  p2        text

*----------------------------------------------------------------------*




FORM GET_DATA .

  SELECT * FROM ZEDT10_004

    INTO TABLE GT_STUDENT.




*    WHERE ZCODE IN S_ZCODE.




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

*&      Form  ALV_DISPLAY

*&---------------------------------------------------------------------*

*       text

*----------------------------------------------------------------------*

*  -->  p1        text

*  <--  p2        text

*----------------------------------------------------------------------*




FORM ALV_DISPLAY .



  PERFORM FIELD_CATALOG.



  CALL FUNCTION 'REUSE_ALV_GRID_DISPLAY'

    EXPORTING




*     I_INTERFACE_CHECK              = ' '

*     I_BYPASSING_BUFFER             =

*     I_BUFFER_ACTIVE  = ' '

*     I_CALLBACK_PROGRAM             = ' '

*     I_CALLBACK_PF_STATUS_SET       = ' '

*     I_CALLBACK_USER_COMMAND        = ' '

*     I_STRUCTURE_NAME = 'ZEDT10_001'

*     IS_LAYOUT   =




      IT_FIELDCAT = GT_FIELDCAT




*     IT_EXCLUDING     =

*     IT_SPECIAL_GROUPS              =

*     IT_SORT     =

*     IT_FILTER   =

*     IS_SEL_HIDE =

*     I_DEFAULT   = 'X'

*     I_SAVE      = ' '

*     IS_VARIANT  =

*     IT_EVENTS   =

*     IT_EVENT_EXIT    =

*     IS_PRINT    =

*     IS_REPREP_ID     =

*     I_SCREEN_START_COLUMN          = 0

*     I_SCREEN_START_LINE            = 0

*     I_SCREEN_END_COLUMN            = 0

*     I_SCREEN_END_LINE              = 0

*     IR_SALV_LIST_ADAPTER           =

*     IT_EXCEPT_QINFO  =

*     I_SUPPRESS_EMPTY_DATA          = ABAP_FALSE

* IMPORTING

*     E_EXIT_CAUSED_BY_CALLER        =

*     ES_EXIT_CAUSED_BY_USER         =




    TABLES

      T_OUTTAB    = GT_STUDENT.




* EXCEPTIONS

*   PROGRAM_ERROR                  = 1

*   OTHERS                         = 2




  .

  IF SY-SUBRC <> 0.




* Implement suitable error handling here




  ENDIF.



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

  CLEAR: GS_FIELDCAT, GT_FIELDCAT.

  GS_FIELDCAT-COL_POS = 1.

  GS_FIELDCAT-FIELDNAME = 'ZCODE'.

  GS_FIELDCAT-SELTEXT_M = '####'.

  APPEND GS_FIELDCAT TO GT_FIELDCAT.



  CLEAR: GS_FIELDCAT.

  GS_FIELDCAT-COL_POS = 2.

  GS_FIELDCAT-FIELDNAME = 'ZPERNR'.

  GS_FIELDCAT-SELTEXT_M = '####'.

  APPEND GS_FIELDCAT TO GT_FIELDCAT.






*  CLEAR: GS_FIELDCAT.

*  GS_FIELDCAT-COL_POS = 3.

*  GS_FIELDCAT-FIELDNAME = 'ZKNAME'.

*  GS_FIELDCAT-SELTEXT_M = '##'.

*  APPEND GS_FIELDCAT TO GT_FIELDCAT.






  CLEAR: GS_FIELDCAT.

  GS_FIELDCAT-COL_POS = 3.

  GS_FIELDCAT-FIELDNAME = 'ZMAJOR'.

  GS_FIELDCAT-SELTEXT_M = '##'.

  GS_FIELDCAT-NO_OUT = 'X'.

  APPEND GS_FIELDCAT TO GT_FIELDCAT.



  CLEAR: GS_FIELDCAT.

  GS_FIELDCAT-COL_POS = 4.

  GS_FIELDCAT-FIELDNAME = 'ZMNAME'.

  GS_FIELDCAT-SELTEXT_M = '###'.

  APPEND GS_FIELDCAT TO GT_FIELDCAT.



  CLEAR: GS_FIELDCAT.

  GS_FIELDCAT-COL_POS = 5.

  GS_FIELDCAT-FIELDNAME = 'ZSUM'.

  GS_FIELDCAT-SELTEXT_M = '####'.

  GS_FIELDCAT-CURRENCY = C_CURR.

  GS_FIELDCAT-DO_SUM = 'X'.

  GS_FIELDCAT-NO_ZERO = 'X'.




*  GS_FIELDCAT-NO_SIGN = 'X'.




  GS_FIELDCAT-EMPHASIZE = 'X'.

  GS_FIELDCAT-EDIT = 'X'.

  APPEND GS_FIELDCAT TO GT_FIELDCAT.






*  CLEAR: GS_FIELDCAT.

*  GS_FIELDCAT-COL_POS = 6.

*  GS_FIELDCAT-FIELDNAME = 'CRDATE'.

*  GS_FIELDCAT-SELTEXT_M = '###'.

*  GS_FIELDCAT-EDIT_MASK = '____-__-__'.

*  APPEND GS_FIELDCAT TO GT_FIELDCAT.




ENDFORM.