
*&---------------------------------------------------------------------*

*&  Include           ZMM23_002_F01

*&---------------------------------------------------------------------*






" ##### (GV_LIFNR) ### ## : ####### ##

FORM CHECK_REQUIRED.

  DATA : LV_TEMP TYPE Z23LFA1.

  GV_FLAG = '1'.



  SELECT SINGLE LIFNR INTO LV_TEMP FROM Z23LFA1

    WHERE LIFNR = GV_LIFNR.



  IF SY-SUBRC NE 0.

    MESSAGE '#### ## ######.' TYPE 'I'.

    GV_FLAG = '0'. RETURN.



  ENDIF.



  CASE OK_CODE.

    WHEN 'ADD'.  "##

      IF GV_BUKRS IS INITIAL OR  "#### BUKRS

        GV_LIFNR IS INITIAL OR  "##### LIFNR

        GV_BEDAT IS INITIAL.  "### BEDAT

        MESSAGE '####, #####, #### ######.' TYPE 'I'.

        GV_FLAG = '0'. RETURN.

      ENDIF.



    WHEN 'SCH'.  "##

      IF GV_BUKRS IS INITIAL OR  "#### BUKRS

        GV_LIFNR IS INITIAL OR  "##### LIFNR

        GV_EBELN IS INITIAL.  "PO ##

        MESSAGE '####, #####, PO### ######.' TYPE 'I'.

        GV_FLAG = '0'. RETURN.

      ENDIF.

  ENDCASE.



ENDFORM.



FORM CHECK_DATA.

  DATA : LS_MARA TYPE Z23MARA.

  CLEAR GS_PO.

  GV_FLAG = '1'.



  LOOP AT GT_PO INTO GS_PO.

    IF GS_PO-GV_EBELP IS INITIAL

      OR GS_PO-GV_MATNR IS INITIAL

      OR GS_PO-GV_MAKTX IS INITIAL

      OR GS_PO-GV_MENGE IS INITIAL

      OR GS_PO-GV_STPRS IS INITIAL

      OR GS_PO-GV_MEINS IS INITIAL

      OR GS_PO-GV_WAERS IS INITIAL

      OR GS_PO-GV_PRDAT IS INITIAL

      OR GS_PO-GV_WERKS IS INITIAL

      OR GS_PO-GV_LGORT IS INITIAL.

      MESSAGE '## ### ######.' TYPE 'I'.

      GV_FLAG = '0'. RETURN.

    ENDIF.



    IF GV_BEDAT > GS_PO-GV_PRDAT.

      MESSAGE '#### ######.' TYPE 'I'.

      GV_FLAG = '0'. RETURN.

    ENDIF.





    SELECT SINGLE *

      FROM Z23MARA

      INTO CORRESPONDING FIELDS OF LS_MARA

      WHERE MATNR EQ GS_PO-GV_MATNR

      AND WERKS EQ GS_PO-GV_WERKS

      AND LGORT EQ GS_PO-GV_LGORT.



    IF SY-DBCNT EQ 0.

      MESSAGE '## #######.' TYPE 'I'.

      GV_FLAG = '0'. RETURN.

    ELSEIF SY-SUBRC EQ 0.

      IF LS_MARA-WERKS NE GS_PO-GV_WERKS

        OR LS_MARA-LGORT NE GS_PO-GV_LGORT.

        MESSAGE '#### ##### ######.' TYPE 'I'.

        GV_FLAG = '0'. RETURN.

      ENDIF.

    ENDIF.



   CLEAR GS_PO.



  ENDLOOP.



ENDFORM.



FORM ADD_LINE.

  CLEAR GS_PO.

  GS_PO-GV_EBELP = GV_EBELPNUM.

  GV_EBELPNUM = GV_EBELPNUM + 10.

  INSERT GS_PO INTO TABLE GT_PO.

  OK_CODE = ''.

ENDFORM.



" GT_PO# #### EKKO, EKPO # ##

FORM SAVE_PO.



  DATA : LV_EKKO TYPE Z23EKKO,  "PO ##

        LV_EKPO TYPE Z23EKPO,  "PO ###

        LV_MAX_EBELN TYPE EBELN.



  "EKKO : PO ##

  SELECT MAX( EBELN ) INTO LV_MAX_EBELN FROM Z23EKKO.



  IF LV_MAX_EBELN IS INITIAL.

    LV_MAX_EBELN = '4499999999'.

  ENDIF.

  LV_MAX_EBELN = LV_MAX_EBELN + 1.



  LV_EKKO-EBELN = LV_MAX_EBELN. "###### ####

  LV_EKKO-BEDAT = GV_BEDAT.



  SELECT B~BUKRS "####

          C~EKGRP "####

          C~EKORG "####

          C~LIFNR"#####

          C~WAERS"##

    INTO CORRESPONDING FIELDS OF LV_EKKO

    FROM Z23LFB1 AS B

    JOIN Z23LFM1 AS C

      ON B~LIFNR EQ C~LIFNR

    WHERE C~LIFNR EQ GV_LIFNR.

  ENDSELECT.



  MODIFY Z23EKKO FROM LV_EKKO.  "## ##



  "EKPO : PO ###

  CLEAR GS_PO.

  LOOP AT GT_PO INTO GS_PO.

    LV_EKPO-EBELN = LV_MAX_EBELN. "######

    LV_EKPO-EBELP = GS_PO-GV_EBELP.  "##

    LV_EKPO-MATNR = GS_PO-GV_MATNR.  "####

    LV_EKPO-MAKTX = GS_PO-GV_MAKTX.  "###

    LV_EKPO-MENGE = GS_PO-GV_MENGE.  "##

    LV_EKPO-MEINS = GS_PO-GV_MEINS.  "##

    LV_EKPO-STPRS = GS_PO-GV_STPRS.  "##

    LV_EKPO-PRDAT = GS_PO-GV_PRDAT.  "###

    LV_EKPO-WERKS = GS_PO-GV_WERKS.  "###

    LV_EKPO-LGORT = GS_PO-GV_LGORT.  "####.

    MODIFY Z23EKPO FROM LV_EKPO.



    CLEAR : LV_EKPO, GS_PO.

  ENDLOOP.



  IF SY-SUBRC EQ 0.

    MESSAGE 'PO# #######.' TYPE 'I'.



    CLEAR : GT_PO, GS_PO.

    GV_EBELPNUM = 10.

    PERFORM ADD_LINE.

  ELSE.

    DELETE Z23EKKO FROM LV_EKKO.  "## ##

  ENDIF.



ENDFORM.



FORM UPDATE_GV_EBELN.

  DATA : LV_CNT TYPE I VALUE 10.



  DELETE GT_PO WHERE GV_CHECK EQ 'X'.



  LOOP AT GT_PO ASSIGNING FIELD-SYMBOL(<FS>).

    <FS>-GV_EBELP = LV_CNT.

    LV_CNT = LV_CNT + 10.

  ENDLOOP.



  GV_EBELPNUM = LV_CNT.



   OK_CODE = ''.

ENDFORM.




*&---------------------------------------------------------------------*

*&      Form  GETDATA_300

*&---------------------------------------------------------------------*

*       text

*----------------------------------------------------------------------*

*  -->  p1        text

*  <--  p2        text

*----------------------------------------------------------------------*




FORM GETDATA_300.

  CLEAR : GS_EKKO, GT_EKPO.



  SELECT SINGLE *

    INTO CORRESPONDING FIELDS OF GS_EKKO

    FROM Z23EKKO

    WHERE EBELN EQ GV_EBELN.

  IF SY-SUBRC NE 0.

    MESSAGE '##### #### ####.' TYPE 'I'.

    LEAVE TO SCREEN 0.

  ENDIF.



  SELECT *

    INTO CORRESPONDING FIELDS OF TABLE GT_EKPO

    FROM Z23EKPO

    WHERE EBELN EQ GV_EBELN.



    IF GT_EKPO[] IS INITIAL.

      MESSAGE '#### #### #### ####.' TYPE 'I'.

      LEAVE TO SCREEN 0.

    ENDIF.



    CTR_300-LINES = SY-DBCNT.



ENDFORM.