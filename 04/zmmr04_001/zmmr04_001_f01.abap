
*&---------------------------------------------------------------------*

*&  Include           ZMMR04_001_F01

*&---------------------------------------------------------------------*

*&---------------------------------------------------------------------*

*&      Form  SET_SCREEN

*&---------------------------------------------------------------------*




FORM SET_SCREEN .

  LOOP AT SCREEN.

    IF SCREEN-GROUP1 = 'M1'.  " #####

      IF P_RD1 = 'X'.

        SCREEN-ACTIVE = '0'.

      ELSE.

        SCREEN-ACTIVE = '1'.

      ENDIF.

    ELSEIF SCREEN-GROUP1 = 'M2'.  " #####

      IF P_RD1 = 'X'.

        SCREEN-ACTIVE = '1'.

      ELSE.

        SCREEN-ACTIVE = '0'.

      ENDIF.

    ENDIF.



    MODIFY SCREEN.

  ENDLOOP.

ENDFORM.




*&---------------------------------------------------------------------*

*&      Form  CHECK_MANDATORY

*&---------------------------------------------------------------------*




FORM CHECK_MANDATORY .

  " ## ## ## # ### ## ##

  IF P_RD1 = 'X'.     " ##

    IF P_BUKRS IS INITIAL OR P_ZKTOKK IS INITIAL.

      MESSAGE I000.

      STOP.

    ENDIF.

  ELSEIF P_RD2 = 'X'. " ##

    IF P_LIFNR IS INITIAL OR P_BUKRS IS INITIAL.

      MESSAGE I000.

      STOP.

    ENDIF.

  ENDIF.

ENDFORM.




*&---------------------------------------------------------------------*

*&      Form  CREATE_OBJECT

*&---------------------------------------------------------------------*




FORM CREATE_OBJECT .

  CREATE OBJECT GC_DOCKING

    EXPORTING

      REPID                       = SY-REPID  " #### ID

      DYNNR                       = SY-DYNNR  " ### ##

      EXTENSION                   = 2000.     " ## ##



  CREATE OBJECT GC_GRID

    EXPORTING

      I_PARENT          = GC_DOCKING.

ENDFORM.




*&---------------------------------------------------------------------*

*&      Form  FIELD_CATALOG_0100

*&---------------------------------------------------------------------*




FORM FIELD_CATALOG_0100 .

  CLEAR : GS_FIELDCAT, GT_FIELDCAT.

  GS_FIELDCAT-COL_POS = 1.

  GS_FIELDCAT-FIELDNAME = 'NAME1'.

  GS_FIELDCAT-SCRTEXT_M = '####'.

  APPEND GS_FIELDCAT TO GT_FIELDCAT.



  CLEAR : GS_FIELDCAT.

  GS_FIELDCAT-COL_POS = 2.

  GS_FIELDCAT-FIELDNAME = 'LAND1'.

  GS_FIELDCAT-SCRTEXT_M = '###'.

  APPEND GS_FIELDCAT TO GT_FIELDCAT.



  IF P_ZKTOKK = 3000. " ##### 3000# ##

    CLEAR : GS_FIELDCAT.

    GS_FIELDCAT-COL_POS = 3.

    GS_FIELDCAT-FIELDNAME = 'STCD1'.

    GS_FIELDCAT-SCRTEXT_M = '####'.

    APPEND GS_FIELDCAT TO GT_FIELDCAT.

  ENDIF.



  IF P_ZKTOKK <> 2000.  " ##### 2000 ## ##

    CLEAR : GS_FIELDCAT.

    GS_FIELDCAT-COL_POS = 4.

    GS_FIELDCAT-FIELDNAME = 'STCD2'.

    GS_FIELDCAT-SCRTEXT_M = '#####'.

    APPEND GS_FIELDCAT TO GT_FIELDCAT.

  ENDIF.



  CLEAR : GS_FIELDCAT.

  GS_FIELDCAT-COL_POS = 5.

  GS_FIELDCAT-FIELDNAME = 'STRAS'.

  GS_FIELDCAT-SCRTEXT_M = '##'.

  APPEND GS_FIELDCAT TO GT_FIELDCAT.



  CLEAR : GS_FIELDCAT.

  GS_FIELDCAT-COL_POS = 6.

  GS_FIELDCAT-FIELDNAME = 'ZAKONT'.

  GS_FIELDCAT-SCRTEXT_M = '##'.

  APPEND GS_FIELDCAT TO GT_FIELDCAT.



  CLEAR : GS_FIELDCAT.

  GS_FIELDCAT-COL_POS = 7.

  GS_FIELDCAT-FIELDNAME = 'ZTERM'.

  GS_FIELDCAT-SCRTEXT_M = '####'.

  APPEND GS_FIELDCAT TO GT_FIELDCAT.



  CLEAR : GS_FIELDCAT.

  GS_FIELDCAT-COL_POS = 8.

  GS_FIELDCAT-FIELDNAME = 'EKORG'.

  GS_FIELDCAT-SCRTEXT_M = '####'.

  APPEND GS_FIELDCAT TO GT_FIELDCAT.



  CLEAR : GS_FIELDCAT.

  GS_FIELDCAT-COL_POS = 9.

  GS_FIELDCAT-FIELDNAME = 'EKGRP'.

  GS_FIELDCAT-SCRTEXT_M = '####'.

  APPEND GS_FIELDCAT TO GT_FIELDCAT.



  CLEAR : GS_FIELDCAT.

  GS_FIELDCAT-COL_POS = 10.

  GS_FIELDCAT-FIELDNAME = 'WAERS'.

  GS_FIELDCAT-SCRTEXT_M = '######'.

  APPEND GS_FIELDCAT TO GT_FIELDCAT.



  CLEAR : GS_FIELDCAT.

  GS_FIELDCAT-COL_POS = 11.

  GS_FIELDCAT-FIELDNAME = 'ZMWSKZ'.

  GS_FIELDCAT-SCRTEXT_M = '####'.

  APPEND GS_FIELDCAT TO GT_FIELDCAT.

ENDFORM.




*&---------------------------------------------------------------------*

*&      Form  ALV_LAYOUT

*&---------------------------------------------------------------------*




FORM ALV_LAYOUT .

  CLEAR GS_LAYOUT.

  GS_LAYOUT-ZEBRA = 'X'.

  IF P_RD1 = 'X'. " ### ## #

    GS_LAYOUT-EDIT = 'X'.  " ## ## ##

  ELSE.

    GS_LAYOUT-EDIT = ''.

  ENDIF.



  CLEAR GS_VARIANT.

  GS_VARIANT-REPORT = SY-REPID.

  GS_VARIANT-USERNAME = SY-UNAME.

ENDFORM.




*&---------------------------------------------------------------------*

*&      Form  ALV_DISPLAY

*&---------------------------------------------------------------------*




FORM ALV_DISPLAY USING P_GT_VENDOR.

  DATA: LT_EXCLUDE TYPE UI_FUNCTIONS.



  CLEAR LT_EXCLUDE.

  IF P_RD2 = 'X'.   " ### ## ## ## ##

    APPEND CL_GUI_ALV_GRID=>MC_FC_EXCL_ALL  TO LT_EXCLUDE. " ## ## ##

  ENDIF.



  CALL METHOD GC_GRID->SET_TABLE_FOR_FIRST_DISPLAY

    EXPORTING

      IS_VARIANT                    = GS_VARIANT

      IS_LAYOUT                     = GS_LAYOUT

      I_SAVE                        = 'A'         " ALV#### #### ##### ## ##

      it_toolbar_excluding          = LT_EXCLUDE  " ### ## ## ###

    CHANGING

      IT_OUTTAB                     = P_GT_VENDOR

      IT_FIELDCATALOG               = GT_FIELDCAT.

ENDFORM.




*&---------------------------------------------------------------------*

*&      Form  REFRESH

*&---------------------------------------------------------------------*




FORM REFRESH .

  DATA LS_STABLE TYPE LVC_S_STBL.



  " #### USERCOMMAND ## ### # CURSOR## ###

  LS_STABLE-ROW = 'X'.

  LS_STABLE-COL = 'X'.



  CALL METHOD GC_GRID->REFRESH_TABLE_DISPLAY

    EXPORTING

      IS_STABLE      = LS_STABLE.

ENDFORM.




*&---------------------------------------------------------------------*

*&      Form  ALV_DATA_CHANGED_FINISHED

*&---------------------------------------------------------------------*




FORM ALV_DATA_CHANGED_FINISHED  USING    P_MODIFIED

                                         PT_GOOD_CELLS TYPE LVC_T_MODI.

  PERFORM REFRESH.

ENDFORM.




*&---------------------------------------------------------------------*

*&      Form  CLASS_EVENT

*&---------------------------------------------------------------------*




FORM CLASS_EVENT .

  " DATA_CHANGED ## ## ##

  CALL METHOD GC_GRID->REGISTER_EDIT_EVENT

    EXPORTING

      I_EVENT_ID = CL_GUI_ALV_GRID=>MC_EVT_MODIFIED.



  CREATE OBJECT GO_EVENT.



  SET HANDLER GO_EVENT->HANDLER_DATA_CHANGED_FINISHED FOR GC_GRID.

ENDFORM.




*&---------------------------------------------------------------------*

*&      Form  SAVE_DATA

*&---------------------------------------------------------------------*




FORM SAVE_DATA .

  DATA LS_LFA1 TYPE ZLFA1_04.

  DATA LS_LFB1 TYPE ZLFB1_04.

  DATA LS_LFM1 TYPE ZLFM1_04.



  LOOP AT GT_VENDOR INTO GS_VENDOR.

    CALL FUNCTION 'NUMBER_GET_NEXT'   " ##### ## ####

      EXPORTING

        NR_RANGE_NR                   = '1'

        OBJECT                        = 'ZSSU04'

      IMPORTING

        NUMBER                        = GS_VENDOR-LIFNR.



    MOVE-CORRESPONDING GS_VENDOR TO LS_LFA1.

    MOVE-CORRESPONDING GS_VENDOR TO LS_LFB1.

    MOVE-CORRESPONDING GS_VENDOR TO LS_LFM1.



    LS_LFA1-ZKTOKK = P_ZKTOKK.

    LS_LFB1-BUKRS = P_BUKRS.



    INSERT INTO ZLFA1_04 VALUES LS_LFA1.

    INSERT INTO ZLFB1_04 VALUES LS_LFB1.

    INSERT INTO ZLFM1_04 VALUES LS_LFM1.

  ENDLOOP.



  IF SY-SUBRC = 0.

    MESSAGE '####' TYPE 'I'.

  ELSE.

    MESSAGE '####' TYPE 'I'.

  ENDIF.



  " ## ####

  LEAVE TO SCREEN 0.

ENDFORM.




*&---------------------------------------------------------------------*

*&      Form  SELECT_DATA

*&---------------------------------------------------------------------*




FORM SELECT_DATA .

  CLEAR : GS_VENDOR_ALV, GT_VENDOR_ALV.



  SELECT SINGLE

      A~NAME1   " ####

      A~LAND1   " ###

      A~ZKTOKK " #####

      A~STCD1   " ####

      A~STCD2   " #####

      A~STRAS   " ##

      B~LOEVM  " #####

      B~ZAKONT  " ##

      B~ZTERM  " ####

      C~EKORG  " ####

      C~EKGRP  " ####

      C~WAERS  " ######

      C~ZMWSKZ  " ####

    INTO CORRESPONDING FIELDS OF GS_VENDOR_ALV

    FROM ZLFA1_04 AS A

      INNER JOIN ZLFB1_04 AS B

      ON A~LIFNR = B~LIFNR

      INNER JOIN ZLFM1_04 AS C

      ON A~LIFNR = C~LIFNR

    WHERE A~LIFNR = P_LIFNR

      AND B~BUKRS = P_BUKRS.



  APPEND GS_VENDOR_ALV TO GT_VENDOR_ALV.

ENDFORM.




*&---------------------------------------------------------------------*

*&      Form  FIELD_CATALOG_0200

*&---------------------------------------------------------------------*




FORM FIELD_CATALOG_0200 .

  CLEAR : GS_FIELDCAT, GT_FIELDCAT.

  GS_FIELDCAT-COL_POS = 1.

  GS_FIELDCAT-FIELDNAME = 'NAME1'.

  GS_FIELDCAT-SCRTEXT_M = '####'.

  APPEND GS_FIELDCAT TO GT_FIELDCAT.



  CLEAR : GS_FIELDCAT.

  GS_FIELDCAT-COL_POS = 2.

  GS_FIELDCAT-FIELDNAME = 'LAND1'.

  GS_FIELDCAT-SCRTEXT_M = '###'.

  APPEND GS_FIELDCAT TO GT_FIELDCAT.



  CLEAR : GS_FIELDCAT.

  GS_FIELDCAT-COL_POS = 3.

  GS_FIELDCAT-FIELDNAME = 'ZKTOKK'.

  GS_FIELDCAT-SCRTEXT_M = '#####'.

  APPEND GS_FIELDCAT TO GT_FIELDCAT.



  IF GS_VENDOR_ALV-ZKTOKK = 3000. " ##### 3000# ##

    CLEAR : GS_FIELDCAT.

    GS_FIELDCAT-COL_POS = 4.

    GS_FIELDCAT-FIELDNAME = 'STCD1'.

    GS_FIELDCAT-SCRTEXT_M = '####'.

    APPEND GS_FIELDCAT TO GT_FIELDCAT.

  ENDIF.



  IF GS_VENDOR_ALV-ZKTOKK <> 2000.  " ##### 2000 ## ##

    CLEAR : GS_FIELDCAT.

    GS_FIELDCAT-COL_POS = 5.

    GS_FIELDCAT-FIELDNAME = 'STCD2'.

    GS_FIELDCAT-SCRTEXT_M = '#####'.

    GS_FIELDCAT-EDIT = 'X'.

    APPEND GS_FIELDCAT TO GT_FIELDCAT.

  ENDIF.



  CLEAR : GS_FIELDCAT.

  GS_FIELDCAT-COL_POS = 6.

  GS_FIELDCAT-FIELDNAME = 'STRAS'.

  GS_FIELDCAT-SCRTEXT_M = '##'.

  GS_FIELDCAT-OUTPUTLEN = 16.             " # ##

  APPEND GS_FIELDCAT TO GT_FIELDCAT.



  CLEAR : GS_FIELDCAT.

  GS_FIELDCAT-COL_POS = 7.

  GS_FIELDCAT-FIELDNAME = 'LOEVM'.

  GS_FIELDCAT-SCRTEXT_M = '#####'.

  APPEND GS_FIELDCAT TO GT_FIELDCAT.



  CLEAR : GS_FIELDCAT.

  GS_FIELDCAT-COL_POS = 8.

  GS_FIELDCAT-FIELDNAME = 'ZAKONT'.

  GS_FIELDCAT-SCRTEXT_M = '##'.

  APPEND GS_FIELDCAT TO GT_FIELDCAT.



  CLEAR : GS_FIELDCAT.

  GS_FIELDCAT-COL_POS = 9.

  GS_FIELDCAT-FIELDNAME = 'ZTERM'.

  GS_FIELDCAT-SCRTEXT_M = '####'.

  APPEND GS_FIELDCAT TO GT_FIELDCAT.



  CLEAR : GS_FIELDCAT.

  GS_FIELDCAT-COL_POS = 10.

  GS_FIELDCAT-FIELDNAME = 'EKORG'.

  GS_FIELDCAT-SCRTEXT_M = '####'.

  APPEND GS_FIELDCAT TO GT_FIELDCAT.



  CLEAR : GS_FIELDCAT.

  GS_FIELDCAT-COL_POS = 11.

  GS_FIELDCAT-FIELDNAME = 'EKGRP'.

  GS_FIELDCAT-SCRTEXT_M = '####'.

  APPEND GS_FIELDCAT TO GT_FIELDCAT.



  CLEAR : GS_FIELDCAT.

  GS_FIELDCAT-COL_POS = 12.

  GS_FIELDCAT-FIELDNAME = 'WAERS'.

  GS_FIELDCAT-SCRTEXT_M = '######'.

  APPEND GS_FIELDCAT TO GT_FIELDCAT.



  CLEAR : GS_FIELDCAT.

  GS_FIELDCAT-COL_POS = 13.

  GS_FIELDCAT-FIELDNAME = 'ZMWSKZ'.

  GS_FIELDCAT-SCRTEXT_M = '####'.

  APPEND GS_FIELDCAT TO GT_FIELDCAT.

ENDFORM.




*&---------------------------------------------------------------------*

*&      Form  SAVE_REVISED_DATA

*&---------------------------------------------------------------------*




FORM SAVE_REVISED_DATA .

  READ TABLE GT_VENDOR_ALV INTO GS_VENDOR_ALV INDEX 1.  " # ## ##



  UPDATE ZLFA1_04

    SET STCD2 = GS_VENDOR_ALV-STCD2     " ##### ####

    WHERE LIFNR = P_LIFNR.



  IF SY-SUBRC = 0.

    MESSAGE '####' TYPE 'I'.

  ELSE.

    MESSAGE '####' TYPE 'I'.

  ENDIF.



  " ## ####

  LEAVE TO SCREEN 0.

ENDFORM.