
*&---------------------------------------------------------------------*

*& Report ZEDR02_PRACTICE006

*&---------------------------------------------------------------------*

*&

*&---------------------------------------------------------------------*




REPORT ZEDR02_PRACTICE006 MESSAGE-ID ZMED02. "### ##



"### ####

TABLES : ZEDT02_102, ZEDT02_103, ZEDT02_104, ZEDT02_105, ZEDT02_106.



"ZEDT02_105# #### ## ### ### ##

DATA: BEGIN OF GS_SALARY.

  include structure
ZEDT02_105
.

DATA : END OF GS_SALARY.

DATA : GT_SALARY LIKE TABLE OF GS_SALARY.



"#### ### ### ## #### ## ### ### ##

DATA: BEGIN OF GS_EMP_INFO,

  ZPERNR LIKE ZEDT02_102-ZPERNR, "####

  ZPNAME LIKE ZEDT02_103-ZPNAME, "####

  ZDEPCODE LIKE ZEDT02_102-ZDEPCODE, "####

  ZDEPRANK LIKE ZEDT02_102-ZDEPRANK, "####

  ZEDATE LIKE ZEDT02_102-ZEDATE, "###

  ZQFLAG LIKE ZEDT02_102-ZQFLAG, "####

  ZGENDER LIKE ZEDT02_103-ZGENDER, "##

  ZADDRESS LIKE ZEDT02_103-ZADDRESS, "##

  ZBANKCODE LIKE ZEDT02_106-ZBANKCODE, "####

  ZACCOUNT LIKE ZEDT02_106-ZACCOUNT, "####

  DATBI LIKE ZEDT02_102-DATBI, "####_FR

  DATAB LIKE ZEDT02_102-DATAB, "####_TO

  ZQDATE LIKE ZEDT02_102-ZQDATE, "####

END OF GS_EMP_INFO.

DATA : GT_EMP_INFO LIKE TABLE OF GS_EMP_INFO.



"#### #### ### ### ##

DATA: BEGIN OF GS_EMP_INFO_OUTPUT,

  ZPERNR LIKE ZEDT02_102-ZPERNR, "####

  ZPNAME LIKE ZEDT02_103-ZPNAME, "####

  ZDEPCODE LIKE ZEDT02_102-ZDEPCODE, "####

  ZDEPNAME TYPE C LENGTH 10, "###

  ZDEPRANKNAME TYPE C LENGTH 10, "###

  ZEDATE LIKE ZEDT02_102-ZEDATE, "###

  ZQFLAG TYPE C LENGTH 10, "####

  ZGENDER TYPE C LENGTH 10, "##

  ZADDRESS LIKE ZEDT02_103-ZADDRESS, "##

  ZBANKCODE LIKE ZEDT02_106-ZBANKCODE, "####

  ZBANKNAME TYPE C LENGTH 10, "###

  ZACCOUNT LIKE ZEDT02_106-ZACCOUNT, "####

END OF GS_EMP_INFO_OUTPUT.

DATA : GT_EMP_INFO_OUTPUT LIKE TABLE OF GS_EMP_INFO_OUTPUT.



"## ### ### #### ## ### ### ##

DATA: BEGIN OF GS_SAL_PAY,

  ZPERNR LIKE ZEDT02_102-ZPERNR, "####

  ZPNAME LIKE ZEDT02_103-ZPNAME, "####

  ZDEPCODE LIKE ZEDT02_102-ZDEPCODE, "####

  ZDEPRANK LIKE ZEDT02_102-ZDEPRANK, "####

  ZEDATE LIKE ZEDT02_102-ZEDATE, "###

  ZSALARY LIKE ZEDT02_106-ZSALARY, "####

  ZRANK LIKE ZEDT02_104-ZRANK, "####

  ZYEAR LIKE ZEDT02_104-ZYEAR, "##

  DATBI LIKE ZEDT02_102-DATBI, "####_FR

  DATAB LIKE ZEDT02_102-DATAB, "####_TO

END OF GS_SAL_PAY.

DATA : GT_SAL_PAY LIKE TABLE OF GS_SAL_PAY.



"## ### ### #### ## ### ### ##

DATA: BEGIN OF GS_EVAL_RESULT,

  ZPERNR LIKE ZEDT02_102-ZPERNR, "####

  ZPNAME LIKE ZEDT02_103-ZPNAME, "####

  ZDEPCODE LIKE ZEDT02_102-ZDEPCODE, "####

  ZDEPRANK LIKE ZEDT02_102-ZDEPRANK, "####

  ZEDATE LIKE ZEDT02_102-ZEDATE, "###

  ZSALARY LIKE ZEDT02_106-ZSALARY, "####

  ZRANK LIKE ZEDT02_104-ZRANK, "####

  ZMON LIKE ZEDT02_105-ZMON01, "N###

END OF GS_EVAL_RESULT.

DATA : GT_EVAL_RESULT LIKE TABLE OF GS_EVAL_RESULT.



"## ## #### ### ### ##

DATA: BEGIN OF GS_EVAL_RESULT_OUTPUT,

  ZPERNR LIKE ZEDT02_102-ZPERNR, "####

  ZPNAME LIKE ZEDT02_103-ZPNAME, "####

  ZDEPCODE LIKE ZEDT02_102-ZDEPCODE, "####

  ZDEPNAME TYPE C LENGTH 10, "###

  ZDEPRANKNAME TYPE C LENGTH 10, "###

  ZEDATE LIKE ZEDT02_102-ZEDATE, "###

  ZSALARY LIKE ZEDT02_106-ZSALARY, "####

  ZRANK LIKE ZEDT02_104-ZRANK, "####

  ZMON LIKE ZEDT02_105-ZMON01, "N####

END OF GS_EVAL_RESULT_OUTPUT.

DATA : GT_EVAL_RESULT_OUTPUT LIKE TABLE OF GS_EVAL_RESULT_OUTPUT.



SELECTION-SCREEN BEGIN OF BLOCK B1 WITH FRAME.

  SELECT-OPTIONS : S_ZPERNR FOR ZEDT02_102-ZPERNR. "####

  SELECT-OPTIONS : S_DATE FOR SY-DATUM MODIF ID M1. "##

  PARAMETERS : P_DEPCO TYPE ZEDT02_102-ZDEPCODE MODIF ID M1. "####

  PARAMETERS : P_YEAR TYPE GJAHR MODIF ID M2 DEFAULT SY-DATUM(4). "##

  PARAMETERS : P_MONTH TYPE MONAT MODIF ID M2 DEFAULT SY-DATUM+4(2). "#

SELECTION-SCREEN END OF BLOCK B1.



SELECTION-SCREEN BEGIN OF BLOCK B2 WITH FRAME.

  PARAMETERS : P_EMP RADIOBUTTON GROUP R1 DEFAULT 'X' USER-COMMAND UC1. "####

  PARAMETERS : P_SAL RADIOBUTTON GROUP R1. "####

  PARAMETERS : P_EVAL RADIOBUTTON GROUP R1. "####

SELECTION-SCREEN END OF BLOCK B2.



SELECTION-SCREEN BEGIN OF BLOCK B3 WITH FRAME.

  PARAMETERS : P_RE AS CHECKBOX DEFAULT 'X' MODIF ID M1. "####

SELECTION-SCREEN END OF BLOCK B3.



RANGES : GR_DEPCODE FOR ZEDT02_102-ZDEPCODE, "####

         GR_OFFICE FOR ZEDT02_102-ZQFLAG. "####



DATA: GV_LAST_DAY TYPE SY-DATUM. "## ## ### #

DATA: GV_SUBRC TYPE I. "UPDATE ### ## ##

DATA: GS_FIELDCAT TYPE SLIS_FIELDCAT_ALV. "###### ###

DATA: GT_FIELDCAT TYPE SLIS_T_FIELDCAT_ALV. "###### ###

DATA : GS_LAYOUT TYPE SLIS_LAYOUT_ALV. "ALV ####

DATA: GS_SORT TYPE SLIS_SORTINFO_ALV. "ALV SORT ###

DATA: GT_SORT TYPE SLIS_T_SORTINFO_ALV. "ALV SORT ###



CONSTANTS: GC_A_BONUS TYPE BSEG-DMBTR VALUE 500, "##### A# # ### 5##

           GC_ALV_RIGHT_ALIGN TYPE C LENGTH 1 VALUE 'R', "###### ## ##

           GC_ALV_CURRENCY TYPE SLIS_FIELDCAT_ALV-CURRENCY VALUE 'KRW'. "## #### ##



INITIALIZATION. "### ##

S_DATE-LOW = '20250101'.

CONCATENATE P_YEAR P_MONTH '01' INTO GV_LAST_DAY.

CALL FUNCTION 'LAST_DAY_OF_MONTHS' "### # ##

  EXPORTING

    DAY_IN                  = GV_LAST_DAY

 IMPORTING

   LAST_DAY_OF_MONTH       = GV_LAST_DAY.

S_DATE-HIGH = GV_LAST_DAY.

APPEND S_DATE.



AT SELECTION-SCREEN.

  IF P_EMP = 'X'. "####

    IF S_DATE IS INITIAL. "### ### ##### ##

      MESSAGE E000.

    ENDIF.

  ELSEIF P_SAL = 'X' OR P_EVAL = 'X'. "#### ####

    IF P_YEAR IS INITIAL OR P_MONTH IS INITIAL. "# ## # # #### ##### ##

      MESSAGE E000.

    ENDIF.

  ENDIF.



AT SELECTION-SCREEN OUTPUT.

  LOOP AT SCREEN.

    IF SCREEN-GROUP1 = 'M1'. "####->##, ####, ####

      IF P_EMP = 'X'.

        SCREEN-ACTIVE = '1'.

      ELSEIF P_SAL = 'X' OR P_EVAL = 'X'.

        SCREEN-ACTIVE = '0'.

      ENDIF.

    ENDIF.

    IF SCREEN-GROUP1 = 'M2'. "####, ####->##, #

      IF P_EMP = 'X'.

        SCREEN-ACTIVE = '0'.

      ELSEIF P_SAL = 'X' OR P_EVAL = 'X'.

        SCREEN-ACTIVE = '1'.

      ENDIF.

    ENDIF.

    MODIFY SCREEN.

  ENDLOOP.



START-OF-SELECTION.

IF P_EMP = 'X'.

  PERFORM GET_EMP_DATA . "#### ### ### #### ## ##

  PERFORM MODIFY_EMP_DATA USING GT_EMP_INFO. "#### ### ## #### #### ## ##

  PERFORM ALV_DISPLAY_EMP . "#### #### ##

ELSEIF P_SAL = 'X'.

  PERFORM GET_EVAL_DATA. "##### ##### ### #### ## ##

  PERFORM UPDATE_SALARY CHANGING GV_SUBRC. "### #### ZEDT02_105# #### ##

  IF GV_SUBRC = 0.

    MESSAGE S002. "###

  ELSE.

    MESSAGE E003. "###

  ENDIF.

ELSEIF P_EVAL = 'X'.

  PERFORM GET_EVAL_DATA.

  PERFORM MODIFY_EVAL_DATA. "#### ### ## #### #### ## ##

  PERFORM ALV_DISPLAY_EVAL. "#### #### ##



ENDIF.






*&---------------------------------------------------------------------*

*&      Form  GET_EMP_DATA

*&---------------------------------------------------------------------*

*       text

*----------------------------------------------------------------------*

*  -->  p1        text

*  <--  p2        text

*----------------------------------------------------------------------*






FORM GET_EMP_DATA .



  IF P_DEPCO IS NOT INITIAL. "##### ### ### ##### #### #### ### RANGE ### ##

    GR_DEPCODE-OPTION = 'EQ'.

    GR_DEPCODE-LOW = P_DEPCO.

    GR_DEPCODE-SIGN = 'I'.

    APPEND GR_DEPCODE.

  ENDIF.



  IF P_RE = 'X'. "##### ##### #### #### ## ### ##

    GR_OFFICE-OPTION = 'NE'.

    GR_OFFICE-SIGN = 'I'.

    GR_OFFICE-LOW = 'X'.

    APPEND GR_OFFICE.

  ENDIF.



  SELECT A~ZPERNR "####

         B~ZPNAME "####

         A~ZDEPCODE "####

         A~ZDEPRANK "####

         A~ZEDATE "###

         A~ZQFLAG "####

         B~ZGENDER "##

         B~ZADDRESS "##

         C~ZBANKCODE "####

         C~ZACCOUNT "####

         A~DATBI "####_FR

         A~DATAB "####_TO

         A~ZQDATE "####

    INTO CORRESPONDING FIELDS OF TABLE GT_EMP_INFO

    FROM ZEDT02_102 AS A "#### ###

    LEFT OUTER JOIN ZEDT02_103 AS B ON A~ZPERNR = B~ZPERNR "####-#### ###

    LEFT OUTER JOIN ZEDT02_106 AS C ON A~ZPERNR = C~ZPERNR. "#### ###



    DELETE GT_EMP_INFO WHERE ZDEPCODE NOT IN GR_DEPCODE. "##### #### ##, ### ### ## ### ##

    DELETE GT_EMP_INFO WHERE ZQFLAG NOT IN GR_OFFICE. "#### ### ### X, ### ### ##

    DELETE GT_EMP_INFO WHERE DATAB < S_DATE-LOW. "## ## ##### ### ##

    DELETE GT_EMP_INFO WHERE DATBI > S_DATE-HIGH.

    DELETE GT_EMP_INFO WHERE ZPERNR NOT IN S_ZPERNR. "##### #### ##, ### ## ## ## ## ### ##

    DELETE GT_EMP_INFO WHERE ZQDATE IS NOT INITIAL AND ZQDATE >= S_DATE-LOW AND ZQDATE <= S_DATE-HIGH. "## ## ### ### ##

    IF GT_EMP_INFO IS INITIAL.

      MESSAGE S001 DISPLAY LIKE 'E'. "### #### ### ##

      STOP.

    ENDIF.



ENDFORM.




*&---------------------------------------------------------------------*

*&      Form  MODIFY_EMP_DATA

*&---------------------------------------------------------------------*

*       text

*----------------------------------------------------------------------*

*  -->  p1        text

*  <--  p2        text

*----------------------------------------------------------------------*




FORM MODIFY_EMP_DATA USING GT_EMP_INFO LIKE GT_EMP_INFO.



  LOOP AT GT_EMP_INFO INTO GS_EMP_INFO.

    CLEAR : GS_EMP_INFO_OUTPUT.

    GS_EMP_INFO_OUTPUT-ZPERNR = GS_EMP_INFO-ZPERNR. "####

    GS_EMP_INFO_OUTPUT-ZPNAME = GS_EMP_INFO-ZPNAME. "####

    GS_EMP_INFO_OUTPUT-ZDEPCODE = GS_EMP_INFO-ZDEPCODE. "####

    CASE: GS_EMP_INFO_OUTPUT-ZDEPCODE. "###

      WHEN 'SS0001'. GS_EMP_INFO_OUTPUT-ZDEPNAME = '###'.

      WHEN 'SS0002'. GS_EMP_INFO_OUTPUT-ZDEPNAME = '###'.

      WHEN 'SS0003'. GS_EMP_INFO_OUTPUT-ZDEPNAME = '###'.

      WHEN 'SS0004'. GS_EMP_INFO_OUTPUT-ZDEPNAME = '###'.

      WHEN 'SS0005'. GS_EMP_INFO_OUTPUT-ZDEPNAME = '###'.

      WHEN 'SS0006'. GS_EMP_INFO_OUTPUT-ZDEPNAME = '###'.

    ENDCASE.

    CASE: GS_EMP_INFO-ZDEPRANK. "###

      WHEN 'A'. GS_EMP_INFO_OUTPUT-ZDEPRANKNAME = '##'.

      WHEN 'B'. GS_EMP_INFO_OUTPUT-ZDEPRANKNAME = '##'.

      WHEN 'C'. GS_EMP_INFO_OUTPUT-ZDEPRANKNAME = '##'.

      WHEN 'D'. GS_EMP_INFO_OUTPUT-ZDEPRANKNAME = '##'.

      WHEN 'E'. GS_EMP_INFO_OUTPUT-ZDEPRANKNAME = '##'.

      WHEN 'F'. GS_EMP_INFO_OUTPUT-ZDEPRANKNAME = '##'.

      WHEN 'G'. GS_EMP_INFO_OUTPUT-ZDEPRANKNAME = '##'.

    ENDCASE.

    GS_EMP_INFO_OUTPUT-ZEDATE = GS_EMP_INFO-ZEDATE. "###

    CASE: GS_EMP_INFO-ZQFLAG. "####

      WHEN 'X'. GS_EMP_INFO_OUTPUT-ZQFLAG = '##'.

      WHEN OTHERS. GS_EMP_INFO_OUTPUT-ZQFLAG = '##'.

    ENDCASE.

    CASE : GS_EMP_INFO-ZGENDER. "##

      WHEN 'M'. GS_EMP_INFO_OUTPUT-ZGENDER = '##'.

      WHEN 'F'. GS_EMP_INFO_OUTPUT-ZGENDER = '##'.

    ENDCASE.

    GS_EMP_INFO_OUTPUT-ZADDRESS = GS_EMP_INFO-ZADDRESS. "##

    GS_EMP_INFO_OUTPUT-ZBANKCODE = GS_EMP_INFO-ZBANKCODE. "####

    CASE : GS_EMP_INFO-ZBANKCODE. "###

      WHEN '001'. GS_EMP_INFO_OUTPUT-ZBANKNAME = '##'.

      WHEN '002'. GS_EMP_INFO_OUTPUT-ZBANKNAME = '##'.

      WHEN '003'. GS_EMP_INFO_OUTPUT-ZBANKNAME = '##'.

      WHEN '004'. GS_EMP_INFO_OUTPUT-ZBANKNAME = '##'.

      WHEN '005'. GS_EMP_INFO_OUTPUT-ZBANKNAME = '###'.

    ENDCASE.

    GS_EMP_INFO_OUTPUT-ZACCOUNT = GS_EMP_INFO-ZACCOUNT. "####



    APPEND GS_EMP_INFO_OUTPUT TO GT_EMP_INFO_OUTPUT.

  ENDLOOP.



ENDFORM.




*&---------------------------------------------------------------------*

*&      Form  ALV_DISPLAY_EMP

*&---------------------------------------------------------------------*

*       text

*----------------------------------------------------------------------*

*  -->  p1        text

*  <--  p2        text

*----------------------------------------------------------------------*




FORM ALV_DISPLAY_EMP.



  CLEAR : GS_FIELDCAT, GT_FIELDCAT.

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

  GS_FIELDCAT-FIELDNAME = 'ZDEPNAME'.

  GS_FIELDCAT-SELTEXT_M = '###'.

  APPEND GS_FIELDCAT TO GT_FIELDCAT.



  CLEAR : GS_FIELDCAT.

  GS_FIELDCAT-COL_POS = 5.

  GS_FIELDCAT-FIELDNAME = 'ZDEPRANKNAME'.

  GS_FIELDCAT-SELTEXT_M = '###'.

  APPEND GS_FIELDCAT TO GT_FIELDCAT.



  CLEAR : GS_FIELDCAT.

  GS_FIELDCAT-COL_POS = 6.

  GS_FIELDCAT-FIELDNAME = 'ZEDATE'.

  GS_FIELDCAT-SELTEXT_M = '###'.

  APPEND GS_FIELDCAT TO GT_FIELDCAT.



  CLEAR : GS_FIELDCAT.

  GS_FIELDCAT-COL_POS = 7.

  GS_FIELDCAT-FIELDNAME = 'ZQFLAG'.

  GS_FIELDCAT-SELTEXT_M = '####'.

  APPEND GS_FIELDCAT TO GT_FIELDCAT.



  CLEAR : GS_FIELDCAT.

  GS_FIELDCAT-COL_POS = 8.

  GS_FIELDCAT-FIELDNAME = 'ZGENDER'.

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

  GS_FIELDCAT-FIELDNAME = 'ZBANKNAME'.

  GS_FIELDCAT-SELTEXT_M = '###'.

  APPEND GS_FIELDCAT TO GT_FIELDCAT.



  CLEAR : GS_FIELDCAT.

  GS_FIELDCAT-COL_POS = 11.

  GS_FIELDCAT-FIELDNAME = 'ZACCOUNT'.

  GS_FIELDCAT-SELTEXT_M = '####'.

  APPEND GS_FIELDCAT TO GT_FIELDCAT.



  GS_LAYOUT-ZEBRA = 'X'. "## ## ## ### ### ##

  GS_SORT-SPOS = '1'. "####

  GS_SORT-FIELDNAME = 'ZPERNR'. "##### #### ##

  GS_SORT-UP = 'X'. "####

  APPEND GS_SORT TO GT_SORT.

  CALL FUNCTION 'REUSE_ALV_GRID_DISPLAY'

    EXPORTING

      IS_LAYOUT                         = GS_LAYOUT

      IT_FIELDCAT                       = GT_FIELDCAT

      IT_SORT                           = GT_SORT

    TABLES

      T_OUTTAB                          = GT_EMP_INFO_OUTPUT.



  IF SY-SUBRC <> 0.

    STOP.

  ENDIF.



ENDFORM.




*&---------------------------------------------------------------------*

*&      Form  UPDATE_SALARY

*&---------------------------------------------------------------------*

*       text

*----------------------------------------------------------------------*

*  -->  p1        text

*  <--  p2        text

*----------------------------------------------------------------------*




FORM UPDATE_SALARY CHANGING GV_SUBRC TYPE I.



  DATA : LV_SAL TYPE BSEG-DMBTR. "### ## #### ##

  LOOP AT GT_SAL_PAY INTO GS_SAL_PAY.

    CLEAR: GS_SALARY.

    LV_SAL = GS_SAL_PAY-ZSALARY / 12.

    IF GS_SAL_PAY-ZRANK = 'A'. "##### A# ### ##

      LV_SAL = LV_SAL + GC_A_BONUS.

    ENDIF.



    CHECK LV_SAL <> 0. "### 0# #### LOOP# ## ##



    SELECT SINGLE *

      FROM ZEDT02_105

      INTO GS_SALARY

      WHERE ZPERNR = GS_SAL_PAY-ZPERNR

      AND ZYEAR  = GS_SAL_PAY-ZYEAR.



    GS_SALARY-AENAME = SY-UNAME. "###

    GS_SALARY-AEDATE = SY-DATUM. "###

    GS_SALARY-AEZEIT = SY-UZEIT. "####



    CASE : P_MONTH.

      WHEN '01'. GS_SALARY-ZMON01 = LV_SAL.

      WHEN '02'. GS_SALARY-ZMON02 = LV_SAL.

      WHEN '03'. GS_SALARY-ZMON03 = LV_SAL.

      WHEN '04'. GS_SALARY-ZMON04 = LV_SAL.

      WHEN '05'. GS_SALARY-ZMON05 = LV_SAL.

      WHEN '06'. GS_SALARY-ZMON06 = LV_SAL.

      WHEN '07'. GS_SALARY-ZMON07 = LV_SAL.

      WHEN '08'. GS_SALARY-ZMON08 = LV_SAL.

      WHEN '09'. GS_SALARY-ZMON09 = LV_SAL.

      WHEN '10'. GS_SALARY-ZMON10 = LV_SAL.

      WHEN '11'. GS_SALARY-ZMON11 = LV_SAL.

      WHEN '12'. GS_SALARY-ZMON12 = LV_SAL.

    ENDCASE.



    UPDATE ZEDT02_105 FROM GS_SALARY.



    GV_SUBRC = SY-SUBRC.

    IF SY-SUBRC <> 0. "#### ### ## ##

      EXIT.

    ENDIF.

  ENDLOOP.



ENDFORM.




*&---------------------------------------------------------------------*

*&      Form  GET_EVAL_DATA

*&---------------------------------------------------------------------*

*       text

*----------------------------------------------------------------------*

*  -->  p1        text

*  <--  p2        text

*----------------------------------------------------------------------*




FORM GET_EVAL_DATA.



  DATA: LV_FIRST_DAY TYPE DATUM, "## ## ## ### #

        LV_LAST_DAY TYPE DATUM. "## ## ## ### #

  CONCATENATE P_YEAR P_MONTH '01' INTO LV_FIRST_DAY.

  CALL FUNCTION 'LAST_DAY_OF_MONTHS' "#### ## ##

  EXPORTING

    DAY_IN                  = LV_FIRST_DAY

  IMPORTING

   LAST_DAY_OF_MONTH       = LV_LAST_DAY.



  SELECT A~ZPERNR "####

         B~ZPNAME "####

         A~ZDEPCODE "####

         A~ZDEPRANK "###

         A~ZEDATE "###

         D~ZSALARY "####

         C~ZRANK "####

         C~ZYEAR "##

         A~DATBI "####_FR

         A~DATAB "####_TO

    INTO CORRESPONDING FIELDS OF TABLE GT_SAL_PAY

    FROM ZEDT02_102 AS A "#### ###

    LEFT OUTER JOIN ZEDT02_103 AS B ON A~ZPERNR = B~ZPERNR "####-#### ###

    LEFT OUTER JOIN ZEDT02_104 AS C ON A~ZPERNR = C~ZPERNR "#### ###

    LEFT OUTER JOIN ZEDT02_106 AS D ON A~ZPERNR = D~ZPERNR. "#### ###

    DELETE GT_SAL_PAY WHERE ZYEAR <> P_YEAR. "ZYEAR #### ##

    DELETE GT_SAL_PAY WHERE ZPERNR NOT IN S_ZPERNR. "ZPERNR #### ## ## ### ### ## ##

    DELETE GT_SAL_PAY WHERE DATBI > LV_FIRST_DAY. "### ### ### ### ##

    DELETE GT_SAL_PAY WHERE DATAB <= LV_LAST_DAY. "##### ### ### ### ##



  IF GT_SAL_PAY IS INITIAL.

      MESSAGE S001 DISPLAY LIKE 'E'. "### ### ### ####

      STOP.

  ENDIF.



  IF P_EVAL = 'X'. "####



    SELECT * FROM ZEDT02_105 "# SELECT### ### ZPERNR# ZYEAR# ZEDT02_105## ###

      INTO TABLE GT_SALARY

      FOR ALL ENTRIES IN GT_SAL_PAY

      WHERE ZPERNR = GT_SAL_PAY-ZPERNR

      AND ZYEAR = P_YEAR.



    LOOP AT GT_SAL_PAY INTO GS_SAL_PAY.

      CLEAR : GS_EVAL_RESULT.

      READ TABLE GT_SALARY INTO GS_SALARY WITH KEY ZPERNR = GS_SAL_PAY-ZPERNR.



      MOVE-CORRESPONDING GS_SAL_PAY TO GS_EVAL_RESULT. "####->###### ##



      CASE P_MONTH. "## ### ##

        WHEN '01'. GS_EVAL_RESULT-ZMON = GS_SALARY-ZMON01.

        WHEN '02'. GS_EVAL_RESULT-ZMON = GS_SALARY-ZMON02.

        WHEN '03'. GS_EVAL_RESULT-ZMON = GS_SALARY-ZMON03.

        WHEN '04'. GS_EVAL_RESULT-ZMON = GS_SALARY-ZMON04.

        WHEN '05'. GS_EVAL_RESULT-ZMON = GS_SALARY-ZMON05.

        WHEN '06'. GS_EVAL_RESULT-ZMON = GS_SALARY-ZMON06.

        WHEN '07'. GS_EVAL_RESULT-ZMON = GS_SALARY-ZMON07.

        WHEN '08'. GS_EVAL_RESULT-ZMON = GS_SALARY-ZMON08.

        WHEN '09'. GS_EVAL_RESULT-ZMON = GS_SALARY-ZMON09.

        WHEN '10'. GS_EVAL_RESULT-ZMON = GS_SALARY-ZMON10.

        WHEN '11'. GS_EVAL_RESULT-ZMON = GS_SALARY-ZMON11.

        WHEN '12'. GS_EVAL_RESULT-ZMON = GS_SALARY-ZMON12.

      ENDCASE.



      IF GS_EVAL_RESULT-ZMON = 0 OR GS_EVAL_RESULT-ZMON IS INITIAL. "### ##### 0## ##

        CONTINUE.

      ENDIF.



      APPEND GS_EVAL_RESULT TO GT_EVAL_RESULT.



    ENDLOOP.



    IF GT_EVAL_RESULT IS INITIAL.

      MESSAGE S001 DISPLAY LIKE 'E'. "### #### ### ####

      STOP.

    ENDIF.



  ENDIF.

ENDFORM.




*&---------------------------------------------------------------------*

*&      Form  MODIFY_EVAL_DATA

*&---------------------------------------------------------------------*

*       text

*----------------------------------------------------------------------*

*  -->  p1        text

*  <--  p2        text

*----------------------------------------------------------------------*




FORM MODIFY_EVAL_DATA.

  LOOP AT GT_EVAL_RESULT INTO GS_EVAL_RESULT.

    CLEAR : GS_EVAL_RESULT_OUTPUT.

    GS_EVAL_RESULT_OUTPUT-ZPERNR = GS_EVAL_RESULT-ZPERNR. "####

    GS_EVAL_RESULT_OUTPUT-ZPNAME = GS_EVAL_RESULT-ZPNAME. "####

    GS_EVAL_RESULT_OUTPUT-ZDEPCODE = GS_EVAL_RESULT-ZDEPCODE. "####

    CASE: GS_EVAL_RESULT_OUTPUT-ZDEPCODE. "###

      WHEN 'SS0001'. GS_EVAL_RESULT_OUTPUT-ZDEPNAME = '###'.

      WHEN 'SS0002'. GS_EVAL_RESULT_OUTPUT-ZDEPNAME = '###'.

      WHEN 'SS0003'. GS_EVAL_RESULT_OUTPUT-ZDEPNAME = '###'.

      WHEN 'SS0004'. GS_EVAL_RESULT_OUTPUT-ZDEPNAME = '###'.

      WHEN 'SS0005'. GS_EVAL_RESULT_OUTPUT-ZDEPNAME = '###'.

      WHEN 'SS0006'. GS_EVAL_RESULT_OUTPUT-ZDEPNAME = '###'.

    ENDCASE.

    CASE: GS_EVAL_RESULT-ZDEPRANK. "###

      WHEN 'A'. GS_EVAL_RESULT_OUTPUT-ZDEPRANKNAME = '##'.

      WHEN 'B'. GS_EVAL_RESULT_OUTPUT-ZDEPRANKNAME = '##'.

      WHEN 'C'. GS_EVAL_RESULT_OUTPUT-ZDEPRANKNAME = '##'.

      WHEN 'D'. GS_EVAL_RESULT_OUTPUT-ZDEPRANKNAME = '##'.

      WHEN 'E'. GS_EVAL_RESULT_OUTPUT-ZDEPRANKNAME = '##'.

      WHEN 'F'. GS_EVAL_RESULT_OUTPUT-ZDEPRANKNAME = '##'.

      WHEN 'G'. GS_EVAL_RESULT_OUTPUT-ZDEPRANKNAME = '##'.

    ENDCASE.

    GS_EVAL_RESULT_OUTPUT-ZEDATE = GS_EVAL_RESULT-ZEDATE. "###

    GS_EVAL_RESULT_OUTPUT-ZSALARY = GS_EVAL_RESULT-ZSALARY. "####

    GS_EVAL_RESULT_OUTPUT-ZRANK = GS_EVAL_RESULT-ZRANK. "####

    GS_EVAL_RESULT_OUTPUT-ZMON = GS_EVAL_RESULT-ZMON. "N###



    APPEND GS_EVAL_RESULT_OUTPUT TO GT_EVAL_RESULT_OUTPUT.

  ENDLOOP.

ENDFORM.




*&---------------------------------------------------------------------*

*&      Form  ALV_DISPLAY_EVAL

*&---------------------------------------------------------------------*

*       text

*----------------------------------------------------------------------*

*  -->  p1        text

*  <--  p2        text

*----------------------------------------------------------------------*




FORM ALV_DISPLAY_EVAL.



  DATA : LV_MON_FIELD_NAME TYPE C LENGTH 10. "## ### ### ##



  CLEAR : GS_FIELDCAT, GT_FIELDCAT.

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

  GS_FIELDCAT-FIELDNAME = 'ZDEPNAME'.

  GS_FIELDCAT-SELTEXT_M = '###'.

  APPEND GS_FIELDCAT TO GT_FIELDCAT.



  CLEAR : GS_FIELDCAT.

  GS_FIELDCAT-COL_POS = 5.

  GS_FIELDCAT-FIELDNAME = 'ZDEPRANKNAME'.

  GS_FIELDCAT-SELTEXT_M = '###'.

  APPEND GS_FIELDCAT TO GT_FIELDCAT.



  CLEAR : GS_FIELDCAT.

  GS_FIELDCAT-COL_POS = 6.

  GS_FIELDCAT-FIELDNAME = 'ZEDATE'.

  GS_FIELDCAT-SELTEXT_M = '###'.

  APPEND GS_FIELDCAT TO GT_FIELDCAT.



  CLEAR : GS_FIELDCAT.

  GS_FIELDCAT-COL_POS = 7.

  GS_FIELDCAT-FIELDNAME = 'ZSALARY'.

  GS_FIELDCAT-SELTEXT_M = '####'.

  GS_FIELDCAT-JUST = GC_ALV_RIGHT_ALIGN.

  GS_FIELDCAT-DO_SUM = 'X'. "## ##

  GS_FIELDCAT-CURRENCY = GC_ALV_CURRENCY.

  GS_FIELDCAT-OUTPUTLEN = 20. "# ## 20

  APPEND GS_FIELDCAT TO GT_FIELDCAT.



  CLEAR : GS_FIELDCAT.

  GS_FIELDCAT-COL_POS = 8.

  GS_FIELDCAT-FIELDNAME = 'ZRANK'.

  GS_FIELDCAT-SELTEXT_M = '####'.

  APPEND GS_FIELDCAT TO GT_FIELDCAT.



  CLEAR : GS_FIELDCAT.

  GS_FIELDCAT-COL_POS = 9.

  GS_FIELDCAT-FIELDNAME = 'ZMON'.

  CONCATENATE P_MONTH '#####' INTO LV_MON_FIELD_NAME.

  GS_FIELDCAT-SELTEXT_M = LV_MON_FIELD_NAME.

  GS_FIELDCAT-JUST = GC_ALV_RIGHT_ALIGN.

  GS_FIELDCAT-DO_SUM = 'X'. "## ##

  GS_FIELDCAT-CURRENCY = GC_ALV_CURRENCY.

  GS_FIELDCAT-OUTPUTLEN = 20.

  APPEND GS_FIELDCAT TO GT_FIELDCAT.



  GS_LAYOUT-ZEBRA = 'X'. "## ## ## ### ### ##

  GS_SORT-SPOS = '1'. "####

  GS_SORT-FIELDNAME = 'ZPERNR'. "ZPERNR# #### ##

  GS_SORT-UP = 'X'. "####

  APPEND GS_SORT TO GT_SORT.

  CALL FUNCTION 'REUSE_ALV_GRID_DISPLAY'

    EXPORTING

      IS_LAYOUT                         = GS_LAYOUT

      IT_FIELDCAT                       = GT_FIELDCAT

      IT_SORT                           = GT_SORT

    TABLES

      T_OUTTAB                          = GT_EVAL_RESULT_OUTPUT.



  IF SY-SUBRC <> 0. "## ## ###

    STOP.

  ENDIF.

ENDFORM.