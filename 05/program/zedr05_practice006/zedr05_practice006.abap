
*&---------------------------------------------------------------------*

*& Report ZEDR05_PRACTICE006

*&---------------------------------------------------------------------*

*&

*&---------------------------------------------------------------------*






REPORT ZEDR05_PRACTICE006.






* TABLES ##




TABLES: ZEDT05_102,

        ZEDT05_103,

        ZEDT05_104,

        ZEDT05_105,

        ZEDT05_106.






* TYPES ##




" #### ### ###

TYPES: BEGIN OF TY_EMP_INFO,

         ZPERNR    TYPE ZEDT05_102-ZPERNR,    "####

         ZPNAME    TYPE ZEDT05_103-ZPNAME,    "####

         ZDEPCODE  TYPE ZEDT05_102-ZDEPCODE,  "####

         ZDEPNAME  TYPE CHAR20,               "###

         ZDEPRANK  TYPE ZEDT05_102-ZDEPRANK,  "####

         ZRANKNAME TYPE CHAR20,               "###

         ZEDATE    TYPE ZEDT05_102-ZEDATE,    "###

         ZQDATE    TYPE ZEDT05_102-ZQDATE,    "###

         ZQFLAG    TYPE ZEDT05_102-ZQFLAG,    "####(##/##)

         ZQFLAG_T    TYPE CHAR20,    "####(##/##)

         ZGENDER   TYPE ZEDT05_103-ZGENDER,   "##

         ZGENDER_T   TYPE CHAR20,   "##(##)

         ZADDRESS  TYPE ZEDT05_103-ZADDRESS,   "##

         ZBANKCODE TYPE ZEDT05_106-ZBANKCODE, "####

         ZBANKNAME TYPE CHAR20,               "###

         ZACCOUNT TYPE ZEDT05_106-ZACCOUNT,   "####

       END OF TY_EMP_INFO.



" #### ### ###

TYPES: BEGIN OF TY_SALARY,

         ZPERNR   TYPE ZEDT05_102-ZPERNR,    "####

         ZQDATE   TYPE ZEDT05_102-ZQDATE,    "###

         ZQFLAG   TYPE ZEDT05_102-ZQFLAG,    "####

         ZSALARY  TYPE ZEDT05_106-ZSALARY,   "####

         ZPAY_AMT TYPE ZEDT05_106-ZSALARY,    "###

         ZRANK    TYPE ZEDT05_104-ZRANK,     "####

       END OF TY_SALARY.



" #### ### ###

TYPES: BEGIN OF TY_EVAL,

         ZPERNR    TYPE ZEDT05_102-ZPERNR,    "####

         ZPNAME    TYPE ZEDT05_103-ZPNAME,    "####

         ZDEPCODE  TYPE ZEDT05_102-ZDEPCODE,  "####

         ZDEPNAME  TYPE CHAR20,               "###

         ZDEPRANK  TYPE ZEDT05_102-ZDEPRANK,  "####

         ZRANKNAME TYPE CHAR20,               "###

         ZEDATE    TYPE ZEDT05_102-ZEDATE,    "###

         ZQDATE    TYPE ZEDT05_102-ZQDATE,    "###

         ZQFLAG    TYPE ZEDT05_102-ZQFLAG,    "####(##/##)

         ZQFLAG_T    TYPE CHAR20,    "####(##/##)

         ZSALARY   TYPE ZEDT05_106-ZSALARY,   "####

         ZRANK     TYPE ZEDT05_104-ZRANK,     "####

         ZMON      TYPE CURR13_2,

         WAERS     TYPE WAERS,

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








* SELECTION SCREEN




SELECTION-SCREEN BEGIN OF BLOCK B1 WITH FRAME.



  " ## #### - ####

  SELECT-OPTIONS: S_PERNR FOR ZEDT05_102-ZPERNR MODIF ID ALL.



  " ##### ####

  SELECT-OPTIONS: S_DATE FOR ZEDT05_102-DATAB MODIF ID M1.

  SELECT-OPTIONS: S_DEPT FOR ZEDT05_102-ZDEPCODE MODIF ID M1.



  " ####/##### ####

  PARAMETERS: P_YEAR  TYPE ZEDT05_104-ZYEAR MODIF ID M2,

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




*----------------------------------------------------------------------*

* INITIALIZATION

*----------------------------------------------------------------------*




INITIALIZATION.



  PERFORM GET_LAST_OF_DAY.






*----------------------------------------------------------------------*

* AT SELECTION-SCREEN OUTPUT

*----------------------------------------------------------------------*




AT SELECTION-SCREEN OUTPUT.

  PERFORM SET_SCREEN_CONTROL.






*----------------------------------------------------------------------*

* AT SELECTION-SCREEN

*----------------------------------------------------------------------*




AT SELECTION-SCREEN.

  PERFORM CHECK_INPUT_VALUE.






*----------------------------------------------------------------------*

* START-OF-SELECTION

*----------------------------------------------------------------------*




START-OF-SELECTION.

  PERFORM MAIN_PROCESS.






*----------------------------------------------------------------------*

* END-OF-SELECTION

*----------------------------------------------------------------------*




"END-OF-SELECTION.




*&---------------------------------------------------------------------*

*&      Form  GET_LAST_OF_DAY

*&---------------------------------------------------------------------*

*       text

*----------------------------------------------------------------------*

*  -->  p1        text

*  <--  p2        text

*----------------------------------------------------------------------*




form GET_LAST_OF_DAY.



  " ####/#### ### ##

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




*   message id SY-MSGID type SY-MSGTY number SY-MSGNO

*              with SY-MSGV1 SY-MSGV2 SY-MSGV3 SY-MSGV4.




  endif.

  APPEND S_DATE.

endform.




*&---------------------------------------------------------------------*

*&      Form  SET_SCREEN_CONTROL

*&---------------------------------------------------------------------*

*       text

*----------------------------------------------------------------------*

*  -->  p1        text

*  <--  p2        text

*----------------------------------------------------------------------*




form SET_SCREEN_CONTROL .



  LOOP AT SCREEN.

    CASE SCREEN-GROUP1.

      WHEN 'M1'.

        IF P_RAD1 = C_X.

          SCREEN-ACTIVE = 1.

        ELSE.

          SCREEN-ACTIVE = 0.

        ENDIF.

      WHEN 'M2'.

        IF P_RAD2 = C_X OR P_RAD3 = C_X.

          SCREEN-ACTIVE = 1.

        ELSE.

          SCREEN-ACTIVE = 0.

        ENDIF.

      WHEN 'ALL'.

        SCREEN-ACTIVE = 1.

    ENDCASE.

    MODIFY SCREEN.

  ENDLOOP.



endform.




*&---------------------------------------------------------------------*

*&      Form  CHECK_INPUT_VALUE

*&---------------------------------------------------------------------*

*       text

*----------------------------------------------------------------------*

*  -->  p1        text

*  <--  p2        text

*----------------------------------------------------------------------*




form CHECK_INPUT_VALUE .



  IF P_RAD1 = C_X.  " #### ##

    IF S_DATE[] IS INITIAL.

      MESSAGE '##### ######.' TYPE 'E'.

      STOP.

    ENDIF.

  ELSEIF P_RAD2 = C_X or P_RAD3 = C_X.  " ####

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






*&---------------------------------------------------------------------*

*&      Form  MAIN_PROCESS

*&---------------------------------------------------------------------*

*       ## ## ##

*----------------------------------------------------------------------*




FORM MAIN_PROCESS.

  " ### ### ## ## ##




*  4. SELECT### JOIN# ### ####, join# ## 4## #### ### ##




  IF P_RAD1 = C_X.  " #### ##

    PERFORM GET_EMPLOYEE_INFO. " ## ## select#

    PERFORM DISPLAY_ALV_EMP_INFO. "## ## ALV ###

  ELSEIF P_RAD2 = C_X.  " ####

    PERFORM GET_SAL_INFO. " ## ## select#

  ELSEIF P_RAD3 = C_X.  " ####

    PERFORM GET_EVAL.

    PERFORM DISPLAY_ALV_EVAL.

  ENDIF.

ENDFORM.




*&---------------------------------------------------------------------*

*&      Form  GET_EMPLOYEE_INFO

*&---------------------------------------------------------------------*

*       text

*----------------------------------------------------------------------*

*  -->  p1        text

*  <--  p2        text

*----------------------------------------------------------------------*




form GET_EMPLOYEE_INFO .

  RANGES : R_Q_CON FOR ZEDT05_102-ZQFLAG.



  IF P_CHK1 = C_X.

    R_Q_CON-SIGN = 'I'.

    R_Q_CON-OPTION = 'NE'.

    R_Q_CON-LOW = 'X'.

    APPEND R_Q_CON.




*    DELETE

*      GT_EMP_INFO

*    WHERE

*      ZQDATE IS NOT INITIAL

*      AND ZQDATE <= S_DATE-HIGH.

*    IF GT_EMP_INFO[] IS INITIAL.

*      MESSAGE '## ### #### #### ####.' TYPE 'E'.

*      STOP.

*    ENDIF.




  ENDIF.







  SELECT

      A~ZPERNR,      B~ZPNAME,      A~ZDEPRANK,      A~ZDEPCODE,

      A~ZEDATE,      A~ZQDATE,      A~ZQFLAG,      B~ZGENDER,

      B~ZADDRESS,      C~ZBANKCODE,      C~ZACCOUNT

    FROM ZEDT05_102 AS A

    LEFT OUTER JOIN ZEDT05_103 AS B

      ON A~ZPERNR = B~ZPERNR

    LEFT OUTER JOIN ZEDT05_106 AS C

      ON A~ZPERNR = C~ZPERNR

    WHERE

      A~ZPERNR IN @S_PERNR

    AND

       A~ZEDATE <= @S_DATE-HIGH

    AND

      A~ZQFLAG IN @R_Q_CON

    INTO CORRESPONDING FIELDS OF TABLE @GT_EMP_INFO.



  IF GT_EMP_INFO[] IS INITIAL.

    MESSAGE '## ### #### ##### ####.' TYPE 'E'.

    STOP.

  ENDIF.









    " ### ## ##

  IF GT_EMP_INFO[] IS INITIAL.

    MESSAGE '## ### #### ##### ####.' TYPE 'E'.

  ENDIF.



  PERFORM CONVERT_KOR CHANGING GT_EMP_INFO.

endform.




*&---------------------------------------------------------------------*

*&      Form  CONVERT_KOR

*&---------------------------------------------------------------------*

*       text

*----------------------------------------------------------------------*

*  -->  p1        text

*  <--  p2        text

*----------------------------------------------------------------------*




FORM CONVERT_KOR

  CHANGING PT_DATA TYPE ANY TABLE.



  FIELD-SYMBOLS: <FS_DATA> TYPE ANY,

                 <FS_CODE> TYPE ANY,

                 <FS_NAME> TYPE ANY.



  LOOP AT PT_DATA ASSIGNING <FS_DATA>.



    " ## ##

    ASSIGN COMPONENT 'ZGENDER' OF STRUCTURE <FS_DATA> TO <FS_CODE>.

    IF SY-SUBRC = 0.

      ASSIGN COMPONENT 'ZGENDER_T' OF STRUCTURE <FS_DATA> TO <FS_NAME>.

      IF SY-SUBRC = 0.

        CASE <FS_CODE>.

          WHEN C_MALE.   <FS_NAME> = C_MALE_T.

          WHEN C_FEMALE. <FS_NAME> = C_FEMALE_T.

        ENDCASE.

      ENDIF.

    ENDIF.





    " ### ## ##

    ASSIGN COMPONENT 'ZDEPCODE' OF STRUCTURE <FS_DATA> TO <FS_CODE>.

    IF SY-SUBRC = 0.

      ASSIGN COMPONENT 'ZDEPNAME' OF STRUCTURE <FS_DATA> TO <FS_NAME>.

      IF SY-SUBRC = 0.

        CASE <FS_CODE>.  " # CODE# ##!

          WHEN 'SS0001'. <FS_NAME> = '###'.

          WHEN 'SS0002'. <FS_NAME> = '###'.

          WHEN 'SS0003'. <FS_NAME> = '###'.

          WHEN 'SS0004'. <FS_NAME> = '###'.

          WHEN 'SS0005'. <FS_NAME> = '###'.

          WHEN 'SS0006'. <FS_NAME> = '###'.

        ENDCASE.

      ENDIF.

    ENDIF.



    " ### ## ##

    ASSIGN COMPONENT 'ZDEPRANK' OF STRUCTURE <FS_DATA> TO <FS_CODE>.

    IF SY-SUBRC = 0.

      ASSIGN COMPONENT 'ZRANKNAME' OF STRUCTURE <FS_DATA> TO <FS_NAME>.

      IF SY-SUBRC = 0.

        CASE <FS_CODE>.

          WHEN 'A'. <FS_NAME> = '##'.

          WHEN 'B'. <FS_NAME> = '##'.

          WHEN 'C'. <FS_NAME> = '##'.

          WHEN 'D'. <FS_NAME> = '##'.

          WHEN 'E'. <FS_NAME> = '##'.

          WHEN 'F'. <FS_NAME> = '##'.

          WHEN 'G'. <FS_NAME> = '##'.

        ENDCASE.

      ENDIF.

    ENDIF.





     " #### ## ##

    ASSIGN COMPONENT 'ZQFLAG' OF STRUCTURE <FS_DATA> TO <FS_CODE>.

    IF SY-SUBRC = 0.

      ASSIGN COMPONENT 'ZQFLAG_T' OF STRUCTURE <FS_DATA> TO <FS_NAME>.

      IF SY-SUBRC = 0.

        IF <FS_CODE> ='X'.  " # CODE# ##!

          <FS_NAME> = C_QUIT_T.

        ELSE. <FS_NAME> = C_ACTIVE.

        ENDIF.

      ENDIF.

    ENDIF.



    " ### ## ##

    ASSIGN COMPONENT 'ZBANKCODE' OF STRUCTURE <FS_DATA> TO <FS_CODE>.

    IF SY-SUBRC = 0.

      ASSIGN COMPONENT 'ZBANKNAME' OF STRUCTURE <FS_DATA> TO <FS_NAME>.

      IF SY-SUBRC = 0.

        CASE <FS_CODE>.  " # CODE# ##!

          WHEN '001'. <FS_NAME> = '####'.

          WHEN '002'. <FS_NAME> = '####'.

          WHEN '003'. <FS_NAME> = '####'.

          WHEN '004'. <FS_NAME> = '####'.

          WHEN '005'. <FS_NAME> = '###'.

        ENDCASE.

      ENDIF.

    ENDIF.



  ENDLOOP.



ENDFORM.






*&---------------------------------------------------------------------*

*&      Form  SET_FIELDCAT_EMP_INFO

*&---------------------------------------------------------------------*

*       text

*----------------------------------------------------------------------*

*  -->  p1        text

*  <--  p2        text

*----------------------------------------------------------------------*

*&      Form  GET_SAL_INFO




FORM GET_SAL_INFO.

  DATA: LV_LAST_DAY TYPE DATUM,

        LV_MSG      TYPE STRING,

        LV_DATE_IN  TYPE DATUM.



  " ##

  SELECT A~ZPERNR, A~ZQDATE, C~ZSALARY, B~ZRANK

    FROM ZEDT05_102 AS A

    LEFT JOIN ZEDT05_104 AS B

      ON A~ZPERNR = B~ZPERNR

     AND B~ZYEAR = @P_YEAR

    LEFT JOIN ZEDT05_106 AS C

      ON A~ZPERNR = C~ZPERNR

    WHERE A~ZPERNR IN @S_PERNR

    INTO CORRESPONDING FIELDS OF TABLE @GT_SALARY.



  " ### ##

  CHECK GT_SALARY[] IS NOT INITIAL.



  " ### # ##

  CONCATENATE P_YEAR P_MONTH '01' INTO LV_DATE_IN.



  CALL FUNCTION 'RP_LAST_DAY_OF_MONTHS'

    EXPORTING

      DAY_IN            = LV_DATE_IN

    IMPORTING

      LAST_DAY_OF_MONTH = LV_LAST_DAY

    EXCEPTIONS

      OTHERS            = 1.



  IF SY-SUBRC <> 0.

    MESSAGE '# ### #### ####.' TYPE 'E'.

    RETURN.

  ENDIF.



  " ## ## ### (###, ## ## ##, ## 0 ##)

  DELETE GT_SALARY

    WHERE ( ZQDATE IS NOT INITIAL AND ZQDATE <= LV_LAST_DAY )

       OR ZRANK IS INITIAL

       OR ZSALARY = C_ZERO.



  " ### ## (#### #11)

  IF GT_SALARY[] IS INITIAL.

    MESSAGE '### ## #### ####.' TYPE 'E'.

    RETURN.

  ENDIF.



  " ## ## ##

  PERFORM PROCESS_SALARY CHANGING LV_MSG.



  " ## ###

  IF LV_MSG IS INITIAL.

    MESSAGE '### #######.' TYPE 'S'.

  ELSE.

    MESSAGE LV_MSG TYPE 'E'.

  ENDIF.



ENDFORM.






*&      Form  PROCESS_SALARY




FORM PROCESS_SALARY CHANGING P_MSG TYPE STRING.

  DATA: LT_105      TYPE TABLE OF ZEDT05_105,

        LS_105      TYPE ZEDT05_105,

        LS_SAL      TYPE TY_SALARY,

        LV_AMT      TYPE P DECIMALS 2,

        LV_BONUS    TYPE P DECIMALS 2,

        LV_COUNT    TYPE I.



  FIELD-SYMBOLS: <FS_105> TYPE ZEDT05_105.



  " 1. 105 ### ## ##

  IF GT_SALARY[] IS NOT INITIAL.

    SELECT *

      FROM ZEDT05_105

      INTO TABLE LT_105

      FOR ALL ENTRIES IN GT_SALARY

      WHERE ZPERNR = GT_SALARY-ZPERNR

        AND ZYEAR = P_YEAR.

  ENDIF.



  " 2. # ### ## ##

  LOOP AT GT_SALARY INTO LS_SAL.



    " ## ## (##/12 + A## ###)

    LV_AMT = LS_SAL-ZSALARY * 100 / C_TWELVE.



    " A## ### ##

    IF LS_SAL-ZRANK = C_RANK_A.

      LV_BONUS = C_BONUS.

    ELSE.

      LV_BONUS = C_ZERO.

    ENDIF.



    LV_AMT = ( LV_AMT + LV_BONUS ) / 100.



    " ## 0 ##

    IF LV_AMT <= C_ZERO.

      CONTINUE.

    ENDIF.



    " 3. ## ## ### ## ## ## ##

    READ TABLE LT_105 ASSIGNING <FS_105>

      WITH KEY ZPERNR = LS_SAL-ZPERNR

               ZYEAR = P_YEAR.



    IF SY-SUBRC <> 0.

      " ## ### ##

      CLEAR LS_105.

      LS_105-ZPERNR = LS_SAL-ZPERNR.

      LS_105-ZYEAR = P_YEAR.

      APPEND LS_105 TO LT_105.



      " ## ### #### ASSIGN

      READ TABLE LT_105 ASSIGNING <FS_105>

        WITH KEY ZPERNR = LS_SAL-ZPERNR

                 ZYEAR = P_YEAR.



      IF SY-SUBRC <> 0.

        ROLLBACK WORK.

        P_MSG = '## ##: ### ## ##'.

        EXIT.

      ENDIF.

    ENDIF.



    IF <FS_105> IS NOT ASSIGNED.

      ROLLBACK WORK.

      P_MSG = '## ##: ### ## ##'.

      EXIT.

    ENDIF.



    " 4. CASE #### ## ### ## ##

    CASE P_MONTH.

      WHEN '01'. <FS_105>-ZMON01 = LV_AMT.

      WHEN '02'. <FS_105>-ZMON02 = LV_AMT.

      WHEN '03'. <FS_105>-ZMON03 = LV_AMT.

      WHEN '04'. <FS_105>-ZMON04 = LV_AMT.

      WHEN '05'. <FS_105>-ZMON05 = LV_AMT.

      WHEN '06'. <FS_105>-ZMON06 = LV_AMT.

      WHEN '07'. <FS_105>-ZMON07 = LV_AMT.

      WHEN '08'. <FS_105>-ZMON08 = LV_AMT.

      WHEN '09'. <FS_105>-ZMON09 = LV_AMT.

      WHEN '10'. <FS_105>-ZMON10 = LV_AMT.

      WHEN '11'. <FS_105>-ZMON11 = LV_AMT.

      WHEN '12'. <FS_105>-ZMON12 = LV_AMT.

      WHEN OTHERS.

        " ### # ## (EXIT - #### #10)

        ROLLBACK WORK.

        CONCATENATE '### # ##:' P_MONTH INTO P_MSG SEPARATED BY SPACE.

        EXIT.

    ENDCASE.



    " ## ## ####

    <FS_105>-AEDATE = SY-DATUM.

    <FS_105>-AENAME = SY-UNAME.

    <FS_105>-AEZEIT = SY-UZEIT.



  ENDLOOP.



  " 5. ## ##### ## (#### 13-2-7)

  IF P_MSG IS INITIAL.

    LV_COUNT = 0.



    LOOP AT LT_105 INTO LS_105.

      IF LS_105-ZPERNR IS INITIAL OR LS_105-ZYEAR IS INITIAL.

        ROLLBACK WORK.

        P_MSG = '#### ##: ## ## ##'.

        EXIT.

      ENDIF.



      " ## MODIFY

      MODIFY ZEDT05_105 FROM LS_105.



      " #### ### ## ROLLBACK # ##

      IF SY-SUBRC <> 0.

        ROLLBACK WORK.

        CONCATENATE '#### ##: ####' LS_105-ZPERNR

                    INTO P_MSG SEPARATED BY SPACE.

        EXIT.  " # 1#### #### ## ##

      ENDIF.



      LV_COUNT = LV_COUNT + 1.

    ENDLOOP.



    " ## ### #### COMMIT

    IF P_MSG IS INITIAL.

      COMMIT WORK AND WAIT.

    ENDIF.

  ENDIF.



ENDFORM.




*&---------------------------------------------------------------------*

*&      Form  GET_EVAL

*&---------------------------------------------------------------------*

*       text

*----------------------------------------------------------------------*

*  -->  p1        text

*  <--  p2        text

*----------------------------------------------------------------------*







*13-3. ####

*1)ALV# ##

*3)### ##### ##

*4)###### ##

*5)#### ### ##### ##  ##### ### ## ##

*6)##### ##(#)# ##

*7)#### ####### ##### ## ## ## ## (1####, 2####..)

*8)## ##### SUM## ####






" #### ### ###




*TYPES: BEGIN OF TY_EVAL,

*         ZPERNR    TYPE ZEDT05_102-ZPERNR,    "####

*         ZPNAME    TYPE ZEDT05_103-ZPNAME,    "####

*         ZDEPCODE  TYPE ZEDT05_102-ZDEPCODE,  "####

*         ZDEPNAME  TYPE CHAR20,               "###

*         ZDEPRANK  TYPE ZEDT05_102-ZDEPRANK,  "####

*         ZEDATE    TYPE ZEDT05_102-ZEDATE,    "###

*         ZQDATE    TYPE ZEDT05_102-ZQDATE,    "###

*         ZQFLAG    TYPE ZEDT05_102-ZQFLAG,    "####(##/##)

*         ZSALARY   TYPE ZEDT05_106-ZSALARY,   "####

*         ZRANK     TYPE ZEDT05_104-ZRANK,     "####

*         ZMON      TYPE CURR13_2,

*       END OF TY_EVAL.




form GET_EVAL.



  DATA: LT_105 TYPE TABLE OF ZEDT05_105,

        LS_105 TYPE ZEDT05_105,

        LV_FIELDNAME TYPE STRING,

        LV_LAST_DAY TYPE DATUM,         " # ##

        LV_DATE_IN TYPE DATUM.          " # ##



  " #### ### # ##

  CONCATENATE P_YEAR P_MONTH '01' INTO LV_DATE_IN.



  CALL FUNCTION 'RP_LAST_DAY_OF_MONTHS'

    EXPORTING

      DAY_IN            = LV_DATE_IN

    IMPORTING

      LAST_DAY_OF_MONTH = LV_LAST_DAY

    EXCEPTIONS

      OTHERS            = 1.



  IF SY-SUBRC <> 0.

    MESSAGE '# ### #### ####.' TYPE 'E'.

    RETURN.

  ENDIF.



  " #### ## (### ### ##!)

  SELECT

     A~ZPERNR,

     B~ZPNAME,

     A~ZDEPCODE,

     A~ZDEPRANK,

     A~ZQDATE,

     A~ZEDATE,

     A~ZQFLAG,

     C~ZSALARY,

     D~ZRANK

  FROM

     ZEDT05_102 AS A

  LEFT OUTER JOIN

     ZEDT05_103 AS B

  ON A~ZPERNR = B~ZPERNR

  LEFT OUTER JOIN

     ZEDT05_106 AS C

  ON A~ZPERNR = C~ZPERNR

  LEFT OUTER JOIN

     ZEDT05_104 AS D

  ON A~ZPERNR = D~ZPERNR

  WHERE A~ZPERNR IN @S_PERNR

    AND D~ZYEAR = @P_YEAR

    AND A~ZEDATE <= @LV_LAST_DAY      " # ### ### ##!

  INTO CORRESPONDING FIELDS OF TABLE @GT_EVAL.



  " ### ##

  IF GT_EVAL[] IS INITIAL.

    MESSAGE '## ### #### ## #### ####.' TYPE 'E'.

    RETURN.

  ENDIF.



  " ## ## ### ##

  SELECT *

    FROM ZEDT05_105

    INTO TABLE LT_105

    FOR ALL ENTRIES IN GT_EVAL

    WHERE ZPERNR = GT_EVAL-ZPERNR

      AND ZYEAR = P_YEAR.



  LOOP AT GT_EVAL INTO GS_EVAL.



    READ TABLE LT_105 INTO LS_105

      WITH KEY ZPERNR = GS_EVAL-ZPERNR

               ZYEAR = P_YEAR.



    IF SY-SUBRC = 0.

      " CASE ### ## ## # ####

      CASE P_MONTH.

        WHEN '01'. GS_EVAL-ZMON = LS_105-ZMON01.

        WHEN '02'. GS_EVAL-ZMON = LS_105-ZMON02.

        WHEN '03'. GS_EVAL-ZMON = LS_105-ZMON03.

        WHEN '04'. GS_EVAL-ZMON = LS_105-ZMON04.

        WHEN '05'. GS_EVAL-ZMON = LS_105-ZMON05.

        WHEN '06'. GS_EVAL-ZMON = LS_105-ZMON06.

        WHEN '07'. GS_EVAL-ZMON = LS_105-ZMON07.

        WHEN '08'. GS_EVAL-ZMON = LS_105-ZMON08.

        WHEN '09'. GS_EVAL-ZMON = LS_105-ZMON09.

        WHEN '10'. GS_EVAL-ZMON = LS_105-ZMON10.

        WHEN '11'. GS_EVAL-ZMON = LS_105-ZMON11.

        WHEN '12'. GS_EVAL-ZMON = LS_105-ZMON12.

      ENDCASE.



      GS_EVAL-WAERS = 'KRW'.  " ## ## ##

      MODIFY GT_EVAL FROM GS_EVAL.

    ENDIF.

  ENDLOOP.



  " ### 0# ## ## (#### 13-3-2)

  DELETE GT_EVAL WHERE ZMON = C_ZERO OR ZMON IS INITIAL.



  " ## ### ##

  IF GT_EVAL[] IS INITIAL.

    MESSAGE '## ### #### ## #### ####.' TYPE 'E'.

    RETURN.

  ENDIF.



  " ## ##

  PERFORM CONVERT_KOR CHANGING GT_EVAL.



endform.



FORM DISPLAY_ALV_EMP_INFO.



  DATA: LT_FCAT   TYPE SLIS_T_FIELDCAT_ALV,

        LS_LAYOUT TYPE SLIS_LAYOUT_ALV,

        LT_SORT   TYPE SLIS_T_SORTINFO_ALV.



  " Field Catalog ##

  PERFORM SET_FIELDCAT_EMP_INFO CHANGING LT_FCAT.



  " Layout ##

  PERFORM SET_COMMON_LAYOUT CHANGING LS_LAYOUT.



  " Sort ##

  PERFORM SET_SORT_EMP_INFO CHANGING LT_SORT.



  " ALV ##

  PERFORM DISPLAY_ALV

    USING    LT_FCAT

             LS_LAYOUT

             LT_SORT

    CHANGING GT_EMP_INFO.



ENDFORM.

FORM SET_FIELDCAT_EMP_INFO

  CHANGING PT_FCAT TYPE SLIS_T_FIELDCAT_ALV.



  CLEAR PT_FCAT.



  " ####

  PERFORM ADD_FIELDCAT USING 'ZPERNR' '####' '10' '' '' CHANGING PT_FCAT.

  " ####

  PERFORM ADD_FIELDCAT USING 'ZPNAME' '####' '15' '' '' CHANGING PT_FCAT.

  " ####

  PERFORM ADD_FIELDCAT USING 'ZDEPCODE' '####' '10' '' '' CHANGING PT_FCAT.

  " ###

  PERFORM ADD_FIELDCAT USING 'ZDEPNAME' '###' '20' '' '' CHANGING PT_FCAT.

  " ###

  PERFORM ADD_FIELDCAT USING 'ZRANKNAME' '###' '15' '' '' CHANGING PT_FCAT.

  " ###

  PERFORM ADD_FIELDCAT USING 'ZEDATE' '###' '10' '' '' CHANGING PT_FCAT.

  " ####

  PERFORM ADD_FIELDCAT USING 'ZQFLAG_T' '####' '10' '' '' CHANGING PT_FCAT.

  " ##

  PERFORM ADD_FIELDCAT USING 'ZGENDER_T' '##' '10' '' '' CHANGING PT_FCAT.

  " ##

  PERFORM ADD_FIELDCAT USING 'ZADDRESS' '##' '30' '' '' CHANGING PT_FCAT.

  " ####

  PERFORM ADD_FIELDCAT USING 'ZBANKCODE' '####' '10' '' '' CHANGING PT_FCAT.

  " ###

  PERFORM ADD_FIELDCAT USING 'ZBANKNAME' '###' '20' '' '' CHANGING PT_FCAT.

  " ####

  PERFORM ADD_FIELDCAT USING 'ZACCOUNT' '####' '20' '' '' CHANGING PT_FCAT.



ENDFORM.



FORM SET_SORT_EMP_INFO

  CHANGING PT_SORT TYPE SLIS_T_SORTINFO_ALV.



  DATA: LS_SORT TYPE SLIS_SORTINFO_ALV.



  CLEAR PT_SORT.



  LS_SORT-FIELDNAME = 'ZPERNR'.

  LS_SORT-UP = 'X'.

  APPEND LS_SORT TO PT_SORT.



ENDFORM.



FORM DISPLAY_ALV_EVAL.



  DATA: LT_FCAT   TYPE SLIS_T_FIELDCAT_ALV,

        LS_LAYOUT TYPE SLIS_LAYOUT_ALV,

        LT_SORT   TYPE SLIS_T_SORTINFO_ALV.



  " Field Catalog ##

  PERFORM SET_FIELDCAT_EVAL CHANGING LT_FCAT.



  " Layout ##

  PERFORM SET_COMMON_LAYOUT CHANGING LS_LAYOUT.



  " Sort ##

  PERFORM SET_SORT_EVAL CHANGING LT_SORT.



  " ALV ##

  PERFORM DISPLAY_ALV

    USING    LT_FCAT

             LS_LAYOUT

             LT_SORT

    CHANGING GT_EVAL.



ENDFORM.






*&---------------------------------------------------------------------*

*&      Form  SET_FIELDCAT_EVAL

*&---------------------------------------------------------------------*




FORM SET_FIELDCAT_EVAL



  CHANGING PT_FCAT TYPE SLIS_T_FIELDCAT_ALV.



  CLEAR PT_FCAT.



  DATA : LV_MONTH TYPE CHAR50.

  CONCATENATE P_MONTH '###' INTO LV_MONTH.



  PERFORM ADD_FIELDCAT USING 'ZPERNR' '####' '10' '' '' CHANGING PT_FCAT.

  PERFORM ADD_FIELDCAT USING 'ZPNAME' '####' '20' '' '' CHANGING PT_FCAT.

  PERFORM ADD_FIELDCAT USING 'ZDEPCODE' '####' '10' '' '' CHANGING PT_FCAT.

  PERFORM ADD_FIELDCAT USING 'ZDEPNAME' '###' '20' '' '' CHANGING PT_FCAT.

  PERFORM ADD_FIELDCAT USING 'ZRANKNAME' '###' '10' '' '' CHANGING PT_FCAT.

  PERFORM ADD_FIELDCAT USING 'ZEDATE' '###' '10' '' '' CHANGING PT_FCAT.

  PERFORM ADD_FIELDCAT USING 'ZSALARY' '####' '20' 'X' 'X' CHANGING PT_FCAT.  " ##O, ##O

  PERFORM ADD_FIELDCAT USING 'ZRANK' '####' '20' '' '' CHANGING PT_FCAT.

  PERFORM ADD_FIELDCAT USING 'ZMON' LV_MONTH '15' 'X' 'X' CHANGING PT_FCAT.  " ##O, ##O



ENDFORM.






*&---------------------------------------------------------------------*

*&      Form  SET_SORT_EVAL

*&---------------------------------------------------------------------*




FORM SET_SORT_EVAL

  CHANGING PT_SORT TYPE SLIS_T_SORTINFO_ALV.



  DATA: LS_SORT TYPE SLIS_SORTINFO_ALV.



  CLEAR PT_SORT.



  LS_SORT-FIELDNAME = 'ZPERNR'.

  LS_SORT-UP = 'X'.

  APPEND LS_SORT TO PT_SORT.



ENDFORM.



FORM ADD_FIELDCAT USING P_FIELDNAME TYPE CHAR30

                        P_TEXT TYPE CHAR50

                        P_OUTPUTLEN TYPE CHAR10

                        P_DO_SUM TYPE C

                        P_CURRENCY TYPE C

                CHANGING PT_FCAT   TYPE SLIS_T_FIELDCAT_ALV.



  DATA LS_FCAT TYPE SLIS_FIELDCAT_ALV.



  CLEAR LS_FCAT.

  LS_FCAT-FIELDNAME = P_FIELDNAME.

  LS_FCAT-SELTEXT_M = P_TEXT.

  LS_FCAT-OUTPUTLEN = P_OUTPUTLEN.



 " ## ##

  IF P_DO_SUM = 'X'.

    LS_FCAT-DO_SUM = 'X'.

  ENDIF.



  " ## ##

  IF P_CURRENCY = 'X'.

    LS_FCAT-CFIELDNAME = 'WAERS'.

    LS_FCAT-CTABNAME = ''.

  ENDIF.



  APPEND LS_FCAT TO PT_FCAT.

ENDFORM.





FORM SET_COMMON_LAYOUT

  CHANGING PS_LAYOUT TYPE SLIS_LAYOUT_ALV.



  PS_LAYOUT-ZEBRA = 'X'.                " ###

  PS_LAYOUT-COLWIDTH_OPTIMIZE = 'X'.   " ## ###



ENDFORM.








*&---------------------------------------------------------------------*

*&      Form  DISPLAY_ALV_EMP_INFO

*&---------------------------------------------------------------------*

*       text

*----------------------------------------------------------------------*

*  -->  p1        text

*  <--  p2        text

*----------------------------------------------------------------------*




form DISPLAY_ALV

  USING PT_FCAT TYPE SLIS_T_FIELDCAT_ALV

        PS_LAYOUT TYPE SLIS_LAYOUT_ALV

        PT_SORT   TYPE SLIS_T_SORTINFO_ALV

  CHANGING PT_DATA TYPE STANDARD TABLE .



  GS_LAYOUT-ZEBRA = 'X'.

  GS_LAYOUT-COLWIDTH_OPTIMIZE = 'X'.



  CALL FUNCTION 'REUSE_ALV_GRID_DISPLAY'

    EXPORTING

      I_CALLBACK_PROGRAM = SY-REPID

      IS_LAYOUT          = PS_LAYOUT

      IT_FIELDCAT        = PT_FCAT

      IT_SORT            = PT_SORT

    TABLES

      T_OUTTAB           = PT_DATA

    EXCEPTIONS

      PROGRAM_ERROR      = 1

      OTHERS             = 2.



    IF SY-SUBRC <> 0.

      MESSAGE 'ALV ## # ### ######.' TYPE 'E'.

    ENDIF.

endform.








*Messages

*----------------------------------------------------------

*

* Message class: Hard coded

*   ##### ######.