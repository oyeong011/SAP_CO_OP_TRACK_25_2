
*&---------------------------------------------------------------------*

*& Report ZEDR21_PRACTICE007

*&---------------------------------------------------------------------*

*&

*&---------------------------------------------------------------------*




REPORT ZEDR21_PRACTICE007.




*&---------------------------------------------------------------------*

*& REPORT ZEDR21_PRACTICE007

*&---------------------------------------------------------------------*

*& ## #### ####

*& ##: #### / #### / ####

*&---------------------------------------------------------------------*










TABLES : ZEDT21_101, ZEDT21_102, ZEDT21_103, ZEDT21_104, ZEDT21_105, ZEDT21_106.






*---------------------------------------------------------------------*

* ### ## ##

*---------------------------------------------------------------------*




DATA : BEGIN OF GS_EMP,

  ZPERNR21    TYPE ZEDT21_102-ZPERNR21,

  ZPNAME21      TYPE ZEDT21_103-ZPNAME21,

  ZDEPCODE21  TYPE ZEDT21_102-ZDEPCODE21,

  ZDEPNAME21    TYPE CHAR20,

  ZDEPRANK21  TYPE ZEDT21_102-ZDEPRANK21,

  ZRANKNAME21   TYPE CHAR20,

  ZEDATE21    TYPE ZEDT21_102-ZEDATE21,

  ZQDATE21    TYPE ZEDT21_102-ZQDATE21,

  ZQFLAG21    TYPE ZEDT21_102-ZQFLAG21,

  ZQFLAG_T    TYPE CHAR10,

  ZGENDER21   TYPE ZEDT21_103-ZGENDER21,

  ZADDRESS21  TYPE ZEDT21_103-ZADDRESS21,

  ZBANKCODE21 TYPE ZEDT21_106-ZBANKCODE21,

  ZBANKNAME21   TYPE CHAR20,

  ZACCOUNT21  TYPE ZEDT21_106-ZACCOUNT21,

END OF GS_EMP.



DATA : BEGIN OF GS_SAL,

  ZPERNR21    TYPE ZEDT21_102-ZPERNR21,

  ZPNAME21      TYPE ZEDT21_103-ZPNAME21,

  ZDEPCODE21  TYPE ZEDT21_102-ZDEPCODE21,

  ZDEPNAME21    TYPE CHAR20,

  ZDEPRANK21  TYPE ZEDT21_102-ZDEPRANK21,

  ZRANKNAME   TYPE CHAR20,

  ZEDATE21    TYPE ZEDT21_102-ZEDATE21,

  ZQDATE21    TYPE ZEDT21_102-ZQDATE21,

  ZQFLAG21    TYPE ZEDT21_102-ZQFLAG21,

  ZSALARY21   TYPE ZEDT21_106-ZSALARY21,

  ZPAY_AMT    TYPE ZEDT21_106-ZSALARY21,

  ZRANK21     TYPE ZEDT21_104-ZRANK21,

  ZMON01      TYPE ZEDT21_105-ZMON01,

  ZMON02      TYPE ZEDT21_105-ZMON02,

  ZMON03      TYPE ZEDT21_105-ZMON03,

  ZMON04      TYPE ZEDT21_105-ZMON04,

  ZMON05      TYPE ZEDT21_105-ZMON05,

  ZMON06      TYPE ZEDT21_105-ZMON06,

  ZMON07      TYPE ZEDT21_105-ZMON07,

  ZMON08      TYPE ZEDT21_105-ZMON08,

  ZMON09      TYPE ZEDT21_105-ZMON09,

  ZMON10      TYPE ZEDT21_105-ZMON10,

  ZMON11      TYPE ZEDT21_105-ZMON11,

  ZMON12      TYPE ZEDT21_105-ZMON12,

END OF GS_SAL.



DATA : BEGIN OF GS_EVAL,

  ZPERNR21    TYPE ZEDT21_102-ZPERNR21,

  ZPNAME21      TYPE ZEDT21_103-ZPNAME21,

  ZDEPCODE21  TYPE ZEDT21_102-ZDEPCODE21,

  ZDEPNAME21    TYPE CHAR20,

  ZDEPRANK21  TYPE ZEDT21_102-ZDEPRANK21,

  ZRANKNAME21   TYPE CHAR20,

  ZQFLAG21    TYPE ZEDT21_102-ZQFLAG21,

  ZQFLAG_T    TYPE CHAR10,

  ZRANK21     TYPE ZEDT21_104-ZRANK21,

  ZSALARY21   TYPE ZEDT21_106-ZSALARY21,

END OF GS_EVAL.






*---------------------------------------------------------------------*

* ## ##

*---------------------------------------------------------------------*




CONSTANTS : C_CHECK  TYPE C VALUE 'X',

            C_MALE   TYPE C VALUE 'M',

            C_FEMALE TYPE C VALUE 'F',

            C_RANK_A TYPE C VALUE 'A',

            C_BONUS  TYPE P DECIMALS 2 VALUE '50000.00',

            C_QUIT   TYPE C VALUE 'X',

            C_ACTIVE TYPE CHAR10 VALUE '##',

            C_QUIT_T TYPE CHAR10 VALUE '##'.






*---------------------------------------------------------------------*

* ## ###

*---------------------------------------------------------------------*




DATA : GT_EMP  LIKE TABLE OF GS_EMP,

       GT_SAL  LIKE TABLE OF GS_SAL,

       GT_EVAL LIKE TABLE OF GS_EVAL.






*---------------------------------------------------------------------*

* ALV ##

*---------------------------------------------------------------------*




DATA : GT_FCAT  TYPE SLIS_T_FIELDCAT_ALV,

       GS_FCAT  TYPE SLIS_FIELDCAT_ALV,

       GT_SORT  TYPE SLIS_T_SORTINFO_ALV,

       GS_SORT  TYPE SLIS_SORTINFO_ALV,

       GS_LAYOUT TYPE SLIS_LAYOUT_ALV.






*---------------------------------------------------------------------*

* RANGE

*---------------------------------------------------------------------*




RANGES : R_DATE  FOR ZEDT21_102-ZEDATE21,

          R_PERNR FOR ZEDT21_102-ZPERNR21,

          R_YEAR  FOR ZEDT21_104-ZYEAR21.






*---------------------------------------------------------------------*

* ## ## # ### (INSERT ## ## # ###)

*---------------------------------------------------------------------*




TYPES: BEGIN OF TY_MAP,

         CODE TYPE CHAR10,

         TEXT TYPE CHAR50,

       END OF TY_MAP.



DATA GT_MAP_DEPT TYPE TABLE OF TY_MAP.

DATA GT_MAP_RANK TYPE TABLE OF TY_MAP.

DATA GT_MAP_BANK TYPE TABLE OF TY_MAP.



INITIALIZATION.



  APPEND VALUE #( CODE = 'SS0001' TEXT = '###' ) TO GT_MAP_DEPT.

  APPEND VALUE #( CODE = 'SS0002' TEXT = '###' ) TO GT_MAP_DEPT.

  APPEND VALUE #( CODE = 'SS0003' TEXT = '###' ) TO GT_MAP_DEPT.

  APPEND VALUE #( CODE = 'SS0004' TEXT = '###' ) TO GT_MAP_DEPT.

  APPEND VALUE #( CODE = 'SS0005' TEXT = '###' ) TO GT_MAP_DEPT.

  APPEND VALUE #( CODE = 'SS0006' TEXT = '###' ) TO GT_MAP_DEPT.



  APPEND VALUE #( CODE = 'A' TEXT = '##' ) TO GT_MAP_RANK.

  APPEND VALUE #( CODE = 'B' TEXT = '##' ) TO GT_MAP_RANK.

  APPEND VALUE #( CODE = 'C' TEXT = '##' ) TO GT_MAP_RANK.

  APPEND VALUE #( CODE = 'D' TEXT = '##' ) TO GT_MAP_RANK.

  APPEND VALUE #( CODE = 'E' TEXT = '##' ) TO GT_MAP_RANK.

  APPEND VALUE #( CODE = 'F' TEXT = '##' ) TO GT_MAP_RANK.

  APPEND VALUE #( CODE = 'G' TEXT = '##' ) TO GT_MAP_RANK.



  APPEND VALUE #( CODE = '001' TEXT = '##' )  TO GT_MAP_BANK.

  APPEND VALUE #( CODE = '002' TEXT = '##' )  TO GT_MAP_BANK.

  APPEND VALUE #( CODE = '003' TEXT = '##' )  TO GT_MAP_BANK.

  APPEND VALUE #( CODE = '004' TEXT = '##' ) TO GT_MAP_BANK.

  APPEND VALUE #( CODE = '005' TEXT = '###' ) TO GT_MAP_BANK.




*---------------------------------------------------------------------*

* SELECTION SCREEN

*---------------------------------------------------------------------*




SELECTION-SCREEN BEGIN OF BLOCK B1 WITH FRAME.

  SELECT-OPTIONS S_PERNR FOR ZEDT21_102-ZPERNR21 MODIF ID ALL.

  SELECT-OPTIONS S_DATE  FOR ZEDT21_102-ZEDATE21 MODIF ID M1.

  SELECT-OPTIONS S_DEPT  FOR ZEDT21_102-ZDEPCODE21 MODIF ID M1.

  PARAMETERS : P_YEAR  TYPE ZEDT21_104-ZYEAR21 MODIF ID M2,

               P_MONTH TYPE NUMC2 MODIF ID M2.

SELECTION-SCREEN END OF BLOCK B1.



SELECTION-SCREEN BEGIN OF BLOCK B2 WITH FRAME.

  PARAMETERS : P_RAD1 RADIOBUTTON GROUP RB1 DEFAULT 'X' USER-COMMAND UC1,

               P_RAD2 RADIOBUTTON GROUP RB1,

               P_RAD3 RADIOBUTTON GROUP RB1.

SELECTION-SCREEN END OF BLOCK B2.



SELECTION-SCREEN BEGIN OF BLOCK B3 WITH FRAME.

  PARAMETERS : P_CH1 AS CHECKBOX DEFAULT 'X' MODIF ID M1.

SELECTION-SCREEN END OF BLOCK B3.






*---------------------------------------------------------------------*

* ## ###

*---------------------------------------------------------------------*




INITIALIZATION.

  PERFORM GET_LAST_DAY.



AT SELECTION-SCREEN OUTPUT.

  PERFORM SET_SCREEN.



AT SELECTION-SCREEN.

  PERFORM CHECK_INPUT.



START-OF-SELECTION.

  PERFORM MAIN_PROCESS.



END-OF-SELECTION.






*---------------------------------------------------------------------*

* FORM GET_LAST_DAY : ### ### # ##

*---------------------------------------------------------------------*




FORM GET_LAST_DAY.

  P_YEAR  = SY-DATUM(4).

  P_MONTH = SY-DATUM+4(2).



  S_DATE-SIGN   = 'I'.

  S_DATE-OPTION = 'BT'.

  S_DATE-LOW    = SY-DATUM(4) && '0101'.



  CALL FUNCTION 'RP_LAST_DAY_OF_MONTHS'

    EXPORTING DAY_IN = SY-DATUM

    IMPORTING LAST_DAY_OF_MONTH = S_DATE-HIGH.



  APPEND S_DATE.

ENDFORM.






*---------------------------------------------------------------------*

* FORM SET_SCREEN : ###### ## ##

*---------------------------------------------------------------------*




FORM SET_SCREEN.

  LOOP AT SCREEN.

    CASE SCREEN-GROUP1.

      WHEN 'M1'.

        SCREEN-ACTIVE = COND #( WHEN P_RAD1 = C_CHECK THEN 1 ELSE 0 ).

      WHEN 'M2'.

        SCREEN-ACTIVE = COND #( WHEN P_RAD2 = C_CHECK OR P_RAD3 = C_CHECK THEN 1 ELSE 0 ).

      WHEN 'ALL'.

        SCREEN-ACTIVE = 1.

    ENDCASE.

    MODIFY SCREEN.

  ENDLOOP.

ENDFORM.






*---------------------------------------------------------------------*

* FORM CHECK_INPUT : ### ##

*---------------------------------------------------------------------*




FORM CHECK_INPUT.

  IF P_RAD1 = C_CHECK.

    IF S_DATE[] IS INITIAL.

      MESSAGE '##### ######' TYPE 'E'.

    ENDIF.

  ELSEIF P_RAD2 = C_CHECK.

    IF P_YEAR IS INITIAL OR P_MONTH IS INITIAL.

      MESSAGE '##/## ######' TYPE 'E'.

    ENDIF.

    IF P_MONTH < 1 OR P_MONTH > 12.

      MESSAGE '## 1~12 ### #### ###.' TYPE 'E'.

    ENDIF.

  ELSEIF P_RAD3 = C_CHECK.

    IF P_YEAR IS INITIAL.

      MESSAGE '##### ######' TYPE 'E'.

    ENDIF.

  ENDIF.

ENDFORM.






*---------------------------------------------------------------------*

* FORM MAIN_PROCESS : ## ##

*---------------------------------------------------------------------*




FORM MAIN_PROCESS.

  IF P_RAD1 = C_CHECK.

    PERFORM GET_EMP_INFO.

    PERFORM DISPLAY_EMP.

  ELSEIF P_RAD2 = C_CHECK.

    PERFORM GET_PAY_INFO.

    PERFORM DISPLAY_PAY.

  ELSEIF P_RAD3 = C_CHECK.

    PERFORM GET_EVAL_INFO.

    PERFORM DISPLAY_EVAL.

  ENDIF.

ENDFORM.






*---------------------------------------------------------------------*

* FORM GET_EMP_INFO : #### ##

*---------------------------------------------------------------------*




FORM GET_EMP_INFO.

  SELECT

    B~ZPERNR21, A~ZDEPRANK21, A~ZDEPCODE21, A~ZEDATE21, A~ZQDATE21, A~ZQFLAG21,

    B~ZGENDER21, B~ZPNAME21, B~ZADDRESS21,

    C~ZBANKCODE21, C~ZACCOUNT21

    FROM ZEDT21_102 AS A

    LEFT JOIN ZEDT21_103 AS B ON A~ZPERNR21 = B~ZPERNR21

    LEFT JOIN ZEDT21_106 AS C ON A~ZPERNR21 = C~ZPERNR21

    WHERE A~ZPERNR21 IN @S_PERNR

      AND A~ZEDATE21 IN @S_DATE

    INTO CORRESPONDING FIELDS OF TABLE @GT_EMP.



  IF P_CH1 = C_CHECK.

    DELETE GT_EMP WHERE ZQFLAG21 = C_QUIT AND ZQDATE21 IS NOT INITIAL.

  ELSE.

    DELETE GT_EMP WHERE ZQFLAG21 = C_QUIT AND ZQDATE21 <= S_DATE-HIGH.

  ENDIF.



  PERFORM CONVERT_KO.

ENDFORM.






*---------------------------------------------------------------------*

* FORM CONVERT_KO : ##### ##(##)  [CASE ##, FS + #####]

*---------------------------------------------------------------------*




FORM CONVERT_KO.



  FIELD-SYMBOLS <FS_EMP> LIKE GS_EMP.

  DATA LS_MAP TYPE TY_MAP.



  LOOP AT GT_EMP ASSIGNING <FS_EMP>.



    " ##

    <FS_EMP>-ZGENDER21 =

      COND #( WHEN <FS_EMP>-ZGENDER21 = C_MALE   THEN '##'

              WHEN <FS_EMP>-ZGENDER21 = C_FEMALE THEN '##'

              ELSE <FS_EMP>-ZGENDER21 ).



    " ##/## ##

    <FS_EMP>-ZQFLAG_T =

      COND #( WHEN <FS_EMP>-ZQFLAG21 = C_QUIT THEN C_QUIT_T ELSE C_ACTIVE ).



    " ###

    READ TABLE GT_MAP_DEPT INTO LS_MAP WITH KEY CODE = <FS_EMP>-ZDEPCODE21.

    IF SY-SUBRC = 0.

      <FS_EMP>-ZDEPNAME21 = LS_MAP-TEXT.

    ENDIF.



    " ###

    READ TABLE GT_MAP_RANK INTO LS_MAP WITH KEY CODE = <FS_EMP>-ZDEPRANK21.

    IF SY-SUBRC = 0.

      <FS_EMP>-ZRANKNAME21 = LS_MAP-TEXT.

    ENDIF.



    " ###

    READ TABLE GT_MAP_BANK INTO LS_MAP WITH KEY CODE = <FS_EMP>-ZBANKCODE21.

    IF SY-SUBRC = 0.

      <FS_EMP>-ZBANKNAME21 = LS_MAP-TEXT.

    ENDIF.



  ENDLOOP.



ENDFORM.






*---------------------------------------------------------------------*

* FORM DISPLAY_EMP : #### ALV

*---------------------------------------------------------------------*




FORM DISPLAY_EMP.

  PERFORM SET_FIELDCAT_EMP.

  GS_LAYOUT-ZEBRA = 'X'.

  GS_LAYOUT-COLWIDTH_OPTIMIZE = 'X'.

  CALL FUNCTION 'REUSE_ALV_GRID_DISPLAY'

    EXPORTING

      IS_LAYOUT  = GS_LAYOUT

      IT_FIELDCAT = GT_FCAT

      IT_SORT     = GT_SORT

    TABLES

      T_OUTTAB    = GT_EMP.

ENDFORM.






*---------------------------------------------------------------------*

* FORM SET_FIELDCAT_EMP : #### FIELDCAT

*---------------------------------------------------------------------*




FORM SET_FIELDCAT_EMP.

  CLEAR GT_FCAT.

  PERFORM ADD_FCAT USING 'ZPERNR21'   '####'  '10'.

  PERFORM ADD_FCAT USING 'ZPNAME21'     '####'  '15'.

  PERFORM ADD_FCAT USING 'ZDEPCODE21' '####'  '10'.

  PERFORM ADD_FCAT USING 'ZDEPNAME21'   '###'    '20'.

  PERFORM ADD_FCAT USING 'ZRANKNAME21'  '###'    '15'.

  PERFORM ADD_FCAT USING 'ZEDATE21'   '###'    '10'.

  PERFORM ADD_FCAT USING 'ZQFLAG_T'   '####'  '10'.

  PERFORM ADD_FCAT USING 'ZGENDER21'  '##'      '10'.

  PERFORM ADD_FCAT USING 'ZADDRESS21' '##'      '30'.

  PERFORM ADD_FCAT USING 'ZBANKCODE21' '####' '10'.

  PERFORM ADD_FCAT USING 'ZBANKNAME21'  '###'    '20'.

  PERFORM ADD_FCAT USING 'ZACCOUNT21' '####'  '20'.

ENDFORM.






*---------------------------------------------------------------------*

* FORM ADD_FCAT : ## FIELDCAT ##

*---------------------------------------------------------------------*




FORM ADD_FCAT USING P_FIELDNAME TYPE CHAR30 P_TEXT TYPE CHAR50 P_OUTPUTLEN TYPE CHAR10.

  CLEAR GS_FCAT.

  GS_FCAT-FIELDNAME = P_FIELDNAME.

  GS_FCAT-SELTEXT_M = P_TEXT.

  GS_FCAT-OUTPUTLEN = P_OUTPUTLEN.

  APPEND GS_FCAT TO GT_FCAT.

ENDFORM.






*---------------------------------------------------------------------*

* FORM GET_PAY_INFO : ## ## ##

*---------------------------------------------------------------------*




FORM GET_PAY_INFO.



  DATA : LV_LAST_DAY TYPE D,

         LV_DAYIN    TYPE D,

         LV_AMT      TYPE P DECIMALS 2,

         LV_FLAG     TYPE C VALUE 'X',

         LS_MON      TYPE ZEDT21_105.



  CONCATENATE P_YEAR P_MONTH '01' INTO LV_DAYIN.



  CALL FUNCTION 'RP_LAST_DAY_OF_MONTHS'

    EXPORTING DAY_IN = LV_DAYIN

    IMPORTING LAST_DAY_OF_MONTH = LV_LAST_DAY.



  CLEAR GT_SAL.



  SELECT A~ZPERNR21, A~ZDEPCODE21, A~ZDEPRANK21, A~ZEDATE21, A~ZQFLAG21, A~ZQDATE21,

         B~ZPNAME21, C~ZSALARY21, D~ZRANK21

    FROM ZEDT21_102 AS A

    INNER JOIN ZEDT21_103 AS B ON A~ZPERNR21 = B~ZPERNR21

    LEFT  JOIN ZEDT21_106 AS C ON A~ZPERNR21 = C~ZPERNR21

    LEFT  JOIN ZEDT21_104 AS D ON A~ZPERNR21 = D~ZPERNR21 AND D~ZYEAR21 = @P_YEAR

    WHERE A~ZPERNR21 IN @S_PERNR

    INTO CORRESPONDING FIELDS OF TABLE @GT_SAL.



  DELETE GT_SAL WHERE ZEDATE21 > LV_LAST_DAY

                  OR ( ZQFLAG21 = C_QUIT AND ZQDATE21 <= LV_LAST_DAY ).



  LOOP AT GT_SAL INTO GS_SAL.

    LV_AMT = ( GS_SAL-ZSALARY21 * 100 ) / 12.

    IF GS_SAL-ZRANK21 = 'A'.

      LV_AMT = LV_AMT + 50000.

    ENDIF.



    SELECT SINGLE * FROM ZEDT21_105 INTO @LS_MON

      WHERE ZPERNR21 = @GS_SAL-ZPERNR21

        AND ZYEAR21  = @P_YEAR.



    IF SY-SUBRC <> 0.

      CLEAR LS_MON.

      LS_MON-ZPERNR21 = GS_SAL-ZPERNR21.

      LS_MON-ZYEAR21  = P_YEAR.

    ENDIF.



    ASSIGN COMPONENT |ZMON{ P_MONTH }| OF STRUCTURE LS_MON TO FIELD-SYMBOL(<FS_MON>).

    IF <FS_MON> IS ASSIGNED.

      <FS_MON> = LV_AMT.

    ENDIF.



    ASSIGN COMPONENT |ZMON{ P_MONTH }| OF STRUCTURE GS_SAL TO FIELD-SYMBOL(<FS_SAL>).

    IF <FS_SAL> IS ASSIGNED.

      <FS_SAL> = LV_AMT.

    ENDIF.



    GS_SAL-ZSALARY21 = GS_SAL-ZSALARY21 * 100.

    MODIFY GT_SAL FROM GS_SAL.



    MODIFY ZEDT21_105 FROM LS_MON.

    IF SY-SUBRC <> 0.

      LV_FLAG = SPACE.

      EXIT.

    ENDIF.

  ENDLOOP.



  IF LV_FLAG = 'X'.

    COMMIT WORK.

    MESSAGE '### #######.' TYPE 'S'.

  ELSE.

    ROLLBACK WORK.

    MESSAGE '#### ##' TYPE 'E'.

  ENDIF.









  PERFORM CONVERT_KO_PAY.

ENDFORM.






*---------------------------------------------------------------------*

* FORM CONVERT_KO_PAY : ##### ##(##) [CASE ##, FS + #####]

*---------------------------------------------------------------------*




FORM CONVERT_KO_PAY.



  FIELD-SYMBOLS <FS_SAL> LIKE GS_SAL.

  DATA LS_MAP TYPE TY_MAP.



  LOOP AT GT_SAL ASSIGNING <FS_SAL>.



    READ TABLE GT_MAP_DEPT INTO LS_MAP WITH KEY CODE = <FS_SAL>-ZDEPCODE21.

    IF SY-SUBRC = 0.

      <FS_SAL>-ZDEPNAME21 = LS_MAP-TEXT.

    ENDIF.



    READ TABLE GT_MAP_RANK INTO LS_MAP WITH KEY CODE = <FS_SAL>-ZDEPRANK21.

    IF SY-SUBRC = 0.

      <FS_SAL>-ZRANKNAME = LS_MAP-TEXT.

    ENDIF.



  ENDLOOP.



ENDFORM.






*---------------------------------------------------------------------*

* FORM DISPLAY_PAY : ## ALV

*---------------------------------------------------------------------*




FORM DISPLAY_PAY.

  PERFORM SET_FIELDCAT_PAY_INFO.

  GS_LAYOUT-ZEBRA = 'X'.

  GS_LAYOUT-COLWIDTH_OPTIMIZE = 'X'.

  CALL FUNCTION 'REUSE_ALV_GRID_DISPLAY'

    EXPORTING

      IS_LAYOUT  = GS_LAYOUT

      IT_FIELDCAT = GT_FCAT

    TABLES

      T_OUTTAB    = GT_SAL.

ENDFORM.






*---------------------------------------------------------------------*

* FORM SET_FIELDCAT_PAY_INFO : ## FIELDCAT

*---------------------------------------------------------------------*




FORM SET_FIELDCAT_PAY_INFO.

  CLEAR GT_FCAT.

  PERFORM ADD_FCAT USING 'ZPERNR21'   '####'   '10'.

  PERFORM ADD_FCAT USING 'ZPNAME21'     '####'   '15'.

  PERFORM ADD_FCAT USING 'ZDEPCODE21' '####'   '10'.

  PERFORM ADD_FCAT USING 'ZDEPNAME21'   '###'     '15'.

  PERFORM ADD_FCAT USING 'ZRANKNAME21'  '###'     '10'.

  PERFORM ADD_FCAT USING 'ZEDATE21'   '###'     '10'.



  DATA: LS_SALARY TYPE SLIS_FIELDCAT_ALV.

  CLEAR LS_SALARY.

  LS_SALARY-FIELDNAME    = 'ZSALARY21'.

  LS_SALARY-SELTEXT_M    = '####'.

  LS_SALARY-OUTPUTLEN    = 30.

  LS_SALARY-DECIMALS_OUT = 0.

  LS_SALARY-DO_SUM       = SPACE.

  APPEND LS_SALARY TO GT_FCAT.



  PERFORM ADD_FCAT USING 'ZRANK21' '####' '10'.



  DATA: LV_FIELD TYPE CHAR30,

        LV_TEXT  TYPE CHAR50.

  LV_FIELD = |ZMON{ P_MONTH }|.

  LV_TEXT  = |{ P_MONTH }# ###|.



  DATA: LS_MON_FC TYPE SLIS_FIELDCAT_ALV.

  CLEAR LS_MON_FC.

  LS_MON_FC-FIELDNAME    = LV_FIELD.

  LS_MON_FC-SELTEXT_M    = LV_TEXT.

  LS_MON_FC-OUTPUTLEN    = 30.

  LS_MON_FC-DECIMALS_OUT = 0.

  LS_MON_FC-DO_SUM       = SPACE.

  APPEND LS_MON_FC TO GT_FCAT.











ENDFORM.






*---------------------------------------------------------------------*

* FORM GET_EVAL_INFO : ## ##

*---------------------------------------------------------------------*




FORM GET_EVAL_INFO.

  SELECT A~ZPERNR21, B~ZPNAME21, A~ZDEPCODE21, A~ZDEPRANK21, A~ZQFLAG21,

         C~ZSALARY21, D~ZRANK21

    FROM ZEDT21_102 AS A

    INNER JOIN ZEDT21_103 AS B ON A~ZPERNR21 = B~ZPERNR21

    LEFT  JOIN ZEDT21_106 AS C ON A~ZPERNR21 = C~ZPERNR21

    LEFT  JOIN ZEDT21_104 AS D ON A~ZPERNR21 = D~ZPERNR21

      AND D~ZYEAR21 = @P_YEAR

    INTO CORRESPONDING FIELDS OF TABLE @GT_EVAL.



  LOOP AT GT_EVAL INTO GS_EVAL.

    GS_EVAL-ZQFLAG_T = COND #( WHEN GS_EVAL-ZQFLAG21 = C_QUIT THEN C_QUIT_T ELSE C_ACTIVE ).

    MODIFY GT_EVAL FROM GS_EVAL.

  ENDLOOP.



  " ##/### ## ## ##

  PERFORM CONVERT_KO_EVAL.

ENDFORM.






*---------------------------------------------------------------------*

* FORM DISPLAY_EVAL : ## ALV

*---------------------------------------------------------------------*




FORM DISPLAY_EVAL.

  CLEAR GT_FCAT.

  PERFORM ADD_FCAT USING 'ZPERNR21'  '####'  '10'.

  PERFORM ADD_FCAT USING 'ZPNAME21'    '####'  '15'.

  PERFORM ADD_FCAT USING 'ZDEPNAME21'  '###'    '15'.

  PERFORM ADD_FCAT USING 'ZRANK21'   '####'  '10'.

  PERFORM ADD_FCAT USING 'ZSALARY21' '####'  '10'.



  GS_LAYOUT-ZEBRA = 'X'.

  GS_LAYOUT-COLWIDTH_OPTIMIZE = 'X'.



  CALL FUNCTION 'REUSE_ALV_GRID_DISPLAY'

    EXPORTING

      IS_LAYOUT  = GS_LAYOUT

      IT_FIELDCAT = GT_FCAT

    TABLES

      T_OUTTAB    = GT_EVAL.

ENDFORM.

FORM CONVERT_KO_EVAL.



  FIELD-SYMBOLS <FS_EVAL> LIKE GS_EVAL.

  DATA LS_MAP TYPE TY_MAP.



  LOOP AT GT_EVAL ASSIGNING <FS_EVAL>.



    " ### ##

    READ TABLE GT_MAP_DEPT INTO LS_MAP

      WITH KEY CODE = <FS_EVAL>-ZDEPCODE21.

    IF SY-SUBRC = 0.

      <FS_EVAL>-ZDEPNAME21 = LS_MAP-TEXT.

    ENDIF.



    " ### ##

    READ TABLE GT_MAP_RANK INTO LS_MAP

      WITH KEY CODE = <FS_EVAL>-ZDEPRANK21.

    IF SY-SUBRC = 0.

      <FS_EVAL>-ZRANKNAME21 = LS_MAP-TEXT.

    ENDIF.



    " ##/##

    <FS_EVAL>-ZQFLAG_T =

      COND #( WHEN <FS_EVAL>-ZQFLAG21 = C_QUIT

              THEN C_QUIT_T ELSE C_ACTIVE ).



  ENDLOOP.



ENDFORM.








*Messages

*----------------------------------------------------------

*

* Message class: Hard coded

*   ##### ######