
*&---------------------------------------------------------------------*

*&  Include           ZMM08_002_F01

*&---------------------------------------------------------------------*

*&---------------------------------------------------------------------*

*&      Form  SET_DEFAULTS

*&---------------------------------------------------------------------*

*       text

*----------------------------------------------------------------------*

*  -->  p1        text

*  <--  p2        text

*----------------------------------------------------------------------*




FORM SET_DEFAULTS .

  TEXT_C01 = '##'.

  TEXT_C02 = '##'.

ENDFORM.




*&---------------------------------------------------------------------*

*&      Form  MODIFY_SELECTION_SCREEN

*&---------------------------------------------------------------------*

*       text

*----------------------------------------------------------------------*

*  -->  p1        text

*  <--  p2        text

*----------------------------------------------------------------------*




FORM MODIFY_SELECTION_SCREEN .



  LOOP AT SCREEN.

    " ## ### #

    IF P_C = 'X'.



      IF SCREEN-GROUP1 = 'M1'.

        SCREEN-ACTIVE = 1.

      ELSEIF SCREEN-GROUP1 = 'M2'.

        SCREEN-ACTIVE = 0.

      ENDIF.



    " ## ##

    ELSEIF P_Q = 'X'.



      IF SCREEN-GROUP1 = 'M1'.

        SCREEN-ACTIVE = 0.

      ELSEIF SCREEN-GROUP1 = 'M2'.

        SCREEN-ACTIVE = 1.

      ENDIF.

    ENDIF.



    MODIFY SCREEN.

  ENDLOOP.



ENDFORM.




*&---------------------------------------------------------------------*

*&      Form  SET_SELECTION_SCREEN

*&---------------------------------------------------------------------*

*       text

*----------------------------------------------------------------------*

*  -->  p1        text

*  <--  p2        text

*----------------------------------------------------------------------*




FORM SET_SELECTION_SCREEN .



  CHECK SY-UCOMM = 'ONLI'. " ## ## ### ## ##



  IF P_C = 'X'.

    IF P_LIFNR IS INITIAL.

      MESSAGE '### ### #####.' TYPE 'E'.

    ENDIF.



    IF P_BUKRS IS INITIAL.

      MESSAGE '#### ### #####.' TYPE 'E'.

    ENDIF.



    DATA: LV_CHECK TYPE ZEDT08_LFA1-LIFNR.



    SELECT SINGLE LIFNR INTO LV_CHECK FROM ZEDT08_LFA1 WHERE LIFNR = P_LIFNR.



    IF SY-SUBRC <> 0.

      MESSAGE '#### ### ### ## #### ####.' TYPE 'E'.

    ENDIF.

  ELSEIF P_Q = 'X'.

    IF P_EBELN IS INITIAL AND P_LIFN2 IS INITIAL.



    ENDIF.

  ENDIF.



  GV_BUKRS = P_BUKRS.

  GV_LIFNR = P_LIFNR.

  GV_BEDAT = P_BEDAT.



ENDFORM.




*&---------------------------------------------------------------------*

*&      Form  START_SCREEN

*&---------------------------------------------------------------------*

*       text

*----------------------------------------------------------------------*

*  -->  p1        text

*  <--  p2        text

*----------------------------------------------------------------------*




FORM START_SCREEN .



  IF P_C = 'X'.

    CALL SCREEN 100.

  ELSE.

    CALL SCREEN 200.

  ENDIF.



ENDFORM.




*&---------------------------------------------------------------------*

*&      Form  DISPLAY_ALV_100

*&---------------------------------------------------------------------*

*       text

*----------------------------------------------------------------------*

*  -->  p1        text

*  <--  p2        text

*----------------------------------------------------------------------*




FORM DISPLAY_ALV_100 .



  GV_BUKRS = P_BUKRS.

  GV_LIFNR = P_LIFNR.

  GV_BEDAT = P_BEDAT.



  IF GV_LIFNR IS NOT INITIAL.

    SELECT SINGLE LAND1 INTO GV_LAND1 FROM ZEDT08_LFA1 WHERE LIFNR = GV_LIFNR.

  ENDIF.



  IF GV_LIFNR IS NOT INITIAL.

    SELECT SINGLE WAERS INTO GV_WAERS FROM ZEDT08_LFM1 WHERE LIFNR = GV_LIFNR.

  ENDIF.



  LOOP AT SCREEN.

    IF SCREEN-NAME = 'GV_BUKRS' OR

       SCREEN-NAME = 'GV_LIFNR' OR

       SCREEN-NAME = 'GV_LAND1' OR

       SCREEN-NAME = 'GV_WAERS' OR

       SCREEN-NAME = 'GV_BEDAT'.



       SCREEN-INPUT = '0'.      " 0 = ## ## (Output Only)

       SCREEN-ACTIVE = '1'.     " 1 = ### ##

       MODIFY SCREEN.           " #### ##

    ENDIF.

  ENDLOOP.



  IF GC_DOCKING IS INITIAL.



    CREATE OBJECT GC_DOCKING

      EXPORTING

        SIDE = CL_GUI_DOCKING_CONTAINER=>DOCK_AT_BOTTOM

        RATIO = 75.



    CREATE OBJECT GC_GRID

      EXPORTING

        I_PARENT = GC_DOCKING.



    CREATE OBJECT GO_EVENT.

    SET HANDLER GO_EVENT->ON_TOOLBAR FOR GC_GRID.

    SET HANDLER GO_EVENT->ON_USER_COMMAND FOR GC_GRID.

    SET HANDLER GO_EVENT->ON_DATA_CHANGED FOR GC_GRID.



    PERFORM BUILD_FIELDCAT.



    GS_LAYOUT-ZEBRA = 'X'.

    GS_LAYOUT-CWIDTH_OPT = 'X'.

    GS_LAYOUT-SEL_MODE = 'D'.



    CALL METHOD GC_GRID->REGISTER_EDIT_EVENT

      EXPORTING

        I_EVENT_ID = CL_GUI_ALV_GRID=>MC_EVT_MODIFIED.



    CALL METHOD GC_GRID->SET_TABLE_FOR_FIRST_DISPLAY

      EXPORTING

        IS_LAYOUT = GS_LAYOUT

      CHANGING

        IT_OUTTAB = GT_EKPO

        IT_FIELDCATALOG = GT_FIELDCAT

      EXCEPTIONS

        INVALID_PARAMETER_COMBINATION = 1

        PROGRAM_ERROR = 2

        TOO_MANY_LINES = 3

        OTHERS = 4.

   ELSE.

     CALL METHOD GC_GRID->REFRESH_TABLE_DISPLAY.

   ENDIF.



ENDFORM.




*&---------------------------------------------------------------------*

*&      Form  DISPLAY_ALV_200

*&---------------------------------------------------------------------*

*       text

*----------------------------------------------------------------------*

*  -->  p1        text

*  <--  p2        text

*----------------------------------------------------------------------*




FORM DISPLAY_ALV_200 .



  PERFORM QUERY_DATA.



  DATA: LS_Q TYPE TY_EKPO.

  DATA: LS_HEAD TYPE ZEDT08_EKKO.



  READ TABLE GT_EKPO_Q INTO LS_Q INDEX 1.

  IF SY-SUBRC = 0.

    SELECT SINGLE * FROM ZEDT08_EKKO INTO LS_HEAD

      WHERE EBELN = LS_Q-EBELN.



    IF SY-SUBRC = 0.

      MOVE-CORRESPONDING LS_HEAD TO GS_EKKO.



      GV_BUKRS = LS_HEAD-BUKRS.

      GV_LIFNR = LS_HEAD-LIFNR.

      GV_BEDAT = LS_HEAD-BEDAT.

      GV_WAERS = LS_HEAD-WAERS.



      SELECT SINGLE LAND1 INTO GV_LAND1 FROM ZEDT08_LFA1 WHERE LIFNR = GV_LIFNR.

    ENDIF.

  ELSE.

    GV_BUKRS = P_BUKR2.

    GV_LIFNR = P_LIFN2.

  ENDIF.



  LOOP AT SCREEN.

    IF SCREEN-NAME = 'GV_BUKRS' OR

      SCREEN-NAME = 'GV_LIFNR' OR

      SCREEN-NAME = 'GV_LAND1' OR

      SCREEN-NAME = 'GV_WAERS' OR

      SCREEN-NAME = 'GV_BEDAT'.



      SCREEN-INPUT = '0'.

      MODIFY SCREEN.

    ENDIF.

  ENDLOOP.



  IF GC_DOCKING IS INITIAL.

    CREATE OBJECT GC_DOCKING

      EXPORTING

        SIDE = CL_GUI_DOCKING_CONTAINER=>DOCK_AT_BOTTOM

        RATIO = 95.



    CREATE OBJECT GC_GRID

      EXPORTING

        I_PARENT = GC_DOCKING.



    PERFORM BUILD_FIELDCAT_Q.



    GS_LAYOUT-ZEBRA = 'X'.

    GS_LAYOUT-CWIDTH_OPT = 'X'.

    GS_LAYOUT-EDIT = ' '.



    CALL METHOD GC_GRID->SET_TABLE_FOR_FIRST_DISPLAY

      EXPORTING

        IS_LAYOUT = GS_LAYOUT

      CHANGING

        IT_OUTTAB = GT_EKPO_Q

        IT_FIELDCATALOG = GT_FIELDCAT

      EXCEPTIONS

        OTHERS = 4.

  ELSE.

    PERFORM QUERY_DATA.

    CALL METHOD GC_GRID->REFRESH_TABLE_DISPLAY.

  ENDIF.



ENDFORM.




*&---------------------------------------------------------------------*

*&      Form  REFRESH_ITEM_DERIVED

*&---------------------------------------------------------------------*

*       text

*----------------------------------------------------------------------*

*  -->  p1        text

*  <--  p2        text

*----------------------------------------------------------------------*




FORM REFRESH_ITEM_DERIVED .



  DATA: LS_ITEM TYPE TY_EKPO,

        LS_MAT TYPE ZEDT08_MAT,

        LV_IDX TYPE SY-TABIX.



 CLEAR LV_IDX.

  LOOP AT GT_EKPO INTO LS_ITEM.

    LV_IDX = SY-TABIX.



    IF LS_ITEM-MATNR IS NOT INITIAL.

      CLEAR LS_MAT.

      SELECT SINGLE * FROM ZEDT08_MAT INTO LS_MAT

        WHERE ZMATNR = LS_ITEM-MATNR

        AND WERKS = LS_ITEM-WERKS

        AND LGORT = LS_ITEM-LGORT.



      IF SY-SUBRC = 0.

        LS_ITEM-MAKTX = LS_MAT-ZMATNAME.

        IF LS_ITEM-MEINS IS INITIAL.

          LS_ITEM-MEINS = LS_MAT-MEINS.

        ENDIF.

        IF LS_ITEM-BPRME IS INITIAL.

          LS_ITEM-BPRME = LS_MAT-STPRS.

        ENDIF.

      ENDIF.

    ENDIF.



    IF LS_ITEM-WAERS IS INITIAL.

      LS_ITEM-WAERS = GS_LFM1-WAERS.

    ENDIF.



    IF LS_ITEM-MWSKZ IS INITIAL.

      LS_ITEM-MWSKZ = GS_LFM1-MWSKZ.

    ENDIF.



    MODIFY GT_EKPO FROM LS_ITEM INDEX LV_IDX.

  ENDLOOP.



  IF GC_GRID IS BOUND.

    CALL METHOD GC_GRID->REFRESH_TABLE_DISPLAY.

  ENDIF.



ENDFORM.




*&---------------------------------------------------------------------*

*&      Form  BUILD_FIELDCAT

*&---------------------------------------------------------------------*

*       text

*----------------------------------------------------------------------*

*  -->  p1        text

*  <--  p2        text

*----------------------------------------------------------------------*




FORM BUILD_FIELDCAT_Q .

  CLEAR GT_FIELDCAT.



  DEFINE _FC_Q.

    CLEAR GS_FIELDCAT.

    GS_FIELDCAT-FIELDNAME = &1.

    GS_FIELDCAT-COLTEXT = &2.

    GS_FIELDCAT-REF_TABLE = 'ZEDT08_EKPO'.

    APPEND GS_FIELDCAT TO GT_FIELDCAT.

  END-OF-DEFINITION.



  _FC_Q 'EBELN' 'PO##'.

  _FC_Q 'EBELP' '##'.

  _FC_Q 'MATNR' '####'.

  _FC_Q 'MAKTX' '###'.



  CLEAR GS_FIELDCAT.

  GS_FIELDCAT-FIELDNAME = 'MENGE'.

  GS_FIELDCAT-COLTEXT = 'PO##'.

  GS_FIELDCAT-REF_TABLE = 'ZEDT08_EKPO'.

  GS_FIELDCAT-QFIELDNAME = 'MEINS'.

  APPEND GS_FIELDCAT TO GT_FIELDCAT.



  _FC_Q 'MEINS' '##'.



  CLEAR GS_FIELDCAT.

  GS_FIELDCAT-FIELDNAME = 'BPRME'.

  GS_FIELDCAT-COLTEXT = '##'.

  GS_FIELDCAT-REF_TABLE = 'ZEDT08_EKPO'.

  GS_FIELDCAT-CFIELDNAME = 'WAERS'.

  APPEND GS_FIELDCAT TO GT_FIELDCAT.



  _FC_Q 'WAERS' '##'.

  _FC_Q 'MWSKZ' '####'.

  _FC_Q 'PRDAT' '###'.

  _FC_Q 'WERKS' 'Plant'.

  _FC_Q 'LGORT' 'SLoc'.



  CLEAR GS_LAYOUT.

  GS_LAYOUT-ZEBRA = ABAP_TRUE.

  GS_LAYOUT-CWIDTH_OPT = ABAP_TRUE.

  GS_LAYOUT-EDIT = ABAP_FALSE.



ENDFORM.




*&---------------------------------------------------------------------*

*&      Form  CHECK_VENDOR

*&---------------------------------------------------------------------*

*       text

*----------------------------------------------------------------------*

*      -->P_GV_BUKRS  text

*      -->P_GV_LIFNR  text

*----------------------------------------------------------------------*




FORM CHECK_VENDOR  USING    PV_BUKRS TYPE ZEDT08_EKKO-BUKRS

                            PV_LIFNR TYPE ZEDT08_EKKO-LIFNR.



  CLEAR: GS_LFA1, GS_LFB1, GS_LFM1.



  SELECT SINGLE * FROM ZEDT08_LFA1 INTO CORRESPONDING FIELDS OF

    GS_LFA1 WHERE LIFNR = PV_LIFNR.

  IF SY-SUBRC <> 0.

    MESSAGE '#### #### ####.' TYPE 'E'.

  ENDIF.



  SELECT SINGLE * FROM ZEDT08_LFB1 INTO CORRESPONDING FIELDS OF GS_LFB1

    WHERE LIFNR = PV_LIFNR AND BUKRS = PV_BUKRS.



  IF SY-SUBRC <> 0.

    MESSAGE '##### #### #### ####.' TYPE 'E'.

  ENDIF.



  SELECT SINGLE * FROM ZEDT08_LFM1 INTO CORRESPONDING FIELDS OF GS_LFM1

    WHERE LIFNR = PV_LIFNR.



  IF SY-SUBRC <> 0.

    MESSAGE '#### #### 1# ## #####.' TYPE 'E'.

  ENDIF.



ENDFORM.




*&---------------------------------------------------------------------*

*&      Form  QUERY_DATA

*&---------------------------------------------------------------------*

*       text

*----------------------------------------------------------------------*

*  -->  p1        text

*  <--  p2        text

*----------------------------------------------------------------------*




FORM QUERY_DATA .



  CLEAR GT_EKPO_Q.



  SELECT A~EBELN, A~EBELP, A~MATNR, A~MAKTX, A~MENGE, A~MEINS,

       A~BPRME, A~PRDAT, A~WERKS, A~LGORT, B~WAERS

  FROM ZEDT08_EKPO AS A

  INNER JOIN ZEDT08_EKKO AS B ON B~EBELN = A~EBELN

  WHERE ( @P_EBELN = '' OR A~EBELN = @P_EBELN )      " IS INITIAL ## = '' ##

    AND ( @P_BUKR2 = '' OR B~BUKRS = @P_BUKR2 )

    AND ( @P_LIFN2 = '' OR B~LIFNR = @P_LIFN2 )

  INTO TABLE @GT_EKPO_Q.



  IF GT_EKPO_Q IS INITIAL.

    MESSAGE '## ### ####.' TYPE 'I'.

  ENDIF.



ENDFORM.




*&---------------------------------------------------------------------*

*&      Form  BUILD_FIELDCAT_Q

*&---------------------------------------------------------------------*

*       text

*----------------------------------------------------------------------*

*  -->  p1        text

*  <--  p2        text

*----------------------------------------------------------------------*




FORM BUILD_FIELDCAT .



  CLEAR GT_FIELDCAT.



  CLEAR GS_FIELDCAT.

  GS_FIELDCAT-FIELDNAME = 'CHK'.

  GS_FIELDCAT-COLTEXT = '##'.

  GS_FIELDCAT-CHECKBOX = 'X'.

  GS_FIELDCAT-EDIT = 'X'.

  APPEND GS_FIELDCAT TO GT_FIELDCAT.



  DEFINE _FC.

    CLEAR GS_FIELDCAT.

    GS_FIELDCAT-FIELDNAME = &1.

    GS_FIELDCAT-COLTEXT = &2.

    GS_FIELDCAT-EDIT = &3.

    GS_FIELDCAT-REF_TABLE = 'ZEDT08_EKPO'.

    APPEND GS_FIELDCAT TO GT_FIELDCAT.

  END-OF-DEFINITION.



  " _FC 'EBELN' 'PO##' 'X'.

  _FC 'EBELP' '##' ''.

  _FC 'MATNR' '####' 'X'.

  _FC 'MAKTX' '###' ''.



  CLEAR GS_FIELDCAT.

  GS_FIELDCAT-FIELDNAME = 'MENGE'.

  GS_FIELDCAT-COLTEXT = 'PO##'.

  GS_FIELDCAT-REF_TABLE = 'ZEDT08_EKPO'.

  GS_FIELDCAT-QFIELDNAME = 'MEINS'.

  GS_FIELDCAT-EDIT = 'X'.

  APPEND GS_FIELDCAT TO GT_FIELDCAT.



  " _FC 'MENGE' 'Quantity' 'X'.



  CLEAR GS_FIELDCAT.

  GS_FIELDCAT-FIELDNAME = 'BPRME'.

  GS_FIELDCAT-COLTEXT = '##'.

  GS_FIELDCAT-REF_TABLE = 'ZEDT08_EKPO'.

  GS_FIELDCAT-CFIELDNAME = 'WAERS'.

  GS_FIELDCAT-EDIT = 'X'.

  APPEND GS_FIELDCAT TO GT_FIELDCAT.



  _FC 'MEINS' '##' 'X'.



  "_FC 'BPRME' '##' 'X'.

  _FC 'WAERS' '##' ''.

  _FC 'MWSKZ' '####' ''.

  _FC 'PRDAT' '###' ''.

  _FC 'WERKS' '###' 'X'.

  _FC 'LGORT' '####' 'X'.



  CLEAR GS_LAYOUT.

  GS_LAYOUT-ZEBRA = ABAP_TRUE.

  GS_LAYOUT-CWIDTH_OPT = ABAP_TRUE.

  GS_LAYOUT-EDIT = ABAP_TRUE.



ENDFORM.




*&---------------------------------------------------------------------*

*&      Form  ADD_ITEM

*&---------------------------------------------------------------------*

*       text

*----------------------------------------------------------------------*

*  -->  p1        text

*  <--  p2        text

*----------------------------------------------------------------------*




FORM ADD_ITEM .

  DATA: LV_NEXT TYPE ZEDT08_EKPO-EBELP VALUE 10,

        LS_ITEM TYPE TY_EKPO.



  LOOP AT GT_EKPO INTO LS_ITEM.

    IF LS_ITEM-EBELP >= LV_NEXT.

      LV_NEXT = LS_ITEM-EBELP + 10.

    ENDIF.

  ENDLOOP.



  CLEAR LS_ITEM.

  LS_ITEM-EBELP = LV_NEXT.

  LS_ITEM-PRDAT = GV_BEDAT.

  APPEND LS_ITEM TO GT_EKPO.



  PERFORM REFRESH_ITEM_DERIVED.



ENDFORM.




*&---------------------------------------------------------------------*

*&      Form  DELETE_ITEM

*&---------------------------------------------------------------------*

*       text

*----------------------------------------------------------------------*

*  -->  p1        text

*  <--  p2        text

*----------------------------------------------------------------------*




FORM DELETE_ITEM .



  IF GC_GRID IS BOUND.

    CALL METHOD GC_GRID->CHECK_CHANGED_DATA.

  ENDIF.



  DELETE GT_EKPO WHERE CHK = 'X'.

  IF GC_GRID IS BOUND.

    CALL METHOD GC_GRID->REFRESH_TABLE_DISPLAY.

  ENDIF.



ENDFORM.




*&---------------------------------------------------------------------*

*&      Form  CREATE_PO

*&---------------------------------------------------------------------*

*       text

*----------------------------------------------------------------------*

*  -->  p1        text

*  <--  p2        text

*----------------------------------------------------------------------*




FORM CREATE_PO .

  DATA: LS_ITEM TYPE TY_EKPO,

        LS_PO TYPE ZEDT08_EKPO,

        LV_MSG TYPE STRING.



  DATA: LS_SAVE TYPE ZEDT08_EKKO.



  IF GC_GRID IS BOUND.

    CALL METHOD GC_GRID->CHECK_CHANGED_DATA.

  ENDIF.



  IF GV_BUKRS IS INITIAL OR GV_LIFNR IS INITIAL OR GV_BEDAT IS INITIAL.

    MESSAGE '####/###/#### #####.' TYPE 'E'.

  ENDIF.



  PERFORM CHECK_VENDOR USING GV_BUKRS GV_LIFNR.

  PERFORM CHECK_ITEMS CHANGING GT_EKPO.



  PERFORM NUMBER_RANGE CHANGING GS_EKKO-EBELN.

  GS_EKKO-BUKRS = GV_BUKRS.

  GS_EKKO-LIFNR = GV_LIFNR.

  GS_EKKO-BEDAT = GV_BEDAT.

  GS_EKKO-WAERS = GS_LFM1-WAERS.



  MOVE-CORRESPONDING GS_EKKO TO LS_SAVE.



  INSERT ZEDT08_EKKO FROM LS_SAVE.

  IF SY-SUBRC <> 0.

    MESSAGE '## ### ######.' TYPE 'E'.

  ENDIF.



  LOOP AT GT_EKPO INTO LS_ITEM.

    CLEAR LS_PO.

    LS_PO-EBELN = GS_EKKO-EBELN.

    LS_PO-EBELP = LS_ITEM-EBELP.

    LS_PO-MATNR = LS_ITEM-MATNR.

    LS_PO-MAKTX = LS_ITEM-MAKTX.

    LS_PO-MENGE = LS_ITEM-MENGE.

    LS_PO-MEINS = LS_ITEM-MEINS.

    LS_PO-BPRME = LS_ITEM-BPRME.

    LS_PO-PRDAT = LS_ITEM-PRDAT.

    LS_PO-WERKS = LS_ITEM-WERKS.

    LS_PO-LGORT = LS_ITEM-LGORT.

    LS_PO-MANDT = SY-MANDT.



    INSERT ZEDT08_EKPO FROM LS_PO.

    IF SY-SUBRC <> 0.

      ROLLBACK WORK.

      LV_MSG = '## ## ##. ##:'.

      CONCATENATE LV_MSG LS_ITEM-EBELP INTO LV_MSG SEPARATED BY ' '.

      MESSAGE LV_MSG TYPE 'E'.

    ENDIF.

  ENDLOOP.



  COMMIT WORK AND WAIT.

  LV_MSG = 'PO ## ##. ##:'.

  CONCATENATE LV_MSG GS_EKKO-EBELN INTO LV_MSG SEPARATED BY ' '.

  MESSAGE LV_MSG TYPE 'S'.



ENDFORM.




*&---------------------------------------------------------------------*

*&      Form  CHECK_ITEMS

*&---------------------------------------------------------------------*

*       text

*----------------------------------------------------------------------*

*      <--P_GT_EKPO  text

*----------------------------------------------------------------------*




FORM CHECK_ITEMS  CHANGING PT_ITEMS LIKE GT_EKPO.

  DATA: LS_I TYPE TY_EKPO,

        LS_MAT TYPE ZEDT08_MAT,

        LS_MSG TYPE STRING.



  IF PT_ITEMS IS INITIAL.

    MESSAGE '## 1# ## #####.' TYPE 'S'.

  ENDIF.



  LOOP AT PT_ITEMS INTO LS_I.

    IF LS_I-MATNR IS INITIAL.

      LS_MSG = '##### #####. #:'.

      LS_MSG = |{ LS_MSG } { SY-TABIX }|.

      MESSAGE LS_MSG TYPE 'E'.

    ENDIF.



    IF LS_I-WERKS IS INITIAL OR LS_I-LGORT IS INITIAL.

      LS_MSG = '###/##### #####. #:'.

      LS_MSG = |{ LS_MSG } { SY-TABIX }|.

      MESSAGE LS_MSG TYPE 'E'.

    ENDIF.



    IF LS_I-MENGE IS INITIAL OR LS_I-MENGE <= 0.

      LS_MSG = '### 0## ## ###. #:'.

      LS_MSG = |{ LS_MSG } { SY-TABIX }|.

      MESSAGE LS_MSG TYPE 'E'.

    ENDIF.



    IF LS_I-BPRME IS INITIAL OR LS_I-BPRME < 0.

      LS_MSG = '### #### ####. #:'.

      LS_MSG = |{ LS_MSG } { SY-TABIX }|.

      MESSAGE LS_MSG TYPE 'E'.

    ENDIF.



    CLEAR LS_MAT.

    SELECT SINGLE * FROM ZEDT08_MAT INTO LS_MAT

      WHERE ZMATNR = LS_I-MATNR

      AND WERKS = LS_I-WERKS

      AND LGORT = LS_I-LGORT.



    IF SY-SUBRC <> 0.

      MESSAGE '###### #### ####.' TYPE 'S'.

    ENDIF.



  ENDLOOP.



ENDFORM.




*&---------------------------------------------------------------------*

*&      Form  NUMBER_RANGE

*&---------------------------------------------------------------------*

*       text

*----------------------------------------------------------------------*

*      <--P_GS_EKKO_EBELN  text

*----------------------------------------------------------------------*




FORM NUMBER_RANGE  CHANGING PV_EBELN TYPE ZEDT08_EKKO-EBELN.



  DATA LV_MAX TYPE ZEDT08_EKKO-EBELN.



  SELECT MAX( EBELN ) INTO LV_MAX FROM ZEDT08_EKKO.



  IF SY-SUBRC <> 0 OR LV_MAX IS INITIAL.

    PV_EBELN = '1000000001'.

  ELSE.

    PV_EBELN = LV_MAX + 1.

  ENDIF.



ENDFORM.