
*&---------------------------------------------------------------------*

*&  Include           ZEDR01_023_F01

*&---------------------------------------------------------------------*



*&---------------------------------------------------------------------*

*&      Form  SET_INIT

*&---------------------------------------------------------------------*




FORM SET_INIT .



  S_ZCODE-LOW = 'SSU-01'.

  S_ZCODE-HIGH = 'SSU-99'.

  APPEND S_ZCODE.



ENDFORM.




*&---------------------------------------------------------------------*

*&      Form  GET_DATA

*&---------------------------------------------------------------------*




FORM GET_DATA .

  SELECT * FROM ZEDT01_002

    INTO CORRESPONDING FIELDS OF TABLE GT_STUDENT

    WHERE ZCODE IN S_ZCODE.

ENDFORM.




*&---------------------------------------------------------------------*

*&      Form  FIELD_CATALOG

*&---------------------------------------------------------------------*




FORM FIELD_CATALOG .




* PERFORM CONTAINER_FIELD.




 PERFORM CONTAINER1_FIELD.

 PERFORM CONTAINER2_FIELD.

ENDFORM.




*&---------------------------------------------------------------------*

*&      Form  ALV_LAYOUT

*&---------------------------------------------------------------------*




FORM ALV_LAYOUT .

  PERFORM CONTAINER_LAYOUT.

ENDFORM.




*&---------------------------------------------------------------------*

*&      Form  ALV_SORT

*&---------------------------------------------------------------------*




FORM ALV_SORT .




*  PERFORM CONTAINER_SORT.




  PERFORM CONTAINER1_SORT.

  PERFORM CONTAINER2_SORT.

ENDFORM.




*&---------------------------------------------------------------------*

*&      Form  CREATE_OBJECT

*&---------------------------------------------------------------------*

*       text

*----------------------------------------------------------------------*

*  -->  p1        text

*  <--  p2        text

*----------------------------------------------------------------------*




FORM CREATE_OBJECT .

  CREATE OBJECT GC_DOCKING

    EXPORTING




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

*    EXCEPTIONS

*      CNTL_ERROR                  = 1

*      CNTL_SYSTEM_ERROR           = 2

*      CREATE_ERROR                = 3

*      LIFETIME_ERROR              = 4

*      LIFETIME_DYNPRO_DYNPRO_LINK = 5

*      others                      = 6




      .

  CREATE OBJECT GC_SPLITTER

    EXPORTING




*      LINK_DYNNR        =

*      LINK_REPID        =

*      SHELLSTYLE        =

*      LEFT              =

*      TOP               =

*      WIDTH             =

*      HEIGHT            =

*      METRIC            = cntl_metric_dynpro

*      ALIGN             = 15




      PARENT            = GC_DOCKING

      ROWS              = 2

      COLUMNS           = 1




*      NO_AUTODEF_PROGID_DYNNR =

*      NAME              =

*    EXCEPTIONS

*      CNTL_ERROR        = 1

*      CNTL_SYSTEM_ERROR = 2

*      others            = 3




      .






*  CREATE OBJECT GC_GRID

*    EXPORTING

**      I_SHELLSTYLE      = 0

**      I_LIFETIME        =

*      I_PARENT          = GC_DOCKING

**      I_APPL_EVENTS     = space

**      I_PARENTDBG       =

**      I_APPLOGPARENT    =

**      I_GRAPHICSPARENT  =

**      I_NAME            =

**      I_FCAT_COMPLETE   = SPACE

**    EXCEPTIONS

**      ERROR_CNTL_CREATE = 1

**      ERROR_CNTL_INIT   = 2

**      ERROR_CNTL_LINK   = 3

**      ERROR_DP_CREATE   = 4

**      others            = 5

*      .






  CALL METHOD GC_SPLITTER->GET_CONTAINER

    EXPORTING

      ROW       = 1

      COLUMN    = 1

    RECEIVING

      CONTAINER = GC_CONTAINER1

      .

  CALL METHOD GC_SPLITTER->GET_CONTAINER

    EXPORTING

      ROW       = 2

      COLUMN    = 1

    RECEIVING

      CONTAINER = GC_CONTAINER2

      .



CREATE OBJECT GC_GRID1

  EXPORTING




*    I_SHELLSTYLE      = 0

*    I_LIFETIME        =




    I_PARENT          = GC_CONTAINER1




*    I_APPL_EVENTS     = space

*    I_PARENTDBG       =

*    I_APPLOGPARENT    =

*    I_GRAPHICSPARENT  =

*    I_NAME            =

*    I_FCAT_COMPLETE   = SPACE

*  EXCEPTIONS

*    ERROR_CNTL_CREATE = 1

*    ERROR_CNTL_INIT   = 2

*    ERROR_CNTL_LINK   = 3

*    ERROR_DP_CREATE   = 4

*    others            = 5




    .



CREATE OBJECT GC_GRID2

  EXPORTING




*    I_SHELLSTYLE      = 0

*    I_LIFETIME        =




    I_PARENT          = GC_CONTAINER2




*    I_APPL_EVENTS     = space

*    I_PARENTDBG       =

*    I_APPLOGPARENT    =

*    I_GRAPHICSPARENT  =

*    I_NAME            =

*    I_FCAT_COMPLETE   = SPACE

*  EXCEPTIONS

*    ERROR_CNTL_CREATE = 1

*    ERROR_CNTL_INIT   = 2

*    ERROR_CNTL_LINK   = 3

*    ERROR_DP_CREATE   = 4

*    others            = 5




    .





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








*  CALL METHOD GC_GRID->SET_TABLE_FOR_FIRST_DISPLAY

*    EXPORTING

**      I_BUFFER_ACTIVE               =

**      I_BYPASSING_BUFFER            =

**      I_CONSISTENCY_CHECK           =

**      I_STRUCTURE_NAME              =

**      IS_VARIANT                    =

**      I_SAVE                        =

**      I_DEFAULT                     = 'X'

*      IS_LAYOUT                     = GS_LAYOUT

**      IS_PRINT                      =

**      IT_SPECIAL_GROUPS             =

**      IT_TOOLBAR_EXCLUDING          =

**      IT_HYPERLINK                  =

**      IT_ALV_GRAPHICS               =

**      IT_EXCEPT_QINFO               =

**      IR_SALV_ADAPTER               =

*    CHANGING

*      IT_OUTTAB                     = GT_STUDENT

*      IT_FIELDCATALOG               = GT_FIELDCAT

*      IT_SORT                       = GT_SORT

**      IT_FILTER                     =

**    EXCEPTIONS

**      INVALID_PARAMETER_COMBINATION = 1

**      PROGRAM_ERROR                 = 2

**      TOO_MANY_LINES                = 3

**      others                        = 4

*          .




CALL METHOD GC_GRID1->SET_TABLE_FOR_FIRST_DISPLAY

   EXPORTING




*    I_BUFFER_ACTIVE               =

*    I_BYPASSING_BUFFER            =

*    I_CONSISTENCY_CHECK           =

*    I_STRUCTURE_NAME              =




    IS_VARIANT                    = GS_VARIENT

    I_SAVE                        = 'A'




*    I_DEFAULT                     = 'X'




    IS_LAYOUT                     = GS_LAYOUT




*    IS_PRINT                      =

*    IT_SPECIAL_GROUPS             =

*    IT_TOOLBAR_EXCLUDING          =

*    IT_HYPERLINK                  =

*    IT_ALV_GRAPHICS               =

*    IT_EXCEPT_QINFO               =

*    IR_SALV_ADAPTER               =




  CHANGING

    IT_OUTTAB                     = GT_STUDENT

    IT_FIELDCATALOG               = GT_FIELDCAT1

    IT_SORT                       = GT_SORT1




*    IT_FILTER                     =

*  EXCEPTIONS

*    INVALID_PARAMETER_COMBINATION = 1

*    PROGRAM_ERROR                 = 2

*    TOO_MANY_LINES                = 3

*    others                        = 4




        .

CALL METHOD GC_GRID2->SET_TABLE_FOR_FIRST_DISPLAY

  EXPORTING




*    I_BUFFER_ACTIVE               =

*    I_BYPASSING_BUFFER            =

*    I_CONSISTENCY_CHECK           =

*    I_STRUCTURE_NAME              =




    IS_VARIANT                    = GS_VARIENT

    I_SAVE                        = 'A'




*    I_DEFAULT                     = 'X'




    IS_LAYOUT                     = GS_LAYOUT




*    IS_PRINT                      =

*    IT_SPECIAL_GROUPS             =

*    IT_TOOLBAR_EXCLUDING          =

*    IT_HYPERLINK                  =

*    IT_ALV_GRAPHICS               =

*    IT_EXCEPT_QINFO               =

*    IR_SALV_ADAPTER               =




  CHANGING

    IT_OUTTAB                     = GT_STUDENT

    IT_FIELDCATALOG               = GT_FIELDCAT2

    IT_SORT                       = GT_SORT2




*    IT_FILTER                     =

*  EXCEPTIONS

*    INVALID_PARAMETER_COMBINATION = 1

*    PROGRAM_ERROR                 = 2

*    TOO_MANY_LINES                = 3

*    others                        = 4




        .



ENDFORM.




*&---------------------------------------------------------------------*

*&      Form  CONTAINER_FIELD

*&---------------------------------------------------------------------*




FORM CONTAINER_FIELD .

  CLEAR : GS_FIELDCAT,GT_FIELDCAT.

  GS_FIELDCAT-COL_POS = 1.

  GS_FIELDCAT-FIELDNAME = 'ZCOLOR'.

  GS_FIELDCAT-SCRTEXT_M = '##'.

  GS_FIELDCAT-ICON = 'X'.

  APPEND GS_FIELDCAT TO GT_FIELDCAT.



  CLEAR : GS_FIELDCAT.

  GS_FIELDCAT-COL_POS = 2.

  GS_FIELDCAT-FIELDNAME = 'ZCODE'.

  GS_FIELDCAT-SCRTEXT_M = '####'.

  GS_FIELDCAT-KEY = 'X'. "# ### ## ### ###### ###

  GS_FIELDCAT-JUST = 'L'.

  APPEND GS_FIELDCAT TO GT_FIELDCAT.



  CLEAR : GS_FIELDCAT.

  GS_FIELDCAT-COL_POS = 3.

  GS_FIELDCAT-FIELDNAME = 'ZPERNR'.

  GS_FIELDCAT-SCRTEXT_M = '####'.

  GS_FIELDCAT-KEY = 'X'.

  APPEND GS_FIELDCAT TO GT_FIELDCAT.



  CLEAR : GS_FIELDCAT.

  GS_FIELDCAT-COL_POS = 4.

  GS_FIELDCAT-FIELDNAME = 'ZMAJOR'.

  GS_FIELDCAT-SCRTEXT_M = '##'.

  APPEND GS_FIELDCAT TO GT_FIELDCAT.



  CLEAR : GS_FIELDCAT.

  GS_FIELDCAT-COL_POS = 5.

  GS_FIELDCAT-FIELDNAME = 'ZMNAME'.

  GS_FIELDCAT-SCRTEXT_M = '###'.

  APPEND GS_FIELDCAT TO GT_FIELDCAT.



  CLEAR : GS_FIELDCAT.

  GS_FIELDCAT-COL_POS = 6.

  GS_FIELDCAT-FIELDNAME = 'ZGENDER'.

  GS_FIELDCAT-SCRTEXT_M = '##'.

  APPEND GS_FIELDCAT TO GT_FIELDCAT.

ENDFORM.




*&---------------------------------------------------------------------*

*&      Form  CONTAINER1_FIELD

*&---------------------------------------------------------------------*




FORM CONTAINER1_FIELD .

  CLEAR : GS_FIELDCAT,GT_FIELDCAT1.

  GS_FIELDCAT-COL_POS = 2.

  GS_FIELDCAT-FIELDNAME = 'ZCODE'.

  GS_FIELDCAT-SCRTEXT_M = '####'.

  GS_FIELDCAT-KEY = 'X'. "# ### ## ### ###### ###

  GS_FIELDCAT-JUST = 'L'.

  APPEND GS_FIELDCAT TO GT_FIELDCAT1.



  CLEAR : GS_FIELDCAT.

  GS_FIELDCAT-COL_POS = 3.

  GS_FIELDCAT-FIELDNAME = 'ZPERNR'.

  GS_FIELDCAT-SCRTEXT_M = '####'.

  GS_FIELDCAT-KEY = 'X'.

  APPEND GS_FIELDCAT TO GT_FIELDCAT1.



  CLEAR : GS_FIELDCAT.

  GS_FIELDCAT-COL_POS = 4.

  GS_FIELDCAT-FIELDNAME = 'ZMAJOR'.

  GS_FIELDCAT-SCRTEXT_M = '##'.

  APPEND GS_FIELDCAT TO GT_FIELDCAT1.



  CLEAR : GS_FIELDCAT.

  GS_FIELDCAT-COL_POS = 5.

  GS_FIELDCAT-FIELDNAME = 'ZMNAME'.

  GS_FIELDCAT-SCRTEXT_M = '###'.

  APPEND GS_FIELDCAT TO GT_FIELDCAT1.



  CLEAR : GS_FIELDCAT.

  GS_FIELDCAT-COL_POS = 6.

  GS_FIELDCAT-FIELDNAME = 'ZGENDER'.

  GS_FIELDCAT-SCRTEXT_M = '##'.

  APPEND GS_FIELDCAT TO GT_FIELDCAT1.



ENDFORM.




*&---------------------------------------------------------------------*

*&      Form  CONTAINER2_FIELD

*&---------------------------------------------------------------------*




FORM CONTAINER2_FIELD .

  CLEAR : GS_FIELDCAT,GT_FIELDCAT2.

  GS_FIELDCAT-COL_POS = 2.

  GS_FIELDCAT-FIELDNAME = 'ZCODE'.

  GS_FIELDCAT-SCRTEXT_M = '####'.

  GS_FIELDCAT-KEY = 'X'. "# ### ## ### ###### ###

  GS_FIELDCAT-JUST = 'L'.

  APPEND GS_FIELDCAT TO GT_FIELDCAT2.



  CLEAR : GS_FIELDCAT.

  GS_FIELDCAT-COL_POS = 3.

  GS_FIELDCAT-FIELDNAME = 'ZPERNR'.

  GS_FIELDCAT-SCRTEXT_M = '####'.

  GS_FIELDCAT-KEY = 'X'.

  APPEND GS_FIELDCAT TO GT_FIELDCAT2.



  CLEAR : GS_FIELDCAT.

  GS_FIELDCAT-COL_POS = 4.

  GS_FIELDCAT-FIELDNAME = 'ZMAJOR'.

  GS_FIELDCAT-SCRTEXT_M = '##'.

  APPEND GS_FIELDCAT TO GT_FIELDCAT2.



  CLEAR : GS_FIELDCAT.

  GS_FIELDCAT-COL_POS = 5.

  GS_FIELDCAT-FIELDNAME = 'ZMNAME'.

  GS_FIELDCAT-SCRTEXT_M = '###'.

  APPEND GS_FIELDCAT TO GT_FIELDCAT2.



  CLEAR : GS_FIELDCAT.

  GS_FIELDCAT-COL_POS = 6.

  GS_FIELDCAT-FIELDNAME = 'ZGENDER'.

  GS_FIELDCAT-SCRTEXT_M = '##'.

  APPEND GS_FIELDCAT TO GT_FIELDCAT2.

ENDFORM.




*&---------------------------------------------------------------------*

*&      Form  CONTAINER_SORT

*&---------------------------------------------------------------------*




FORM CONTAINER_SORT .

    GS_SORT-SPOS = 1.

    GS_SORT-FIELDNAME = 'ZCODE'.

    GS_SORT-UP = 'X'. "##

    APPEND GS_SORT TO GT_SORT.

ENDFORM.




*&---------------------------------------------------------------------*

*&      Form  CONTAINER1_SORT

*&---------------------------------------------------------------------*




FORM CONTAINER1_SORT .

    GS_SORT-SPOS = 1.

    GS_SORT-FIELDNAME = 'ZCODE'.

    GS_SORT-UP = 'X'. "##

    APPEND GS_SORT TO GT_SORT1.

ENDFORM.




*&---------------------------------------------------------------------*

*&      Form  CONTAINER2_SORT

*&---------------------------------------------------------------------*




FORM CONTAINER2_SORT .

    GS_SORT-SPOS = 1.

    GS_SORT-FIELDNAME = 'ZCODE'.

    GS_SORT-UP = 'X'. "##

    APPEND GS_SORT TO GT_SORT2.

ENDFORM.




*&---------------------------------------------------------------------*

*&      Form  CONTAINER_LAYOUT

*&---------------------------------------------------------------------*




FORM CONTAINER_LAYOUT .

  GS_LAYOUT-ZEBRA = 'X'. " ### ## ###




*  GS_LAYOUT-TOTALS_BEFORE_ITEMS = 'X'. "## ## ####




ENDFORM.




*&---------------------------------------------------------------------*

*&      Form  CONTAINER1_LAYOUT

*&---------------------------------------------------------------------*




FORM CONTAINER1_LAYOUT .

  GS_LAYOUT1-ZEBRA = 'X'. " ### ## ###

ENDFORM.




*&---------------------------------------------------------------------*

*&      Form  CONTAINER2_LAYOUT

*&---------------------------------------------------------------------*




FORM CONTAINER2_LAYOUT .

  GS_LAYOUT2-ZEBRA = 'X'. " ### ## ###

ENDFORM.