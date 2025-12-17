
*&---------------------------------------------------------------------*

*&  Include           ZMM09_001_F01

*&---------------------------------------------------------------------*



*&---------------------------------------------------------------------*

*&      Form  CONTROL_SCREEN

*----------------------------------------------------------------------*




" ####(P_R1) ### -> ####(P_BUKRS), ####(P_KTOKK)

" ####(P_R2) ### -> #####(P_LIFNR), ####(P_BUKRS) ####

FORM CONTROL_SCREEN .

  LOOP AT SCREEN.

    IF P_R1 = 'X'. "####

      IF SCREEN-GROUP1 = 'C'.

        SCREEN-ACTIVE = 1.

      ELSEIF SCREEN-GROUP1 = 'S'.

        SCREEN-ACTIVE = 0.

      ENDIF.



    ELSEIF P_R2 = 'X'.  "####

    IF SCREEN-GROUP1 = 'C'.

        SCREEN-ACTIVE = 0.

      ELSEIF SCREEN-GROUP1 = 'S'.

        SCREEN-ACTIVE = 1.

      ENDIF.

    ENDIF.



    MODIFY SCREEN.

  ENDLOOP.

ENDFORM.






*&---------------------------------------------------------------------*

*&      Form  VALID_INPUT

*&---------------------------------------------------------------------*




FORM VALID_INPUT .

  IF P_R1 = 'X'. "##

    IF P_BUKR_C = '' OR P_KTOKK = ''.

      MESSAGE '##### ##### ########.' TYPE 'I'.

      STOP.

    ENDIF.

  ELSEIF P_R2 = 'X'. "##

    IF P_LIFNR = '' OR P_BUKR_S = ''.

      MESSAGE '###### ##### ########.' TYPE 'I'.

      STOP.

    ENDIF.

  ENDIF.

ENDFORM.






*&---------------------------------------------------------------------*

*&      Form  SAVE_DATA

*&---------------------------------------------------------------------*




FORM SAVE_DATA .

  "SNRO ### ## ####

  PERFORM GET_SNRO CHANGING GV_LIFNR.



  "### ##

  PERFORM SAVE_VENDER USING GV_LIFNR.



ENDFORM.






*&---------------------------------------------------------------------*

*&      Form  GET_SNRO

*&---------------------------------------------------------------------*




FORM GET_SNRO  CHANGING P_GV_LIFNR.

  CALL FUNCTION 'NUMBER_GET_NEXT'

    EXPORTING

      NR_RANGE_NR = '01'

      OBJECT = 'ZLIFNR09'

    IMPORTING

      NUMBER = P_GV_LIFNR.

ENDFORM.






*&---------------------------------------------------------------------*

*&      Form  SAVE_VENDER

*&---------------------------------------------------------------------*




FORM SAVE_VENDER USING P_GV_LIFNR.

  CLEAR : GS_LFA1, GS_LFB1, GS_LFM1.



  "##### ###

  GS_LFA1-MANDT = SY-MANDT.

  GS_LFA1-LIFNR = P_GV_LIFNR.

  GS_LFA1-NAME1 = GF_NAME1.

  GS_LFA1-LAND1 = GF_LAND1.

  GS_LFA1-KTOKK = P_KTOKK. "### ##### #### ####

  GS_LFA1-STCD1 = GF_STCD1.

  GS_LFA1-STCD2 = GF_STCD2.

  GS_LFA1-STRAS = GF_STRAS.



  "#### ###

  GS_LFB1-MANDT = SY-MANDT.

  GS_LFB1-LIFNR = P_GV_LIFNR.

  GS_LFB1-BUKRS = P_BUKR_C. "### ##### #### ####

  GS_LFB1-LOEVM = ''. "##### ##### ##

  GS_LFB1-AKONT = GF_AKONT.

  GS_LFB1-ZTERM = GF_ZTERM.



  "#### ###

  GS_LFM1-MANDT = SY-MANDT.

  GS_LFM1-LIFNR = P_GV_LIFNR.

  GS_LFM1-EKORG = ZLFM1_09-EKORG.

  GS_LFM1-EKGRP = ZLFM1_09-EKGRP.

  GS_LFM1-LOEVM = ''.

  GS_LFM1-WAERS = GF_WAERS.

  GS_LFM1-MWSKZ = GF_MWSKZ.



  "#### # ##

  INSERT INTO ZLFA1_09 VALUES GS_LFA1.

  IF SY-SUBRC <> 0.

    MESSAGE '##### ####' TYPE 'I'.

    ROLLBACK WORK.

    EXIT.

  ENDIF.



  INSERT INTO ZLFB1_09 VALUES GS_LFB1.

  IF SY-SUBRC <> 0.

    MESSAGE '####### ####' TYPE 'I'.

    ROLLBACK WORK.

    EXIT.

  ENDIF.



  INSERT INTO ZLFM1_09 VALUES GS_LFM1.

  IF SY-SUBRC <> 0.

    MESSAGE '#### ####' TYPE 'I'.

    ROLLBACK WORK.

    EXIT.

  ENDIF.



  "##### ### ## ####

  MESSAGE |### { P_GV_LIFNR } # #######| TYPE 'I'.

ENDFORM.






*&---------------------------------------------------------------------*

*&      Form  GET_DATA

*&---------------------------------------------------------------------*




FORM GET_DATA  USING    P_LIFNR     "#####

                        P_BUKR_S.   "####



  SELECT *

  FROM ZLFA1_09 AS a

  INNER JOIN ZLFB1_09 AS b

  ON a~LIFNR = b~LIFNR

  INNER JOIN ZLFM1_09 AS c

  ON a~LIFNR = c~LIFNR

  INTO CORRESPONDING FIELDS OF TABLE GT_ALV

  WHERE a~LIFNR = P_LIFNR "##### ###

  AND b~BUKRS = P_BUKR_S. "#### ###



  LOOP AT GT_ALV INTO GS_ALV.

  ENDLOOP.



ENDFORM.






*&---------------------------------------------------------------------*

*&      Form  REFRESH

*&---------------------------------------------------------------------*




FORM REFRESH .

  DATA : LS_STABLE TYPE LVC_S_STBL.



  LS_STABLE-ROW = 'X'. "#### usercommand ## ### #, ## ## ##

  LS_STABLE-COL = 'X'.

  CALL METHOD GC_GRID->REFRESH_TABLE_DISPLAY

    EXPORTING

      IS_STABLE      = LS_STABLE.

ENDFORM.






*&---------------------------------------------------------------------*

*&      Form  CREATE_OBJECT

*&---------------------------------------------------------------------*




FORM CREATE_OBJECT .

  "docking ##### grid #### ##

  CREATE OBJECT GC_DOCKING

    EXPORTING

      REPID                       = SY-REPID

      DYNNR                       = SY-DYNNR

      EXTENSION                   = 2000.



  CREATE OBJECT GC_GRID

    EXPORTING

      I_PARENT          = GC_DOCKING.



ENDFORM.






*&---------------------------------------------------------------------*

*&      Form  CALL_ALV

*&---------------------------------------------------------------------*




FORM CALL_ALV .

  CALL METHOD GC_GRID->SET_TABLE_FOR_FIRST_DISPLAY

    EXPORTING

      IS_VARIANT                    = GS_VARIANT

      I_SAVE                        = 'A'

      IS_LAYOUT                     = GS_LAYOUT

    CHANGING

      IT_OUTTAB                     = GT_ALV

      IT_FIELDCATALOG               = GT_FIELDCAT.



ENDFORM.






*&---------------------------------------------------------------------*

*&      Form  FIELD_CATALOG

*&---------------------------------------------------------------------*




FORM FIELD_CATALOG .

 CLEAR : GS_FIELDCAT, GT_FIELDCAT.

  GS_FIELDCAT-COL_POS = 1.

  GS_FIELDCAT-FIELDNAME = 'LIFNR'.

  GS_FIELDCAT-COLTEXT = '#####'.

  APPEND GS_FIELDCAT TO GT_FIELDCAT.



  CLEAR : GS_FIELDCAT.

  GS_FIELDCAT-COL_POS = 2.

  GS_FIELDCAT-FIELDNAME = 'NAME1'.

  GS_FIELDCAT-COLTEXT = '####'.

  APPEND GS_FIELDCAT TO GT_FIELDCAT.



  CLEAR : GS_FIELDCAT.

  GS_FIELDCAT-COL_POS = 3.

  GS_FIELDCAT-FIELDNAME = 'LAND1'.

  GS_FIELDCAT-COLTEXT = '###'.

  APPEND GS_FIELDCAT TO GT_FIELDCAT.



  CLEAR : GS_FIELDCAT.

  GS_FIELDCAT-COL_POS = 4.

  GS_FIELDCAT-FIELDNAME = 'KTOKK'.

  GS_FIELDCAT-COLTEXT = '####'.

  APPEND GS_FIELDCAT TO GT_FIELDCAT.



IF GS_ALV-KTOKK = '3000'.

    CLEAR : GS_FIELDCAT.

    GS_FIELDCAT-COL_POS = 5.

    GS_FIELDCAT-FIELDNAME = 'STCD1'.

    GS_FIELDCAT-COLTEXT = '####'.

    GS_FIELDCAT-EDIT = 'X'.

    GS_FIELDCAT-OUTPUTLEN = 20.

    APPEND GS_FIELDCAT TO GT_FIELDCAT.

ENDIF.



IF GS_ALV-KTOKK <> '2000' AND GS_ALV-KTOKK <> '3000'.

  CLEAR : GS_FIELDCAT.

  GS_FIELDCAT-COL_POS = 6.

  GS_FIELDCAT-FIELDNAME = 'STCD2'.

  GS_FIELDCAT-COLTEXT = '#####'.

  GS_FIELDCAT-EDIT = 'X'.          "## ##

  GS_FIELDCAT-OUTPUTLEN = 15.

  APPEND GS_FIELDCAT TO GT_FIELDCAT.

ENDIF.



  CLEAR : GS_FIELDCAT.

  GS_FIELDCAT-COL_POS = 7.

  GS_FIELDCAT-FIELDNAME = 'STRAS'.

  GS_FIELDCAT-COLTEXT = '##'.

  APPEND GS_FIELDCAT TO GT_FIELDCAT.



  CLEAR : GS_FIELDCAT.

  GS_FIELDCAT-COL_POS = 8.

  GS_FIELDCAT-FIELDNAME = 'BUKRS'.

  GS_FIELDCAT-COLTEXT = '####'.

  APPEND GS_FIELDCAT TO GT_FIELDCAT.



  CLEAR : GS_FIELDCAT.

  GS_FIELDCAT-COL_POS = 9.

  GS_FIELDCAT-FIELDNAME = 'AKONT'.

  GS_FIELDCAT-COLTEXT = '##'.

  APPEND GS_FIELDCAT TO GT_FIELDCAT.



  CLEAR : GS_FIELDCAT.

  GS_FIELDCAT-COL_POS = 10.

  GS_FIELDCAT-FIELDNAME = 'ZTERM'.

  GS_FIELDCAT-COLTEXT = '####'.

  APPEND GS_FIELDCAT TO GT_FIELDCAT.



  CLEAR : GS_FIELDCAT.

  GS_FIELDCAT-COL_POS = 11.

  GS_FIELDCAT-FIELDNAME = 'EKORG'.

  GS_FIELDCAT-COLTEXT = '####'.

  APPEND GS_FIELDCAT TO GT_FIELDCAT.



  CLEAR : GS_FIELDCAT.

  GS_FIELDCAT-COL_POS = 12.

  GS_FIELDCAT-FIELDNAME = 'EKGRP'.

  GS_FIELDCAT-COLTEXT = '####'.

  APPEND GS_FIELDCAT TO GT_FIELDCAT.



  CLEAR : GS_FIELDCAT.

  GS_FIELDCAT-COL_POS = 13.

  GS_FIELDCAT-FIELDNAME = 'WAERS'.

  GS_FIELDCAT-COLTEXT = '######'.

  APPEND GS_FIELDCAT TO GT_FIELDCAT.



  CLEAR : GS_FIELDCAT.

  GS_FIELDCAT-COL_POS = 14.

  GS_FIELDCAT-FIELDNAME = 'MWSKZ'.

  GS_FIELDCAT-COLTEXT = '####'.

  APPEND GS_FIELDCAT TO GT_FIELDCAT.

ENDFORM.






*&---------------------------------------------------------------------*

*&      Form  ALV_LAYOUT

*&---------------------------------------------------------------------*




FORM ALV_LAYOUT .

  CLEAR : GS_LAYOUT, GS_VARIANT.



  GS_LAYOUT-ZEBRA = 'X'.

  GS_VARIANT-REPORT = SY-REPID.

  GS_VARIANT-USERNAME = SY-UNAME.

ENDFORM.






*&---------------------------------------------------------------------*

*&      Form  CLASS_EVENT

*&---------------------------------------------------------------------*




FORM CLASS_EVENT .

  CREATE OBJECT GO_EVENT.



  "##### ### ##

  CALL METHOD GC_GRID->REGISTER_EDIT_EVENT

    EXPORTING

      I_EVENT_ID = CL_GUI_ALV_GRID=>MC_EVT_MODIFIED.



  "###### ##

  SET HANDLER GO_EVENT->HANDLER_DATA_CHANGED FOR GC_GRID.

  SET HANDLER GO_EVENT->HANDLER_DATA_CHANGED_FINISHED FOR GC_GRID.

ENDFORM.






*&---------------------------------------------------------------------*

*&      Form  ALV_HANDLER_DATA_CHANGED

*&---------------------------------------------------------------------*




FORM ALV_HANDLER_DATA_CHANGED  USING    P_ER_DATA_CHANGED TYPE REF TO CL_ALV_CHANGED_DATA_PROTOCOL

                                        P_E_ONF4

                                        P_E_ONF4_BEFORE

                                        P_E_ONF4_AFTER

                                        P_E_UCOMM.



  DATA : LS_MODI TYPE LVC_S_MODI,

         LV_VALUE TYPE STRING.



  LOOP AT P_ER_DATA_CHANGED->MT_GOOD_CELLS INTO LS_MODI.

      CLEAR : GS_ALV.



      READ TABLE GT_ALV INTO GS_ALV INDEX LS_MODI-ROW_ID.



      "###### #### ##

      IF LS_MODI-FIELDNAME = 'STCD2' OR LS_MODI-FIELDNAME = 'STCD1'.

        LV_VALUE = LS_MODI-VALUE.



        IF STRLEN( LV_VALUE ) = 0. "# # ##

          "alv# ## ##

          CALL METHOD P_ER_DATA_CHANGED->ADD_PROTOCOL_ENTRY

            EXPORTING

              I_MSGID = 'ZMED09'

              I_MSGTY = 'E'

              I_MSGNO = '020'

              I_FIELDNAME = LS_MODI-FIELDNAME

              I_ROW_ID = LS_MODI-ROW_ID.



        ENDIF.



        "#### - 16####

        IF LS_MODI-FIELDNAME = 'STCD1'.

          LV_VALUE = LS_MODI-VALUE.



          IF STRLEN( LV_VALUE ) > 16.

            "alv# ## ##

            CALL METHOD P_ER_DATA_CHANGED->ADD_PROTOCOL_ENTRY

              EXPORTING

                I_MSGID = 'ZMED09'

                I_MSGTY = 'E'

                I_MSGNO = '022'

                I_FIELDNAME = LS_MODI-FIELDNAME

                I_ROW_ID = LS_MODI-ROW_ID.



          ENDIF.

        ENDIF.



        "##### - 11####

        IF LS_MODI-FIELDNAME = 'STCD2'.

          LV_VALUE = LS_MODI-VALUE.



          IF STRLEN( LV_VALUE ) > 11.

            "alv# ## ##

            CALL METHOD P_ER_DATA_CHANGED->ADD_PROTOCOL_ENTRY

              EXPORTING

                I_MSGID = 'ZMED09'

                I_MSGTY = 'E'

                I_MSGNO = '023'

                I_FIELDNAME = LS_MODI-FIELDNAME

                I_ROW_ID = LS_MODI-ROW_ID.



          ENDIF.

        ENDIF.



      ENDIF.



  ENDLOOP.

ENDFORM.






*&---------------------------------------------------------------------*

*&      Form  ALV_DATA_CHANGED_FINISHED

*&---------------------------------------------------------------------*




FORM ALV_DATA_CHANGED_FINISHED  USING    P_E_MODIFIED

                                         P_ET_GOOD_CELLS TYPE LVC_T_MODI.

  MESSAGE '##### #######. ### #####.' TYPE 'S'.

ENDFORM.






*&---------------------------------------------------------------------*

*&      Form  INIT_DATA

*&---------------------------------------------------------------------*

*       text

*----------------------------------------------------------------------*

*  -->  p1        text

*  <--  p2        text

*----------------------------------------------------------------------*




FORM INIT_DATA .

  GF_KTOKK = P_KTOKK.



  "#### ## ### ##

  GF_NAME1 = '### ###'.

  GF_LAND1 = 'KR'.

  GF_STCD1 = '01012345678'. "####

  GF_STCD2 = '123-45-6789'. "#####

  GF_STRAS = '### ### ###'.



  "####

  ZLFB1_09-AKONT = '2100001010'.

  ZLFB1_09-ZTERM = 'M001'.



  "#### / ####

  ZLFM1_09-EKORG = '1000'.

  ZLFM1_09-EKGRP = '101'.

  GF_WAERS = 'KRW'.

  ZLFM1_09-MWSKZ = 'V1'.



ENDFORM.