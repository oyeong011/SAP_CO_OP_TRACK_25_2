
*&---------------------------------------------------------------------*

*&  Include           ZMM09_002_F01

*&---------------------------------------------------------------------*

*&---------------------------------------------------------------------*

*&      Form  CONTROL_SCREEN

*&---------------------------------------------------------------------*




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

*   - #### #, ### ##### ## (## #### ####### ## ######## ##)

*&---------------------------------------------------------------------*




FORM VALID_INPUT  USING    P_LIFN_C P_BUKR_C.




*  "### ##

*  IF ( P_BUKR_C IS INITIAL ) OR ( P_LIFN_C IS INITIAL ) OR ( P_BEDAT IS INITIAL ).

*    MESSAGE '####, ###, #### ########' TYPE 'I'.

*    EXIT.

*  ENDIF.






  "##### ## ##

  SELECT SINGLE LIFNR

  FROM ZLFA1_09

  INTO GS_LFA1-LIFNR

  WHERE LIFNR = P_LIFN_C.



  IF SY-SUBRC <> 0.

    MESSAGE '#### #### ####.' TYPE 'E'.

    EXIT.

  ENDIF.



  "#### ### ## ##

  SELECT SINGLE *

  FROM ZLFB1_09

  INTO GS_LFB1

  WHERE LIFNR = P_LIFN_C

  AND   BUKRS = P_BUKR_C.



  IF SY-SUBRC <> 0.

    MESSAGE '## ##### #### #### ####' TYPE 'E'.

    EXIT.

  ENDIF.



ENDFORM.






*&---------------------------------------------------------------------*

*&      Form  SAVE_DATA

*&---------------------------------------------------------------------*




FORM SAVE_DATA .

  CLEAR : GS_EKKO.

  "PO ## ###

  PERFORM GET_EBELN CHANGING GS_EKKO-EBELN.



  "#### ###

  GS_EKKO-MANDT = SY-MANDT.

  GS_EKKO-BUKRS = P_BUKR_C. "####

  GS_EKKO-EKGRP = GF_EKGRP. "####

  GS_EKKO-EKORG = GF_EKORG. "####

  GS_EKKO-LIFNR = P_LIFN_C. "###

  GS_EKKO-BEDAT = P_BEDAT.  "###



  "## ####

  SELECT SINGLE WAERS

  FROM ZLFM1_09

  INTO GS_EKKO-WAERS

  WHERE LIFNR = P_LIFN_C.



  INSERT INTO ZEKKO_09 VALUES GS_EKKO.

  IF SY-SUBRC <> 0.

    MESSAGE '#### ####' TYPE 'I'.

    ROLLBACK WORK.

    EXIT.

  ENDIF.



  "#### ###

  CLEAR : GS_ITEM.

  LOOP AT GT_ITEM INTO GS_ITEM.

    MOVE-CORRESPONDING GS_ITEM TO GS_EKPO.



    "## ## ###

    GS_EKPO-MANDT = SY-MANDT.

    GS_EKPO-EBELN = GS_EKKO-EBELN. "### ## ID



    "### #### ## (bprme)

    GS_EKPO-BPRME = GS_ITEM-MEINS.

    APPEND GS_EKPO TO GT_EKPO.

    CLEAR : GS_ITEM.

  ENDLOOP.



  INSERT ZEKPO_09 FROM TABLE GT_EKPO.



  IF SY-SUBRC = 0.

    MESSAGE |## PO# ## { GS_EKKO-EBELN } ## ###### | TYPE 'I'.

  ENDIF.



ENDFORM.






*&---------------------------------------------------------------------*

*&      Form  GET_EBELN

*&---------------------------------------------------------------------*




FORM GET_EBELN  CHANGING P_EKPO_EBELN.

  CALL FUNCTION 'NUMBER_GET_NEXT'

    EXPORTING

      NR_RANGE_NR = '01'

      OBJECT = 'ZEBELN09_1'

    IMPORTING

      NUMBER = P_EKPO_EBELN.

ENDFORM.






*&---------------------------------------------------------------------*

*&      Form  CREATE_OBJECT

*&---------------------------------------------------------------------*




FORM CREATE_OBJECT .

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

  GS_FIELDCAT-FIELDNAME = 'EBELP'.

  GS_FIELDCAT-COLTEXT = '##'.

  APPEND GS_FIELDCAT TO GT_FIELDCAT.



 CLEAR : GS_FIELDCAT.

  GS_FIELDCAT-COL_POS = 2.

  GS_FIELDCAT-FIELDNAME = 'MATNR'.

  GS_FIELDCAT-COLTEXT = '####'.

  APPEND GS_FIELDCAT TO GT_FIELDCAT.



 CLEAR : GS_FIELDCAT.

  GS_FIELDCAT-COL_POS = 3.

  GS_FIELDCAT-FIELDNAME = 'MAKTX'.

  GS_FIELDCAT-COLTEXT = '###'.

  APPEND GS_FIELDCAT TO GT_FIELDCAT.



 CLEAR : GS_FIELDCAT.

  GS_FIELDCAT-COL_POS = 4.

  GS_FIELDCAT-FIELDNAME = 'MENGE'.

  GS_FIELDCAT-COLTEXT = 'PO##'.

  APPEND GS_FIELDCAT TO GT_FIELDCAT.



 CLEAR : GS_FIELDCAT.

  GS_FIELDCAT-COL_POS = 5.

  GS_FIELDCAT-FIELDNAME = 'STPRS'.

  GS_FIELDCAT-COLTEXT = '##'.

  APPEND GS_FIELDCAT TO GT_FIELDCAT.



 CLEAR : GS_FIELDCAT.

  GS_FIELDCAT-COL_POS = 6.

  GS_FIELDCAT-FIELDNAME = 'MEINS'.

  GS_FIELDCAT-COLTEXT = '##'.

  APPEND GS_FIELDCAT TO GT_FIELDCAT.



 CLEAR : GS_FIELDCAT.

  GS_FIELDCAT-COL_POS = 7.

  GS_FIELDCAT-FIELDNAME = 'WAERS'.

  GS_FIELDCAT-COLTEXT = '##'.

  APPEND GS_FIELDCAT TO GT_FIELDCAT.



 CLEAR : GS_FIELDCAT.

  GS_FIELDCAT-COL_POS = 8.

  GS_FIELDCAT-FIELDNAME = 'MWSKZ'.

  GS_FIELDCAT-COLTEXT = '####'.

  APPEND GS_FIELDCAT TO GT_FIELDCAT.



 CLEAR : GS_FIELDCAT.

  GS_FIELDCAT-COL_POS = 9.

  GS_FIELDCAT-FIELDNAME = 'BEDAT'.

  GS_FIELDCAT-COLTEXT = '###'.

  APPEND GS_FIELDCAT TO GT_FIELDCAT.



 CLEAR : GS_FIELDCAT.

  GS_FIELDCAT-COL_POS = 10.

  GS_FIELDCAT-FIELDNAME = 'WERKS'.

  GS_FIELDCAT-COLTEXT = '###'.

  APPEND GS_FIELDCAT TO GT_FIELDCAT.



 CLEAR : GS_FIELDCAT.

  GS_FIELDCAT-COL_POS = 11.

  GS_FIELDCAT-FIELDNAME = 'LGORT'.

  GS_FIELDCAT-COLTEXT = '####'.

  APPEND GS_FIELDCAT TO GT_FIELDCAT.

ENDFORM.






*&---------------------------------------------------------------------*

*&      Form  GET_DATA

*&---------------------------------------------------------------------*

*       text

*----------------------------------------------------------------------*

*      -->P_P_LIFN_S  text

*      -->P_P_BUKR_S  text

*      -->P_P_EBELN  text

*----------------------------------------------------------------------*




FORM GET_DATA  USING    P_LIFN_S "###

                        P_BUKR_S "####

                        P_EBELN.  "PO##

  CLEAR : GS_EKKO, GS_EKPO, GT_EKPO.



  "#### ####

  SELECT SINGLE *

  FROM ZEKKO_09

  INTO GS_EKKO

  WHERE EBELN = P_EBELN

  AND   BUKRS = P_BUKR_S

  AND   LIFNR = P_LIFN_S.



  IF SY-SUBRC <> 0.

    MESSAGE '#### ## #######.' TYPE 'I'.

    STOP.

  ENDIF.



  "##### ####

  SELECT *

  FROM ZEKPO_09

  INTO CORRESPONDING FIELDS OF TABLE GT_EKPO

  WHERE EBELN = P_EBELN.



  IF SY-SUBRC <> 0.

    MESSAGE '## ####### #### #### ####.' TYPE 'I'.

    STOP.

  ENDIF.



  "### ####

ENDFORM.






*&---------------------------------------------------------------------*

*&      Form  MODIFY_DATA

*     - ALV ###

*&---------------------------------------------------------------------*




FORM MODIFY_DATA .

  CLEAR : GS_ALV.



  "#### ## ###

  GS_ALV-WAERS = GS_EKKO-WAERS.

  GS_ALV-BEDAT = GS_EKKO-BEDAT.



  "##### ###

  CLEAR : GS_EKPO.

  LOOP AT GT_EKPO INTO GS_EKPO.

    MOVE-CORRESPONDING GS_EKPO TO GS_ALV.



    APPEND GS_ALV TO GT_ALV.

    CLEAR : GS_EKPO.

  ENDLOOP.

ENDFORM.






*&---------------------------------------------------------------------*

*&      Form  ALV_LAYOUT

*&---------------------------------------------------------------------*




FORM ALV_LAYOUT .

  CLEAR : GS_LAYOUT.



  GS_LAYOUT-ZEBRA = 'X'.

ENDFORM.






*&---------------------------------------------------------------------*

*&      Form  VALUD_INPUT_ALL

*&---------------------------------------------------------------------*




FORM VALUD_INPUT_ALL .

  IF P_R1 = 'X'.

    IF ( P_BUKR_C IS INITIAL ) OR ( P_LIFN_C IS INITIAL ) OR ( P_BEDAT IS INITIAL ).

      MESSAGE '####, ###, #### ########' TYPE 'I'.

      STOP.

    ENDIF.

  ELSEIF P_R2 = 'X'.

    IF ( P_LIFN_S IS INITIAL ) OR ( P_BUKR_S IS INITIAL ) OR ( P_EBELN IS INITIAL ).

      MESSAGE '###, ####, PO### ########' TYPE 'I'.

      STOP.

    ENDIF.

  ENDIF.



ENDFORM.