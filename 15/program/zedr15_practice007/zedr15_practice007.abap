
*&---------------------------------------------------------------------*

*& Report ZEDR15_PRACTICE007

*&---------------------------------------------------------------------*

*&

*&---------------------------------------------------------------------*




REPORT ZEDR15_PRACTICE007 MESSAGE-ID ZMED15. "### #### ##### ##








*TABLES ##




TABLES : ZEDT15_102,

        ZEDT15_103,

        ZEDT15_104,

        ZEDT15_105,

        ZEDT15_106.






*####




CONSTANTS : C_X VALUE 'X'.






*####




DATA : GV_SUBRC TYPE I. "update ## ## ## (CHANGING# ##)






*RANGE## ##




RANGES : GR_ZFG FOR ZEDT15_102-ZQFLAG. "#### ### ##






*ALV ## DATA ##




DATA : GS_FIELDCAT TYPE SLIS_FIELDCAT_ALV.

DATA : GT_FIELDCAT TYPE SLIS_T_FIELDCAT_ALV.

DATA : GS_LAYOUT TYPE SLIS_LAYOUT_ALV.

DATA : GS_SORT TYPE SLIS_SORTINFO_ALV.

DATA : GT_SORT TYPE SLIS_T_SORTINFO_ALV.






*### ###### ##(#### ##)

*#### ### / ###




DATA : BEGIN OF GS_EMP,

         ZPERNR      TYPE ZEDT15_102-ZPERNR,    "####

         ZPNAME      TYPE ZEDT15_103-ZPNAME,    "####

         ZDEPCODE    TYPE ZEDT15_102-ZDEPCODE,  "####

         ZDEPCODE_T  TYPE C LENGTH 20,          "###

         ZDEPRANK    TYPE ZEDT15_102-ZDEPRANK,  "#### -##x

         ZDEPRANK_T  TYPE C LENGTH 20,          "###

         ZEDATE      TYPE ZEDT15_102-ZEDATE,    "###

         ZQDATE      TYPE ZEDT15_102-ZQDATE,    "### -##x

         ZQFLAG      TYPE ZEDT15_102-ZQFLAG,    "####(##/##) -##x

         ZQFLAG_T    TYPE C LENGTH 4,           "####(##)

         ZGENDER     TYPE ZEDT15_103-ZGENDER,   "## -##x

         ZGENDER_T   TYPE C LENGTH 2,           "##(##)

         ZADDRESS    TYPE ZEDT15_103-ZADDRESS,  "##

         ZBANKCODE   TYPE ZEDT15_106-ZBANKCODE, "####

         ZBANKCODE_T TYPE C LENGTH 20,          "###

         ZACCOUNT    TYPE ZEDT15_106-ZACCOUNT,  "####

       END OF GS_EMP.

DATA : GT_EMP LIKE TABLE OF GS_EMP.



DATA : BEGIN OF GS_EMP_OUT,

         ZPERNR      TYPE ZEDT15_102-ZPERNR,    "####

         ZPNAME      TYPE ZEDT15_103-ZPNAME,    "####

         ZDEPCODE    TYPE ZEDT15_102-ZDEPCODE,  "####

         ZDEPCODE_T  TYPE C LENGTH 20,          "###

         ZDEPRANK_T  TYPE C LENGTH 20,          "###

         ZEDATE      TYPE ZEDT15_102-ZEDATE,    "###

         ZQFLAG_T    TYPE C LENGTH 4,           "####(##)

         ZGENDER_T   TYPE C LENGTH 2,           "##(##)

         ZADDRESS    TYPE ZEDT15_103-ZADDRESS,  "##

         ZBANKCODE   TYPE ZEDT15_106-ZBANKCODE, "####

         ZBANKCODE_T TYPE C LENGTH 20,          "###

         ZACCOUNT    TYPE ZEDT15_106-ZACCOUNT,  "####

       END OF GS_EMP_OUT.

DATA : GT_EMP_OUT LIKE TABLE OF GS_EMP_OUT.






*#### ### / #####




DATA: BEGIN OF GS_SAL,

         ZPERNR      TYPE ZEDT15_102-ZPERNR,    "####

         ZPNAME      TYPE ZEDT15_103-ZPNAME,    "####

         ZDEPCODE    TYPE ZEDT15_102-ZDEPCODE,  "####

         ZDEPCODE_T  TYPE C LENGTH 20,          "###

         ZDEPRANK    TYPE ZEDT15_102-ZDEPRANK,  "#### -##x

         ZDEPRANK_T  TYPE C LENGTH 20,          "###

         ZEDATE      TYPE ZEDT15_102-ZEDATE,    "###

         DATAB       TYPE ZEDT15_102-DATAB,     "###

         ZSALARY     TYPE ZEDT15_106-ZSALARY,   "####

         ZYEAR       TYPE ZEDT15_106-ZYEAR,     "##

         ZRANK       TYPE ZEDT15_104-ZRANK,     "####

         ZSAL_MONTH  TYPE ZEDT15_106-ZSALARY,   "## ###

       END OF GS_SAL.

DATA : GT_SAL LIKE TABLE OF GS_SAL.



DATA: BEGIN OF GS_SAL_OUT.

  include structure
ZEDT15_105
.

DATA : END OF GS_SAL_OUT.

DATA : GT_SAL_OUT LIKE TABLE OF GS_SAL_OUT.






*#### ##




DATA : BEGIN OF GS_EVAL,

         ZPERNR      TYPE ZEDT15_102-ZPERNR,    "####

         ZPNAME      TYPE ZEDT15_103-ZPNAME,    "####

         ZDEPCODE    TYPE ZEDT15_102-ZDEPCODE,  "####

         ZDEPCODE_T  TYPE C LENGTH 20,          "###

         ZDEPRANK_T  TYPE C LENGTH 20,          "###

         ZEDATE      TYPE ZEDT15_102-ZEDATE,    "###

         ZSALARY     TYPE ZEDT15_106-ZSALARY,   "####

         ZRANK       TYPE ZEDT15_104-ZRANK,     "####

         ZSAL_MONTH  TYPE ZEDT15_106-ZSALARY,   "## ###

       END OF GS_EVAL.

DATA : GT_EVAL LIKE TABLE OF GS_EVAL.






*SELECTION SCREEN ###




SELECTION-SCREEN BEGIN OF BLOCK B1 WITH FRAME.




*for# like# ##

*for - data element## (select-options# for ##)

*like - ###/#### ## ## (parameters# like ##)




  "####(####/####/#### ##)

  SELECT-OPTIONS : S_ZPERNR FOR ZEDT15_102-ZPERNR MODIF ID ALL.

  "##/##(####)

  SELECT-OPTIONS : S_DATE FOR ZEDT15_102-DATBI MODIF ID M1.

  SELECT-OPTIONS : S_DEPT FOR ZEDT15_102-ZDEPCODE NO INTERVALS NO-EXTENSION MODIF ID M1.

  "#/# (####/####)

  PARAMETERS : P_YEAR TYPE BKPF-GJAHR DEFAULT SY-DATUM(4) MODIF ID M2. "### ## ##

  PARAMETERS : P_MONTH TYPE BKPF-MONAT DEFAULT SY-DATUM+4(2) MODIF ID M2. "### # ##

SELECTION-SCREEN END OF BLOCK B1.



SELECTION-SCREEN BEGIN OF BLOCK B2 WITH FRAME.

  PARAMETERS : P_R1 RADIOBUTTON GROUP R1 DEFAULT 'X' USER-COMMAND UC1. "####

  PARAMETERS : P_R2 RADIOBUTTON GROUP R1. "####

  PARAMETERS : P_R3 RADIOBUTTON GROUP R1. "####

SELECTION-SCREEN END OF BLOCK B2.



SELECTION-SCREEN BEGIN OF BLOCK B3 WITH FRAME.

  "#### (####)

  PARAMETERS : P_CH1 AS CHECKBOX DEFAULT 'X' MODIF ID M1.

SELECTION-SCREEN END OF BLOCK B3.



INITIALIZATION.




*#### ## ##




S_DATE-SIGN = 'I'.

S_DATE-OPTION = 'BT'.

S_DATE-LOW = SY-DATUM(4) && '0101'.

CALL FUNCTION 'RP_LAST_DAY_OF_MONTHS'

  EXPORTING

    DAY_IN = SY-DATUM

  IMPORTING

    LAST_DAY_OF_MONTH = S_DATE-HIGH.

APPEND S_DATE.



AT SELECTION-SCREEN.




*## ## ### ##### ##




IF S_DATE-LOW IS INITIAL OR S_DATE-HIGH IS INITIAL.

  MESSAGE E000.

ENDIF.



IF P_YEAR IS INITIAL.

  MESSAGE E000.

ENDIF.



IF P_MONTH IS INITIAL.

  MESSAGE E000.

ENDIF.



AT SELECTION-SCREEN OUTPUT.




*SELECTION SCREEN ##




LOOP AT SCREEN.

  CASE SCREEN-GROUP1.

    WHEN 'ALL'. "### ##

      SCREEN-ACTIVE = 1.

    WHEN 'M1'. "#### ## ##

      IF P_R1 = C_X.

        SCREEN-ACTIVE = 1.

      ELSE.

        SCREEN-ACTIVE = 0.

      ENDIF.

    WHEN 'M2'. "####/##### ##

      IF P_R2 = C_X OR P_R3 = C_X.

        SCREEN-ACTIVE = 1.

      ELSE.

        SCREEN-ACTIVE = 0.

      ENDIF.

  ENDCASE.

  MODIFY SCREEN.

ENDLOOP.



START-OF-SELECTION.




*  ###### ## ##




  IF P_R1 = C_X. "####

    PERFORM RANGES_CONTROL.

    PERFORM GET_EMP.

    PERFORM MODIFY_EMP USING GT_EMP.

    PERFORM DISPLAY_EMP.

  ELSEIF P_R2 = C_X. "####

    PERFORM GET_SAL.

    PERFORM UPDATE_SAL CHANGING GV_SUBRC.

  ELSEIF P_R3 = C_X. "####

    PERFORM GET_SAL.

    PERFORM MODIFY_EVAL USING GT_SAL.

    PERFORM DISPLAY_EVAL.

  ENDIF.




*&---------------------------------------------------------------------*

*&      Form  RANGES_CONTROL

*&---------------------------------------------------------------------*

*       ###### #### ### ## ## ##

*----------------------------------------------------------------------*

*  -->  p1        text

*  <--  p2        text

*----------------------------------------------------------------------*




FORM RANGES_CONTROL .




*  RANGES_CONTROL #### ### ## ##




  GR_ZFG-SIGN = 'I'.

  GR_ZFG-OPTION = 'EQ'.

  GR_ZFG-LOW = ''.

  APPEND GR_ZFG.



  IF P_CH1 = C_X.

    GR_ZFG-LOW = C_X.

  ENDIF.

  APPEND GR_ZFG.



ENDFORM.




*&---------------------------------------------------------------------*

*&      Form  GET_EMP

*&---------------------------------------------------------------------*

*       ### ## ## SELECT

*----------------------------------------------------------------------*

*  -->  p1        text

*  <--  p2        text

*----------------------------------------------------------------------*




FORM GET_EMP .




*  GET_EMP




  SELECT

    T1~ZPERNR, "####

    T2~ZPNAME, "####

    T1~ZDEPCODE, "####

    T1~ZDEPRANK, "##

    T1~ZEDATE, "###

    T1~ZQDATE, "###

    T1~ZQFLAG, "####

    T2~ZGENDER, "##

    T2~ZADDRESS, "##

    T3~ZBANKCODE, "####

    T3~ZACCOUNT "####

  FROM ZEDT15_102 AS T1

  INNER JOIN ZEDT15_103 AS T2

  ON T1~ZPERNR = T2~ZPERNR

  INNER JOIN ZEDT15_106 AS T3

  ON T1~ZPERNR = T3~ZPERNR

  INTO CORRESPONDING FIELDS OF TABLE @GT_EMP

  WHERE T1~ZEDATE IN @S_DATE "#### ## ## ###

  AND T1~ZQDATE NOT IN @S_DATE "#### ## ## ## ###

  AND T1~ZDEPCODE IN @S_DEPT "#### ##

  AND T1~ZPERNR IN @S_ZPERNR "#### ##

  AND T1~ZQFLAG IN @GR_ZFG."##### ## ##



  IF GT_EMP IS INITIAL.

      MESSAGE E001. "### #### ### ####

      STOP.

  ENDIF.

ENDFORM.




*&---------------------------------------------------------------------*

*&      Form  MODIFY_EMP

*&---------------------------------------------------------------------*

*       #### ### MODIFY (### ###### ## ## APPEND)

*----------------------------------------------------------------------*

*  -->  p1        text

*  <--  p2        text

*----------------------------------------------------------------------*




FORM MODIFY_EMP USING GT_EMP LIKE GT_EMP.




* MODIFY_EMP




  LOOP AT GT_EMP INTO GS_EMP.

    MOVE-CORRESPONDING GS_EMP TO GS_EMP_OUT.



     CASE: GS_EMP-ZDEPCODE. "###

        WHEN 'SS0001'. GS_EMP_OUT-ZDEPCODE_T = '###'.

        WHEN 'SS0002'. GS_EMP_OUT-ZDEPCODE_T = '###'.

        WHEN 'SS0003'. GS_EMP_OUT-ZDEPCODE_T = '###'.

        WHEN 'SS0004'. GS_EMP_OUT-ZDEPCODE_T = '###'.

        WHEN 'SS0005'. GS_EMP_OUT-ZDEPCODE_T = '###'.

        WHEN 'SS0006'. GS_EMP_OUT-ZDEPCODE_T = '###'.

      ENDCASE.



      CASE: GS_EMP-ZDEPRANK. "###

        WHEN 'A'. GS_EMP_OUT-ZDEPRANK_T = '##'.

        WHEN 'B'. GS_EMP_OUT-ZDEPRANK_T = '##'.

        WHEN 'C'. GS_EMP_OUT-ZDEPRANK_T = '##'.

        WHEN 'D'. GS_EMP_OUT-ZDEPRANK_T = '##'.

        WHEN 'E'. GS_EMP_OUT-ZDEPRANK_T = '##'.

        WHEN 'F'. GS_EMP_OUT-ZDEPRANK_T = '##'.

        WHEN 'G'. GS_EMP_OUT-ZDEPRANK_T = '##'.

      ENDCASE.





      CASE: GS_EMP-ZQFLAG. "####

        WHEN 'X'. GS_EMP_OUT-ZQFLAG_T = '##'.

        WHEN OTHERS. GS_EMP_OUT-ZQFLAG_T = '##'.

      ENDCASE.



      CASE : GS_EMP-ZGENDER. "##

        WHEN 'M'. GS_EMP_OUT-ZGENDER_T = '##'.

        WHEN 'F'. GS_EMP_OUT-ZGENDER_T = '##'.

      ENDCASE.



      CASE : GS_EMP-ZBANKCODE. "###

        WHEN '001'. GS_EMP_OUT-ZBANKCODE_T = '##'.

        WHEN '002'. GS_EMP_OUT-ZBANKCODE_T = '##'.

        WHEN '003'. GS_EMP_OUT-ZBANKCODE_T = '##'.

        WHEN '004'. GS_EMP_OUT-ZBANKCODE_T = '##'.

        WHEN '005'. GS_EMP_OUT-ZBANKCODE_T = '###'.

      ENDCASE.



      APPEND GS_EMP_OUT TO GT_EMP_OUT.

  ENDLOOP.



ENDFORM.




*&---------------------------------------------------------------------*

*&      Form  DISPLAY_EMP

*&---------------------------------------------------------------------*

*       #### ALV# ##

*----------------------------------------------------------------------*

*  -->  p1        text

*  <--  p2        text

*----------------------------------------------------------------------*




FORM DISPLAY_EMP .




*  FIELDCAT,LAYOUT, SORT##




  PERFORM ALV_FIELDCAT_EMP.

  PERFORM ALV_LAYOUT_EMP.

  PERFORM ALV_SORT_EMP.



  CALL FUNCTION 'REUSE_ALV_GRID_DISPLAY'

  EXPORTING

    IT_FIELDCAT = GT_FIELDCAT

    IS_LAYOUT = GS_LAYOUT

    IT_SORT = GT_SORT

  TABLES

    T_OUTTAB = GT_EMP_OUT.

ENDFORM.






*&---------------------------------------------------------------------*

*&      Form  ALV_FIELDCAT_EMP

*&---------------------------------------------------------------------*

*       ##### ## FIELDCAT

*----------------------------------------------------------------------*

*  -->  p1        text

*  <--  p2        text

*----------------------------------------------------------------------*




FORM ALV_FIELDCAT_EMP .




* ALV_FIELDCAT_EMP




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

  GS_FIELDCAT-FIELDNAME = 'ZDEPCODE_T'.

  GS_FIELDCAT-SELTEXT_M = '###'.

  APPEND GS_FIELDCAT TO GT_FIELDCAT.



  CLEAR : GS_FIELDCAT.

  GS_FIELDCAT-COL_POS = 5.

  GS_FIELDCAT-FIELDNAME = 'ZDEPRANK_T'.

  GS_FIELDCAT-SELTEXT_M = '###'.

  APPEND GS_FIELDCAT TO GT_FIELDCAT.



  CLEAR : GS_FIELDCAT.

  GS_FIELDCAT-COL_POS = 6.

  GS_FIELDCAT-FIELDNAME = 'ZEDATE'.

  GS_FIELDCAT-SELTEXT_M = '###'.

  APPEND GS_FIELDCAT TO GT_FIELDCAT.



  CLEAR : GS_FIELDCAT.

  GS_FIELDCAT-COL_POS = 7.

  GS_FIELDCAT-FIELDNAME = 'ZQFLAG_T'.

  GS_FIELDCAT-SELTEXT_M = '####'.

  APPEND GS_FIELDCAT TO GT_FIELDCAT.



  CLEAR : GS_FIELDCAT.

  GS_FIELDCAT-COL_POS = 8.

  GS_FIELDCAT-FIELDNAME = 'ZGENDER_T'.

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

  GS_FIELDCAT-FIELDNAME = 'ZBANKCODE_T'.

  GS_FIELDCAT-SELTEXT_M = '###'.

  APPEND GS_FIELDCAT TO GT_FIELDCAT.



  CLEAR : GS_FIELDCAT.

  GS_FIELDCAT-COL_POS = 12.

  GS_FIELDCAT-FIELDNAME = 'ZACCOUNT'.

  GS_FIELDCAT-SELTEXT_M = '####'.

  APPEND GS_FIELDCAT TO GT_FIELDCAT.

ENDFORM.




*&---------------------------------------------------------------------*

*&      Form  ALV_LAYOUT_EMP

*&---------------------------------------------------------------------*

*       ##### ## LAYOUT

*----------------------------------------------------------------------*

*  -->  p1        text

*  <--  p2        text

*----------------------------------------------------------------------*




FORM ALV_LAYOUT_EMP .




* ALV_LAYOUT_EMP




GS_LAYOUT-ZEBRA = C_X.

ENDFORM.




*&---------------------------------------------------------------------*

*&      Form  ALV_SORT_EMP

*&---------------------------------------------------------------------*

*       ##### ## SORT

*----------------------------------------------------------------------*

*  -->  p1        text

*  <--  p2        text

*----------------------------------------------------------------------*




FORM ALV_SORT_EMP .




* ALV_SORT_EMP




  GS_SORT-SPOS = 1.

  GS_SORT-FIELDNAME = 'ZPERNR'.

  GS_SORT-UP = C_X.

  APPEND GS_SORT TO GT_SORT.

ENDFORM.




*&---------------------------------------------------------------------*

*&      Form  GET_SAL

*&---------------------------------------------------------------------*

*       #### / #### ## ### ## SELECT

*----------------------------------------------------------------------*

*  -->  p1        text

*  <--  p2        text

*----------------------------------------------------------------------*




FORM GET_SAL .






*  GET_SAL




  DATA : LV_FIRST TYPE D, "##### ## # ## ## ### (### ##)

        LV_LAST TYPE D.   "##### ## # ## ## #### (### ##)



  LV_FIRST = P_YEAR && P_MONTH && '01'. "###

  CALL FUNCTION 'RP_LAST_DAY_OF_MONTHS'

    EXPORTING

      DAY_IN = LV_FIRST

    IMPORTING

      LAST_DAY_OF_MONTH = LV_LAST. "####



  SELECT

    T1~ZPERNR, "####

    T2~ZPNAME, "####

    T1~ZDEPCODE, "####

    T1~ZDEPRANK, "##

    T1~ZEDATE,"###

    T1~DATAB, "### (ZQDATE## ## ### ### #### ###)

    T4~ZSALARY, "####

    T4~ZYEAR, "##

    T3~ZRANK "####

  FROM ZEDT15_102 AS T1

  INNER JOIN ZEDT15_103 AS T2

  ON T1~ZPERNR = T2~ZPERNR

  INNER JOIN ZEDT15_104 AS T3

  ON T1~ZPERNR = T3~ZPERNR

  INNER JOIN ZEDT15_106 AS T4

  ON T1~ZPERNR = T4~ZPERNR

  INTO CORRESPONDING FIELDS OF TABLE @GT_SAL

  WHERE T1~ZPERNR IN @S_ZPERNR "#### ##

  AND T1~ZEDATE <= @LV_FIRST "#### ## ## ##

  AND T1~DATAB > @LV_LAST. "#### ## ## ##



  IF GT_SAL IS INITIAL.

      MESSAGE E001. "### #### ### ####

      STOP.

  ENDIF.



ENDFORM.




*&---------------------------------------------------------------------*

*&      Form  UPDATE_SAL

*&---------------------------------------------------------------------*

*       ## UPDATE

*----------------------------------------------------------------------*

*  -->  GV_SUBRC

*  <--  P_SUBRC

*----------------------------------------------------------------------*




FORM UPDATE_SAL CHANGING P_SUBRC.




*  UPDATE_SAL




  DATA : LV_SAL TYPE ZEDT15_106-ZSALARY. "## ## ##

  "FIELD-SYMBOL ##### ### ##

  DATA : ZMON TYPE C LENGTH 6.

  FIELD-SYMBOLS : <FS1> LIKE GS_SAL_OUT,

                  <FS2> TYPE ANY.



  LOOP AT GT_SAL INTO GS_SAL.

    CLEAR : GS_SAL_OUT.





    "#### / ## ###

    MOVE-CORRESPONDING GS_SAL TO GS_SAL_OUT.

    CHECK GS_SAL-ZRANK NE ''. "###### ### ##



    SELECT *  "## ### ### ZEDT15_105 select (## ### ### UPDATE# # ## # ### ### 0## UPDATE#)

    FROM ZEDT15_105

    INTO CORRESPONDING FIELDS OF GS_SAL_OUT

    WHERE ZPERNR = GS_SAL_OUT-ZPERNR.

    ENDSELECT.



    "## ##

    LV_SAL = GS_SAL-ZSALARY / 12.

      IF GS_SAL-ZRANK = 'A'. "##### A ###

        LV_SAL = LV_SAL + '500'.

      ENDIF.



    IF LV_SAL IS INITIAL OR LV_SAL = 0. "### 0# ## #### ## ##.

      CONTINUE.

    ENDIF.



    GS_SAL_OUT-AENAME = SY-UNAME. "###

    GS_SAL_OUT-AEDATE = SY-DATUM. "###

    GS_SAL_OUT-AEZEIT = SY-UZEIT. "####



    "## ## ## ## ##




*    CASE : P_MONTH.

*        WHEN '01'. GS_SAL_OUT-ZMON01 = LV_SAL.

*        WHEN '02'. GS_SAL_OUT-ZMON02 = LV_SAL.

*        WHEN '03'. GS_SAL_OUT-ZMON03 = LV_SAL.

*        WHEN '04'. GS_SAL_OUT-ZMON04 = LV_SAL.

*        WHEN '05'. GS_SAL_OUT-ZMON05 = LV_SAL.

*        WHEN '06'. GS_SAL_OUT-ZMON06 = LV_SAL.

*        WHEN '07'. GS_SAL_OUT-ZMON07 = LV_SAL.

*        WHEN '08'. GS_SAL_OUT-ZMON08 = LV_SAL.

*        WHEN '09'. GS_SAL_OUT-ZMON09 = LV_SAL.

*        WHEN '10'. GS_SAL_OUT-ZMON10 = LV_SAL.

*        WHEN '11'. GS_SAL_OUT-ZMON11 = LV_SAL.

*        WHEN '12'. GS_SAL_OUT-ZMON12 = LV_SAL.

*     ENDCASE.








    ASSIGN GS_SAL_OUT TO <FS1>.

    CONCATENATE 'ZMON' P_MONTH INTO ZMON.

    ASSIGN COMPONENT ZMON OF STRUCTURE <FS1> TO <FS2>.

    <FS2> = LV_SAL.



    "### ####

    UPDATE ZEDT15_105 FROM GS_SAL_OUT.



    P_SUBRC = SY-SUBRC.

    IF SY-SUBRC NE 0. "#### ###

       EXIT.

    ENDIF.

  ENDLOOP.



  IF P_SUBRC = 0.

    WRITE : /'### #######.'.

  ELSE.

    WRITE : /'#### ##'.

    STOP. "#### ### #### ##

  ENDIF.

ENDFORM.




*&---------------------------------------------------------------------*

*&      Form  MODIFY_EVAL

*&---------------------------------------------------------------------*

*       ##### ## ### MODIFY # ### ITAB# APPEND

*----------------------------------------------------------------------*

*  -->  p1        text

*  <--  p2        text

*----------------------------------------------------------------------*




FORM MODIFY_EVAL USING GT_SAL LIKE GT_SAL .




*MODIFY_EVAL




LOOP AT GT_SAL INTO GS_SAL.



  "## # ## ####

  MOVE-CORRESPONDING GS_SAL TO GS_SAL_OUT.



  SELECT *  "### ### ZEDT15_105 select

  FROM ZEDT15_105

  INTO CORRESPONDING FIELDS OF GS_SAL_OUT

  WHERE ZPERNR = GS_SAL_OUT-ZPERNR.

  ENDSELECT.



   CASE P_MONTH. "## ### ##

      WHEN '01'. GS_SAL-ZSAL_MONTH = GS_SAL_OUT-ZMON01.

      WHEN '02'. GS_SAL-ZSAL_MONTH = GS_SAL_OUT-ZMON02.

      WHEN '03'. GS_SAL-ZSAL_MONTH = GS_SAL_OUT-ZMON03.

      WHEN '04'. GS_SAL-ZSAL_MONTH = GS_SAL_OUT-ZMON04..

      WHEN '05'. GS_SAL-ZSAL_MONTH = GS_SAL_OUT-ZMON05.

      WHEN '06'. GS_SAL-ZSAL_MONTH = GS_SAL_OUT-ZMON06.

      WHEN '07'. GS_SAL-ZSAL_MONTH = GS_SAL_OUT-ZMON07.

      WHEN '08'. GS_SAL-ZSAL_MONTH = GS_SAL_OUT-ZMON08.

      WHEN '09'. GS_SAL-ZSAL_MONTH = GS_SAL_OUT-ZMON09.

      WHEN '10'. GS_SAL-ZSAL_MONTH = GS_SAL_OUT-ZMON10.

      WHEN '11'. GS_SAL-ZSAL_MONTH = GS_SAL_OUT-ZMON11.

      WHEN '12'. GS_SAL-ZSAL_MONTH = GS_SAL_OUT-ZMON12.

   ENDCASE.



   "

   MOVE-CORRESPONDING GS_SAL TO GS_EVAL.



   CASE: GS_SAL-ZDEPCODE. "###

      WHEN 'SS0001'. GS_EVAL-ZDEPCODE_T = '###'.

      WHEN 'SS0002'. GS_EVAL-ZDEPCODE_T = '###'.

      WHEN 'SS0003'. GS_EVAL-ZDEPCODE_T = '###'.

      WHEN 'SS0004'. GS_EVAL-ZDEPCODE_T = '###'.

      WHEN 'SS0005'. GS_EVAL-ZDEPCODE_T = '###'.

      WHEN 'SS0006'. GS_EVAL-ZDEPCODE_T = '###'.

    ENDCASE.



    CASE: GS_SAL-ZDEPRANK. "###

      WHEN 'A'. GS_EVAL-ZDEPRANK_T = '##'.

      WHEN 'B'. GS_EVAL-ZDEPRANK_T = '##'.

      WHEN 'C'. GS_EVAL-ZDEPRANK_T = '##'.

      WHEN 'D'. GS_EVAL-ZDEPRANK_T = '##'.

      WHEN 'E'. GS_EVAL-ZDEPRANK_T = '##'.

      WHEN 'F'. GS_EVAL-ZDEPRANK_T = '##'.

      WHEN 'G'. GS_EVAL-ZDEPRANK_T = '##'.

    ENDCASE.



    APPEND GS_EVAL TO GT_EVAL.

ENDLOOP.



ENDFORM.




*&---------------------------------------------------------------------*

*&      Form  DISPLAY_EVAL

*&---------------------------------------------------------------------*

*       #### ALV# ##

*----------------------------------------------------------------------*

*  -->  p1        text

*  <--  p2        text

*----------------------------------------------------------------------*




FORM DISPLAY_EVAL .

  PERFORM ALV_FIELDCAT_EVAL.

  PERFORM ALV_LAYOUT_EVAL.

  PERFORM ALV_SORT_EVAL.



  CALL FUNCTION 'REUSE_ALV_GRID_DISPLAY'

    EXPORTING

      IS_LAYOUT                         = GS_LAYOUT

      IT_FIELDCAT                       = GT_FIELDCAT

      IT_SORT                           = GT_SORT

    TABLES

      T_OUTTAB                          = GT_EVAL.

ENDFORM.




*&---------------------------------------------------------------------*

*&      Form  ALV_FIELDCAT_EVAL

*&---------------------------------------------------------------------*

*       ##### ## FIELDCAT

*----------------------------------------------------------------------*

*  -->  p1        text

*  <--  p2        text

*----------------------------------------------------------------------*




FORM ALV_FIELDCAT_EVAL .




*  ALV_FIELDCAT_EVAL.




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

  GS_FIELDCAT-FIELDNAME = 'ZDEPCODE_T'.

  GS_FIELDCAT-SELTEXT_M = '###'.

  APPEND GS_FIELDCAT TO GT_FIELDCAT.



  CLEAR : GS_FIELDCAT.

  GS_FIELDCAT-COL_POS = 5.

  GS_FIELDCAT-FIELDNAME = 'ZDEPRANK_T'.

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

  GS_FIELDCAT-CURRENCY = 'KRW'. "## ### ##

  GS_FIELDCAT-JUST = 'R'. "### ##

  GS_FIELDCAT-DO_SUM = 'X'. "## ##

  GS_FIELDCAT-OUTPUTLEN = 15. "# ## 15

  APPEND GS_FIELDCAT TO GT_FIELDCAT.



  CLEAR : GS_FIELDCAT.

  GS_FIELDCAT-COL_POS = 8.

  GS_FIELDCAT-FIELDNAME = 'ZRANK'.

  GS_FIELDCAT-SELTEXT_M = '####'.

  APPEND GS_FIELDCAT TO GT_FIELDCAT.



  CLEAR : GS_FIELDCAT.

  GS_FIELDCAT-COL_POS = 9.

  GS_FIELDCAT-FIELDNAME = 'ZSAL_MONTH'.

  GS_FIELDCAT-SELTEXT_M =  P_MONTH && '#####'.

  GS_FIELDCAT-CURRENCY = 'KRW'. "## ### ##

  GS_FIELDCAT-JUST = 'R'. "### ##

  GS_FIELDCAT-DO_SUM = C_X. "## ##

  GS_FIELDCAT-OUTPUTLEN = 15. "# ## 15

  APPEND GS_FIELDCAT TO GT_FIELDCAT.

ENDFORM.




*&---------------------------------------------------------------------*

*&      Form  ALV_LAYOUT_EVAL

*&---------------------------------------------------------------------*

*       ##### ## LAYOUT

*----------------------------------------------------------------------*

*  -->  p1        text

*  <--  p2        text

*----------------------------------------------------------------------*




FORM ALV_LAYOUT_EVAL .




*  ALV_LAYOUT_EVAL




  GS_LAYOUT-ZEBRA = C_X.

ENDFORM.




*&---------------------------------------------------------------------*

*&      Form  ALV_SORT_EVAL

*&---------------------------------------------------------------------*

*       ##### ## SORT

*----------------------------------------------------------------------*

*  -->  p1        text

*  <--  p2        text

*----------------------------------------------------------------------*




FORM ALV_SORT_EVAL .




*  ALV_SORT_EVAL




  GS_SORT-SPOS = '1'.

  GS_SORT-FIELDNAME = 'ZPERNR'.

  GS_SORT-UP = C_X. "####

  APPEND GS_SORT TO GT_SORT.

ENDFORM.