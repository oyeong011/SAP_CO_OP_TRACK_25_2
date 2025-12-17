
*&---------------------------------------------------------------------*

*& Report ZEDR10_PRACTICE006

*&---------------------------------------------------------------------*

*&

*&---------------------------------------------------------------------*




REPORT ZEDR10_PRACTICE007.



CONSTANTS: C_MON_COL(4) TYPE C VALUE 'ZMON'.

CONSTANTS: C_MON_COL_TEXT(4) TYPE C VALUE '####'.



" #### ##

" #### STRUCT

TYPES:BEGIN OF TY_COMMON_INFO,

        ZPERNR       TYPE C LENGTH 10,  " ####

        ZPNAME       TYPE C LENGTH 10,  " ####

        ZDEPCODE     TYPE ZDEPCODE10,   " ####

        ZDEPNAME     TYPE C LENGTH 10, " ###

        ZDEPRANK     TYPE ZDEPRANK10,   " ####

        ZDEPRANKNAME TYPE C LENGTH 10, " ###

        ZEDATE       TYPE D,            " ####

        ZQFLAG       TYPE ZQFLAG10,     " ####

      END OF TY_COMMON_INFO.



DATA: BEGIN OF GS_STAFF_INFO.

    INCLUDE TYPE TY_COMMON_INFO.

DATA: ZQTEXT    TYPE C LENGTH 10,               " #### TEXT

      ZGENDER   TYPE ZGENDER10,    " ####

      ZGENDERT  TYPE C LENGTH 2,   " ####

      ZADDRESS  TYPE C LENGTH 20,  " ##

      ZBANKCODE TYPE ZBANKCODE10,           " ####

      ZBANKNAME TYPE C LENGTH 3,           " ###

      ZACCOUNT  TYPE C LENGTH 20,           " ####

      END OF GS_STAFF_INFO.

DATA: GT_STAFF_INFO LIKE TABLE OF GS_STAFF_INFO.



" #### STRUCT

DATA: BEGIN OF GS_STAFF_RATING.

    INCLUDE TYPE TY_COMMON_INFO.

DATA: ZSALARY TYPE ZEDT10_106-ZSALARY, " ####

      ZRANK   TYPE ZRANK10,      " ####

      ZMON01  TYPE CURR13_2, " 1###

      ZMON02  TYPE CURR13_2, " 2###

      ZMON03  TYPE CURR13_2, " 3###

      ZMON04  TYPE CURR13_2, " 4###

      ZMON05  TYPE CURR13_2, " 5###

      ZMON06  TYPE CURR13_2, " 6###

      ZMON07  TYPE CURR13_2, " 7###

      ZMON08  TYPE CURR13_2, " 8###

      ZMON09  TYPE CURR13_2, " 9###

      ZMON10  TYPE CURR13_2, " 10###

      ZMON11  TYPE CURR13_2, " 11###

      ZMON12  TYPE CURR13_2, " 12###

      ZWAERS  TYPE WAERS, " ####

      END OF GS_STAFF_RATING.

DATA: GT_STAFF_RATING LIKE TABLE OF GS_STAFF_RATING.



DATA: BEGIN OF GS_STAFF_PAYMENT,

        ZPERNR  TYPE C LENGTH 10,  " ####

        ZQFLAG  TYPE ZQFLAG10,     " ####

        ZQDATE  TYPE D,            " ####

        ZEDATE  TYPE D,       " ####

        ZRANK   TYPE ZRANK10,      " ####

        ZSALARY TYPE ZEDT10_106-ZSALARY, " ####

        ZYEAR   TYPE ZEDT10_105-ZYEAR,

        ZMON01  TYPE CURR13_2, " 1###

        ZMON02  TYPE CURR13_2, " 2###

        ZMON03  TYPE CURR13_2, " 3###

        ZMON04  TYPE CURR13_2, " 4###

        ZMON05  TYPE CURR13_2, " 5###

        ZMON06  TYPE CURR13_2, " 6###

        ZMON07  TYPE CURR13_2, " 7###

        ZMON08  TYPE CURR13_2, " 8###

        ZMON09  TYPE CURR13_2, " 9###

        ZMON10  TYPE CURR13_2, " 10###

        ZMON11  TYPE CURR13_2, " 11###

        ZMON12  TYPE CURR13_2, " 12###

        ZWAERS  TYPE WAERS. " ####

        include structure
ZEDS10_002
.

DATA: END OF GS_STAFF_PAYMENT.

DATA: GT_STAFF_PAYMENT LIKE TABLE OF GS_STAFF_PAYMENT.



" FIELD CAT ##

DATA: GT_FIELDCAT TYPE SLIS_T_FIELDCAT_ALV,

      GS_FIELDCAT TYPE SLIS_FIELDCAT_ALV.

" LAYOUT ##

DATA: GS_LAYOUT TYPE SLIS_LAYOUT_ALV,

      GS_SORT   TYPE SLIS_SORTINFO_ALV,

      GT_SORT   TYPE SLIS_T_SORTINFO_ALV.



" ## ## ### ### ## ##

DATA: GV_TODAY_DATS  TYPE SY-DATUM,

      GV_TODAY_MONTH TYPE MONAT,

      GV_TODAY_YEAR  TYPE GJAHR,

      GV_DATS        LIKE SY-DATUM,

      GV_MON_COL     TYPE C LENGTH 6   " ZMON**# ### COLUMN#

      .



" ##. ## ##

SELECTION-SCREEN BEGIN OF BLOCK B1 WITH FRAME.

SELECT-OPTIONS:

S_ZPERNR FOR GS_STAFF_INFO-ZPERNR,

" ## ## ##

S_DATE FOR GS_STAFF_INFO-ZEDATE NO-EXTENSION MODIF ID INF.

PARAMETERS: P_DEPNM LIKE GS_STAFF_INFO-ZDEPNAME MODIF ID INF.



PARAMETERS:

  P_YEAR  TYPE GJAHR MODIF ID RAT,

  P_MONTH TYPE MONAT MODIF ID RAT.



SELECTION-SCREEN END OF BLOCK B1.



SELECTION-SCREEN BEGIN OF BLOCK B2 WITH FRAME.

PARAMETERS:

  P_I_FLAG RADIOBUTTON GROUP R1 DEFAULT 'X' USER-COMMAND UC1,

  P_P_FLAG RADIOBUTTON GROUP R1,

  P_R_FLAG RADIOBUTTON GROUP R1.

SELECTION-SCREEN END OF BLOCK B2.



SELECTION-SCREEN BEGIN OF BLOCK B3 WITH FRAME.

PARAMETERS:

  P_Q_FLAG AS CHECKBOX DEFAULT 'X' MODIF ID QUI.

SELECTION-SCREEN END OF BLOCK B3.



" #. ## ##



" ### ##



INITIALIZATION.

  " ##. ## SELECT-OPTIONS ##

  " ## # ####.

  GV_TODAY_YEAR = SY-DATUM(4).

  GV_TODAY_MONTH = SY-DATUM+4(2).



  " ## ## ###

  S_DATE-LOW = |{ GV_TODAY_YEAR }0101|.

  " ##. ### #### ###.

  CALL FUNCTION 'RP_LAST_DAY_OF_MONTHS'

    EXPORTING

      DAY_IN            = SY-DATUM

    IMPORTING

      LAST_DAY_OF_MONTH = GV_DATS.

  S_DATE-HIGH = GV_DATS.

  APPEND S_DATE.



  P_YEAR = GV_TODAY_YEAR.

  P_MONTH = GV_TODAY_MONTH.

  " #. ## SELECT-OPTIONS ##





AT SELECTION-SCREEN OUTPUT.

  LOOP AT SCREEN.

    IF P_I_FLAG = 'X'.

      IF SCREEN-GROUP1 = 'RAT'.

        SCREEN-ACTIVE = 0.

      ELSEIF SCREEN-GROUP1 = 'INF'.

        SCREEN-ACTIVE = 1.

      ELSEIF SCREEN-GROUP1 = 'QUI'.

        SCREEN-INVISIBLE = 0.

      ENDIF.

    ELSE.

      IF SCREEN-GROUP1 = 'INF'.

        SCREEN-ACTIVE = 0.

      ELSEIF SCREEN-GROUP1 = 'RAT'.

        SCREEN-ACTIVE = 1.

      ELSEIF SCREEN-GROUP1 = 'QUI'.

        SCREEN-INVISIBLE = 1.

      ENDIF.



    ENDIF.

    MODIFY SCREEN.

  ENDLOOP.



  " ## ##



AT SELECTION-SCREEN.

  IF P_I_FLAG = 'X'.

    " ### ## ## ### #### #### ##

    IF S_DATE-LOW IS INITIAL OR S_DATE-HIGH IS INITIAL.

      MESSAGE '## ### ## #######' TYPE 'E'.

    ENDIF.



  ELSEIF P_R_FLAG = 'X' OR P_P_FLAG = 'X'.

    " ## ### ## ### ## ### ##### ##

    IF P_MONTH IS INITIAL OR P_YEAR IS INITIAL.

      MESSAGE '## #### ### ## ######.' TYPE 'E'.

    ENDIF.



  ENDIF.



  " ## ##



START-OF-SELECTION.

  " COL # ####

  CONCATENATE 'ZMON' P_MONTH INTO GV_MON_COL.

  " CASE# COLNAME ##### ### ##

  " # ##

  PERFORM SELECT_DATA.

  " TEXT DATA ##

  PERFORM MODIF_DATA.



  " ## ##



END-OF-SELECTION.

  IF P_P_FLAG <> 'X'.

    PERFORM SET_FILED_CAT.

    PERFORM LAYOUT_ALV.

    PERFORM CALL_ALV.

  ELSE.

    PERFORM PAYMENT_LOGIC.

  ENDIF.






*&---------------------------------------------------------------------*

*&      Form  SELECT_DATA

*&---------------------------------------------------------------------*

*       text

*----------------------------------------------------------------------*

*  -->  p1        text

*  <--  p2        text

*----------------------------------------------------------------------*




FORM SELECT_DATA .

  " ## ## ## RANGE

  DATA: LT_QUIT_COND TYPE RANGE OF ZEDT10_102-ZQFLAG,

        LS_QUIT_COND LIKE LINE OF LT_QUIT_COND.



  " ### RANGE, ### RANGE

  DATA: LRT_Q_DATE TYPE RANGE OF ZEDT10_102-ZQDATE,

        LRS_Q_DATE LIKE LINE OF LRT_Q_DATE,

        LRT_E_DATE TYPE RANGE OF ZEDT10_102-ZEDATE,

        LRS_E_DATE LIKE LINE OF LRT_E_DATE.



  IF P_I_FLAG = 'X'.

    " #### ### ##.

    IF P_Q_FLAG = 'X'.

      LS_QUIT_COND-SIGN = 'I'.

      LS_QUIT_COND-OPTION = 'NE'.

      LS_QUIT_COND-LOW = 'X'.

      APPEND LS_QUIT_COND TO LT_QUIT_COND.

    ENDIF.



    " #### @S_DATE ### ### ### # S_DATE-HIGH < QDATE(###)

    " #### ##### ## ##. ### #####.

    CLEAR LRS_Q_DATE.

    LRS_Q_DATE-SIGN = 'I'.

    LRS_Q_DATE-LOW = S_DATE-HIGH.

    LRS_Q_DATE-OPTION = 'GT'.

    APPEND LRS_Q_DATE TO LRT_Q_DATE.



    " ## #### ####

    CLEAR LRS_Q_DATE.

    LRS_Q_DATE-SIGN = 'I'.

    LRS_Q_DATE-LOW = 0.

    LRS_Q_DATE-OPTION = 'EQ'.

    APPEND LRS_Q_DATE TO LRT_Q_DATE.



    SELECT

      T2~ZPERNR, T3~ZPNAME, T2~ZDEPCODE, T2~ZDEPRANK, T2~ZEDATE, T2~ZQFLAG,

      T3~ZGENDER, T3~ZADDRESS,

      T6~ZBANKCODE, T6~ZACCOUNT

      FROM ZEDT10_102 AS T2

      INNER JOIN ZEDT10_103 AS T3

        ON T2~ZPERNR = T3~ZPERNR



      INNER JOIN ZEDT10_106 AS T6

        ON T2~ZPERNR = T6~ZPERNR



      WHERE T2~ZEDATE IN @S_DATE          " #### ## ##

      AND   T2~ZQDATE IN @LRT_Q_DATE      " #### ## ###

      AND   T2~ZQFLAG IN @LT_QUIT_COND    " #### ##

      AND   T2~ZPERNR IN @S_ZPERNR        " ## ### ##



    INTO CORRESPONDING FIELDS OF TABLE @GT_STAFF_INFO.



  ELSE.



    " #### ### ## ###### ###

    DATA: LV_LAST_DAY TYPE SY-DATUM.

    CONCATENATE P_YEAR P_MONTH '01' INTO LV_LAST_DAY.

    CALL FUNCTION 'RP_LAST_DAY_OF_MONTHS'

      EXPORTING

        DAY_IN            = LV_LAST_DAY

      IMPORTING

        LAST_DAY_OF_MONTH = LV_LAST_DAY.



    CLEAR LRS_Q_DATE.

    LRS_Q_DATE-SIGN = 'I'.

    LRS_Q_DATE-LOW = LV_LAST_DAY.

    LRS_Q_DATE-OPTION = 'GT'.

    APPEND LRS_Q_DATE TO LRT_Q_DATE.



    " #### ####

    CLEAR LRS_Q_DATE.

    LRS_Q_DATE-SIGN = 'I'.

    LRS_Q_DATE-LOW = 0.

    LRS_Q_DATE-OPTION = 'EQ'.

    APPEND LRS_Q_DATE TO LRT_Q_DATE.



    " #### ### # ## ## ### ##

    CLEAR LRS_E_DATE.

    LRS_E_DATE-SIGN = 'I'.

    CONCATENATE P_YEAR P_MONTH '01' INTO LRS_E_DATE-LOW.

    LRS_E_DATE-OPTION = 'LE'.

    APPEND LRS_E_DATE TO LRT_E_DATE.



    IF P_R_FLAG = 'X'.

      " ### ### ## 4# #### ####

      " PAYMENT# ### ### T5# ### ### ##.

      SELECT

         T2~ZPERNR, T2~ZDEPCODE, T2~ZDEPRANK, T2~ZQFLAG, T2~ZEDATE, T6~ZSALARY, T4~ZRANK, T6~ZWAERS

        FROM ZEDT10_102 AS T2

        INNER JOIN ZEDT10_104 AS T4

          ON T2~ZPERNR = T4~ZPERNR

        INNER JOIN ZEDT10_106 AS T6

          ON T2~ZPERNR = T6~ZPERNR



        WHERE   T2~ZPERNR IN @S_ZPERNR        " ## ### ##

        AND     T2~ZQDATE IN @LRT_Q_DATE

        AND     T2~ZEDATE IN @LRT_E_DATE

        AND T6~ZYEAR = @P_YEAR

        AND T4~ZYEAR = @P_YEAR                " ## ### ## #### ###

        INTO CORRESPONDING FIELDS OF TABLE @GT_STAFF_RATING

        .



      " 103# 105# #### #### ###.

      DATA: LS_T3_5 LIKE GS_STAFF_RATING,

            LT_T3_5 LIKE TABLE OF LS_T3_5.

      " 103# 105# #### ### ####

      SELECT T3~ZPERNR T3~ZPNAME

        T5~ZMON01 T5~ZMON02 T5~ZMON03 T5~ZMON04 T5~ZMON05 T5~ZMON06 T5~ZMON07

        T5~ZMON08 T5~ZMON09 T5~ZMON10 T5~ZMON11 T5~ZMON12

        FROM ZEDT10_105 AS T5

        INNER JOIN ZEDT10_103 AS T3

          ON T5~ZPERNR = T3~ZPERNR

        INTO CORRESPONDING FIELDS OF TABLE LT_T3_5.



      LOOP AT LT_T3_5 INTO LS_T3_5.

        MODIFY GT_STAFF_RATING FROM LS_T3_5

          TRANSPORTING

          ZMON01 ZMON02 ZMON03 ZMON04 ZMON05 ZMON06

          ZMON07 ZMON08 ZMON09 ZMON10 ZMON11 ZMON12

          WHERE ZPERNR = LS_T3_5-ZPERNR.

      ENDLOOP.



    ELSEIF P_P_FLAG = 'X'.

      " ### # ####, ####, #####

      " ### MODIFY## ## 105 TABLE# ## ### #####.

      SELECT

        T2~ZPERNR, T2~ZQFLAG, T2~ZQDATE, T2~ZEDATE, T6~ZSALARY, T4~ZRANK, T6~ZWAERS,

        T4~ZYEAR,

        T5~ZMON01, T5~ZMON02, T5~ZMON03, T5~ZMON04, T5~ZMON05, T5~ZMON06,

        T5~ZMON07, T5~ZMON08, T5~ZMON09, T5~ZMON10, T5~ZMON11, T5~ZMON12,

        T5~CRNAME, T5~CRDATE, T5~CRZEIT, T5~AENAME, T5~AEDATE

        FROM ZEDT10_102 AS T2

        INNER JOIN ZEDT10_104 AS T4

          ON T2~ZPERNR = T4~ZPERNR

        INNER JOIN ZEDT10_106 AS T6

          ON T2~ZPERNR = T6~ZPERNR

        INNER JOIN ZEDT10_105 AS T5

          ON T2~ZPERNR = T5~ZPERNR



        WHERE   T2~ZPERNR IN @S_ZPERNR        " ## ### ##

        AND     T2~ZQDATE IN @LRT_Q_DATE

        AND     T2~ZEDATE IN @LRT_E_DATE

        AND T6~ZYEAR = @P_YEAR

        AND T4~ZYEAR = @P_YEAR                " ## ### ## #### ###



      INTO CORRESPONDING FIELDS OF TABLE @GT_STAFF_PAYMENT.

    ENDIF.

  ENDIF.

ENDFORM.




*&---------------------------------------------------------------------*

*&      Form  MODIF_DATA

*&---------------------------------------------------------------------*

*       text

*----------------------------------------------------------------------*

*  -->  p1        text

*  <--  p2        text

*----------------------------------------------------------------------*




FORM MODIF_DATA .

  IF P_I_FLAG = 'X'.

    LOOP AT GT_STAFF_INFO INTO GS_STAFF_INFO.

      " ###

      PERFORM MODIF_DEPNAME CHANGING GS_STAFF_INFO.

      " ###

      PERFORM MODIF_RANKNAME CHANGING GS_STAFF_INFO.

      " ## TEXT ##

      CASE GS_STAFF_INFO-ZBANKCODE.

        WHEN '001'.

          GS_STAFF_INFO-ZBANKNAME = '##'.

        WHEN '002'.

          GS_STAFF_INFO-ZBANKNAME = '##'.

        WHEN '003'.

          GS_STAFF_INFO-ZBANKNAME = '##'.

        WHEN '004'.

          GS_STAFF_INFO-ZBANKNAME = '##'.

        WHEN '005'.

          GS_STAFF_INFO-ZBANKNAME = '###'.

      ENDCASE.

      " #### ##

      CASE GS_STAFF_INFO-ZQFLAG.

        WHEN 'X'.

          GS_STAFF_INFO-ZQTEXT = '##'.

        WHEN OTHERS.

          GS_STAFF_INFO-ZQTEXT = '##'.

      ENDCASE.

      " ## ##

      CASE GS_STAFF_INFO-ZGENDER.

        WHEN 'M'.

          GS_STAFF_INFO-ZGENDERT = '##'.

        WHEN 'F'.

          GS_STAFF_INFO-ZGENDERT = '##'.

      ENDCASE.

      MODIFY GT_STAFF_INFO FROM GS_STAFF_INFO INDEX SY-TABIX.

    ENDLOOP.

  ELSEIF P_R_FLAG = 'X'.

    LOOP AT GT_STAFF_RATING INTO GS_STAFF_RATING.

      " ###

      PERFORM MODIF_DEPNAME CHANGING GS_STAFF_RATING.

      " ###

      PERFORM MODIF_RANKNAME CHANGING GS_STAFF_RATING.

      MODIFY GT_STAFF_RATING FROM GS_STAFF_RATING INDEX SY-TABIX.

    ENDLOOP.

  ENDIF.

ENDFORM.




*&---------------------------------------------------------------------*

*&      Form  SET_FILED_CAT

*&---------------------------------------------------------------------*

*       text

*----------------------------------------------------------------------*

*  -->  p1        text

*  <--  p2        text

*----------------------------------------------------------------------*




FORM SET_FILED_CAT .

  " TODO: ## ## IF # ## ##

  IF P_I_FLAG = 'X'.

    " 1. ####

    GS_FIELDCAT-FIELDNAME = 'ZPERNR'.         " ### ### ###

    GS_FIELDCAT-SELTEXT_M = '####'.       " ## ## ### (## ##)

    GS_FIELDCAT-COL_POS   = 1.                " ## ##

    GS_FIELDCAT-KEY = 'X'.

    APPEND GS_FIELDCAT TO GT_FIELDCAT.

    CLEAR GS_FIELDCAT.



    " 2. ####

    GS_FIELDCAT-FIELDNAME = 'ZPNAME'.

    GS_FIELDCAT-SELTEXT_M = '####'.

    GS_FIELDCAT-COL_POS   = 2.

    GS_FIELDCAT-KEY = 'X'.

    APPEND GS_FIELDCAT TO GT_FIELDCAT.

    CLEAR GS_FIELDCAT.



    " 3. ####

    GS_FIELDCAT-FIELDNAME = 'ZDEPCODE'.

    GS_FIELDCAT-SELTEXT_M = '####'.

    GS_FIELDCAT-COL_POS   = 3.

    APPEND GS_FIELDCAT TO GT_FIELDCAT.

    CLEAR GS_FIELDCAT.



    " 4. ###

    GS_FIELDCAT-FIELDNAME = 'ZDEPNAME'.

    GS_FIELDCAT-SELTEXT_M = '###'.

    GS_FIELDCAT-COL_POS   = 4.

    APPEND GS_FIELDCAT TO GT_FIELDCAT.

    CLEAR GS_FIELDCAT.



    " 5. ###

    GS_FIELDCAT-FIELDNAME = 'ZDEPRANKNAME'.

    GS_FIELDCAT-SELTEXT_M = '###'.

    GS_FIELDCAT-COL_POS   = 5.

    APPEND GS_FIELDCAT TO GT_FIELDCAT.

    CLEAR GS_FIELDCAT.



    " 6. ###

    GS_FIELDCAT-FIELDNAME = 'ZEDATE'.

    GS_FIELDCAT-SELTEXT_M = '###'.

    GS_FIELDCAT-COL_POS   = 6.

    APPEND GS_FIELDCAT TO GT_FIELDCAT.

    CLEAR GS_FIELDCAT.



    " 7. ####

    GS_FIELDCAT-FIELDNAME = 'ZQTEXT'.

    GS_FIELDCAT-SELTEXT_M = '####'.

    GS_FIELDCAT-COL_POS   = 7.

    APPEND GS_FIELDCAT TO GT_FIELDCAT.

    CLEAR GS_FIELDCAT.



    " 8. ##

    GS_FIELDCAT-FIELDNAME = 'ZGENDERT'.

    GS_FIELDCAT-SELTEXT_M = '##'.

    GS_FIELDCAT-COL_POS   = 8.

    APPEND GS_FIELDCAT TO GT_FIELDCAT.

    CLEAR GS_FIELDCAT.



    " 9. ##

    GS_FIELDCAT-FIELDNAME = 'ZADDRESS'.

    GS_FIELDCAT-SELTEXT_M = '##'.

    GS_FIELDCAT-COL_POS   = 9.

    APPEND GS_FIELDCAT TO GT_FIELDCAT.

    CLEAR GS_FIELDCAT.



    " 10. ####

    GS_FIELDCAT-FIELDNAME = 'ZBANKCODE'.

    GS_FIELDCAT-SELTEXT_M = '####'.

    GS_FIELDCAT-COL_POS   = 10.

    APPEND GS_FIELDCAT TO GT_FIELDCAT.

    CLEAR GS_FIELDCAT.



    " 11. ###

    GS_FIELDCAT-FIELDNAME = 'ZBANKNAME'.

    GS_FIELDCAT-SELTEXT_M = '###'.

    GS_FIELDCAT-COL_POS   = 11.

    APPEND GS_FIELDCAT TO GT_FIELDCAT.

    CLEAR GS_FIELDCAT.



    " 12. ####

    GS_FIELDCAT-FIELDNAME = 'ZACCOUNT'.

    GS_FIELDCAT-SELTEXT_M = '####'.

    GS_FIELDCAT-COL_POS   = 12.

    APPEND GS_FIELDCAT TO GT_FIELDCAT.

    CLEAR GS_FIELDCAT.



  ELSEIF P_R_FLAG = 'X'.

    " 1. ####

    GS_FIELDCAT-FIELDNAME = 'ZPERNR'.

    GS_FIELDCAT-SELTEXT_M = '####'.

    GS_FIELDCAT-COL_POS   = 1.

    GS_FIELDCAT-KEY       = 'X'.

    APPEND GS_FIELDCAT TO GT_FIELDCAT.

    CLEAR GS_FIELDCAT.



    " 2. ####

    GS_FIELDCAT-FIELDNAME = 'ZPNAME'.

    GS_FIELDCAT-SELTEXT_M = '####'.

    GS_FIELDCAT-COL_POS   = 2.

    GS_FIELDCAT-KEY = 'X'.

    APPEND GS_FIELDCAT TO GT_FIELDCAT.

    CLEAR GS_FIELDCAT.



    " 3. ####

    GS_FIELDCAT-FIELDNAME = 'ZDEPCODE'.

    GS_FIELDCAT-SELTEXT_M = '####'.

    GS_FIELDCAT-COL_POS   = 3.

    APPEND GS_FIELDCAT TO GT_FIELDCAT.

    CLEAR GS_FIELDCAT.



    " 4. ###

    GS_FIELDCAT-FIELDNAME = 'ZDEPNAME'.

    GS_FIELDCAT-SELTEXT_M = '###'.

    GS_FIELDCAT-COL_POS   = 4.

    APPEND GS_FIELDCAT TO GT_FIELDCAT.

    CLEAR GS_FIELDCAT.



    " 5. ###

    GS_FIELDCAT-FIELDNAME = 'ZDEPRANKNAME'.

    GS_FIELDCAT-SELTEXT_M = '###'.

    GS_FIELDCAT-COL_POS   = 5.

    APPEND GS_FIELDCAT TO GT_FIELDCAT.

    CLEAR GS_FIELDCAT.



    " 6. ###

    GS_FIELDCAT-FIELDNAME = 'ZEDATE'.

    GS_FIELDCAT-SELTEXT_M = '###'.

    GS_FIELDCAT-COL_POS   = 6.

    APPEND GS_FIELDCAT TO GT_FIELDCAT.

    CLEAR GS_FIELDCAT.



    " 7. ####

    GS_FIELDCAT-FIELDNAME  = 'ZSALARY'.

    GS_FIELDCAT-SELTEXT_M  = '####'.

    GS_FIELDCAT-COL_POS    = 7.

    GS_FIELDCAT-DO_SUM     = 'X'. " ## ### ### #### ##

    GS_FIELDCAT-CFIELDNAME = 'ZWAERS'. " ## ##(Currency) ### #### 3## ## # ## ##

    APPEND GS_FIELDCAT TO GT_FIELDCAT.

    CLEAR GS_FIELDCAT.



    " 8. ####

    GS_FIELDCAT-FIELDNAME = 'ZRANK'.

    GS_FIELDCAT-SELTEXT_M = '####'.

    GS_FIELDCAT-COL_POS   = 8.

    APPEND GS_FIELDCAT TO GT_FIELDCAT.

    CLEAR GS_FIELDCAT.



    " 9. 01####

    " DYNAMIC SELTEXT# ## ## ## # ##

    DATA: LV_SELTEXT TYPE C LENGTH 6.

    CONCATENATE P_MONTH C_MON_COL_TEXT INTO LV_SELTEXT.

    GS_FIELDCAT-FIELDNAME  = GV_MON_COL.

    GS_FIELDCAT-SELTEXT_M  = LV_SELTEXT.

    GS_FIELDCAT-COL_POS    = 9.

    GS_FIELDCAT-DO_SUM     = 'X'. " ## ### ### #### ##

    GS_FIELDCAT-CFIELDNAME = 'ZWAERS'. " ## ## ### ##

    APPEND GS_FIELDCAT TO GT_FIELDCAT.

    CLEAR GS_FIELDCAT.

  ENDIF.

ENDFORM.




*&---------------------------------------------------------------------*

*&      Form  LAYOUT_ALV

*&---------------------------------------------------------------------*

*       text

*----------------------------------------------------------------------*

*  -->  p1        text

*  <--  p2        text

*----------------------------------------------------------------------*




FORM LAYOUT_ALV .

  GS_LAYOUT-ZEBRA = 'X'.

  GS_SORT-SPOS = 1.

  GS_SORT-FIELDNAME = 'ZPERNR'.

  GS_SORT-UP = 'X'.

  APPEND GS_SORT TO GT_SORT.

ENDFORM.




*&---------------------------------------------------------------------*

*&      Form  CALL_ALV

*&---------------------------------------------------------------------*

*       text

*----------------------------------------------------------------------*

*  -->  p1        text

*  <--  p2        text

*----------------------------------------------------------------------*




FORM CALL_ALV .

  IF P_I_FLAG = 'X'.

    CALL FUNCTION 'REUSE_ALV_GRID_DISPLAY'

      EXPORTING

        IT_FIELDCAT = GT_FIELDCAT

        IS_LAYOUT   = GS_LAYOUT

      TABLES

        T_OUTTAB    = GT_STAFF_INFO.

  ELSEIF P_R_FLAG = 'X'.

    CALL FUNCTION 'REUSE_ALV_GRID_DISPLAY'

      EXPORTING

        IT_FIELDCAT = GT_FIELDCAT

        IS_LAYOUT   = GS_LAYOUT

      TABLES

        T_OUTTAB    = GT_STAFF_RATING.

  ENDIF.

ENDFORM.




*&---------------------------------------------------------------------*

*&      Form  MODIF_DEPNAME

*&---------------------------------------------------------------------*

*       text

*----------------------------------------------------------------------*

*  -->  p1        text

*  <--  p2        text

*----------------------------------------------------------------------*




FORM MODIF_DEPNAME CHANGING P_GS_STAFF TYPE ANY.



  " CASTING# ## WRAPPING

  FIELD-SYMBOLS: <LS_COMMON> TYPE TY_COMMON_INFO.

  ASSIGN P_GS_STAFF TO <LS_COMMON> CASTING.



  CASE <LS_COMMON>-ZDEPCODE.

    WHEN 'SS0001'.

      <LS_COMMON>-ZDEPNAME = '###'.

    WHEN 'SS0002'.

      <LS_COMMON>-ZDEPNAME = '###'.

    WHEN 'SS0003'.

      <LS_COMMON>-ZDEPNAME = '###'.

    WHEN 'SS0004'.

      <LS_COMMON>-ZDEPNAME = '###'.

    WHEN 'SS0005'.

      <LS_COMMON>-ZDEPNAME = '###'.

    WHEN 'SS0006'.

      <LS_COMMON>-ZDEPNAME = '###'.

  ENDCASE.

ENDFORM.




*&---------------------------------------------------------------------*

*&      Form  MODIF_RANKNAME

*&---------------------------------------------------------------------*

*       text

*----------------------------------------------------------------------*

*      <--P_GS_STAFF_INFO  text

*----------------------------------------------------------------------*




FORM MODIF_RANKNAME  CHANGING P_GS_STAFF TYPE ANY .



  " CASTING# ## WRAPPING

  FIELD-SYMBOLS: <LS_COMMON> TYPE TY_COMMON_INFO.

  ASSIGN P_GS_STAFF TO <LS_COMMON> CASTING.



  CASE <LS_COMMON>-ZDEPRANK.

    WHEN 'A'.

      <LS_COMMON>-ZDEPRANKNAME = '##'.

    WHEN 'B'.

      <LS_COMMON>-ZDEPRANKNAME = '##'.

    WHEN 'C'.

      <LS_COMMON>-ZDEPRANKNAME = '##'.

    WHEN 'D'.

      <LS_COMMON>-ZDEPRANKNAME = '##'.

    WHEN 'E'.

      <LS_COMMON>-ZDEPRANKNAME = '##'.

    WHEN 'F'.

      <LS_COMMON>-ZDEPRANKNAME = '##'.

    WHEN 'G'.

      <LS_COMMON>-ZDEPRANKNAME = '##'.

  ENDCASE.

ENDFORM.




*&---------------------------------------------------------------------*

*&      Form  PAYMENT_LOGIC

*&---------------------------------------------------------------------*

*       text

*----------------------------------------------------------------------*

*  -->  p1        text

*  <--  p2        text

*----------------------------------------------------------------------*




FORM PAYMENT_LOGIC .

  DATA: LV_ERROR_FLAG TYPE C LENGTH 1 VALUE ''.

  DATA: LV_ERROR_MESSAGE TYPE STRING VALUE ''.

  DATA: LV_TEMP_MESSAGE TYPE STRING.

  LOOP AT GT_STAFF_PAYMENT ASSIGNING FIELD-SYMBOL(<FS_STAFF_PAYMENT>).

    " ##### #### #### ####. ### ###



    " ##### ## ### ## ## #### ### ####

    CHECK <FS_STAFF_PAYMENT>-ZRANK IS NOT INITIAL.



    " ### ### 12## 1# ##

    FIELD-SYMBOLS: <FS_PAY_COL> TYPE ANY.

    ASSIGN COMPONENT GV_MON_COL OF STRUCTURE <FS_STAFF_PAYMENT> TO <FS_PAY_COL>.

    IF <FS_PAY_COL> IS ASSIGNED.

      <FS_PAY_COL> = <FS_STAFF_PAYMENT>-ZSALARY / 12.

      " ## ### A## 5## ###

      IF <FS_STAFF_PAYMENT>-ZRANK = 'A'.

        <FS_PAY_COL> = <FS_PAY_COL> + 500.

      ENDIF.

    ELSE.

      " ### #### ## STOP ##

      STOP.

    ENDIF.

  ENDLOOP.



  IF LV_ERROR_FLAG = 'X'.

    WRITE:/ '## ## ##'.

  ELSE.

    PERFORM UPDATE_PAYMENT USING GT_STAFF_PAYMENT.



    IF SY-SUBRC <> 0.

      WRITE:/ '## ## ##'.

    ELSE.

      WRITE:/ '## ## ##'.

    ENDIF.

  ENDIF.

ENDFORM.




*&---------------------------------------------------------------------*

*&      Form  UPDATE_PAYMENT

*&---------------------------------------------------------------------*

*       text

*----------------------------------------------------------------------*

*      -->P_GS_STAFF_PAYMENT  text

*----------------------------------------------------------------------*




FORM UPDATE_PAYMENT  USING    P_GT_STAFF_PAYMENT LIKE GT_STAFF_PAYMENT.

  FIELD-SYMBOLS: <MON_PAYMENT> LIKE GS_STAFF_PAYMENT-ZMON01,

                 <LS_MON_PAYMENT> LIKE ZEDT10_105-ZMON01.

  DATA: LS_ZEDT10_105 TYPE ZEDT10_105.    " MODIFY# ###



  LOOP AT P_GT_STAFF_PAYMENT ASSIGNING FIELD-SYMBOL(<FS_STAFF_PAYMENT>).

    CLEAR LS_ZEDT10_105.



    " ## FIELD ### ### ### CASTING

    MOVE-CORRESPONDING <FS_STAFF_PAYMENT> TO LS_ZEDT10_105.



    " #### # ### ####

    LS_ZEDT10_105-AEDATE = SY-DATUM.

    LS_ZEDT10_105-AENAME = SY-UNAME.

    LS_ZEDT10_105-AEZEIT = SY-UZEIT.



    " ### MODIFY# ####

    MODIFY ZEDT10_105 FROM LS_ZEDT10_105.



    IF SY-SUBRC <> 0.

      " MODIFY ##

      ROLLBACK WORK.

      EXIT.

    ENDIF.

  ENDLOOP.



  " ## LOOP# ##### ### COMMIT

  COMMIT WORK.

  SY-SUBRC = 0. " ## ##



ENDFORM.








*Messages

*----------------------------------------------------------

*

* Message class: Hard coded

*   ## ### ## #######