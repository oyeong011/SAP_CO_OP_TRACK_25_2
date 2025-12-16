
*&---------------------------------------------------------------------*

*& Report ZEDR02_023

*&---------------------------------------------------------------------*

*&

*&---------------------------------------------------------------------*




REPORT ZEDR02_023.



"20251014 FUNCTION PROGRAM ##



TABLES : ZEDT02_001.



DATA: BEGIN OF GS_STUDENT.

  include structure
ZEDT02_001
.

DATA : END OF GS_STUDENT.

DATA : GT_STUDENT LIKE TABLE OF GS_STUDENT.



DATA: GS_FIELDCAT TYPE SLIS_FIELDCAT_ALV.

DATA: GT_FIELDCAT TYPE SLIS_T_FIELDCAT_ALV.



SELECTION-SCREEN BEGIN OF BLOCK B1 WITH FRAME.

  SELECT-OPTIONS : S_ZCODE FOR ZEDT02_001-ZCODE.

  PARAMETERS : P_ZPERNR LIKE ZEDT02_001-ZPERNR.

  PARAMETERS : P_ZGEN LIKE ZEDT02_001-ZGENDER DEFAULT 'M' MODIF ID SC1.

SELECTION-SCREEN END OF BLOCK B1.



"INITIALIZATION ### START-OF-SELECTION ##

INITIALIZATION.

S_ZCODE-LOW = 'SSU-01'.

S_ZCODE-HIGH = 'SSU-99'.

APPEND S_ZCODE.



"OUTPUT: SELECTION SCREEN ### LAYOUT ### ##

AT SELECTION-SCREEN OUTPUT.

  LOOP AT SCREEN.

    IF SCREEN-GROUP1 = 'SC1'.

      SCREEN-INPUT = 0.

    ENDIF.

    MODIFY SCREEN.

  ENDLOOP.



"#### ## ### ### ######## ## ## ## SELECT ### ###

START-OF-SELECTION.

  PERFORM GET_DATA.

  PERFORM MODIFY_DATA.



"SELECT#### ## #### ## # ### WRITE #### ## ##

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

  SELECT * FROM ZEDT02_001

    INTO CORRESPONDING FIELDS OF TABLE GT_STUDENT

    WHERE ZCODE IN S_ZCODE.

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




*  CALL FUNCTION 'REUSE_ALV_LIST_DISPLAY'

*    EXPORTING

**      I_INTERFACE_CHECK              = ' '

**      I_BYPASSING_BUFFER             =

**      I_BUFFER_ACTIVE                = ' '

**      I_CALLBACK_PROGRAM             = ' '

**      I_CALLBACK_PF_STATUS_SET       = ' '

**      I_CALLBACK_USER_COMMAND        = ' '

*      I_STRUCTURE_NAME               = 'ZEDT02_001'

**       IS_LAYOUT                      =

**       IT_FIELDCAT                    =

**       IT_EXCLUDING                   =

**       IT_SPECIAL_GROUPS              =

**       IT_SORT                        =

**       IT_FILTER                      =

**       IS_SEL_HIDE                    =

**       I_DEFAULT                      = 'X'

**       I_SAVE                         = ' '

**       IS_VARIANT                     =

**       IT_EVENTS                      =

**       IT_EVENT_EXIT                  =

**       IS_PRINT                       =

**       IS_REPREP_ID                   =

**       I_SCREEN_START_COLUMN          = 0

**       I_SCREEN_START_LINE            = 0

**       I_SCREEN_END_COLUMN            = 0

**       I_SCREEN_END_LINE              = 0

**       IR_SALV_LIST_ADAPTER           =

**       IT_EXCEPT_QINFO                =

**       I_SUPPRESS_EMPTY_DATA          = ABAP_FALSE

**     IMPORTING

**       E_EXIT_CAUSED_BY_CALLER        =

**       ES_EXIT_CAUSED_BY_USER         =

*      TABLES

*        T_OUTTAB                       = GT_STUDENT.

**     EXCEPTIONS

**       PROGRAM_ERROR                  = 1

**       OTHERS                         = 2

**              .

**    IF SY-SUBRC <> 0.

**

**   ENDIF.



*  CALL FUNCTION 'REUSE_ALV_GRID_DISPLAY'

*   EXPORTING

**     I_INTERFACE_CHECK                 = ' '

**     I_BYPASSING_BUFFER                = ' '

**     I_BUFFER_ACTIVE                   = ' '

**     I_CALLBACK_PROGRAM                = ' '

**     I_CALLBACK_PF_STATUS_SET          = ' '

**     I_CALLBACK_USER_COMMAND           = ' '

**     I_CALLBACK_TOP_OF_PAGE            = ' '

**     I_CALLBACK_HTML_TOP_OF_PAGE       = ' '

**     I_CALLBACK_HTML_END_OF_LIST       = ' '

*     I_STRUCTURE_NAME                  = 'ZEDT02_001'

**     I_BACKGROUND_ID                   = ' '

**     I_GRID_TITLE                      =

**     I_GRID_SETTINGS                   =

**     IS_LAYOUT                         =

**     IT_FIELDCAT                       =

**     IT_EXCLUDING                      =

**     IT_SPECIAL_GROUPS                 =

**     IT_SORT                           =

**     IT_FILTER                         =

**     IS_SEL_HIDE                       =

**     I_DEFAULT                         = 'X'

**     I_SAVE                            = ' '

**     IS_VARIANT                        =

**     IT_EVENTS                         =

**     IT_EVENT_EXIT                     =

**     IS_PRINT                          =

**     IS_REPREP_ID                      =

**     I_SCREEN_START_COLUMN             = 0

**     I_SCREEN_START_LINE               = 0

**     I_SCREEN_END_COLUMN               = 0

**     I_SCREEN_END_LINE                 = 0

**     I_HTML_HEIGHT_TOP                 = 0

**     I_HTML_HEIGHT_END                 = 0

**     IT_ALV_GRAPHICS                   =

**     IT_HYPERLINK                      =

**     IT_ADD_FIELDCAT                   =

**     IT_EXCEPT_QINFO                   =

**     IR_SALV_FULLSCREEN_ADAPTER        =

**   IMPORTING

**     E_EXIT_CAUSED_BY_CALLER           =

**     ES_EXIT_CAUSED_BY_USER            =

*    TABLES

*      T_OUTTAB                          = GT_STUDENT

**   EXCEPTIONS

**     PROGRAM_ERROR                     = 1

**     OTHERS                            = 2

*            .

**  IF SY-SUBRC <> 0.

*** Implement suitable error handling here

**  ENDIF.






  PERFORM FIELD_CATALOG.

  PERFORM CALL_ALV.



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

*&      Form  FIELD_CATALOG

*&---------------------------------------------------------------------*

*       text

*----------------------------------------------------------------------*

*  -->  p1        text

*  <--  p2        text

*----------------------------------------------------------------------*




FORM FIELD_CATALOG .



  CLEAR : GS_FIELDCAT, GT_FIELDCAT.

  GS_FIELDCAT-COL_POS = 1. "### OUTPUT ##

  GS_FIELDCAT-FIELDNAME = 'ZCODE'. "## ##### ## ## / ####### ## ### #####

  GS_FIELDCAT-SELTEXT_M = '####'. "### ###

  APPEND GS_FIELDCAT TO GT_FIELDCAT.



  CLEAR : GS_FIELDCAT.

  GS_FIELDCAT-COL_POS = 2.

  GS_FIELDCAT-FIELDNAME = 'ZPERNR'.

  GS_FIELDCAT-SELTEXT_M = '####'.

  APPEND GS_FIELDCAT TO GT_FIELDCAT.



  CLEAR : GS_FIELDCAT.

  GS_FIELDCAT-COL_POS = 3.

  GS_FIELDCAT-FIELDNAME = 'ZKNAME'.

  GS_FIELDCAT-SELTEXT_M = '##'.

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




*     I_INTERFACE_CHECK                 = ' '

*     I_BYPASSING_BUFFER                = ' '

*     I_BUFFER_ACTIVE                   = ' '

*     I_CALLBACK_PROGRAM                = ' '

*     I_CALLBACK_PF_STATUS_SET          = ' '

*     I_CALLBACK_USER_COMMAND           = ' '

*     I_CALLBACK_TOP_OF_PAGE            = ' '

*     I_CALLBACK_HTML_TOP_OF_PAGE       = ' '

*     I_CALLBACK_HTML_END_OF_LIST       = ' '

*     I_STRUCTURE_NAME                  =

*     I_BACKGROUND_ID                   = ' '

*     I_GRID_TITLE                      =

*     I_GRID_SETTINGS                   =

*     IS_LAYOUT                         =




     IT_FIELDCAT                       = GT_FIELDCAT




*     IT_EXCLUDING                      =

*     IT_SPECIAL_GROUPS                 =

*     IT_SORT                           =

*     IT_FILTER                         =

*     IS_SEL_HIDE                       =

*     I_DEFAULT                         = 'X'

*     I_SAVE                            = ' '

*     IS_VARIANT                        =

*     IT_EVENTS                         =

*     IT_EVENT_EXIT                     =

*     IS_PRINT                          =

*     IS_REPREP_ID                      =

*     I_SCREEN_START_COLUMN             = 0

*     I_SCREEN_START_LINE               = 0

*     I_SCREEN_END_COLUMN               = 0

*     I_SCREEN_END_LINE                 = 0

*     I_HTML_HEIGHT_TOP                 = 0

*     I_HTML_HEIGHT_END                 = 0

*     IT_ALV_GRAPHICS                   =

*     IT_HYPERLINK                      =

*     IT_ADD_FIELDCAT                   =

*     IT_EXCEPT_QINFO                   =

*     IR_SALV_FULLSCREEN_ADAPTER        =

*   IMPORTING

*     E_EXIT_CAUSED_BY_CALLER           =

*     ES_EXIT_CAUSED_BY_USER            =




    TABLES

      T_OUTTAB                          = GT_STUDENT




*   EXCEPTIONS

*     PROGRAM_ERROR                     = 1

*     OTHERS                            = 2




            .




*  IF SY-SUBRC <> 0.

** Implement suitable error handling here

*  ENDIF.






ENDFORM.