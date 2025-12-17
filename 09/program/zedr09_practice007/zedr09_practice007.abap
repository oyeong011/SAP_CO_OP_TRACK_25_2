
*&---------------------------------------------------------------------*

*& Report ZEDR09_PRACTICE007

*&---------------------------------------------------------------------*

*&

*&---------------------------------------------------------------------*




REPORT ZEDR09_PRACTICE007 MESSAGE-ID ZMED09.








*---------------------------------------------------------------

* ## ### ## ## ### 2## ##

* - #### -> p_mon ### zsalary ### #### ## ## (UPDATE_SALARY_BY_MON ##)

* - #### -> p_mon ### zsalary # ### #### ## ( GET_ZSALARY_MON ## )

*---------------------------------------------------------------



*---------------------------------------------------------------

* ##, ## ##

*---------------------------------------------------------------




TABLES : ZEDT09_102.



" ####, ##, 'X' ##

CONSTANTS : C_STATUS_EMP TYPE C LENGTH 10 VALUE '##',

            C_STATUS_RET TYPE C LENGTH 10 VALUE '##',

            C_GENDER_M TYPE C LENGTH 10 VALUE '##',

            C_GENDER_F TYPE C LENGTH 10 VALUE '##',

            C_X TYPE C VALUE 'X'.



" #### range ##

RANGES : GR_QFLAG FOR ZEDT09_102-ZQFLAG.



" ######, ####, sort ##

DATA : GS_FIELDCAT TYPE SLIS_FIELDCAT_ALV.    "######

DATA : GT_FIELDCAT TYPE SLIS_T_FIELDCAT_ALV.



DATA : GS_LAYOUT TYPE SLIS_LAYOUT_ALV.        "####



DATA : GS_SORT TYPE SLIS_SORTINFO_ALV.        "sort

DATA : GT_SORT TYPE SLIS_T_SORTINFO_ALV.





"#### ######

DATA : BEGIN OF GS_EMPLOYEE,

   ZPERNR LIKE ZEDT09_102-ZPERNR, "####

   ZPNAME LIKE ZEDT09_103-ZPNAME, "####

   ZDEPCODE LIKE ZEDT09_102-ZDEPCODE, "####

   ZDEPRANK LIKE ZEDT09_102-ZDEPRANK, "####

   ZEDATE LIKE ZEDT09_102-ZEDATE, "###

   ZQFLAG LIKE ZEDT09_102-ZQFLAG, "####

   ZGENDER LIKE ZEDT09_103-ZGENDER, "##

   ZADDRESS LIKE ZEDT09_103-ZADDRESS, "##

   ZBANKCODE LIKE ZEDT09_106-ZBANKCODE, "####

   ZACCOUNT LIKE ZEDT09_106-ZACCOUNT, "####

END OF GS_EMPLOYEE.

DATA : GT_EMPLOYEE LIKE TABLE OF GS_EMPLOYEE.



"#### ###### ALV

DATA : BEGIN OF GS_EMPLOYEE_ALV,

   ZPERNR LIKE ZEDT09_102-ZPERNR, "####

   ZPNAME LIKE ZEDT09_103-ZPNAME, "####

   ZDEPCODE LIKE ZEDT09_102-ZDEPCODE, "####

   ZDEPNAME_C TYPE C LENGTH 20, "### (###### XX#)

   ZDEPNAME_R TYPE C LENGTH 20, "### (###### ##,##..)

   ZEDATE LIKE ZEDT09_102-ZEDATE, "###

   ZQSTATUS TYPE C LENGTH 10, "#### (##### '##', ##### '##'

   ZGENDER_N TYPE C LENGTH 10, "## ('M'## ##, 'F'# ##)

   ZADDRESS LIKE ZEDT09_103-ZADDRESS, "##

   ZBANKCODE LIKE ZEDT09_106-ZBANKCODE, "####

   ZBANKNAME TYPE C LENGTH 10, "### (##### ## ##,##,##..)

   ZACCOUNT LIKE ZEDT09_106-ZACCOUNT, "####

END OF GS_EMPLOYEE_ALV.

DATA : GT_EMPLOYEE_ALV LIKE TABLE OF GS_EMPLOYEE_ALV.



"#### ######

DATA : BEGIN OF GS_SALARY,

  ZPERNR LIKE ZEDT09_102-ZPERNR,  "####

  ZEDATE LIKE ZEDT09_102-ZEDATE,  "####

  ZQDATE LIKE ZEDT09_102-ZQDATE,  "####

  ZQFLAG LIKE ZEDT09_102-ZQFLAG,  "####

  ZRANK  LIKE ZEDT09_104-ZRANK,   "####

  ZSALARY LIKE ZEDT09_106-ZSALARY, "#### (##)

END OF GS_SALARY.

DATA : GT_SALARY LIKE TABLE OF GS_SALARY.



"#### ######

DATA : BEGIN OF GS_ASSESS,

  ZPERNR LIKE ZEDT09_102-ZPERNR,  "####

  ZPNAME LIKE ZEDT09_103-ZPNAME,  "####

  ZDEPCODE LIKE ZEDT09_102-ZDEPCODE,  "####

  ZDEPRANK LIKE ZEDT09_102-ZDEPRANK,  "####

  ZEDATE LIKE ZEDT09_102-ZEDATE,      "###

  ZQDATE LIKE ZEDT09_102-ZQDATE,      "###

  ZQFLAG LIKE ZEDT09_102-ZQFLAG,      "####

  ZSALARY LIKE ZEDT09_106-ZSALARY,    "####

  ZRANK LIKE ZEDT09_104-ZRANK,        "####

END OF GS_ASSESS.

DATA : GT_ASSESS LIKE TABLE OF GS_ASSESS.



"#### ###### ALV#

DATA : BEGIN OF GS_ASSESS_ALV,

  ZPERNR LIKE ZEDT09_102-ZPERNR,  "####

  ZPNAME LIKE ZEDT09_103-ZPNAME,  "####

  ZDEPCODE LIKE ZEDT09_102-ZDEPCODE,  "####

  ZDEPCODE_C TYPE C LENGTH 20,        "###

  ZDEPNAME_R TYPE C LENGTH 20,        "###

  ZEDATE LIKE ZEDT09_102-ZEDATE,      "###

  ZSALARY LIKE ZEDT09_106-ZSALARY,    "####

  ZRANK LIKE ZEDT09_104-ZRANK,        "####

  ZSALARY_MON LIKE ZEDT09_106-ZSALARY,  "## ###

END OF GS_ASSESS_ALV.

DATA : GT_ASSESS_ALV LIKE TABLE OF GS_ASSESS_ALV.








*---------------------------------------------------------------

* ## ##

*---------------------------------------------------------------




SELECTION-SCREEN BEGIN OF BLOCK B1 WITH FRAME.

  "## - ####

  SELECT-OPTIONS : S_ZPERNR FOR ZEDT09_102-ZPERNR.



  "#### ## - ##, ####, modif id : A

  SELECT-OPTIONS : S_DATE FOR ZEDT09_102-DATBI NO-EXTENSION MODIF ID A.

  SELECT-OPTIONS : S_DEPT FOR ZEDT09_102-ZDEPCODE NO INTERVALS NO-EXTENSION MODIF ID A.



  "####, #### - #/#, modify id : B

  PARAMETERS : P_YEAR LIKE ZEDT09_104-ZYEAR MODIF ID B.

  PARAMETERS : P_MON TYPE MONAT MODIF ID B.

SELECTION-SCREEN END OF BLOCK B1.



"##### 3# - ####, ####, ####

SELECTION-SCREEN BEGIN OF BLOCK B2 WITH FRAME.

  PARAMETERS : P_R1 RADIOBUTTON GROUP R1 DEFAULT 'X' USER-COMMAND UC1. "####

  PARAMETERS : P_R2 RADIOBUTTON GROUP R1.             "####

  PARAMETERS : P_R3 RADIOBUTTON GROUP R1.             "####

SELECTION-SCREEN END OF BLOCK B2.



"#### #### (##### ##), modify id : C

SELECTION-SCREEN BEGIN OF BLOCK B3 WITH FRAME.

  PARAMETERS : Z_CHECK AS CHECKBOX DEFAULT 'X' MODIF ID C.  "####

SELECTION-SCREEN END OF BLOCK B3.






*---------------------------------------------------------------

* #### ### ##

*

* ## - #####+01.01 ~ ##### ####

* ## - #####, # - ### #

*---------------------------------------------------------------




INITIALIZATION.



  DATA : LV_FIRST_DAY TYPE SY-DATUM,

         LV_LAST_DAY TYPE SY-DATUM.



  "##

  LV_FIRST_DAY = SY-DATUM+0(4) && '01' && '01'.



  "###### ####

  CALL FUNCTION 'RP_LAST_DAY_OF_MONTHS'

    EXPORTING

      DAY_IN = SY-DATUM

    IMPORTING

      LAST_DAY_OF_MONTH = LV_LAST_DAY.



  "S_DATE# #####+01.01 ~ ##### #### ##

   S_DATE-SIGN = 'I'.

   S_DATE-OPTION = 'BT'.

   S_DATE-LOW = LV_FIRST_DAY.

   S_DATE-HIGH = LV_LAST_DAY.

   APPEND S_DATE.



   P_YEAR = SY-DATUM+0(4). "2025, ### ## ##

   P_MON = SY-DATUM+4(2).  "10, ### # ##










*---------------------------------------------------------------

* #### ##

*  - # ### ## ## # ##/###

*---------------------------------------------------------------




AT SELECTION-SCREEN OUTPUT.

  LOOP AT SCREEN.

    "###### #### ##

    CASE SCREEN-GROUP1.

      WHEN 'A' OR 'C'. "#### ## ### (A: ##, #### / C: #### ####)

       IF P_R1 = C_X.

         SCREEN-ACTIVE = '1'.

       ELSE.

         SCREEN-ACTIVE = '0'.

       ENDIF.

      WHEN 'B'. "####, #### ## (##, #)

       IF P_R1 = C_X.

         SCREEN-ACTIVE = '0'.

       ELSE.

         SCREEN-ACTIVE = '1'.

       ENDIF.

    ENDCASE.



    MODIFY SCREEN.

  ENDLOOP.






*---------------------------------------------------------------

* #### ##

*  - # ### ##, #####

*---------------------------------------------------------------




AT SELECTION-SCREEN.

  IF P_R1 = C_X.  "#### : ## ##

    IF S_DATE[] IS INITIAL OR S_DATE-LOW IS INITIAL OR S_DATE-HIGH IS INITIAL.

      MESSAGE E012.

      STOP.

    ENDIF.



  ELSE. "####/#### : #/# ##

    IF P_YEAR IS INITIAL OR P_MON IS INITIAL.

      MESSAGE E012.

      STOP.

    ENDIF.



  ENDIF.








*---------------------------------------------------------------

* ## ####

*---------------------------------------------------------------




START-OF-SELECTION.

  IF P_R1 = C_X. "#### ##

    PERFORM SELECT_EMPLOYEE.

    PERFORM MODIFY_EMPLOYEE.

    PERFORM ALV_EMPLOYEE.



  ELSEIF P_R2 = C_X. "#### ##

    PERFORM SELECT_SALARY.

    PERFORM MODIFY_SALARY.



  ELSEIF P_R3 = C_X. "#### ##

    PERFORM SELECT_ASSESS.

    PERFORM MODIFY_ASSESS.

    PERFORM ALV_ASSESS.

  ENDIF.










*---------------------------------------------------------------

* PERFORM

*---------------------------------------------------------------



*---------------------------------------------------------------

* FORM SELECT_EMPLOYEE

*

*---------------------------------------------------------------




FORM SELECT_EMPLOYEE.

  CLEAR : GR_QFLAG.



  "#### ## #, ### / ####, ### ##

  IF Z_CHECK = C_X.

    GR_QFLAG-SIGN = 'I'.

    GR_QFLAG-OPTION = 'EQ'.

    GR_QFLAG-LOW = ' '. "###

    APPEND GR_QFLAG.

  ELSE.

    GR_QFLAG-SIGN = 'I'.

    GR_QFLAG-OPTION = 'EQ'.

    GR_QFLAG-LOW = ' '.

    APPEND GR_QFLAG.

    GR_QFLAG-LOW = C_X.

    APPEND GR_QFLAG.

  ENDIF.



  SELECT a~ZPERNR

         b~ZPNAME

         a~ZDEPCODE

         a~ZDEPRANK

         a~ZEDATE

         a~ZQFLAG

         b~ZGENDER

         b~ZADDRESS

         c~ZBANKCODE

         c~ZACCOUNT

    FROM ZEDT09_102 AS a

    INNER JOIN ZEDT09_103 AS b

    ON a~ZPERNR = b~ZPERNR

    INNER JOIN ZEDT09_106 AS c

    ON a~ZPERNR = c~ZPERNR

    INTO CORRESPONDING FIELDS OF TABLE GT_EMPLOYEE

    WHERE a~DATBI >= S_DATE-LOW

    AND a~DATAB > S_DATE-HIGH

    AND a~ZEDATE < S_DATE-HIGH

    AND a~ZPERNR IN S_ZPERNR    "####

    AND a~ZDEPCODE IN S_DEPT   "####

    AND a~ZQFLAG IN GR_QFLAG. "##### ## ##



    "#### # #### ## #, ###### ## ##

    IF GT_EMPLOYEE[] IS INITIAL.

      MESSAGE I013.

      EXIT.

    ENDIF.



ENDFORM.






*---------------------------------------------------------------

* FORM MODIFY_EMPLOYEE

*  - ###, ###, ####, ##, ### ### (### itab# ###)

*---------------------------------------------------------------




FORM MODIFY_EMPLOYEE.



  LOOP AT GT_EMPLOYEE INTO GS_EMPLOYEE.

    CLEAR : GS_EMPLOYEE_ALV.

    MOVE-CORRESPONDING GS_EMPLOYEE TO GS_EMPLOYEE_ALV.



    "####, ## ####

    IF GS_EMPLOYEE-ZQFLAG = C_X.  "####

      GS_EMPLOYEE_ALV-ZQSTATUS = C_STATUS_RET.

    ELSE. "####

      GS_EMPLOYEE_ALV-ZQSTATUS = C_STATUS_EMP.

    ENDIF.



    IF GS_EMPLOYEE-ZGENDER = 'M'. "###

      GS_EMPLOYEE_ALV-ZGENDER_N = C_GENDER_M.

    ELSE. "###

      GS_EMPLOYEE_ALV-ZGENDER_N = C_GENDER_F.

    ENDIF.



    "### ###

    PERFORM CHANGE_ZDEPNAME_C USING GS_EMPLOYEE-ZDEPCODE

                              CHANGING GS_EMPLOYEE_ALV-ZDEPNAME_C.



    "### ###

    PERFORM CHANGE_ZDEPNAME_R USING GS_EMPLOYEE-ZDEPRANK

                              CHANGING GS_EMPLOYEE_ALV-ZDEPNAME_R.



    "### ###

    PERFORM CHANGE_ZBANKNAME USING GS_EMPLOYEE-ZBANKCODE

                             CHANGING GS_EMPLOYEE_ALV-ZBANKNAME.



    APPEND GS_EMPLOYEE_ALV TO GT_EMPLOYEE_ALV.

  ENDLOOP.



ENDFORM.






*---------------------------------------------------------------

* FORM ALV_EMPLOYEE

*  - ## ####, ####, sort , alv ##

*  - gt_employee_alv# ## ### alv# ####

*---------------------------------------------------------------




FORM ALV_EMPLOYEE.

  PERFORM FIELD_CATALOG_EMP. "######

  PERFORM ALV_LAYOUT.        "layout (##)

  PERFORM ALV_SORT.          "sort   (##)

  PERFORM CALL_ALV_EMP.      "alv ##

ENDFORM.








*---------------------------------------------------------------

* FORM SELECT_SALARY.

*  - ## ### <= #### ## ### ##

* -> ### ##### ## ###.. #### # ##(3#) ####,

*    ### <= 3.31 + ##### 'X' ## ##

*---------------------------------------------------------------




FORM SELECT_SALARY.



  "#### ## ### ##, ### ##

  DATA : LV_FIRST_DAY TYPE SY-DATUM.

  DATA : LV_LAST_DAY TYPE SY-DATUM.



  LV_FIRST_DAY = P_YEAR && P_MON && '01'.



  CALL FUNCTION 'RP_LAST_DAY_OF_MONTHS'

    EXPORTING

      DAY_IN = LV_FIRST_DAY

    IMPORTING

      LAST_DAY_OF_MONTH = LV_LAST_DAY.



  SELECT a~ZPERNR    "####

         a~ZEDATE    "###

         a~ZQDATE    "###

         a~ZQFLAG    "####

         b~ZRANK     "####

         c~ZSALARY   "##

    INTO CORRESPONDING FIELDS OF TABLE GT_SALARY

    FROM ZEDT09_102 AS a

    INNER JOIN ZEDT09_104 AS b

    ON a~ZPERNR = b~ZPERNR

    INNER JOIN ZEDT09_106 AS c

    ON a~ZPERNR = c~ZPERNR

    WHERE a~ZPERNR IN S_ZPERNR        "#### ## ###

    AND a~ZEDATE <= LV_FIRST_DAY      "##### <= #### ## ### ##

    AND NOT ( a~ZQDATE <= LV_LAST_DAY "#### ##### ### #### #### & ##### ##

      AND a~ZQFLAG = C_X ).



  "#### # #### ## #, ###### ## ##

  IF GT_SALARY[] IS INITIAL.

    MESSAGE I013.

    EXIT.

  ENDIF.



ENDFORM.








*---------------------------------------------------------------

* FORM MODIFY_SALARY.

*---------------------------------------------------------------




FORM MODIFY_SALARY.

  CLEAR : GS_SALARY.



  LOOP AT GT_SALARY INTO GS_SALARY.

    "## ## : ### ##/12##, ### 'A'#### #### 5## ##

    GS_SALARY-ZSALARY = GS_SALARY-ZSALARY / 12.



    IF GS_SALARY-ZRANK = 'A'.

      GS_SALARY-ZSALARY = GS_SALARY-ZSALARY + '500.00'.

    ENDIF.



    "##### 0# ##, #### ###

    CHECK GS_SALARY-ZSALARY > 0.



    "## ### ## ####, ZEDT09_105# ZMONXX ### ## ####### (####)

    PERFORM UPDATE_SALARY_BY_MON USING

                            GS_SALARY-ZPERNR

                            P_MON

                            GS_SALARY-ZSALARY.



  ENDLOOP.



  "#### ####, "### #######", #### "#### ##" #### ##.

  IF SY-SUBRC = 0.

    MESSAGE I015.

  ELSE.

    MESSAGE E016.

    EXIT.

  ENDIF.



ENDFORM.






*&---------------------------------------------------------------------*

*&      Form  UPDATE_SALARY_BY_MON

*&---------------------------------------------------------------------*




FORM UPDATE_SALARY_BY_MON  USING

                                    P_GS_SALARY_ZPERNR

                                    P_P_MON

                                    P_GS_SALARY_ZSALARY.



  DATA : LV_ZMON TYPE C LENGTH 20 VALUE 'ZMON',

         LS_ROW TYPE ZEDT09_105.

  CONCATENATE LV_ZMON P_P_MON INTO LV_ZMON. "zmon01, zmon02 ...



  "#### ## - ANY# #### ##

  FIELD-SYMBOLS <FS> TYPE ANY.



  "## # ##

  SELECT SINGLE *

    FROM ZEDT09_105

    INTO LS_ROW

    WHERE ZPERNR = P_GS_SALARY_ZPERNR.



  "ls_row ##### lv_zmon### ##, # ### #### <FS># ##

  ASSIGN COMPONENT LV_ZMON OF STRUCTURE LS_ROW TO <FS>.



  "<FS># ### ##

  <FS> = P_GS_SALARY_ZSALARY.



  "####### ## ##

  LS_ROW-AENAME = SY-UNAME.

  LS_ROW-AEDATE = SY-DATUM.

  LS_ROW-AEZEIT = SY-UZEIT.



  "# ####

  UPDATE ZEDT09_105 FROM LS_ROW.



  " ## # #### ## ##### ## #, #### ## (STOP)

  IF SY-SUBRC NE 0.

    MESSAGE I014.

    STOP.

  ENDIF.










*  CASE P_P_MON.

*    WHEN '01'.

*      UPDATE ZEDT09_105

*        SET ZMON01 = P_GS_SALARY_ZSALARY  "##

*            AENAME = SY-UNAME             "###

*            AEDATE = SY-DATUM             "####

*            AEZEIT = SY-UZEIT             "####

*        WHERE ZPERNR = GS_SALARY-ZPERNR.

*    WHEN '02'.

*      UPDATE ZEDT09_105

*        SET ZMON02 = P_GS_SALARY_ZSALARY  "##

*            AENAME = SY-UNAME             "###

*            AEDATE = SY-DATUM             "####

*            AEZEIT = SY-UZEIT             "####

*        WHERE ZPERNR = GS_SALARY-ZPERNR.

*    WHEN '03'.

*      UPDATE ZEDT09_105

*        SET ZMON03 = P_GS_SALARY_ZSALARY  "##

*            AENAME = SY-UNAME             "###

*            AEDATE = SY-DATUM             "####

*            AEZEIT = SY-UZEIT             "####

*        WHERE ZPERNR = GS_SALARY-ZPERNR.

*    WHEN '04'.

*      UPDATE ZEDT09_105

*        SET ZMON04 = P_GS_SALARY_ZSALARY  "##

*            AENAME = SY-UNAME             "###

*            AEDATE = SY-DATUM             "####

*            AEZEIT = SY-UZEIT             "####

*        WHERE ZPERNR = GS_SALARY-ZPERNR.

*    WHEN '05'.

*      UPDATE ZEDT09_105

*        SET ZMON05 = P_GS_SALARY_ZSALARY  "##

*            AENAME = SY-UNAME             "###

*            AEDATE = SY-DATUM             "####

*            AEZEIT = SY-UZEIT             "####

*        WHERE ZPERNR = GS_SALARY-ZPERNR.

*    WHEN '06'.

*      UPDATE ZEDT09_105

*        SET ZMON06 = P_GS_SALARY_ZSALARY  "##

*            AENAME = SY-UNAME             "###

*            AEDATE = SY-DATUM             "####

*            AEZEIT = SY-UZEIT             "####

*        WHERE ZPERNR = GS_SALARY-ZPERNR.

*    WHEN '07'.

*      UPDATE ZEDT09_105

*        SET ZMON07 = P_GS_SALARY_ZSALARY  "##

*            AENAME = SY-UNAME             "###

*            AEDATE = SY-DATUM             "####

*            AEZEIT = SY-UZEIT             "####

*        WHERE ZPERNR = GS_SALARY-ZPERNR.

*    WHEN '08'.

*      UPDATE ZEDT09_105

*        SET ZMON08 = P_GS_SALARY_ZSALARY  "##

*            AENAME = SY-UNAME             "###

*            AEDATE = SY-DATUM             "####

*            AEZEIT = SY-UZEIT             "####

*        WHERE ZPERNR = GS_SALARY-ZPERNR.

*    WHEN '09'.

*      UPDATE ZEDT09_105

*        SET ZMON09 = P_GS_SALARY_ZSALARY  "##

*            AENAME = SY-UNAME             "###

*            AEDATE = SY-DATUM             "####

*            AEZEIT = SY-UZEIT             "####

*        WHERE ZPERNR = GS_SALARY-ZPERNR.

*    WHEN '10'.

*      UPDATE ZEDT09_105

*        SET ZMON10 = P_GS_SALARY_ZSALARY  "##

*            AENAME = SY-UNAME             "###

*            AEDATE = SY-DATUM             "####

*            AEZEIT = SY-UZEIT             "####

*        WHERE ZPERNR = GS_SALARY-ZPERNR.

*    WHEN '11'.

*      UPDATE ZEDT09_105

*        SET ZMON11 = P_GS_SALARY_ZSALARY  "##

*            AENAME = SY-UNAME             "###

*            AEDATE = SY-DATUM             "####

*            AEZEIT = SY-UZEIT             "####

*        WHERE ZPERNR = GS_SALARY-ZPERNR.

*    WHEN '12'.

*      UPDATE ZEDT09_105

*        SET ZMON12 = P_GS_SALARY_ZSALARY  "##

*            AENAME = SY-UNAME             "###

*            AEDATE = SY-DATUM             "####

*            AEZEIT = SY-UZEIT             "####

*        WHERE ZPERNR = GS_SALARY-ZPERNR.

*

*    " ## # #### ## ##### ## #, #### ## (STOP)

*    IF SY-SUBRC NE 0.

*      MESSAGE I014.

*      STOP.

*    ENDIF.

*  ENDCASE.




ENDFORM.






*&---------------------------------------------------------------------*

*&      Form   SELECT_ASSESS



* - #### ###, ##### ## ##### ### ## ##

*  - ## ### <= #### ## ### ##

*  - #### : 3#

*  - ### ## : (### <= 3.31 + #### : 'X') ## ##

*----------------------------------------------------------------------*




FORM SELECT_ASSESS.



 "##### ## ### ##, ### ##

 DATA : LV_FIRST_DAY TYPE SY-DATUM.

 DATA : LV_LAST_DAY TYPE SY-DATUM.



 LV_FIRST_DAY = P_YEAR && P_MON && '01'.



 CALL FUNCTION 'RP_LAST_DAY_OF_MONTHS'

   EXPORTING

     DAY_IN = LV_FIRST_DAY

   IMPORTING

     LAST_DAY_OF_MONTH = LV_LAST_DAY.



 SELECT a~ZPERNR    "####

        b~ZPNAME    "####

        a~ZDEPCODE  "####

        a~ZDEPRANK  "####

        a~ZEDATE    "###

        a~ZQDATE    "###

        a~ZQFLAG    "####

        c~ZSALARY   "####

        d~ZRANK     "####

   INTO CORRESPONDING FIELDS OF TABLE GT_ASSESS

   FROM ZEDT09_102 AS a

   INNER JOIN ZEDT09_103 AS b

   ON a~ZPERNR = b~ZPERNR

   INNER JOIN ZEDT09_106 AS c

   ON a~ZPERNR = c~ZPERNR

   INNER JOIN ZEDT09_104 AS d

   ON a~ZPERNR = d~ZPERNR

   WHERE a~ZPERNR IN S_ZPERNR        "####

   AND a~ZEDATE <= LV_FIRST_DAY      "### <= #### ## ### #

   AND NOT ( a~ZQDATE <= LV_LAST_DAY "### ## (### <= #### ### # && ####)

     AND a~ZQFLAG = C_X ).



 "#### # #### ## #, ###### ## ##

 IF GT_ASSESS[] IS INITIAL.

   MESSAGE I013.

   EXIT.

 ENDIF.

ENDFORM.








*&---------------------------------------------------------------------*

*&      Form  MODIFY_ASSESS (#### alv ####)

*----------------------------------------------------------------------*




FORM MODIFY_ASSESS.

  CLEAR : GS_ASSESS.



  LOOP AT GT_ASSESS INTO GS_ASSESS.

    "gs_assess# ### alv# ## ###

    MOVE-CORRESPONDING GS_ASSESS TO GS_ASSESS_ALV.



    "## ####

    PERFORM GET_ZSALARY_MON USING GS_ASSESS-ZPERNR P_MON

                            CHANGING GS_ASSESS_ALV-ZSALARY_MON.



    "### 0# ### ###### #### ####

    IF GS_ASSESS_ALV-ZSALARY_MON = '0'.

      CONTINUE.

    ENDIF.



    "###, ### ### ## (## #### ## ##)

    PERFORM CHANGE_ZDEPNAME_C USING GS_ASSESS-ZDEPCODE

                              CHANGING GS_ASSESS_ALV-ZDEPCODE_C.



    PERFORM CHANGE_ZDEPNAME_R USING GS_ASSESS-ZDEPRANK

                              CHANGING GS_ASSESS_ALV-ZDEPNAME_R.



    APPEND GS_ASSESS_ALV TO GT_ASSESS_ALV.

  ENDLOOP.

ENDFORM.






*&---------------------------------------------------------------------*

*&      Form ALV_ASSESS (##### alv)

*&---------------------------------------------------------------------*




FORM ALV_ASSESS.

  PERFORM FIELD_CATALOG_ASSESS.  "### ######

  PERFORM ALV_LAYOUT.            "## layout

  PERFORM ALV_SORT.              "## sort

  PERFORM CALL_ALV_ACCESS.       "### alv ##

ENDFORM.






*&---------------------------------------------------------------------*

*&      Form  GET_ZSALARY_MON

*    - P_MON #### ### ###### ####

*&---------------------------------------------------------------------*




FORM GET_ZSALARY_MON  USING    P_GS_ASSESS_ZPERNR

                               P_P_MON

                      CHANGING P_GS_ASSESS_ALV_ZSALARY_MON.



    DATA : LV_ZMON TYPE C LENGTH 20 VALUE 'ZMON',

           LS_ROW TYPE ZEDT09_105.

    CONCATENATE LV_ZMON P_P_MON INTO LV_ZMON. "zmon01, zmon02...



    "#### ## - ANY# #### ##

    FIELD-SYMBOLS <FS> TYPE ANY.



    "## # ##

    SELECT SINGLE *

      FROM ZEDT09_105

      INTO LS_ROW

      WHERE ZPERNR = P_GS_ASSESS_ZPERNR.



    "ls_row ##### lv_zmon ### ##, # ### #### <FS># ##

    ASSIGN COMPONENT LV_ZMON OF STRUCTURE LS_ROW TO <FS>.



    "### <FS> #### ### ### alv# ##

    P_GS_ASSESS_ALV_ZSALARY_MON = <FS>.




*   CASE P_P_MON.

*     WHEN '01'.

*       SELECT SINGLE ZMON01

*         FROM ZEDT09_105

*         INTO P_GS_ASSESS_ALV_ZSALARY_MON

*         WHERE ZPERNR = P_GS_ASSESS_ZPERNR.

*     WHEN '02'.

*       SELECT SINGLE ZMON02

*         FROM ZEDT09_105

*         INTO P_GS_ASSESS_ALV_ZSALARY_MON

*         WHERE ZPERNR = P_GS_ASSESS_ZPERNR.

*     WHEN '03'.

*       SELECT SINGLE ZMON03

*         FROM ZEDT09_105

*         INTO P_GS_ASSESS_ALV_ZSALARY_MON

*         WHERE ZPERNR = P_GS_ASSESS_ZPERNR.

*     WHEN '04'.

*       SELECT SINGLE ZMON04

*         FROM ZEDT09_105

*         INTO P_GS_ASSESS_ALV_ZSALARY_MON

*         WHERE ZPERNR = P_GS_ASSESS_ZPERNR.

*     WHEN '05'.

*       SELECT SINGLE ZMON05

*         FROM ZEDT09_105

*         INTO P_GS_ASSESS_ALV_ZSALARY_MON

*         WHERE ZPERNR = P_GS_ASSESS_ZPERNR.

*     WHEN '06'.

*       SELECT SINGLE ZMON06

*         FROM ZEDT09_105

*         INTO P_GS_ASSESS_ALV_ZSALARY_MON

*         WHERE ZPERNR = P_GS_ASSESS_ZPERNR.

*     WHEN '07'.

*       SELECT SINGLE ZMON07

*         FROM ZEDT09_105

*         INTO P_GS_ASSESS_ALV_ZSALARY_MON

*         WHERE ZPERNR = P_GS_ASSESS_ZPERNR.

*     WHEN '08'.

*       SELECT SINGLE ZMON08

*         FROM ZEDT09_105

*         INTO P_GS_ASSESS_ALV_ZSALARY_MON

*         WHERE ZPERNR = P_GS_ASSESS_ZPERNR.

*     WHEN '09'.

*       SELECT SINGLE ZMON09

*         FROM ZEDT09_105

*         INTO P_GS_ASSESS_ALV_ZSALARY_MON

*         WHERE ZPERNR = P_GS_ASSESS_ZPERNR.

*     WHEN '10'.

*       SELECT SINGLE ZMON10

*         FROM ZEDT09_105

*         INTO P_GS_ASSESS_ALV_ZSALARY_MON

*         WHERE ZPERNR = P_GS_ASSESS_ZPERNR.

*     WHEN '11'.

*       SELECT SINGLE ZMON11

*         FROM ZEDT09_105

*         INTO P_GS_ASSESS_ALV_ZSALARY_MON

*         WHERE ZPERNR = P_GS_ASSESS_ZPERNR.

*     WHEN '12'.

*       SELECT SINGLE ZMON12

*         FROM ZEDT09_105

*         INTO P_GS_ASSESS_ALV_ZSALARY_MON

*         WHERE ZPERNR = P_GS_ASSESS_ZPERNR.

*   ENDCASE.






ENDFORM.






*&---------------------------------------------------------------------*

*&      Form  CHANGE_ZDEPNAME_C

*----------------------------------------------------------------------*




FORM CHANGE_ZDEPNAME_C  USING    P_GS_EMPLOYEE_ZDEPCODE

                        CHANGING P_GS_EMPLOYEE_ALV_ZDEPNAME_C.



  CASE P_GS_EMPLOYEE_ZDEPCODE.

    WHEN 'SS0001'.

      P_GS_EMPLOYEE_ALV_ZDEPNAME_C = '###'.

    WHEN 'SS0002'.

      P_GS_EMPLOYEE_ALV_ZDEPNAME_C = '###'.

    WHEN 'SS0003'.

      P_GS_EMPLOYEE_ALV_ZDEPNAME_C = '###'.

    WHEN 'SS0004'.

      P_GS_EMPLOYEE_ALV_ZDEPNAME_C = '###'.

    WHEN 'SS0005'.

      P_GS_EMPLOYEE_ALV_ZDEPNAME_C = '###'.

    WHEN 'SS0006'.

      P_GS_EMPLOYEE_ALV_ZDEPNAME_C = '###'.

  ENDCASE.



ENDFORM.






*&---------------------------------------------------------------------*

*&      Form  CHANGE_ZDEPNAME_R

*&---------------------------------------------------------------------*




FORM CHANGE_ZDEPNAME_R  USING    P_GS_EMPLOYEE_ZDEPRANK

                        CHANGING P_GS_EMPLOYEE_ALV_ZDEPNAME_R.



  CASE P_GS_EMPLOYEE_ZDEPRANK.

    WHEN 'A'.

      P_GS_EMPLOYEE_ALV_ZDEPNAME_R = '##'.

    WHEN 'B'.

      P_GS_EMPLOYEE_ALV_ZDEPNAME_R = '##'.

    WHEN 'C'.

      P_GS_EMPLOYEE_ALV_ZDEPNAME_R = '##'.

    WHEN 'D'.

      P_GS_EMPLOYEE_ALV_ZDEPNAME_R = '##'.

    WHEN 'E'.

      P_GS_EMPLOYEE_ALV_ZDEPNAME_R = '##'.

    WHEN 'F'.

      P_GS_EMPLOYEE_ALV_ZDEPNAME_R = '##'.

    WHEN 'G'.

      P_GS_EMPLOYEE_ALV_ZDEPNAME_R = '##'.

  ENDCASE.



ENDFORM.




*&---------------------------------------------------------------------*

*&      Form  CHANGE_ZBANKNAME

*&---------------------------------------------------------------------*




FORM CHANGE_ZBANKNAME  USING    P_GS_EMPLOYEE_ZBANKCODE

                       CHANGING P_GS_EMPLOYEE_ALV_ZBANKNAME.



  CASE P_GS_EMPLOYEE_ZBANKCODE.

    WHEN '001'.

      P_GS_EMPLOYEE_ALV_ZBANKNAME = '##'.

    WHEN '002'.

      P_GS_EMPLOYEE_ALV_ZBANKNAME = '##'.

    WHEN '003'.

      P_GS_EMPLOYEE_ALV_ZBANKNAME = '##'.

    WHEN '004'.

      P_GS_EMPLOYEE_ALV_ZBANKNAME = '##'.

    WHEN '005'.

      P_GS_EMPLOYEE_ALV_ZBANKNAME = '###'.

  ENDCASE.



ENDFORM.






*&---------------------------------------------------------------------*

*&      Form  FIELD_CATALOG_EMP

*&---------------------------------------------------------------------*




FORM FIELD_CATALOG_EMP .

  CLEAR : GS_FIELDCAT, GT_FIELDCAT.



  GS_FIELDCAT-COL_POS = 1.

  GS_FIELDCAT-FIELDNAME = 'ZPERNR'.

  GS_FIELDCAT-SELTEXT_M = '####'.

  GS_FIELDCAT-KEY = C_X.

  APPEND GS_FIELDCAT TO GT_FIELDCAT.



  CLEAR : GS_FIELDCAT.

  GS_FIELDCAT-COL_POS = 2.

  GS_FIELDCAT-FIELDNAME = 'ZPNAME'.

  GS_FIELDCAT-SELTEXT_M = '####'.

  GS_FIELDCAT-KEY = C_X.

  APPEND GS_FIELDCAT TO GT_FIELDCAT.



  CLEAR : GS_FIELDCAT.

  GS_FIELDCAT-COL_POS = 3.

  GS_FIELDCAT-FIELDNAME = 'ZDEPCODE'.

  GS_FIELDCAT-SELTEXT_M = '####'.

  APPEND GS_FIELDCAT TO GT_FIELDCAT.



  CLEAR : GS_FIELDCAT.

  GS_FIELDCAT-COL_POS = 4.

  GS_FIELDCAT-FIELDNAME = 'ZDEPNAME_C'.

  GS_FIELDCAT-SELTEXT_M = '###'.

  APPEND GS_FIELDCAT TO GT_FIELDCAT.



  CLEAR : GS_FIELDCAT.

  GS_FIELDCAT-COL_POS = 5.

  GS_FIELDCAT-FIELDNAME = 'ZDEPNAME_R'.

  GS_FIELDCAT-SELTEXT_M = '###'.

  APPEND GS_FIELDCAT TO GT_FIELDCAT.



  CLEAR : GS_FIELDCAT.

  GS_FIELDCAT-COL_POS = 6.

  GS_FIELDCAT-FIELDNAME = 'ZEDATE'.

  GS_FIELDCAT-SELTEXT_M = '###'.

  GS_FIELDCAT-OUTPUTLEN = '10'.

  APPEND GS_FIELDCAT TO GT_FIELDCAT.



  CLEAR : GS_FIELDCAT.

  GS_FIELDCAT-COL_POS = 7.

  GS_FIELDCAT-FIELDNAME = 'ZQSTATUS'.

  GS_FIELDCAT-SELTEXT_M = '####'.

  APPEND GS_FIELDCAT TO GT_FIELDCAT.



  CLEAR : GS_FIELDCAT.

  GS_FIELDCAT-COL_POS = 8.

  GS_FIELDCAT-FIELDNAME = 'ZGENDER_N'.

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

  GS_FIELDCAT-COL_POS = 12.

  GS_FIELDCAT-FIELDNAME = 'ZACCOUNT'.

  GS_FIELDCAT-SELTEXT_M = '####'.

  APPEND GS_FIELDCAT TO GT_FIELDCAT.



ENDFORM.






*&---------------------------------------------------------------------*

*&      Form  ALV_LAYOUT

*&---------------------------------------------------------------------*




FORM ALV_LAYOUT.

  CLEAR : GS_LAYOUT.

  GS_LAYOUT-ZEBRA = C_X.



ENDFORM.




*&---------------------------------------------------------------------*

*&      Form  ALV_SORT

*&---------------------------------------------------------------------*




FORM ALV_SORT.

  CLEAR : GS_SORT.

  GS_SORT-SPOS = 1.

  GS_SORT-FIELDNAME = 'ZPERNR'.

  GS_SORT-UP = C_X.

  APPEND GS_SORT TO GT_SORT.



ENDFORM.






*&---------------------------------------------------------------------*

*&      Form  CALL_ALV_EMP

*&---------------------------------------------------------------------*




FORM CALL_ALV_EMP .



   CALL FUNCTION 'REUSE_ALV_GRID_DISPLAY'

     EXPORTING

       IT_FIELDCAT = GT_FIELDCAT

       IS_LAYOUT = GS_LAYOUT

       IT_SORT = GT_SORT

     TABLES

       T_OUTTAB = GT_EMPLOYEE_ALV.



ENDFORM.






*&---------------------------------------------------------------------*

*&      Form  FIELD_CATALOG_ASSESS

* - ## ### ##(#)## ##

* - #### ####### ##### ## ## ## ## (1# ###, 2# ###..)

* - ## ## ### SUM ## ### #

*----------------------------------------------------------------------*




FORM FIELD_CATALOG_ASSESS .



  "#### ####### ##### ## ## ## ## (1# ###, 2# ###..)

  DATA : LV_SALARY_MON TYPE C LENGTH 20.



  CONCATENATE P_MON '####' INTO LV_SALARY_MON.



  CLEAR : GS_FIELDCAT, GT_FIELDCAT.



  GS_FIELDCAT-COL_POS = 1.

  GS_FIELDCAT-FIELDNAME = 'ZPERNR'.

  GS_FIELDCAT-SELTEXT_M = '####'.

  GS_FIELDCAT-KEY = C_X.

  APPEND GS_FIELDCAT TO GT_FIELDCAT.



  CLEAR : GS_FIELDCAT.

  GS_FIELDCAT-COL_POS = 2.

  GS_FIELDCAT-FIELDNAME = 'ZPNAME'.

  GS_FIELDCAT-SELTEXT_M = '####'.

  GS_FIELDCAT-KEY = C_X.

  APPEND GS_FIELDCAT TO GT_FIELDCAT.



  CLEAR : GS_FIELDCAT.

  GS_FIELDCAT-COL_POS = 3.

  GS_FIELDCAT-FIELDNAME = 'ZDEPCODE'.

  GS_FIELDCAT-SELTEXT_M = '####'.

  APPEND GS_FIELDCAT TO GT_FIELDCAT.



  CLEAR : GS_FIELDCAT.

  GS_FIELDCAT-COL_POS = 4.

  GS_FIELDCAT-FIELDNAME = 'ZDEPCODE_C'.

  GS_FIELDCAT-SELTEXT_M = '###'.

  APPEND GS_FIELDCAT TO GT_FIELDCAT.



  CLEAR : GS_FIELDCAT.

  GS_FIELDCAT-COL_POS = 5.

  GS_FIELDCAT-FIELDNAME = 'ZDEPNAME_R'.

  GS_FIELDCAT-SELTEXT_M = '###'.

  APPEND GS_FIELDCAT TO GT_FIELDCAT.



  CLEAR : GS_FIELDCAT.

  GS_FIELDCAT-COL_POS = 6.

  GS_FIELDCAT-FIELDNAME = 'ZEDATE'.

  GS_FIELDCAT-SELTEXT_M = '###'.

  GS_FIELDCAT-OUTPUTLEN = '10'.

  APPEND GS_FIELDCAT TO GT_FIELDCAT.



  CLEAR : GS_FIELDCAT.

  GS_FIELDCAT-COL_POS = 7.

  GS_FIELDCAT-FIELDNAME = 'ZSALARY'.

  GS_FIELDCAT-SELTEXT_M = '####'.

  GS_FIELDCAT-OUTPUTLEN = '20'.

  GS_FIELDCAT-DO_SUM = C_X.          "## ## ##

  GS_FIELDCAT-CURRENCY = 'KRW'.      "## ##

  APPEND GS_FIELDCAT TO GT_FIELDCAT.



  CLEAR : GS_FIELDCAT.

  GS_FIELDCAT-COL_POS = 8.

  GS_FIELDCAT-FIELDNAME = 'ZRANK'.

  GS_FIELDCAT-SELTEXT_M = '####'.

  APPEND GS_FIELDCAT TO GT_FIELDCAT.



  CLEAR : GS_FIELDCAT.

  GS_FIELDCAT-COL_POS = 9.

  GS_FIELDCAT-FIELDNAME = 'ZSALARY_MON'.

  GS_FIELDCAT-SELTEXT_M = LV_SALARY_MON.  "## #### concatenate# #####

  GS_FIELDCAT-OUTPUTLEN = '20'.

  GS_FIELDCAT-DO_SUM = C_X.          "## ## ##

  GS_FIELDCAT-CURRENCY = 'KRW'.      "## ##

  APPEND GS_FIELDCAT TO GT_FIELDCAT.



ENDFORM.






*&---------------------------------------------------------------------*

*&      Form  CALL_ALV_ACCESS

*&---------------------------------------------------------------------*




FORM CALL_ALV_ACCESS .

  CALL FUNCTION 'REUSE_ALV_GRID_DISPLAY'

    EXPORTING

      IT_FIELDCAT = GT_FIELDCAT

      IS_LAYOUT = GS_LAYOUT

      IT_SORT = GT_SORT

    TABLES

      T_OUTTAB = GT_ASSESS_ALV.

ENDFORM.