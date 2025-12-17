
*&---------------------------------------------------------------------*

*&  Include           ZDOCKING_CONTAINER05_F01

*&---------------------------------------------------------------------*



*&---------------------------------------------------------------------*

*&      Form  GET_DATA

*&---------------------------------------------------------------------*

*       text

*----------------------------------------------------------------------*

*  -->  p1        text

*  <--  p2        text

*----------------------------------------------------------------------*




FORM GET_DATA.

  SELECT A~ZCODE,

         A~ZPERNR,

         A~ZKNAME,

         A~ZENAME,

         A~ZGENDER,

         B~ZSUM,

         B~ZMAJOR,

         B~ZMNAME

    FROM ZEDT05_001 AS A

    INNER JOIN ZEDT05_002 AS B

      ON A~ZCODE = B~ZCODE

    INTO CORRESPONDING FIELDS OF TABLE @GT_STUDENT

    WHERE A~ZCODE IN @S_ZCODE.

ENDFORM.




*&---------------------------------------------------------------------*

*&      Form  CREATE_OBJECT

*&---------------------------------------------------------------------*

*       text

*----------------------------------------------------------------------*

*  -->  p1        text

*  <--  p2        text

*----------------------------------------------------------------------*




form CREATE_OBJECT .

  create object GC_DOCKING

    exporting




*      PARENT                      =




      REPID                       = SY-REPID

      DYNNR                       = SY-DYNNR




*      SIDE                        = DOCK_AT_LEFT




      EXTENSION                   = 2000




*      STYLE                       =

*      LIFETIME                    = lifetime_default

*      CAPTION                     =

*      METRIC                      = 0

*      RATIO                       =

*      NO_AUTODEF_PROGID_DYNNR     =

*      NAME                        =

*    exceptions

*      CNTL_ERROR                  = 1

*      CNTL_SYSTEM_ERROR           = 2

*      CREATE_ERROR                = 3

*      LIFETIME_ERROR              = 4

*      LIFETIME_DYNPRO_DYNPRO_LINK = 5

*      OTHERS                      = 6




      .

  if SY-SUBRC <> 0.




*   MESSAGE ID SY-MSGID TYPE SY-MSGTY NUMBER SY-MSGNO

*              WITH SY-MSGV1 SY-MSGV2 SY-MSGV3 SY-MSGV4.




  endif.





  create object GC_GRID

    exporting




*      I_SHELLSTYLE      = 0

*      I_LIFETIME        =




      I_PARENT          = GC_DOCKING




*      I_APPL_EVENTS     = space

*      I_PARENTDBG       =

*      I_APPLOGPARENT    =

*      I_GRAPHICSPARENT  =

*      I_NAME            =

*      I_FCAT_COMPLETE   = SPACE

*    exceptions

*      ERROR_CNTL_CREATE = 1

*      ERROR_CNTL_INIT   = 2

*      ERROR_CNTL_LINK   = 3

*      ERROR_DP_CREATE   = 4

*      OTHERS            = 5




      .

  if SY-SUBRC <> 0.




*   MESSAGE ID SY-MSGID TYPE SY-MSGTY NUMBER SY-MSGNO

*              WITH SY-MSGV1 SY-MSGV2 SY-MSGV3 SY-MSGV4.




  endif.






*

*  create object GC_SPLITTER

*    exporting

**      LINK_DYNNR        =

**      LINK_REPID        =

**      SHELLSTYLE        =

**      LEFT              =

**      TOP               =

**      WIDTH             =

**      HEIGHT            =

**      METRIC            = cntl_metric_dynpro

**      ALIGN             = 15

*      PARENT            = GC_DOCKING

*      ROWS              = 2

*      COLUMNS           = 1

**      NO_AUTODEF_PROGID_DYNNR =

**      NAME              =

**    exceptions

**      CNTL_ERROR        = 1

**      CNTL_SYSTEM_ERROR = 2

**      OTHERS            = 3

*      .

*  if SY-SUBRC <> 0.

**   MESSAGE ID SY-MSGID TYPE SY-MSGTY NUMBER SY-MSGNO

**              WITH SY-MSGV1 SY-MSGV2 SY-MSGV3 SY-MSGV4.

*  endif.

*

*

*

*  call method GC_SPLITTER->GET_CONTAINER

*    exporting

*      ROW       = 1

*      COLUMN    = 1

*    receiving

*      CONTAINER = GC_CONTAINER1.

*      .

*

*

*  call method GC_SPLITTER->GET_CONTAINER

*    exporting

*      ROW       = 2

*      COLUMN    = 1

*    receiving

*      CONTAINER = GC_CONTAINER2

*      .

*

*

*  create object GC_GRID1

*    exporting

**      I_SHELLSTYLE      = 0

**      I_LIFETIME        =

*      I_PARENT          = GC_CONTAINER1

**      I_APPL_EVENTS     = space

**      I_PARENTDBG       =

**      I_APPLOGPARENT    =

**      I_GRAPHICSPARENT  =

**      I_NAME            =

**      I_FCAT_COMPLETE   = SPACE

**    exceptions

**      ERROR_CNTL_CREATE = 1

**      ERROR_CNTL_INIT   = 2

**      ERROR_CNTL_LINK   = 3

**      ERROR_DP_CREATE   = 4

**      OTHERS            = 5

*      .

*  if SY-SUBRC <> 0.

**   MESSAGE ID SY-MSGID TYPE SY-MSGTY NUMBER SY-MSGNO

**              WITH SY-MSGV1 SY-MSGV2 SY-MSGV3 SY-MSGV4.

*  endif.

*

*

*

*create object GC_GRID2

*  exporting

**    I_SHELLSTYLE      = 0

**    I_LIFETIME        =

*    I_PARENT          = GC_CONTAINER2

**    I_APPL_EVENTS     = space

**    I_PARENTDBG       =

**    I_APPLOGPARENT    =

**    I_GRAPHICSPARENT  =

**    I_NAME            =

**    I_FCAT_COMPLETE   = SPACE

**  exceptions

**    ERROR_CNTL_CREATE = 1

**    ERROR_CNTL_INIT   = 2

**    ERROR_CNTL_LINK   = 3

**    ERROR_DP_CREATE   = 4

**    OTHERS            = 5

*    .

*if SY-SUBRC <> 0.

** MESSAGE ID SY-MSGID TYPE SY-MSGTY NUMBER SY-MSGNO

**            WITH SY-MSGV1 SY-MSGV2 SY-MSGV3 SY-MSGV4.

*endif.






endform.




*&---------------------------------------------------------------------*

*&      Form  ALV_LAYOUT

*&---------------------------------------------------------------------*

*       text

*----------------------------------------------------------------------*

*  -->  p1        text

*  <--  p2        text

*----------------------------------------------------------------------*




form ALV_LAYOUT .

  GS_LAYOUT-ZEBRA = 'X'.




*  PERFORM CONTAINER1_SORT.

*  PERFORM CONTAINER2_SORT.




endform.




*&---------------------------------------------------------------------*

*&      Form  ALV_SORT

*&---------------------------------------------------------------------*

*       text

*----------------------------------------------------------------------*

*  -->  p1        text

*  <--  p2        text

*----------------------------------------------------------------------*




form ALV_SORT .

  CLEAR : GS_SORT, GT_SORT.



  GS_SORT-SPOS = 1.

  GS_SORT-FIELDNAME = 'ZPERNR'.

  GS_SORT-UP = 'X'.

  APPEND GS_SORT TO GT_SORT.

endform.




*&---------------------------------------------------------------------*

*&      Form  CALL_ALV

*&---------------------------------------------------------------------*

*       text

*----------------------------------------------------------------------*

*  -->  p1        text

*  <--  p2        text

*----------------------------------------------------------------------*




form CALL_ALV .



endform.




*&---------------------------------------------------------------------*

*&      Form  CONTAINER1_FIELD

*&---------------------------------------------------------------------*

*       text

*----------------------------------------------------------------------*

*  -->  p1        text

*  <--  p2        text

*----------------------------------------------------------------------*




form CONTAINER1_FIELD .



endform.




*&---------------------------------------------------------------------*

*&      Form  CONTAINER2_FIELD

*&---------------------------------------------------------------------*

*       text

*----------------------------------------------------------------------*

*  -->  p1        text

*  <--  p2        text

*----------------------------------------------------------------------*




form CONTAINER2_FIELD .



endform.




*&---------------------------------------------------------------------*

*&      Form  CONTAINER1_SORT

*&---------------------------------------------------------------------*

*       text

*----------------------------------------------------------------------*

*  -->  p1        text

*  <--  p2        text

*----------------------------------------------------------------------*




form CONTAINER1_SORT .



endform.




*&---------------------------------------------------------------------*

*&      Form  ALV_DISPLAY

*&---------------------------------------------------------------------*

*       text

*----------------------------------------------------------------------*

*  -->  p1        text

*  <--  p2        text

*----------------------------------------------------------------------*



*&---------------------------------------------------------------------*

*&      Form  SET_INIT

*&---------------------------------------------------------------------*

*       text

*----------------------------------------------------------------------*

*  -->  p1        text

*  <--  p2        text

*----------------------------------------------------------------------*




form SET_INIT .

  S_ZCODE-LOW = 'SSU-01'.

  S_ZCODE-HIGH = 'SSU-99'.

  APPEND S_ZCODE.



endform.



FORM FIELD_CATALOG .

  CLEAR GS_FIELDCAT.

  CLEAR GT_FIELDCAT.





  GS_FIELDCAT-COL_POS = 1.

  GS_FIELDCAT-FIELDNAME = 'ZCODE'.



  GS_FIELDCAT-KEY = 'X'.

  GS_FIELDCAT-JUST = 'L'.

  APPEND GS_FIELDCAT TO GT_FIELDCAT.



  CLEAR GS_FIELDCAT.

  GS_FIELDCAT-COL_POS = 2.

  GS_FIELDCAT-FIELDNAME = 'ZPERNR'.

  GS_FIELDCAT-KEY = 'X'.

  GS_FIELDCAT-JUST = 'L'.

  APPEND GS_FIELDCAT TO GT_FIELDCAT.



  CLEAR GS_FIELDCAT.

  GS_FIELDCAT-COL_POS = 3.

  GS_FIELDCAT-FIELDNAME = 'ZKNAME'.

  APPEND GS_FIELDCAT TO GT_FIELDCAT.



  CLEAR GS_FIELDCAT.

  GS_FIELDCAT-COL_POS = 4.

  GS_FIELDCAT-FIELDNAME = 'ZENAME'.

  APPEND GS_FIELDCAT TO GT_FIELDCAT.



  CLEAR GS_FIELDCAT.

  GS_FIELDCAT-COL_POS = 5.

  GS_FIELDCAT-FIELDNAME = 'ZGENDER'.

  APPEND GS_FIELDCAT TO GT_FIELDCAT.



  CLEAR GS_FIELDCAT.

  GS_FIELDCAT-COL_POS = 6.

  GS_FIELDCAT-FIELDNAME = 'ZSUM'.

  GS_FIELDCAT-DO_SUM = 'X'.

  APPEND GS_FIELDCAT TO GT_FIELDCAT.



  CLEAR GS_FIELDCAT.

  GS_FIELDCAT-COL_POS = 7.

  GS_FIELDCAT-FIELDNAME = 'ZMAJOR'.

  GS_FIELDCAT-JUST = 'L'.

  APPEND GS_FIELDCAT TO GT_FIELDCAT.



  CLEAR GS_FIELDCAT.

  GS_FIELDCAT-COL_POS = 8.

  GS_FIELDCAT-FIELDNAME = 'ZMNAME'.

  APPEND GS_FIELDCAT TO GT_FIELDCAT.

ENDFORM.




*&---------------------------------------------------------------------*

*&      Form  ALV_DISPLAY

*&---------------------------------------------------------------------*

*       text

*----------------------------------------------------------------------*

*  -->  p1        text

*  <--  p2        text

*----------------------------------------------------------------------*




form ALV_DISPLAY .

  call method GC_GRID->SET_TABLE_FOR_FIRST_DISPLAY

    exporting




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




    changing

      IT_OUTTAB                     = GT_STUDENT

      IT_FIELDCATALOG               =  GT_FIELDCAT

      IT_SORT                       = GT_SORT




*      IT_FILTER                     =

*    exceptions

*      INVALID_PARAMETER_COMBINATION = 1

*      PROGRAM_ERROR                 = 2

*      TOO_MANY_LINES                = 3

*      OTHERS                        = 4




          .

  if SY-SUBRC <> 0.




*   Implement suitable error handling here




  endif.



endform.