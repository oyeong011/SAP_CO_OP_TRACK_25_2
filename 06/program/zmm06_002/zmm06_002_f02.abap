
*&---------------------------------------------------------------------*

*&  Include           ZMM06_002_F02

*&---------------------------------------------------------------------*

*&---------------------------------------------------------------------*

*&      Form  PO_CREATE

*&---------------------------------------------------------------------*

*       text

*----------------------------------------------------------------------*

*  -->  p1        text

*  <--  p2        text

*----------------------------------------------------------------------*




FORM PO_CREATE .

    " ## ## ## ##.

    CALL SCREEN 200.



ENDFORM.






*&---------------------------------------------------------------------*

*&      Form  SAVE_PO

*&---------------------------------------------------------------------*

*       text

*----------------------------------------------------------------------*

*  -->  p1        text

*  <--  p2        text

*----------------------------------------------------------------------*




FORM SAVE_PO .

  DATA : LV_EKKO_DB TYPE ZEDT06_EKKO,

         LV_EKPO_DB TYPE ZEDT06_EKPO.



  DATA : LV_EBELN TYPE ZEDT06_EKKO-EBELN,

         LV_EBELN_MAX TYPE ZEDT06_EKKO-EBELN.



  DATA : LV_LFM1_DB TYPE ZEDT06_LFM1.

  DATA : LV_SEL_CNT TYPE I.



  LOOP AT GT_PO_ALV INTO GS_PO_ALV WHERE SEL = 'X'.

    LV_SEL_CNT = LV_SEL_CNT + 1.

  ENDLOOP.



  IF LV_SEL_CNT = 0.

    MESSAGE '### ### ####.' TYPE 'E'.

    LEAVE SCREEN.

  ENDIF.



  " 1. ## ## ##.

  SELECT MAX( EBELN )

    INTO LV_EBELN_MAX

    FROM ZEDT06_EKKO.



  IF LV_EBELN_MAX IS INITIAL.

    LV_EBELN = 1000000000.

  ELSE.

    LV_EBELN = LV_EBELN_MAX + 1.

  ENDIF.



  " 2. ## ## ### ##.

  LOOP AT GT_PO_ALV INTO GS_PO_ALV.

    IF GS_PO_ALV-SEL <> 'X'.

      CONTINUE.

    ENDIF.



    " 2-1. ## ### ## ### ##.

    PERFORM VALIDATION_PO_GS USING GS_PO_ALV.



    " 2-2. ## ## ## ### INSERT

    LV_EKPO_DB-EBELN = LV_EBELN.

    LV_EKPO_DB-EBELP = GS_PO_ALV-EBELP.

    LV_EKPO_DB-MATNR = GS_PO_ALV-MATNR.

    LV_EKPO_DB-MAKTX = GS_PO_ALV-MAKTX.

    LV_EKPO_DB-MENGE = GS_PO_ALV-MENGE.

    LV_EKPO_DB-MEINS = GS_PO_ALV-MEINS.

    LV_EKPO_DB-BPRME = GS_PO_ALV-BPRME.

    LV_EKPO_DB-PRDAT = GS_PO_ALV-PRDAT.

    LV_EKPO_DB-WERKS = GS_PO_ALV-WERKS.

    LV_EKPO_DB-LGORT = GS_PO_ALV-LGORT.

    INSERT ZEDT06_EKPO FROM LV_EKPO_DB.

  ENDLOOP.



  " 3. ## ## ##.

  SELECT SINGLE * FROM ZEDT06_LFM1

  INTO LV_LFM1_DB

  WHERE LIFNR = P_LIFNR1.



  LV_EKKO_DB-EBELN = LV_EBELN.

  LV_EKKO_DB-BUKRS = P_BUKRS.

  LV_EKKO_DB-EKGRP = LV_LFM1_DB-EKGRP.

  LV_EKKO_DB-EKORG = LV_LFM1_DB-EKORG.

  LV_EKKO_DB-LIFNR = P_LIFNR1.

  LV_EKKO_DB-BEDAT = P_BEDAT.

  LV_EKKO_DB-WAERS = 'KRW'.



  INSERT ZEDT06_EKKO FROM LV_EKKO_DB.



  " 4. ### #### ALV## ##.

  DELETE GT_PO_ALV WHERE SEL = 'X'.



  IF SY-SUBRC = 0.

    MESSAGE '### ##### #######.' TYPE 'I'.

  ENDIF.



  COMMIT WORK.



ENDFORM.






*&---------------------------------------------------------------------*

*&      Form  ADD_PO

*&---------------------------------------------------------------------*

*       text

*----------------------------------------------------------------------*

*  -->  p1        text

*  <--  p2        text

*----------------------------------------------------------------------*




FORM ADD_PO .



  DATA: LV_MAX_POS TYPE ZEDT06_EKPO-EBELP.



  " 1. ## ##### ## EBELP ##

  IF GT_PO_ALV IS NOT INITIAL.

    LOOP AT GT_PO_ALV INTO GS_PO_ALV.

      IF GS_PO_ALV-EBELP > LV_MAX_POS.

        LV_MAX_POS = GS_PO_ALV-EBELP.

      ENDIF.

    ENDLOOP.

  ENDIF.



  " 2. #### ## ## (10,20,30...)

  LV_MAX_POS = LV_MAX_POS + 10.



  " 3. ## ## ## (### ## ##)

  CLEAR GS_PO_ALV.

  GS_PO_ALV-EBELP = LV_MAX_POS.



  " 4. ###### ##

  APPEND GS_PO_ALV TO GT_PO_ALV.



  " 5. ALV ###

  PERFORM REFRESH.

ENDFORM.




*&---------------------------------------------------------------------*

*&      Form  DEL_PO

*&---------------------------------------------------------------------*

*       text

*----------------------------------------------------------------------*

*  -->  p1        text

*  <--  p2        text

*----------------------------------------------------------------------*




FORM DEL_PO .



  DELETE GT_PO_ALV WHERE SEL = 'X'.



  PERFORM REFRESH.



ENDFORM.








*&---------------------------------------------------------------------*

*&      Form  VALIDATION_PO_GS

*&---------------------------------------------------------------------*

*       text

*----------------------------------------------------------------------*

*      -->P_GS_PO_ALV  text

*----------------------------------------------------------------------*




FORM VALIDATION_PO_GS  USING   PS_PO_ALV TYPE TY_PO_ALV.



  DATA LS_MAT TYPE ZEDT06_MAT.



  IF PS_PO_ALV-MATNR IS INITIAL.

    MESSAGE '##### #####' TYPE 'E'.

  ENDIF.



  IF PS_PO_ALV-MENGE IS INITIAL.

    MESSAGE 'PO### #####' TYPE 'E'.

  ENDIF.



  IF PS_PO_ALV-BPRME IS INITIAL.

    MESSAGE '### #####' TYPE 'E'.

  ENDIF.



  IF PS_PO_ALV-MEINS IS INITIAL.

    MESSAGE '### #####' TYPE 'E'.

  ENDIF.



  IF PS_PO_ALV-MWSKZ IS INITIAL.

    MESSAGE '##### #####' TYPE 'E'.

  ENDIF.



  IF PS_PO_ALV-PRDAT IS INITIAL.

    MESSAGE '#### #####' TYPE 'E'.

  ENDIF.



  IF PS_PO_ALV-PRDAT < P_BEDAT.

    MESSAGE '#### ##### ### #######..' TYPE 'E'.

  ENDIF.



  DATA LV_VALUE TYPE LVC_VALUE.



  LV_VALUE = PS_PO_ALV-WERKS.

  PERFORM CHECK_DOMAIN_VALUE USING 'ZWERKS06' LV_VALUE.



  LV_VALUE = PS_PO_ALV-LGORT.

  PERFORM CHECK_DOMAIN_VALUE USING 'ZLGORT06' LV_VALUE.



ENDFORM.








*&---------------------------------------------------------------------*

*&      Form  ALV_HANDLE_DATA_CHANGED

*&---------------------------------------------------------------------*

*       text

*----------------------------------------------------------------------*

*      -->P_ER_DATA_CHANGED  text

*      -->P_E_ONF4  text

*      -->P_E_ONF4_BEFORE  text

*      -->P_E_ONF4_AFTER  text

*      -->P_E_UCOMM  text

*----------------------------------------------------------------------*




FORM ALV_HANDLE_DATA_CHANGED  USING    PR_DATA_CHANGED TYPE REF TO CL_ALV_CHANGED_DATA_PROTOCOL

                                       P_ONF4

                                       P_ONF4_BEFORE

                                       P_ONF4_AFTER

                                       P_UCOMM.



  IF P_UCOMM = 'DEL'.

    RETURN.

  ENDIF.



  DATA : LS_MODI TYPE LVC_S_MODI.

  DATA : LV_LEN(02).



  CLEAR : LS_MODI, LV_LEN.



  LOOP AT PR_DATA_CHANGED->MT_MOD_CELLS INTO LS_MODI.



    READ TABLE GT_PO_ALV INTO GS_PO_ALV INDEX LS_MODI-ROW_ID.



    ASSIGN COMPONENT ls_modi-fieldname OF STRUCTURE GS_PO_ALV TO FIELD-SYMBOL(<fs>).

    IF <fs> IS ASSIGNED.

      <fs> = ls_modi-value.

    ENDIF.



    CASE LS_MODI-FIELDNAME.



      WHEN 'MATNR'.  " ##### ####

        PERFORM CHECK_MATNR USING PR_DATA_CHANGED LS_MODI-ROW_ID LS_MODI-VALUE.

      WHEN 'MWSKZ'.  " ##### ####

        PERFORM CHECK_MWSKZ USING LS_MODI-ROW_ID LS_MODI-VALUE.

      WHEN 'WERKS'.

        PERFORM CHECK_DOMAIN_VALUE USING 'ZWERKS06' LS_MODI-VALUE.

      WHEN 'LGORT'.

        PERFORM CHECK_DOMAIN_VALUE USING 'ZLGORT06' LS_MODI-VALUE.

    ENDCASE.



    " # #### ## AVL# ####

    MODIFY GT_PO_ALV FROM GS_PO_ALV INDEX LS_MODI-ROW_ID.



  ENDLOOP.





ENDFORM.




*&---------------------------------------------------------------------*

*&      Form  CHECK_MATNR

*&---------------------------------------------------------------------*

*       text

*----------------------------------------------------------------------*




FORM CHECK_DOMAIN_VALUE

  USING

    P_DOMNAME TYPE DD07L-DOMNAME

    P_VALUE   TYPE LVC_VALUE.



  DATA LV_DUMMY TYPE DD07L-DOMVALUE_L.



  SELECT SINGLE DOMVALUE_L

    INTO LV_DUMMY

    FROM DD07L

    WHERE DOMNAME    = P_DOMNAME

      AND DOMVALUE_L = P_VALUE.



  IF SY-SUBRC <> 0.

    MESSAGE |### { P_DOMNAME }# #### ## ####.| TYPE 'E'.

  ENDIF.



ENDFORM.




*&---------------------------------------------------------------------*

*&      Form  CHECK_MATNR

*&---------------------------------------------------------------------*

*       text

*----------------------------------------------------------------------*

*      -->P_LS_MODI_ROW_ID  text

*      -->P_LS_MODI_VALUE  text

*----------------------------------------------------------------------*




FORM CHECK_MATNR USING PR_DATA_CHANGED TYPE REF TO CL_ALV_CHANGED_DATA_PROTOCOL

                        P_ROW_ID

                        P_MATNR.



  DATA : LS_MAT   TYPE ZEDT06_MAT,

         LS_MOD   TYPE LVC_S_MODI,

         LV_MATNR TYPE ZEDT06_MAT-ZMATNR.



  " 0) ##### #### STOP

  IF P_MATNR IS INITIAL.

    MESSAGE '##### #### #####.' TYPE 'E'.

  ENDIF.



  " 1) ## ## + 0 ##(ALPHA INPUT)

  LV_MATNR = P_MATNR.

  CONDENSE LV_MATNR NO-GAPS.



  CALL FUNCTION 'CONVERSION_EXIT_ALPHA_INPUT'

    EXPORTING

      INPUT  = LV_MATNR

    IMPORTING

      OUTPUT = LV_MATNR.



  " 2) ##### ##

  SELECT SINGLE *

    FROM ZEDT06_MAT

    INTO @LS_MAT

    WHERE ZMATNR = @LV_MATNR.



  IF SY-SUBRC <> 0.

    MESSAGE '#### ## #######.' TYPE 'E'.

  ENDIF.



  " ##### # ##

  READ TABLE GT_PO_ALV INTO GS_PO_ALV INDEX P_ROW_ID.

  GS_PO_ALV-MATNR = LV_MATNR.

  GS_PO_ALV-MAKTX = LS_MAT-ZMATNAME.

  GS_PO_ALV-MEINS = LS_MAT-MEINS.

  GS_PO_ALV-WAERS = LS_MAT-WAERS.

  GS_PO_ALV-BPRME = LS_MAT-STPRS.



  MODIFY GT_PO_ALV FROM GS_PO_ALV INDEX P_ROW_ID.



  "--- ## ## (GOODCELLS ##) -----



    CLEAR LS_MOD.

  LS_MOD-ROW_ID = P_ROW_ID.

  LS_MOD-FIELDNAME = 'MATNR'.

  LS_MOD-VALUE = LV_MATNR.

  INSERT LS_MOD INTO TABLE PR_DATA_CHANGED->MT_GOOD_CELLS.



  CLEAR LS_MOD.

  LS_MOD-ROW_ID = P_ROW_ID.

  LS_MOD-FIELDNAME = 'MAKTX'.

  LS_MOD-VALUE = GS_PO_ALV-MAKTX.

  INSERT LS_MOD INTO TABLE PR_DATA_CHANGED->MT_GOOD_CELLS.



  CLEAR LS_MOD.

  LS_MOD-ROW_ID = P_ROW_ID.

  LS_MOD-FIELDNAME = 'MEINS'.

  LS_MOD-VALUE = GS_PO_ALV-MEINS.

  INSERT LS_MOD INTO TABLE PR_DATA_CHANGED->MT_GOOD_CELLS.



  CLEAR LS_MOD.

  LS_MOD-ROW_ID = P_ROW_ID.

  LS_MOD-FIELDNAME = 'WAERS'.

  LS_MOD-VALUE = GS_PO_ALV-WAERS.

  INSERT LS_MOD INTO TABLE PR_DATA_CHANGED->MT_GOOD_CELLS.



  CLEAR LS_MOD.

  LS_MOD-ROW_ID = P_ROW_ID.

  LS_MOD-FIELDNAME = 'BPRME'.

  LS_MOD-VALUE = GS_PO_ALV-BPRME.

  INSERT LS_MOD INTO TABLE PR_DATA_CHANGED->MT_GOOD_CELLS.



ENDFORM.




*&---------------------------------------------------------------------*

*&      Form  CHECK_MWSKZ

*&---------------------------------------------------------------------*

*       text

*----------------------------------------------------------------------*

*      -->P_LS_MODI_ROW_ID  text

*      -->P_LS_MODI_VALUE  text

*----------------------------------------------------------------------*




FORM CHECK_MWSKZ  USING    P_LS_MODI_ROW_ID

                           P_LS_MODI_VALUE.



ENDFORM.