
*&---------------------------------------------------------------------*

*& Report ZEDR05_PRACTICE006

*&---------------------------------------------------------------------*

*&

*&---------------------------------------------------------------------*



*2. ZEDR00_PRACTICE006 "######" ######




REPORT ZEDR19_048.




*1. DOMAIN, ELEMENT# #### TABLE##

*3. ## ###### ### ##### ## ### ### ##, ALV### ITAB ## ##

*6. SELECT, MODIFY, ALV # ## ##### ### PERFORM# #### PERFORM# ### #####

*7. USING, CHANGING 1### ##

*8. CONSTANTS 1### ####, ### ##

*9. CASE# ### ##

*10. STOP, EXIT, CHECK, CONTINUE ## 1# ## ##

*11. ##### #### ### ###### ####

*12. ALV### ######, LAYOUT, SORT### ##

*

*13. ###### 3## ###, ### ### ### ## ###. (### ### ## ### # ##)

*13-1. ####

*1)ALV# ##

*3)#### ##### ##### #### ### #### ##, # ##### ### ## # #### #### ### ##, #### ### # ##

*4)##### ### #######(ZEDT00_102)### # ####_FROM ~####_TO # ## #### #### #####

*ex. ##### ### 2025.01.01~ 2025.01.31# ##### #### 2025.02.01 ## # #### ### ##

*5)### ##### ##

*6)### ##,## ### ### ## # # ##

*7)###, ### ### ##

*

*13-2. ####

*1)ALV# ### ## ## #### ### ## ### #### ### ####

*2)#### ### ##### ## ## ZEDT00_105# ZMONXX (#####)# UPDATE## ### #### ### ### CASE ### #### ## ##

*3)#### ##### #### #### #### (ex. 3#### 3##### ##)

*4)##### ## ### #### #### ### #### , ###### ### ## ##

*5)#### # ## #### ### ##/12# ## , ### A## #### 5## #### ####. ###, ###### #####, ###, ### ##### ####

*6)#####(ZEDT00_105)# #### CURR# ## ##  ex. 1000### 10.00## ##

*7)#### #### # ##, ### 1#### ##### ## ### ##### ####

*8)#### #### "### #######." , #### "#### ##" #### ##

*9)### 0#### #### ## ###.





*13-3. ####

*1)ALV# ##

*2)### 0# ### ###### #### ####

*3)### ##### ##

*4)###### ##

*5)#### ### ##### ##  ##### ### ## ##

*6)##### ##(#)# ##

*7)#### ####### ##### ## ## ## ## (1####, 2####..)

*8)## ##### SUM## ####



* TABLES ##




TABLES: ZEDT19_102,

        ZEDT19_103,

        ZEDT19_104,

        ZEDT19_105,

        ZEDT19_106.






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

         ZQFLAG_T  TYPE CHAR4,              "####(##)

         ZGENDER   TYPE ZEDT05_103-ZGENDER,   "##(##)

         ZADDRESS  TYPE ZEDT05_103-ZADDRESS,   "##

         ZBANKCODE TYPE ZEDT05_106-ZBANKCODE, "####

         ZBANKNAME TYPE CHAR20,               "###

         ZACCOUNT TYPE ZEDT05_106-ZACCOUNT,   "####

       END OF TY_EMP_INFO.



" #### ### ###

TYPES: BEGIN OF TY_SALARY,

         ZPERNR   TYPE ZEDT19_102-ZPERNR,    "####

         ZQDATE   TYPE ZEDT19_102-ZQDATE,    "###

         ZQFLAG   TYPE ZEDT19_102-ZQFLAG,    "####

         ZSALARY  TYPE ZEDT19_106-ZSALARY,   "####

         ZPAY_AMT TYPE ZEDT19_106-ZSALARY,    "###

         ZRANK    TYPE ZEDT19_104-ZRANK,     "####

       END OF TY_SALARY.



" #### ### ###

TYPES: BEGIN OF TY_EVAL,

         ZPERNR    TYPE ZEDT19_102-ZPERNR,    "####

         ZPNAME    TYPE ZEDT19_103-ZPNAME,    "####

         ZDEPCODE  TYPE ZEDT19_102-ZDEPCODE,  "####

         ZDEPNAME  TYPE CHAR20,               "###

         ZDEPRANK  TYPE ZEDT19_102-ZDEPRANK,  "####

         ZRANKNAME TYPE CHAR20,               "###

         ZQFLAG    TYPE ZEDT19_102-ZQFLAG,    "####(##/##)

         ZQFLAG_T  TYPE CHAR10,               "##/##

         ZRANK     TYPE ZEDT19_104-ZRANK,     "####

         ZSALARY   TYPE ZEDT19_106-ZSALARY,   "####

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




END-OF-SELECTION.




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

    PERFORM GET_PAYMENT_INFO. " ## ## select#

  ELSEIF P_RAD3 = C_X.  " ####




*    PERFROM GET_EVAL.




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



  PERFORM CONVERT_KOR.

endform.




*&---------------------------------------------------------------------*

*&      Form  CONVERT_KOR

*&---------------------------------------------------------------------*

*       text

*----------------------------------------------------------------------*

*  -->  p1        text

*  <--  p2        text

*----------------------------------------------------------------------*




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






*&---------------------------------------------------------------------*

*&      Form  DISPLAY_ALV_EMP_INFO

*&---------------------------------------------------------------------*

*       text

*----------------------------------------------------------------------*

*  -->  p1        text

*  <--  p2        text

*----------------------------------------------------------------------*




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




*&---------------------------------------------------------------------*

*&      Form  SET_FIELDCAT_EMP_INFO

*&---------------------------------------------------------------------*

*       text

*----------------------------------------------------------------------*

*  -->  p1        text

*  <--  p2        text

*----------------------------------------------------------------------*




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






*&---------------------------------------------------------------------*

*&      Form  SET_SORT_EMP_INFO

*&---------------------------------------------------------------------*

*       SORT ##

*----------------------------------------------------------------------*




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




*&---------------------------------------------------------------------*

*&      Form  GET_PAYMENT_INFO

*&---------------------------------------------------------------------*

*       text

*----------------------------------------------------------------------*

*  -->  p1        text

*  <--  p2        text

*----------------------------------------------------------------------*




form GET_PAYMENT_INFO .



  DATA: LV_LAST_DAY TYPE D,

        LV_PAY_DATE TYPE D,

        LV_SUCCESS  TYPE C,

        LV_ERROR    TYPE C.





  SELECT

    A~ZPERNR, A~ZQDATE, A~ZQFLAG, C~ZSALARY, B~ZRANK

  FROM  ZEDT19_102 AS A

  LEFT OUTER JOIN ZEDT19_104 AS B

  ON

    A~ZPERNR = B~ZPERNR

    AND B~ZYEAR = @P_YEAR

  LEFT OUTER JOIN ZEDT19_106 AS C

  ON

      A~ZPERNR = C~ZPERNR

  WHERE

    A~ZPERNR IN @S_PERNR

  INTO CORRESPONDING FIELDS OF TABLE @GT_SALARY.



    " ## ## ### # ##

  CALL FUNCTION 'RP_LAST_DAY_OF_MONTHS'

    EXPORTING

      DAY_IN            = P_YEAR && P_MONTH && '01'

    IMPORTING

      LAST_DAY_OF_MONTH = LV_LAST_DAY

    EXCEPTIONS

      DAY_IN_NO_DATE    = 1

      OTHERS            = 2.



  IF SY-SUBRC <> 0.

    MESSAGE '# ### #### ####.' TYPE 'E'.

    STOP.

  ENDIF.







  " ### ## (## ## ### #)

  LV_PAY_DATE = LV_LAST_DAY.





  DELETE

    GT_SALARY

  WHERE

    ZQFLAG IS NOT INITIAL

  AND

    ZQDATE <= LV_PAY_DATE

  OR

    ZSALARY = C_ZERO

  OR ZRANK IS INITIAL.

endform.








*Messages

*----------------------------------------------------------

*

* Message class: Hard coded

*   ##### ######.