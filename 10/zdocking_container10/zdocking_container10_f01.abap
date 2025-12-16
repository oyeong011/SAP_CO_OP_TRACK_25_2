
*&---------------------------------------------------------------------*

*&  Include           ZDOCKING_CONTAINER10_F01

*&---------------------------------------------------------------------*



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




*&---------------------------------------------------------------------*

*&      Form  GET_DATA

*&---------------------------------------------------------------------*

*       text

*----------------------------------------------------------------------*

*  -->  p1        text

*  <--  p2        text

*----------------------------------------------------------------------*




FORM GET_DATA .

  SELECT

    T1~ZCODE T1~ZPERNR T1~ZKNAME T1~ZENAME T1~ZGENDER




*    T2~ZSUM T2~ZMAJOR T2~ZMNAME




    FROM ZEDT10_001 AS T1




*    INNER JOIN ZEDT10_002 AS T2

*      ON T2~ZCODE = T1~ZCODE




    INTO CORRESPONDING FIELDS OF TABLE GT_STUDENT.

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

  CREATE OBJECT GC_DOCKING

    EXPORTING




*     PARENT    =




      REPID     = SY-REPID

      DYNNR     = SY-DYNNR




*     SIDE      = DOCK_AT_LEFT




      EXTENSION = 5000




*     STYLE     =

*     LIFETIME  = lifetime_default

*     CAPTION   =

*     METRIC    = 0

*     RATIO     =

*     NO_AUTODEF_PROGID_DYNNR     =

*     NAME      =

*  EXCEPTIONS

*     CNTL_ERROR                  = 1

*     CNTL_SYSTEM_ERROR           = 2

*     CREATE_ERROR                = 3

*     LIFETIME_ERROR              = 4

*     LIFETIME_DYNPRO_DYNPRO_LINK = 5

*     OTHERS    = 6




    .

  IF SY-SUBRC <> 0.




* MESSAGE ID SY-MSGID TYPE SY-MSGTY NUMBER SY-MSGNO

*            WITH SY-MSGV1 SY-MSGV2 SY-MSGV3 SY-MSGV4.




  ENDIF.



  CREATE OBJECT GC_GRID

    EXPORTING




*     I_SHELLSTYLE      = 0

*     I_LIFETIME        =




      I_PARENT = GC_DOCKING




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

*&      Form  FILED_CAT

*&---------------------------------------------------------------------*

*       text

*----------------------------------------------------------------------*

*  -->  p1        text

*  <--  p2        text

*----------------------------------------------------------------------*




FORM FILED_CAT .

  CLEAR GT_FCAT.






*  CLEAR GS_FCAT.

*  GS_FCAT-COL_POS = '0'.

*  GS_FCAT-FIELDNAME = 'ZCOLOR'.

*  GS_FCAT-SELTEXT = '##'.

*  GS_FCAT-ICON = 'X'.

*  APPEND GS_FCAT TO GT_FCAT.






  CLEAR GS_FCAT.

  GS_FCAT-COL_POS = '1'.

  GS_FCAT-FIELDNAME = 'ZCODE'.

  GS_FCAT-SELTEXT = '##ID'.

  GS_FCAT-KEY = 'X'.

  APPEND GS_FCAT TO GT_FCAT.



  CLEAR GS_FCAT.

  GS_FCAT-COL_POS = '2'.

  GS_FCAT-FIELDNAME = 'ZPERNR'.

  GS_FCAT-SELTEXT = '####'.

  GS_FCAT-JUST = 'L'.

  APPEND GS_FCAT TO GT_FCAT.



  CLEAR GS_FCAT.

  GS_FCAT-COL_POS = '3'.

  GS_FCAT-FIELDNAME = 'ZKNAME'.

  GS_FCAT-SELTEXT = '##'.

  GS_FCAT-JUST = 'M'.

  APPEND GS_FCAT TO GT_FCAT.



  CLEAR GS_FCAT.

  GS_FCAT-COL_POS = '4'.

  GS_FCAT-FIELDNAME = 'ZENAME'.

  GS_FCAT-SELTEXT = '#'.

  GS_FCAT-JUST = 'M'.

  APPEND GS_FCAT TO GT_FCAT.






*  CLEAR GS_FCAT.

*  GS_FCAT-COL_POS = '5'.

*  GS_FCAT-FIELDNAME = 'ZGENDER'.

*  GS_FCAT-SELTEXT = '##'.

*  GS_FCAT-JUST = 'M'.

*  APPEND GS_FCAT TO GT_FCAT.

*

*  CLEAR GS_FCAT.

*  GS_FCAT-COL_POS = '6'.

*  GS_FCAT-FIELDNAME = 'ZSUM'.

*  GS_FCAT-SELTEXT = '##'.

*  GS_FCAT-JUST = 'M'.

*  APPEND GS_FCAT TO GT_FCAT.

*

*  CLEAR GS_FCAT.

*  GS_FCAT-COL_POS = '7'.

*  GS_FCAT-FIELDNAME = 'ZMAJOR'.

*  GS_FCAT-SELTEXT = '####'.

*  GS_FCAT-JUST = 'M'.

*  APPEND GS_FCAT TO GT_FCAT.

*

*  CLEAR GS_FCAT.

*  GS_FCAT-COL_POS = '8'.

*  GS_FCAT-FIELDNAME = 'ZMNAME'.

*  GS_FCAT-SELTEXT = '###'.

*  APPEND GS_FCAT TO GT_FCAT.






ENDFORM.




*&---------------------------------------------------------------------*

*&      Form  ALV_LAYO

*&---------------------------------------------------------------------*

*       text

*----------------------------------------------------------------------*

*  -->  p1        text

*  <--  p2        text

*----------------------------------------------------------------------*




FORM ALV_LAYO .

  CLEAR GS_LAYO.

  GS_LAYO-ZEBRA = 'X'.



  CLEAR GS_VARIANT.

  GS_VARIANT-REPORT = SY-REPID.

  GS_VARIANT-USERNAME = SY-UNAME.

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

    EXPORTING




*     I_BUFFER_ACTIVE =

*     I_BYPASSING_BUFFER            =

*     I_CONSISTENCY_CHECK           =

*     I_STRUCTURE_NAME              =

*     IS_VARIANT      =

*     I_SAVE          =

*     I_DEFAULT       = 'X'




      IS_LAYOUT       = GS_LAYO




*     IS_PRINT        =

*     IT_SPECIAL_GROUPS             =

*     IT_TOOLBAR_EXCLUDING          =

*     IT_HYPERLINK    =

*     IT_ALV_GRAPHICS =

*     IT_EXCEPT_QINFO =

*     IR_SALV_ADAPTER =




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

*&      Form  REFRESH

*&---------------------------------------------------------------------*

*       text

*----------------------------------------------------------------------*

*  -->  p1        text

*  <--  p2        text

*----------------------------------------------------------------------*




FORM REFRESH .

  DATA: LS_STABLE TYPE LVC_S_STBL.

  LS_STABLE-ROW = 'X'.

  LS_STABLE-COL = 'X'.

  CALL METHOD GC_GRID->REFRESH_TABLE_DISPLAY

    EXPORTING

      IS_STABLE = LS_STABLE




*     I_SOFT_REFRESH =

*      EXCEPTIONS

*     FINISHED  = 1

*     OTHERS    = 2




    .

  IF SY-SUBRC <> 0.




*     Implement suitable error handling here




  ENDIF.



ENDFORM.