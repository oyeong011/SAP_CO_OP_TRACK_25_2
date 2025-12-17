
*&---------------------------------------------------------------------*

*& Include          ZEDR10_PRACTICE009_F01

*&---------------------------------------------------------------------*



*&---------------------------------------------------------------------*

*& Form SET_DATE

*&---------------------------------------------------------------------*




FORM SET_DATE .

  " ### ##: ##### ##### ## ## ### ## ##

  IF S_DATBI[] IS INITIAL.

    S_DATBI-LOW = SY-DATUM(6) && '01'.



    CALL FUNCTION 'LAST_DAY_OF_MONTHS'

      EXPORTING

        DAY_IN            = S_DATBI-LOW

      IMPORTING

        LAST_DAY_OF_MONTH = S_DATBI-LOW.



    S_DATBI-SIGN = 'I'.

    S_DATBI-OPTION = 'EQ'.

    APPEND S_DATBI.

  ENDIF.

ENDFORM.






*&---------------------------------------------------------------------*

*& Form CHECK_DATA

*&---------------------------------------------------------------------*




FORM CHECK_DATA .

  " ## ### ##

  IF ( S_PERNR[] IS INITIAL AND S_DEP IS INITIAL ) OR S_DATBI IS INITIAL.

    MESSAGE I000. " ## ### #####

    STOP.

  ENDIF.



  " ### ## ## ## (TOP# Ranges ## R_FG ##)

  R_FG-SIGN = 'I'.

  R_FG-OPTION = 'EQ'.

  R_FG-LOW = ' '.

  APPEND R_FG.



  " TOP# ### ## GC_X ## (P_ZFLAG# Checkbox)

  IF P_ZFLAG = GC_X.

    R_FG-LOW = 'X'.

    APPEND R_FG.

  ENDIF.

ENDFORM.






*&---------------------------------------------------------------------*

*& Form GET_DATA

*&---------------------------------------------------------------------*




FORM GET_DATA .

  " 1. ## ### # #### ## (ZEDT10_102 + ZEDT10_103)

  " #### ## ##: ##### ### ####(DATAB~DATBI) ### ##### #

  CALL FUNCTION 'CONVERSION_EXIT_ALPHA_INPUT'

    EXPORTING

      INPUT  = S_PERNR-LOW

    IMPORTING

      OUTPUT = S_PERNR-LOW.



  CALL FUNCTION 'CONVERSION_EXIT_ALPHA_INPUT'

    EXPORTING

      INPUT  = S_PERNR-HIGH

    IMPORTING

      OUTPUT = S_PERNR-HIGH.



  APPEND S_PERNR.



  SELECT A~ZPERNR B~ZPNAME A~ZDEPRANK A~ZDEPCODE

         B~ZGENDER A~DATBI A~DATAB A~ZDEPRANK

         A~ZEDATE A~ZQDATE A~ZQFLAG B~ZADDRESS

    INTO CORRESPONDING FIELDS OF TABLE GT_EMP

    FROM ZEDT10_102 AS A

    INNER JOIN ZEDT10_103 AS B

    ON A~ZPERNR = B~ZPERNR

    WHERE A~ZPERNR IN S_PERNR

    AND A~ZDEPCODE IN S_DEP AND

    A~DATBI <= S_DATBI-LOW AND

    A~DATAB >= S_DATBI-LOW AND

    A~ZQFLAG IN R_FG.       " ### ## ##

  .

  IF GT_EMP[] IS NOT INITIAL.

    " 2. ##/## ## ## (ZEDT10_106)

    " ZEDT10_106 #### ZSALARY, ZBANKCODE, ZACCOUNT ### ###

    SELECT *

      FROM ZEDT10_106

      INTO CORRESPONDING FIELDS OF TABLE GT_PAY

      FOR ALL ENTRIES IN GT_EMP

      WHERE ZPERNR = GT_EMP-ZPERNR

        AND DATBI <= S_DATBI-LOW

        AND DATAB >= S_DATBI-LOW

        AND ZYEAR = S_DATBI-LOW(4). " ##### ### #### ###



    " 3. ##/#### ## ## (ZEDT10_104)

    SELECT *

      FROM ZEDT10_104

      INTO CORRESPONDING FIELDS OF TABLE GT_EVAL

      FOR ALL ENTRIES IN GT_EMP

      WHERE ZPERNR = GT_EMP-ZPERNR

        AND DATBI <= S_DATBI-LOW

        AND DATAB >= S_DATBI-LOW

        AND ZYEAR = S_DATBI-LOW(4)

        AND ZDEPCODE IN S_DEP.    " ## ## ## ### ##

  ENDIF.

ENDFORM.






*&---------------------------------------------------------------------*

*& Form CREATE_OBJECT

*&---------------------------------------------------------------------*




FORM CREATE_OBJECT .

  " Docking Container ##

  CREATE OBJECT GC_DOCKING

    EXPORTING

      REPID     = SY-REPID

      DYNNR     = SY-DYNNR

      EXTENSION = 2000.



  " ## ## ## (Splitter 1)

  CREATE OBJECT GC_SPLITTER

    EXPORTING

      PARENT  = GC_DOCKING

      ROWS    = 2

      COLUMNS = 1.



  CALL METHOD GC_SPLITTER->GET_CONTAINER

    EXPORTING

      ROW       = 1

      COLUMN    = 1

    RECEIVING

      CONTAINER = GC_CONTAINER_TOP.



  CALL METHOD GC_SPLITTER->GET_CONTAINER

    EXPORTING

      ROW       = 2

      COLUMN    = 1

    RECEIVING

      CONTAINER = GC_CONTAINER_BOTTOM.



  " ## ## ## ## (Splitter 2)

  CREATE OBJECT GC_SPLITTER2

    EXPORTING

      PARENT  = GC_CONTAINER_TOP

      ROWS    = 1

      COLUMNS = 2.



  CALL METHOD GC_SPLITTER2->GET_CONTAINER

    EXPORTING

      ROW       = 1

      COLUMN    = 1

    RECEIVING

      CONTAINER = GC_CONTAINER_TOPEVAL.



  CALL METHOD GC_SPLITTER2->GET_CONTAINER

    EXPORTING

      ROW       = 1

      COLUMN    = 2

    RECEIVING

      CONTAINER = GC_CONTAINER_TOPPAY.



  " ALV Grid ##

  CREATE OBJECT GC_GRID_TOPEVAL

    EXPORTING

      I_PARENT = GC_CONTAINER_TOPEVAL.



  CREATE OBJECT GC_GRID_TOPPAY

    EXPORTING

      I_PARENT = GC_CONTAINER_TOPPAY.



  CREATE OBJECT GC_GRID_BOTTOM

    EXPORTING

      I_PARENT = GC_CONTAINER_BOTTOM.

ENDFORM.






*&---------------------------------------------------------------------*

*& Form FIELD_CATALOG

*&---------------------------------------------------------------------*




FORM FIELD_CATALOG .

  PERFORM FIELD_CATALOG2. " ## (####)

  PERFORM FIELD_CATALOG3. " #### (##)

  PERFORM FIELD_CATALOG4. " #### (##)

ENDFORM.






* ##: ## ## ALV ## ##-




FORM FIELD_CATALOG2 .

  CLEAR : GS_FIELDCAT, GT_FIELDCAT_BOTTOM.



  " ### ###

  GS_FIELDCAT-COL_POS = 1.

  GS_FIELDCAT-FIELDNAME = 'ICON'.

  GS_FIELDCAT-COLTEXT = '##'.

  GS_FIELDCAT-ICON = 'X'.

  APPEND GS_FIELDCAT TO GT_FIELDCAT_BOTTOM.



  CLEAR : GS_FIELDCAT.

  GS_FIELDCAT-COL_POS = 2.

  GS_FIELDCAT-KEY = 'X'.

  GS_FIELDCAT-FIELDNAME = 'ZPERNR'.

  GS_FIELDCAT-SCRTEXT_M = '####'.

  APPEND GS_FIELDCAT TO GT_FIELDCAT_BOTTOM.



  CLEAR : GS_FIELDCAT.

  GS_FIELDCAT-COL_POS = 3.

  GS_FIELDCAT-FIELDNAME = 'ZPNAME'.

  GS_FIELDCAT-SCRTEXT_M = '##'.

  APPEND GS_FIELDCAT TO GT_FIELDCAT_BOTTOM.



  CLEAR : GS_FIELDCAT.

  GS_FIELDCAT-COL_POS = 4.

  GS_FIELDCAT-FIELDNAME = 'ZDEPCODE_NAME'.

  GS_FIELDCAT-SCRTEXT_M = '###'.

  APPEND GS_FIELDCAT TO GT_FIELDCAT_BOTTOM.



  CLEAR : GS_FIELDCAT.

  GS_FIELDCAT-COL_POS = 5.

  GS_FIELDCAT-FIELDNAME = 'DATAB'.

  GS_FIELDCAT-SCRTEXT_M = '###'.

  APPEND GS_FIELDCAT TO GT_FIELDCAT_BOTTOM.



  CLEAR : GS_FIELDCAT.

  GS_FIELDCAT-COL_POS = 6.

  GS_FIELDCAT-FIELDNAME = 'DATBI'.

  GS_FIELDCAT-SCRTEXT_M = '###'.

  APPEND GS_FIELDCAT TO GT_FIELDCAT_BOTTOM.



  CLEAR : GS_FIELDCAT.

  GS_FIELDCAT-COL_POS = 7.

  GS_FIELDCAT-FIELDNAME = 'ZRANK_NAME'.

  GS_FIELDCAT-SCRTEXT_M = '##'.

  APPEND GS_FIELDCAT TO GT_FIELDCAT_BOTTOM.



  CLEAR : GS_FIELDCAT.

  GS_FIELDCAT-COL_POS = 8.

  GS_FIELDCAT-FIELDNAME = 'ZGENDER_NAME'.

  GS_FIELDCAT-SCRTEXT_M = '##'.

  APPEND GS_FIELDCAT TO GT_FIELDCAT_BOTTOM.



  CLEAR : GS_FIELDCAT.

  GS_FIELDCAT-COL_POS = 9.

  GS_FIELDCAT-FIELDNAME = 'ZEDATE'.

  GS_FIELDCAT-SCRTEXT_M = '###'.

  APPEND GS_FIELDCAT TO GT_FIELDCAT_BOTTOM.



  CLEAR : GS_FIELDCAT.

  GS_FIELDCAT-COL_POS = 10.

  GS_FIELDCAT-FIELDNAME = 'ZADDRESS'.

  GS_FIELDCAT-SCRTEXT_M = '##'.

  APPEND GS_FIELDCAT TO GT_FIELDCAT_BOTTOM.



  " ### ## ## ### ##

  IF P_ZFLAG = GC_X.

    CLEAR : GS_FIELDCAT.

    GS_FIELDCAT-COL_POS = 11.

    GS_FIELDCAT-FIELDNAME = 'ZQDATE'.

    GS_FIELDCAT-SCRTEXT_M = '###'.

    APPEND GS_FIELDCAT TO GT_FIELDCAT_BOTTOM.



    CLEAR : GS_FIELDCAT.

    GS_FIELDCAT-COL_POS = 12.

    GS_FIELDCAT-FIELDNAME = 'ZQFLAG'.

    GS_FIELDCAT-SCRTEXT_M = '####'.

    APPEND GS_FIELDCAT TO GT_FIELDCAT_BOTTOM.

  ENDIF.

ENDFORM.






* ## ##: ## ## (ZEDT10_106 ##)-




FORM FIELD_CATALOG3 .

  CLEAR : GS_FIELDCAT , GT_FIELDCAT_TOPPAY.



  GS_FIELDCAT-COL_POS = 1.

  GS_FIELDCAT-KEY = 'X'.

  GS_FIELDCAT-FIELDNAME = 'ZPERNR'.

  GS_FIELDCAT-SCRTEXT_M = '####'.

  APPEND GS_FIELDCAT TO GT_FIELDCAT_TOPPAY.



  GS_FIELDCAT-COL_POS = 2.

  GS_FIELDCAT-FIELDNAME = 'ZYEAR'.

  GS_FIELDCAT-SCRTEXT_M = '##'.

  APPEND GS_FIELDCAT TO GT_FIELDCAT_TOPPAY.



  GS_FIELDCAT-COL_POS = 3.

  GS_FIELDCAT-FIELDNAME = 'DATBI'.

  GS_FIELDCAT-SCRTEXT_M = '###'.

  APPEND GS_FIELDCAT TO GT_FIELDCAT_TOPPAY.



  GS_FIELDCAT-COL_POS = 4.

  GS_FIELDCAT-FIELDNAME = 'DATAB'.

  GS_FIELDCAT-SCRTEXT_M = '###'.

  APPEND GS_FIELDCAT TO GT_FIELDCAT_TOPPAY.



  " ## ## ## (##, ## ## ##)

  GS_FIELDCAT-COL_POS = 5.

  GS_FIELDCAT-FIELDNAME = 'ZSALARY'.

  GS_FIELDCAT-SCRTEXT_M = '####'.

  GS_FIELDCAT-DO_SUM = 'X'.

  GS_FIELDCAT-CFIELDNAME = 'ZWAERS'. " ## # ## ##

  GS_FIELDCAT-OUTPUTLEN = '16'.

  APPEND GS_FIELDCAT TO GT_FIELDCAT_TOPPAY.



  " ## ## (#### ##)

  GS_FIELDCAT-COL_POS = 6.

  GS_FIELDCAT-FIELDNAME = 'ZWAERS'.

  GS_FIELDCAT-SCRTEXT_M = '##'.

  GS_FIELDCAT-NO_OUT = 'X'.

  APPEND GS_FIELDCAT TO GT_FIELDCAT_TOPPAY.



  GS_FIELDCAT-COL_POS = 7.

  GS_FIELDCAT-FIELDNAME = 'ZBANK_NAME'.

  GS_FIELDCAT-SCRTEXT_M = '###'.

  APPEND GS_FIELDCAT TO GT_FIELDCAT_TOPPAY.



  GS_FIELDCAT-COL_POS = 8.

  GS_FIELDCAT-FIELDNAME = 'ZACCOUNT'.

  GS_FIELDCAT-SCRTEXT_M = '####'.

  APPEND GS_FIELDCAT TO GT_FIELDCAT_TOPPAY.

ENDFORM.






* ## ##: ## ## (ZEDT10_104 ##)-




FORM FIELD_CATALOG4 .

  CLEAR : GS_FIELDCAT , GT_FIELDCAT_TOPEVAL.



  GS_FIELDCAT-COL_POS = 1.

  GS_FIELDCAT-KEY = 'X'.

  GS_FIELDCAT-FIELDNAME = 'ZPERNR'.

  GS_FIELDCAT-SCRTEXT_M = '####'.

  APPEND GS_FIELDCAT TO GT_FIELDCAT_TOPEVAL.



  GS_FIELDCAT-COL_POS = 2.

  GS_FIELDCAT-FIELDNAME = 'ZDEPCODE_NAME'.

  GS_FIELDCAT-SCRTEXT_M = '###'.

  APPEND GS_FIELDCAT TO GT_FIELDCAT_TOPEVAL.



  GS_FIELDCAT-COL_POS = 3.

  GS_FIELDCAT-FIELDNAME = 'ZYEAR'.

  GS_FIELDCAT-SCRTEXT_M = '##'.

  APPEND GS_FIELDCAT TO GT_FIELDCAT_TOPEVAL.



  GS_FIELDCAT-COL_POS = 4.

  GS_FIELDCAT-FIELDNAME = 'DATAB'.

  GS_FIELDCAT-SCRTEXT_M = '###'.

  APPEND GS_FIELDCAT TO GT_FIELDCAT_TOPEVAL.



  GS_FIELDCAT-COL_POS = 5.

  GS_FIELDCAT-FIELDNAME = 'DATBI'.

  GS_FIELDCAT-SCRTEXT_M = '###'.

  APPEND GS_FIELDCAT TO GT_FIELDCAT_TOPEVAL.



  GS_FIELDCAT-COL_POS = 6.

  GS_FIELDCAT-FIELDNAME = 'ZRANK'.

  GS_FIELDCAT-SCRTEXT_M = '####'.

  APPEND GS_FIELDCAT TO GT_FIELDCAT_TOPEVAL.

ENDFORM.






*&---------------------------------------------------------------------*

*& Form ALV_LAYOUT

*&---------------------------------------------------------------------*




FORM ALV_LAYOUT .

  CLEAR GS_LAYOUT.

  GS_LAYOUT-ZEBRA = 'X'.

  GS_LAYOUT-TOTALS_BEF = 'X'.



  CLEAR GS_VARIANT.

  GS_VARIANT-REPORT = SY-REPID.

  GS_VARIANT-USERNAME = SY-UNAME.

ENDFORM.






*&---------------------------------------------------------------------*

*& Form ALV_SORT

*&---------------------------------------------------------------------*




FORM ALV_SORT .

  CLEAR : GS_SORT, GT_SORT1.

  GS_SORT-SPOS = 1.

  GS_SORT-FIELDNAME = 'ZPERNR'.

  GS_SORT-UP = 'X'.

  APPEND GS_SORT TO GT_SORT1.

ENDFORM.






*&---------------------------------------------------------------------*

*& Form CALL_ALV

*&---------------------------------------------------------------------*




FORM CALL_ALV .

  " ## ## (##)

  CALL METHOD GC_GRID_TOPEVAL->SET_TABLE_FOR_FIRST_DISPLAY

    EXPORTING

      IS_VARIANT      = GS_VARIANT

      I_SAVE          = 'A'

      IS_LAYOUT       = GS_LAYOUT

    CHANGING

      IT_OUTTAB       = GT_EVAL_ALV

      IT_FIELDCATALOG = GT_FIELDCAT_TOPEVAL

      IT_SORT         = GT_SORT1.



  " ## ## (##)

  CALL METHOD GC_GRID_TOPPAY->SET_TABLE_FOR_FIRST_DISPLAY

    EXPORTING

      IS_VARIANT      = GS_VARIANT

      I_SAVE          = 'A'

      IS_LAYOUT       = GS_LAYOUT

    CHANGING

      IT_OUTTAB       = GT_PAY_ALV

      IT_FIELDCATALOG = GT_FIELDCAT_TOPPAY

      IT_SORT         = GT_SORT1.



  " ## (####)

  CALL METHOD GC_GRID_BOTTOM->SET_TABLE_FOR_FIRST_DISPLAY

    EXPORTING

      IS_VARIANT      = GS_VARIANT

      I_SAVE          = 'A'

      IS_LAYOUT       = GS_LAYOUT

    CHANGING

      IT_OUTTAB       = GT_EMP_ALV

      IT_FIELDCATALOG = GT_FIELDCAT_BOTTOM

      IT_SORT         = GT_SORT1.

ENDFORM.






*&---------------------------------------------------------------------*

*& Form CONVERT_DATA

*&---------------------------------------------------------------------*




FORM CONVERT_DATA .

  DATA : LV_TYPENUM TYPE CHAR1.



  " 1. ## ## ##

  LOOP AT GT_EMP INTO GS_EMP.

    MOVE-CORRESPONDING GS_EMP TO GS_EMP_ALV.



    " ### ##

    LV_TYPENUM = 1.

    PERFORM CONVERT_NAME USING GS_EMP-ZDEPCODE LV_TYPENUM CHANGING GS_EMP_ALV-ZDEPCODE_NAME.



    " ### ## (ZDEPRANK)

    LV_TYPENUM = 2.

    PERFORM CONVERT_NAME USING GS_EMP-ZDEPRANK LV_TYPENUM CHANGING GS_EMP_ALV-ZRANK_NAME.



    " ## ##

    LV_TYPENUM = 3.

    PERFORM CONVERT_NAME USING GS_EMP-ZGENDER LV_TYPENUM CHANGING GS_EMP_ALV-ZGENDER_NAME.



    " ###(ICON) ##

    IF GS_EMP_ALV-ZQFLAG = GC_X.

      GS_EMP_ALV-ICON = GC_RED.   " ## (##)

    ELSEIF GS_EMP_ALV-ZRANK_NAME = '##'. " ## (##) - ZRANK_NAME ## ### ## '##' ##

      GS_EMP_ALV-ICON = GC_YELLOW.

    ELSE.

      GS_EMP_ALV-ICON = GC_GREEN. " ## (##)

    ENDIF.



    APPEND GS_EMP_ALV TO GT_EMP_ALV.

    CLEAR : GS_EMP, GS_EMP_ALV.

  ENDLOOP.



  " 2. ## ## ##

  LOOP AT GT_EVAL INTO GS_EVAL.

    MOVE-CORRESPONDING GS_EVAL TO GS_EVAL_ALV.

    " ### ##

    LV_TYPENUM = 1.

    PERFORM CONVERT_NAME USING GS_EVAL-ZDEPCODE LV_TYPENUM CHANGING GS_EVAL_ALV-ZDEPCODE_NAME.

    APPEND GS_EVAL_ALV TO GT_EVAL_ALV.

    CLEAR : GS_EVAL, GS_EVAL_ALV.

  ENDLOOP.



  " 3. ## ## ##

  LOOP AT GT_PAY INTO GS_PAY.

    MOVE-CORRESPONDING GS_PAY TO GS_PAY_ALV.



    " ### ##

    LV_TYPENUM = 4.

    PERFORM CONVERT_NAME USING GS_PAY-ZBANKCODE LV_TYPENUM CHANGING GS_PAY_ALV-ZBANK_NAME.



    " ## ## ## (001~010 ### KRW)

    IF GS_PAY-ZBANKCODE BETWEEN '001' AND '010'.

      GS_PAY_ALV-ZWAERS = GC_KRW.

    ENDIF.



    APPEND GS_PAY_ALV TO GT_PAY_ALV.

    CLEAR : GS_PAY, GS_PAY_ALV.

  ENDLOOP.

ENDFORM.






*&---------------------------------------------------------------------*

*& Form CONVERT_NAME

*&---------------------------------------------------------------------*




FORM CONVERT_NAME USING P_EMP_VAL P_TYPENUM CHANGING P_ALV_VAL.

  "~# ## ##. ### ZEDT10# ### #(SS000X, A~G)# ## ### ## ##

  CASE P_TYPENUM.

    WHEN '1'. " ###

      CASE P_EMP_VAL.

        WHEN 'SS0001'. P_ALV_VAL = '###'.

        WHEN 'SS0002'. P_ALV_VAL = '###'.

        WHEN 'SS0003'. P_ALV_VAL = '###'.

        WHEN 'SS0004'. P_ALV_VAL = '###'.

        WHEN 'SS0005'. P_ALV_VAL = '###'.

        WHEN 'SS0006'. P_ALV_VAL = '###'.

      ENDCASE.

    WHEN '2'. " ##

      CASE P_EMP_VAL.

        WHEN 'A'. P_ALV_VAL = '##'.

        WHEN 'B'. P_ALV_VAL = '##'.

        WHEN 'C'. P_ALV_VAL = '##'.

        WHEN 'D'. P_ALV_VAL = '##'.

        WHEN 'E'. P_ALV_VAL = '##'.

        WHEN 'F'. P_ALV_VAL = '##'.

        WHEN 'G'. P_ALV_VAL = '##'.

        WHEN 'H'. P_ALV_VAL = '##'.

        WHEN 'I'. P_ALV_VAL = '##'.

      ENDCASE.

    WHEN '3'. " ##

      CASE P_EMP_VAL.

        WHEN 'M'. P_ALV_VAL = '#'.

        WHEN 'F'. P_ALV_VAL = '#'.

      ENDCASE.

    WHEN '4'. " ###

      CASE P_EMP_VAL.

        WHEN '001'. P_ALV_VAL = '##'.

        WHEN '002'. P_ALV_VAL = '##'.

        WHEN '003'. P_ALV_VAL = '##'.

        WHEN '004'. P_ALV_VAL = '##'.

        WHEN '005'. P_ALV_VAL = '##'.

      ENDCASE.

  ENDCASE.

ENDFORM.