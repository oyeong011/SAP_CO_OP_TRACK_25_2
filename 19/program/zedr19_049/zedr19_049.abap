
*&---------------------------------------------------------------------*

*& Report ZEDR05_PRACTICE006

*&---------------------------------------------------------------------*

*&

*&---------------------------------------------------------------------*




REPORT ZEDR19_049.






* TABLES ##




TABLES: ZEDT19_102,

        ZEDT19_103,

        ZEDT19_104,

        ZEDT19_105,

        ZEDT19_106.



DATA : ls_105 TYPE ZEDT19_105,

       lv_db_amt TYPE p DECIMALS 2,

       lv_mon_i TYPE i.






* TYPES ##




" #### ### ###

TYPES: BEGIN OF TY_EMP_INFO,

         ZPERNR    TYPE ZEDT19_102-ZPERNR,    "####

         ZPNAME    TYPE ZEDT19_103-ZPNAME,    "####

         ZDEPCODE  TYPE ZEDT19_102-ZDEPCODE,  "####

         ZDEPNAME  TYPE CHAR20,               "###

         ZDEPRANK  TYPE ZEDT19_102-ZDEPRANK,  "####

         ZRANKNAME TYPE CHAR20,               "###

         ZEDATE    TYPE ZEDT19_102-ZEDATE,    "###

         ZQDATE    TYPE ZEDT19_102-ZQDATE,    "###

         ZQFLAG    TYPE ZEDT19_102-ZQFLAG,    "####(##/##)

         ZQFLAG_T  TYPE CHAR4,              "####(##)

         ZGENDER   TYPE ZEDT19_103-ZGENDER,   "##(##)

         ZADDRESS  TYPE ZEDT19_103-ZADDRESS,   "##

         ZBANKCODE TYPE ZEDT19_106-ZBANKCODE, "####

         ZBANKNAME TYPE CHAR20,               "###

         ZACCOUNT TYPE ZEDT19_106-ZACCOUNT,   "####

       END OF TY_EMP_INFO.



" #### ### ###

TYPES: BEGIN OF TY_SALARY,

         ZPERNR   TYPE ZEDT19_102-ZPERNR,    "####

         ZPNAME   TYPE ZEDT19_103-ZPNAME,    "###

         ZDEPCODE TYPE ZEDT19_104-ZDEPCODE,

         ZDEPNAME TYPE CHAR20, "###

         ZRANKNAME TYPE CHAR20, "###

         ZQFLAG    TYPE ZEDT19_102-ZQFLAG,    "####(##/##)

         ZQFLAG_K  TYPE CHAR2, "#### -> ####

         ZQDATE    TYPE ZEDT19_102-ZQDATE,    "###

         ZEDATE    TYPE ZEDT19_102-ZEDATE, "###

         ZSALARY  TYPE ZEDT19_106-ZSALARY,   "####

         ZPAY_AMT TYPE ZEDT19_106-ZSALARY,    "###

         ZRANK    TYPE ZEDT19_104-ZRANK,     "####

         ZPERNR_I TYPE I, "## ### ###

       END OF TY_SALARY.



" #### ### ###

TYPES: BEGIN OF TY_EVAL,

         ZPERNR    TYPE ZEDT19_102-ZPERNR,    "####

         ZPNAME    TYPE ZEDT19_103-ZPNAME,    "####

         ZDEPCODE  TYPE ZEDT19_102-ZDEPCODE,  "####

         ZDEPNAME  TYPE CHAR20,               "###

         ZRANKNAME TYPE CHAR20,               "###

         ZEDATE    TYPE ZEDT19_102-ZEDATE,    "###

         ZQDATE    TYPE ZEDT19_102-ZQDATE,    "##

         ZQFLAG    TYPE ZEDT19_102-ZQFLAG,    "####(##/##)#

         ZSALARY  TYPE ZEDT19_106-ZSALARY,    "####

         ZQFLAG_T  TYPE CHAR10,               "##/##

         ZRANK     TYPE ZEDT19_104-ZRANK,     "####

       END OF TY_EVAL.






* CONSTANTS ##




CONSTANTS: C_X           TYPE C VALUE 'X',

           C_MALE        TYPE C VALUE 'M',           "##

           C_FEMALE      TYPE C VALUE 'F',           "##

           C_MALE_T      TYPE CHAR4 VALUE '##',

           C_FEMALE_T    TYPE CHAR4 VALUE '##',

           C_RANK_A      TYPE C VALUE 'A',           "#### A

           C_BONUS       TYPE P DECIMALS 2 VALUE '50000.00',  "### 5##

           C_QUIT        TYPE C VALUE 'Y',           "##

           C_ACTIVE      TYPE CHAR10 VALUE '##',

           C_QUIT_T      TYPE CHAR10 VALUE '##',

           C_ZERO        TYPE P DECIMALS 2 VALUE 0,

           C_TWELVE      TYPE I VALUE 12.            "12##






* ALV ### Internal Tables




DATA: GT_EMP_INFO TYPE TABLE OF TY_EMP_INFO,  "#### ###

      GS_EMP_INFO TYPE TY_EMP_INFO.



DATA: GT_SALARY TYPE TABLE OF TY_SALARY,      "#### ###

      GS_SALARY TYPE TY_SALARY.



DATA: GT_EVAL TYPE TABLE OF TY_EVAL,          "#### ###

      GS_EVAL TYPE TY_EVAL.






* ALV ## ##






DATA: GT_FCAT   TYPE SLIS_T_FIELDCAT_ALV,     "Field Catalog

      GS_FCAT   TYPE SLIS_FIELDCAT_ALV,

      GT_SORT   TYPE SLIS_T_SORTINFO_ALV,     "Sort

      GS_SORT   TYPE SLIS_SORTINFO_ALV,

      GS_LAYOUT TYPE SLIS_LAYOUT_ALV. "Layout






* RANGES ##

*5. ##### 1### ##




RANGES: R_DATE   FOR ZEDT19_102-DATAB,        "#### ##

        R_PERNR  FOR ZEDT19_102-ZPERNR,       "#### ##

        R_YEAR   FOR ZEDT19_104-ZYEAR.        "## ##






* SELECTION SCREEN




SELECTION-SCREEN BEGIN OF BLOCK B1 WITH FRAME.



  " ## #### - ####

  SELECT-OPTIONS: S_PERNR FOR ZEDT19_102-ZPERNR MODIF ID ALL.



  " ##### ####

  SELECT-OPTIONS: S_DATE FOR ZEDT19_102-DATAB MODIF ID M1.

  SELECT-OPTIONS: S_DEPT FOR ZEDT19_102-ZDEPCODE NO INTERVALS NO-EXTENSION MODIF ID M1.



  " ####/##### ####

  PARAMETERS: P_YEAR  TYPE ZEDT19_104-ZYEAR MODIF ID M2,

              P_MONTH TYPE NUMC2 MODIF ID M2.



SELECTION-SCREEN END OF BLOCK B1.





SELECTION-SCREEN BEGIN OF BLOCK B2 WITH FRAME.

  " ##### - 3## ##

  PARAMETERS: P_RAD1 RADIOBUTTON GROUP RB1 DEFAULT 'X' USER-COMMAND UC1,

              P_RAD2 RADIOBUTTON GROUP RB1,

              P_RAD3 RADIOBUTTON GROUP RB1.



SELECTION-SCREEN END OF BLOCK B2.







SELECTION-SCREEN BEGIN OF BLOCK B3 WITH FRAME.



  PARAMETERS: P_CHK1 AS CHECKBOX DEFAULT 'X' MODIF ID M1. "####



SELECTION-SCREEN END OF BLOCK B3.






* ### ## : ## ## ##




INITIALIZATION.



  PERFORM GET_LAST_OF_DAY.






*




AT SELECTION-SCREEN OUTPUT.

  PERFORM SET_SCREEN_CONTROL.






* ### ### ## (### ####, ### ### #)




AT SELECTION-SCREEN.

  PERFORM CHECK_INPUT_VALUE.






* ## #### ##




START-OF-SELECTION.

  PERFORM MAIN_PROCESS.



END-OF-SELECTION.






* GET_LAST_OF_DAY

* ### ### #### P_YEAR# #### S_DATE ##




form GET_LAST_OF_DAY.



  P_YEAR  = SY-DATUM(4).      "####

  P_MONTH = SY-DATUM+4(2).    "###



  " #### ### ##

  S_DATE-SIGN   = 'I'.

  S_DATE-OPTION = 'BT'.

  S_DATE-LOW    = SY-DATUM(4) && '0101'.  "## 1# 1#



  CALL FUNCTION 'RP_LAST_DAY_OF_MONTHS'

    exporting

      DAY_IN            =  SY-DATUM

    importing

      LAST_DAY_OF_MONTH =   S_DATE-HIGH

    exceptions

      DAY_IN_NO_DATE    = 1

      OTHERS            = 2

    .

  if sy-subrc <> 0.

  endif.

  APPEND S_DATE.

endform.






* SET_SCREEN_CONTROL.

* ### ## #### ## ## ## ##




FORM set_screen_control .



  LOOP AT SCREEN.



    " ALL ##: ## ##

    IF screen-group1 = 'ALL'.

      screen-active = 1.

      MODIFY SCREEN.

      CONTINUE.

    ENDIF.



    " M1 ##: #### ###(P_RAD1) ## ## ##

    IF screen-group1 = 'M1'.

      IF p_rad1 = c_x.

        screen-active = 1.

      ELSE.

        screen-active = 0.

      ENDIF.

      MODIFY SCREEN.

      CONTINUE.

    ENDIF.



    IF screen-group1 = 'M2'.

      IF p_rad2 = c_x OR p_rad3 = c_x.

        screen-active = 1.

      ELSE.

        screen-active = 0.

      ENDIF.

      MODIFY SCREEN.

      CONTINUE.

    ENDIF.



  ENDLOOP.



ENDFORM.








* CHECK_INPUT_VALUE

* ##### #### ## ## #### #### ### ## ## ### ## -> STOP




form CHECK_INPUT_VALUE .



  IF P_RAD1 = C_X.  " #### ##

    IF S_DATE[] IS INITIAL.

      MESSAGE '##### ######.' TYPE 'E'.

      STOP.

    ENDIF.

  ELSEIF P_RAD2 = C_X.  " ####

      IF P_YEAR IS INITIAL.

        MESSAGE '##### ######.' TYPE 'E'.

        STOP.

      ENDIF.



      IF P_MONTH IS INITIAL.

        MESSAGE '#### ######.' TYPE 'E'.

        STOP.

      ENDIF.



      " # ### ## (1~12)

      IF P_MONTH < 1 OR P_MONTH > 12.

        MESSAGE '## 1~12 ### #### ###.' TYPE 'E'.

        STOP.

      ENDIF.

    ELSEIF P_RAD3 = C_X.  " ####

      IF P_YEAR IS INITIAL.

        MESSAGE '##### ######.' TYPE 'E'.

        STOP.

      ENDIF.

    ENDIF.

ENDFORM.






* MAIN_PROCESS

* ##### #### ## ### ### ### ##




FORM MAIN_PROCESS.

  " ### ### ## ## ##

  IF P_RAD1 = C_X.  " #### ##

    PERFORM GET_EMPLOYEE_INFO. " ## ## select#

    PERFORM DISPLAY_ALV_EMP_INFO. "## ## ALV ###

  ELSEIF P_RAD2 = C_X.  " ####

    PERFORM GET_PAYMENT_INFO. " ## ##

    PERFORM PROCESS_PAYMENT. " ### ##

    PERFORM FILL_EMP_NAME.

    PERFORM DISPLAY_ALV_SALARY.

  ELSEIF P_RAD3 = C_X.  " ####

  ENDIF.

ENDFORM.



FORM process_payment .



  DATA: lv_pay_date TYPE d,

        lv_dayin    TYPE d,

        lv_amt      TYPE zedt19_106-zsalary,

        lv_db_amt   TYPE p DECIMALS 2,

        lv_updated  TYPE i,

        lv_mon_i    TYPE i.



  DATA: lv_pernr TYPE zedt19_105-zpernr,   "# ### ##

        lv_year  TYPE zedt19_105-zyear,

        ls_105   TYPE zedt19_105,

        ls_exist TYPE zedt19_105.





  " ## ##

  lv_dayin = |{ p_year }{ p_month }01|.

  CALL FUNCTION 'RP_LAST_DAY_OF_MONTHS'

    EXPORTING  day_in = lv_dayin

    IMPORTING  last_day_of_month = lv_pay_date.



  lv_mon_i = p_month.    " '03' -> 3 (###### ##)



  LOOP AT gt_salary INTO gs_salary.



    "---- # ## ###: ### ## # ## ----

    lv_pernr = gs_salary-zpernr.

    CALL FUNCTION 'CONVERSION_EXIT_ALPHA_INPUT'

      EXPORTING  input  = lv_pernr

      IMPORTING  output = lv_pernr.

    lv_year  = p_year.



    " # ##/## ##

    IF gs_salary-zqflag IS NOT INITIAL AND gs_salary-zqdate <= lv_pay_date.

      CONTINUE.

    ENDIF.

    IF gs_salary-zrank IS INITIAL.

      CONTINUE.

    ENDIF.



    " # ### ##

    lv_amt = gs_salary-zsalary / c_twelve.

    IF gs_salary-zrank = c_rank_a.

      lv_amt = lv_amt + c_bonus.

    ENDIF.

    IF lv_amt = c_zero.

      CONTINUE.

    ENDIF.



    " # ### ## (#: 1000# -> 10.00)

    lv_db_amt = lv_amt / 100.



    "---- # #### ## ## # ### INSERT (### # ##) ----

    CLEAR ls_exist.

    SELECT SINGLE zpernr, zyear

      FROM zedt19_105

      INTO CORRESPONDING FIELDS OF @ls_exist

      WHERE zpernr = @lv_pernr

        AND zyear  = @lv_year.



    IF sy-subrc <> 0.

      CLEAR ls_105.

      ls_105-zpernr = lv_pernr.

      ls_105-zyear  = lv_year.

      INSERT zedt19_105 FROM @ls_105.

      IF sy-subrc <> 0.

        ROLLBACK WORK. MESSAGE '#### ##' TYPE 'E'. STOP.

      ENDIF.

    ENDIF.



    "---- # ## CASE# UPDATE (## lv_pernr/lv_year ##!) ----

    CASE lv_mon_i.

      WHEN 1.

        UPDATE zedt19_105

           SET zmon01 = @lv_db_amt,

               aename = @sy-uname,

               aedate = @sy-datum,

               aezeit = @sy-uzeit

         WHERE zpernr = @lv_pernr

           AND zyear  = @lv_year.

           gs_salary-zpay_amt = lv_db_amt.



      WHEN 2.

        UPDATE zedt19_105

           SET zmon02 = @lv_db_amt,

               aename = @sy-uname,

               aedate = @sy-datum,

               aezeit = @sy-uzeit

         WHERE zpernr = @lv_pernr

           AND zyear  = @lv_year.

           gs_salary-zpay_amt = lv_db_amt.



      WHEN 3.

        UPDATE zedt19_105

           SET zmon03 = @lv_db_amt,

               aename = @sy-uname,

               aedate = @sy-datum,

               aezeit = @sy-uzeit

         WHERE zpernr = @lv_pernr

           AND zyear  = @lv_year.

           gs_salary-zpay_amt = lv_db_amt.



      WHEN 4.

        UPDATE zedt19_105

           SET zmon04 = @lv_db_amt,

               aename = @sy-uname,

               aedate = @sy-datum,

               aezeit = @sy-uzeit

         WHERE zpernr = @lv_pernr

           AND zyear  = @lv_year.

           gs_salary-zpay_amt = lv_db_amt.



      WHEN 5.

        UPDATE zedt19_105

           SET zmon05 = @lv_db_amt,

               aename = @sy-uname,

               aedate = @sy-datum,

               aezeit = @sy-uzeit

         WHERE zpernr = @lv_pernr

           AND zyear  = @lv_year.

           gs_salary-zpay_amt = lv_db_amt.



      WHEN 6.

        UPDATE zedt19_105

           SET zmon03 = @lv_db_amt,

               aename = @sy-uname,

               aedate = @sy-datum,

               aezeit = @sy-uzeit

         WHERE zpernr = @lv_pernr

           AND zyear  = @lv_year.

           gs_salary-zpay_amt = lv_db_amt.



      WHEN 7.

        UPDATE zedt19_105

           SET zmon03 = @lv_db_amt,

               aename = @sy-uname,

               aedate = @sy-datum,

               aezeit = @sy-uzeit

         WHERE zpernr = @lv_pernr

           AND zyear  = @lv_year.

           gs_salary-zpay_amt = lv_db_amt.



      WHEN 8.

        UPDATE zedt19_105

           SET zmon04 = @lv_db_amt,

               aename = @sy-uname,

               aedate = @sy-datum,

               aezeit = @sy-uzeit

         WHERE zpernr = @lv_pernr

           AND zyear  = @lv_year.

           gs_salary-zpay_amt = lv_db_amt.



      WHEN 9.

        UPDATE zedt19_105

           SET zmon05 = @lv_db_amt,

               aename = @sy-uname,

               aedate = @sy-datum,

               aezeit = @sy-uzeit

         WHERE zpernr = @lv_pernr

           AND zyear  = @lv_year.

           gs_salary-zpay_amt = lv_db_amt.



      WHEN 10.

        UPDATE zedt19_105

           SET zmon03 = @lv_db_amt,

               aename = @sy-uname,

               aedate = @sy-datum,

               aezeit = @sy-uzeit

         WHERE zpernr = @lv_pernr

           AND zyear  = @lv_year.

           gs_salary-zpay_amt = lv_db_amt.



      WHEN 11.

        UPDATE zedt19_105

           SET zmon05 = @lv_db_amt,

               aename = @sy-uname,

               aedate = @sy-datum,

               aezeit = @sy-uzeit

         WHERE zpernr = @lv_pernr

           AND zyear  = @lv_year.

           gs_salary-zpay_amt = lv_db_amt.



      WHEN 12.

        UPDATE zedt19_105

           SET zmon03 = @lv_db_amt,

               aename = @sy-uname,

               aedate = @sy-datum,

               aezeit = @sy-uzeit

         WHERE zpernr = @lv_pernr

           AND zyear  = @lv_year.

           gs_salary-zpay_amt = lv_db_amt.



      WHEN OTHERS.

        ROLLBACK WORK. MESSAGE '#### ## ####.' TYPE 'E'. STOP.

    ENDCASE.





    IF sy-subrc <> 0 OR sy-dbcnt = 0.

      ROLLBACK WORK. MESSAGE '#### ##' TYPE 'E'. STOP.

    ENDIF.



    lv_updated = lv_updated + sy-dbcnt.



    MODIFY gt_salary FROM gs_salary.



  ENDLOOP.



  IF lv_updated > 0.

    COMMIT WORK.

    MESSAGE '### #######.' TYPE 'S'.

  ELSE.

    MESSAGE '## ### ####.' TYPE 'I'.

  ENDIF.



ENDFORM.








* ## alv display




FORM DISPLAY_ALV_SALARY.

  PERFORM SET_FIELDCAT_SALARY.

  PERFORM SET_SORT_SALARY.



  GS_LAYOUT-ZEBRA = 'X'.

  GS_LAYOUT-COLWIDTH_OPTIMIZE = 'X'.



  CALL FUNCTION 'REUSE_ALV_GRID_DISPLAY'

    EXPORTING

      I_CALLBACK_PROGRAM = SY-REPID

      IS_LAYOUT          = GS_LAYOUT

      IT_FIELDCAT        = GT_FCAT

      IT_SORT            = GT_SORT

    TABLES

      T_OUTTAB           = GT_SALARY

    EXCEPTIONS

      PROGRAM_ERROR      = 1

      OTHERS             = 2.



    IF SY-SUBRC <> 0.

      MESSAGE 'ALV ## # ### ######.' TYPE 'E'.

    ENDIF.



ENDFORM.



FORM SET_FIELDCAT_SALARY.



  DATA : lv_pay_coltext TYPE CHAR50.



  lv_pay_coltext = |{ p_month }# ###|.



  CLEAR GT_FCAT.



  PERFORM ADD_FIELDCAT USING 'ZPERNR' '####' '10'.



  PERFORM ADD_FIELDCAT USING 'ZPNAME' '####' '15'.



  PERFORM ADD_FIELDCAT USING 'ZDEPCODE' '####' '10'.



  PERFORM ADD_FIELDCAT USING 'ZDEPNAME' '###' '20'.



  PERFORM ADD_FIELDCAT USING 'ZRANKNAME' '###' '15'.



  PERFORM ADD_FIELDCAT USING 'ZEDATE' '###' '10'.



  "####

  PERFORM ADD_FIELDCAT USING 'ZSALARY' '####' '30'.



  "####

  PERFORM ADD_FIELDCAT USING 'ZRANK' '####' '4'.



  "n# ###

  PERFORM ADD_FIELDCAT USING 'ZPAY_AMT' lv_pay_coltext '10'.



ENDFORM.






* ## ### #### ### ####

* SET_SORT_SALARY




FORM set_sort_salary.



  " ## ### ### (## 0# ### CONV i(...)# ### ##)

  LOOP AT gt_salary INTO gs_salary.

    gs_salary-zpernr_i = CONV i( gs_salary-zpernr ).

    MODIFY gt_salary FROM gs_salary TRANSPORTING zpernr_i.

  ENDLOOP.



  " ### ## ##

  SORT gt_salary BY zpernr_i ASCENDING.



ENDFORM.






* GET_EMPLOYEE_INFO

* #### ##




form GET_EMPLOYEE_INFO .

  SELECT

      A~ZPERNR,      B~ZPNAME,      A~ZDEPRANK,      A~ZDEPCODE,

      A~ZEDATE,      A~ZQDATE,      A~ZQFLAG,      B~ZGENDER,

      B~ZADDRESS,      C~ZBANKCODE,      C~ZACCOUNT

    FROM ZEDT19_102 AS A

    LEFT OUTER JOIN ZEDT19_103 AS B

      ON A~ZPERNR = B~ZPERNR

    LEFT OUTER JOIN ZEDT19_106 AS C

      ON A~ZPERNR = C~ZPERNR

    WHERE

      A~ZPERNR IN @S_PERNR

    AND

      A~ZEDATE IN @S_DATE

    INTO CORRESPONDING FIELDS OF TABLE @GT_EMP_INFO.





  IF P_CHK1 = C_X.

    DELETE

      GT_EMP_INFO

    WHERE

      ZQDATE IS NOT INITIAL

    AND

      ZQDATE <= S_DATE-HIGH.

  ENDIF.



  PERFORM CONVERT_KOR. "#### #### ### ##

endform.






* CONVERT_KOR

* ###(##,####,##,##,##)# #### #### ### ##




form CONVERT_KOR .



  LOOP AT GT_EMP_INFO INTO GS_EMP_INFO.

    CASE GS_EMP_INFO-ZGENDER.

      WHEN C_MALE.

        GS_EMP_INFO-ZGENDER = C_MALE_T.

      WHEN C_FEMALE.

        GS_EMP_INFO-ZGENDER = C_FEMALE_T.

    ENDCASE.



    IF GS_EMP_INFO-ZQFLAG IS NOT INITIAL.

      GS_EMP_INFO-ZQFLAG_T = C_QUIT_T.

    ELSE.

      GS_EMP_INFO-ZQFLAG_T = C_ACTIVE.

    ENDIF.



    " ### ## ##

    CASE GS_EMP_INFO-ZDEPCODE.

      WHEN 'SS0001'. GS_EMP_INFO-ZDEPNAME = '###'.

      WHEN 'SS0002'. GS_EMP_INFO-ZDEPNAME = '###'.

      WHEN 'SS0003'. GS_EMP_INFO-ZDEPNAME = '###'.

      WHEN 'SS0004'. GS_EMP_INFO-ZDEPNAME = '###'.

      WHEN 'SS0005'. GS_EMP_INFO-ZDEPNAME = '###'.

      WHEN 'SS0006'. GS_EMP_INFO-ZDEPNAME = '###'.

    ENDCASE.



    " ### ## ##

    CASE GS_EMP_INFO-ZDEPRANK.

      WHEN '1'. GS_EMP_INFO-ZRANKNAME = '##'.

      WHEN '2'. GS_EMP_INFO-ZRANKNAME = '##'.

      WHEN '3'. GS_EMP_INFO-ZRANKNAME = '##'.

      WHEN '4'. GS_EMP_INFO-ZRANKNAME = '##'.

      WHEN '5'. GS_EMP_INFO-ZRANKNAME = '##'.

      WHEN '6'. GS_EMP_INFO-ZRANKNAME = '##'.

      WHEN '7'. GS_EMP_INFO-ZRANKNAME = '##'.

    ENDCASE.



    " ### ## ##

    CASE GS_EMP_INFO-ZBANKCODE.

      WHEN '001'. GS_EMP_INFO-ZBANKNAME = '##'.

      WHEN '002'. GS_EMP_INFO-ZBANKNAME = '##'.

      WHEN '003'. GS_EMP_INFO-ZBANKNAME = '##'.

      WHEN '004'. GS_EMP_INFO-ZBANKNAME = '##'.

      WHEN '005'. GS_EMP_INFO-ZBANKNAME = '###'.

    ENDCASE.



    MODIFY GT_EMP_INFO FROM GS_EMP_INFO.

  ENDLOOP.

endform.






* ### ## -> ##### ##

* ##### : ######(## ### ## ##/##/#### #### ##), ####(###/###/### ## #), ##/##

* ##### ## -> ## (REUSE_ALV_GRID_DISPLAY)



* DISPLAY_ALV_EMP_INFO

* ### #### #### ALV ##




form DISPLAY_ALV_EMP_INFO .

  PERFORM SET_FIELDCAT_EMP_INFO.

  PERFORM SET_SORT_EMP_INFO.



  GS_LAYOUT-ZEBRA = 'X'.

  GS_LAYOUT-COLWIDTH_OPTIMIZE = 'X'.



  CALL FUNCTION 'REUSE_ALV_GRID_DISPLAY'

    EXPORTING

      I_CALLBACK_PROGRAM = SY-REPID

      IS_LAYOUT          = GS_LAYOUT

      IT_FIELDCAT        = GT_FCAT

      IT_SORT            = GT_SORT

    TABLES

      T_OUTTAB           = GT_EMP_INFO

    EXCEPTIONS

      PROGRAM_ERROR      = 1

      OTHERS             = 2.



    IF SY-SUBRC <> 0.

      MESSAGE 'ALV ## # ### ######.' TYPE 'E'.

    ENDIF.

endform.






* SET_FIELDCAT_EMP_INFO

* #### ALV# ###### ##




form SET_FIELDCAT_EMP_INFO .

  CLEAR GT_FCAT.



    " ####

  PERFORM ADD_FIELDCAT USING 'ZPERNR' '####' '10'.



  " ####

  PERFORM ADD_FIELDCAT USING 'ZPNAME' '####' '15'.



  " ####

  PERFORM ADD_FIELDCAT USING 'ZDEPCODE' '####' '10'.



  " ###

  PERFORM ADD_FIELDCAT USING 'ZDEPNAME' '###' '20'.



  " ###

  PERFORM ADD_FIELDCAT USING 'ZRANKNAME' '###' '15'.



  " ###

  PERFORM ADD_FIELDCAT USING 'ZEDATE' '###' '10'.



  " ####

  PERFORM ADD_FIELDCAT USING 'ZQFLAG_T' '####' '10'.



  " ##

  PERFORM ADD_FIELDCAT USING 'ZGENDER' '##' '10'.



  " ##

  PERFORM ADD_FIELDCAT USING 'ZADDRESS' '##' '30'.



  " ####

  PERFORM ADD_FIELDCAT USING 'ZBANKCODE' '####' '10'.



  " ###

  PERFORM ADD_FIELDCAT USING 'ZBANKNAME' '###' '20'.



  " ####

  PERFORM ADD_FIELDCAT USING 'ZACCOUNT' '####' '20'.

ENDFORM.





FORM ADD_FIELDCAT USING P_FIELDNAME TYPE CHAR30

                        P_TEXT TYPE CHAR50

                        P_OUTPUTLEN TYPE CHAR10.

  CLEAR : GS_FCAT.



  GS_FCAT-FIELDNAME = P_FIELDNAME.

  GS_FCAT-SELTEXT_M = P_TEXT.

  GS_FCAT-OUTPUTLEN = P_OUTPUTLEN.

  APPEND GS_FCAT TO GT_FCAT.

ENDFORM.






* SET_SORT_EMP_INFO

* ALV ## ## : ## -> #### ###### ## ##




FORM SET_SORT_EMP_INFO.

  CLEAR GT_SORT.



  " ##### ##

  CLEAR GS_SORT.

  GS_SORT-FIELDNAME = 'ZPERNR'.

  GS_SORT-UP = 'X'.

  APPEND GS_SORT TO GT_SORT.



  " ##### ##

  CLEAR GS_SORT.

  GS_SORT-FIELDNAME = 'ZDEPCODE'.

  GS_SORT-UP = 'X'.

  APPEND GS_SORT TO GT_SORT.

ENDFORM.



FORM get_payment_info .



  DATA: lv_last_day TYPE d,

        lv_pay_date TYPE d,

        lv_dayin    TYPE d.



  CLEAR gt_salary.



  SELECT

    a~zpernr,

    b~zpname,

    a~zdepcode,

    a~zedate,

    a~zqflag,

    a~zqdate,

    c~zsalary,

    d~zrank

  FROM  zedt19_102 AS a

  LEFT OUTER JOIN zedt19_103 AS b

    ON a~zpernr = b~zpernr

  LEFT OUTER JOIN zedt19_104 AS d

    ON a~zpernr = d~zpernr

   AND d~zyear  = @p_year

  LEFT OUTER JOIN zedt19_106 AS c

    ON a~zpernr = c~zpernr

  WHERE a~zpernr IN @s_pernr

  INTO CORRESPONDING FIELDS OF TABLE @gt_salary.



  " # ### # ##

  lv_dayin = |{ p_year }{ p_month }01|.

  CALL FUNCTION 'RP_LAST_DAY_OF_MONTHS'

    EXPORTING  day_in = lv_dayin

    IMPORTING  last_day_of_month = lv_last_day.



  lv_pay_date = lv_last_day.



  " #### # ## (###/##X/##X)

  DELETE gt_salary

    WHERE ( zqflag IS NOT INITIAL AND zqdate <= lv_pay_date )

       OR zsalary = c_zero

       OR zrank   IS INITIAL.



  " ###/### ##

  LOOP AT gt_salary INTO gs_salary.



    CASE gs_salary-zdepcode.

      WHEN 'SS0001'. gs_salary-zdepname = '###'.

      WHEN 'SS0002'. gs_salary-zdepname = '###'.

      WHEN 'SS0003'. gs_salary-zdepname = '###'.

      WHEN 'SS0004'. gs_salary-zdepname = '###'.

      WHEN 'SS0005'. gs_salary-zdepname = '###'.

      WHEN 'SS0006'. gs_salary-zdepname = '###'.

    ENDCASE.



    CASE gs_salary-zrank.

      WHEN 'A'. gs_salary-zrankname = '##'.

      WHEN 'B'. gs_salary-zrankname = '##'.

      WHEN 'C'. gs_salary-zrankname = '##'.

      WHEN 'D'. gs_salary-zrankname = '##'.

      WHEN 'E'. gs_salary-zrankname = '##'.

      WHEN 'F'. gs_salary-zrankname = '##'.

      WHEN 'G'. gs_salary-zrankname = '##'.

    ENDCASE.



    MODIFY gt_salary FROM gs_salary.

  ENDLOOP.



ENDFORM.



FORM fill_emp_name .



  DATA: ls_name  TYPE zedt19_103,

        lv_pernr TYPE zedt19_103-zpernr,

        lv_idx   TYPE sy-tabix.



  LOOP AT gt_salary INTO gs_salary.

    lv_idx  = sy-tabix.             " ## ## ### ##

    lv_pernr = gs_salary-zpernr.



    " ## ALPHA ## (0000000123 ### ##)

    CALL FUNCTION 'CONVERSION_EXIT_ALPHA_INPUT'

      EXPORTING  input  = lv_pernr

      IMPORTING  output = lv_pernr.



    " ## ## ##

    CLEAR ls_name.

    SELECT SINGLE zpname

      FROM zedt19_103

      INTO @ls_name-zpname

      WHERE zpernr = @lv_pernr.



    IF sy-subrc = 0 AND ls_name-zpname IS NOT INITIAL.

      gs_salary-zpname = ls_name-zpname.

      MODIFY gt_salary FROM gs_salary INDEX lv_idx TRANSPORTING zpname.

    ENDIF.

  ENDLOOP.



ENDFORM.








*Messages

*----------------------------------------------------------

*

* Message class: Hard coded

*   ##### ######.