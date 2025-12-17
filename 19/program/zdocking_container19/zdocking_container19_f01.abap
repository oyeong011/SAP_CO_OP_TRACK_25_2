
*&---------------------------------------------------------------------*

*&  Include           ZDOCKING_CONTAINER19_F01

*&---------------------------------------------------------------------*






FORM CREATE_OBJECT.

CREATE OBJECT GC_DOCKING

  EXPORTING




*    PARENT                      =




    REPID                       = SY-REPID

    DYNNR                       = SY-DYNNR




*    SIDE                        = DOCK_AT_LEFT




    EXTENSION                   = 2000




*    STYLE                       =

*    LIFETIME                    = lifetime_default

*    CAPTION                     =

*    METRIC                      = 0

*    RATIO                       =

*    NO_AUTODEF_PROGID_DYNNR     =

*    NAME                        =

*  EXCEPTIONS

*    CNTL_ERROR                  = 1

*    CNTL_SYSTEM_ERROR           = 2

*    CREATE_ERROR                = 3

*    LIFETIME_ERROR              = 4

*    LIFETIME_DYNPRO_DYNPRO_LINK = 5

*    others                      = 6




    .

IF SY-SUBRC <> 0.




* MESSAGE ID SY-MSGID TYPE SY-MSGTY NUMBER SY-MSGNO

*            WITH SY-MSGV1 SY-MSGV2 SY-MSGV3 SY-MSGV4.




ENDIF.



  CREATE OBJECT GC_GRID

    EXPORTING




*      I_SHELLSTYLE      = 0

*      I_LIFETIME        =




      I_PARENT          = GC_DOCKING "##### ### ###




*      I_APPL_EVENTS     = space

*      I_PARENTDBG       =

*      I_APPLOGPARENT    =

*      I_GRAPHICSPARENT  =

*      I_NAME            =

*      I_FCAT_COMPLETE   = SPACE

*    EXCEPTIONS

*      ERROR_CNTL_CREATE = 1

*      ERROR_CNTL_INIT   = 2

*      ERROR_CNTL_LINK   = 3

*      ERROR_DP_CREATE   = 4

*      others            = 5




      .

  IF SY-SUBRC <> 0.




*   MESSAGE ID SY-MSGID TYPE SY-MSGTY NUMBER SY-MSGNO

*              WITH SY-MSGV1 SY-MSGV2 SY-MSGV3 SY-MSGV4.




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

   CLEAR : gs_fieldcat.



  gs_fieldcat-col_pos = 1.

  gs_fieldcat-fieldname = 'ZCODE'.

  gs_fieldcat-coltext = '####'.

  APPEND gs_fieldcat TO gt_fieldcat.



  CLEAR : gs_fieldcat.



  gs_fieldcat-col_pos = 2.

  gs_fieldcat-fieldname = 'ZPERNR'.

  gs_fieldcat-coltext = '####'.

  APPEND gs_fieldcat TO gt_fieldcat.



  CLEAR : gs_fieldcat.



  gs_fieldcat-col_pos = 3.

  gs_fieldcat-fieldname = 'ZKNAME'.

  gs_fieldcat-coltext = '####'.

  APPEND gs_fieldcat TO gt_fieldcat.



  CLEAR : gs_fieldcat.



  gs_fieldcat-col_pos = 4.

  gs_fieldcat-fieldname = 'ZENAME'.

  gs_fieldcat-coltext = '####'.

  APPEND gs_fieldcat TO gt_fieldcat.



  CLEAR : gs_fieldcat.



  gs_fieldcat-col_pos = 5.

  gs_fieldcat-fieldname = 'ZGENDER'.

  gs_fieldcat-coltext = '##'.

  APPEND gs_fieldcat TO gt_fieldcat.



  CLEAR : gs_fieldcat.



  gs_fieldcat-col_pos = 6.

  gs_fieldcat-fieldname = 'ZSUM'.

  gs_fieldcat-coltext = '#'.

  APPEND gs_fieldcat TO gt_fieldcat.



  CLEAR : gs_fieldcat.



  gs_fieldcat-col_pos = 7.

  gs_fieldcat-fieldname = 'ZMAJOR'.

  gs_fieldcat-coltext = '####'.

  APPEND gs_fieldcat TO gt_fieldcat.



  CLEAR : gs_fieldcat.



  gs_fieldcat-col_pos = 8.

  gs_fieldcat-fieldname = 'ZMNAME'.

  gs_fieldcat-coltext = '###'.

  APPEND gs_fieldcat TO gt_fieldcat.

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

  PERFORM ALV_DISPLAY.

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

  SELECT * FROM ZEDT19_0001

    INTO CORRESPONDING FIELDS OF TABLE GT_STUDENT

  WHERE ZCODE IN S_ZCODE.

ENDFORM.




*&---------------------------------------------------------------------*

*&      Form  SET_INIT

*&---------------------------------------------------------------------*

*       text

*----------------------------------------------------------------------*

*  -->  p1        text

*  <--  p2        text

*----------------------------------------------------------------------*




FORM SET_INIT .

  S_ZCODE-LOW = 'SSU-01'.

  S_ZCODE-HIGH = 'SSU-99'.

  APPEND S_ZCODE.

ENDFORM.



FORM ALV_DISPLAY.

  CALL METHOD GC_GRID->SET_TABLE_FOR_FIRST_DISPLAY

    EXPORTING




*      I_BUFFER_ACTIVE               =

*      I_BYPASSING_BUFFER            =

*      I_CONSISTENCY_CHECK           =

*      I_STRUCTURE_NAME              =

*      IS_VARIANT                    =

*      I_SAVE                        =

*      I_DEFAULT                     = 'X'




      IS_LAYOUT                     = GS_LAYOUT




*      IS_PRINT                      =

*      IT_SPECIAL_GROUPS             =

*      IT_TOOLBAR_EXCLUDING          =

*      IT_HYPERLINK                  =

*      IT_ALV_GRAPHICS               =

*      IT_EXCEPT_QINFO               =

*      IR_SALV_ADAPTER               =




    CHANGING

      IT_OUTTAB                     = GT_STUDENT

      IT_FIELDCATALOG               = GT_FIELDCAT

      IT_SORT                       = GT_SORT




*      IT_FILTER                     =

*    EXCEPTIONS

*      INVALID_PARAMETER_COMBINATION = 1

*      PROGRAM_ERROR                 = 2

*      TOO_MANY_LINES                = 3

*      others                        = 4




          .

  IF SY-SUBRC <> 0.




*   Implement suitable error handling here




  ENDIF.



ENDFORM.




*&---------------------------------------------------------------------*

*&      Form  REFRESH

*&---------------------------------------------------------------------*

*       text

*----------------------------------------------------------------------*

*  -->  p1        text

*  <--  p2        text

*----------------------------------------------------------------------*




FORM REFRESH .

  DATA : LS_STABLE TYPE LVC_S_STBL.



  LS_STABLE-ROW = 'X'.

  LS_STABLE-COL = 'X'.



  CALL METHOD GC_GRID->REFRESH_TABLE_DISPLAY

    EXPORTING

      IS_STABLE      = LS_STABLE




*      I_SOFT_REFRESH =

*    EXCEPTIONS

*      FINISHED       = 1

*      others         = 2




          .

  IF SY-SUBRC <> 0.




*   Implement suitable error handling here




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

  LOOP AT GT_STUDENT INTO GS_STUDENT.

    MODIFY GT_STUDENT FROM GS_STUDENT.

  ENDLOOP.

ENDFORM.