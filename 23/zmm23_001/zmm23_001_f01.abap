
*&---------------------------------------------------------------------*

*&  Include           ZMM23_001_F01

*&---------------------------------------------------------------------*






FORM CHECK_DATA.

  CASE OK_CODE.

    WHEN 'ADD'.          "##

      IF GV_BUKRS IS INITIAL OR GV_KTOKK IS INITIAL.

        MESSAGE '####, ###### ######.' TYPE 'E'.

      ENDIF.

    WHEN 'SCH'.          "##

      IF GV_LIFNR IS INITIAL OR GV_BUKRS IS INITIAL.

        MESSAGE '#####, ##### ######.' TYPE 'E'.

      ENDIF.

  ENDCASE.



ENDFORM.



FORM CHECK_REQUIRED.

  GV_FLAG = '1'.

  IF GV_NAME1 IS INITIAL

    OR GV_LAND1 IS INITIAL

    OR GV_STRAS IS INITIAL

    OR GV_AKONT IS INITIAL

    OR GV_ZTERM IS INITIAL

    OR GV_EKORG IS INITIAL

    OR GV_EKGRP IS INITIAL

    OR GV_WAERS IS INITIAL

    OR GV_MWSKZ IS INITIAL.

    GV_FLAG = '0'.

    MESSAGE '## ### ######.' TYPE 'I'.

  ENDIF.



  CASE GV_KTOKK.

    WHEN '1000'.

      IF GV_STCD2 IS INITIAL.

        GV_FLAG = '0'.

        MESSAGE '###### ######.' TYPE 'I'.

      ENDIF.

    WHEN '3000'.

      IF GV_STCD1 IS INITIAL.

        GV_FLAG = '0'.

        MESSAGE '##### ######.' TYPE 'I'.

      ENDIF.

  ENDCASE.



ENDFORM.



" 200_## ## ## # #####.

FORM ADD_TO_VENDOR.

  "Z23LFA1, Z23LFB1, Z23LFM1# #####,

  DATA : LV_LFA1 TYPE Z23LFA1,

        LV_LFB1 TYPE Z23LFB1,

        LV_LFM1 TYPE Z23LFM1,

        LV_MAX_LIFNR TYPE LIFNR.






*** 1. ###### ## #### ***




  SELECT MAX( LIFNR ) INTO LV_MAX_LIFNR FROM Z23LFA1.

  IF LV_MAX_LIFNR IS INITIAL.

    LV_MAX_LIFNR = '999999999'.

  ENDIF.

  LV_MAX_LIFNR = LV_MAX_LIFNR + 1.

  " ### ##

  LV_LFA1-LIFNR = LV_MAX_LIFNR.

  LV_LFA1-NAME1 = GV_NAME1.

  LV_LFA1-LAND1 = GV_LAND1.

  LV_LFA1-KTOKK = GV_KTOKK.

  LV_LFA1-STCD1 = GV_STCD1.

  LV_LFA1-STCD2 = GV_STCD2.

  LV_LFA1-STRAS = GV_STRAS.

  MODIFY Z23LFA1 FROM LV_LFA1.

  IF SY-SUBRC NE 0.

    MESSAGE '### ### ######.' TYPE 'E'.

  ENDIF.



  LV_LFB1-LIFNR = LV_MAX_LIFNR.

  LV_LFB1-BUKRS = GV_BUKRS.

  LV_LFB1-LOEVM = GV_LOEVM.

  LV_LFB1-AKONT = GV_AKONT.

  LV_LFB1-ZTERM = GV_ZTERM.

  MODIFY Z23LFB1 FROM LV_LFB1.

  IF SY-SUBRC NE 0.

    MESSAGE '### ### ######.' TYPE 'E'.

  ENDIF.



  LV_LFM1-LIFNR = LV_MAX_LIFNR.

  LV_LFM1-EKORG = GV_EKORG.

  LV_LFM1-EKGRP = GV_EKGRP.

  LV_LFM1-LOEVM = GV_LOEVM.

  LV_LFM1-WAERS = GV_WAERS.

  LV_LFM1-MWSKZ = GV_MWSKZ.

  MODIFY Z23LFM1 FROM LV_LFM1.

  IF SY-SUBRC NE 0.

    MESSAGE '### ### ######.' TYPE 'E'.

  ELSE.

    MESSAGE '###(####)# #######.' TYPE 'I'.

  ENDIF.



ENDFORM.



FORM GETDATA_300.

  CLEAR GS_PRINT.

  GV_FLAG = '0'.

  SELECT A~LIFNR  "#####

    B~BUKRS "####

    A~NAME1 "####

    A~LAND1 "###

    A~KTOKK "#####

    A~STCD1 "####

    A~STCD2 "#####

    A~STRAS "##

    B~AKONT "##

    B~ZTERM "####

    C~EKORG "####

    C~EKGRP "####

    C~WAERS "##

    C~MWSKZ "####

    INTO CORRESPONDING FIELDS OF GS_PRINT

    FROM Z23LFA1 AS A

    JOIN Z23LFB1 AS B ON A~LIFNR EQ B~LIFNR

    JOIN Z23LFM1 AS C ON A~LIFNR EQ C~LIFNR

    WHERE A~LIFNR EQ GV_LIFNR

    AND B~BUKRS EQ GV_BUKRS.

  ENDSELECT.



  IF GS_PRINT IS INITIAL.

    MESSAGE '### #### ####' TYPE 'I'.

    GV_FLAG = '1'.

    RETURN.

  ENDIF.



  PERFORM VAL_TO_DESC.



ENDFORM.



FORM VAL_TO_DESC.

  CALL FUNCTION 'RKE_DOMVALUE_TEXT_GET'

    EXPORTING

      I_DOMA                   = 'ZKTOKK23'

      I_DOMVALUE               = GS_PRINT-KTOKK

      I_LANGU                  = SY-LANGU

    IMPORTING

      E_DDTEXT                 = GS_PRINT-KTOKK_STR.



  CALL FUNCTION 'RKE_DOMVALUE_TEXT_GET'

    EXPORTING

      I_DOMA                   = 'ZAKONT23'

      I_DOMVALUE               = GS_PRINT-AKONT

      I_LANGU                  = SY-LANGU

    IMPORTING

      E_DDTEXT                 = GS_PRINT-AKONT_STR.



  CALL FUNCTION 'RKE_DOMVALUE_TEXT_GET'

    EXPORTING

      I_DOMA                   = 'ZTERM23'

      I_DOMVALUE               = GS_PRINT-ZTERM

      I_LANGU                  = SY-LANGU

    IMPORTING

      E_DDTEXT                 = GS_PRINT-ZTERM_STR.



  CALL FUNCTION 'RKE_DOMVALUE_TEXT_GET'

    EXPORTING

      I_DOMA                   = 'ZMWSKZ23'

      I_DOMVALUE               = GS_PRINT-MWSKZ

      I_LANGU                  = SY-LANGU

    IMPORTING

      E_DDTEXT                 = GS_PRINT-MWSKZ_STR.



ENDFORM.



FORM SAVE_TO_VENDOR_300.

  IF GS_PRINT-KTOKK EQ '3000'.  " #### STCD1 ##

    UPDATE Z23LFA1 SET STCD1 = GS_PRINT-STCD1 WHERE LIFNR EQ GS_PRINT-LIFNR.

    IF SY-SUBRC EQ 0.

      MESSAGE '#### ### #######.' TYPE 'I'.

    ENDIF.

    RETURN.



  ELSEIF GS_PRINT-KTOKK EQ '1000'.  "##### STCD2 ##

    UPDATE Z23LFA1 SET STCD2 = GS_PRINT-STCD2 WHERE LIFNR EQ GS_PRINT-LIFNR.

    IF SY-SUBRC EQ 0.

      MESSAGE '##### ### #######.' TYPE 'I'.

    ENDIF.

    RETURN.

  ENDIF.



ENDFORM.