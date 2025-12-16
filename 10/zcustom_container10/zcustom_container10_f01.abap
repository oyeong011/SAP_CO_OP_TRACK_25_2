
*&---------------------------------------------------------------------*

*&  Include           ZCUSTOM_CONTAINER10_F01

*&---------------------------------------------------------------------*

*&---------------------------------------------------------------------*

*&      Form  SET_INITIAL

*&---------------------------------------------------------------------*

*       text

*----------------------------------------------------------------------*

*  -->  p1        text

*  <--  p2        text

*----------------------------------------------------------------------*




FORM SET_INITIAL .

  S_ZCODE-LOW = 'SSU-01'.

  S_ZCODE-HIGH = 'SSU-99'.

  APPEND S_ZCODE.

ENDFORM.




*&---------------------------------------------------------------------*

*&      Form  GET_DATA

*&---------------------------------------------------------------------*

*       text

*----------------------------------------------------------------------*

*  -->  p1        text

*  <--  p2        text

*----------------------------------------------------------------------*




FORM GET_DATA .

  SELECT * FROM ZEDT10_001 INTO CORRESPONDING FIELDS OF TABLE GT_STUDENT.

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

  LOOP AT GT_STUDENT ASSIGNING FIELD-SYMBOL(<FS_GS_STUDENT>).

    CASE <FS_GS_STUDENT>-ZGENDER.

      WHEN 'M'.

        <FS_GS_STUDENT>-ZGNAME = '##'.

      WHEN 'F'.

        <FS_GS_STUDENT>-ZGNAME = '##'.

      WHEN OTHERS.

        <FS_GS_STUDENT>-ZGNAME = '##'.

    ENDCASE.

  ENDLOOP.

ENDFORM.




*&---------------------------------------------------------------------*

*&      Form  SET_SCREEN

*&---------------------------------------------------------------------*

*       text

*----------------------------------------------------------------------*

*  -->  p1        text

*  <--  p2        text

*----------------------------------------------------------------------*




FORM SET_SCREEN .



ENDFORM.




*&---------------------------------------------------------------------*

*&      Form  CREATE_OBJ

*&---------------------------------------------------------------------*

*       text

*----------------------------------------------------------------------*

*  -->  p1        text

*  <--  p2        text

*----------------------------------------------------------------------*




FORM CREATE_OBJ .

  CREATE OBJECT GC_CUSTOM

    EXPORTING




*     PARENT         =




      CONTAINER_NAME = 'CON1'




*     STYLE          =

*     LIFETIME       = lifetime_default

*     REPID          =

*     DYNNR          =

*     NO_AUTODEF_PROGID_DYNNR     =

*    EXCEPTIONS

*     CNTL_ERROR     = 1

*     CNTL_SYSTEM_ERROR           = 2

*     CREATE_ERROR   = 3

*     LIFETIME_ERROR = 4

*     LIFETIME_DYNPRO_DYNPRO_LINK = 5

*     OTHERS         = 6




    .

  IF SY-SUBRC <> 0.




*   MESSAGE ID SY-MSGID TYPE SY-MSGTY NUMBER SY-MSGNO

*              WITH SY-MSGV1 SY-MSGV2 SY-MSGV3 SY-MSGV4.




  ENDIF.



  CREATE OBJECT GC_GRID

    EXPORTING




*     I_SHELLSTYLE      = 0

*     I_LIFETIME        =




      I_PARENT = GC_CUSTOM




*     I_APPL_EVENTS     = space

*     I_PARENTDBG       =

*     I_APPLOGPARENT    =

*     I_GRAPHICSPARENT  =

*     I_NAME   =

*     I_FCAT_COMPLETE   = SPACE

*    EXCEPTIONS

*     ERROR_CNTL_CREATE = 1

*     ERROR_CNTL_INIT   = 2

*     ERROR_CNTL_LINK   = 3

*     ERROR_DP_CREATE   = 4

*     OTHERS   = 5




    .

  IF SY-SUBRC <> 0.




*   MESSAGE ID SY-MSGID TYPE SY-MSGTY NUMBER SY-MSGNO

*              WITH SY-MSGV1 SY-MSGV2 SY-MSGV3 SY-MSGV4.




  ENDIF.



ENDFORM.




*&---------------------------------------------------------------------*

*&      Form  CALL_ALV

*&---------------------------------------------------------------------*

*       text

*----------------------------------------------------------------------*

*  -->  p1        text

*  <--  p2        text

*----------------------------------------------------------------------*

*&---------------------------------------------------------------------*

*&      Form  FIELD_CATALOG

*&---------------------------------------------------------------------*

*       text

*----------------------------------------------------------------------*

*  -->  p1        text

*  <--  p2        text

*----------------------------------------------------------------------*




FORM FIELD_CATALOG .

  CLEAR GS_FCAT.




*  CLEAR GT_FCAT.

*  GS_FCAT-COL_POS = 0.

*  GS_FCAT-FIELDNAME = 'ZCOLOR'.

*  GS_FCAT-SELTEXT = '##'.

*  GS_FCAT-ICON = 'X'.

*  APPEND GS_FCAT TO GT_FCAT.






  CLEAR GS_FCAT.

  GS_FCAT-COL_POS = 1.

  GS_FCAT-FIELDNAME = 'ZCODE'.

  GS_FCAT-SCRTEXT_M = '####'.

  GS_FCAT-JUST = 'L'.

  APPEND GS_FCAT TO GT_FCAT.



  CLEAR GS_FCAT.

  GS_FCAT-COL_POS = 2.

  GS_FCAT-FIELDNAME = 'ZPERNR'.

  GS_FCAT-SCRTEXT_M = '####'.

  GS_FCAT-JUST = 'C'.

  APPEND GS_FCAT TO GT_FCAT.



  CLEAR GS_FCAT.

  GS_FCAT-COL_POS = 3.

  GS_FCAT-FIELDNAME = 'ZKNAME'.

  GS_FCAT-SCRTEXT_M = '##'.

  APPEND GS_FCAT TO GT_FCAT.



  CLEAR GS_FCAT.

  GS_FCAT-COL_POS = 4.

  GS_FCAT-FIELDNAME = 'ZENAME'.

  GS_FCAT-SCRTEXT_M = '##'.

  APPEND GS_FCAT TO GT_FCAT.



  CLEAR GS_FCAT.

  GS_FCAT-COL_POS = 5.

  GS_FCAT-FIELDNAME = 'ZGNAME'.

  GS_FCAT-SCRTEXT_M = '##'.

  APPEND GS_FCAT TO GT_FCAT.



  CLEAR GS_FCAT.

  GS_FCAT-COL_POS = 6.

  GS_FCAT-FIELDNAME = 'ZTEL'.

  GS_FCAT-SCRTEXT_M = '####'.

  APPEND GS_FCAT TO GT_FCAT.

ENDFORM.




*&---------------------------------------------------------------------*

*&      Form  ALV_SORT

*&---------------------------------------------------------------------*

*       text

*----------------------------------------------------------------------*

*  -->  p1        text

*  <--  p2        text

*----------------------------------------------------------------------*




FORM ALV_SORT .

  CLEAR GT_SORT.

  CLEAR GS_SORT.

  GS_SORT-SPOS = 1.

  GS_SORT-FIELDNAME = 'ZCODE'.

  GS_SORT-UP = 'X'.

  APPEND GS_SORT TO GT_SORT.

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

  CALL METHOD GC_GRID->SET_TABLE_FOR_FIRST_DISPLAY




*    EXPORTING

*      I_BUFFER_ACTIVE               =

*      I_BYPASSING_BUFFER            =

*      I_CONSISTENCY_CHECK           =

*      I_STRUCTURE_NAME              =

*      IS_VARIANT                    =

*      I_SAVE                        =

*      I_DEFAULT                     = 'X'

*      IS_LAYOUT                     =

*      IS_PRINT                      =

*      IT_SPECIAL_GROUPS             =

*      IT_TOOLBAR_EXCLUDING          =

*      IT_HYPERLINK                  =

*      IT_ALV_GRAPHICS               =

*      IT_EXCEPT_QINFO               =

*      IR_SALV_ADAPTER               =




    CHANGING

      IT_OUTTAB       = GT_STUDENT

      IT_FIELDCATALOG = GT_FCAT

      IT_SORT         = GT_SORT




*     IT_FILTER       =

*    EXCEPTIONS

*     INVALID_PARAMETER_COMBINATION = 1

*     PROGRAM_ERROR   = 2

*     TOO_MANY_LINES  = 3

*     OTHERS          = 4




    .

  IF SY-SUBRC <> 0.




*   Implement suitable error handling here




  ENDIF.



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

  GS_LAYOUT-ZEBRA = 'X'. " ## ### ## ### -> ### ## ##. # # #### ## # #

ENDFORM.