
*&---------------------------------------------------------------------*

*& Report ZEDR06_PRACTICE006

*&---------------------------------------------------------------------*

*&

*&---------------------------------------------------------------------*




REPORT ZEDR06_PRACTICE006 MESSAGE-ID ZMED06.



TABLES : ZEDT06_102, ZEDT06_103, ZEDT06_104, ZEDT06_105, ZEDT06_106.






*&---------------------------------------------------------------------*

*&      ## ## ##

*&---------------------------------------------------------------------*




CONSTANTS C_X TYPE C VALUE 'X'.

CONSTANTS C_DOT TYPE C VALUE '.'.



RANGES GR_RANK FOR ZEDT06_104-ZRANK.

CLEAR GR_RANK.

GR_RANK-SIGN = 'I'.

GR_RANK-OPTION = 'EQ'.

GR_RANK-LOW = 'A'.

APPEND GR_RANK.






*&---------------------------------------------------------------------*

*&      INTERNAL TABLE ##

*&---------------------------------------------------------------------*




" ALV # ## # STRUCTURE # INTERNAL TABLE, LAYOUT ##

DATA : GS_FIELDCAT TYPE SLIS_FIELDCAT_ALV.    " ## # STRUCTURE

DATA : GT_FIELDCAT TYPE SLIS_T_FIELDCAT_ALV.  " ## # INTERNAL TABLE

DATA : GS_LAYOUT TYPE SLIS_LAYOUT_ALV.        " ## # LAYOUT STRUCTURE

DATA : GS_SORT TYPE SLIS_SORTINFO_ALV.        " ## # SORT STRUCTURE

DATA : GT_SORT TYPE SLIS_T_SORTINFO_ALV.      " ## # SORT INTERNAL TABLE



" 1. GS_EMPLOYEE = ZEDT06_102, ZEDT06_103, ZEDT06_106 JOIN

DATA : BEGIN OF GS_EMPLOYEE,

  ZPERNR TYPE ZEDT06_102-ZPERNR,      " ####

  ZPNAME TYPE ZEDT06_103-ZPNAME,      " ####

  ZDEPCODE TYPE ZEDT06_102-ZDEPCODE,  " ####

  ZDEPCODE_NAME TYPE C LENGTH 10,     " ##(#)

  ZDEPRANK TYPE ZEDT06_102-ZDEPRANK,  " ####

  ZDEPRANK_NAME TYPE C LENGTH 10,     " ##(#)

  ZEDATE TYPE ZEDT06_102-ZEDATE,      " ###

  ZQDATE TYPE ZEDT06_102-ZQDATE,      " ###

  ZQFLAG TYPE ZEDT06_102-ZQFLAG,      " ####

  ZQFLAG_NAME TYPE C LENGTH 4,        " ####(#)

  ZGENDER TYPE ZEDT06_103-ZGENDER,    " ##

  ZGENDER_NAME TYPE C LENGTH 4,       " ##(#)

  ZADDRESS TYPE ZEDT06_103-ZADDRESS,  " ##

  ZBANKCODE TYPE ZEDT06_106-ZBANKCODE," ####

  ZBANKCODE_NAME TYPE C LENGTH 10,    " ##(#)

  ZACCOUNT TYPE ZEDT06_106-ZACCOUNT,  " ####

  END OF GS_EMPLOYEE.

DATA : GT_EMPLOYEE LIKE TABLE OF GS_EMPLOYEE.



" 2. GS_EMPLOYEE_PAYMENT = ZEDT06_102, ZEDT06_104, ZEDT06_106 JOIN

DATA : BEGIN OF GS_EMPLOYEE_PAYMENT,

  ZPERNR TYPE ZEDT06_102-ZPERNR,    " ####

  ZEDATE TYPE ZEDT06_102-ZEDATE,    " ####

  ZQDATE TYPE ZEDT06_102-ZQDATE,    " ####

  ZQFLAG TYPE ZEDT06_102-ZQFLAG,    " ####

  ZRANK TYPE ZEDT06_104-ZRANK,      " ####

  ZSALARY TYPE ZEDT06_106-ZSALARY,  " ####

  ZYEAR TYPE ZEDT06_106-ZYEAR,      " ##

  END OF GS_EMPLOYEE_PAYMENT.

DATA : GT_EMPLOYEE_PAYMENT LIKE TABLE OF GS_EMPLOYEE_PAYMENT.



" 3. GS_EMPLOYEE = ZEDT06_102, ZEDT06_103, ZEDT06_104, ZEDT06_106 JOIN

DATA : BEGIN OF GS_PAY_INFO,

  ZPERNR TYPE ZEDT06_102-ZPERNR,        " ####

  ZPNAME TYPE ZEDT06_103-ZPNAME,        " ####

  ZDEPCODE TYPE ZEDT06_102-ZDEPCODE,    " ####

  ZDEPCODE_NAME TYPE C LENGTH 10,       " ##(#)

  ZDEPRANK TYPE ZEDT06_102-ZDEPRANK,    " ####

  ZDEPRANK_NAME TYPE C LENGTH 10,       " ##(#)

  ZEDATE TYPE ZEDT06_102-ZEDATE,        " ###

  ZQFLAG TYPE ZEDT06_102-ZQFLAG,        " ####

  ZSALARY TYPE ZEDT06_106-ZSALARY,      " ####

  ZYEAR TYPE ZEDT06_106-ZYEAR,          " ##

  ZRANK TYPE ZEDT06_104-ZRANK,          " ####

  ZMON_PAY TYPE P DECIMALS 2,           " ## ###

  END OF GS_PAY_INFO.

DATA : GT_PAY_INFO LIKE TABLE OF GS_PAY_INFO.






*&---------------------------------------------------------------------*

*&      SCREEN ##

*&---------------------------------------------------------------------*




SELECTION-SCREEN BEGIN OF BLOCK B1 WITH FRAME.

  SELECT-OPTIONS S_ZPERNR FOR ZEDT06_102-ZPERNR.                          " ####

  SELECT-OPTIONS S_DATE FOR ZEDT06_102-ZEDATE MODIF ID M1.                " ## YYYY.MM.DD

  PARAMETERS P_DEP TYPE ZEDT06_102-ZDEPCODE MODIF ID M1.                  " ##

  PARAMETERS P_YEAR TYPE C LENGTH 4 MODIF ID M2.                          " ## YYYY

  PARAMETERS P_MONTH TYPE C LENGTH 2 MODIF ID M2.                         " #

SELECTION-SCREEN END OF BLOCK B1.



SELECTION-SCREEN BEGIN OF BLOCK B2 WITH FRAME.

  PARAMETERS P_R1 RADIOBUTTON GROUP R1 DEFAULT 'X' USER-COMMAND UC1.      " ####

  PARAMETERS P_R2 RADIOBUTTON GROUP R1.                                   " ####

  PARAMETERS P_R3 RADIOBUTTON GROUP R1.                                   " ####

SELECTION-SCREEN END OF BLOCK B2.



SELECTION-SCREEN BEGIN OF BLOCK B3 WITH FRAME.

  PARAMETERS P_C1 AS CHECKBOX DEFAULT 'X' MODIF ID M3.                    " ####

SELECTION-SCREEN END OF BLOCK B3.








*&---------------------------------------------------------------------*

*&      MAIN ##.

*&---------------------------------------------------------------------*




" 1. ### ##

INITIALIZATION.

  PERFORM DEFAUL_SETTING.



" 2. ### ##

AT SELECTION-SCREEN OUTPUT.

  PERFORM SCREEN_SETTING.



" 3. ## # ### ##.

AT SELECTION-SCREEN.

  PERFORM DATA_VAILD_CHECK.



" 4. ### ##

START-OF-SELECTION.

  PERFORM GET_DATA.

  PERFORM MODIFY_DATA.



" 5. ### ##

END-OF-SELECTION.

  IF P_R1 = C_X.

    PERFORM ALV_DISPLAY CHANGING GT_EMPLOYEE.

  ELSEIF P_R3 = C_X.

    PERFORM ALV_DISPLAY CHANGING GT_PAY_INFO.

  ENDIF.






*&---------------------------------------------------------------------*

*&      Form  DATA_VAILD_CHECK.

*&---------------------------------------------------------------------*

*       text

*----------------------------------------------------------------------*

*  -->  p1        text

*  <--  p2        text

*----------------------------------------------------------------------*




FORM DATA_VAILD_CHECK.

  IF P_R1 = C_X.



    IF S_DATE-LOW IS INITIAL.

      MESSAGE I000.

      EXIT.

    ENDIF.



  ELSE.



    IF P_YEAR IS INITIAL.

      MESSAGE E000.

      EXIT.

    ENDIF.



    IF P_MONTH IS INITIAL.

      MESSAGE E000.

      EXIT.

    ENDIF.



  ENDIF.

ENDFORM.






*&---------------------------------------------------------------------*

*&      Form  DEFAUL_SETTING.

*&---------------------------------------------------------------------*

*       text

*----------------------------------------------------------------------*

*  -->  p1        text

*  <--  p2        text

*----------------------------------------------------------------------*




FORM DEFAUL_SETTING.

  " #### ## ## #.

  P_YEAR = SY-DATUM(4).

  P_MONTH = SY-DATUM+4(2).



  " ## = ### ##.01.01 ~ ##### #### ##

  S_DATE-SIGN = 'I'.

  S_DATE-OPTION = 'BT'.

  CONCATENATE P_YEAR '0101' INTO S_DATE-LOW.  " ## # ### 1# 1# ##.



  " ### ### ## ### ###(RP_LAST_DAY_OF_MONTHS) ##

  CALL FUNCTION 'RP_LAST_DAY_OF_MONTHS'

    EXPORTING

     DAY_IN                  = SY-DATUM

   IMPORTING

     LAST_DAY_OF_MONTH       = S_DATE-HIGH

   EXCEPTIONS

     DAY_IN_NO_DATE          = 1

     OTHERS                  = 2.



  IF SY-SUBRC <> 0.

    " ## ### ##

  ENDIF.

  APPEND S_DATE.

ENDFORM.






*&---------------------------------------------------------------------*

*&      Form  SCREEN_SETTING.

*&---------------------------------------------------------------------*

*       text

*----------------------------------------------------------------------*

*  -->  p1        text

*  <--  p2        text

*----------------------------------------------------------------------*




FORM SCREEN_SETTING.

  LOOP AT SCREEN.

    " #### ## # -> M1 ###

    IF SCREEN-GROUP1 = 'M1'.

      IF P_R1 = C_X.

        SCREEN-ACTIVE = 1.

      ELSEIF P_R2 = 'X' OR P_R3 = 'X'.

        SCREEN-ACTIVE = 0.

      ENDIF.

    ENDIF.

    " #### ## # -> M2 ###

    IF SCREEN-GROUP1 = 'M2'.

      IF P_R2 = 'X' OR P_R3 = 'X'.

        SCREEN-ACTIVE = '1'.

      ELSEIF P_R1 = 'X'.

        SCREEN-ACTIVE = '0'.

      ENDIF.

    ENDIF.



    " #### ## # -> M2 ###

    IF SCREEN-GROUP1 = 'M3'.

      IF P_R2 = 'X' OR P_R3 = 'X'.

        SCREEN-ACTIVE = '0'.

      ELSEIF P_R1 = 'X'.

        SCREEN-ACTIVE = '1'.

      ENDIF.

    ENDIF.



    " ## ## ##.

    MODIFY SCREEN.

  ENDLOOP.

ENDFORM.








*&---------------------------------------------------------------------*

*&      Form  GET_DATA.

*&---------------------------------------------------------------------*

*       text

*----------------------------------------------------------------------*

*  -->  p1        text

*  <--  p2        text

*----------------------------------------------------------------------*




FORM GET_DATA.

  IF P_R1 = C_X.

    " 1. ####, 2. ##(### ##), 3. ####, 4. #### (3,4## ### ##)

    SELECT *

      FROM ZEDT06_102 AS A

      INNER JOIN ZEDT06_103 AS B ON A~ZPERNR = B~ZPERNR

      INNER JOIN ZEDT06_106 AS C ON B~ZPERNR = C~ZPERNR

      INTO CORRESPONDING FIELDS OF TABLE GT_EMPLOYEE

      WHERE A~ZPERNR IN S_ZPERNR " #### ##

      AND  A~ZEDATE IN S_DATE " ## ##

      AND A~ZPERNR IN S_ZPERNR. " ## ##



    IF GT_EMPLOYEE IS INITIAL.

      MESSAGE E001.

    ENDIF.



  ELSEIF P_R2 = C_X.

    SELECT

      A~ZPERNR  " ####

      A~ZEDATE  " ####

      A~ZQDATE  " ####

      A~ZQFLAG  " ####

      B~ZRANK   " ####

      C~ZSALARY " ####(##)

      C~ZYEAR   " ##

    FROM ZEDT06_102 AS A

    INNER JOIN ZEDT06_104 AS B ON A~ZPERNR = B~ZPERNR

    INNER JOIN ZEDT06_106 AS C ON B~ZPERNR = C~ZPERNR

    INTO CORRESPONDING FIELDS OF TABLE GT_EMPLOYEE_PAYMENT

    WHERE A~ZPERNR IN S_ZPERNR

    AND C~ZYEAR = P_YEAR.



    IF GT_EMPLOYEE_PAYMENT IS INITIAL.

      MESSAGE E001.

    ENDIF.



  ELSEIF P_R3 = C_X.

    SELECT

      A~ZPERNR

      B~ZPNAME

      A~ZDEPCODE

      A~ZDEPRANK

      A~ZEDATE

      A~ZQFLAG

      D~ZSALARY

      D~ZYEAR

      C~ZRANK

    FROM ZEDT06_102 AS A

    INNER JOIN ZEDT06_103 AS B ON A~ZPERNR = B~ZPERNR

    INNER JOIN ZEDT06_104 AS C ON B~ZPERNR = C~ZPERNR

    INNER JOIN ZEDT06_106 AS D ON C~ZPERNR = D~ZPERNR

    INTO CORRESPONDING FIELDS OF TABLE GT_PAY_INFO

    WHERE A~ZPERNR IN S_ZPERNR

    AND D~ZYEAR = P_YEAR.



    IF GT_PAY_INFO IS INITIAL.

      MESSAGE E001.

    ENDIF.



  ENDIF.

ENDFORM.






*&---------------------------------------------------------------------*

*&      Form  MODIFY_DATA.

*&---------------------------------------------------------------------*

*       text

*----------------------------------------------------------------------*

*  -->  p1        text

*  <--  p2        text

*----------------------------------------------------------------------*




FORM MODIFY_DATA.

  IF P_R1 = C_X.

    PERFORM MODIFY_DATA_EMPLOYEE.

  ELSEIF P_R2 = C_X.

    PERFORM MODIFY_DATA_EMPLOYEE_PAYMENT.

  ELSEIF P_R3 = C_X.

    PERFORM MODIFY_DATA_PAY_INFO.

  ENDIF.

ENDFORM.






*&---------------------------------------------------------------------*

*&      Form  ALV_DISPLAY

*&---------------------------------------------------------------------*

*       text

*----------------------------------------------------------------------*

*  -->  p1        text

*  <--  p2        text

*----------------------------------------------------------------------*




FORM ALV_DISPLAY CHANGING PT_TABLE TYPE STANDARD TABLE.

  PERFORM FIELD_CATALOG.

  PERFORM ALV_LAYOUT.

  PERFORM ALV_SORT.

  PERFORM CALL_ALV USING PT_TABLE.

ENDFORM.






*&---------------------------------------------------------------------*

*&      Form  MODIFY_DATA_EMPLOYEE_PAYMENT.

*&---------------------------------------------------------------------*

*       text

*----------------------------------------------------------------------*

*  -->  p1        text

*  <--  p2        text

*----------------------------------------------------------------------*




FORM MODIFY_DATA_EMPLOYEE_PAYMENT.

  DATA : LV_CHANING_CNT TYPE I.



  CLEAR GS_EMPLOYEE_PAYMENT.

  LOOP AT GT_EMPLOYEE_PAYMENT INTO GS_EMPLOYEE_PAYMENT.



    " ## ## ## ## ##

    IF ( GS_EMPLOYEE_PAYMENT-ZQFLAG = C_X AND P_MONTH >= GS_EMPLOYEE_PAYMENT-ZQDATE+4(2) ).

      CONTINUE.

    ENDIF.



    IF ( P_MONTH < GS_EMPLOYEE_PAYMENT-ZEDATE+4(2) ).

      CONTINUE.

    ENDIF.



    " #### ## ##

    DATA : LV_SALARY TYPE I.

    LV_SALARY = ( GS_EMPLOYEE_PAYMENT-ZSALARY / 12 ).



    " A### ## 5## ## ##

    IF GS_EMPLOYEE_PAYMENT-ZRANK IN GR_RANK.

      LV_SALARY = LV_SALARY + 500.

    ENDIF.



    "  ## #### ##

    CASE P_MONTH.

      WHEN: '01' OR '1' .

        UPDATE  ZEDT06_105 SET ZMON01 = LV_SALARY

        WHERE ZPERNR = GS_EMPLOYEE_PAYMENT-ZPERNR AND ZYEAR = GS_EMPLOYEE_PAYMENT-ZYEAR.

      WHEN: '02' OR '2'.

        UPDATE  ZEDT06_105 SET ZMON02 = LV_SALARY

        WHERE ZPERNR = GS_EMPLOYEE_PAYMENT-ZPERNR AND ZYEAR = GS_EMPLOYEE_PAYMENT-ZYEAR..

      WHEN: '03' OR '3'.

        UPDATE  ZEDT06_105 SET ZMON03 = LV_SALARY

        WHERE ZPERNR = GS_EMPLOYEE_PAYMENT-ZPERNR AND ZYEAR = GS_EMPLOYEE_PAYMENT-ZYEAR.

      WHEN: '04' OR '4'.

        UPDATE  ZEDT06_105 SET ZMON04 = LV_SALARY

        WHERE ZPERNR = GS_EMPLOYEE_PAYMENT-ZPERNR AND ZYEAR = GS_EMPLOYEE_PAYMENT-ZYEAR.

      WHEN: '05' OR '5'.

        UPDATE  ZEDT06_105 SET ZMON05 = LV_SALARY

        WHERE ZPERNR = GS_EMPLOYEE_PAYMENT-ZPERNR AND ZYEAR = GS_EMPLOYEE_PAYMENT-ZYEAR.

      WHEN: '06' OR '6'.

        UPDATE  ZEDT06_105 SET ZMON06 = LV_SALARY

        WHERE ZPERNR = GS_EMPLOYEE_PAYMENT-ZPERNR AND ZYEAR = GS_EMPLOYEE_PAYMENT-ZYEAR.

      WHEN: '07' OR '7'.

        UPDATE  ZEDT06_105 SET ZMON07 = LV_SALARY

        WHERE ZPERNR = GS_EMPLOYEE_PAYMENT-ZPERNR AND ZYEAR = GS_EMPLOYEE_PAYMENT-ZYEAR.

      WHEN: '08' OR '8'.

        UPDATE  ZEDT06_105 SET ZMON08 = LV_SALARY

        WHERE ZPERNR = GS_EMPLOYEE_PAYMENT-ZPERNR AND ZYEAR = GS_EMPLOYEE_PAYMENT-ZYEAR.

      WHEN: '09' OR '9'.

        UPDATE  ZEDT06_105 SET ZMON09 = LV_SALARY

        WHERE ZPERNR = GS_EMPLOYEE_PAYMENT-ZPERNR AND ZYEAR = GS_EMPLOYEE_PAYMENT-ZYEAR.

      WHEN: '10'.

        UPDATE  ZEDT06_105 SET ZMON10 = LV_SALARY

        WHERE ZPERNR = GS_EMPLOYEE_PAYMENT-ZPERNR AND ZYEAR = GS_EMPLOYEE_PAYMENT-ZYEAR.

      WHEN: '11'.

        UPDATE  ZEDT06_105 SET ZMON11 = LV_SALARY

        WHERE ZPERNR = GS_EMPLOYEE_PAYMENT-ZPERNR AND ZYEAR = GS_EMPLOYEE_PAYMENT-ZYEAR.

      WHEN: '12'.

        UPDATE  ZEDT06_105 SET ZMON12 = LV_SALARY

        WHERE ZPERNR = GS_EMPLOYEE_PAYMENT-ZPERNR AND ZYEAR = GS_EMPLOYEE_PAYMENT-ZYEAR.

      WHEN OTHERS.

        WRITE :/ '01~12## ## #####.'.

        EXIT.

    ENDCASE.



    IF SY-SUBRC <> 0.

      WRITE :/ '##'.

      EXIT.

    ELSE.

      LV_CHANING_CNT = LV_CHANING_CNT + 1.

    ENDIF.



    CLEAR GS_EMPLOYEE_PAYMENT.

  ENDLOOP.



  IF LV_CHANING_CNT > 0.

     WRITE :/ '##'.

  ENDIF.



ENDFORM.






*&---------------------------------------------------------------------*

*&      Form  MODIFY_DATA_EMPLOYEE.

*&---------------------------------------------------------------------*

*       text

*----------------------------------------------------------------------*

*  -->  p1        text

*  <--  p2        text

*----------------------------------------------------------------------*




FORM MODIFY_DATA_EMPLOYEE.

  " 1.### ## ### ## (####)

  IF P_C1 = C_X.

    DELETE GT_EMPLOYEE WHERE ZQFLAG = 'X'.

  ENDIF.





  " 2. ## ##(###, ###, ####, ##, ###)

  CLEAR GS_EMPLOYEE.

  LOOP AT GT_EMPLOYEE INTO GS_EMPLOYEE.



    IF GS_EMPLOYEE-ZQDATE IS NOT INITIAL AND GS_EMPLOYEE-ZQDATE+4(2) <= S_DATE-HIGH+4(2).

      DELETE GT_EMPLOYEE INDEX SY-TABIX.

      CONTINUE.

    ENDIF.



    " 2-1. ### ##.

    CASE: GS_EMPLOYEE-ZDEPCODE.

      WHEN  'SS0001'. GS_EMPLOYEE-ZDEPCODE_NAME = '###'.

      WHEN  'SS0002'. GS_EMPLOYEE-ZDEPCODE_NAME = '###'.

      WHEN  'SS0003'. GS_EMPLOYEE-ZDEPCODE_NAME = '###'.

      WHEN  'SS0004'. GS_EMPLOYEE-ZDEPCODE_NAME = '###'.

      WHEN  'SS0005'. GS_EMPLOYEE-ZDEPCODE_NAME = '###'.

      WHEN  'SS0006'. GS_EMPLOYEE-ZDEPCODE_NAME = '###'.

    ENDCASE.



    " 2-2. ###.

    CASE: GS_EMPLOYEE-ZDEPRANK.

      WHEN 'A'. GS_EMPLOYEE-ZDEPRANK_NAME = '##'.

      WHEN 'B'. GS_EMPLOYEE-ZDEPRANK_NAME = '##'.

      WHEN 'C'. GS_EMPLOYEE-ZDEPRANK_NAME = '##'.

      WHEN 'D'. GS_EMPLOYEE-ZDEPRANK_NAME = '##'.

      WHEN 'E'. GS_EMPLOYEE-ZDEPRANK_NAME = '##'.

      WHEN 'F'. GS_EMPLOYEE-ZDEPRANK_NAME = '##'.

      WHEN 'G'. GS_EMPLOYEE-ZDEPRANK_NAME = '##'.

    ENDCASE.



    " 2-3. ####

    CASE: GS_EMPLOYEE-ZQFLAG.

      WHEN 'X'. GS_EMPLOYEE-ZQFLAG_NAME = '##'.

      WHEN ''. GS_EMPLOYEE-ZQFLAG_NAME = '##'.

     ENDCASE.



    " 2-4. ##

    CASE: GS_EMPLOYEE-ZGENDER.

      WHEN 'M'. GS_EMPLOYEE-ZGENDER_NAME = '##'.

      WHEN 'F'. GS_EMPLOYEE-ZGENDER_NAME = '##'.

     ENDCASE.



    " 2-4. ###

    CASE: GS_EMPLOYEE-ZBANKCODE.

      WHEN '001'. GS_EMPLOYEE-ZBANKCODE_NAME = '##'.

      WHEN '002'. GS_EMPLOYEE-ZBANKCODE_NAME = '##'.

      WHEN '003'. GS_EMPLOYEE-ZBANKCODE_NAME = '##'.

      WHEN '004'. GS_EMPLOYEE-ZBANKCODE_NAME = '##'.

      WHEN '005'. GS_EMPLOYEE-ZBANKCODE_NAME = '###'.

     ENDCASE.



    MODIFY GT_EMPLOYEE FROM GS_EMPLOYEE.

  ENDLOOP.



ENDFORM.






*&---------------------------------------------------------------------*

*&      Form  MODIFY_DATA_PAY_INFO.

*&---------------------------------------------------------------------*

*       text #DB# ## ## ###.

*----------------------------------------------------------------------*

*  -->  p1        text

*  <--  p2        text

*----------------------------------------------------------------------*




FORM MODIFY_DATA_PAY_INFO.



  CLEAR GS_PAY_INFO.

  LOOP AT GT_PAY_INFO INTO GS_PAY_INFO.



    IF GS_PAY_INFO-ZQFLAG EQ 'X'.

      IF GS_PAY_INFO-ZEDATE+4(2) > P_MONTH.

        DELETE GT_PAY_INFO INDEX SY-TABIX.

        CONTINUE.

      ENDIF.

    ENDIF.



    " 2-1. ### ##.

    CASE: GS_PAY_INFO-ZDEPCODE.

      WHEN  'SS0001'. GS_PAY_INFO-ZDEPCODE_NAME = '###'.

      WHEN  'SS0002'. GS_PAY_INFO-ZDEPCODE_NAME = '###'.

      WHEN  'SS0003'. GS_PAY_INFO-ZDEPCODE_NAME = '###'.

      WHEN  'SS0004'. GS_PAY_INFO-ZDEPCODE_NAME = '###'.

      WHEN  'SS0005'. GS_PAY_INFO-ZDEPCODE_NAME = '###'.

      WHEN  'SS0006'. GS_PAY_INFO-ZDEPCODE_NAME = '###'.

    ENDCASE.



    " 2-2. ###.

    CASE: GS_PAY_INFO-ZDEPRANK.

      WHEN 'A'. GS_PAY_INFO-ZDEPRANK_NAME = '##'.

      WHEN 'B'. GS_PAY_INFO-ZDEPRANK_NAME = '##'.

      WHEN 'C'. GS_PAY_INFO-ZDEPRANK_NAME = '##'.

      WHEN 'D'. GS_PAY_INFO-ZDEPRANK_NAME = '##'.

      WHEN 'E'. GS_PAY_INFO-ZDEPRANK_NAME = '##'.

      WHEN 'F'. GS_PAY_INFO-ZDEPRANK_NAME = '##'.

      WHEN 'G'. GS_PAY_INFO-ZDEPRANK_NAME = '##'.

    ENDCASE.



    IF P_MONTH = '01' OR P_MONTH = '1'.

      SELECT SINGLE ZMON01 INTO GS_PAY_INFO-ZMON_PAY FROM ZEDT06_105

        WHERE ZPERNR = GS_PAY_INFO-ZPERNR AND ZYEAR = GS_PAY_INFO-ZYEAR.

    ELSEIF P_MONTH = '02' OR P_MONTH = '2'.

      SELECT SINGLE ZMON02 INTO GS_PAY_INFO-ZMON_PAY FROM ZEDT06_105

        WHERE ZPERNR = GS_PAY_INFO-ZPERNR AND ZYEAR = GS_PAY_INFO-ZYEAR.

    ELSEIF P_MONTH = '03' OR P_MONTH = '3'.

      SELECT SINGLE ZMON03 INTO GS_PAY_INFO-ZMON_PAY FROM ZEDT06_105

        WHERE ZPERNR = GS_PAY_INFO-ZPERNR AND ZYEAR = GS_PAY_INFO-ZYEAR.

    ELSEIF P_MONTH = '04' OR P_MONTH = '4'.

      SELECT SINGLE ZMON04 INTO GS_PAY_INFO-ZMON_PAY FROM ZEDT06_105

        WHERE ZPERNR = GS_PAY_INFO-ZPERNR AND ZYEAR = GS_PAY_INFO-ZYEAR.

    ELSEIF P_MONTH = '05' OR P_MONTH = '5'.

      SELECT SINGLE ZMON05 INTO GS_PAY_INFO-ZMON_PAY FROM ZEDT06_105

        WHERE ZPERNR = GS_PAY_INFO-ZPERNR AND ZYEAR = GS_PAY_INFO-ZYEAR.

    ELSEIF P_MONTH = '06' OR P_MONTH = '6'.

      SELECT SINGLE ZMON06 INTO GS_PAY_INFO-ZMON_PAY FROM ZEDT06_105

        WHERE ZPERNR = GS_PAY_INFO-ZPERNR AND ZYEAR = GS_PAY_INFO-ZYEAR.

    ELSEIF P_MONTH = '07' OR P_MONTH = '7'.

      SELECT SINGLE ZMON07 INTO GS_PAY_INFO-ZMON_PAY FROM ZEDT06_105

        WHERE ZPERNR = GS_PAY_INFO-ZPERNR AND ZYEAR = GS_PAY_INFO-ZYEAR.

    ELSEIF P_MONTH = '08' OR P_MONTH = '8'.

      SELECT SINGLE ZMON08 INTO GS_PAY_INFO-ZMON_PAY FROM ZEDT06_105

        WHERE ZPERNR = GS_PAY_INFO-ZPERNR AND ZYEAR = GS_PAY_INFO-ZYEAR.

    ELSEIF P_MONTH = '09' OR P_MONTH = '9'.

      SELECT SINGLE ZMON09 INTO GS_PAY_INFO-ZMON_PAY FROM ZEDT06_105

        WHERE ZPERNR = GS_PAY_INFO-ZPERNR AND ZYEAR = GS_PAY_INFO-ZYEAR.

    ELSEIF P_MONTH = '10'.

      SELECT SINGLE ZMON10 INTO GS_PAY_INFO-ZMON_PAY FROM ZEDT06_105

        WHERE ZPERNR = GS_PAY_INFO-ZPERNR AND ZYEAR = GS_PAY_INFO-ZYEAR.

    ELSEIF P_MONTH = '11'.

      SELECT SINGLE ZMON12 INTO GS_PAY_INFO-ZMON_PAY FROM ZEDT06_105

        WHERE ZPERNR = GS_PAY_INFO-ZPERNR AND ZYEAR = GS_PAY_INFO-ZYEAR.

    ELSEIF P_MONTH = '12'.

      SELECT SINGLE ZMON12 INTO GS_PAY_INFO-ZMON_PAY FROM ZEDT06_105

        WHERE ZPERNR = GS_PAY_INFO-ZPERNR AND ZYEAR = GS_PAY_INFO-ZYEAR.

    ENDIF.



    IF GS_PAY_INFO-ZMON_PAY EQ 0.

      DELETE GT_PAY_INFO INDEX SY-TABIX.

    ELSE.

      MODIFY GT_PAY_INFO FROM GS_PAY_INFO.

    ENDIF.



  ENDLOOP.



ENDFORM.








*&---------------------------------------------------------------------*

*&      Form  FIELD_CATALOG.

*&---------------------------------------------------------------------*

*       text ALV ###### ## ###

*----------------------------------------------------------------------*

*  -->  p1        text

*  <--  p2        text

*----------------------------------------------------------------------*




FORM FIELD_CATALOG.

   " ## FIELD

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

   GS_FIELDCAT-OUTPUTLEN = 10.

   APPEND GS_FIELDCAT TO GT_FIELDCAT.



   " ## ### ## ## FIELD

   IF P_R1 = C_X.

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



  " ##### ## ## FIELD

  ELSEIF P_R3 = C_X.

     DATA : LV_PAY_AMOUNT_FIELD TYPE C LENGTH 20.

     CONCATENATE P_MONTH '#####' INTO LV_PAY_AMOUNT_FIELD.



     CLEAR : GS_FIELDCAT.

     GS_FIELDCAT-COL_POS = 7.

     GS_FIELDCAT-FIELDNAME = 'ZSALARY'.

     GS_FIELDCAT-SELTEXT_M = '####'.

     GS_FIELDCAT-DO_SUM = C_X.

     GS_FIELDCAT-CURRENCY = 'KRW'.

     GS_FIELDCAT-OUTPUTLEN = 20.

     APPEND GS_FIELDCAT TO GT_FIELDCAT.



     CLEAR : GS_FIELDCAT.

     GS_FIELDCAT-COL_POS = 8.

     GS_FIELDCAT-FIELDNAME = 'ZRANK'.

     GS_FIELDCAT-SELTEXT_M = '####'.

     APPEND GS_FIELDCAT TO GT_FIELDCAT.



     CLEAR : GS_FIELDCAT.

     GS_FIELDCAT-COL_POS = 9.

     GS_FIELDCAT-FIELDNAME = 'ZMON_PAY'.

     GS_FIELDCAT-SELTEXT_M = LV_PAY_AMOUNT_FIELD.

     GS_FIELDCAT-DO_SUM = C_X.

     GS_FIELDCAT-CURRENCY = 'KRW'.

     GS_FIELDCAT-OUTPUTLEN = 20.

     GS_FIELDCAT-NO_ZERO = C_X.

     APPEND GS_FIELDCAT TO GT_FIELDCAT.

  ENDIF.

ENDFORM.






*&---------------------------------------------------------------------*

*&      Form  ALV_LAYOUT.

*&---------------------------------------------------------------------*

*       text ALV LAYOUT ## ###

*----------------------------------------------------------------------*

*  -->  p1        text

*  <--  p2        text

*----------------------------------------------------------------------*




FORM ALV_LAYOUT.

  GS_LAYOUT-ZEBRA = C_X.

ENDFORM.






*&---------------------------------------------------------------------*

*&      Form  ALV_SORT.

*&---------------------------------------------------------------------*

*       text AVL ## ###

*----------------------------------------------------------------------*

*  -->  p1        text

*  <--  p2        text

*----------------------------------------------------------------------*




FORM ALV_SORT.

    GS_SORT-SPOS = 1.

    GS_SORT-FIELDNAME = 'ZPERNR'.

    GS_SORT-UP = C_X.

    APPEND GS_SORT TO GT_SORT.

ENDFORM.






*&---------------------------------------------------------------------*

*&      Form  CALL_ALV

*&---------------------------------------------------------------------*

*       text ALV ## ###.

*----------------------------------------------------------------------*

*  -->  p1        text

*  <--  p2        text

*----------------------------------------------------------------------*




FORM CALL_ALV USING PT_TABLE TYPE STANDARD TABLE.

  CALL FUNCTION 'REUSE_ALV_GRID_DISPLAY'

   EXPORTING

     IT_FIELDCAT                       = GT_FIELDCAT

     IS_LAYOUT                         = GS_LAYOUT

     IT_SORT                           = GT_SORT

    TABLES

     T_OUTTAB                          = PT_TABLE.

    IF SY-SUBRC <> 0.

      " ## ### ##

    ENDIF.

ENDFORM.