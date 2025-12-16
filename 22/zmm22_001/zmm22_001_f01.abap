
*&---------------------------------------------------------------------*

*&  Include           ZMM22_001_F01

*&---------------------------------------------------------------------*

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



    CASE SCREEN-GROUP1.



      WHEN 'M1'.   "## ## ## (P_KTOKK)

        IF P_CRE = 'X'.

          SCREEN-ACTIVE = 1.

          SCREEN-INPUT  = 1.

        ELSE.

          SCREEN-ACTIVE = 0.

        ENDIF.



      WHEN 'M2'.   "## ## ## (P_LIFNR)

        IF P_VIEW = 'X'.

          SCREEN-ACTIVE = 1.

          SCREEN-INPUT  = 1.

        ELSE.

          SCREEN-ACTIVE = 0.

        ENDIF.



      WHEN 'M0'.   "## (P_BUKRS)

        SCREEN-ACTIVE = 1.

        SCREEN-INPUT  = 1.



    ENDCASE.



    MODIFY SCREEN.

  ENDLOOP.



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

      REPID                       = SY-REPID

      DYNNR                       = SY-DYNNR

      EXTENSION                   = 2000.



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



  CREATE OBJECT GC_SPLITTER2

    EXPORTING



    PARENT            = GC_CONTAINER1

    ROWS              = 1

    COLUMNS           = 2.



  CALL METHOD GC_SPLITTER2->GET_CONTAINER

    EXPORTING

      ROW       = 1

      COLUMN    = 1

   RECEIVING

      CONTAINER = GC_CONTAINER3.



  CALL METHOD GC_SPLITTER2->GET_CONTAINER

    EXPORTING

      ROW       = 1

      COLUMN    = 2

    RECEIVING

      CONTAINER = GC_CONTAINER4.



  CREATE OBJECT GC_GRID1

    EXPORTING

      I_PARENT          = GC_CONTAINER3.



  CREATE OBJECT GC_GRID2

    EXPORTING

      I_PARENT          = GC_CONTAINER4.



  CREATE OBJECT GC_GRID3

    EXPORTING

      I_PARENT          = GC_CONTAINER2.



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

  PERFORM CONTAINER2_FIELD.

  PERFORM CONTAINER3_FIELD.

  PERFORM CONTAINER4_FIELD.

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

*&      Form  ALV_LAYOUT

*&---------------------------------------------------------------------*

*       text

*----------------------------------------------------------------------*

*  -->  p1        text

*  <--  p2        text

*----------------------------------------------------------------------*




FORM ALV_LAYOUT .

  CLEAR GS_LAYOUT.

  GS_LAYOUT-ZEBRA = 'X'.

  GS_LAYOUT-CWIDTH_OPT = 'X'.

  "GS_LAYOUT-EDIT = 'X'.



  CLEAR GS_VARIANT.

  GS_VARIANT-REPORT = SY-REPID.

  GS_VARIANT-USERNAME = SY-UNAME.



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



  CALL METHOD GC_GRID1->SET_TABLE_FOR_FIRST_DISPLAY

    EXPORTING

      IS_VARIANT = GS_VARIANT

      I_SAVE     = 'A'

      IS_LAYOUT  = GS_LAYOUT

    CHANGING

      IT_OUTTAB       = GT_LFA1_ALV"## ###

      IT_FIELDCATALOG = GT_FIELDCAT1

      IT_SORT         = GT_SORT1.



  CALL METHOD GC_GRID1->SET_READY_FOR_INPUT

    EXPORTING I_READY_FOR_INPUT = 1.

  CALL METHOD GC_GRID2->SET_TABLE_FOR_FIRST_DISPLAY

    EXPORTING

      IS_VARIANT = GS_VARIANT

      I_SAVE     = 'A'

      IS_LAYOUT  = GS_LAYOUT

    CHANGING

      IT_OUTTAB       = GT_LFB1_ALV"####

      IT_FIELDCATALOG = GT_FIELDCAT2

      IT_SORT         = GT_SORT1.



  CALL METHOD GC_GRID2->SET_READY_FOR_INPUT

    EXPORTING I_READY_FOR_INPUT = 1.



  CALL METHOD GC_GRID3->SET_TABLE_FOR_FIRST_DISPLAY

    EXPORTING

      IS_VARIANT = GS_VARIANT

      I_SAVE     = 'A'

      IS_LAYOUT  = GS_LAYOUT

    CHANGING

      IT_OUTTAB       = GT_LFM1_ALV"####

      IT_FIELDCATALOG = GT_FIELDCAT3

      IT_SORT         = GT_SORT1.



  CALL METHOD GC_GRID3->SET_READY_FOR_INPUT

    EXPORTING I_READY_FOR_INPUT = 1.



ENDFORM.




*&---------------------------------------------------------------------*

*&      FORM CONTAINER2_FIELD  "##### (LFA1)

*&---------------------------------------------------------------------*




FORM CONTAINER2_FIELD .



  CLEAR: GS_FIELDCAT, GT_FIELDCAT1.

  "1. #####

  CLEAR GS_FIELDCAT.

  GS_FIELDCAT-COL_POS   = 1.

  "GS_FIELDCAT-KEY       = 'X'.

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



  "5. ####

  "CLEAR GS_FIELDCAT.

  "GS_FIELDCAT-COL_POS   = 5.

  "GS_FIELDCAT-FIELDNAME = 'STCD1'.

  "GS_FIELDCAT-SCRTEXT_M = '####'.

  "GS_FIELDCAT-EDIT = 'X'.

  "APPEND GS_FIELDCAT TO GT_FIELDCAT1.



  "6. #####

  "CLEAR GS_FIELDCAT.

  "GS_FIELDCAT-COL_POS   = 6.

  "GS_FIELDCAT-FIELDNAME = 'STCD2'.

  "GS_FIELDCAT-SCRTEXT_M = '#####'.

  "GS_FIELDCAT-EDIT = 'X'.

  "APPEND GS_FIELDCAT TO GT_FIELDCAT1.



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

  CLEAR GS_FIELDCAT.

  GS_FIELDCAT-COL_POS   = 1.

  "GS_FIELDCAT-KEY       = 'X'.

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

  CLEAR GS_FIELDCAT.

  GS_FIELDCAT-COL_POS   = 1.

  "GS_FIELDCAT-KEY       = 'X'.

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

  "GS_FIELDCAT-SCRTEXT_M = '####'.

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



FORM REFRESH_FIELD_CATALOG.



  PERFORM FIELD_CATALOG.  "### STCD1/STCD2 ###



  IF gc_grid1 IS BOUND.

    CALL METHOD gc_grid1->refresh_table_display.

  ENDIF.



ENDFORM.






*&---------------------------------------------------------------------*

*&      Form  SELECT_DATA

*&---------------------------------------------------------------------*

*       text

*----------------------------------------------------------------------*

*  -->  p1        text

*  <--  p2        text

*----------------------------------------------------------------------*




FORM GET_DATA ."##

   " ## ### # ALV ## # ##



  IF P_CRE = 'X'.



    " ##### ALV  # ### ### (## # 1# ##)

    CLEAR GT_LFA1_ALV.

    CLEAR GS_LFA1_ALV.

    APPEND GS_LFA1_ALV TO GT_LFA1_ALV.



    " #### ALV  ### ## ## # ## ##

    CLEAR GT_LFB1_ALV.

    CLEAR GS_LFB1_ALV.

    APPEND GS_LFB1_ALV TO GT_LFB1_ALV.



    " #### ALV  # # ##

    CLEAR GT_LFM1_ALV.

    CLEAR GS_LFM1_ALV.

    APPEND GS_LFM1_ALV TO GT_LFM1_ALV.



  ENDIF.



ENDFORM.




*&---------------------------------------------------------------------*

*&      Form  SELECT_DATA

*&---------------------------------------------------------------------*

*       text

*----------------------------------------------------------------------*

*  -->  p1        text

*  <--  p2        text

*----------------------------------------------------------------------*




FORM SELECT_DATA .



  " ## ### (LFA1)

  CLEAR GT_LFA1_ALV.

  SELECT *

    FROM ZLFA1_22

    INTO TABLE GT_LFA1_ALV.



  " #### ### (LFB1)

  CLEAR GT_LFB1_ALV.

  SELECT *

    FROM ZLFB1_22

    INTO TABLE GT_LFB1_ALV.



  " #### ### (LFM1)

  CLEAR GT_LFM1_ALV.

  SELECT *

    FROM ZLFM1_22

    INTO TABLE GT_LFM1_ALV.



ENDFORM.




*&---------------------------------------------------------------------*

*&      Form  ADD_ROW

*&---------------------------------------------------------------------*

*       text

*----------------------------------------------------------------------*

*  -->  p1        text

*  <--  p2        text

*----------------------------------------------------------------------*




FORM ADD_ROW.



  " ##### ALV - # # ##

  CLEAR GS_LFA1_ALV.

  APPEND GS_LFA1_ALV TO GT_LFA1_ALV.



  " #### ALV - # # ## (### ## ##)

  CLEAR GS_LFB1_ALV.

  APPEND GS_LFB1_ALV TO GT_LFB1_ALV.



  " #### ALV - # # ##

  CLEAR GS_LFM1_ALV.

  APPEND GS_LFM1_ALV TO GT_LFM1_ALV.



  " # ALV ##

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

FORM SAVE_DATA.



  DATA: LV_LIFNR_CHAR TYPE LIFNR,

        LV_LINES TYPE I,

        LV_MSG TYPE STRING,

        LV_COUNT TYPE I,

        LV_MAX_LIFNR TYPE LIFNR,

        LV_LIFNR_NUM TYPE I.



  " 0. ALV## ### #### ## #### ####

  CALL METHOD GC_GRID1->CHECK_CHANGED_DATA.

  CALL METHOD GC_GRID2->CHECK_CHANGED_DATA.

  CALL METHOD GC_GRID3->CHECK_CHANGED_DATA.



  "1. ### ##

  DESCRIBE TABLE GT_LFA1_ALV LINES LV_LINES.

  IF LV_LINES = 0.

    MESSAGE '### ### #### ####.' TYPE 'E'.

    RETURN.

  ENDIF.



  LOOP AT GT_LFA1_ALV INTO GS_LFA1_ALV.

    IF GS_LFA1_ALV-NAME1 IS INITIAL.

      MESSAGE '##### ## ## #####.' TYPE 'E'.

      RETURN.

    ENDIF.

    IF GS_LFA1_ALV-LAND1 IS INITIAL.

      MESSAGE '### ## ## #####.' TYPE 'E'.

      RETURN.

    ENDIF.

    IF GS_LFA1_ALV-KTOKK IS INITIAL.

      MESSAGE '###### ## ## #####.' TYPE 'E'.

      RETURN.

    ENDIF.

  ENDLOOP.



  LOOP AT GT_LFB1_ALV INTO GS_LFB1_ALV.

    IF GS_LFB1_ALV-BUKRS IS INITIAL.

      MESSAGE '##### ## ## #####.' TYPE 'E'.

      RETURN.

    ENDIF.

    IF GS_LFB1_ALV-AKONT IS INITIAL.

      MESSAGE '### ## ## #####.' TYPE 'E'.

      RETURN.

    ENDIF.

  ENDLOOP.



  LOOP AT GT_LFM1_ALV INTO GS_LFM1_ALV.

    IF GS_LFM1_ALV-EKORG IS INITIAL.

      MESSAGE '##### ## ## #####.' TYPE 'E'.

      RETURN.

    ENDIF.

    IF GS_LFM1_ALV-EKGRP IS INITIAL.

      MESSAGE '##### ## ## #####.' TYPE 'E'.

      RETURN.

    ENDIF.

  ENDLOOP.



  " 2. ##### MAX ## #### +1

  SELECT MAX( LIFNR ) INTO LV_MAX_LIFNR

    FROM ZLFA1_22.



  IF LV_MAX_LIFNR IS INITIAL OR LV_MAX_LIFNR = '0000000000'.

    LV_LIFNR_CHAR = '1000000001'.

  ELSE.

    LV_LIFNR_NUM = LV_MAX_LIFNR.

    LV_LIFNR_NUM = LV_LIFNR_NUM + 1.

    LV_LIFNR_CHAR = LV_LIFNR_NUM.

    CALL FUNCTION 'CONVERSION_EXIT_ALPHA_INPUT'

      EXPORTING

        INPUT  = LV_LIFNR_CHAR

      IMPORTING

        OUTPUT = LV_LIFNR_CHAR.

  ENDIF.



  " 3. ## ##

  SELECT COUNT(*) INTO LV_COUNT

    FROM ZLFA1_22

    WHERE LIFNR = LV_LIFNR_CHAR.



  IF LV_COUNT > 0.

    MESSAGE |##### { LV_LIFNR_CHAR }# ## #####.| TYPE 'E'.

    RETURN.

  ENDIF.



  " 4. ##### INSERT

  READ TABLE GT_LFA1_ALV INTO GS_LFA1_ALV INDEX 1.

  IF SY-SUBRC = 0.

    CLEAR ZLFA1_22.

    ZLFA1_22-MANDT = SY-MANDT.

    ZLFA1_22-LIFNR = LV_LIFNR_CHAR.

    ZLFA1_22-NAME1 = GS_LFA1_ALV-NAME1.

    ZLFA1_22-LAND1 = GS_LFA1_ALV-LAND1.

    ZLFA1_22-KTOKK = GS_LFA1_ALV-KTOKK.

    ZLFA1_22-STCD1 = GS_LFA1_ALV-STCD1.

    ZLFA1_22-STCD2 = GS_LFA1_ALV-STCD2.

    ZLFA1_22-STRAS = GS_LFA1_ALV-STRAS.



    INSERT ZLFA1_22.

    IF SY-SUBRC <> 0.

      LV_MSG = |## ### ## ## (SUBRC={ SY-SUBRC })|.

      IF SY-SUBRC = 4.

        LV_MSG = LV_MSG && | - ## #|.

      ELSEIF SY-MSGID IS NOT INITIAL.

        LV_MSG = LV_MSG && | - { SY-MSGID }/{ SY-MSGNO }|.

      ENDIF.

      MESSAGE LV_MSG TYPE 'E'.

      ROLLBACK WORK.

      RETURN.

    ENDIF.

  ENDIF.



  " 5. ####### INSERT

  LOOP AT GT_LFB1_ALV INTO GS_LFB1_ALV.

    IF GS_LFB1_ALV-BUKRS IS INITIAL AND

       GS_LFB1_ALV-AKONT IS INITIAL.

      CONTINUE.

    ENDIF.



    CLEAR ZLFB1_22.

    ZLFB1_22-MANDT = SY-MANDT.

    ZLFB1_22-LIFNR = LV_LIFNR_CHAR.

    ZLFB1_22-BUKRS = GS_LFB1_ALV-BUKRS.

    ZLFB1_22-AKONT = GS_LFB1_ALV-AKONT.

    ZLFB1_22-ZTERM = GS_LFB1_ALV-ZTERM.

    ZLFB1_22-LOEVM = GS_LFB1_ALV-LOEVM.



    INSERT ZLFB1_22.

    IF SY-SUBRC <> 0.

      MESSAGE |#### ### ## ## (SUBRC={ SY-SUBRC })| TYPE 'E'.

      ROLLBACK WORK.

      RETURN.

    ENDIF.

  ENDLOOP.



  "6. ####### INSERT

  LOOP AT GT_LFM1_ALV INTO GS_LFM1_ALV.

    IF GS_LFM1_ALV-EKORG IS INITIAL AND

       GS_LFM1_ALV-EKGRP IS INITIAL.

      CONTINUE.

    ENDIF.



    CLEAR ZLFM1_22.

    ZLFM1_22-MANDT = SY-MANDT.

    ZLFM1_22-LIFNR = LV_LIFNR_CHAR.

    ZLFM1_22-EKORG = GS_LFM1_ALV-EKORG.

    ZLFM1_22-EKGRP = GS_LFM1_ALV-EKGRP.

    ZLFM1_22-WAERS = GS_LFM1_ALV-WAERS.

    ZLFM1_22-MWSKZ = GS_LFM1_ALV-MWSKZ.

    ZLFM1_22-LOEVM = GS_LFM1_ALV-LOEVM.



    INSERT ZLFM1_22.

    IF SY-SUBRC <> 0.

      MESSAGE |#### ### ## ## (SUBRC={ SY-SUBRC })| TYPE 'E'.

      ROLLBACK WORK.

      RETURN.

    ENDIF.

  ENDLOOP.



  "7. COMMIT

  COMMIT WORK.



  MESSAGE |### { LV_LIFNR_CHAR } ## ##| TYPE 'I'.

  "MESSAGE |### { LV_LIFNR_CHAR } ## ##| TYPE 'S'.



  "8. ## ###

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



ENDFORM.




*&---------------------------------------------------------------------*

*&      Form  VALID_SCREEN_INPUT

*&---------------------------------------------------------------------*

*       #### ### ##

*----------------------------------------------------------------------*




FORM VALID_SCREEN_INPUT .



  "## ### #: #### + #### ##

  IF P_CRE = 'X'.



    IF P_BUKRS IS INITIAL OR P_KTOKK IS INITIAL.

      MESSAGE '##### ##### ## #####.' TYPE 'E'.

    ENDIF.



  "## ### #: #### + ##### ##

  ELSEIF P_VIEW = 'X'.



    IF P_BUKRS IS INITIAL OR P_LIFNR IS INITIAL.

      MESSAGE '##### ###### ## #####.' TYPE 'E'.

    ENDIF.



  ELSE.

    MESSAGE '## ## ## ### #####.' TYPE 'E'.

  ENDIF.



ENDFORM.




*&---------------------------------------------------------------------*

*&      Form  GET_DATA_200

*&---------------------------------------------------------------------*

*       text

*----------------------------------------------------------------------*

*  -->  p1        text

*  <--  p2        text

*----------------------------------------------------------------------*




FORM GET_DATA_200.



  CLEAR: GT_LFA1_ALV, GT_LFB1_ALV, GT_LFM1_ALV, GT_VENDOR_ALL.



  " 1. ##### (ZLFA1_22)

  SELECT *

    FROM ZLFA1_22

    INTO TABLE GT_LFA1_ALV

    WHERE LIFNR = G_LIFNR.



  " 2. ####### (ZLFB1_22)

  SELECT *

    FROM ZLFB1_22

    INTO TABLE GT_LFB1_ALV

    WHERE LIFNR = G_LIFNR

      AND BUKRS = G_BUKRS.



  " 3. ####### (ZLFM1_22)

  SELECT *

    FROM ZLFM1_22

    INTO TABLE GT_LFM1_ALV

    WHERE LIFNR = G_LIFNR.





  "3# ### ### # ## ###

  CLEAR GS_VENDOR_ALL.



  READ TABLE GT_LFA1_ALV INTO DATA(LS_LFA1) INDEX 1.

  READ TABLE GT_LFB1_ALV INTO DATA(LS_LFB1) INDEX 1.

  READ TABLE GT_LFM1_ALV INTO DATA(LS_LFM1) INDEX 1.



  IF SY-SUBRC = 0.



    " LFA1

    GS_VENDOR_ALL-LIFNR = LS_LFA1-LIFNR.

    GS_VENDOR_ALL-NAME1 = LS_LFA1-NAME1.

    GS_VENDOR_ALL-LAND1 = LS_LFA1-LAND1.

    GS_VENDOR_ALL-KTOKK = LS_LFA1-KTOKK.

    GS_VENDOR_ALL-STCD1 = LS_LFA1-STCD1.

    GS_VENDOR_ALL-STCD2 = LS_LFA1-STCD2.

    GS_VENDOR_ALL-STRAS = LS_LFA1-STRAS.



    " LFB1

    GS_VENDOR_ALL-BUKRS = LS_LFB1-BUKRS.

    GS_VENDOR_ALL-AKONT = LS_LFB1-AKONT.

    GS_VENDOR_ALL-ZTERM = LS_LFB1-ZTERM.

    GS_VENDOR_ALL-LOEVM1 = LS_LFB1-LOEVM.



    " LFM1

    GS_VENDOR_ALL-EKORG = LS_LFM1-EKORG.

    GS_VENDOR_ALL-EKGRP = LS_LFM1-EKGRP.

    GS_VENDOR_ALL-WAERS = LS_LFM1-WAERS.

    GS_VENDOR_ALL-MWSKZ = LS_LFM1-MWSKZ.

    GS_VENDOR_ALL-LOEVM2 = LS_LFM1-LOEVM.



    APPEND GS_VENDOR_ALL TO GT_VENDOR_ALL.



  ENDIF.



ENDFORM.




*&---------------------------------------------------------------------*

*&      Form  CREATE_OBJECT2

*&---------------------------------------------------------------------*

*       text

*----------------------------------------------------------------------*

*  -->  p1        text

*  <--  p2        text

*----------------------------------------------------------------------*




FORM CREATE_OBJECT2 .

  CREATE OBJECT GC_CUSTOM

    EXPORTING




*      PARENT                      =




      CONTAINER_NAME              = 'CC200'




*      STYLE                       =

*      LIFETIME                    = lifetime_default

*      REPID                       =

*      DYNNR                       =

*      NO_AUTODEF_PROGID_DYNNR     =

*    EXCEPTIONS

*      CNTL_ERROR                  = 1

*      CNTL_SYSTEM_ERROR           = 2

*      CREATE_ERROR                = 3

*      LIFETIME_ERROR              = 4

*      LIFETIME_DYNPRO_DYNPRO_LINK = 5

*      others                      = 6




      .

  IF SY-SUBRC <> 0.




*   MESSAGE ID SY-MSGID TYPE SY-MSGTY NUMBER SY-MSGNO

*              WITH SY-MSGV1 SY-MSGV2 SY-MSGV3 SY-MSGV4.




  ENDIF.

CREATE OBJECT GC_GRID

  EXPORTING




*    I_SHELLSTYLE      = 0

*    I_LIFETIME        =




    I_PARENT          = GC_CUSTOM




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

IF SY-SUBRC <> 0.




* MESSAGE ID SY-MSGID TYPE SY-MSGTY NUMBER SY-MSGNO

*            WITH SY-MSGV1 SY-MSGV2 SY-MSGV3 SY-MSGV4.




ENDIF.





ENDFORM.




*&---------------------------------------------------------------------*

*&      Form  FILED_CATALOG2

*&---------------------------------------------------------------------*

*       text

*----------------------------------------------------------------------*

*  -->  p1        text

*  <--  p2        text

*----------------------------------------------------------------------*




FORM FILED_CATALOG2.



  CLEAR GT_FIELDCAT1.

  "## ###

  CLEAR GS_FIELDCAT.

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

*&      Form  SAVE_UPDATE_DATA_200

*&---------------------------------------------------------------------*

*       text

*----------------------------------------------------------------------*

*  -->  p1        text

*  <--  p2        text

*----------------------------------------------------------------------*




FORM SAVE_UPDATED_DATA_200.



  " ALV## ### ## ####

  IF GC_GRID IS BOUND.

    CALL METHOD GC_GRID->CHECK_CHANGED_DATA.

  ENDIF.



  LOOP AT GT_VENDOR_ALL INTO GS_VENDOR_ALL.



    "## ###

    UPDATE ZLFA1_22 SET

      STCD2 = GS_VENDOR_ALL-STCD2   "##### ## ##

      WHERE LIFNR = GS_VENDOR_ALL-LIFNR.



    IF SY-SUBRC <> 0.

      MESSAGE |##### UPDATE ##| TYPE 'E'.

    ENDIF.



    "#### ###

    UPDATE ZLFB1_22 SET

      AKONT = GS_VENDOR_ALL-AKONT

      ZTERM = GS_VENDOR_ALL-ZTERM

      WHERE LIFNR = GS_VENDOR_ALL-LIFNR

        AND BUKRS = GS_VENDOR_ALL-BUKRS.



    IF SY-SUBRC <> 0.

      MESSAGE |#### UPDATE ##| TYPE 'E'.

    ENDIF.



    "#### ###

    UPDATE ZLFM1_22 SET

      WAERS = GS_VENDOR_ALL-WAERS

      MWSKZ = GS_VENDOR_ALL-MWSKZ

      WHERE LIFNR = GS_VENDOR_ALL-LIFNR

        AND EKORG = GS_VENDOR_ALL-EKORG.



    IF SY-SUBRC <> 0.

      MESSAGE |#### UPDATE ##| TYPE 'E'.

    ENDIF.



  ENDLOOP.



  COMMIT WORK.



  MESSAGE '## ##' TYPE 'S'.



ENDFORM.








*&---------------------------------------------------------------------*

*&      Form  ALV_LAYOUT2

*&---------------------------------------------------------------------*

*       text

*----------------------------------------------------------------------*

*  -->  p1        text

*  <--  p2        text

*----------------------------------------------------------------------*




FORM ALV_LAYOUT2 .

  CLEAR GS_LAYOUT.

  GS_LAYOUT-ZEBRA = 'X'.

  GS_LAYOUT-CWIDTH_OPT = 'X'.



  CLEAR GS_VARIANT.

  GS_VARIANT-REPORT = SY-REPID.

  GS_VARIANT-USERNAME = SY-UNAME.



ENDFORM.




*&---------------------------------------------------------------------*

*&      Form  ALV_SORT2

*&---------------------------------------------------------------------*

*       text

*----------------------------------------------------------------------*

*  -->  p1        text

*  <--  p2        text

*----------------------------------------------------------------------*




FORM ALV_SORT2 .



ENDFORM.




*&---------------------------------------------------------------------*

*&      Form  CALL_ALV2

*&---------------------------------------------------------------------*

*       text

*----------------------------------------------------------------------*

*  -->  p1        text

*  <--  p2        text

*----------------------------------------------------------------------*




FORM CALL_ALV2 .

CALL METHOD GC_GRID->SET_TABLE_FOR_FIRST_DISPLAY

  EXPORTING




*    I_BUFFER_ACTIVE               =

*    I_BYPASSING_BUFFER            =

*    I_CONSISTENCY_CHECK           =

*    I_STRUCTURE_NAME              =

*    IS_VARIANT                    =

*    I_SAVE                        =

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

    IT_OUTTAB                     = GT_VENDOR_ALL

    IT_FIELDCATALOG               = GT_FIELDCAT1

    IT_SORT                       = GT_SORT1




*    IT_FILTER                     =

*  EXCEPTIONS

*    INVALID_PARAMETER_COMBINATION = 1

*    PROGRAM_ERROR                 = 2

*    TOO_MANY_LINES                = 3

*    others                        = 4




        .

IF SY-SUBRC <> 0.




* Implement suitable error handling here




ENDIF.



ENDFORM.