
*&---------------------------------------------------------------------*

*&  Include           ZMM02_001_F01

*&---------------------------------------------------------------------*

*&---------------------------------------------------------------------*

*&      Form  SET_INIT

*&---------------------------------------------------------------------*

*       text

*----------------------------------------------------------------------*

*  -->  p1        text

*  <--  p2        text

*----------------------------------------------------------------------*




FORM SET_INIT .



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

    IF SCREEN-GROUP1 = 'M1'.

      IF P_CRE = 'X'. "### #

        SCREEN-ACTIVE = '1'.

      ELSEIF P_VIEW = 'X'.

        SCREEN-ACTIVE = '0'.

      ENDIF.

    ENDIF.

    IF SCREEN-GROUP1 = 'M2'.

      IF P_CRE = 'X'.

        SCREEN-ACTIVE = '0'.

      ELSEIF P_VIEW = 'X'.

        SCREEN-ACTIVE = '1'.

      ENDIF.

    ENDIF.

    MODIFY SCREEN.

  ENDLOOP.

ENDFORM.




*&---------------------------------------------------------------------*

*&      Form  VALIDATE_INPUT

*&---------------------------------------------------------------------*

*       text

*----------------------------------------------------------------------*

*  -->  p1        text

*  <--  p2        text

*----------------------------------------------------------------------*




FORM VALIDATE_INPUT .

  IF P_CRE = 'X'.

    IF P_BUKRS IS INITIAL OR P_KTOKK IS INITIAL.

      MESSAGE I000.

      EXIT.

    ENDIF.

  ELSEIF P_VIEW = 'X'.

    IF P_LIFNR IS INITIAL OR P_BUKRS IS INITIAL.

      MESSAGE I000.

      LEAVE TO SCREEN 0.

    ENDIF.

  ENDIF.

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



  SELECT A~LIFNR "#####

         A~NAME1 "####

         A~LAND1 "###

         A~KTOKK "#####

         A~STCD1 "####

         A~STCD2 "#####

         A~STRAS "##

         B~BUKRS "####

         B~LOEVM AS LOEVM_B "#### #####

         B~AKONT "##

         B~ZTERM "####

         C~EKORG "####

         C~EKGRP "####

         C~LOEVM AS LOEVM_M "#### #####

         C~WAERS "######

         C~MWSKZ "####

    INTO CORRESPONDING FIELDS OF TABLE GT_VENDOR

    FROM ZLFA1_02 AS A

    LEFT OUTER JOIN ZLFB1_02 AS B ON A~LIFNR = B~LIFNR

    LEFT OUTER JOIN ZLFM1_02 AS C ON A~LIFNR = C~LIFNR

    WHERE A~LIFNR = G_LIFNR.

    DELETE GT_VENDOR WHERE BUKRS <> G_BUKRS. "##### ## ### ##

    IF GT_VENDOR IS INITIAL. "### ### ## #

      MESSAGE S001 DISPLAY LIKE 'E'.

      LEAVE LIST-PROCESSING.

    ENDIF.

ENDFORM.




*&---------------------------------------------------------------------*

*&      Form  CREATE_VENDOR

*&---------------------------------------------------------------------*

*       text

*----------------------------------------------------------------------*

*  -->  p1        text

*  <--  p2        text

*----------------------------------------------------------------------*




FORM CREATE_VENDOR .

  DATA: LV_KTOKK TYPE ZKTOKK02, "#####

        LV_AKONT TYPE ZAKONT02, "##

        LV_ZTERM TYPE ZTERM02, "####

        LV_MWSKZ TYPE ZMWSKZ02. "####

  IF G_KTOKK IS INITIAL OR "#####

     G_BUKRS IS INITIAL OR "####

     G_STRAS IS INITIAL OR "##

     G_AKONT IS INITIAL OR "##

     G_ZTERM IS INITIAL OR "####

     G_MWSKZ IS INITIAL OR "####

     G_EKORG IS INITIAL OR "####

     G_EKGRP IS INITIAL OR "####

     G_WAERS IS INITIAL OR "######

     ( G_KTOKK = '3000' AND G_STCD1 IS INITIAL ) OR "####

     ( G_KTOKK <> '2000' AND G_KTOKK <> '3000' AND G_STCD2 IS INITIAL ). "#####

    MESSAGE '## ## ## ### ######.' TYPE 'S' DISPLAY LIKE 'E'.

    SY-SUBRC = 4.

    EXIT.

  ENDIF.



  SELECT SINGLE KTOKK "#####

    FROM ZEDT02_KTOKK

    INTO LV_KTOKK

    WHERE KTOKK = G_KTOKK.



  IF SY-SUBRC <> 0.

    G_CURSOR_FIELD = 'G_KTOKK'. "## ##

    MESSAGE '#### ## ### #####.' TYPE 'S' DISPLAY LIKE 'E'.

    SY-SUBRC = 4.

    EXIT.

  ENDIF.



  SELECT SINGLE AKONT "##

    FROM ZEDT02_AKONT

    INTO LV_AKONT

    WHERE AKONT = G_AKONT.



  IF SY-SUBRC <> 0.

    G_CURSOR_FIELD = 'G_AKONT'.

    MESSAGE '#### ## #####.' TYPE 'S' DISPLAY LIKE 'E'.

    SY-SUBRC = 4.

    EXIT.

  ENDIF.



  SELECT SINGLE ZTERM "####

    FROM ZEDT02_ZTERM

    INTO LV_ZTERM

    WHERE ZTERM = G_ZTERM.



  IF SY-SUBRC <> 0.

    G_CURSOR_FIELD = 'G_ZTERM'.

    MESSAGE '#### ## #######.' TYPE 'S' DISPLAY LIKE 'E'.

    SY-SUBRC = 4.

    EXIT.

  ENDIF.



  SELECT SINGLE MWSKZ "####

    FROM ZEDT02_MWSKZ

    INTO LV_MWSKZ

    WHERE MWSKZ = G_MWSKZ.



  IF SY-SUBRC <> 0.

    G_CURSOR_FIELD = 'G_MWSKZ'.

    MESSAGE '#### ## ######.' TYPE 'S' DISPLAY LIKE 'E'.

    SY-SUBRC = 4.

    EXIT.

  ENDIF.



  CALL FUNCTION 'NUMBER_GET_NEXT' "####

    EXPORTING

      NR_RANGE_NR                   = '01'

      OBJECT                        = 'ZLIFNR02' " ## ## ## (### ###)




*     QUANTITY                      = '1'

*     SUBOBJECT                     = ' '

*     TOYEAR                        = '0000'

*     IGNORE_BUFFER                 = ' '




   IMPORTING

     NUMBER                        = G_LIFNR "#####




*     QUANTITY                      =

*     RETURNCODE                    =

*   EXCEPTIONS

*     INTERVAL_NOT_FOUND            = 1

*     NUMBER_RANGE_NOT_INTERN       = 2

*     OBJECT_NOT_FOUND              = 3

*     QUANTITY_IS_0                 = 4

*     QUANTITY_IS_NOT_1             = 5

*     INTERVAL_OVERFLOW             = 6

*     BUFFER_OVERFLOW               = 7

*     OTHERS                        = 8




            .

  IF SY-SUBRC <> 0.




*   Implement suitable error handling here




  ENDIF.

ENDFORM.




*&---------------------------------------------------------------------*

*&      Form  PUSH_DB

*&---------------------------------------------------------------------*

*       text

*----------------------------------------------------------------------*

*  -->  p1        text

*  <--  p2        text

*----------------------------------------------------------------------*




FORM PUSH_DB .



  CLEAR: GT_LFA1, GT_LFB1, GT_LFM1.

  GS_LFA1-MANDT = SY-MANDT.

  GS_LFA1-LIFNR = G_LIFNR. "#####

  GS_LFA1-NAME1 = G_NAME1. "####

  GS_LFA1-LAND1 = G_LAND1. "###

  GS_LFA1-KTOKK = G_KTOKK. "#####

  IF G_KTOKK = '3000'.

    GS_LFA1-STCD1 = G_STCD1. "####

  ENDIF.

  IF G_KTOKK <> '2000' AND G_KTOKK <> '3000'.

    GS_LFA1-STCD2 = G_STCD2. "#####

  ENDIF.

  GS_LFA1-STRAS = G_STRAS. "##

  GS_LFB1-LIFNR = G_LIFNR.

  GS_LFB1-BUKRS = G_BUKRS. "####

  GS_LFB1-AKONT = G_AKONT. "##

  GS_LFB1-ZTERM = G_ZTERM. "####

  GS_LFM1-LIFNR = G_LIFNR.

  GS_LFM1-EKORG = G_EKORG. "####

  GS_LFM1-EKGRP = G_EKGRP. "####

  GS_LFM1-WAERS = G_WAERS. "######

  GS_LFM1-MWSKZ = G_MWSKZ. "####



  APPEND GS_LFA1 TO GT_LFA1.

  APPEND GS_LFB1 TO GT_LFB1.

  APPEND GS_LFM1 TO GT_LFM1.



  INSERT ZLFA1_02 FROM TABLE GT_LFA1.

  INSERT ZLFB1_02 FROM TABLE GT_LFB1.

  INSERT ZLFM1_02 FROM TABLE GT_LFM1.



  MESSAGE '#######.' TYPE 'S'.

ENDFORM.




*&---------------------------------------------------------------------*

*&      Form  SET_DATA

*&---------------------------------------------------------------------*

*       text

*----------------------------------------------------------------------*

*  -->  p1        text

*  <--  p2        text

*----------------------------------------------------------------------*




FORM SET_DATA .

  READ TABLE GT_VENDOR INTO GS_VENDOR INDEX 1.

  G_LIFNR = GS_VENDOR-LIFNR. "#####

  G_NAME1 = GS_VENDOR-NAME1. "####

  G_LAND1 = GS_VENDOR-LAND1. "###

  G_KTOKK = GS_VENDOR-KTOKK. "#####

  G_STCD1 = GS_VENDOR-STCD1. "####

  G_STCD2 = GS_VENDOR-STCD2. "#####

  G_STRAS = GS_VENDOR-STRAS. "##

  G_BUKRS = GS_VENDOR-BUKRS. "####

  G_LOEVM_B = GS_VENDOR-LOEVM_B. "#### #####

  G_AKONT = GS_VENDOR-AKONT. "##

  G_ZTERM = GS_VENDOR-ZTERM. "####

  G_EKORG = GS_VENDOR-EKORG. "####

  G_EKGRP = GS_VENDOR-EKGRP. "####

  G_LOEVM_M = GS_VENDOR-LOEVM_M. "#### #####

  G_WAERS = GS_VENDOR-WAERS. "######

  G_MWSKZ = GS_VENDOR-MWSKZ. "####

ENDFORM.