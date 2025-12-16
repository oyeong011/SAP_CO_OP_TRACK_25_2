
*&---------------------------------------------------------------------*

*& Report ZEDR08_PRACTICE006

*&---------------------------------------------------------------------*

*&

*&---------------------------------------------------------------------*




REPORT ZEDR08_PRACTICE006.






* TABLE ### ## ##




TABLES: ZEDT08_102, " ## ###

        ZEDT08_103, " ## ##

        ZEDT08_104, " ####

        ZEDT08_105, " ####

        ZEDT08_106. " ####



" X ## ### ## ##

CONSTANTS: C_X TYPE CHAR1 VALUE 'X'.

TYPE-POOLS: SLIS.



" ## ## ### ##

TYPES: BEGIN OF GS_EMPLOYEE,

  ZPERNR TYPE ZEDT08_102-ZPERNR,

  ZPNAME TYPE ZEDT08_103-ZPNAME,

  ZDEPCODE TYPE ZEDT08_102-ZDEPCODE,

  ZDEPNAME TYPE CHAR20,

  ZDEPRANK TYPE ZEDT08_102-ZDEPRANK,

  ZRANKNAME TYPE CHAR20,

  ZEDATE TYPE ZEDT08_102-ZEDATE,

  ZQDATE TYPE ZEDT08_102-ZQDATE,

  ZQFLAG TYPE ZEDT08_102-ZQFLAG,

  ZQFLAG_T TYPE CHAR4,

  ZGENDER TYPE ZEDT08_103-ZGENDER,

  ZADDRESS TYPE ZEDT08_103-ZADDRESS,

  ZBANKCODE TYPE ZEDT08_106-ZBANKCODE,

  ZBANKNAME TYPE CHAR20,

  ZACCOUNT TYPE ZEDT08_106-ZACCOUNT,

  END OF GS_EMPLOYEE.



" ## ## ### ### # ## ## ##

DATA: GT_EMPLOYEE TYPE TABLE OF GS_EMPLOYEE,

      GWA_EMPLOYEE TYPE GS_EMPLOYEE.



" ## ### ### ##

DATA : BEGIN OF GS_SALARY, "#######

  ZPERNR LIKE ZEDT08_102-ZPERNR, "####

  ZQDATE LIKE ZEDT08_102-ZQDATE, "###

  ZQFLAG LIKE ZEDT08_102-ZQFLAG, "####

  ZSALARY LIKE ZEDT08_106-ZSALARY, "####

  ZPAY LIKE ZEDT08_106-ZSALARY, "##

  ZRANK LIKE ZEDT08_104-ZRANK, "####

  END OF GS_SALARY.

DATA : GT_SALARY LIKE TABLE OF GS_SALARY.



" ## ### ### ##

DATA : BEGIN OF GS_ASSESS, "#####

  ZPERNR LIKE ZEDT08_102-ZPERNR, "####

  ZPNAME LIKE ZEDT08_103-ZPNAME, "####

  ZDEPCODE LIKE ZEDT08_102-ZDEPCODE, "####

  ZDEPRANK LIKE ZEDT08_102-ZDEPRANK, "##

  ZEDATE LIKE ZEDT08_102-ZEDATE, "###

  ZSALARY LIKE ZEDT08_106-ZSALARY, "####

  ZRANK LIKE ZEDT08_104-ZRANK, "####

  END OF GS_ASSESS.

DATA : GT_ASSESS LIKE TABLE OF GS_ASSESS.



" ## ## ALV ### ### ##

DATA : BEGIN OF GS_ASSESS_ALV, "##### ALV###

  ZPERNR LIKE ZEDT08_102-ZPERNR, "####

  ZPNAME LIKE ZEDT08_103-ZPNAME, "####

  ZDEPCODE LIKE ZEDT08_102-ZDEPCODE, "####

  ZDEPCODE_NAME(10), "###

  ZDEPRANK_NAME(6),  "###

  ZEDATE LIKE ZEDT08_102-ZEDATE, "###

  ZSALARY LIKE ZEDT08_106-ZSALARY, "####

  ZRANK LIKE ZEDT08_104-ZRANK, "####

  ZMON LIKE ZEDT08_105-ZMON01, "##

  END OF GS_ASSESS_ALV.

DATA : GT_ASSESS_ALV LIKE TABLE OF GS_ASSESS_ALV.



" ### ### ### ## ###

TYPES: BEGIN OF GS_DEP,

  ZDEPCODE TYPE ZEDT08_104-ZDEPCODE,

  ZDEPNAME TYPE CHAR20,

  END OF GS_DEP.



" ### ### ### ## ###

TYPES: BEGIN OF GS_RANK,

  ZDEPRANK TYPE ZEDT08_102-ZDEPRANK,

  ZRANKNAME TYPE CHAR20,

  END OF GS_RANK.



" ##/## ### ### # ## ##

DATA: GT_DEP TYPE TABLE OF GS_DEP,

      GWA_DEP TYPE GS_DEP,

      GT_RANK TYPE TABLE OF GS_RANK,

      GWA_RANK TYPE GS_RANK.



" # ## ## ##

DATA: GT_DATE TYPE RANGE OF ZEDT08_102-ZEDATE.

DATA: GV_DATE_HIGH TYPE D.



" #/# ### ##

DATA : GV_YEAR(4),

       GV_MON(2) TYPE N.



" ## ## # #### ## / ## ### ###

DATA : GV_CHECK.



" ALV ### ### ##

DATA: GT_FIELDCAT TYPE SLIS_T_FIELDCAT_ALV,

      GS_FIELDCAT TYPE SLIS_FIELDCAT_ALV,

      GT_SORT TYPE SLIS_T_SORTINFO_ALV,

      GS_SORT TYPE SLIS_SORTINFO_ALV,

      GS_LAYOUT TYPE SLIS_LAYOUT_ALV.



"---------------------------------------------------------------"

" ## B1: ## ## ## (####, ##, ####)

"---------------------------------------------------------------

SELECTION-SCREEN BEGIN OF BLOCK B1 WITH FRAME.

  SELECT-OPTIONS : S_PERNR FOR ZEDT08_102-ZPERNR MODIF ID ALL.

  SELECT-OPTIONS : S_EDATE FOR ZEDT08_102-ZEDATE MODIF ID M1.

  SELECT-OPTIONS : S_DCODE FOR ZEDT08_102-ZDEPCODE NO INTERVALS NO-EXTENSION MODIF ID M1.



  PARAMETERS: P_YEAR TYPE ZEDT08_104-ZYEAR MODIF ID M2,

              P_MONTH TYPE NUMC2 MODIF ID M2.



SELECTION-SCREEN END OF BLOCK B1.



"---------------------------------------------------------------"

" ## B2: ## ## ## (#####)

"---------------------------------------------------------------

SELECTION-SCREEN BEGIN OF BLOCK B2 WITH FRAME.



  PARAMETERS: P_RBUT1 RADIOBUTTON GROUP RBUT DEFAULT 'X' USER-COMMAND  UC1,

              P_RBUT2 RADIOBUTTON GROUP RBUT,

              P_RBUT3 RADIOBUTTON GROUP RBUT.



SELECTION-SCREEN END OF BLOCK B2.



"---------------------------------------------------------------"

" #### ## (####)

"---------------------------------------------------------------

SELECTION-SCREEN BEGIN OF BLOCK B3 WITH FRAME.



  PARAMETERS: P_CHK1 AS CHECKBOX DEFAULT C_X USER-COMMAND UC2 MODIF ID UC2.



SELECTION-SCREEN END OF BLOCK B3.



" #### ## # ## 1# #### ##

INITIALIZATION.

  " #### #### #### #

  PERFORM INIT_DEFAULT.



" ### ## ### ## ## ### ##/### #### #

AT SELECTION-SCREEN OUTPUT.

  PERFORM MODIFY_SCREEN.



" SELECTION SCREEN## #### ## ##

START-OF-SELECTION.

  CASE C_X.

    " ## ## ##

    WHEN P_RBUT1.

      " ### ##

      PERFORM GET_DATA.

      " ### ###

      PERFORM POST_FILTER.

      " ## #### ##

      PERFORM CONVERT_KOR.

      " ###, ### ## ##

      PERFORM ENRICH_DATA.



      " ### #### ### ### ## # ##

      IF GT_EMPLOYEE IS INITIAL.

        MESSAGE '## ### ####.' TYPE 'I'.

        EXIT.

      ENDIF.



      " ALV ##

      PERFORM BUILD_FIELDCAT.

      PERFORM BUILD_SORT.

      PERFORM DISPLAY_ALV.

    " ## ##

    WHEN P_RBUT2.

      " ## ## ### ##

      PERFORM GET_BASE_FOR_SALARY.



      " ### ## ##

      IF GT_SALARY[] IS INITIAL.

        MESSAGE '## ### ####.' TYPE 'I'.

        EXIT.

      ENDIF.

      " ## ## # ####

      PERFORM MODIFY_DATA_R2.

    " ## # ## ##

    WHEN P_RBUT3.

      " ## # ## ## ##

      PERFORM SELECT_DATA_R3.



      " ### #### ### ### ## # ##

      IF GT_ASSESS[] IS INITIAL.

        MESSAGE '## ### ####.' TYPE 'I'.

        EXIT.

      ENDIF.



      " ALV ###

      PERFORM MODIFY_DATA_R3.

      PERFORM ALV_DISPLAY_R3.

  ENDCASE.



" ## ### ## ### ##

END-OF-SELECTION.

  CHECK P_RBUT2 = C_X.

    IF GV_CHECK = C_X.

      MESSAGE '#### ##' TYPE 'I'.

    ELSE.

      MESSAGE '### #######.' TYPE 'I'.

    ENDIF.






*&---------------------------------------------------------------------*

*&      Form  INIT_DEFAULT

*&---------------------------------------------------------------------*

*       text

*----------------------------------------------------------------------*

*  -->  p1        text

*  <--  p2        text

*----------------------------------------------------------------------*




FORM INIT_DEFAULT . " #### #### ## 1# ~ ## ### ##



  DATA LV_FIRST TYPE D.

  DATA LV_LAST TYPE D.

  LV_FIRST = SY-DATUM.

  LV_FIRST+6(2) = '01'.

  S_EDATE-SIGN = 'I'.

  S_EDATE-OPTION = 'BT'.

  S_EDATE-LOW = LV_FIRST.



  CALL FUNCTION 'LAST_DAY_OF_MONTHS'

    EXPORTING DAY_IN = LV_FIRST

    IMPORTING LAST_DAY_OF_MONTH = LV_LAST.

  S_EDATE-HIGH = LV_LAST.

  APPEND S_EDATE.



ENDFORM.




*&---------------------------------------------------------------------*

*&      Form  INIT_DEFAULT

*&---------------------------------------------------------------------*

*       text

*----------------------------------------------------------------------*

*  -->  p1        text

*  <--  p2        text

*----------------------------------------------------------------------*




FORM MODIFY_SCREEN. " ### ## ### ## ## ## ##



  LOOP AT SCREEN.

    IF SCREEN-GROUP1 = 'M2'.

      IF P_RBUT2 = C_X OR P_RBUT3 = C_X.

        SCREEN-ACTIVE = 1.

      ELSE.

        SCREEN-ACTIVE = 0.

      ENDIF.

      MODIFY SCREEN.

    ENDIF.



    IF SCREEN-GROUP1 = 'M1'.

      IF P_RBUT1 = C_X.

        SCREEN-ACTIVE = 1.

      ELSE.

        SCREEN-ACTIVE = 0.

      ENDIF.

      MODIFY SCREEN.

    ENDIF.



    IF SCREEN-GROUP1 = 'UC2'.

      IF P_RBUT1 = C_X.

        SCREEN-ACTIVE = 1.

      ELSE.

        SCREEN-ACTIVE = 0.

      ENDIF.

      MODIFY SCREEN.

    ENDIF.

  ENDLOOP.



ENDFORM.




*&---------------------------------------------------------------------*

*&      Form  GET_DATA

*&---------------------------------------------------------------------*

*       text

*----------------------------------------------------------------------*

*  -->  p1        text

*  <--  p2        text

*----------------------------------------------------------------------*




FORM GET_DATA . " ## ## ##



  DATA: LT_DATE TYPE RANGE OF ZEDT08_102-ZEDATE,

        LS_DATE LIKE LINE OF LT_DATE.



  CLEAR GT_EMPLOYEE.



  " ### ## 1## ##

  IF P_RBUT1 = C_X.

    LT_DATE[] = S_EDATE[].

    GV_DATE_HIGH = S_EDATE-HIGH.

  ELSE.

    " ## #### ##### P_YEAR, P_MONTH #### ## ## ##

    PERFORM BUILD_MONTH_DAY_RANGE.



    LT_DATE[] = GT_DATE[].

    S_EDATE[] = LT_DATE[].



    READ TABLE LT_DATE INDEX 1 INTO LS_DATE.

    IF SY-SUBRC = 0.

      GV_DATE_HIGH = LS_DATE-HIGH.

    ENDIF.



  ENDIF.



  " ### SELECT

  SELECT A~ZPERNR,

         B~ZPNAME,

         A~ZDEPRANK,

         A~ZDEPCODE,

         A~ZEDATE,

         A~ZQDATE,

         A~ZQFLAG,

         B~ZGENDER,

         B~ZADDRESS,

         C~ZBANKCODE,

         C~ZACCOUNT

    FROM ZEDT08_102 AS A

    LEFT OUTER JOIN ZEDT08_103 AS B ON A~ZPERNR = B~ZPERNR

    LEFT OUTER JOIN ZEDT08_106 AS C ON A~ZPERNR = C~ZPERNR

    WHERE A~ZPERNR   IN @S_PERNR

      AND A~ZEDATE   IN @S_EDATE

      AND A~ZDEPCODE IN @S_DCODE

    INTO CORRESPONDING FIELDS OF TABLE @GT_EMPLOYEE.



ENDFORM.




*&---------------------------------------------------------------------*

*&      Form  BUILD_MONTH_RANGE

*&---------------------------------------------------------------------*

*       text

*----------------------------------------------------------------------*

*  -->  p1        text

*  <--  p2        text

*----------------------------------------------------------------------*




"---------------------------------------------------------------

" # ## ## FORM

"---------------------------------------------------------------

FORM BUILD_MONTH_DAY_RANGE. " P_YEAR, P_MONTH ##### #### ## ## 1# ~ ## ## ## ##



  DATA: LV_LOW TYPE D,

        LV_HIGH TYPE D,

        LS_DATE LIKE LINE OF GT_DATE.



  REFRESH GT_DATE.



  " ## ## ## #### ## ## ###

  IF P_YEAR IS INITIAL OR P_MONTH IS INITIAL.

    MESSAGE E398(00) WITH '### ## #####.'.

  ENDIF.



  " ## ## ##

  LV_LOW = '00000000'.

  LV_LOW(4) = P_YEAR.

  LV_LOW+4(2) = P_MONTH.

  LV_LOW+6(2) = '01'.



  " ## ### # ##

  CALL FUNCTION 'LAST_DAY_OF_MONTHS'

    EXPORTING DAY_IN = LV_LOW

    IMPORTING LAST_DAY_OF_MONTH = LV_HIGH.



  " RANGE ### ##

  CLEAR LS_DATE.

  LS_DATE-SIGN = 'I'.

  LS_DATE-OPTION = 'BT'.

  LS_DATE-LOW = LV_LOW.

  LS_DATE-HIGH = LV_HIGH.

  APPEND LS_DATE TO GT_DATE.



ENDFORM.




*&---------------------------------------------------------------------*

*&      Form  POST_FILTER

*&---------------------------------------------------------------------*

*       text

*----------------------------------------------------------------------*

*  -->  p1        text

*  <--  p2        text

*----------------------------------------------------------------------*




FORM POST_FILTER . "DB ## # ## ###



  DELETE GT_EMPLOYEE WHERE ZEDATE > S_EDATE-HIGH.



  IF P_CHK1 = C_X.

    DELETE GT_EMPLOYEE WHERE ZQDATE IS NOT INITIAL.

  ENDIF.



ENDFORM.




*&---------------------------------------------------------------------*

*&      Form  CONVERT_KOR

*&---------------------------------------------------------------------*

*       text

*----------------------------------------------------------------------*

*  -->  p1        text

*  <--  p2        text

*----------------------------------------------------------------------*




FORM CONVERT_KOR . " ### #### ## #### ##



  LOOP AT GT_EMPLOYEE INTO GWA_EMPLOYEE.

    IF GWA_EMPLOYEE-ZQFLAG IS NOT INITIAL OR GWA_EMPLOYEE-ZQDATE IS NOT INITIAL.

      GWA_EMPLOYEE-ZQFLAG_T = '##'.

    ELSE.

      GWA_EMPLOYEE-ZQFLAG_T = '##'.

    ENDIF.



    IF GWA_EMPLOYEE-ZGENDER = 'M'.

      GWA_EMPLOYEE-ZGENDER = '##'.

    ELSEIF GWA_EMPLOYEE-ZGENDER = 'F'.

      GWA_EMPLOYEE-ZGENDER = '##'.

    ENDIF.



    CASE GWA_EMPLOYEE-ZBANKCODE.

      WHEN '001'.

        GWA_EMPLOYEE-ZBANKNAME = '##'.

      WHEN '002'.

        GWA_EMPLOYEE-ZBANKNAME = '##'.

      WHEN '003'.

        GWA_EMPLOYEE-ZBANKNAME = '##'.

      WHEN '004'.

        GWA_EMPLOYEE-ZBANKNAME = '##'.

      WHEN '005'.

        GWA_EMPLOYEE-ZBANKNAME = '###'.

      WHEN OTHERS.

        GWA_EMPLOYEE-ZBANKNAME = ''.

    ENDCASE.



    MODIFY GT_EMPLOYEE FROM GWA_EMPLOYEE.



  ENDLOOP.



ENDFORM.




*&---------------------------------------------------------------------*

*&      Form  ENRICH_DATA

*&---------------------------------------------------------------------*

*       text

*----------------------------------------------------------------------*

*  -->  p1        text

*  <--  p2        text

*----------------------------------------------------------------------*




FORM ENRICH_DATA . " ###, #### ### ### ##



  DATA: LT_DCODE TYPE TABLE OF ZEDT08_102-ZDEPCODE,

        WA_DCODE TYPE ZEDT08_102-ZDEPCODE,

        LT_RCODE TYPE TABLE OF ZEDT08_102-ZDEPRANK,

        WA_RCODE TYPE ZEDT08_102-ZDEPRANK.



  CLEAR GWA_EMPLOYEE.



  " GT_EMPLOYEE LOOP ## ## ## / ## ##

  LOOP AT GT_EMPLOYEE INTO GWA_EMPLOYEE.

    WA_DCODE = GWA_EMPLOYEE-ZDEPCODE.

    APPEND WA_DCODE TO LT_DCODE.



    WA_RCODE = GWA_EMPLOYEE-ZDEPRANK.

    APPEND WA_RCODE TO LT_RCODE.

  ENDLOOP.



  " ### ## ## ##

  SORT LT_DCODE BY TABLE_LINE.

  DELETE ADJACENT DUPLICATES FROM LT_DCODE.



  SORT LT_RCODE BY TABLE_LINE.

  DELETE ADJACENT DUPLICATES FROM LT_RCODE.



  CLEAR GT_DEP.



  " LOOP ### SELECT SINGLE ##

  LOOP AT LT_DCODE INTO WA_DCODE.

    CLEAR GWA_DEP.



    SELECT SINGLE ZDEPCODE

      INTO GWA_DEP-ZDEPCODE

      FROM ZEDT08_104

      WHERE ZDEPCODE = WA_DCODE.



    IF SY-SUBRC = 0.

      CASE GWA_DEP-ZDEPCODE.

        WHEN 'SS0001'.

          GWA_DEP-ZDEPNAME = '###'.

        WHEN 'SS0002'.

          GWA_DEP-ZDEPNAME = '###'.

        WHEN 'SS0003'.

          GWA_DEP-ZDEPNAME = '###'.

        WHEN 'SS0004'.

          GWA_DEP-ZDEPNAME = '###'.

        WHEN 'SS0005'.

          GWA_DEP-ZDEPNAME = '###'.

        WHEN 'SS0006'.

          GWA_DEP-ZDEPNAME = '###'.

        WHEN OTHERS.

          GWA_DEP-ZDEPNAME = ''.

      ENDCASE.



      APPEND GWA_DEP TO GT_DEP.

    ENDIF.

  ENDLOOP.



  CLEAR GT_RANK.



  " GT_RANK ##

  LOOP AT LT_RCODE INTO WA_RCODE.

    SELECT SINGLE ZDEPRANK

      INTO GWA_RANK-ZDEPRANK

      FROM ZEDT08_102

      WHERE ZDEPRANK = WA_RCODE.



    IF SY-SUBRC = 0.

      CASE GWA_RANK-ZDEPRANK.

        WHEN 'A'.

          GWA_RANK-ZRANKNAME = '##'.

        WHEN 'B'.

          GWA_RANK-ZRANKNAME = '##'.

        WHEN 'C'.

          GWA_RANK-ZRANKNAME = '##'.

        WHEN 'D'.

          GWA_RANK-ZRANKNAME = '##'.

        WHEN 'E'.

          GWA_RANK-ZRANKNAME = '##'.

        WHEN 'F'.

          GWA_RANK-ZRANKNAME = '##'.

        WHEN 'G'.

          GWA_RANK-ZRANKNAME = '##'.

        WHEN OTHERS.

          GWA_RANK-ZRANKNAME = ''.

      ENDCASE.



      APPEND GWA_RANK TO GT_RANK.

    ENDIF.

  ENDLOOP.



  CLEAR GWA_EMPLOYEE.



  " GT_EMPLOYEE# ## LOOP ## ### / ### ##

  LOOP AT GT_EMPLOYEE INTO GWA_EMPLOYEE.

    READ TABLE GT_DEP INTO GWA_DEP WITH KEY ZDEPCODE = GWA_EMPLOYEE-ZDEPCODE.



    IF SY-SUBRC = 0.

      GWA_EMPLOYEE-ZDEPNAME = GWA_DEP-ZDEPNAME.

    ELSE.

      CONTINUE.

    ENDIF.



    READ TABLE GT_RANK INTO GWA_RANK WITH KEY ZDEPRANK = GWA_EMPLOYEE-ZDEPRANK.



    IF SY-SUBRC = 0.

      GWA_EMPLOYEE-ZRANKNAME = GWA_RANK-ZRANKNAME.

    ENDIF.



    MODIFY GT_EMPLOYEE FROM GWA_EMPLOYEE.

  ENDLOOP.



ENDFORM.

FORM ADD_FCAT USING P_FIELD TYPE SLIS_FIELDNAME

                    P_TEXT TYPE CHAR40

                    P_DATAT TYPE CHAR1

                    P_KEY TYPE CHAR1. " ALV ## ##### ### #### ## #

  CLEAR GS_FIELDCAT.

  GS_FIELDCAT-FIELDNAME = P_FIELD.

  GS_FIELDCAT-SELTEXT_M = P_TEXT.



  " ### ### ### ##

  IF P_DATAT IS NOT INITIAL.

    GS_FIELDCAT-DATATYPE = P_DATAT.

  ENDIF.



  " # ### ### ##

  IF P_KEY = 'X'.

    GS_FIELDCAT-KEY = 'X'.

  ENDIF.



  APPEND GS_FIELDCAT TO GT_FIELDCAT.



ENDFORM.




*&---------------------------------------------------------------------*

*&      Form  BUILD_FIELDCAT

*&---------------------------------------------------------------------*

*       text

*----------------------------------------------------------------------*

*  -->  p1        text

*  <--  p2        text

*----------------------------------------------------------------------*




FORM BUILD_FIELDCAT . " ALV# ## #### ##



  REFRESH GT_FIELDCAT.

  PERFORM ADD_FCAT USING 'ZPERNR'    '####' '' 'X'.

  PERFORM ADD_FCAT USING 'ZPNAME'    '####' '' 'X'.

  PERFORM ADD_FCAT USING 'ZDEPCODE'  '####' '' ''.

  PERFORM ADD_FCAT USING 'ZDEPNAME'  '###'   '' ''.

  PERFORM ADD_FCAT USING 'ZRANKNAME' '###'   '' ''.

  PERFORM ADD_FCAT USING 'ZEDATE'    '###'   'D' ''.

  PERFORM ADD_FCAT USING 'ZQFLAG_T'  '####' '' ''.

  PERFORM ADD_FCAT USING 'ZGENDER'   '##'     '' ''.

  PERFORM ADD_FCAT USING 'ZADDRESS'  '##'     '' ''.

  PERFORM ADD_FCAT USING 'ZBANKCODE' '####' '' ''.

  PERFORM ADD_FCAT USING 'ZBANKNAME' '###'   '' ''.

  PERFORM ADD_FCAT USING 'ZACCOUNT'  '####' '' ''.



  CLEAR GS_LAYOUT.

  GS_LAYOUT-ZEBRA = C_X.

  GS_LAYOUT-COLWIDTH_OPTIMIZE = C_X.



ENDFORM.




*&---------------------------------------------------------------------*

*&      Form  BUILD_SORT

*&---------------------------------------------------------------------*

*       text

*----------------------------------------------------------------------*

*  -->  p1        text

*  <--  p2        text

*----------------------------------------------------------------------*




FORM BUILD_SORT . " ALV# ## ## ## ##

  REFRESH GT_SORT.



  CLEAR GS_SORT.

  GS_SORT-FIELDNAME = 'ZPERNR'.

  GS_SORT-UP = C_X.

  APPEND GS_SORT TO GT_SORT.



  CLEAR GS_SORT.

  GS_SORT-FIELDNAME = 'ZDEPCODE'.

  GS_SORT-UP = C_X.

  APPEND GS_SORT TO GT_SORT.



ENDFORM.




*&---------------------------------------------------------------------*

*&      Form  DISPLAY_ALV

*&---------------------------------------------------------------------*

*       text

*----------------------------------------------------------------------*

*  -->  p1        text

*  <--  p2        text

*----------------------------------------------------------------------*




FORM DISPLAY_ALV . " ALV ##



  CALL FUNCTION 'REUSE_ALV_GRID_DISPLAY'

    EXPORTING

      I_CALLBACK_PROGRAM = SY-REPID

      IT_FIELDCAT = GT_FIELDCAT

      IT_SORT = GT_SORT

      IS_LAYOUT = GS_LAYOUT

      I_SAVE = 'A'

    TABLES

      T_OUTTAB = GT_EMPLOYEE.



ENDFORM.




*&---------------------------------------------------------------------*

*&      Form  GET_BASE_FOR_SALARY

*&---------------------------------------------------------------------*

*       text

*----------------------------------------------------------------------*

*  -->  p1        text

*  <--  p2        text

*----------------------------------------------------------------------*




FORM GET_BASE_FOR_SALARY . " ## ## ### ## ##



  DATA: LV_DATE LIKE ZEDT08_102-DATBI.

  CLEAR: LV_DATE.

  CONCATENATE P_YEAR P_MONTH '01' INTO LV_DATE.



  " ### SELECT

  SELECT A~ZPERNR

           A~ZQDATE

           A~ZQFLAG

           B~ZRANK

           C~ZSALARY

      INTO CORRESPONDING FIELDS OF TABLE GT_SALARY

      FROM ZEDT08_102 AS A INNER JOIN ZEDT08_104 AS B

      ON A~ZPERNR = B~ZPERNR

      INNER JOIN ZEDT08_106 AS C

      ON A~ZPERNR = C~ZPERNR

      WHERE A~ZPERNR IN S_PERNR

      AND B~ZYEAR = P_YEAR

      AND C~ZYEAR = P_YEAR

      AND B~DATBI <= LV_DATE.



ENDFORM.




*&---------------------------------------------------------------------*

*&      Form  MODIFY_DATA_R2

*&---------------------------------------------------------------------*

*       text

*----------------------------------------------------------------------*

*  -->  p1        text

*  <--  p2        text

*----------------------------------------------------------------------*




FORM MODIFY_DATA_R2 . " ## ## # ### ####



  DATA : LV_DATE2(6).

  CLEAR : LV_DATE2.

  CONCATENATE P_YEAR P_MONTH INTO LV_DATE2.



  LOOP AT GT_SALARY INTO GS_SALARY.

    " ### ###

    IF GS_SALARY-ZQFLAG = C_X.

      IF GS_SALARY-ZQDATE+0(6) <= LV_DATE2.

        CONTINUE.

      ENDIF.

    ENDIF.



    " ## #### ### ### /12

    GS_SALARY-ZPAY = GS_SALARY-ZSALARY / 12.

    " ### A## #### 5## #### ##

    IF GS_SALARY-ZRANK = 'A'.

      GS_SALARY-ZPAY = GS_SALARY-ZPAY + '500.00'.

    ENDIF.



    " ### 0# ## #### ## ###.

    CHECK GS_SALARY-ZPAY NE 0.



    PERFORM UPDATE_PAY USING P_YEAR P_MONTH

                             GS_SALARY-ZPERNR

                             GS_SALARY-ZPAY

                       CHANGING GV_CHECK.

    " #### ## 1#### ##### ## ### #### ##

    IF GV_CHECK = C_X.

      STOP.

    ENDIF.

  ENDLOOP.



ENDFORM.




*&---------------------------------------------------------------------*

*&      Form  UPDATE_PAY

*&---------------------------------------------------------------------*

*       text

*----------------------------------------------------------------------*

*      -->P_GV_YEAR  text

*      -->P_GV_MON  text

*      -->P_GS_SALARY_ZPERNR  text

*      -->P_GS_SALARY_ZPAY  text

*      <--P_GV_CHECK  text

*----------------------------------------------------------------------*




FORM UPDATE_PAY  USING    PV_YEAR

                          PV_MON

                          P_ZPERNR

                          P_ZPAY

                 CHANGING PV_CHECK. " #### ## # ### ## ####



  CASE PV_MON. " #### ## ## # ## UPDATE

    WHEN '01'.

      UPDATE ZEDT08_105 SET ZMON01 = P_ZPAY

      WHERE ZPERNR = P_ZPERNR

      AND   ZYEAR = PV_YEAR.



      IF SY-SUBRC NE 0.

        PV_CHECK = C_X.

      ENDIF.

    WHEN '02'.

      UPDATE ZEDT08_105 SET ZMON02 = P_ZPAY

      WHERE ZPERNR = P_ZPERNR

      AND   ZYEAR = PV_YEAR.



      IF SY-SUBRC NE 0.

        PV_CHECK = C_X.

      ENDIF.

    WHEN '03'.

      UPDATE ZEDT08_105 SET ZMON03 = P_ZPAY

      WHERE ZPERNR = P_ZPERNR

      AND   ZYEAR = PV_YEAR.



      IF SY-SUBRC NE 0.

        PV_CHECK = C_X.

      ENDIF.

    WHEN '04'.

      UPDATE ZEDT08_105 SET ZMON04 = P_ZPAY

      WHERE ZPERNR = P_ZPERNR

      AND   ZYEAR = PV_YEAR.



      IF SY-SUBRC NE 0.

        PV_CHECK = C_X.

      ENDIF.

    WHEN '05'.

      UPDATE ZEDT08_105 SET ZMON05 = P_ZPAY

      WHERE ZPERNR = P_ZPERNR

      AND   ZYEAR = PV_YEAR.



      IF SY-SUBRC NE 0.

        PV_CHECK = C_X.

      ENDIF.

    WHEN '06'.

      UPDATE ZEDT08_105 SET ZMON06 = P_ZPAY

      WHERE ZPERNR = P_ZPERNR

      AND   ZYEAR = PV_YEAR.



      IF SY-SUBRC NE 0.

        PV_CHECK = C_X.

      ENDIF.

    WHEN '07'.

      UPDATE ZEDT08_105 SET ZMON07 = P_ZPAY

      WHERE ZPERNR = P_ZPERNR

      AND   ZYEAR = PV_YEAR.



      IF SY-SUBRC NE 0.

        PV_CHECK = C_X.

      ENDIF.

    WHEN '08'.

      UPDATE ZEDT08_105 SET ZMON08 = P_ZPAY

      WHERE ZPERNR = P_ZPERNR

      AND   ZYEAR = PV_YEAR.



      IF SY-SUBRC NE 0.

        PV_CHECK = C_X.

      ENDIF.

    WHEN '09'.

      UPDATE ZEDT08_105 SET ZMON09 = P_ZPAY

      WHERE ZPERNR = P_ZPERNR

      AND   ZYEAR = PV_YEAR.



      IF SY-SUBRC NE 0.

        PV_CHECK = C_X.

      ENDIF.

    WHEN '10'.

      UPDATE ZEDT08_105 SET ZMON10 = P_ZPAY

      WHERE ZPERNR = P_ZPERNR

      AND   ZYEAR = PV_YEAR.



      IF SY-SUBRC NE 0.

        PV_CHECK = C_X.

      ENDIF.

    WHEN '11'.

      UPDATE ZEDT08_105 SET ZMON11 = P_ZPAY

      WHERE ZPERNR = P_ZPERNR

      AND   ZYEAR = PV_YEAR.



      IF SY-SUBRC NE 0.

        PV_CHECK = C_X.

      ENDIF.

    WHEN '12'.

      UPDATE ZEDT08_105 SET ZMON12 = P_ZPAY

      WHERE ZPERNR = P_ZPERNR

      AND   ZYEAR = PV_YEAR.



      " UPDATE# #### ##

      IF SY-SUBRC NE 0.

        PV_CHECK = C_X.

      ENDIF.

  ENDCASE.



ENDFORM.




*&---------------------------------------------------------------------*

*&      Form  SELECT_DATA_R3

*&---------------------------------------------------------------------*

*       text

*----------------------------------------------------------------------*

*  -->  p1        text

*  <--  p2        text

*----------------------------------------------------------------------*




FORM SELECT_DATA_R3 . " ## # ## ## ### ##



  SELECT A~ZPERNR "####

         B~ZPNAME "####

         A~ZDEPCODE "####

         A~ZDEPRANK "####

         A~ZEDATE "###




*         A~ZQFLAG "####




         C~ZRANK "####

         D~ZSALARY "####

    INTO CORRESPONDING FIELDS OF TABLE GT_ASSESS

    FROM ZEDT08_102 AS A  INNER JOIN ZEDT08_103 AS B

    ON A~ZPERNR = B~ZPERNR

    INNER JOIN ZEDT08_104 AS C

    ON A~ZPERNR = C~ZPERNR

    INNER JOIN ZEDT08_106 AS D

    ON A~ZPERNR = D~ZPERNR

    WHERE A~ZPERNR IN S_PERNR




*    AND   A~ZQFLAG NE C_X




    AND   C~ZYEAR = P_YEAR

    AND   D~ZYEAR = P_YEAR.



ENDFORM.




*&---------------------------------------------------------------------*

*&      Form  MODIFY_DATA_R3

*&---------------------------------------------------------------------*

*       text

*----------------------------------------------------------------------*

*  -->  p1        text

*  <--  p2        text

*----------------------------------------------------------------------*




FORM MODIFY_DATA_R3 . " ### #### ALV ###



  LOOP AT GT_ASSESS INTO GS_ASSESS.

    CLEAR : GS_ASSESS_ALV.

    MOVE-CORRESPONDING GS_ASSESS TO GS_ASSESS_ALV.



    " ## ## ### ### ##

    PERFORM GET_PAY USING P_YEAR P_MONTH

                          GS_ASSESS_ALV-ZPERNR

                    CHANGING GS_ASSESS_ALV-ZMON.



    " #### -> ##### ##

    PERFORM MAKE_DEPCODE USING GS_ASSESS_ALV-ZDEPCODE

                         CHANGING GS_ASSESS_ALV-ZDEPCODE_NAME.



    " ## ## -> ##### ##

    PERFORM MAKE_RANK USING GS_ASSESS-ZDEPRANK

                      CHANGING GS_ASSESS_ALV-ZDEPRANK_NAME.



    " ### ### 0# ## #### ALV #### ##

    IF GS_ASSESS_ALV-ZMON NE 0.

      APPEND GS_ASSESS_ALV TO GT_ASSESS_ALV.

    ENDIF.

  ENDLOOP.



ENDFORM.




*&---------------------------------------------------------------------*

*&      Form  GET_PAY

*&---------------------------------------------------------------------*

*       text

*----------------------------------------------------------------------*

*      -->P_GV_YEAR  text

*      -->P_GV_MON  text

*      -->P_GS_ASSESS_ALV_ZPERNR  text

*      <--P_GS_ASSESS_ALV_ZMON  text

*----------------------------------------------------------------------*




FORM GET_PAY  USING    PV_YEAR

                       PV_MON

                       P_ZPERNR

              CHANGING P_ZMON. " ##### P_MONTH# #### ## ##



  " P_MONTH #### ## ## ## # ### SELECT

  CASE PV_MON.

    WHEN '01'.

      SELECT SINGLE ZMON01 FROM ZEDT08_105 INTO P_ZMON

        WHERE ZPERNR = P_ZPERNR

        AND ZYEAR = PV_YEAR.

    WHEN '02'.

      SELECT SINGLE ZMON02 FROM ZEDT08_105 INTO P_ZMON

        WHERE ZPERNR = P_ZPERNR

        AND ZYEAR = PV_YEAR.

    WHEN '03'.

      SELECT SINGLE ZMON03 FROM ZEDT08_105 INTO P_ZMON

        WHERE ZPERNR = P_ZPERNR

        AND ZYEAR = PV_YEAR.

    WHEN '04'.

      SELECT SINGLE ZMON04 FROM ZEDT08_105 INTO P_ZMON

        WHERE ZPERNR = P_ZPERNR

        AND ZYEAR = PV_YEAR.

    WHEN '05'.

      SELECT SINGLE ZMON05 FROM ZEDT08_105 INTO P_ZMON

        WHERE ZPERNR = P_ZPERNR

        AND ZYEAR = PV_YEAR.

    WHEN '06'.

      SELECT SINGLE ZMON06 FROM ZEDT08_105 INTO P_ZMON

        WHERE ZPERNR = P_ZPERNR

        AND ZYEAR = PV_YEAR.

    WHEN '07'.

      SELECT SINGLE ZMON07 FROM ZEDT08_105 INTO P_ZMON

        WHERE ZPERNR = P_ZPERNR

        AND ZYEAR = PV_YEAR.

    WHEN '08'.

      SELECT SINGLE ZMON08 FROM ZEDT08_105 INTO P_ZMON

        WHERE ZPERNR = P_ZPERNR

        AND ZYEAR = PV_YEAR.

    WHEN '09'.

      SELECT SINGLE ZMON09 FROM ZEDT08_105 INTO P_ZMON

        WHERE ZPERNR = P_ZPERNR

        AND ZYEAR = PV_YEAR.

    WHEN '10'.

      SELECT SINGLE ZMON10 FROM ZEDT08_105 INTO P_ZMON

        WHERE ZPERNR = P_ZPERNR

        AND ZYEAR = PV_YEAR.

    WHEN '11'.

      SELECT SINGLE ZMON11 FROM ZEDT08_105 INTO P_ZMON

        WHERE ZPERNR = P_ZPERNR

        AND ZYEAR = PV_YEAR.

    WHEN '12'.

      SELECT SINGLE ZMON12 FROM ZEDT08_105 INTO P_ZMON

        WHERE ZPERNR = P_ZPERNR

        AND ZYEAR = PV_YEAR.

  ENDCASE.



ENDFORM.




*&---------------------------------------------------------------------*

*&      Form  MAKE_DEPCODE

*&---------------------------------------------------------------------*

*       text

*----------------------------------------------------------------------*

*      -->P_GS_ASSESS_ALV_ZDEPCODE  text

*      <--P_GS_ASSESS_ALV_ZDEPCODE_NAME  text

*----------------------------------------------------------------------*




FORM MAKE_DEPCODE  USING    P_ZEDPCODE

                   CHANGING P_ZEDPCODE_NAME. " ## ### ##### ##



  CASE P_ZEDPCODE.

    WHEN 'SS0001'.

      P_ZEDPCODE_NAME = '###'.

    WHEN 'SS0002'.

      P_ZEDPCODE_NAME = '###'.

    WHEN 'SS0003'.

      P_ZEDPCODE_NAME = '###'.

    WHEN 'SS0004'.

      P_ZEDPCODE_NAME = '###'.

    WHEN 'SS0005'.

      P_ZEDPCODE_NAME = '###'.

    WHEN 'SS0006'.

      P_ZEDPCODE_NAME = '###'.

  ENDCASE.



ENDFORM.




*&---------------------------------------------------------------------*

*&      Form  MAKE_RANK

*&---------------------------------------------------------------------*

*       text

*----------------------------------------------------------------------*

*      -->P_GS_ASSESS_ZDEPRANK  text

*      <--P_GS_ASSESS_ALV_ZDEPRANK_NAME  text

*----------------------------------------------------------------------*




FORM MAKE_RANK  USING    P_RANK

                CHANGING P_RANK_NAME. " ## ### ##### ##



  CASE P_RANK.

    WHEN 'A'.

      P_RANK_NAME = '##'.

    WHEN 'B'.

      P_RANK_NAME = '##'.

    WHEN 'C'.

      P_RANK_NAME = '##'.

    WHEN 'D'.

      P_RANK_NAME = '##'.

    WHEN 'E'.

      P_RANK_NAME = '##'.

    WHEN 'F'.

      P_RANK_NAME = '##'.

    WHEN 'G'.

      P_RANK_NAME = '##'.

  ENDCASE.



ENDFORM.




*&---------------------------------------------------------------------*

*&      Form  ALV_DISPLAY_R3

*&---------------------------------------------------------------------*

*       text

*----------------------------------------------------------------------*

*  -->  p1        text

*  <--  p2        text

*----------------------------------------------------------------------*




FORM ALV_DISPLAY_R3 . " ALV ## ## ##



  PERFORM FIELD_CATALOG. " ## #### ##

  PERFORM SET_LAYOUT. " #### ##

  PERFORM SET_SORT. " ##

  PERFORM CALL_ALV TABLES GT_ASSESS_ALV. " ALV ##



ENDFORM.




*&---------------------------------------------------------------------*

*&      Form  FIELD_CATALOG

*&---------------------------------------------------------------------*

*       text

*----------------------------------------------------------------------*

*  -->  p1        text

*  <--  p2        text

*----------------------------------------------------------------------*




FORM FIELD_CATALOG . " ## ## ALV# ## #### ##



  DATA : L_TEXT(10).



  " ## ##

  CLEAR: GS_FIELDCAT, GT_FIELDCAT.

  GS_FIELDCAT-COL_POS = 1.

  GS_FIELDCAT-FIELDNAME = 'ZPERNR'.

  GS_FIELDCAT-SELTEXT_M = '####'.

  GS_FIELDCAT-KEY = 'X'.

  APPEND GS_FIELDCAT TO GT_FIELDCAT.



  " ## ##

  CLEAR : GS_FIELDCAT.

  GS_FIELDCAT-COL_POS = 2.

  GS_FIELDCAT-FIELDNAME = 'ZPNAME'.

  GS_FIELDCAT-SELTEXT_M = '####'.

  GS_FIELDCAT-KEY = 'X'.

  APPEND GS_FIELDCAT TO GT_FIELDCAT.



  " ## ##

  CLEAR : GS_FIELDCAT.

  GS_FIELDCAT-COL_POS = 3.

  GS_FIELDCAT-FIELDNAME = 'ZDEPCODE'.

  GS_FIELDCAT-SELTEXT_M = '####'.

  APPEND GS_FIELDCAT TO GT_FIELDCAT.



  " ###

  CLEAR : GS_FIELDCAT.

  GS_FIELDCAT-COL_POS = 4.

  GS_FIELDCAT-FIELDNAME = 'ZDEPCODE_NAME'.

  GS_FIELDCAT-SELTEXT_M = '###'.

  APPEND GS_FIELDCAT TO GT_FIELDCAT.



  " ###

  CLEAR : GS_FIELDCAT.

  GS_FIELDCAT-COL_POS = 5.

  GS_FIELDCAT-FIELDNAME = 'ZDEPRANK_NAME'.

  GS_FIELDCAT-SELTEXT_M = '###'.

  APPEND GS_FIELDCAT TO GT_FIELDCAT.



  " ###

  CLEAR : GS_FIELDCAT.

  GS_FIELDCAT-COL_POS = 6.

  GS_FIELDCAT-FIELDNAME = 'ZEDATE'.

  GS_FIELDCAT-SELTEXT_M = '###'.

  GS_FIELDCAT-OUTPUTLEN = '10'.

  APPEND GS_FIELDCAT TO GT_FIELDCAT.





  IF P_RBUT1 = C_X.

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

    GS_FIELDCAT-FIELDNAME = 'ZBANK_NAME'.

    GS_FIELDCAT-SELTEXT_M = '###'.

    APPEND GS_FIELDCAT TO GT_FIELDCAT.



    CLEAR : GS_FIELDCAT.

    GS_FIELDCAT-COL_POS = 11.

    GS_FIELDCAT-FIELDNAME = 'ZACCOUNT'.

    GS_FIELDCAT-SELTEXT_M = '####'.

    APPEND GS_FIELDCAT TO GT_FIELDCAT.

  ELSEIF P_RBUT3 = 'X'.

    CLEAR : GS_FIELDCAT.

    GS_FIELDCAT-COL_POS = 7.

    GS_FIELDCAT-FIELDNAME = 'ZSALARY'.

    GS_FIELDCAT-SELTEXT_M = '####'.

    GS_FIELDCAT-OUTPUTLEN = '20'.

    GS_FIELDCAT-CURRENCY = 'KRW'.

    GS_FIELDCAT-DO_SUM = C_X.

    APPEND GS_FIELDCAT TO GT_FIELDCAT.



    CLEAR : GS_FIELDCAT.

    GS_FIELDCAT-COL_POS = 8.

    GS_FIELDCAT-FIELDNAME = 'ZRANK'.

    GS_FIELDCAT-SELTEXT_M = '####'.

    APPEND GS_FIELDCAT TO GT_FIELDCAT.



    CLEAR : GS_FIELDCAT, L_TEXT.

    GS_FIELDCAT-COL_POS = 9.

    GS_FIELDCAT-FIELDNAME = 'ZMON'.

    CONCATENATE P_MONTH '####' INTO L_TEXT.

    GS_FIELDCAT-SELTEXT_M = L_TEXT.

    GS_FIELDCAT-CURRENCY = 'KRW'.

    GS_FIELDCAT-DO_SUM = C_X.

    APPEND GS_FIELDCAT TO GT_FIELDCAT.

  ENDIF.



ENDFORM.




*&---------------------------------------------------------------------*

*&      Form  SET_LAYOUT

*&---------------------------------------------------------------------*

*       text

*----------------------------------------------------------------------*

*  -->  p1        text

*  <--  p2        text

*----------------------------------------------------------------------*




FORM SET_LAYOUT . " ## ## ALV# #### ##



  CLEAR GS_LAYOUT.

  GS_LAYOUT-ZEBRA = C_X. " # # ##



ENDFORM.




*&---------------------------------------------------------------------*

*&      Form  SET_SORT

*&---------------------------------------------------------------------*

*       text

*----------------------------------------------------------------------*

*  -->  p1        text

*  <--  p2        text

*----------------------------------------------------------------------*




FORM SET_SORT . " ALV# ## ## ##



  CLEAR : GS_SORT, GT_SORT.



  " #### ## ## ##

  GS_SORT-SPOS = 1.

  GS_SORT-FIELDNAME = 'ZPERNR'.

  GS_SORT-UP = C_X.

  APPEND GS_SORT TO GT_SORT.



ENDFORM.




*&---------------------------------------------------------------------*

*&      Form  CALL_ALV

*&---------------------------------------------------------------------*

*       text

*----------------------------------------------------------------------*

*      -->P_GT_ASSESS_ALV  text

*----------------------------------------------------------------------*




FORM CALL_ALV TABLES PT_ALV . " ## ## ALV ##



  CALL FUNCTION 'REUSE_ALV_GRID_DISPLAY'

   EXPORTING

     IT_FIELDCAT = GT_FIELDCAT

     IS_LAYOUT = GS_LAYOUT

     IT_SORT = GT_SORT

    TABLES

      T_OUTTAB = PT_ALV.



ENDFORM.








*Messages

*----------------------------------------------------------

*

* Message class: 00

*398   & & & &

*

* Message class: Hard coded

*   ## ### ####.