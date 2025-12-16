
*&---------------------------------------------------------------------*

*&  Include           ZMM18_001_F01

*&---------------------------------------------------------------------*

*&---------------------------------------------------------------------*

*&      Form  CREATE_OBJECT

*&---------------------------------------------------------------------*




FORM CREATE_OBJECT_0100 .

  CREATE OBJECT GC_DOCKING_0100

    EXPORTING

      REPID     = SY-REPID

      DYNNR     = SY-DYNNR

      EXTENSION = 2000.



  CREATE OBJECT GC_SPLITTER_1

    EXPORTING

      PARENT  = GC_DOCKING_0100

      ROWS    = 2

      COLUMNS = 1.



  CALL METHOD GC_SPLITTER_1->GET_CONTAINER

    EXPORTING

      ROW       = 1

      COLUMN    = 1

    RECEIVING

      CONTAINER = GC_CONTAINER1.



  CALL METHOD GC_SPLITTER_1->GET_CONTAINER

    EXPORTING

      ROW       = 2

      COLUMN    = 1

    RECEIVING

      CONTAINER = GC_CONTAINER2.



  CREATE OBJECT GC_SPLITTER_2

    EXPORTING

      PARENT  = GC_CONTAINER2

      ROWS    = 1

      COLUMNS = 2.



  CALL METHOD GC_SPLITTER_2->GET_CONTAINER

    EXPORTING

      ROW       = 1

      COLUMN    = 1

    RECEIVING

      CONTAINER = GC_CONTAINER3.



  CALL METHOD GC_SPLITTER_2->GET_CONTAINER

    EXPORTING

      ROW       = 1

      COLUMN    = 2

    RECEIVING

      CONTAINER = GC_CONTAINER4.



  CREATE OBJECT GC_GRID1 "#####

    EXPORTING

      I_PARENT = GC_CONTAINER1.



  CREATE OBJECT GC_GRID2 "#######

    EXPORTING

      I_PARENT = GC_CONTAINER3.



  CREATE OBJECT GC_GRID3 "#######

    EXPORTING

      I_PARENT = GC_CONTAINER4.

ENDFORM.

FORM CREATE_OBJECT_0200 .

  CREATE OBJECT GC_DOCKING_0200

    EXPORTING

      REPID     = SY-REPID

      DYNNR     = SY-DYNNR

      EXTENSION = 2000.



  IF SY-SUBRC <> 0.




*   MESSAGE ID SY-MSGID TYPE SY-MSGTY NUMBER SY-MSGNO

*              WITH SY-MSGV1 SY-MSGV2 SY-MSGV3 SY-MSGV4.




  ENDIF.



  CREATE OBJECT GC_GRID_0200

    EXPORTING

      I_PARENT = GC_DOCKING_0200.



  IF SY-SUBRC <> 0.




*   MESSAGE ID SY-MSGID TYPE SY-MSGTY NUMBER SY-MSGNO

*              WITH SY-MSGV1 SY-MSGV2 SY-MSGV3 SY-MSGV4.




  ENDIF.

ENDFORM.




*&---------------------------------------------------------------------*

*&      Form  FIELD_CATALOG

*&---------------------------------------------------------------------*




FORM FIELD_CATALOG_0100 .

  PERFORM CONTAINER2_FIELD.

  PERFORM CONTAINER3_FIELD.

  PERFORM CONTAINER4_FIELD.

ENDFORM.

FORM FIELD_CATALOG_0200 .

  "## ###

  CLEAR: GS_FIELDCAT, GT_FIELDCAT1.

  GS_FIELDCAT-FIELDNAME = 'LIFNR'.

  GS_FIELDCAT-COLTEXT   = '#####'.

  APPEND GS_FIELDCAT TO GT_FIELDCAT1.



  CLEAR GS_FIELDCAT.

  GS_FIELDCAT-FIELDNAME = 'NAME1'.

  GS_FIELDCAT-COLTEXT   = '####'.

  APPEND GS_FIELDCAT TO GT_FIELDCAT1.



  CLEAR GS_FIELDCAT.

  GS_FIELDCAT-FIELDNAME = 'LAND1'.

  GS_FIELDCAT-COLTEXT   = '###'.

  APPEND GS_FIELDCAT TO GT_FIELDCAT1.



  CLEAR GS_FIELDCAT.

  GS_FIELDCAT-FIELDNAME = 'KTOKK'.

  GS_FIELDCAT-COLTEXT   = '#####'.

  APPEND GS_FIELDCAT TO GT_FIELDCAT1.



  CLEAR GS_FIELDCAT.

  GS_FIELDCAT-FIELDNAME = 'STCD1'.

  GS_FIELDCAT-COLTEXT   = '####'.

  APPEND GS_FIELDCAT TO GT_FIELDCAT1.



  CLEAR GS_FIELDCAT.

  GS_FIELDCAT-FIELDNAME = 'STCD2'.

  GS_FIELDCAT-COLTEXT   = '#####'.

  GS_FIELDCAT-EDIT      = 'X'.

  APPEND GS_FIELDCAT TO GT_FIELDCAT1.



  CLEAR GS_FIELDCAT.

  GS_FIELDCAT-FIELDNAME = 'STRAS'.

  GS_FIELDCAT-COLTEXT   = '##'.

  APPEND GS_FIELDCAT TO GT_FIELDCAT1.



  "## ## ###

  CLEAR GS_FIELDCAT.

  GS_FIELDCAT-FIELDNAME = 'BUKRS'.

  GS_FIELDCAT-COLTEXT   = '####'.

  APPEND GS_FIELDCAT TO GT_FIELDCAT1.



  CLEAR GS_FIELDCAT.

  GS_FIELDCAT-FIELDNAME = 'AKONT'.

  GS_FIELDCAT-COLTEXT   = '##'.

  APPEND GS_FIELDCAT TO GT_FIELDCAT1.



  CLEAR GS_FIELDCAT.

  GS_FIELDCAT-FIELDNAME = 'ZTERM'.

  GS_FIELDCAT-COLTEXT   = '####'.

  APPEND GS_FIELDCAT TO GT_FIELDCAT1.



  "## ## ###

  CLEAR GS_FIELDCAT.

  GS_FIELDCAT-FIELDNAME = 'EKORG'.

  GS_FIELDCAT-COLTEXT   = '####'.

  APPEND GS_FIELDCAT TO GT_FIELDCAT1.



  CLEAR GS_FIELDCAT.

  GS_FIELDCAT-FIELDNAME = 'EKGRP'.

  GS_FIELDCAT-COLTEXT   = '####'.

  APPEND GS_FIELDCAT TO GT_FIELDCAT1.



  CLEAR GS_FIELDCAT.

  GS_FIELDCAT-FIELDNAME = 'WAERS'.

  GS_FIELDCAT-COLTEXT   = '##'.

  APPEND GS_FIELDCAT TO GT_FIELDCAT1.



  CLEAR GS_FIELDCAT.

  GS_FIELDCAT-FIELDNAME = 'MWSKZ'.

  GS_FIELDCAT-COLTEXT   = '####'.

  APPEND GS_FIELDCAT TO GT_FIELDCAT1.

ENDFORM.




*&---------------------------------------------------------------------*

*&      FORM CONTAINER2_FIELD  "##### (LFA1)

*&---------------------------------------------------------------------*




FORM CONTAINER2_FIELD .



  CLEAR: GS_FIELDCAT, GT_FIELDCAT1.

  "1. #####

  CLEAR GS_FIELDCAT.

  GS_FIELDCAT-COL_POS   = 1.

  GS_FIELDCAT-FIELDNAME = 'LIFNR'.

  GS_FIELDCAT-SCRTEXT_M = '#####'.

  GS_FIELDCAT-EDIT      = ''.

  APPEND GS_FIELDCAT TO GT_FIELDCAT1.



  "2. ####

  CLEAR GS_FIELDCAT.

  GS_FIELDCAT-COL_POS   = 2.

  GS_FIELDCAT-FIELDNAME = 'NAME1'.

  GS_FIELDCAT-SCRTEXT_M = '####'.

  GS_FIELDCAT-EDIT = 'X'.

  APPEND GS_FIELDCAT TO GT_FIELDCAT1.



  "3. ###

  CLEAR GS_FIELDCAT.

  GS_FIELDCAT-COL_POS   = 3.

  GS_FIELDCAT-FIELDNAME = 'LAND1'.

  GS_FIELDCAT-SCRTEXT_M = '###'.

  GS_FIELDCAT-EDIT = 'X'.

  APPEND GS_FIELDCAT TO GT_FIELDCAT1.



  "4. #####

  CLEAR GS_FIELDCAT.

  GS_FIELDCAT-COL_POS   = 4.

  GS_FIELDCAT-FIELDNAME = 'KTOKK'.

  GS_FIELDCAT-SCRTEXT_M = '#####'.

  GS_FIELDCAT-EDIT = 'X'.

  APPEND GS_FIELDCAT TO GT_FIELDCAT1.



  "5. #### (KTOKK = '3000'# ## ###)

  IF P_KTOKK = '3000'.

    CLEAR GS_FIELDCAT.

    GS_FIELDCAT-COL_POS   = 5.

    GS_FIELDCAT-FIELDNAME = 'STCD1'.

    GS_FIELDCAT-SCRTEXT_M = '####'.

    GS_FIELDCAT-EDIT = 'X'.

    APPEND GS_FIELDCAT TO GT_FIELDCAT1.

  ENDIF.



  "6. ##### (KTOKK = '2000'## ##)

  IF P_KTOKK <> '2000'.

    CLEAR GS_FIELDCAT.

    GS_FIELDCAT-COL_POS   = 6.

    GS_FIELDCAT-FIELDNAME = 'STCD2'.

    GS_FIELDCAT-SCRTEXT_M = '#####'.

    GS_FIELDCAT-EDIT = 'X'.

    APPEND GS_FIELDCAT TO GT_FIELDCAT1.

  ENDIF.



  "7. ##

  CLEAR GS_FIELDCAT.

  GS_FIELDCAT-COL_POS   = 7.

  GS_FIELDCAT-FIELDNAME = 'STRAS'.

  GS_FIELDCAT-SCRTEXT_M = '##'.

  GS_FIELDCAT-EDIT = 'X'.

  APPEND GS_FIELDCAT TO GT_FIELDCAT1.



ENDFORM.




*&---------------------------------------------------------------------*

*&      FORM CONTAINER3_FIELD "####(LFB1)

*&---------------------------------------------------------------------*




FORM CONTAINER3_FIELD .



  CLEAR: GS_FIELDCAT, GT_FIELDCAT2.

  "1. #####

  GS_FIELDCAT-COL_POS   = 1.

  GS_FIELDCAT-FIELDNAME = 'LIFNR'.

  GS_FIELDCAT-SCRTEXT_M = '#####'.

  GS_FIELDCAT-EDIT      = ''.

  APPEND GS_FIELDCAT TO GT_FIELDCAT2.



  "2. ####

  CLEAR GS_FIELDCAT.

  GS_FIELDCAT-COL_POS   = 2.

  GS_FIELDCAT-FIELDNAME = 'BUKRS'.

  GS_FIELDCAT-SCRTEXT_M = '####'.

  GS_FIELDCAT-EDIT = 'X'.

  APPEND GS_FIELDCAT TO GT_FIELDCAT2.



  "3. #####

  "CLEAR GS_FIELDCAT.

  "GS_FIELDCAT-COL_POS   = 3.

  "GS_FIELDCAT-FIELDNAME = 'LOEVM'.

  "GS_FIELDCAT-SCRTEXT_M = '#####'.

  "GS_FIELDCAT-EDIT = 'X'.

  "APPEND GS_FIELDCAT TO GT_FIELDCAT2.



  "4. ##

  CLEAR GS_FIELDCAT.

  GS_FIELDCAT-COL_POS   = 4.

  GS_FIELDCAT-FIELDNAME = 'AKONT'.

  GS_FIELDCAT-SCRTEXT_M = '##'.

  GS_FIELDCAT-EDIT = 'X'.

  APPEND GS_FIELDCAT TO GT_FIELDCAT2.



  "5. ####

  CLEAR GS_FIELDCAT.

  GS_FIELDCAT-COL_POS   = 5.

  GS_FIELDCAT-FIELDNAME = 'ZTERM'.

  GS_FIELDCAT-SCRTEXT_M = '####'.

  GS_FIELDCAT-EDIT = 'X'.

  APPEND GS_FIELDCAT TO GT_FIELDCAT2.



ENDFORM.




*&---------------------------------------------------------------------*

*&      FORM CONTAINER4_FIELD  "####(LFM1)

*&---------------------------------------------------------------------*




FORM CONTAINER4_FIELD .



  CLEAR: GS_FIELDCAT, GT_FIELDCAT3.

  "1. #####

  GS_FIELDCAT-COL_POS   = 1.

  GS_FIELDCAT-FIELDNAME = 'LIFNR'.

  GS_FIELDCAT-SCRTEXT_M = '#####'.

  GS_FIELDCAT-EDIT      = ''.

  APPEND GS_FIELDCAT TO GT_FIELDCAT3.



  "2. ####

  CLEAR GS_FIELDCAT.

  GS_FIELDCAT-COL_POS   = 2.

  GS_FIELDCAT-FIELDNAME = 'EKORG'.

  GS_FIELDCAT-SCRTEXT_M = '####'.

  GS_FIELDCAT-EDIT = 'X'.

  APPEND GS_FIELDCAT TO GT_FIELDCAT3.



  "3. ####

  CLEAR GS_FIELDCAT.

  GS_FIELDCAT-COL_POS   = 3.

  GS_FIELDCAT-FIELDNAME = 'EKGRP'.

  GS_FIELDCAT-SCRTEXT_M = '####'.

  GS_FIELDCAT-EDIT = 'X'.

  APPEND GS_FIELDCAT TO GT_FIELDCAT3.



  "4. #####

  "CLEAR GS_FIELDCAT.

  "GS_FIELDCAT-COL_POS   = 4.

  "GS_FIELDCAT-FIELDNAME = 'LOEVM'.

  "GS_FIELDCAT-SCRTEXT_M = '#####'.

  "GS_FIELDCAT-EDIT = 'X'.

  "APPEND GS_FIELDCAT TO GT_FIELDCAT3.



  "5. ##

  CLEAR GS_FIELDCAT.

  GS_FIELDCAT-COL_POS   = 5.

  GS_FIELDCAT-FIELDNAME = 'WAERS'.

  GS_FIELDCAT-SCRTEXT_M = '##'.

  GS_FIELDCAT-EDIT = 'X'.

  APPEND GS_FIELDCAT TO GT_FIELDCAT3.



  "6. ####

  CLEAR GS_FIELDCAT.

  GS_FIELDCAT-COL_POS   = 6.

  GS_FIELDCAT-FIELDNAME = 'MWSKZ'.

  GS_FIELDCAT-SCRTEXT_M = '####'.

  GS_FIELDCAT-EDIT = 'X'.

  APPEND GS_FIELDCAT TO GT_FIELDCAT3.



ENDFORM.




*&---------------------------------------------------------------------*

*&      Form  ALV_SORT

*&---------------------------------------------------------------------*




FORM ALV_SORT_0100 .

  CLEAR: GS_SORT, GT_SORT1, GT_SORT2, GT_SORT3.



ENDFORM.

FORM ALV_SORT_0200 .

  CLEAR: GS_SORT, GT_SORT1.



  " 1. ## ## ## (### ## ##)

  GS_SORT-SPOS      = 1.       " ## ## (1##)

  GS_SORT-FIELDNAME = 'LIFNR'. " ### ### (### ##)

  GS_SORT-UP        = 'X'.     " ####

  APPEND GS_SORT TO GT_SORT1.



  " 2# ##(#: ####)

  CLEAR GS_SORT.

  GS_SORT-SPOS      = 2.

  GS_SORT-FIELDNAME = 'BUKRS'.

  GS_SORT-UP        = 'X'.

  APPEND GS_SORT TO GT_SORT1.



ENDFORM.




*&---------------------------------------------------------------------*

*&      Form  ALV_LAYOUT

*&---------------------------------------------------------------------*




FORM ALV_LAYOUT .

  CLEAR GS_LAYOUT.

  GS_LAYOUT-ZEBRA = 'X'.

  GS_LAYOUT-CWIDTH_OPT = 'X'.



  CLEAR GS_VARIANT.

  GS_VARIANT-REPORT = SY-REPID.

  GS_VARIANT-USERNAME = SY-UNAME.



ENDFORM.




*&---------------------------------------------------------------------*

*&      Form  ALV_DISPLAY

*&---------------------------------------------------------------------*




FORM ALV_DISPLAY_0100 .

  PERFORM CALL_ALV_DISPLAY USING GT_LFA1_ALV GC_GRID1 GT_FIELDCAT1 GT_SORT1. "#####

  PERFORM CALL_ALV_DISPLAY USING GT_LFB1_ALV GC_GRID2 GT_FIELDCAT2 GT_SORT2. "#######

  PERFORM CALL_ALV_DISPLAY USING GT_LFM1_ALV GC_GRID3 GT_FIELDCAT3 GT_SORT3. "#######

ENDFORM.

FORM ALV_DISPLAY_0200 .

  PERFORM CALL_ALV_DISPLAY USING GT_VIEW_ALV GC_GRID_0200 GT_FIELDCAT1 GT_SORT1.

ENDFORM.




*&---------------------------------------------------------------------*

*&      Form  CALL_ALV_DISPLAY

*&---------------------------------------------------------------------*




FORM CALL_ALV_DISPLAY USING PT_ITAB TYPE STANDARD TABLE

      P_GRID TYPE REF TO CL_GUI_ALV_GRID

  P_FIELDCAT TYPE LVC_T_FCAT

  P_SORT TYPE LVC_T_SORT.



  CALL METHOD P_GRID->SET_TABLE_FOR_FIRST_DISPLAY

    EXPORTING




*     I_BUFFER_ACTIVE =

*     I_BYPASSING_BUFFER            =

*     I_CONSISTENCY_CHECK           =

*     I_STRUCTURE_NAME              =




      IS_VARIANT      = GS_VARIANT

      I_SAVE          = 'A'




*     I_DEFAULT       = 'X'




      IS_LAYOUT       = GS_LAYOUT




*     IS_PRINT        =

*     IT_SPECIAL_GROUPS             =

*     IT_TOOLBAR_EXCLUDING          =

*     IT_HYPERLINK    =

*     IT_ALV_GRAPHICS =

*     IT_EXCEPT_QINFO =

*     IR_SALV_ADAPTER =




    CHANGING

      IT_OUTTAB       = PT_ITAB

      IT_FIELDCATALOG = P_FIELDCAT

      IT_SORT         = P_SORT




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

*&      Form  APPEND_ROW

*&---------------------------------------------------------------------*




FORM APPEND_ROW .



  " ## ### ## (## ## ##)

  FIELD-SYMBOLS: <FS_LFA1> LIKE LINE OF GT_LFA1_ALV,

                 <FS_LFB1> LIKE LINE OF GT_LFB1_ALV,

                 <FS_LFM1> LIKE LINE OF GT_LFM1_ALV.



  " 1. ## ### (LFA1) # ##

  APPEND INITIAL LINE TO GT_LFA1_ALV ASSIGNING <FS_LFA1>.

  <FS_LFA1>-KTOKK = P_KTOKK.  " Selection Screen# ### ## ##

  " LIFNR# ### (## # ##)



  " 2. #### ### (LFB1) # ##

  APPEND INITIAL LINE TO GT_LFB1_ALV ASSIGNING <FS_LFB1>.

  <FS_LFB1>-BUKRS = P_BUKRS.  " Selection Screen# #### ##



  " 3. #### ### (LFM1) # ##

  APPEND INITIAL LINE TO GT_LFM1_ALV ASSIGNING <FS_LFM1>.

  <FS_LFM1>-WAERS = 'KRW'.    " (##) ## #### #### #### ##



  " 4. ## ## (#### ### ## ### ##)

  " Check: ### ### #### ### ## # #### ## ###

  IF GC_GRID1 IS BOUND.

    CALL METHOD GC_GRID1->REFRESH_TABLE_DISPLAY.

  ENDIF.

  IF GC_GRID2 IS BOUND.

    CALL METHOD GC_GRID2->REFRESH_TABLE_DISPLAY.

  ENDIF.

  IF GC_GRID3 IS BOUND.

    CALL METHOD GC_GRID3->REFRESH_TABLE_DISPLAY.

  ENDIF.



ENDFORM.




*&---------------------------------------------------------------------*

*&      Form  ADD_TO_DB

*&---------------------------------------------------------------------*




FORM ADD_TO_DB.



  DATA: LV_VALID TYPE CHAR1.



  " 1. ### ## (## ## # ## ##)

  PERFORM VALIDATE_DATA CHANGING LV_VALID.

  IF LV_VALID <> 'X'.

    EXIT.

  ENDIF.



  " 2. DB ## ##

  PERFORM SAVE_PROCESS.



ENDFORM.




*&---------------------------------------------------------------------*

*&      Form  VALIDATE_DATA

*&---------------------------------------------------------------------*




FORM VALIDATE_DATA CHANGING PV_VALID TYPE CHAR1.



  PV_VALID = 'X'. " ## #### ##



  " 1. ALV ### ##

  IF GC_GRID1 IS BOUND. CALL METHOD GC_GRID1->CHECK_CHANGED_DATA. ENDIF.

  IF GC_GRID2 IS BOUND. CALL METHOD GC_GRID2->CHECK_CHANGED_DATA. ENDIF.

  IF GC_GRID3 IS BOUND. CALL METHOD GC_GRID3->CHECK_CHANGED_DATA. ENDIF.



  " 2. ### ## ## ##

  IF GT_LFA1_ALV IS INITIAL.

    MESSAGE '### #### ####.' TYPE 'S' DISPLAY LIKE 'E'.

    PV_VALID = ' '.

    RETURN.

  ENDIF.



  " 3. ## ## ### ##

  DATA: LV_TABIX TYPE SY-TABIX.



  LOOP AT GT_LFA1_ALV INTO GS_LFA1_ALV.

    LV_TABIX = SY-TABIX.



    " [## ### LFA1]

    IF GS_LFA1_ALV-NAME1 IS INITIAL.

      MESSAGE '####(NAME1)# #####.' TYPE 'S' DISPLAY LIKE 'E'.

      PV_VALID = ' '. RETURN.

    ENDIF.



    IF GS_LFA1_ALV-LAND1 IS INITIAL.

      MESSAGE '###(LAND1)# #####.' TYPE 'S' DISPLAY LIKE 'E'.

      PV_VALID = ' '. RETURN.

    ENDIF.



    " [#### ### LFB1] - ## ## ##

    READ TABLE GT_LFB1_ALV INTO GS_LFB1_ALV INDEX LV_TABIX.

    IF SY-SUBRC = 0.

      " 1) #### (#####)

      IF GS_LFB1_ALV-AKONT IS INITIAL.

        MESSAGE '####(AKONT)# #####.' TYPE 'S' DISPLAY LIKE 'E'.

        PV_VALID = ' '. RETURN.

      ENDIF.



      " 2) ####

      IF GS_LFB1_ALV-ZTERM IS INITIAL.

        MESSAGE '####(ZTERM)# #####.' TYPE 'S' DISPLAY LIKE 'E'.

        PV_VALID = ' '. RETURN.

      ENDIF.

    ENDIF.



    " [#### ### LFM1] - ## ## ##

    READ TABLE GT_LFM1_ALV INTO GS_LFM1_ALV INDEX LV_TABIX.

    IF SY-SUBRC = 0.

      " 1) ### (## # # ##)

      IF GS_LFM1_ALV-WAERS IS INITIAL.

        MESSAGE '##(WAERS)# #####.' TYPE 'S' DISPLAY LIKE 'E'.

        PV_VALID = ' '. RETURN.

      ENDIF.

    ENDIF.



  ENDLOOP.



ENDFORM.




*&---------------------------------------------------------------------*

*&      Form  SAVE_PROCESS

*&---------------------------------------------------------------------*

* ## ## # DB INSERT ##

*----------------------------------------------------------------------*




FORM SAVE_PROCESS.



  " SNRO ## ## ### ## (## ## ## #### #####)

  DATA: LV_NEXT_NUMBER TYPE LIFNR,

        LV_RC          TYPE INRI-RETURNCODE,

        LV_NR_RANGE    TYPE INRI-NRRANGENR VALUE '01',    " ####

        LV_OBJECT      TYPE INRI-OBJECT    VALUE 'ZVENDOR18', " SNRO ####

        LV_MAX_LIFNR   TYPE LIFNR,

        LV_CURRENT_NR  TYPE NRIV-NRLEVEL.



  DATA: LV_TABIX TYPE SY-TABIX.



  " 1. DB ### ### ### ### ### (### # ###)

  CLEAR: GT_LFA1, GT_LFB1, GT_LFM1.



  " (1) DB(ZLFA1_18)## ## # ## ##

  SELECT MAX( LIFNR ) INTO LV_MAX_LIFNR FROM ZLFA1_18.



  " (2) ## SNRO ##(NRIV ###) ##

  SELECT SINGLE NRLEVEL

    INTO LV_CURRENT_NR

    FROM NRIV

   WHERE OBJECT    = LV_OBJECT    " ZVENDOR

     AND NRRANGENR = LV_NR_RANGE. " 01



  " (3) DB### SNRO## # ## ## #### (SQL UPDATE ##)

  IF SY-SUBRC = 0 AND LV_MAX_LIFNR > LV_CURRENT_NR.



    UPDATE NRIV

       SET NRLEVEL = LV_MAX_LIFNR  " DB# ##### ## ### ##

     WHERE OBJECT    = LV_OBJECT

       AND NRRANGENR = LV_NR_RANGE.



    IF SY-SUBRC = 0.

      COMMIT WORK. " #### ##

    ENDIF.

  ENDIF.

  " 2. ### ## # ## Loop

  LOOP AT GT_LFA1_ALV INTO GS_LFA1_ALV.

    LV_TABIX = SY-TABIX.



    " 2-1. ## ## (NUMBER_GET_NEXT)

    CALL FUNCTION 'NUMBER_GET_NEXT'

      EXPORTING

        NR_RANGE_NR = LV_NR_RANGE

        OBJECT      = LV_OBJECT

      IMPORTING

        NUMBER      = LV_NEXT_NUMBER

        RETURNCODE  = LV_RC

      EXCEPTIONS

        OTHERS      = 1.



    IF SY-SUBRC <> 0.

      ROLLBACK WORK.

      MESSAGE ID SY-MSGID TYPE SY-MSGTY NUMBER SY-MSGNO

         WITH SY-MSGV1 SY-MSGV2 SY-MSGV3 SY-MSGV4.

      EXIT.

    ENDIF.



    " 2-2. ## ### (LFA1) ## -> TOP# ## GS_LFA1 ##

    CLEAR GS_LFA1.

    MOVE-CORRESPONDING GS_LFA1_ALV TO GS_LFA1.

    GS_LFA1-LIFNR = LV_NEXT_NUMBER. " ### ## ##

    APPEND GS_LFA1 TO GT_LFA1.      " TOP# ## GT_LFA1# ##



    " 2-3. #### ### (LFB1) ##

    READ TABLE GT_LFB1_ALV INTO GS_LFB1_ALV INDEX LV_TABIX.

    IF SY-SUBRC = 0.

      CLEAR GS_LFB1.

      MOVE-CORRESPONDING GS_LFB1_ALV TO GS_LFB1.

      GS_LFB1-LIFNR = LV_NEXT_NUMBER.

      GS_LFB1-BUKRS = P_BUKRS.

      APPEND GS_LFB1 TO GT_LFB1.    " TOP# ## GT_LFB1# ##

    ENDIF.



    " 2-4. #### ### (LFM1) ##

    READ TABLE GT_LFM1_ALV INTO GS_LFM1_ALV INDEX LV_TABIX.

    IF SY-SUBRC = 0.

      CLEAR GS_LFM1.

      MOVE-CORRESPONDING GS_LFM1_ALV TO GS_LFM1.

      GS_LFM1-LIFNR = LV_NEXT_NUMBER.

      APPEND GS_LFM1 TO GT_LFM1.    " TOP# ## GT_LFM1# ##

    ENDIF.



  ENDLOOP.



  " 3. DB Insert (### ### ##)

  IF GT_LFA1 IS NOT INITIAL.

    INSERT ZLFA1_18 FROM TABLE GT_LFA1 ACCEPTING DUPLICATE KEYS.

    INSERT ZLFB1_18 FROM TABLE GT_LFB1 ACCEPTING DUPLICATE KEYS.

    INSERT ZLFM1_18 FROM TABLE GT_LFM1 ACCEPTING DUPLICATE KEYS.



    IF SY-SUBRC = 0.

      COMMIT WORK AND WAIT.

      MESSAGE '##### #######.' TYPE 'S'.



      " ## # ALV # ### ###

      CLEAR: GT_LFA1_ALV, GT_LFB1_ALV, GT_LFM1_ALV.



      IF GC_GRID1 IS BOUND.

        CALL METHOD GC_GRID1->REFRESH_TABLE_DISPLAY.

      ENDIF.

      IF GC_GRID2 IS BOUND.

        CALL METHOD GC_GRID2->REFRESH_TABLE_DISPLAY.

      ENDIF.

      IF GC_GRID3 IS BOUND.

        CALL METHOD GC_GRID3->REFRESH_TABLE_DISPLAY.

      ENDIF.



    ELSE.

      ROLLBACK WORK.

      MESSAGE '### ######.' TYPE 'E'.

    ENDIF.

  ENDIF.



ENDFORM.




*&---------------------------------------------------------------------*

*&      Form  SAVE_TO_DB

*&---------------------------------------------------------------------*

*       text

*----------------------------------------------------------------------*

*  -->  p1        text

*  <--  p2        text

*----------------------------------------------------------------------*




FORM SAVE_TO_DB .

DATA: LV_UPD_CNT TYPE I.



  " 1. ALV #### ##### ### ###(GT_VIEW_ALV)# ##

  "    (## # ## #### ### ## GT_VIEW_ALV ## ####)

  IF GC_GRID_0200 IS BOUND.

    CALL METHOD GC_GRID_0200->CHECK_CHANGED_DATA.

  ENDIF.



  " 2. ### ## ## ##

  IF GT_VIEW_ALV IS INITIAL.

    MESSAGE '### #### ####.' TYPE 'S' DISPLAY LIKE 'E'.

    EXIT.

  ENDIF.



  " 3. DB #### ## (Loop ### ##### ####)

  "    * ###: ## #### #### ## ## ###### # ###,

  "      #### #### ## ### ## ### #######.

  LOOP AT GT_VIEW_ALV INTO GS_VIEW_ALV.



    " ZLFA1_18 #### STCD2 ### # ### #### (Key: LIFNR)

    UPDATE ZLFA1_18

       SET STCD2 = GS_VIEW_ALV-STCD2

     WHERE LIFNR = GS_VIEW_ALV-LIFNR.



    IF SY-SUBRC = 0.

      ADD 1 TO LV_UPD_CNT.

    ENDIF.



  ENDLOOP.



  " 4. ## ### # Commit

  IF LV_UPD_CNT > 0.

    COMMIT WORK AND WAIT.

    MESSAGE '##### #######.' TYPE 'S'.

  ELSE.

    ROLLBACK WORK.

    MESSAGE '##### ### ### ######.' TYPE 'S' DISPLAY LIKE 'E'.

  ENDIF.

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

  LOOP AT SCREEN.



    " 1. ##(P_CR) ### ##### #

    IF P_CR = 'X'.

      IF SCREEN-GROUP1 = 'M1'.      " M1: ### ## (###)

        SCREEN-ACTIVE = '1'.

      ELSEIF SCREEN-GROUP1 = 'M2'.  " M2: ### ## (###)

        SCREEN-ACTIVE = '0'.

      ENDIF.



      " 2. ##(P_DIS) ### ##### #

    ELSEIF P_DIS = 'X'.

      IF SCREEN-GROUP1 = 'M1'.      " M1: ### ## (###)

        SCREEN-ACTIVE = '0'.

      ELSEIF SCREEN-GROUP1 = 'M2'.  " M2: ### ## (###)

        SCREEN-ACTIVE = '1'.

      ENDIF.

    ENDIF.



    " ### ## ##

    MODIFY SCREEN.



  ENDLOOP.

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

  " 1. ###

  CLEAR: GT_VIEW_ALV.



  " 2. ## ## ## (### ### ## # ## ## ##)

  RANGES: LR_LIFNR FOR ZLFA1_18-LIFNR.



  IF P_LIFNR IS NOT INITIAL.

    LR_LIFNR-SIGN   = 'I'.

    LR_LIFNR-OPTION = 'EQ'.

    LR_LIFNR-LOW    = P_LIFNR.

    APPEND LR_LIFNR.

  ENDIF.



  " 3. ### ## (INNER JOIN)

  "    LFA1(##) + LFB1(##) + LFM1(##) #### ### ###

  "    TOP# ### TY_VIEW_ALL ### #### ##

  SELECT A~LIFNR A~NAME1 A~LAND1 A~KTOKK A~STCD1 A~STCD2 A~STRAS

         B~BUKRS B~AKONT B~ZTERM B~LOEVM AS LOEVM_B1

         C~EKORG C~EKGRP C~WAERS C~MWSKZ C~LOEVM AS LOEVM_M1

    INTO CORRESPONDING FIELDS OF TABLE GT_VIEW_ALV

    FROM ZLFA1_18 AS A

    INNER JOIN ZLFB1_18 AS B ON A~LIFNR = B~LIFNR

    INNER JOIN ZLFM1_18 AS C ON A~LIFNR = C~LIFNR

   WHERE B~BUKRS EQ P_BUKRS    " ##### ## ##

     AND A~LIFNR IN LR_LIFNR.  " ###### ##### ##, ### ##



  " 4. ## ##

  IF GT_VIEW_ALV IS INITIAL.

    MESSAGE '### ## #### ####.' TYPE 'S' DISPLAY LIKE 'E'.

  ELSE.

    MESSAGE '#######.' TYPE 'S'.

  ENDIF.

ENDFORM.




*&---------------------------------------------------------------------*

*&      Form  VALIDATE_SCR_INPUT

*&---------------------------------------------------------------------*

*       text

*----------------------------------------------------------------------*

*  -->  p1        text

*  <--  p2        text

*----------------------------------------------------------------------*




FORM VALIDATE_SCR_INPUT .

    " 1. [## ##]# # ##

    IF P_CR = 'X'.

      " #### ##

      IF P_BUKRS IS INITIAL.

        SET CURSOR FIELD 'P_BUKRS'. " ### ## ### ##

        MESSAGE '####(P_BUKRS)# ######.' TYPE 'E'.

      ENDIF.



      " ##### ##

      IF P_KTOKK IS INITIAL.

        SET CURSOR FIELD 'P_KTOKK'.

        MESSAGE '#####(P_KTOKK)# ######.' TYPE 'E'.

      ENDIF.



      " 2. [## ##]# # ##

    ELSEIF P_DIS = 'X'.

      " #### ##

      IF P_BUKRS IS INITIAL.

        SET CURSOR FIELD 'P_BUKRS'.

        MESSAGE '####(P_BUKRS)# ######.' TYPE 'E'.

      ENDIF.



      IF P_LIFNR IS INITIAL.

        SET CURSOR FIELD 'P_LIFNR'.

        MESSAGE '#####(P_LIFNR)# ######.' TYPE 'E'.

      ENDIF.

    ENDIF.

ENDFORM.