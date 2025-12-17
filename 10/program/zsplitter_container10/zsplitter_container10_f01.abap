
*&---------------------------------------------------------------------*

*&  Include           ZSPLITTER_CONTAINER10_F01

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

  SELECT T1~ZCODE T1~ZPERNR T1~ZKNAME T1~ZENAME T1~ZGENDER

    T2~ZSUM T2~ZMAJOR T2~ZMNAME

    FROM ZEDT10_001 AS T1

    INNER JOIN ZEDT10_002 AS T2

      ON T2~ZCODE = T1~ZCODE

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




      EXTENSION = 2000




*     STYLE     =

*     LIFETIME  = lifetime_default

*     CAPTION   =

*     METRIC    = 0

*     RATIO     =

*     NO_AUTODEF_PROGID_DYNNR     =

*     NAME      =

*    EXCEPTIONS

*     CNTL_ERROR                  = 1

*     CNTL_SYSTEM_ERROR           = 2

*     CREATE_ERROR                = 3

*     LIFETIME_ERROR              = 4

*     LIFETIME_DYNPRO_DYNPRO_LINK = 5

*     OTHERS    = 6




    .

  IF SY-SUBRC <> 0.




*   MESSAGE ID SY-MSGID TYPE SY-MSGTY NUMBER SY-MSGNO

*              WITH SY-MSGV1 SY-MSGV2 SY-MSGV3 SY-MSGV4.




  ENDIF.



  CREATE OBJECT GC_SPLITTER

    EXPORTING

      LINK_DYNNR = SY-DYNNR

      LINK_REPID = SY-REPID




*     SHELLSTYLE =

*     LEFT       =

*     TOP        =

*     WIDTH      =

*     HEIGHT     =

*     METRIC     = cntl_metric_dynpro

*     ALIGN      = 15




      PARENT     = GC_DOCKING

      ROWS       = 2

      COLUMNS    = 1




*     NO_AUTODEF_PROGID_DYNNR =

*     NAME       =

*    EXCEPTIONS

*     CNTL_ERROR = 1

*     CNTL_SYSTEM_ERROR = 2

*     OTHERS     = 3




    .

  IF SY-SUBRC <> 0.




*   MESSAGE ID SY-MSGID TYPE SY-MSGTY NUMBER SY-MSGNO

*              WITH SY-MSGV1 SY-MSGV2 SY-MSGV3 SY-MSGV4.




  ENDIF.



  CALL METHOD GC_SPLITTER->GET_CONTAINER

    EXPORTING

      ROW       = 1

      COLUMN    = 1

    RECEIVING

      CONTAINER = GC_CONTAINER1.



  CALL METHOD GC_SPLITTER->GET_CONTAINER

    EXPORTING

      ROW       = 2

      COLUMN    = 1

    RECEIVING

      CONTAINER = GC_CONTAINER2.



  CREATE OBJECT GC_GRID1

    EXPORTING




*     I_SHELLSTYLE      = 0

*     I_LIFETIME        =




      I_PARENT = GC_CONTAINER1




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



  CREATE OBJECT GC_GRID2

    EXPORTING




*     I_SHELLSTYLE      = 0

*     I_LIFETIME        =




      I_PARENT = GC_CONTAINER2




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

*&      Form  ALV_DISPLAY

*&---------------------------------------------------------------------*

*       text

*----------------------------------------------------------------------*

*  -->  p1        text

*  <--  p2        text

*----------------------------------------------------------------------*




FORM ALV_DISPLAY .

  CALL METHOD GC_GRID1->SET_TABLE_FOR_FIRST_DISPLAY

    EXPORTING




*     I_BUFFER_ACTIVE =

*     I_BYPASSING_BUFFER            =

*     I_CONSISTENCY_CHECK           =

*     I_STRUCTURE_NAME              =




     IS_VARIANT      =

     I_SAVE          = 'A'




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

*&      Form  FIELD_CAT

*&---------------------------------------------------------------------*

*       text

*----------------------------------------------------------------------*

*  -->  p1        text

*  <--  p2        text

*----------------------------------------------------------------------*




FORM FIELD_CAT .



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



ENDFORM.