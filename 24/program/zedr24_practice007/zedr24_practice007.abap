
*&---------------------------------------------------------------------*

*& Report ZEDR24_PRACTICE007

*&---------------------------------------------------------------------*

*&

*&---------------------------------------------------------------------*




REPORT ZEDR24_PRACTICE007 MESSAGE-ID ZEDM24.



TABLES : ZEDT24_102, ZEDT24_103, ZEDT24_104, ZEDT24_105, ZEDT24_106.



CONSTANTS : C_BONUS TYPE I VALUE 500.



"0. ## ##

DATA : GV_YEAR_SO TYPE C LENGTH 4,

       GV_MONTH_SO TYPE C LENGTH 2.





"0-1. #### ###

"0-1-1. ###_#######

DATA : BEGIN OF GS_IN_EMPLOYEE,

  ZPERNR LIKE ZEDT24_102-ZPERNR,        "####

  ZPNAME LIKE ZEDT24_103-ZPNAME,        "####

  ZDEPCODE LIKE ZEDT24_102-ZDEPCODE,    "####

  ZDEPRANK LIKE ZEDT24_102-ZDEPRANK,    "####

  ZEDATE LIKE ZEDT24_102-ZEDATE,        "###

  ZQFLAG LIKE ZEDT24_102-ZQFLAG,        "####

  ZGENDER LIKE ZEDT24_103-ZGENDER,      "##

  ZADDRESS LIKE ZEDT24_103-ZADDRESS,    "##

  ZBANKCODE LIKE ZEDT24_106-ZBANKCODE,  "####

  ZACCOUNT LIKE ZEDT24_106-ZACCOUNT,    "####

  DATAB LIKE ZEDT24_102-DATAB,          "####_FR

  DATABI LIKE ZEDT24_102-DATBI,         "####_TO

  ZQDATE LIKE ZEDT24_102-ZQDATE,        "####

END OF GS_IN_EMPLOYEE.

DATA : GT_IN_EMPLOYEE LIKE TABLE OF GS_IN_EMPLOYEE.

FIELD-SYMBOLS : <FS_INFO> LIKE LINE OF GT_IN_EMPLOYEE.



"0-1-2. ###_#######

DATA : BEGIN OF GS_OUT_EMPLOYEE,

  ZPERNR LIKE ZEDT24_102-ZPERNR,        "####

  ZPNAME LIKE ZEDT24_103-ZPNAME,        "####

  ZDEPCODE LIKE ZEDT24_102-ZDEPCODE,    "####

  ZDEPNAME TYPE C LENGTH 5,             "###

  ZDEPRANKNAME TYPE C LENGTH 5,         "###

  ZEDATE LIKE ZEDT24_102-ZEDATE,        "###

  ZQSTR TYPE C LENGTH 5,                "#### ###

  ZGENDERSTR TYPE C LENGTH 5,           "## ###

  ZADDRESS LIKE ZEDT24_103-ZADDRESS,    "##

  ZBANKCODE LIKE ZEDT24_106-ZBANKCODE,  "####

  ZBANKNAME TYPE C LENGTH 5,            "###

  ZACCOUNT LIKE ZEDT24_106-ZACCOUNT,    "####

END OF GS_OUT_EMPLOYEE.

DATA : GT_OUT_EMPLOYEE LIKE TABLE OF GS_OUT_EMPLOYEE.



"0-2. ## ##

"0-2-1. ###_#### ###

DATA : BEGIN OF GS_IN_MONTHPAY,

  ZPERNR LIKE ZEDT24_102-ZPERNR,        "####

  ZPNAME LIKE ZEDT24_103-ZPNAME,        "####

  ZDEPCODE LIKE ZEDT24_102-ZDEPCODE,    "####

  ZDEPRANK LIKE ZEDT24_102-ZDEPRANK,    "####

  ZEDATE LIKE ZEDT24_102-ZEDATE,        "###

  ZSALARY LIKE ZEDT24_106-ZSALARY,      "####

  ZRANK LIKE ZEDT24_104-ZRANK,          "####

  ZYEAR LIKE ZEDT24_104-ZYEAR,          "##

  DATAB LIKE ZEDT24_102-DATAB,          "####_FR

  DATABI LIKE ZEDT24_102-DATBI,         "####_TO

END OF GS_IN_MONTHPAY.

DATA : GT_IN_MONTHPAY LIKE TABLE OF GS_IN_MONTHPAY.



"0-2-2. ###_#### ###

DATA : BEGIN OF GS_OUT_MONTHPAY,

  ZPERNR LIKE ZEDT24_102-ZPERNR,        "####

  ZPNAME LIKE ZEDT24_103-ZPNAME,        "####

  ZDEPCODE LIKE ZEDT24_102-ZDEPCODE,    "####

  ZDEPNAME TYPE C LENGTH 5,             "###

  ZDEPRANKNAME TYPE C LENGTH 5,         "###

  ZEDATE LIKE ZEDT24_102-ZEDATE,        "###

  ZSALARY LIKE ZEDT24_106-ZSALARY,      "####

  ZRANK LIKE ZEDT24_104-ZRANK,          "####

  ZMONTHPAY LIKE ZEDT24_105-ZMON01,     "N# ###

END OF GS_OUT_MONTHPAY.

DATA : GT_OUT_MONTHPAY LIKE TABLE OF GS_OUT_MONTHPAY.



"0-3. ## ##

"0-3-1. ###_#### ###

DATA : BEGIN OF GS_IN_EVAL,

  ZPERNR LIKE ZEDT24_102-ZPERNR,        "####

  ZPNAME LIKE ZEDT24_103-ZPNAME,        "####

  ZDEPCODE LIKE ZEDT24_102-ZDEPCODE,    "####

  ZDEPRANK LIKE ZEDT24_102-ZDEPRANK,    "####

  ZEDATE LIKE ZEDT24_102-ZEDATE,        "###

  ZSALARY LIKE ZEDT24_106-ZSALARY,      "####

  ZRANK LIKE ZEDT24_104-ZRANK,          "####

  ZMON LIKE ZEDT02_105-ZMON01,          "N# ##

END OF GS_IN_EVAL.

DATA : GT_IN_EVAL LIKE TABLE OF GS_IN_EVAL.



"0-3-2. ###_#### ###

DATA : BEGIN OF GS_OUT_EVAL,

  ZPERNR LIKE ZEDT24_102-ZPERNR,        "####

  ZPNAME LIKE ZEDT24_103-ZPNAME,        "####

  ZDEPCODE LIKE ZEDT24_102-ZDEPCODE,    "####

  ZDEPNAME TYPE C LENGTH 5,             "###

  ZDEPRANKNAME TYPE C LENGTH 5,         "###

  ZEDATE LIKE ZEDT24_102-ZEDATE,        "###

  ZSALARY LIKE ZEDT24_106-ZSALARY,      "####

  ZRANK LIKE ZEDT24_104-ZRANK,          "####

  ZMON LIKE ZEDT02_105-ZMON01,          "N# ##

END OF GS_OUT_EVAL.

DATA : GT_OUT_EVAL LIKE TABLE OF GS_OUT_EVAL.



"0-3-3. ## ### ## ## ## ###

DATA : BEGIN OF GS_105.

  include structure
ZEDT24_105
.

DATA : END OF GS_105.

DATA : GT_105 LIKE TABLE OF GS_105.



"1. ## ## ##

"1-1. ####, ##, ##

SELECTION-SCREEN BEGIN OF BLOCK B1 WITH FRAME.

  "1-1-1. ## ####

  SELECT-OPTIONS S_ZPERNR FOR ZEDT24_102-ZPERNR.                 "#### ( ~ )



  "1-1-2. ## ## ###

  SELECT-OPTIONS S_TERM FOR ZEDT24_102-ZEDATE NO-EXTENSION MODIF ID M1.       "## ( ~ )

  SELECT-OPTIONS S_ZDCODE FOR ZEDT24_102-ZDEPCODE NO INTERVALS NO-EXTENSION MODIF ID M1.   "##



  "1-1-3. ## ## ### OR 3. ## ## ###

  SELECT-OPTIONS S_YEAR FOR GV_YEAR_SO NO INTERVALS NO-EXTENSION VISIBLE LENGTH 4 MODIF ID M2.       "##

  SELECT-OPTIONS S_MONTH FOR GV_MONTH_SO NO INTERVALS NO-EXTENSION VISIBLE LENGTH 2 MODIF ID M2.      "#




*  SELECT-OPTIONS S_MONTH FOR SY-DATUM+4(2) NO INTERVALS NO-EXTENSION VISIBLE LENGTH 2 MODIF ID M2.      "#




SELECTION-SCREEN END OF BLOCK B1.



"1-2. ####, ####, ####

SELECTION-SCREEN BEGIN OF BLOCK B2 WITH FRAME.

  PARAMETERS : P_R1 RADIOBUTTON GROUP R1 DEFAULT 'X' USER-COMMAND UC1. "####

  PARAMETERS : P_R2 RADIOBUTTON GROUP R1.                              "####

  PARAMETERS : P_R3 RADIOBUTTON GROUP R1.                              "####

SELECTION-SCREEN END OF BLOCK B2.



"1-3. ####

SELECTION-SCREEN BEGIN OF BLOCK B3 WITH FRAME.

  PARAMETERS : P_ISQUIT AS CHECKBOX MODIF ID M3.   "#### (#### ###)

SELECTION-SCREEN END OF BLOCK B3.



"2. ## ## ## ### ##

INITIALIZATION.

  DATA : GV_YEAR TYPE DATS,

         GV_MONTH TYPE DATS,

         GV_FIRST_DAY TYPE DATS,

         GV_LAST_DAY TYPE DATS.



  "2-1-2. ## ## ### -> ## ## ## ###

  CONCATENATE SY-DATUM+0(4) '0101' INTO GV_FIRST_DAY.



  CALL FUNCTION 'RP_LAST_DAY_OF_MONTHS'

  EXPORTING

    DAY_IN = SY-DATUM

  IMPORTING

    LAST_DAY_OF_MONTH = GV_LAST_DAY.

  S_TERM-LOW = GV_FIRST_DAY.

  S_TERM-HIGH = GV_LAST_DAY.

  S_TERM-OPTION = 'BT'.

  S_TERM-SIGN = 'I'.

  APPEND S_TERM.



  "2-1-3. ## ## ### -> ##, # ## ## ###

  GV_YEAR = SY-DATUM(4).

  S_YEAR-LOW = GV_YEAR.

  APPEND S_YEAR.



  GV_MONTH = SY-DATUM+4(2).

  S_MONTH-LOW = GV_MONTH.

  APPEND S_MONTH.



"3. ## ## ##

"3. ## ## ##

AT SELECTION-SCREEN ON S_MONTH.

  LOOP AT S_MONTH.

    IF S_MONTH-LOW IS NOT INITIAL.

      UNPACK S_MONTH-LOW TO S_MONTH-LOW.

    ENDIF.



    IF S_MONTH-HIGH IS NOT INITIAL.

      UNPACK S_MONTH-HIGH TO S_MONTH-HIGH.

    ENDIF.

    MODIFY S_MONTH.

  ENDLOOP.



AT SELECTION-SCREEN.

  "3-1. ## ## ## ## ## ##

  IF P_R1 = 'X'.

    IF S_TERM IS INITIAL.

      MESSAGE E000.

    ENDIF.

  "3-2. ## ## OR ## ## ## ## ##

  ELSEIF P_R2 = 'X' OR P_R3 = 'X'.

    IF S_YEAR IS INITIAL OR S_MONTH IS INITIAL.

      MESSAGE E000.

    ENDIF.

  ENDIF.



"3. ####

AT SELECTION-SCREEN OUTPUT.

  "3-1. ## ## ##

  IF P_R1 = 'X'.

    "3-1-1. ## ##

    LOOP AT SCREEN.

      IF SCREEN-GROUP1 = 'M1'.

        SCREEN-ACTIVE = '1'.

      ENDIF.

      IF SCREEN-GROUP1 = 'M2'.

        SCREEN-ACTIVE = '0'.

      ENDIF.

      IF SCREEN-GROUP1 = 'M3'.

        SCREEN-ACTIVE = '1'.

      ENDIF.

      MODIFY SCREEN.

    ENDLOOP.

  ENDIF.



  "3-2. ## ## ##

  IF P_R2 = 'X'.

    "3-2-1. ## ##

    LOOP AT SCREEN.

      IF SCREEN-GROUP1 = 'M1'.

        SCREEN-ACTIVE = '0'.

      ENDIF.

      IF SCREEN-GROUP1 = 'M2'.

        SCREEN-ACTIVE = '1'.

      ENDIF.

      IF SCREEN-GROUP1 = 'M3'.

        SCREEN-ACTIVE = '0'.

      ENDIF.

      MODIFY SCREEN.

    ENDLOOP.

  ENDIF.



  "3-3. ## ## ##

  IF P_R3 = 'X'.

    "3-3-1. ## ##

    LOOP AT SCREEN.

      IF SCREEN-GROUP1 = 'M1'.

        SCREEN-ACTIVE = '0'.

      ENDIF.

      IF SCREEN-GROUP1 = 'M2'.

        SCREEN-ACTIVE = '1'.

      ENDIF.

      IF SCREEN-GROUP1 = 'M3'.

        SCREEN-ACTIVE = '0'.

      ENDIF.

      MODIFY SCREEN.

    ENDLOOP.

  ENDIF.



"4.DB## # ####

START-OF-SELECTION.

"4-1. ####

IF P_R1 = 'X'.

  PERFORM GET_DATA_EMPLOYEE.

  PERFORM MODIFY_DATA_EMPLOYEE.

ENDIF.



"4-2. ####

IF P_R2 = 'X'.

  PERFORM GET_DATA_MONTHPAY.

  PERFORM MODIFY_DATA_MONTHPAY.

ENDIF.



"4-3. ####

IF P_R3 = 'X'.

  PERFORM GT_DATA_EVAL.

  PERFORM MODIFY_DATA_EVAL.

ENDIF.



"5. ####

END-OF-SELECTION.

"5-1. ####

IF P_R1 = 'X'.

  PERFORM ALV_DISPLAY_EMPLOYEE.

ENDIF.






*"5-2. ####

*IF P_R2 = 'X'.

*  PERFORM ALV_DISPLAY_MONTHPAY.

*ENDIF.






"5-3. ####

IF P_R3 = 'X'.

  PERFORM ALV_DISPLAY_EVAL.

ENDIF.






*&---------------------------------------------------------------------*

*&      Form  GET_DATA_EMPLOYEE

*&---------------------------------------------------------------------*

*       #### #### ####.

*----------------------------------------------------------------------*

*  -->  p1        text

*  <--  p2        text

*----------------------------------------------------------------------*




FORM GET_DATA_EMPLOYEE .

  RANGES : LR_DEPCODE FOR ZEDT24_102-ZDEPCODE,

           LR_QUIT FOR ZEDT24_102-ZQFLAG.



  IF P_ISQUIT = 'X'.

    LR_QUIT-OPTION = 'NE'.

    LR_QUIT-SIGN = 'I'.

    LR_QUIT-LOW = 'X'.

    APPEND LR_QUIT.

  ENDIF.



  SELECT * FROM ZEDT24_102 AS 102

      INNER JOIN ZEDT24_103 AS 103 ON 102~ZPERNR = 103~ZPERNR

      INNER JOIN ZEDT24_106 AS 106 ON 102~ZPERNR = 106~ZPERNR

    INTO CORRESPONDING FIELDS OF TABLE GT_IN_EMPLOYEE

    WHERE 102~ZPERNR IN S_ZPERNR   "1. ## ## ##

      AND ZEDATE IN S_TERM     "2. ## ##

      AND ZDEPCODE IN S_ZDCODE "3. ## ## ##

      AND ZQFLAG IN LR_QUIT.   "4. ## ## ##



  IF GT_IN_EMPLOYEE IS INITIAL.

    MESSAGE E001. "##### #### #### ## ## ##

    STOP.

  ENDIF.



ENDFORM.






*&---------------------------------------------------------------------*

*&      Form  GET_DATA_MONTHPAY

*&---------------------------------------------------------------------*

*       #### #### ####.

*----------------------------------------------------------------------*

*  -->  p1        text

*  <--  p2        text

*----------------------------------------------------------------------*




FORM GET_DATA_MONTHPAY .

  DATA : LV_FIRST_DAY TYPE DATUM,

         LV_LAST_DAY TYPE DATUM.



  "1. ####, #### #### ## ###

  CONCATENATE S_YEAR-LOW S_MONTH-LOW '01' INTO LV_FIRST_DAY.

  CALL FUNCTION 'LAST_DAY_OF_MONTHS'

    EXPORTING

      DAY_IN = LV_FIRST_DAY

    IMPORTING

      LAST_DAY_OF_MONTH = LV_LAST_DAY.



  "2. ### ### ####

  SELECT * FROM ZEDT24_102 AS 102

           INNER JOIN ZEDT24_103 AS 103 ON 102~ZPERNR = 103~ZPERNR

           INNER JOIN ZEDT24_104 AS 104 ON 102~ZPERNR = 104~ZPERNR

           INNER JOIN ZEDT24_106 AS 106 ON 102~ZPERNR = 106~ZPERNR

    INTO CORRESPONDING FIELDS OF TABLE GT_IN_MONTHPAY

    WHERE 102~ZPERNR IN S_ZPERNR

      AND 106~ZYEAR IN S_YEAR

      AND 102~DATBI <= LV_FIRST_DAY "#### ###

      AND 102~DATAB > LV_LAST_DAY. "#### ###



  "3. ######

  CLEAR GT_105.

  SELECT * FROM ZEDT24_105

  INTO TABLE GT_105

  WHERE ZPERNR IN S_ZPERNR

    AND ZYEAR IN S_YEAR.



ENDFORM.






*&---------------------------------------------------------------------*

*&      Form  GT_DATA_EVAL

*&---------------------------------------------------------------------*

*       ## #### ####.

*----------------------------------------------------------------------*

*  -->  p1        text

*  <--  p2        text

*----------------------------------------------------------------------*




FORM GT_DATA_EVAL .

  DATA : LV_FIRST_DAY TYPE DATUM,

         LV_LAST_DAY TYPE DATUM.



  "1. ####, #### #### ## ###

  CONCATENATE S_YEAR-LOW S_MONTH-LOW '01' INTO LV_FIRST_DAY.

  CALL FUNCTION 'LAST_DAY_OF_MONTHS'

    EXPORTING

      DAY_IN = LV_FIRST_DAY

    IMPORTING

      LAST_DAY_OF_MONTH = LV_LAST_DAY.



  "2. main ### ####

  SELECT * FROM ZEDT24_102 AS 102

           INNER JOIN ZEDT24_103 AS 103 ON 102~ZPERNR = 103~ZPERNR

           INNER JOIN ZEDT24_104 AS 104 ON 102~ZPERNR = 104~ZPERNR

           INNER JOIN ZEDT24_106 AS 106 ON 102~ZPERNR = 106~ZPERNR

    INTO CORRESPONDING FIELDS OF TABLE GT_IN_EVAL

    WHERE 102~ZPERNR IN S_ZPERNR

      AND 106~ZYEAR IN S_YEAR

      AND 102~DATBI <= LV_FIRST_DAY "#### ###

      AND 102~DATAB > LV_LAST_DAY. "#### ###



  "3. #### ## ##

  IF GT_IN_EVAL IS INITIAL.

    MESSAGE E101.

    STOP.

  ENDIF.



  "4. ######

  CLEAR GT_105.

  SELECT * FROM ZEDT24_105

  INTO TABLE GT_105

  WHERE ZPERNR IN S_ZPERNR

    AND ZYEAR IN S_YEAR.



ENDFORM.






*&---------------------------------------------------------------------*

*&      Form  MODIFY_DATA_EMPLOYEE

*&---------------------------------------------------------------------*

*       #### #### #### ## #### ####.

*----------------------------------------------------------------------*

*  -->  p1        text

*  <--  p2        text

*----------------------------------------------------------------------*




FORM MODIFY_DATA_EMPLOYEE .

  LOOP AT GT_IN_EMPLOYEE ASSIGNING <FS_INFO>.

    CLEAR GS_OUT_EMPLOYEE.



    MOVE-CORRESPONDING <FS_INFO> TO GS_OUT_EMPLOYEE.

    PERFORM ZDEPCODE_2_ZDEPNAME USING <FS_INFO>-ZDEPCODE GS_OUT_EMPLOYEE-ZDEPNAME.

    PERFORM ZDEPRANK_2_ZDEPRANKNAME USING <FS_INFO>-ZDEPRANK GS_OUT_EMPLOYEE-ZDEPRANKNAME.

    PERFORM ZQFLAG_2_ZQSTR USING <FS_INFO>-ZQFLAG GS_OUT_EMPLOYEE-ZQSTR.

    PERFORM ZGENDER_2_ZGENDERSTR USING <FS_INFO>-ZGENDER GS_OUT_EMPLOYEE-ZGENDERSTR.

    PERFORM ZBANKCODE_2_ZBANKNAME USING <FS_INFO>-ZBANKCODE GS_OUT_EMPLOYEE-ZBANKNAME.



    APPEND GS_OUT_EMPLOYEE TO GT_OUT_EMPLOYEE.

  ENDLOOP.

ENDFORM.




*&---------------------------------------------------------------------*

*&      Form  MODIFY_DATA_MONTHPAY

*&---------------------------------------------------------------------*

*       ### ###### ## #### ####.

*----------------------------------------------------------------------*

*  -->  p1        text

*  <--  p2        text

*----------------------------------------------------------------------*




FORM MODIFY_DATA_MONTHPAY .



  "## ##

  FIELD-SYMBOLS : <FS1> LIKE ZEDT24_105,

                  <FS2> TYPE ANY.



  ASSIGN ZEDT24_105 TO <FS1>.



  "3. ## ##

  DATA : LV_MONTHPAY LIKE GS_IN_MONTHPAY-ZSALARY.



  LOOP AT GT_IN_MONTHPAY INTO GS_IN_MONTHPAY.

    CLEAR GS_OUT_MONTHPAY.

    MOVE-CORRESPONDING GS_IN_MONTHPAY TO GS_OUT_MONTHPAY.



    LV_MONTHPAY = GS_IN_MONTHPAY-ZSALARY / 12.

    IF GS_IN_MONTHPAY-ZRANK = 'A'.

      LV_MONTHPAY = LV_MONTHPAY + C_BONUS.

    ENDIF.



    CHECK LV_MONTHPAY <> 0.



    CLEAR GS_105.

    SELECT SINGLE *

      FROM ZEDT24_105

      INTO GS_105

      WHERE ZPERNR = GS_105-ZPERNR

        AND ZYEAR = GS_105-ZYEAR.



    GS_105-AENAME = SY-UNAME. "###

    GS_105-AEDATE = SY-DATUM. "###

    GS_105-AEZEIT = SY-UZEIT. "####





    CASE : S_MONTH-LOW.

      WHEN '01'.

          UPDATE ZEDT24_105 SET ZMON01 = LV_MONTHPAY WHERE ZPERNR = GS_IN_MONTHPAY-ZPERNR.

      WHEN '02'.

          UPDATE ZEDT24_105 SET ZMON02 = LV_MONTHPAY WHERE ZPERNR = GS_IN_MONTHPAY-ZPERNR.

      WHEN '03'.

          UPDATE ZEDT24_105 SET ZMON03 = LV_MONTHPAY WHERE ZPERNR = GS_IN_MONTHPAY-ZPERNR.

      WHEN '04'.

          UPDATE ZEDT24_105 SET ZMON04 = LV_MONTHPAY WHERE ZPERNR = GS_IN_MONTHPAY-ZPERNR.

      WHEN '05'.

          UPDATE ZEDT24_105 SET ZMON05 = LV_MONTHPAY WHERE ZPERNR = GS_IN_MONTHPAY-ZPERNR.

      WHEN '06'.

          UPDATE ZEDT24_105 SET ZMON06 = LV_MONTHPAY WHERE ZPERNR = GS_IN_MONTHPAY-ZPERNR.

      WHEN '07'.

          UPDATE ZEDT24_105 SET ZMON07 = LV_MONTHPAY WHERE ZPERNR = GS_IN_MONTHPAY-ZPERNR.

      WHEN '08'.

          UPDATE ZEDT24_105 SET ZMON08 = LV_MONTHPAY WHERE ZPERNR = GS_IN_MONTHPAY-ZPERNR.

      WHEN '09'.

          UPDATE ZEDT24_105 SET ZMON09 = LV_MONTHPAY WHERE ZPERNR = GS_IN_MONTHPAY-ZPERNR.

      WHEN '10'.

          UPDATE ZEDT24_105 SET ZMON10 = LV_MONTHPAY WHERE ZPERNR = GS_IN_MONTHPAY-ZPERNR.

      WHEN '11'.

          UPDATE ZEDT24_105 SET ZMON11 = LV_MONTHPAY WHERE ZPERNR = GS_IN_MONTHPAY-ZPERNR.

      WHEN '12'.

          UPDATE ZEDT24_105 SET ZMON12 = LV_MONTHPAY WHERE ZPERNR = GS_IN_MONTHPAY-ZPERNR.

    ENDCASE.



    IF SY-SUBRC <> 0.

      WRITE :/ '#### ##.'.

      MESSAGE '#### ##' TYPE 'E'.

      EXIT.

    ENDIF.

  ENDLOOP.

  WRITE :/ '### #######'.

ENDFORM.




*&---------------------------------------------------------------------*

*&      Form  MODIFY_DATA_EVAL

*&---------------------------------------------------------------------*

*       #### #### #### ## #### ####.

*----------------------------------------------------------------------*

*  -->  p1        text

*  <--  p2        text

*----------------------------------------------------------------------*




FORM MODIFY_DATA_EVAL .

  LOOP AT GT_IN_EVAL INTO GS_IN_EVAL.

    CLEAR GS_OUT_EVAL.



    "1. # ## # #### ##

    MOVE-CORRESPONDING GS_IN_EVAL TO GS_OUT_EVAL.

    PERFORM ZDEPCODE_2_ZDEPNAME USING GS_IN_EVAL-ZDEPCODE GS_OUT_EVAL-ZDEPNAME.

    PERFORM ZDEPRANK_2_ZDEPRANKNAME USING GS_IN_EVAL-ZDEPRANK GS_OUT_EVAL-ZDEPRANKNAME.



    "2. ## ##

    READ TABLE GT_105 INTO GS_105 WITH KEY ZPERNR = GS_OUT_EVAL-ZPERNR.



    CASE S_MONTH-LOW.

      WHEN '01'.

        GS_OUT_EVAL-ZMON = GS_105-ZMON01.

      WHEN '02'.

        GS_OUT_EVAL-ZMON = GS_105-ZMON02.

      WHEN '03'.

        GS_OUT_EVAL-ZMON = GS_105-ZMON03.

      WHEN '04'.

        GS_OUT_EVAL-ZMON = GS_105-ZMON04.

      WHEN '05'.

        GS_OUT_EVAL-ZMON = GS_105-ZMON05.

      WHEN '06'.

        GS_OUT_EVAL-ZMON = GS_105-ZMON06.

      WHEN '07'.

        GS_OUT_EVAL-ZMON = GS_105-ZMON07.

      WHEN '08'.

        GS_OUT_EVAL-ZMON = GS_105-ZMON08.

      WHEN '09'.

        GS_OUT_EVAL-ZMON = GS_105-ZMON09.

      WHEN '10'.

        GS_OUT_EVAL-ZMON = GS_105-ZMON10.

      WHEN '11'.

        GS_OUT_EVAL-ZMON = GS_105-ZMON11.

      WHEN '12'.

        GS_OUT_EVAL-ZMON = GS_105-ZMON12.

    ENDCASE.



    "3. ### 0# ## #### ##

    IF GS_OUT_EVAL-ZMON = 0 OR GS_OUT_EVAL-ZMON IS INITIAL.

      CONTINUE.

    ENDIF.



    APPEND GS_OUT_EVAL TO GT_OUT_EVAL.

  ENDLOOP.

ENDFORM.




*&---------------------------------------------------------------------*

*&      Form  ZDEPCODE_2_ZDEPNAME

*&---------------------------------------------------------------------*

*       ZDEPCODE# #### ##

*----------------------------------------------------------------------*

*      -->P_ZDEPCODE  DEPCODE #

*      <--P_ZDEPNAME  DEPCODE ## #### ##

*----------------------------------------------------------------------*




FORM ZDEPCODE_2_ZDEPNAME  USING    P_ZDEPCODE

                                   P_ZDEPNAME.

  CASE: P_ZDEPCODE. "###

    WHEN 'SS0001'. P_ZDEPNAME = '###'.

    WHEN 'SS0002'. P_ZDEPNAME = '###'.

    WHEN 'SS0003'. P_ZDEPNAME = '###'.

    WHEN 'SS0004'. P_ZDEPNAME = '###'.

    WHEN 'SS0005'. P_ZDEPNAME = '###'.

    WHEN 'SS0006'. P_ZDEPNAME = '###'.

  ENDCASE.

ENDFORM.




*&---------------------------------------------------------------------*

*&      Form  ZDEPRANK_2_ZDEPRANKNAME

*&---------------------------------------------------------------------*

*       ZDEPRANK# #### ##

*----------------------------------------------------------------------*

*      -->ZDEPRANK  ZDEPRANK #

*      <--ZDEPRANKNAME  ZDEPRANK ## #### ##

*----------------------------------------------------------------------*




FORM ZDEPRANK_2_ZDEPRANKNAME  USING    ZDEPRANK

                                       ZDEPRANKNAME.

  CASE: ZDEPRANK. "###

    WHEN 'A'. ZDEPRANKNAME = '##'.

    WHEN 'B'. ZDEPRANKNAME = '##'.

    WHEN 'C'. ZDEPRANKNAME = '##'.

    WHEN 'D'. ZDEPRANKNAME = '##'.

    WHEN 'E'. ZDEPRANKNAME = '##'.

    WHEN 'F'. ZDEPRANKNAME = '##'.

    WHEN 'G'. ZDEPRANKNAME = '##'.

  ENDCASE.

ENDFORM.




*&---------------------------------------------------------------------*

*&      Form  ZQFLAG_2_ZQSTR

*&---------------------------------------------------------------------*

*       ZFLAG# #### ##

*----------------------------------------------------------------------*

*      -->ZQFLAG  ZQFLAG #

*      <--ZQSTR  ZQFLAG ## #### ##

*----------------------------------------------------------------------*




FORM ZQFLAG_2_ZQSTR  USING    ZQFLAG

                              ZQSTR.

  CASE: ZQFLAG. "####

    WHEN 'X'. ZQSTR = '##'.

    WHEN OTHERS. ZQSTR = '##'.

  ENDCASE.

ENDFORM.




*&---------------------------------------------------------------------*

*&      Form  ZGENDER_2_ZGENDERSTR

*&---------------------------------------------------------------------*

*       ZGENDER# #### ##

*----------------------------------------------------------------------*

*      -->ZGENDER  ZGENDER #

*      <--ZGENDERSTR  ZGENDER ## #### ##

*----------------------------------------------------------------------*




FORM ZGENDER_2_ZGENDERSTR  USING    ZGENDER

                                    ZGENDERSTR.

  CASE : ZGENDER. "##

    WHEN 'M'. ZGENDERSTR = '##'.

    WHEN 'F'. ZGENDERSTR = '##'.

  ENDCASE.

ENDFORM.




*&---------------------------------------------------------------------*

*&      Form  ZBANKCODE_2_ZBANKNAME

*&---------------------------------------------------------------------*

*       ZBANKCODE# #### ##

*----------------------------------------------------------------------*

*      -->ZBANKCODE  ZBANKCODE #

*      <--ZBANKNAME  ZBANKCODE ## #### ##

*----------------------------------------------------------------------*




FORM ZBANKCODE_2_ZBANKNAME  USING    ZBANKCODE

                                     ZBANKNAME.

  CASE : ZBANKCODE. "###

    WHEN '001'. ZBANKNAME = '##'.

    WHEN '002'. ZBANKNAME = '##'.

    WHEN '003'. ZBANKNAME = '##'.

    WHEN '004'. ZBANKNAME = '##'.

    WHEN '005'. ZBANKNAME = '###'.

  ENDCASE.

ENDFORM.




*&---------------------------------------------------------------------*

*&      Form  ALV_DISPLAY_EMPLOYEE

*&---------------------------------------------------------------------*

*       #### ##

*----------------------------------------------------------------------*




FORM ALV_DISPLAY_EMPLOYEE .

  "1. ## ####

  DATA : LS_FIELDCAT TYPE SLIS_FIELDCAT_ALV.

  DATA : LT_FIELDCAT TYPE SLIS_T_FIELDCAT_ALV.

  PERFORM EMPLOYEE_FIELD_CATALOG USING LS_FIELDCAT LT_FIELDCAT.



  "2. ####

  DATA : LS_LAYOUT TYPE SLIS_LAYOUT_ALV.

  PERFORM ALV_LAYOUT USING LS_LAYOUT.



  "3. ##

  DATA : LS_SORT TYPE SLIS_SORTINFO_ALV.

  DATA : LT_SORT TYPE SLIS_T_SORTINFO_ALV.

  PERFORM ALV_SORT USING LS_SORT LT_SORT.



  CALL FUNCTION 'REUSE_ALV_GRID_DISPLAY'

    EXPORTING

      IT_FIELDCAT = LT_FIELDCAT

      IS_LAYOUT = LS_LAYOUT

      IT_SORT = LT_SORT

    TABLES

      T_OUTTAB = GT_OUT_EMPLOYEE.



  IF SY-SUBRC <> 0.

    STOP.

  ENDIF.

ENDFORM.




*&---------------------------------------------------------------------*

*&      Form  ALV_DISPLAY_EVAL

*&---------------------------------------------------------------------*

*       #### ##

*----------------------------------------------------------------------*

*  -->  p1        text

*  <--  p2        text

*----------------------------------------------------------------------*




FORM ALV_DISPLAY_EVAL .

  "1. ## ####

  DATA : LS_FIELDCAT TYPE SLIS_FIELDCAT_ALV.

  DATA : LT_FIELDCAT TYPE SLIS_T_FIELDCAT_ALV.

  PERFORM EVAL_FIELD_CATALOG USING LS_FIELDCAT LT_FIELDCAT.



  "2. ####

  DATA : LS_LAYOUT TYPE SLIS_LAYOUT_ALV.

  PERFORM ALV_LAYOUT USING LS_LAYOUT.



  "3. ##

  DATA : LS_SORT TYPE SLIS_SORTINFO_ALV.

  DATA : LT_SORT TYPE SLIS_T_SORTINFO_ALV.

  PERFORM ALV_SORT USING LS_SORT LT_SORT.



  CALL FUNCTION 'REUSE_ALV_GRID_DISPLAY'

    EXPORTING

      IT_FIELDCAT = LT_FIELDCAT

      IS_LAYOUT = LS_LAYOUT

      IT_SORT = LT_SORT

    TABLES

      T_OUTTAB = GT_OUT_EVAL.



  IF SY-SUBRC <> 0.

    STOP.

  ENDIF.

ENDFORM.




*&---------------------------------------------------------------------*

*&      Form  EMPLOYEE_FIELD_CATALOG

*&---------------------------------------------------------------------*

*       #### ### ## ###### ##

*----------------------------------------------------------------------*

*      -->P_LS_FIELDCAT  text

*      <--P_LT_FIELDCAT  text

*----------------------------------------------------------------------*




FORM EMPLOYEE_FIELD_CATALOG  USING    P_LS_FIELDCAT TYPE SLIS_FIELDCAT_ALV

                                      P_LT_FIELDCAT TYPE SLIS_T_FIELDCAT_ALV.

  CLEAR : P_LS_FIELDCAT, P_LT_FIELDCAT.

  P_LS_FIELDCAT-COL_POS = 1.

  P_LS_FIELDCAT-FIELDNAME = 'ZPERNR'.

  P_LS_FIELDCAT-SELTEXT_M = '####'.

  P_LS_FIELDCAT-KEY = 'X'.

  APPEND P_LS_FIELDCAT TO P_LT_FIELDCAT.



  CLEAR : P_LS_FIELDCAT.

  P_LS_FIELDCAT-COL_POS = 2.

  P_LS_FIELDCAT-FIELDNAME = 'ZPNAME'.

  P_LS_FIELDCAT-SELTEXT_M = '####'.

  P_LS_FIELDCAT-KEY = 'X'.

  APPEND P_LS_FIELDCAT TO P_LT_FIELDCAT.



  CLEAR : P_LS_FIELDCAT.

  P_LS_FIELDCAT-COL_POS = 3.

  P_LS_FIELDCAT-FIELDNAME = 'ZDEPCODE'.

  P_LS_FIELDCAT-SELTEXT_M = '####'.

  APPEND P_LS_FIELDCAT TO P_LT_FIELDCAT.



 CLEAR : P_LS_FIELDCAT.

  P_LS_FIELDCAT-COL_POS = 4.

  P_LS_FIELDCAT-FIELDNAME = 'ZDEPNAME'.

  P_LS_FIELDCAT-SELTEXT_M = '###'.

  APPEND P_LS_FIELDCAT TO P_LT_FIELDCAT.



  CLEAR : P_LS_FIELDCAT.

  P_LS_FIELDCAT-COL_POS = 5.

  P_LS_FIELDCAT-FIELDNAME = 'ZDEPRANKNAME'.

  P_LS_FIELDCAT-SELTEXT_M = '###'.

  APPEND P_LS_FIELDCAT TO P_LT_FIELDCAT.



  CLEAR : P_LS_FIELDCAT.

  P_LS_FIELDCAT-COL_POS = 6.

  P_LS_FIELDCAT-FIELDNAME = 'ZEDATE'.

  P_LS_FIELDCAT-SELTEXT_M = '###'.

  APPEND P_LS_FIELDCAT TO P_LT_FIELDCAT.



  CLEAR : P_LS_FIELDCAT.

  P_LS_FIELDCAT-COL_POS = 7.

  P_LS_FIELDCAT-FIELDNAME = 'ZQSTR'.

  P_LS_FIELDCAT-SELTEXT_M = '####'.

  APPEND P_LS_FIELDCAT TO P_LT_FIELDCAT.



  CLEAR : P_LS_FIELDCAT.

  P_LS_FIELDCAT-COL_POS = 8.

  P_LS_FIELDCAT-FIELDNAME = 'ZGENDERSTR'.

  P_LS_FIELDCAT-SELTEXT_M = '##'.

  APPEND P_LS_FIELDCAT TO P_LT_FIELDCAT.



  CLEAR : P_LS_FIELDCAT.

  P_LS_FIELDCAT-COL_POS = 9.

  P_LS_FIELDCAT-FIELDNAME = 'ZADDRESS'.

  P_LS_FIELDCAT-SELTEXT_M = '##'.

  APPEND P_LS_FIELDCAT TO P_LT_FIELDCAT.



  CLEAR : P_LS_FIELDCAT.

  P_LS_FIELDCAT-COL_POS = 10.

  P_LS_FIELDCAT-FIELDNAME = 'ZBANKCODE'.

  P_LS_FIELDCAT-SELTEXT_M = '####'.

  APPEND P_LS_FIELDCAT TO P_LT_FIELDCAT.



  CLEAR : P_LS_FIELDCAT.

  P_LS_FIELDCAT-COL_POS = 11.

  P_LS_FIELDCAT-FIELDNAME = 'ZBANKNAME'.

  P_LS_FIELDCAT-SELTEXT_M = '###'.

  APPEND P_LS_FIELDCAT TO P_LT_FIELDCAT.



  CLEAR : P_LS_FIELDCAT.

  P_LS_FIELDCAT-COL_POS = 12.

  P_LS_FIELDCAT-FIELDNAME = 'ZACCOUNT'.

  P_LS_FIELDCAT-SELTEXT_M = '####'.

  APPEND P_LS_FIELDCAT TO P_LT_FIELDCAT.

ENDFORM.






*&---------------------------------------------------------------------*

*&      Form  EVAL_FIELD_CATALOG

*&---------------------------------------------------------------------*

*       #### ### ## ###### ##

*----------------------------------------------------------------------*

*      -->P_LS_FIELDCAT  text

*      -->P_LT_FIELDCAT  text

*----------------------------------------------------------------------*




FORM EVAL_FIELD_CATALOG  USING    P_LS_FIELDCAT TYPE SLIS_FIELDCAT_ALV

                                  P_LT_FIELDCAT TYPE SLIS_T_FIELDCAT_ALV.

  CLEAR : P_LS_FIELDCAT, P_LT_FIELDCAT.

  P_LS_FIELDCAT-COL_POS = 1.

  P_LS_FIELDCAT-FIELDNAME = 'ZPERNR'.

  P_LS_FIELDCAT-SELTEXT_M = '####'.

  P_LS_FIELDCAT-KEY = 'X'.

  APPEND P_LS_FIELDCAT TO P_LT_FIELDCAT.



  CLEAR : P_LS_FIELDCAT.

  P_LS_FIELDCAT-COL_POS = 2.

  P_LS_FIELDCAT-FIELDNAME = 'ZPNAME'.

  P_LS_FIELDCAT-SELTEXT_M = '####'.

  P_LS_FIELDCAT-KEY = 'X'.

  APPEND P_LS_FIELDCAT TO P_LT_FIELDCAT.



  CLEAR : P_LS_FIELDCAT.

  P_LS_FIELDCAT-COL_POS = 3.

  P_LS_FIELDCAT-FIELDNAME = 'ZDEPCODE'.

  P_LS_FIELDCAT-SELTEXT_M = '####'.

  APPEND P_LS_FIELDCAT TO P_LT_FIELDCAT.



 CLEAR : P_LS_FIELDCAT.

  P_LS_FIELDCAT-COL_POS = 4.

  P_LS_FIELDCAT-FIELDNAME = 'ZDEPNAME'.

  P_LS_FIELDCAT-SELTEXT_M = '###'.

  APPEND P_LS_FIELDCAT TO P_LT_FIELDCAT.



  CLEAR : P_LS_FIELDCAT.

  P_LS_FIELDCAT-COL_POS = 5.

  P_LS_FIELDCAT-FIELDNAME = 'ZDEPRANKNAME'.

  P_LS_FIELDCAT-SELTEXT_M = '###'.

  APPEND P_LS_FIELDCAT TO P_LT_FIELDCAT.



  CLEAR : P_LS_FIELDCAT.

  P_LS_FIELDCAT-COL_POS = 6.

  P_LS_FIELDCAT-FIELDNAME = 'ZEDATE'.

  P_LS_FIELDCAT-SELTEXT_M = '###'.

  P_LS_FIELDCAT-OUTPUTLEN = 10.

  APPEND P_LS_FIELDCAT TO P_LT_FIELDCAT.



  CLEAR : P_LS_FIELDCAT.

  P_LS_FIELDCAT-COL_POS = 7.

  P_LS_FIELDCAT-FIELDNAME = 'ZSALARY'.

  P_LS_FIELDCAT-CURRENCY = 'KRW'.

  P_LS_FIELDCAT-SELTEXT_M = '####'.

  P_LS_FIELDCAT-DO_SUM = 'X'.

  P_LS_FIELDCAT-OUTPUTLEN = 20.

  APPEND P_LS_FIELDCAT TO P_LT_FIELDCAT.



  CLEAR : P_LS_FIELDCAT.

  P_LS_FIELDCAT-COL_POS = 8.

  P_LS_FIELDCAT-FIELDNAME = 'ZRANK'.

  P_LS_FIELDCAT-SELTEXT_M = '####'.

  APPEND P_LS_FIELDCAT TO P_LT_FIELDCAT.



  CLEAR : P_LS_FIELDCAT.

  P_LS_FIELDCAT-COL_POS = 9.

  P_LS_FIELDCAT-FIELDNAME = 'ZMON'.

  P_LS_FIELDCAT-CURRENCY = 'KRW'.

  P_LS_FIELDCAT-DO_SUM = 'X'.

  P_LS_FIELDCAT-OUTPUTLEN = 20.

  CONCATENATE S_MONTH-LOW '####' INTO P_LS_FIELDCAT-SELTEXT_M.

  APPEND P_LS_FIELDCAT TO P_LT_FIELDCAT.

ENDFORM.






*&---------------------------------------------------------------------*

*&      Form  ALV_LAYOUT

*&---------------------------------------------------------------------*

*       #### ## ##

*----------------------------------------------------------------------*

*      <--P_LS_LAYOUT  #### ### ### ###

*----------------------------------------------------------------------*




FORM ALV_LAYOUT  USING    P_LS_LAYOUT TYPE SLIS_LAYOUT_ALV.

  P_LS_LAYOUT-ZEBRA = 'X'.

ENDFORM.




*&---------------------------------------------------------------------*

*&      Form  ALV_SORT

*&---------------------------------------------------------------------*

*       text

*----------------------------------------------------------------------*

*      -->P_LS_SORT  text

*      -->P_LT_SORT  text

*----------------------------------------------------------------------*




FORM ALV_SORT  USING    P_LS_SORT TYPE SLIS_SORTINFO_ALV

                        P_LT_SORT TYPE SLIS_T_SORTINFO_ALV.

  CLEAR P_LS_SORT.

  P_LS_SORT = 1.

  P_LS_SORT-FIELDNAME = 'ZPERNR'.

  P_LS_SORT-UP = 'X'.

  APPEND P_LS_SORT TO P_LT_SORT.



ENDFORM.








*Messages

*----------------------------------------------------------

*

* Message class: Hard coded

*   #### ##