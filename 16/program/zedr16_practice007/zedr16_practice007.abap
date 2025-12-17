
*&---------------------------------------------------------------------*

*& Report ZEDR16_PRACTICE007

*&---------------------------------------------------------------------*

*&

*&---------------------------------------------------------------------*




REPORT ZEDR16_PRACTICE007.








*0. # #### ## ##

*1. DOMAIN, ELEMENT# #### TABLE##

*2. ZEDR00_PRACTICE006 "######" ######

*3. ## ###### ### ##### ## ### ### ##, ALV### ITAB ## ##

*4. SELECT### JOIN# ### ####, join# ## 4## #### ### ##

*5. ##### 1### ##

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

*

*13-3. ####

*1)ALV# ##

*2)### 0# ### ###### #### ####

*3)### ##### ##

*4)###### ##

*5)#### ### ##### ##  ##### ### ## ##

*6)##### ##(#)# ##

*7)#### ####### ##### ## ## ## ## (1####, 2####..)

*8)## ##### SUM## ####






TABLES: ZEDT16_102.

TABLES: ZEDT16_103.

TABLES: ZEDT16_104.

TABLES: ZEDT16_105.

TABLES: ZEDT16_106.



" 1-1. ## ## ###

DATA : BEGIN OF GS_EMP.

    include structure
ZEDT16_102
.

DATA : END OF GS_EMP.

DATA : GT_EMP LIKE TABLE OF GS_EMP.



" 1-2. ####-####

DATA : BEGIN OF GS_EMP_NAME.

    include structure
ZEDT16_103
.

DATA : END OF GS_EMP_NAME.

DATA : GT_EMP_NAME LIKE TABLE OF GS_EMP_NAME.



" 2. ####

DATA : BEGIN OF GS_EVAL.

    include structure
ZEDT16_104
.

DATA : END OF GS_EVAL.

DATA : GT_EVAL LIKE TABLE OF GS_EVAL.



" 3-1. ####

DATA : BEGIN OF GS_MONTHLY_SALARY.

    include structure
ZEDT16_105
.

DATA : END OF GS_MONTHLY_SALARY.

DATA : GT_MONTHLY_SALARY LIKE TABLE OF GS_MONTHLY_SALARY.



" 3-2. ####

DATA : BEGIN OF GS_ANNUAL_SALARY.

    include structure
ZEDT16_106
.

DATA : END OF GS_ANNUAL_SALARY.

DATA : GT_ANNUAL_SALARY LIKE TABLE OF GS_ANNUAL_SALARY.



" ALV ## ###

"1. ####

" ####(102ZPERNR), ####(103ZPNAME), ####(102ZDEPCODE), ###(102ZDEPCODE), ####(102ZDEPRANK), ###(102ZDEPRANK),

" ###(102ZEDATE), ####(102ZQFLAG), ##(103ZGENDER), ##(103ZADDRESS),

" ####(106ZBANKCODE), ###(106ZBANKCODE), ####(106ZACCOUNT)



DATA : BEGIN OF GS_OUTPUT_EMP,

         ZPERNR       TYPE ZEDT16_102-ZPERNR,

         ZPNAME       TYPE ZEDT16_103-ZPNAME,

         ZDEPCODE     TYPE ZEDT16_102-ZDEPCODE,

         ZDEPNAME     TYPE CHAR20,

         ZDEPRANK     TYPE ZEDT16_102-ZDEPRANK,

         ZDEPRANKNAME TYPE CHAR20,

         ZEDATE       TYPE ZEDT16_102-ZEDATE,

         ZQFLAG       TYPE ZEDT16_102-ZQFLAG,

         ZQFLAGNAME   TYPE CHAR20,

         ZGENDER      TYPE ZEDT16_103-ZGENDER,

         ZGENDERNAME  TYPE CHAR20,

         ZADDRESS     TYPE ZEDT16_103-ZADDRESS,

         ZBANKCODE    TYPE ZEDT16_106-ZBANKCODE,

         ZBANKNAME    TYPE CHAR20,

         ZACCOUNT     TYPE ZEDT16_106-ZACCOUNT,

       END OF GS_OUTPUT_EMP.

DATA : GT_OUTPUT_EMP LIKE TABLE OF GS_OUTPUT_EMP.





" ## ## ## ###

" 2. ####

" ####, ##(105ZYEAR), *###(105ZMON**), ####(102ZQDATE), ##(104ZYEAR), ####(104ZRANK),

" ####(106ZSALARY), ###, ###, ####

DATA : BEGIN OF GS_MODIFY_SALARY,

         ZPERNR  TYPE ZEDT16_102-ZPERNR,

         ZYEAR   TYPE ZEDT16_105-ZYEAR,

         ZMON    TYPE ZEDT16_105-ZMON01,

         ZEDATE  TYPE ZEDT16_102-ZEDATE,

         ZQDATE  TYPE ZEDT16_102-ZQDATE,

         ZRANK   TYPE ZEDT16_104-ZRANK,

         ZSALARY TYPE ZEDT16_106-ZSALARY,

       END OF GS_MODIFY_SALARY.

DATA : GT_MODIFY_SALARY LIKE TABLE OF GS_MODIFY_SALARY.





"3. ####

" ####(102ZPERNR), ####(103ZPNAME), ####(102ZDEPCODE), ###(102ZDEPCODE), ###(102ZDEPRANK),

" ###(102ZEDATE), ####(106ZSALARY), ####(104ZRANK), ##(105ZMON01)



DATA : BEGIN OF GS_OUTPUT_EVAL,

         ZPERNR       TYPE ZEDT16_102-ZPERNR,

         ZPNAME       TYPE ZEDT16_103-ZPNAME,

         ZDEPCODE     TYPE ZEDT16_102-ZDEPCODE,

         ZDEPNAME     TYPE CHAR20,

         ZDEPRANK     TYPE ZEDT16_102-ZDEPRANK,

         ZDEPRANKNAME TYPE CHAR20,

         ZEDATE       TYPE ZEDT16_102-ZEDATE,

         ZQFLAG       TYPE ZEDT16_102-ZQFLAG,

         ZSALARY      TYPE ZEDT16_106-ZSALARY,

         ZRANK        TYPE ZEDT16_104-ZRANK,

         ZMON         TYPE ZEDT16_105-ZMON01,




*         ZMON02       TYPE ZEDT16_105-ZMON02,

*         ZMON03       TYPE ZEDT16_105-ZMON03,

*         ZMON04       TYPE ZEDT16_105-ZMON04,

*         ZMON05       TYPE ZEDT16_105-ZMON05,

*         ZMON06       TYPE ZEDT16_105-ZMON06,

*         ZMON07       TYPE ZEDT16_105-ZMON07,

*         ZMON08       TYPE ZEDT16_105-ZMON08,

*         ZMON09       TYPE ZEDT16_105-ZMON09,

*         ZMON10       TYPE ZEDT16_105-ZMON10,

*         ZMON11       TYPE ZEDT16_105-ZMON11,

*         ZMON12       TYPE ZEDT16_105-ZMON12,




       END OF GS_OUTPUT_EVAL.

DATA : GT_OUTPUT_EVAL LIKE TABLE OF GS_OUTPUT_EVAL.



DATA: GT_FIELDCAT TYPE SLIS_T_FIELDCAT_ALV,

      GS_FIELDCAT TYPE SLIS_FIELDCAT_ALV,

      GT_SORT     TYPE SLIS_T_SORTINFO_ALV,

      GS_SORT     TYPE SLIS_SORTINFO_ALV,

      GS_LAYOUT   TYPE SLIS_LAYOUT_ALV.






* ## ## ### ### ## ##

*DATA: GV_TODAY_DATS  TYPE SY-DATUM,

*      GV_TODAY_MONTH TYPE MONAT,

*      GV_TODAY_YEAR  TYPE GJAHR,

*      GV_DATS        LIKE SY-DATUM,

*      GV_MON_COL     TYPE C LENGTH 6   " ZMON**# ### COLUMN#

*      .








" SELECTION SCREEN



SELECTION-SCREEN BEGIN OF BLOCK B1 WITH FRAME.

SELECT-OPTIONS : S_ZPERNR FOR ZEDT16_102-ZPERNR. " ####

SELECT-OPTIONS : S_ZEDATE FOR ZEDT16_102-ZEDATE MODIF ID M1. " ###

PARAMETERS : P_ZDEP LIKE ZEDT16_102-ZDEPCODE MODIF ID M1. " ####

PARAMETERS : P_YEAR TYPE BKPF-GJAHR DEFAULT SY-DATUM(4) MODIF ID M2. " yyyy

PARAMETERS : P_MONTH TYPE BKPF-MONAT DEFAULT SY-DATUM+4(2) MODIF ID M2. " mm

SELECTION-SCREEN END OF BLOCK B1.



SELECTION-SCREEN BEGIN OF BLOCK B2 WITH FRAME.

PARAMETERS : P_EMP RADIOBUTTON GROUP R1 DEFAULT 'X' USER-COMMAND UC1. " ####

PARAMETERS : P_SALARY RADIOBUTTON GROUP R1. " ####

PARAMETERS : P_EVAL RADIOBUTTON GROUP R1. " ####

SELECTION-SCREEN END OF BLOCK B2.



SELECTION-SCREEN BEGIN OF BLOCK B3 WITH FRAME.

PARAMETERS : P_ACTIVE AS CHECKBOX DEFAULT 'X' MODIF ID M1. " ####

SELECTION-SCREEN END OF BLOCK B3.




*

*DATA : R_ZEDATE TYPE RANGE OF ZEDT16_102-ZEDATE,

*       R_ZPERNR TYPE RANGE OF ZEDT16_102-ZPERNR.



*DATA: GR_ZEDATE LIKE RANGE OF ZEDT16_102-ZEDATE.






CONSTANTS: C_KRW_FACTOR TYPE P DECIMALS 0 VALUE 100.   " ###: DB(##2) # #(##) ##








*gr_range-sign = 'I'.

*gr_range-option = 'BT'.

*gr_range-low = 'SSU-90'.

*gr_range-high = 'SSU-99'.

*APPEND gr_range.






DATA : LV_FIRST TYPE D,

       LV_LAST  TYPE D.



INITIALIZATION.

  PERFORM BUILD_RANGE.





AT SELECTION-SCREEN OUTPUT.



  LOOP AT SCREEN.



    CASE SCREEN-GROUP1.



      WHEN 'M1'. " ###, ####, #### ##

        IF P_EMP = 'X'.

          SCREEN-ACTIVE = '1'.  " #### ## # ##

        ELSE.

          SCREEN-ACTIVE = '0'.  " ###### ##

        ENDIF.



      WHEN 'M2'. " ##, # ##

        IF P_SALARY = 'X' OR P_EVAL = 'X'.

          SCREEN-ACTIVE = '1'.  " ####, #### # ##

        ELSE.

          SCREEN-ACTIVE = '0'.  " ####### ##

        ENDIF.



    ENDCASE.



    MODIFY SCREEN.



  ENDLOOP.



AT SELECTION-SCREEN.



  " ####: ##(LOW/HIGH # #### ##)

  IF P_EMP = 'X'.

    IF S_ZEDATE-LOW IS INITIAL AND S_ZEDATE-HIGH IS INITIAL.

      MESSAGE '##### ######' TYPE 'E'.

    ENDIF.

  ENDIF.



  " ####/####: ##, # # # ##

  IF P_SALARY = 'X' OR P_EVAL = 'X'.

    IF P_YEAR IS INITIAL OR P_MONTH IS INITIAL.

      MESSAGE '##### ######' TYPE 'E'.

    ENDIF.

  ENDIF.



END-OF-SELECTION.







START-OF-SELECTION.



  CASE 'X'.

    WHEN P_EMP.         "#### ## #

      PERFORM GET_EMP_DATA.

      PERFORM DISPLAY_EMP_ALV.

    WHEN P_SALARY.

      PERFORM PAY_SALARY.

    WHEN P_EVAL.

      PERFORM GET_EVAL_DATA.

      PERFORM DISPLAY_EVAL_ALV.

  ENDCASE.




*&---------------------------------------------------------------------*

*&      Form  GET_EMP_DATA

*&---------------------------------------------------------------------*

*       text

*----------------------------------------------------------------------*

*  -->  p1        text

*  <--  p2        text

*----------------------------------------------------------------------*




FORM GET_EMP_DATA .



  " ####(102ZPERNR), ####(103ZPNAME), ####(102ZDEPCODE), ###(102ZDEPCODE), ####(102ZDEPRANK), ###(102ZDEPRANK),

  " ###(102ZEDATE), ####(102ZQFLAG), ##(103ZGENDER), ##(103ZADDRESS),

  " ####(106ZBANKCODE), ###(106ZBANKCODE), ####(106ZACCOUNT)



  " 102 103 106

  REFRESH GT_OUTPUT_EMP.



  SELECT A~ZPERNR

         B~ZPNAME

         A~ZDEPCODE

         A~ZDEPRANK

         A~ZEDATE

         A~ZQFLAG

         B~ZGENDER

         B~ZADDRESS

         C~ZBANKCODE

         C~ZACCOUNT

    INTO CORRESPONDING FIELDS OF TABLE GT_OUTPUT_EMP

    FROM ZEDT16_102 AS A

    INNER JOIN ZEDT16_103 AS B ON A~ZPERNR = B~ZPERNR

    INNER JOIN ZEDT16_106 AS C ON A~ZPERNR = C~ZPERNR

   WHERE A~ZPERNR IN S_ZPERNR

     AND A~ZEDATE IN S_ZEDATE.



  IF SY-SUBRC <> 0.

    MESSAGE '## ### ## ##### ####.' TYPE 'E'.

  ENDIF.



  " name ## ### : #### -> ###, #### -> ###, #### -> ###, ## -> ###, #### -> ###



  LOOP AT GT_OUTPUT_EMP INTO GS_OUTPUT_EMP.



    CASE GS_OUTPUT_EMP-ZDEPCODE.

      WHEN 'SS0001'. GS_OUTPUT_EMP-ZDEPNAME = '###'.

      WHEN 'SS0002'. GS_OUTPUT_EMP-ZDEPNAME = '###'.

      WHEN 'SS0003'. GS_OUTPUT_EMP-ZDEPNAME = '###'.

      WHEN 'SS0004'. GS_OUTPUT_EMP-ZDEPNAME = '###'.

      WHEN 'SS0005'. GS_OUTPUT_EMP-ZDEPNAME = '###'.

      WHEN 'SS0006'. GS_OUTPUT_EMP-ZDEPNAME = '###'.

    ENDCASE.



    CASE GS_OUTPUT_EMP-ZDEPRANK.

      WHEN 'A'. GS_OUTPUT_EMP-ZDEPRANKNAME = '##'.

      WHEN 'B'. GS_OUTPUT_EMP-ZDEPRANKNAME = '##'.

      WHEN 'C'. GS_OUTPUT_EMP-ZDEPRANKNAME = '##'.

      WHEN 'D'. GS_OUTPUT_EMP-ZDEPRANKNAME = '##'.

      WHEN 'E'. GS_OUTPUT_EMP-ZDEPRANKNAME = '##'.

      WHEN 'F'. GS_OUTPUT_EMP-ZDEPRANKNAME = '##'.

      WHEN 'G'. GS_OUTPUT_EMP-ZDEPRANKNAME = '##'.

    ENDCASE.





    IF GS_OUTPUT_EMP-ZQFLAG = 'X'.

      GS_OUTPUT_EMP-ZQFLAGNAME = '##'.

    ELSE.

      GS_OUTPUT_EMP-ZQFLAGNAME = '##'.

    ENDIF.






*    IF P_ACTIVE = 'X' AND GS_OUTPUT_EMP-ZQFLAG = 'X'.

*      CONTINUE. " #### ###

*    ENDIF.






    " ## ##

    CASE GS_OUTPUT_EMP-ZGENDER.

      WHEN 'M'. GS_OUTPUT_EMP-ZGENDERNAME = '##'.

      WHEN 'F'. GS_OUTPUT_EMP-ZGENDERNAME = '##'.

    ENDCASE.



    CASE GS_OUTPUT_EMP-ZBANKCODE.

      WHEN '001'. GS_OUTPUT_EMP-ZBANKNAME = '##'.

      WHEN '002'. GS_OUTPUT_EMP-ZBANKNAME = '##'.

      WHEN '003'. GS_OUTPUT_EMP-ZBANKNAME = '##'.

      WHEN '004'. GS_OUTPUT_EMP-ZBANKNAME = '##'.

      WHEN '005'. GS_OUTPUT_EMP-ZBANKNAME = '###'.

    ENDCASE.







    MODIFY GT_OUTPUT_EMP FROM GS_OUTPUT_EMP.

  ENDLOOP.



  " #### ##

  IF P_ACTIVE = 'X'.

    DELETE GT_OUTPUT_EMP WHERE ZQFLAG = 'X'.

  ENDIF.



  " #### ## # ###

  IF NOT P_ZDEP IS INITIAL.

    DELETE GT_OUTPUT_EMP WHERE ZDEPCODE <> P_ZDEP.

  ENDIF.



ENDFORM.




*&---------------------------------------------------------------------*

*&      Form  BUILD_RANGE

*&---------------------------------------------------------------------*

*       text

*----------------------------------------------------------------------*

*  -->  p1        text

*  <--  p2        text

*----------------------------------------------------------------------*




FORM BUILD_RANGE .

  DATA LV_YEAR TYPE N LENGTH 4.

  LV_YEAR = SY-DATUM(4).



  CONCATENATE LV_YEAR '0101' INTO LV_FIRST.



  CALL FUNCTION 'RP_LAST_DAY_OF_MONTHS'

    EXPORTING

      DAY_IN            = SY-DATUM

    IMPORTING

      LAST_DAY_OF_MONTH = LV_LAST.








*  REFRESH GR_ZEDATE.

*  CLEAR GR_ZEDATE.

*  GR_ZEDATE-SIGN   = 'I'.

*  GR_ZEDATE-OPTION = 'BT'.

*  GR_ZEDATE-LOW    = LV_FIRST.

*  GR_ZEDATE-HIGH   = LV_LAST.

*  APPEND GR_ZEDATE.






  S_ZEDATE-SIGN = 'I'.

  S_ZEDATE-OPTION = 'BT'.

  S_ZEDATE-LOW = LV_FIRST.

  S_ZEDATE-HIGH = LV_LAST.

  APPEND S_ZEDATE.

ENDFORM.




*&---------------------------------------------------------------------*

*&      Form  DISPLAY_EMP_ALV

*&---------------------------------------------------------------------*

*       text

*----------------------------------------------------------------------*

*  -->  p1        text

*  <--  p2        text

*----------------------------------------------------------------------*




FORM DISPLAY_EMP_ALV .

  PERFORM BUILD_FIELDCAT USING 'ZPERNR' '####'.

  PERFORM BUILD_FIELDCAT USING 'ZPNAME' '####'.

  PERFORM BUILD_FIELDCAT USING 'ZDEPCODE' '####'.

  PERFORM BUILD_FIELDCAT USING 'ZDEPNAME' '###'.

  PERFORM BUILD_FIELDCAT USING 'ZDEPRANKNAME' '###'.

  PERFORM BUILD_FIELDCAT USING 'ZEDATE' '###'.

  PERFORM BUILD_FIELDCAT USING 'ZQFLAGNAME' '####'.

  PERFORM BUILD_FIELDCAT USING 'ZGENDERNAME' '##'.

  PERFORM BUILD_FIELDCAT USING 'ZADDRESS' '##'.

  PERFORM BUILD_FIELDCAT USING 'ZBANKCODE' '####'.

  PERFORM BUILD_FIELDCAT USING 'ZBANKNAME' '###'.

  PERFORM BUILD_FIELDCAT USING 'ZACCOUNT' '####'.







  REFRESH GT_SORT.





  CLEAR GS_SORT.

  GS_SORT-FIELDNAME = 'ZPERNR'.    " ##

  GS_SORT-UP        = 'X'.

  APPEND GS_SORT TO GT_SORT.



  CLEAR GS_LAYOUT.

  GS_LAYOUT-ZEBRA = 'X'.

  GS_LAYOUT-COLWIDTH_OPTIMIZE = 'X'.

  GS_LAYOUT-COLTAB_FIELDNAME = 'CELL_COLOR'. " # ## ###



  CALL FUNCTION 'REUSE_ALV_GRID_DISPLAY'

    EXPORTING

      IS_LAYOUT   = GS_LAYOUT

      IT_FIELDCAT = GT_FIELDCAT

      IT_SORT     = GT_SORT

    TABLES

      T_OUTTAB    = GT_OUTPUT_EMP.



ENDFORM.



FORM BUILD_FIELDCAT USING P_FIELD P_TEXT.

  CLEAR GS_FIELDCAT.

  GS_FIELDCAT-FIELDNAME = P_FIELD.

  GS_FIELDCAT-SELTEXT_M = P_TEXT.



  IF P_FIELD = 'ZPERNR' OR P_FIELD = 'ZPNAME'.

    GS_FIELDCAT-EMPHASIZE = 'C600'. " ### ## ##

  ENDIF.



  APPEND GS_FIELDCAT TO GT_FIELDCAT.

ENDFORM.




*&---------------------------------------------------------------------*

*&      Form  PAY_SALARY

*&---------------------------------------------------------------------*

*       text

*----------------------------------------------------------------------*

*  -->  p1        text

*  <--  p2        text

*----------------------------------------------------------------------*




FORM PAY_SALARY .





  CONSTANTS:

    C_BONUS      TYPE P DECIMALS 0 VALUE 50000.  " ## A ###




*    C_SCALE_CURR TYPE P DECIMALS 2 VALUE '100'.  " 1000 # 10.00 ###






  DATA:

    LV_TARGET_YYMM TYPE N LENGTH 6,

    LV_BASE_PAY    TYPE P DECIMALS 0,

    LV_PAY_FINAL   TYPE P DECIMALS 0,

    LV_PAY_CURR    TYPE P DECIMALS 2,

    LV_MONTH       TYPE C LENGTH 2,

    LV_CNT_SUCCESS TYPE I VALUE 0.



  CONCATENATE P_YEAR P_MONTH INTO LV_TARGET_YYMM.



  REFRESH GT_MODIFY_SALARY.






*  DATA : BEGIN OF GS_MODIFY_SALARY,

*         ZPERNR  TYPE ZEDT16_102-ZPERNR,

*         ZYEAR   TYPE ZEDT16_105-ZYEAR,

*         ZMON    TYPE ZEDT16_105-ZMON01,

*         ZQDATE  TYPE ZEDT16_102-ZQDATE,

*         ZRANK   TYPE ZEDT16_104-ZRANK,

*         ZSALARY TYPE ZEDT16_106-ZSALARY,

*       END OF GS_MODIFY_SALARY.

*DATA : GT_MODIFY_SALARY LIKE TABLE OF GS_MODIFY_SALARY.








  " ## ## ## + ## ## JOIN

  SELECT

    A~ZPERNR,

    A~ZEDATE,

    A~ZQDATE,

    D~ZRANK,

    D~ZYEAR,

    C~ZSALARY

    INTO CORRESPONDING FIELDS OF TABLE @GT_MODIFY_SALARY

    FROM ZEDT16_102 AS A

    INNER JOIN ZEDT16_104 AS D

            ON D~ZPERNR = A~ZPERNR

           AND D~ZYEAR  = @P_YEAR

    INNER JOIN ZEDT16_106 AS C

            ON C~ZPERNR = A~ZPERNR

           AND C~ZYEAR  = @P_YEAR

   WHERE A~ZPERNR IN @S_ZPERNR.





  IF SY-SUBRC <> 0 OR GT_MODIFY_SALARY IS INITIAL.

    MESSAGE '## ## ### ####.' TYPE 'E'.

  ENDIF.



  LOOP AT GT_MODIFY_SALARY INTO GS_MODIFY_SALARY.



    " ### ##

    IF GS_MODIFY_SALARY-ZEDATE IS NOT INITIAL

       AND GS_MODIFY_SALARY-ZEDATE(6) > LV_TARGET_YYMM.

      CONTINUE.

    ENDIF.





    " 3. ### ##

    IF GS_MODIFY_SALARY-ZQDATE IS NOT INITIAL

       AND GS_MODIFY_SALARY-ZQDATE(6) <= LV_TARGET_YYMM.

      CONTINUE.

    ENDIF.



    " 5. ### ## (##/12 + A## ###)

    LV_BASE_PAY = GS_MODIFY_SALARY-ZSALARY * C_KRW_FACTOR / 12.

    LV_PAY_FINAL = LV_BASE_PAY.

    IF GS_MODIFY_SALARY-ZRANK = 'A'.

      LV_PAY_FINAL = LV_PAY_FINAL + C_BONUS.

    ENDIF.



    IF LV_PAY_FINAL = 0.

      CONTINUE.

    ENDIF.



    LV_PAY_CURR = LV_PAY_FINAL / C_KRW_FACTOR.






*    CASE P_MONTH.

*      WHEN '01'.

*        UPDATE ZEDT16_105

*           SET ZMON01 = @LV_PAY_CURR,

*               AEDATE  = @SY-DATUM,

*               AENAME  = @SY-UNAME,

*               AEZEIT  = @SY-UZEIT

*         WHERE ZPERNR = @GS_MODIFY_SALARY-ZPERNR

*           AND ZYEAR  = @P_YEAR.

*

*      WHEN '02'.

*        UPDATE ZEDT16_105

*           SET ZMON02 = @LV_PAY_CURR,

*               AEDATE  = @SY-DATUM,

*               AENAME  = @SY-UNAME,

*               AEZEIT  = @SY-UZEIT

*         WHERE ZPERNR = @GS_MODIFY_SALARY-ZPERNR

*           AND ZYEAR  = @P_YEAR.

*

*      WHEN '03'.

*        UPDATE ZEDT16_105

*           SET ZMON03 = @LV_PAY_CURR,

*               AEDATE  = @SY-DATUM,

*               AENAME  = @SY-UNAME,

*               AEZEIT  = @SY-UZEIT

*         WHERE ZPERNR = @GS_MODIFY_SALARY-ZPERNR

*           AND ZYEAR  = @P_YEAR.

*

*      WHEN '04'.

*        UPDATE ZEDT16_105

*           SET ZMON04 = @LV_PAY_CURR,

*               AEDATE  = @SY-DATUM,

*               AENAME  = @SY-UNAME,

*               AEZEIT  = @SY-UZEIT

*         WHERE ZPERNR = @GS_MODIFY_SALARY-ZPERNR

*           AND ZYEAR  = @P_YEAR.

*

*      WHEN '05'.

*        UPDATE ZEDT16_105

*           SET ZMON05 = @LV_PAY_CURR,

*               AEDATE  = @SY-DATUM,

*               AENAME  = @SY-UNAME,

*               AEZEIT  = @SY-UZEIT

*         WHERE ZPERNR = @GS_MODIFY_SALARY-ZPERNR

*           AND ZYEAR  = @P_YEAR.

*

*      WHEN '06'.

*        UPDATE ZEDT16_105

*           SET ZMON06 = @LV_PAY_CURR,

*               AEDATE  = @SY-DATUM,

*               AENAME  = @SY-UNAME,

*               AEZEIT  = @SY-UZEIT

*         WHERE ZPERNR = @GS_MODIFY_SALARY-ZPERNR

*           AND ZYEAR  = @P_YEAR.

*

*      WHEN '07'.

*        UPDATE ZEDT16_105

*           SET ZMON07 = @LV_PAY_CURR,

*               AEDATE  = @SY-DATUM,

*               AENAME  = @SY-UNAME,

*               AEZEIT  = @SY-UZEIT

*         WHERE ZPERNR = @GS_MODIFY_SALARY-ZPERNR

*           AND ZYEAR  = @P_YEAR.

*

*      WHEN '08'.

*        UPDATE ZEDT16_105

*           SET ZMON08 = @LV_PAY_CURR,

*               AEDATE  = @SY-DATUM,

*               AENAME  = @SY-UNAME,

*               AEZEIT  = @SY-UZEIT

*         WHERE ZPERNR = @GS_MODIFY_SALARY-ZPERNR

*           AND ZYEAR  = @P_YEAR.

*

*      WHEN '09'.

*        UPDATE ZEDT16_105

*           SET ZMON09 = @LV_PAY_CURR,

*               AEDATE  = @SY-DATUM,

*               AENAME  = @SY-UNAME,

*               AEZEIT  = @SY-UZEIT

*         WHERE ZPERNR = @GS_MODIFY_SALARY-ZPERNR

*           AND ZYEAR  = @P_YEAR.

*

*      WHEN '10'.

*        UPDATE ZEDT16_105

*           SET ZMON10 = @LV_PAY_CURR,

*               AEDATE  = @SY-DATUM,

*               AENAME  = @SY-UNAME,

*               AEZEIT  = @SY-UZEIT

*         WHERE ZPERNR = @GS_MODIFY_SALARY-ZPERNR

*           AND ZYEAR  = @P_YEAR.

*

*      WHEN '11'.

*        UPDATE ZEDT16_105

*           SET ZMON11 = @LV_PAY_CURR,

*               AEDATE  = @SY-DATUM,

*               AENAME  = @SY-UNAME,

*               AEZEIT  = @SY-UZEIT

*         WHERE ZPERNR = @GS_MODIFY_SALARY-ZPERNR

*           AND ZYEAR  = @P_YEAR.

*

*      WHEN '12'.

*        UPDATE ZEDT16_105

*           SET ZMON12 = @LV_PAY_CURR,

*               AEDATE  = @SY-DATUM,

*               AENAME  = @SY-UNAME,

*               AEZEIT  = @SY-UZEIT

*         WHERE ZPERNR = @GS_MODIFY_SALARY-ZPERNR

*           AND ZYEAR  = @P_YEAR.

*

*      WHEN OTHERS.

*        MESSAGE '### ####.' TYPE 'E'.

*    ENDCASE.

*

*    IF SY-SUBRC <> 0.

*      MESSAGE '#### ##' TYPE 'E'.

*      LEAVE PROGRAM.

*    ENDIF.

*

*    LV_CNT_SUCCESS = LV_CNT_SUCCESS + 1.






    DATA: LS_105  TYPE ZEDT16_105,

          LV_FMON TYPE C LENGTH 6.

    FIELD-SYMBOLS: <FS_MON> TYPE ANY.



    " 1) ## ##/## ### ## (## # # ## ##)

    SELECT SINGLE *

   INTO @LS_105

   FROM ZEDT16_105

  WHERE ZPERNR = @GS_MODIFY_SALARY-ZPERNR

    AND ZYEAR  = @P_YEAR.



    IF SY-SUBRC <> 0.

      MESSAGE '## ##/## ## ####.' TYPE 'E'.

      LEAVE PROGRAM.

    ENDIF.



    " 2) # ### ###: 'ZMON' + '01'..'12'

    CLEAR LV_FMON.

    CONCATENATE 'ZMON' P_MONTH INTO LV_FMON.



    " 3) ## # ### ##### ####

    ASSIGN COMPONENT LV_FMON OF STRUCTURE LS_105 TO <FS_MON>.

    IF <FS_MON> IS NOT ASSIGNED.

      MESSAGE '### # ####.' TYPE 'E'.

      LEAVE PROGRAM.

    ENDIF.





    " 4) UPDATE: ## ## # ## + ## ## ##

    <FS_MON>       = LV_PAY_CURR.

    LS_105-AEDATE  = SY-DATUM.

    LS_105-AENAME  = SY-UNAME.

    LS_105-AEZEIT  = SY-UZEIT.



    " 5) DB ##

    UPDATE ZEDT16_105 FROM @LS_105.

    IF SY-SUBRC <> 0.

      MESSAGE '#### ##' TYPE 'E'.

      LEAVE PROGRAM.

    ENDIF.



    LV_CNT_SUCCESS = LV_CNT_SUCCESS + 1.



  ENDLOOP.



  IF LV_CNT_SUCCESS > 0.

    MESSAGE '### #######.' TYPE 'S'.

  ELSE.

    MESSAGE '### ### ####.' TYPE 'I'.

  ENDIF.







ENDFORM.




*&---------------------------------------------------------------------*

*&      Form  GET_EVAL_DATA

*&---------------------------------------------------------------------*

*       text

*----------------------------------------------------------------------*

*  -->  p1        text

*  <--  p2        text

*----------------------------------------------------------------------*




FORM GET_EVAL_DATA .






*  REFRESH GT_OUTPUT_EVAL.

*

*  SELECT

*    A~ZPERNR,

*    B~ZPNAME,

*    A~ZDEPCODE,

*    A~ZDEPRANK,

*    A~ZEDATE,

*    A~ZQFLAG,

*    D~ZRANK,

*    C~ZSALARY,

*    CASE @P_MONTH

*      WHEN '01' THEN E~ZMON01

*      WHEN '02' THEN E~ZMON02

*      WHEN '03' THEN E~ZMON03

*      WHEN '04' THEN E~ZMON04

*      WHEN '05' THEN E~ZMON05

*      WHEN '06' THEN E~ZMON06

*      WHEN '07' THEN E~ZMON07

*      WHEN '08' THEN E~ZMON08

*      WHEN '09' THEN E~ZMON09

*      WHEN '10' THEN E~ZMON10

*      WHEN '11' THEN E~ZMON11

*      WHEN '12' THEN E~ZMON12

*    END AS ZMON

*    INTO CORRESPONDING FIELDS OF TABLE @GT_OUTPUT_EVAL

*    FROM ZEDT16_102 AS A

*    INNER JOIN ZEDT16_103 AS B ON B~ZPERNR = A~ZPERNR

*    INNER JOIN ZEDT16_104 AS D ON D~ZPERNR = A~ZPERNR AND D~ZYEAR = @P_YEAR

*    LEFT  JOIN  ZEDT16_105 AS E ON E~ZPERNR = A~ZPERNR AND E~ZYEAR = @P_YEAR

*    LEFT  JOIN  ZEDT16_106 AS C ON C~ZPERNR = A~ZPERNR

*   WHERE A~ZPERNR IN @S_ZPERNR.

*

*  IF SY-SUBRC <> 0 OR GT_OUTPUT_EVAL IS INITIAL.

*    MESSAGE '#### #### ####.' TYPE 'E'.

*  ENDIF.

*

*  " ##: ##/### ## + KRW ### ##(100)

*  LOOP AT GT_OUTPUT_EVAL INTO GS_OUTPUT_EVAL.

*

*    " ###

*    CASE GS_OUTPUT_EVAL-ZDEPCODE.

*      WHEN 'SS0001'. GS_OUTPUT_EVAL-ZDEPNAME = '###'.

*      WHEN 'SS0002'. GS_OUTPUT_EVAL-ZDEPNAME = '###'.

*      WHEN 'SS0003'. GS_OUTPUT_EVAL-ZDEPNAME = '###'.

*      WHEN 'SS0004'. GS_OUTPUT_EVAL-ZDEPNAME = '###'.

*      WHEN 'SS0005'. GS_OUTPUT_EVAL-ZDEPNAME = '###'.

*      WHEN 'SS0006'. GS_OUTPUT_EVAL-ZDEPNAME = '###'.

*    ENDCASE.

*

*    " ###

*    CASE GS_OUTPUT_EVAL-ZDEPRANK.

*      WHEN 'A'. GS_OUTPUT_EVAL-ZDEPRANKNAME = '##'.

*      WHEN 'B'. GS_OUTPUT_EVAL-ZDEPRANKNAME = '##'.

*      WHEN 'C'. GS_OUTPUT_EVAL-ZDEPRANKNAME = '##'.

*      WHEN 'D'. GS_OUTPUT_EVAL-ZDEPRANKNAME = '##'.

*      WHEN 'E'. GS_OUTPUT_EVAL-ZDEPRANKNAME = '##'.

*      WHEN 'F'. GS_OUTPUT_EVAL-ZDEPRANKNAME = '##'.

*      WHEN 'G'. GS_OUTPUT_EVAL-ZDEPRANKNAME = '##'.

*    ENDCASE.

*

*    " ## ###: DB# ##2(CURR)## ### # ### ### 100

*    IF GS_OUTPUT_EVAL-ZSALARY IS NOT INITIAL.

*      GS_OUTPUT_EVAL-ZSALARY = GS_OUTPUT_EVAL-ZSALARY * C_KRW_FACTOR.

*    ENDIF.

*    IF GS_OUTPUT_EVAL-ZMON IS NOT INITIAL.

*      GS_OUTPUT_EVAL-ZMON    = GS_OUTPUT_EVAL-ZMON    * C_KRW_FACTOR.

*    ENDIF.

*

*    MODIFY GT_OUTPUT_EVAL FROM GS_OUTPUT_EVAL.

*  ENDLOOP.

*

*  " 0# ##(####)

*  DELETE GT_OUTPUT_EVAL WHERE ZMON = 0.






  REFRESH GT_OUTPUT_EVAL.





  SELECT

    A~ZPERNR,

    B~ZPNAME,

    A~ZDEPCODE,

    A~ZDEPRANK,

    A~ZEDATE,

    A~ZQFLAG,

    D~ZRANK,

    C~ZSALARY

    INTO CORRESPONDING FIELDS OF TABLE @GT_OUTPUT_EVAL

    FROM ZEDT16_102 AS A

    INNER JOIN ZEDT16_103 AS B ON B~ZPERNR = A~ZPERNR

    INNER JOIN ZEDT16_104 AS D ON D~ZPERNR = A~ZPERNR AND D~ZYEAR = @P_YEAR

    LEFT  JOIN  ZEDT16_106 AS C ON C~ZPERNR = A~ZPERNR AND C~ZYEAR = @P_YEAR

   WHERE A~ZPERNR IN @S_ZPERNR.



  IF SY-SUBRC <> 0 OR GT_OUTPUT_EVAL IS INITIAL.

    MESSAGE '#### #### ####.' TYPE 'E'.

  ENDIF.





  DATA: LS_105  TYPE ZEDT16_105,

        LV_FMON TYPE C LENGTH 6.

  FIELD-SYMBOLS: <FS_MON> TYPE ANY.



  LOOP AT GT_OUTPUT_EVAL INTO GS_OUTPUT_EVAL.





    CLEAR LS_105.

    SELECT SINGLE *

      INTO @LS_105

      FROM ZEDT16_105

     WHERE ZPERNR = @GS_OUTPUT_EVAL-ZPERNR

       AND ZYEAR  = @P_YEAR.



    IF SY-SUBRC = 0.

      CLEAR LV_FMON.

      CONCATENATE 'ZMON' P_MONTH INTO LV_FMON.

      ASSIGN COMPONENT LV_FMON OF STRUCTURE LS_105 TO <FS_MON>.

      IF <FS_MON> IS ASSIGNED.

        GS_OUTPUT_EVAL-ZMON = <FS_MON>.

      ENDIF.

    ENDIF.



    " 3) ##/### ##

    CASE GS_OUTPUT_EVAL-ZDEPCODE.

      WHEN 'SS0001'. GS_OUTPUT_EVAL-ZDEPNAME = '###'.

      WHEN 'SS0002'. GS_OUTPUT_EVAL-ZDEPNAME = '###'.

      WHEN 'SS0003'. GS_OUTPUT_EVAL-ZDEPNAME = '###'.

      WHEN 'SS0004'. GS_OUTPUT_EVAL-ZDEPNAME = '###'.

      WHEN 'SS0005'. GS_OUTPUT_EVAL-ZDEPNAME = '###'.

      WHEN 'SS0006'. GS_OUTPUT_EVAL-ZDEPNAME = '###'.

    ENDCASE.



    CASE GS_OUTPUT_EVAL-ZDEPRANK.

      WHEN 'A'. GS_OUTPUT_EVAL-ZDEPRANKNAME = '##'.

      WHEN 'B'. GS_OUTPUT_EVAL-ZDEPRANKNAME = '##'.

      WHEN 'C'. GS_OUTPUT_EVAL-ZDEPRANKNAME = '##'.

      WHEN 'D'. GS_OUTPUT_EVAL-ZDEPRANKNAME = '##'.

      WHEN 'E'. GS_OUTPUT_EVAL-ZDEPRANKNAME = '##'.

      WHEN 'F'. GS_OUTPUT_EVAL-ZDEPRANKNAME = '##'.

      WHEN 'G'. GS_OUTPUT_EVAL-ZDEPRANKNAME = '##'.

    ENDCASE.





    IF GS_OUTPUT_EVAL-ZSALARY IS NOT INITIAL.

      GS_OUTPUT_EVAL-ZSALARY = GS_OUTPUT_EVAL-ZSALARY * C_KRW_FACTOR.

    ENDIF.

    IF GS_OUTPUT_EVAL-ZMON IS NOT INITIAL.

      GS_OUTPUT_EVAL-ZMON    = GS_OUTPUT_EVAL-ZMON    * C_KRW_FACTOR.

    ENDIF.



    MODIFY GT_OUTPUT_EVAL FROM GS_OUTPUT_EVAL.

  ENDLOOP.



  " 0# ##

  DELETE GT_OUTPUT_EVAL WHERE ZMON = 0.





ENDFORM.




*&---------------------------------------------------------------------*

*&      Form  DISPLAY_EVAL_ALV

*&---------------------------------------------------------------------*

*       text

*----------------------------------------------------------------------*

*  -->  p1        text

*  <--  p2        text

*----------------------------------------------------------------------*




FORM DISPLAY_EVAL_ALV .



  DATA LV_TEXT TYPE CHAR20.



  REFRESH GT_FIELDCAT.

  REFRESH GT_SORT.



  " ## ### ###### ##

  PERFORM BUILD_FIELDCAT USING 'ZPERNR'       '####'.

  PERFORM BUILD_FIELDCAT USING 'ZPNAME'       '####'.

  PERFORM BUILD_FIELDCAT USING 'ZDEPCODE'     '####'.

  PERFORM BUILD_FIELDCAT USING 'ZDEPNAME'     '###'.

  PERFORM BUILD_FIELDCAT USING 'ZDEPRANKNAME' '###'.

  PERFORM BUILD_FIELDCAT USING 'ZEDATE'       '###'.

  PERFORM BUILD_FIELDCAT USING 'ZSALARY'      '####'.

  PERFORM BUILD_FIELDCAT USING 'ZRANK'        '####'.



  CONCATENATE P_MONTH '####' INTO LV_TEXT.

  PERFORM BUILD_FIELDCAT USING 'ZMON'         LV_TEXT.



  " sort

  CLEAR GS_SORT.

  GS_SORT-FIELDNAME = 'ZPERNR'.    " ##

  GS_SORT-UP        = 'X'.

  APPEND GS_SORT TO GT_SORT.



  " ####

  CLEAR GS_LAYOUT.

  GS_LAYOUT-ZEBRA             = 'X'.

  GS_LAYOUT-COLWIDTH_OPTIMIZE = 'X'.



  " ##/####: ####, ####  (## ## ## ###)

  LOOP AT GT_FIELDCAT INTO GS_FIELDCAT.

    IF GS_FIELDCAT-FIELDNAME = 'ZSALARY'

    OR GS_FIELDCAT-FIELDNAME = 'ZMON'.

      GS_FIELDCAT-DO_SUM       = 'X'.

      GS_FIELDCAT-DECIMALS_OUT = 0.   " .00 ##

      MODIFY GT_FIELDCAT FROM GS_FIELDCAT INDEX SY-TABIX.

    ENDIF.

  ENDLOOP.



  " ###: ##/##

  LOOP AT GT_FIELDCAT INTO GS_FIELDCAT.

    IF GS_FIELDCAT-FIELDNAME = 'ZPERNR'

    OR GS_FIELDCAT-FIELDNAME = 'ZPNAME'.

      GS_FIELDCAT-EMPHASIZE = 'C600'.

      MODIFY GT_FIELDCAT FROM GS_FIELDCAT INDEX SY-TABIX.

    ENDIF.

  ENDLOOP.



  CALL FUNCTION 'REUSE_ALV_GRID_DISPLAY'

    EXPORTING

      IS_LAYOUT   = GS_LAYOUT

      IT_FIELDCAT = GT_FIELDCAT

      IT_SORT     = GT_SORT

    TABLES

      T_OUTTAB    = GT_OUTPUT_EVAL.





ENDFORM.








*Messages

*----------------------------------------------------------

*

* Message class: Hard coded

*   ##### ######