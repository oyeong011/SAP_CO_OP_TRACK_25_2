
*&---------------------------------------------------------------------*

*&  Include           ZEDR04_083_F01

*&---------------------------------------------------------------------*

*&---------------------------------------------------------------------*

*&      Form  SET_INIT

*&---------------------------------------------------------------------*




FORM SET_INIT.

  S_ZCODE-LOW = 'SSU-01'.

  S_ZCODE-HIGH = 'SSU-99'.

  APPEND S_ZCODE.

ENDFORM.




*&---------------------------------------------------------------------*

*&      Form  GET_DATA

*&---------------------------------------------------------------------*




FORM GET_DATA .

  SELECT * FROM ZEDT04_001

    INTO CORRESPONDING FIELDS OF TABLE GT_STUDENT

    WHERE ZCODE IN S_ZCODE.

ENDFORM.




*&---------------------------------------------------------------------*

*&      Form  CREATE_OBJECT (##)

*&---------------------------------------------------------------------*




FORM CREATE_OBJECT .




*  " 1. CUSTOM CONTAINER

*  CREATE OBJECT GC_CUSTOM

*    EXPORTING

*      CONTAINER_NAME              = 'CON01'.   " 100# ###->LAYOUT->CUSTOM CONTROL

*

*  CREATE OBJECT GC_GRID

*    EXPORTING

*      I_PARENT          = GC_CUSTOM.



*  " 2. DOCKING CONTAINER

*  CREATE OBJECT GC_DOCKING

*    EXPORTING

*      REPID                       = SY-REPID  " #### ID

*      DYNNR                       = SY-DYNNR  " ### ##

*      EXTENSION                   = 2000.     " ## ##

*

*  CREATE OBJECT GC_GRID

*    EXPORTING

*      I_PARENT          = GC_DOCKING.






  " 3. SPLITTER CONTAINER

  CREATE OBJECT GC_DOCKING

    EXPORTING

      REPID                       = SY-REPID  " #### ID

      DYNNR                       = SY-DYNNR  " ### ##

      EXTENSION                   = 2000.     " ## ##



  CREATE OBJECT GC_SPLITTER

    EXPORTING

      PARENT            = GC_DOCKING

      ROWS              = 2

      COLUMNS           = 1.



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

      I_PARENT          = GC_CONTAINER1.



  CREATE OBJECT GC_GRID2

    EXPORTING

      I_PARENT          = GC_CONTAINER2.

ENDFORM.




*&---------------------------------------------------------------------*

*&      Form  FIELD_CATALOG (##)

*&---------------------------------------------------------------------*




FORM FIELD_CATALOG .




*  " ### 3. SPLITTER# ## #### ## ##

*  PERFORM CONTAINER1_FIELD.

*  PERFORM CONTAINER2_FIELD.






  CLEAR : GS_FIELDCAT, GT_FIELDCAT.

  GS_FIELDCAT-COL_POS = 1.

  GS_FIELDCAT-FIELDNAME = 'ZCODE'.

  GS_FIELDCAT-SCRTEXT_M = '####'.   " ### ##

  GS_FIELDCAT-KEY = 'X'.  " ###. ## ##. #### # ##.

  APPEND GS_FIELDCAT TO GT_FIELDCAT.



  CLEAR : GS_FIELDCAT.

  GS_FIELDCAT-COL_POS = 2.

  GS_FIELDCAT-FIELDNAME = 'ZPERNR'.

  GS_FIELDCAT-SCRTEXT_M = '####'.

  GS_FIELDCAT-KEY = 'X'.

  APPEND GS_FIELDCAT TO GT_FIELDCAT.



  CLEAR : GS_FIELDCAT.

  GS_FIELDCAT-COL_POS = 3.

  GS_FIELDCAT-FIELDNAME = 'ZKNAME'.

  GS_FIELDCAT-SCRTEXT_M = '##'.

  APPEND GS_FIELDCAT TO GT_FIELDCAT.



  CLEAR : GS_FIELDCAT.

  GS_FIELDCAT-COL_POS = 4.

  GS_FIELDCAT-FIELDNAME = 'ZENAME'.

  GS_FIELDCAT-SCRTEXT_M = '###'.

  APPEND GS_FIELDCAT TO GT_FIELDCAT.



  CLEAR : GS_FIELDCAT.

  GS_FIELDCAT-COL_POS = 5.

  GS_FIELDCAT-FIELDNAME = 'ZGENDER'.

  GS_FIELDCAT-SCRTEXT_M = '##'.

  APPEND GS_FIELDCAT TO GT_FIELDCAT.

ENDFORM.




*&---------------------------------------------------------------------*

*&      Form  ALV_LAYOUT (##)

*&---------------------------------------------------------------------*




FORM ALV_LAYOUT .

  CLEAR GS_LAYOUT.

  GS_LAYOUT-ZEBRA = 'X'.          " ## ## # ### ##



  " 2. 3. ## ##

  CLEAR GS_VARIANT.

  GS_VARIANT-REPORT = SY-REPID.

  GS_VARIANT-USERNAME = SY-UNAME.

ENDFORM.




*&---------------------------------------------------------------------*

*&      Form  ALV_SORT

*&---------------------------------------------------------------------*




FORM ALV_SORT .




*  " ### 3. SPLITTER# ALV SORT ## ##

*  PERFORM CONTAINER1_SORT.

*  PERFORM CONTAINER2_SORT.






  GS_SORT-SPOS = 1.             " ## ## (## ####?)

  GS_SORT-FIELDNAME = 'ZCODE'.

  GS_SORT-UP = 'X'.             " ####

  APPEND GS_SORT TO GT_SORT.

ENDFORM.




*&---------------------------------------------------------------------*

*&      Form  ALV_DISPLAY (##)

*&---------------------------------------------------------------------*




FORM ALV_DISPLAY .




*  " 1. CUSTOM, 2. DOCKING CONTAINER

*  CALL METHOD GC_GRID->SET_TABLE_FOR_FIRST_DISPLAY

*    EXPORTING

*      IS_LAYOUT                     = GS_LAYOUT

**      IS_VARIANT                    = GS_VARIANT  " 2.

**      I_SAVE                        = 'A'         " 2. ALV#### #### ##### ## ##

*    CHANGING

*      IT_OUTTAB                     = GT_STUDENT

*      IT_FIELDCATALOG               = GT_FIELDCAT

*      IT_SORT                       = GT_SORT.






  " 3. SPLITTER CONTAINER

  CALL METHOD GC_GRID1->SET_TABLE_FOR_FIRST_DISPLAY

    EXPORTING

      IS_VARIANT                    = GS_VARIANT

      I_SAVE                        = 'A'

      IS_LAYOUT                     = GS_LAYOUT

    CHANGING

      IT_OUTTAB                     = GT_STUDENT

      IT_FIELDCATALOG               = GT_FIELDCAT

      IT_SORT                       = GT_SORT.



  CALL METHOD GC_GRID2->SET_TABLE_FOR_FIRST_DISPLAY

    EXPORTING

      IS_VARIANT                    = GS_VARIANT

      I_SAVE                        = 'A'

      IS_LAYOUT                     = GS_LAYOUT

    CHANGING

      IT_OUTTAB                     = GT_STUDENT

      IT_FIELDCATALOG               = GT_FIELDCAT

      IT_SORT                       = GT_SORT.

ENDFORM.