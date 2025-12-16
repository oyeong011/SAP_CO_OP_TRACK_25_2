
*&---------------------------------------------------------------------*

*&  Include           ZMM06_002_F03

*&---------------------------------------------------------------------*

*&---------------------------------------------------------------------*

*&      Form  PO_FIND

*&---------------------------------------------------------------------*

*       text

*----------------------------------------------------------------------*

*  -->  p1        text

*  <--  p2        text

*----------------------------------------------------------------------*




FORM PO_FIND .

    PERFORM GET_PO.

    PERFORM MODIFY_PO.

    CALL SCREEN 300.

ENDFORM.






*&---------------------------------------------------------------------*

*&      Form  GET_PO

*&---------------------------------------------------------------------*

*       text

*----------------------------------------------------------------------*

*  -->  p1        text

*  <--  p2        text

*----------------------------------------------------------------------*




FORM GET_PO .



  CLEAR : GS_EKKO, GT_EKPO.



  " 1. ## ##

  SELECT SINGLE * FROM ZEDT06_EKKO

    INTO CORRESPONDING FIELDS OF GS_EKKO

    WHERE EBELN = P_EBELN

    AND BUKRS = P_BUKRS.



  IF SY-SUBRC <> 0.

    MESSAGE '## ##### #### ####.' TYPE 'E'.

  ENDIF.



  GS_EKKO_DISP-EBELN = GS_EKKO-EBELN.

  GS_EKKO_DISP-BUKRS = GS_EKKO-BUKRS.

  GS_EKKO_DISP-EKGRP = GS_EKKO-EKGRP.

  GS_EKKO_DISP-EKORG = GS_EKKO-EKORG.

  GS_EKKO_DISP-LIFNR = GS_EKKO-LIFNR.



  " ## ### yyyy-mm-dd # ##

  GS_EKKO_DISP-BEDAT = |{ GS_EKKO-BEDAT DATE = ISO }|.



  GS_EKKO_DISP-WAERS = GS_EKKO-WAERS.



  " 2. ## ##

  SELECT *

    FROM ZEDT06_EKPO

    INTO CORRESPONDING FIELDS OF TABLE @GT_EKPO

    WHERE EBELN = @P_EBELN.



  IF GT_EKPO IS INITIAL.

    MESSAGE '## ##### ##### ####.' TYPE 'I'.

  ENDIF.



ENDFORM.




*&---------------------------------------------------------------------*

*&      Form  MODIFY_PO

*&---------------------------------------------------------------------*

*       text

*----------------------------------------------------------------------*

*  -->  p1        text

*  <--  p2        text

*----------------------------------------------------------------------*




FORM MODIFY_PO .



  LOOP AT GT_EKPO INTO GS_EKPO.



    CLEAR : GS_EKPO_ALV.



    MOVE-CORRESPONDING GS_EKPO TO GS_EKPO_ALV.



    " ALV# ### ## ##(WAERS)# #### ##

    GS_EKPO_ALV-WAERS = GS_EKKO-WAERS.



    " ### # #### ##

    APPEND GS_EKPO_ALV TO GT_EKPO_ALV.



  ENDLOOP.



ENDFORM.




*&---------------------------------------------------------------------*

*&      Form  CREATE_OBJECT_300

*&---------------------------------------------------------------------*

*       text

*----------------------------------------------------------------------*

*  -->  p1        text

*  <--  p2        text

*----------------------------------------------------------------------*




FORM CREATE_OBJECT_300 .



    CREATE OBJECT GC_CUSTOM_300

      EXPORTING

        CONTAINER_NAME = 'CON1'.



    CREATE OBJECT GC_GRID_300

      EXPORTING

        I_PARENT = GC_CUSTOM_300.



ENDFORM.




*&---------------------------------------------------------------------*

*&      Form  ALV_FIELDCAT_300

*&---------------------------------------------------------------------*

*       text

*----------------------------------------------------------------------*

*  -->  p1        text

*  <--  p2        text

*----------------------------------------------------------------------*




FORM ALV_FIELDCAT_300 .



  CLEAR : GS_FIELDCAT_300, GT_FIELDCAT_300.



  GS_FIELDCAT_300-COL_POS   = 1.

  GS_FIELDCAT_300-FIELDNAME = 'EBELN'.

  GS_FIELDCAT_300-SCRTEXT_M = '######'.

  APPEND GS_FIELDCAT_300 TO GT_FIELDCAT_300.

  CLEAR GS_FIELDCAT_300.



  GS_FIELDCAT_300-COL_POS   = 2.

  GS_FIELDCAT_300-FIELDNAME = 'EBELP'.

  GS_FIELDCAT_300-SCRTEXT_M = '##'.

  APPEND GS_FIELDCAT_300 TO GT_FIELDCAT_300.

  CLEAR GS_FIELDCAT_300.



  " 2. #### (MATNR)

  GS_FIELDCAT_300-COL_POS   = 3.

  GS_FIELDCAT_300-FIELDNAME = 'MATNR'.

  GS_FIELDCAT_300-SCRTEXT_M = '####'.

  GS_FIELDCAT_300-EDIT      = ''.

  APPEND GS_FIELDCAT_300 TO GT_FIELDCAT_300.

  CLEAR GS_FIELDCAT_300.



  " 3. ### (MAKTX)

  GS_FIELDCAT_300-COL_POS   = 4.

  GS_FIELDCAT_300-FIELDNAME = 'MAKTX'.

  GS_FIELDCAT_300-SCRTEXT_M = '###'.

  APPEND GS_FIELDCAT_300 TO GT_FIELDCAT_300.

  CLEAR GS_FIELDCAT_300.



  " 4. ## (MENGE)

  GS_FIELDCAT_300-COL_POS   = 5.

  GS_FIELDCAT_300-FIELDNAME = 'MENGE'.

  GS_FIELDCAT_300-SCRTEXT_M = '##'.

  APPEND GS_FIELDCAT_300 TO GT_FIELDCAT_300.

  CLEAR GS_FIELDCAT_300.



  " 5. ## (MEINS)

  GS_FIELDCAT_300-COL_POS   = 6.

  GS_FIELDCAT_300-FIELDNAME = 'MEINS'.

  GS_FIELDCAT_300-SCRTEXT_M = '##'.

  APPEND GS_FIELDCAT_300 TO GT_FIELDCAT_300.

  CLEAR GS_FIELDCAT_300.



  " 6. ## (BPRME)

  GS_FIELDCAT_300-COL_POS   = 7.

  GS_FIELDCAT_300-FIELDNAME = 'BPRME'.

  GS_FIELDCAT_300-SCRTEXT_M = '##'.

  GS_FIELDCAT_300-CFIELDNAME = 'WAERS'.

  APPEND GS_FIELDCAT_300 TO GT_FIELDCAT_300.

  CLEAR GS_FIELDCAT_300.



  " 7. ### (PRDAT)

  GS_FIELDCAT_300-COL_POS   = 8.

  GS_FIELDCAT_300-FIELDNAME = 'PRDAT'.

  GS_FIELDCAT_300-SCRTEXT_M = '###'.

  GS_FIELDCAT_300-OUTPUTLEN = 10.

  APPEND GS_FIELDCAT_300 TO GT_FIELDCAT_300.

  CLEAR GS_FIELDCAT_300.



  " 8. ### (WERKS)

  GS_FIELDCAT_300-COL_POS   = 9.

  GS_FIELDCAT_300-FIELDNAME = 'WERKS'.

  GS_FIELDCAT_300-SCRTEXT_M = '###'.

  APPEND GS_FIELDCAT_300 TO GT_FIELDCAT_300.

  CLEAR GS_FIELDCAT_300.



  " 9. #### (LGORT)

  GS_FIELDCAT_300-COL_POS   = 10.

  GS_FIELDCAT_300-FIELDNAME = 'LGORT'.

  GS_FIELDCAT_300-SCRTEXT_M = '####'.

  APPEND GS_FIELDCAT_300 TO GT_FIELDCAT_300.

  CLEAR GS_FIELDCAT_300.



ENDFORM.




*&---------------------------------------------------------------------*

*&      Form  ALV_LAYOUT_300

*&---------------------------------------------------------------------*

*       text

*----------------------------------------------------------------------*

*  -->  p1        text

*  <--  p2        text

*----------------------------------------------------------------------*




FORM ALV_LAYOUT_300 .



  CLEAR GS_LAYOUT_300.



  GS_LAYOUT_300-ZEBRA = 'X'.     " ###

  GS_LAYOUT_300-CWIDTH_OPT = 'X'. " ## ## # ##



ENDFORM.




*&---------------------------------------------------------------------*

*&      Form  ALV_SORT_300

*&---------------------------------------------------------------------*

*       text

*----------------------------------------------------------------------*

*  -->  p1        text

*  <--  p2        text

*----------------------------------------------------------------------*




FORM ALV_SORT_300 .



  CLEAR GT_SORT_300.

  CLEAR GS_SORT_300.



  GS_SORT_300-FIELDNAME = 'EBELN'.

  GS_SORT_300-UP = 'X'.



  APPEND GS_SORT_300 TO GT_SORT_300.



ENDFORM.




*&---------------------------------------------------------------------*

*&      Form  ALV_DISPLAY_300

*&---------------------------------------------------------------------*

*       text

*----------------------------------------------------------------------*

*  -->  p1        text

*  <--  p2        text

*----------------------------------------------------------------------*




FORM ALV_DISPLAY_300 .



  CALL METHOD GC_GRID_300->SET_TABLE_FOR_FIRST_DISPLAY

    EXPORTING

      IS_LAYOUT       = GS_LAYOUT_300

    CHANGING

      IT_OUTTAB       = GT_EKPO_ALV

      IT_FIELDCATALOG = GT_FIELDCAT_300

      IT_SORT         = GT_SORT_300.



ENDFORM.