
*&---------------------------------------------------------------------*

*& Report ZEDR01_PRACTICE006

*&---------------------------------------------------------------------*

*&

*&---------------------------------------------------------------------*




REPORT ZEDR01_PRACTICE006 MESSAGE-ID ZMED01.



TABLES : ZEDT01_102 , ZEDT01_103 , ZEDT01_104 , ZEDT01_105 ,ZEDT01_106.




*&---------------------------------------------------------------------*




DATA : BEGIN OF GS_INFO,                   "## ## ### ### # ###

  ZPERNR TYPE ZEDT01_102-ZPERNR,           "####

  ZPNAME TYPE ZEDT01_103-ZPNAME,           "####

  ZDEPCODE TYPE ZEDT01_102-ZDEPCODE,       "####

  ZDEPCODE_NAME TYPE C LENGTH 20,          "###

  ZDEPRANK TYPE ZEDT01_102-ZDEPRANK,       "##

  ZDEPRANK_NAME TYPE C LENGTH 20,          "###

  ZEDATE TYPE ZEDT01_102-ZEDATE,           "###

  ZQDATE TYPE ZEDT01_102-ZQDATE,           "###

  ZQFLAG TYPE ZEDT01_102-ZQFLAG,           "####

  ZQFLAG_NAME TYPE C LENGTH 20,            "####

  ZGENDER TYPE ZEDT01_103-ZGENDER,         "##

  ZGENDER_NAME TYPE C LENGTH 20,           "####

  ZADDRESS TYPE ZEDT01_103-ZADDRESS,       "##

  ZBANKCODE TYPE ZEDT01_106-ZBANKCODE,     "####

  ZBANKCODE_NAME TYPE C LENGTH 20,         "###

  ZACCOUNT TYPE ZEDT01_106-ZACCOUNT,       "####

  DATBI TYPE ZEDT01_102-DATBI,             "####

  DATAB TYPE ZEDT01_102-DATAB,             "####

  END OF GS_INFO.

DATA : GT_INFO LIKE TABLE OF GS_INFO.



DATA : BEGIN OF GS_PAY_INFO,           "##### ### # ###

  ZPERNR TYPE ZEDT01_102-ZPERNR,       "####

  ZYEAR TYPE ZEDT01_104-ZYEAR,         "####

  ZPNAME TYPE ZEDT01_103-ZPNAME,       "####

  ZDEPCODE TYPE ZEDT01_102-ZDEPCODE,   "##

  ZDEPCODE_NAME TYPE C LENGTH 20,      "###

  ZDEPRANK TYPE ZEDT01_102-ZDEPRANK,   "##

  ZDEPRANK_NAME TYPE C LENGTH 20,      "###

  ZEDATE TYPE ZEDT01_102-ZEDATE,       "###

  ZQDATE TYPE ZEDT01_102-ZQDATE,       "###

  ZQFLAG TYPE ZEDT01_102-ZQFLAG,       "####

  ZSALARY TYPE ZEDT01_106-ZSALARY,     "####

  ZPAY_MONTH TYPE ZEDT01_106-ZSALARY,  "### ###

  ZRANK TYPE ZEDT01_104-ZRANK,         "####

  ZMON01 TYPE ZEDT01_105-ZMON01,       "1~12### ###

  ZMON02 TYPE ZEDT01_105-ZMON02,

  ZMON03 TYPE ZEDT01_105-ZMON03,

  ZMON04 TYPE ZEDT01_105-ZMON04,

  ZMON05 TYPE ZEDT01_105-ZMON05,

  ZMON06 TYPE ZEDT01_105-ZMON06,

  ZMON07 TYPE ZEDT01_105-ZMON07,

  ZMON08 TYPE ZEDT01_105-ZMON08,

  ZMON09 TYPE ZEDT01_105-ZMON09,

  ZMON10 TYPE ZEDT01_105-ZMON10,

  ZMON11 TYPE ZEDT01_105-ZMON11,

  ZMON12 TYPE ZEDT01_105-ZMON12,

  END OF GS_PAY_INFO.

DATA : GT_PAY_INFO LIKE TABLE OF GS_PAY_INFO.



DATA : GS_PAY TYPE ZEDT01_105.         "ZEDT01_105# ###### #### ###



CONSTANTS : LV_PAY_RATE_A TYPE I VALUE 500.  "##### ## ####

RANGES : GR_RANK FOR ZEDT01_104-ZRANK.       "#### ## ## A##

CLEAR GR_RANK.

GR_RANK-SIGN = 'I'.

GR_RANK-OPTION = 'EQ'.

GR_RANK-LOW = 'A'.

APPEND GR_RANK.



DATA : LV_MONTH_TEXT TYPE CHAR10.            "### ### ##

DATA : LV_MONTH_PAY TYPE I.                  "### ###

DATA : LV_LASTDAY TYPE I.                    "## ###



DATA : GS_FIELDCAT TYPE SLIS_FIELDCAT_ALV.    "ALV# ### ##

DATA : GT_FIELDCAT TYPE SLIS_T_FIELDCAT_ALV.

DATA : GS_LAYOUT TYPE SLIS_LAYOUT_ALV.

DATA : GS_SORT TYPE SLIS_SORTINFO_ALV.

DATA : GT_SORT TYPE SLIS_T_SORTINFO_ALV.




*&---------------------------------------------------------------------*






SELECTION-SCREEN BEGIN OF BLOCK B1 WITH FRAME.                " ### ##

  SELECT-OPTIONS : S_ZPERNR FOR ZEDT01_102-ZPERNR.            " ####

  SELECT-OPTIONS : S_ZDATE FOR ZEDT01_102-DATBI MODIF ID M1.  " ## ( M1 )

  PARAMETERS : S_DEP TYPE ZEDT01_102-ZDEPCODE MODIF ID M1.    " ## ( M1 )

  PARAMETERS : P_YEAR TYPE ZEDT05_104-ZYEAR MODIF ID M2.      " ## ( M1 )

  PARAMETERS : P_MONTH TYPE BKPF-MONAT MODIF ID M2.           " #   ( M2 )

SELECTION-SCREEN END OF BLOCK B1.



INITIALIZATION.



CONCATENATE SY-DATUM(4) '01' '01' INTO S_ZDATE-LOW.          " ### ### ## ####,01# 01# # ##

CALL FUNCTION 'RP_LAST_DAY_OF_MONTHS'                        " ### ### ## #### ## ## ##

    EXPORTING

      DAY_IN                  = SY-DATUM

    IMPORTING

      LAST_DAY_OF_MONTH       = S_ZDATE-HIGH.

APPEND S_ZDATE.

P_YEAR = SY-DATUM(4).

P_MONTH = SY-DATUM+4(2).






*&---------------------------------------------------------------------*




START-OF-SELECTION.



SELECTION-SCREEN BEGIN OF BLOCK B2 WITH FRAME.                         " ### ##

  PARAMETERS : P_R1 RADIOBUTTON GROUP R1 DEFAULT 'X' USER-COMMAND UC1. " ####

  PARAMETERS : P_R2 RADIOBUTTON GROUP R1.                              " ####

  PARAMETERS : P_R3 RADIOBUTTON GROUP R1.                              " ####

SELECTION-SCREEN END OF BLOCK B2.



SELECTION-SCREEN BEGIN OF BLOCK B3 WITH FRAME.                         " ####

  PARAMETERS : P_CH1 AS CHECKBOX DEFAULT 'X'.                          " ####

SELECTION-SCREEN END OF BLOCK B3.



AT SELECTION-SCREEN.

  IF P_R1 = 'X'.                                                       " ##### ####

    IF S_ZDATE IS INITIAL.                                             " ### ##### ##

      MESSAGE E000.                                                    " ##### ##

    ENDIF.

  ELSEIF P_R2 = 'X' OR P_R3 = 'X'.                                     " #### OR ##### ####

    IF P_YEAR IS INITIAL OR P_MONTH IS INITIAL.                        " ## ## ## ##### ##

      MESSAGE E000.                                                    " ##### ##

    ENDIF.

  ENDIF.



AT SELECTION-SCREEN OUTPUT.                                           " ### ##

  LOOP AT SCREEN.

    IF SCREEN-GROUP1 = 'M1'.                                          " M1## ##

      IF P_R2 = 'X' OR P_R3 = 'X'.                                    " #### OR ##### ##### M1## OFF

        SCREEN-ACTIVE = '0'.

      ELSEIF P_R1 = 'X'.                                              " ##### ##### ON

        SCREEN-ACTIVE = '1'.

      ENDIF.

    ENDIF.



    IF SCREEN-GROUP1 = 'M2'.                                          " M2## ##

      IF P_R2 = 'X' OR P_R3 = 'X'.                                    " #### ##### #### ON

        SCREEN-ACTIVE = '1'.

      ELSEIF P_R1 = 'X'.                                              " ##### ##### OFF

        SCREEN-ACTIVE = '0'.

      ENDIF.

    ENDIF.



    MODIFY SCREEN.

  ENDLOOP.



END-OF-SELECTION.




*&---------------------------------------------------------------------*






IF P_R1 = 'X'.                                    "##### ###### #####

  PERFORM GET_DATA_INFO.

  PERFORM MODIFY_DATA.

  PERFORM ALV_DISPLAY USING GT_INFO.

ELSEIF P_R2 = 'X'.                                "##### ### ##

  PERFORM GET_DATA_PAY.

  PERFORM MODIFY_PAY.

ELSEIF P_R3 = 'X'.                                "##### ### ##

  PERFORM GET_DATA_PAY.

  PERFORM MODIFY_PAY_DATA.

  PERFORM ALV_DISPLAY USING GT_PAY_INFO.

ENDIF.






*&---------------------------------------------------------------------*

*&      Form  FIELD_CATALOG

*&---------------------------------------------------------------------*




FORM FIELD_CATALOG .



  CLEAR : GS_FIELDCAT,GT_FIELDCAT.

  GS_FIELDCAT-COL_POS = 1.

  GS_FIELDCAT-FIELDNAME = 'ZPERNR'.

  GS_FIELDCAT-SELTEXT_M = '####'.

  GS_FIELDCAT-KEY = 'X'.

  APPEND GS_FIELDCAT TO GT_FIELDCAT.



  CLEAR : GS_FIELDCAT.

  GS_FIELDCAT-COL_POS = 2.

  GS_FIELDCAT-FIELDNAME = 'ZPNAME'.

  GS_FIELDCAT-SELTEXT_M = '####'.

  GS_FIELDCAT-KEY = 'X'.

  APPEND GS_FIELDCAT TO GT_FIELDCAT.



  CLEAR : GS_FIELDCAT.

  GS_FIELDCAT-COL_POS = 3.

  GS_FIELDCAT-FIELDNAME = 'ZDEPCODE'.

  GS_FIELDCAT-SELTEXT_M = '####'.

  APPEND GS_FIELDCAT TO GT_FIELDCAT.



  CLEAR : GS_FIELDCAT.

  GS_FIELDCAT-COL_POS = 4.

  GS_FIELDCAT-FIELDNAME = 'ZDEPCODE_NAME'.

  GS_FIELDCAT-SELTEXT_M = '###'.

  APPEND GS_FIELDCAT TO GT_FIELDCAT.



  CLEAR : GS_FIELDCAT.

  GS_FIELDCAT-COL_POS = 5.

  GS_FIELDCAT-FIELDNAME = 'ZDEPRANK_NAME'.

  GS_FIELDCAT-SELTEXT_M = '###'.

  APPEND GS_FIELDCAT TO GT_FIELDCAT.



  CLEAR : GS_FIELDCAT.

  GS_FIELDCAT-COL_POS = 6.

  GS_FIELDCAT-FIELDNAME = 'ZEDATE'.

  GS_FIELDCAT-SELTEXT_M = '###'.

  APPEND GS_FIELDCAT TO GT_FIELDCAT.



  IF P_R1 = 'X'.



    CLEAR : GS_FIELDCAT.

    GS_FIELDCAT-COL_POS = 7.

    GS_FIELDCAT-FIELDNAME = 'ZQFLAG_NAME'.

    GS_FIELDCAT-SELTEXT_M = '####'.

    APPEND GS_FIELDCAT TO GT_FIELDCAT.



    CLEAR : GS_FIELDCAT.

    GS_FIELDCAT-COL_POS = 8.

    GS_FIELDCAT-FIELDNAME = 'ZGENDER_NAME'.

    GS_FIELDCAT-SELTEXT_M = '##'.

    APPEND GS_FIELDCAT TO GT_FIELDCAT.



    CLEAR : GS_FIELDCAT.

    GS_FIELDCAT-COL_POS = 9.

    GS_FIELDCAT-FIELDNAME = 'ZADDRESS'.

    GS_FIELDCAT-SELTEXT_M = '##'.

    APPEND GS_FIELDCAT TO GT_FIELDCAT.



    CLEAR : GS_FIELDCAT.

    GS_FIELDCAT-COL_POS = 10.

    GS_FIELDCAT-FIELDNAME = 'ZBANKCODE'.

    GS_FIELDCAT-SELTEXT_M = '####'.

    APPEND GS_FIELDCAT TO GT_FIELDCAT.



    CLEAR : GS_FIELDCAT.

    GS_FIELDCAT-COL_POS = 11.

    GS_FIELDCAT-FIELDNAME = 'ZBANKCODE_NAME'.

    GS_FIELDCAT-SELTEXT_M = '###'.

    APPEND GS_FIELDCAT TO GT_FIELDCAT.



    CLEAR : GS_FIELDCAT.

    GS_FIELDCAT-COL_POS = 12.

    GS_FIELDCAT-FIELDNAME = 'ZACCOUNT'.

    GS_FIELDCAT-SELTEXT_M = '####'.

    APPEND GS_FIELDCAT TO GT_FIELDCAT.



  ELSEIF P_R3 = 'X'.



    CLEAR : GS_FIELDCAT.

    GS_FIELDCAT-COL_POS = 7.

    GS_FIELDCAT-FIELDNAME = 'ZSALARY'.

    GS_FIELDCAT-SELTEXT_M = '####'.

    GS_FIELDCAT-DO_SUM = 'X'.

    GS_FIELDCAT-CURRENCY = 'KRW'.

    APPEND GS_FIELDCAT TO GT_FIELDCAT.



    CLEAR : GS_FIELDCAT.

    GS_FIELDCAT-COL_POS = 8.

    GS_FIELDCAT-FIELDNAME = 'ZRANK'.

    GS_FIELDCAT-SELTEXT_M = '####'.

    APPEND GS_FIELDCAT TO GT_FIELDCAT.



    LV_MONTH_TEXT = |{ P_MONTH }# ###|.

    CLEAR : GS_FIELDCAT.

    GS_FIELDCAT-COL_POS = 9.

    GS_FIELDCAT-FIELDNAME = 'ZPAY_MONTH'.

    GS_FIELDCAT-SELTEXT_M = LV_MONTH_TEXT.

    GS_FIELDCAT-DO_SUM = 'X'.

    GS_FIELDCAT-CURRENCY = 'KRW'.

    APPEND GS_FIELDCAT TO GT_FIELDCAT.

  ENDIF.





ENDFORM.




*&---------------------------------------------------------------------*

*&      Form  CALL_ALV

*&---------------------------------------------------------------------*




FORM CALL_ALV USING PT_TABLE TYPE STANDARD TABLE.



  CALL FUNCTION 'REUSE_ALV_GRID_DISPLAY'

   EXPORTING

     IS_LAYOUT   = GS_LAYOUT

     IT_FIELDCAT = GT_FIELDCAT

     IT_SORT = GT_SORT

   TABLES

     T_OUTTAB   = PT_TABLE.

ENDFORM.






*&---------------------------------------------------------------------*

*&      Form  ALV_LAYOUT

*&---------------------------------------------------------------------*




FORM ALV_LAYOUT .

  GS_LAYOUT-ZEBRA = 'X'.

ENDFORM.




*&---------------------------------------------------------------------*

*&      Form  ALV_DISPLAY

*&---------------------------------------------------------------------*




FORM ALV_DISPLAY USING PT_TABLE TYPE STANDARD TABLE.



  PERFORM FIELD_CATALOG.

  PERFORM ALV_LAYOUT.

  PERFORM ALV_SORT.

  PERFORM CALL_ALV USING PT_TABLE.



ENDFORM.




*&---------------------------------------------------------------------*

*&      Form  ALV_SORT

*&---------------------------------------------------------------------*




FORM ALV_SORT .

    GS_SORT-SPOS = 1.

    GS_SORT-FIELDNAME = 'ZPERNR'.

    GS_SORT-UP = 'X'. "##

    APPEND GS_SORT TO GT_SORT.

ENDFORM.




*&---------------------------------------------------------------------*

*&      Form  MODIFY_DATA

*&---------------------------------------------------------------------*




" #### ### #### #### #### ###### ## ####

" ## ## ## ##### ## ### ## ## ##

FORM MODIFY_DATA .

  IF P_CH1 = 'X'.                         " ##### ##### ##### #### ## X

    DELETE GT_INFO WHERE ZQFLAG = 'X'.

  ELSE.                                   " ## ### ### ## #### ######## ## X

    DELETE GT_INFO WHERE ZQDATE+4(2) = S_ZDATE-HIGH+4(2).

  ENDIF.



  LOOP AT GT_INFO INTO GS_INFO.

    PERFORM DEP_NAMING USING GS_INFO-ZDEPCODE GS_INFO-ZDEPRANK              "### ### ## ####

                       CHANGING GS_INFO-ZDEPCODE_NAME GS_INFO-ZDEPRANK_NAME.





    CASE GS_INFO-ZQFLAG.

      WHEN 'X'.

        GS_INFO-ZQFLAG_NAME = '##'.

      WHEN OTHERS.

        GS_INFO-ZQFLAG_NAME = '##'.

    ENDCASE.



    CASE GS_INFO-ZGENDER.

      WHEN 'M'.

        GS_INFO-ZGENDER_NAME = '##'.

      WHEN 'F'.

        GS_INFO-ZGENDER_NAME = '##'.

    ENDCASE.



    CASE GS_INFO-ZBANKCODE.

      WHEN '001'.

        GS_INFO-ZBANKCODE_NAME = '##'.

      WHEN '002'.

        GS_INFO-ZBANKCODE_NAME = '##'.

      WHEN '003'.

        GS_INFO-ZBANKCODE_NAME = '##'.

      WHEN '004'.

        GS_INFO-ZBANKCODE_NAME = '##'.

      WHEN '005'.

        GS_INFO-ZBANKCODE_NAME = '###'.

    ENDCASE.



    MODIFY GT_INFO FROM GS_INFO.



  ENDLOOP.



ENDFORM.




*&---------------------------------------------------------------------*

*&      Form  MODIFY_PAY_DATA

*&---------------------------------------------------------------------*




" ##### ###### #### ####

FORM MODIFY_PAY_DATA .

  IF P_CH1 = 'X'.                         " ##### ##### ##### #### ## X

    DELETE GT_PAY_INFO WHERE ZQFLAG = 'X'.

  ELSE.                                   " ## ### ### ## #### ######## ## X

    DELETE GT_PAY_INFO WHERE ZQDATE+4(2) = S_ZDATE-HIGH+4(2).

  ENDIF.



  LOOP AT GT_PAY_INFO INTO GS_PAY_INFO.   "

    SELECT SINGLE ZRANK FROM ZEDT01_104 INTO GS_PAY_INFO-ZRANK " ## DB# ####

      WHERE ZPERNR = GS_PAY_INFO-ZPERNR.



    CASE P_MONTH.  " #### ## ## ### ## ##

      WHEN '1'.

        GS_PAY_INFO-ZPAY_MONTH = GS_PAY_INFO-ZMON01.

      WHEN '2'.

        GS_PAY_INFO-ZPAY_MONTH = GS_PAY_INFO-ZMON02.

      WHEN '3'.

        GS_PAY_INFO-ZPAY_MONTH = GS_PAY_INFO-ZMON03.

      WHEN '4'.

        GS_PAY_INFO-ZPAY_MONTH = GS_PAY_INFO-ZMON04.

      WHEN '5'.

        GS_PAY_INFO-ZPAY_MONTH = GS_PAY_INFO-ZMON05.

      WHEN '6'.

        GS_PAY_INFO-ZPAY_MONTH = GS_PAY_INFO-ZMON06.

      WHEN '7'.

        GS_PAY_INFO-ZPAY_MONTH = GS_PAY_INFO-ZMON07.

      WHEN '8'.

        GS_PAY_INFO-ZPAY_MONTH = GS_PAY_INFO-ZMON08.

      WHEN '9'.

        GS_PAY_INFO-ZPAY_MONTH = GS_PAY_INFO-ZMON09.

      WHEN '10'.

        GS_PAY_INFO-ZPAY_MONTH = GS_PAY_INFO-ZMON10.

      WHEN '11'.

        GS_PAY_INFO-ZPAY_MONTH = GS_PAY_INFO-ZMON11.

      WHEN '12'.

        GS_PAY_INFO-ZPAY_MONTH = GS_PAY_INFO-ZMON12.

    ENDCASE.



    PERFORM DEP_NAMING USING GS_PAY_INFO-ZDEPCODE GS_PAY_INFO-ZDEPRANK    "##### #### ## ## ##

                   CHANGING GS_PAY_INFO-ZDEPCODE_NAME GS_PAY_INFO-ZDEPRANK_NAME.



    MODIFY GT_PAY_INFO FROM GS_PAY_INFO.

  ENDLOOP.

  DELETE GT_PAY_INFO WHERE ZPAY_MONTH = 0. "### ### 0# ## ## X

ENDFORM.




*&---------------------------------------------------------------------*

*&      Form  MODIFY_PAY

*&---------------------------------------------------------------------*




" ### #### ####

FORM MODIFY_PAY .

  LOOP AT GT_PAY_INFO INTO GS_PAY_INFO.



    SELECT SINGLE ZRANK FROM ZEDT01_104 INTO GS_PAY_INFO-ZRANK "#### ##### ###

      WHERE ZPERNR = GS_PAY_INFO-ZPERNR.



    IF GS_PAY_INFO-ZRANK IS INITIAL. "## ### #### #### ##

      CONTINUE.

    ENDIF.



    IF GS_PAY_INFO-ZYEAR <> P_YEAR. "#### ### #### #### ##

      MESSAGE W005.

      EXIT.

    ENDIF.



    IF GS_PAY_INFO-ZQFLAG = 'X'.   " ####### #### ## ### ##

      CHECK GS_PAY_INFO-ZQDATE+4(2) > P_MONTH. " ##### #### #### ### # #### #### ## X

    ELSEIF GS_PAY_INFO-ZEDATE+4(2) > P_MONTH. " ##### #### #### ## ## X

      CONTINUE.

    ENDIF.



    CLEAR GS_PAY.                   " ZEDT105# ###### ### ###

    MOVE-CORRESPONDING GS_PAY_INFO TO GS_PAY. "#### ## #### ## ##

    GS_PAY-ZYEAR = GS_PAY_INFO-ZYEAR.         " ### ## ## ## ##

    LV_MONTH_PAY = GS_PAY_INFO-ZSALARY  / 12. " ## / 12# #### ##



    IF GS_PAY_INFO-ZRANK IN GR_RANK.          " #### ##### GR_RANK# ##### ( ## A## A ##)

      LV_MONTH_PAY = LV_MONTH_PAY + LV_PAY_RATE_A. " 500# ## ( 50000#)

    ENDIF.

  " #### ### ### ### ### ##

    GS_PAY-ZPERNR = GS_PAY_INFO-ZPERNR.

    GS_PAY-ZYEAR = GS_PAY_INFO-ZYEAR.

    GS_PAY-AEDATE = SY-DATUM.

    GS_PAY-AENAME = SY-UNAME.

  " ##### ## ## ### ##,

  " # CHECK_UPDATE ###### 0# ###### ## ## ###### ###### ## #### ##

    CASE P_MONTH.

      WHEN '1'.

        PERFORM CHECK_UPDATE USING GS_PAY-ZMON01 LV_MONTH_PAY.

        GS_PAY-ZMON01 = LV_MONTH_PAY.

      WHEN '2'.

        PERFORM CHECK_UPDATE USING GS_PAY-ZMON02 LV_MONTH_PAY.

        GS_PAY-ZMON02 = LV_MONTH_PAY.

      WHEN '3'.

        PERFORM CHECK_UPDATE USING GS_PAY-ZMON03 LV_MONTH_PAY.

        GS_PAY-ZMON03 = LV_MONTH_PAY.

      WHEN '4'.

        PERFORM CHECK_UPDATE USING GS_PAY-ZMON04 LV_MONTH_PAY.

        GS_PAY-ZMON04 = LV_MONTH_PAY.

      WHEN '5'.

        PERFORM CHECK_UPDATE USING GS_PAY-ZMON05 LV_MONTH_PAY.

        GS_PAY-ZMON05 = LV_MONTH_PAY.

      WHEN '6'.

        PERFORM CHECK_UPDATE USING GS_PAY-ZMON06 LV_MONTH_PAY.

        GS_PAY-ZMON06 = LV_MONTH_PAY.

      WHEN '7'.

        PERFORM CHECK_UPDATE USING GS_PAY-ZMON07 LV_MONTH_PAY.

        GS_PAY-ZMON07 = LV_MONTH_PAY.

      WHEN '8'.

        PERFORM CHECK_UPDATE USING GS_PAY-ZMON08 LV_MONTH_PAY.

        GS_PAY-ZMON08 = LV_MONTH_PAY.

      WHEN '9'.

        PERFORM CHECK_UPDATE USING GS_PAY-ZMON09 LV_MONTH_PAY.

        GS_PAY-ZMON09 = LV_MONTH_PAY.

      WHEN '10'.

        PERFORM CHECK_UPDATE USING GS_PAY-ZMON10 LV_MONTH_PAY.

        GS_PAY-ZMON10 = LV_MONTH_PAY.

      WHEN '11'.

        PERFORM CHECK_UPDATE USING GS_PAY-ZMON11 LV_MONTH_PAY.

        GS_PAY-ZMON11 = LV_MONTH_PAY.

      WHEN '12'.

        PERFORM CHECK_UPDATE USING GS_PAY-ZMON12 LV_MONTH_PAY.

        GS_PAY-ZMON12 = LV_MONTH_PAY.

    ENDCASE.

    MODIFY ZEDT01_105 FROM GS_PAY.



    IF SY-SUBRC = 0. " MODIFY ##### ##

      MESSAGE S002. " ### #### #### ### ##

    ELSE.

      MESSAGE S003. " ##### ##### ##

    ENDIF.



  ENDLOOP.



ENDFORM.




*&---------------------------------------------------------------------*

*&      Form  GET_DATA_INFO

*&---------------------------------------------------------------------*




"#### #### #### #### #### ###### ##

" ###### ##### DATBI # DATAB# S_ZDATE LOW HIGH# #### #### ###

FORM GET_DATA_INFO .



    SELECT A~ZPERNR, B~ZPNAME, A~ZDEPRANK, A~ZDEPCODE,

           A~ZEDATE, A~ZQDATE, A~ZQFLAG, B~ZGENDER,

           B~ZADDRESS, C~ZBANKCODE, C~ZACCOUNT

      INTO CORRESPONDING FIELDS OF TABLE @GT_INFO

      FROM ZEDT01_102 AS A

      LEFT OUTER JOIN ZEDT01_103 AS B

        ON A~ZPERNR = B~ZPERNR

      LEFT OUTER JOIN ZEDT01_106 AS C

        ON A~ZPERNR = C~ZPERNR

     WHERE A~ZPERNR IN @S_ZPERNR

       AND A~DATBI >= @S_ZDATE-LOW

       AND A~DATAB >= @S_ZDATE-HIGH.



    IF GT_INFO[] IS INITIAL.

      MESSAGE E001.

      STOP.

    ENDIF.

ENDFORM.




*&---------------------------------------------------------------------*

*&      Form  GET_DATA_PAY

*&---------------------------------------------------------------------*




"#### #### #### #### #### ###### ##

FORM GET_DATA_PAY .

    SELECT  A~ZPERNR,      B~ZPNAME,      A~ZDEPRANK,    A~ZDEPCODE,

          A~ZEDATE,      A~ZQDATE,      A~ZQFLAG,      C~ZSALARY,

          C~ZYEAR ,

          D~ZMON01 ,     D~ZMON02 ,      D~ZMON03 ,      D~ZMON04 ,

          D~ZMON05 ,      D~ZMON06 ,      D~ZMON07 ,      D~ZMON08 ,

          D~ZMON09 ,      D~ZMON10 ,      D~ZMON11 ,      D~ZMON12

    INTO CORRESPONDING FIELDS OF TABLE @GT_PAY_INFO

    FROM ZEDT01_102 AS A

    LEFT OUTER JOIN ZEDT01_103 AS B

    ON A~ZPERNR = B~ZPERNR

    LEFT OUTER JOIN ZEDT01_106 AS C

    ON A~ZPERNR = C~ZPERNR

    INNER JOIN ZEDT01_105 AS D

    ON A~ZPERNR = D~ZPERNR.



    IF GT_PAY_INFO[] IS INITIAL.

      MESSAGE E001.

      STOP.

    ENDIF.



ENDFORM.




*&---------------------------------------------------------------------*

*&      Form  DEP_NAMING

*&---------------------------------------------------------------------*




" #### #### ## ### #### ####

FORM DEP_NAMING USING P_DEPCODE P_DEPRANK

                CHANGING P_DEPCODE_NAME P_DEPRANK_NAME.

    CASE P_DEPCODE.

      WHEN 'SS0001'.

        P_DEPCODE_NAME = '###'.

      WHEN 'SS0002'.

        P_DEPCODE_NAME = '###'.

      WHEN 'SS0003'.

        P_DEPCODE_NAME = '###'.

      WHEN 'SS0004'.

        P_DEPCODE_NAME = '###'.

      WHEN 'SS0005'.

        P_DEPCODE_NAME = '###'.

      WHEN 'SS0006'.

        P_DEPCODE_NAME = '###'.

    ENDCASE.



   CASE P_DEPRANK.

      WHEN 'A'.

        P_DEPRANK_NAME = '##'.

      WHEN 'B'.

        P_DEPRANK_NAME = '##'.

      WHEN 'C'.

        P_DEPRANK_NAME = '##'.

      WHEN 'D'.

        P_DEPRANK_NAME = '##'.

      WHEN 'E'.

        P_DEPRANK_NAME = '##'.

      WHEN 'F'.

        P_DEPRANK_NAME = '##'.

      WHEN 'G'.

        P_DEPRANK_NAME = '##'.

    ENDCASE.



ENDFORM.




*&---------------------------------------------------------------------*

*&      Form  CHECK_UPDATE

*&---------------------------------------------------------------------*




" #### ##### ## ### ## ## 0#### ### ## ##### ##### ## ## #### ## ##

FORM CHECK_UPDATE  USING    P_ZMONTH_PAY

                            P_MONTH_PAY.

  IF ( P_ZMONTH_PAY = P_MONTH_PAY ) OR ( P_MONTH_PAY = 0 ).

    MESSAGE E004.

  ENDIF.

ENDFORM.