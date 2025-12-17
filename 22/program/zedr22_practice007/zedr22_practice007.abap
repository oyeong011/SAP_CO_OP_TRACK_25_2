
*&---------------------------------------------------------------------*

*& Report ZEDR22_PRACTICE007

*&---------------------------------------------------------------------*

*&

*&---------------------------------------------------------------------*




REPORT ZEDR22_PRACTICE007 MESSAGE-ID ZMED22_1.

"## ##

" ### ##

TABLES : ZEDT22_102, ZEDT22_103, ZEDT22_104, ZEDT22_105, ZEDT22_106.

CONSTANTS : C_BONUS_A TYPE P DECIMALS 2 VALUE '500'.

CONSTANTS : C_STATUS_RETIRE TYPE CHAR4 VALUE '##'.

CONSTANTS : C_STATUS_WORK   TYPE CHAR4 VALUE '##'.

CONSTANTS : C_GENDER_M      TYPE CHAR4 VALUE '##'.

CONSTANTS : C_GENDER_F      TYPE CHAR4 VALUE '##'.

CONSTANTS : C_X TYPE CHAR1 VALUE 'X'.

CONSTANTS : C_0 TYPE CHAR1 VALUE '0'.

CONSTANTS : C_I TYPE CHAR1 VALUE 'I'.

CONSTANTS : C_BT TYPE CHAR2 VALUE 'BT'.

CONSTANTS : C_EQ TYPE CHAR2 VALUE 'EQ'.



RANGES : R_FLAG FOR ZEDT22_102-ZQFLAG.



DATA : GV_YEAR(4), GV_MONTH(2) TYPE N.

DATA : C_CHECK.



DATA : BEGIN OF GS_PERNR, "#######

         ZPERNR    LIKE ZEDT22_102-ZPERNR, "####

         ZPNAME    LIKE ZEDT22_103-ZPNAME, "####

         ZDEPCODE  LIKE ZEDT22_102-ZDEPCODE, "####

         ZDEPRANK  LIKE ZEDT22_102-ZDEPRANK, "##

         ZEDATE    LIKE ZEDT22_102-ZEDATE, "###

         ZQFLAG    LIKE ZEDT22_102-ZQFLAG, "####

         ZGENDER   LIKE ZEDT22_103-ZGENDER, "##

         ZADDRESS  LIKE ZEDT22_103-ZADDRESS, "##

         ZBANKCODE LIKE ZEDT22_106-ZBANKCODE, "####

         ZACCOUNT  LIKE ZEDT22_106-ZACCOUNT, "####

       END OF GS_PERNR.

DATA : GT_PERNR LIKE TABLE OF GS_PERNR.



DATA : BEGIN OF GS_PERNR_ALV, "#### ALV ###

         ZPERNR            LIKE ZEDT22_102-ZPERNR, "####

         ZPNAME            LIKE ZEDT22_103-ZPNAME, "####

         ZDEPCODE          LIKE ZEDT22_102-ZDEPCODE, "####

         ZDEPCODE_NAME(10), "###

         ZDEPRANK_NAME(6),  "###

         ZEDATE            LIKE ZEDT22_102-ZEDATE, "###

         ZQFLAG_NAME(4), "####

         ZGENDER_NAME(4), "##

         ZADDRESS          LIKE ZEDT22_103-ZADDRESS, "##

         ZBANKCODE         LIKE ZEDT22_106-ZBANKCODE, "####

         ZBANK_NAME(10),"###

         ZACCOUNT          LIKE ZEDT22_106-ZACCOUNT, "####

       END OF GS_PERNR_ALV.

DATA : GT_PERNR_ALV LIKE TABLE OF GS_PERNR_ALV.



DATA : BEGIN OF GS_SALARY, "#######

         ZPERNR  LIKE ZEDT22_102-ZPERNR, "####

         ZPNAME   LIKE ZEDT22_103-ZPNAME, "####

         ZDEPCODE LIKE ZEDT22_102-ZDEPCODE, "####

         ZDEPRANK LIKE ZEDT22_102-ZDEPRANK, "##

         ZEDATE   LIKE ZEDT22_102-ZEDATE, "###

         ZQDATE  LIKE ZEDT22_102-ZQDATE, "###

         ZQFLAG  LIKE ZEDT22_102-ZQFLAG, "####

         ZSALARY LIKE ZEDT22_106-ZSALARY, "####

         ZPAY    LIKE ZEDT22_106-ZSALARY, "##

         ZRANK   LIKE ZEDT22_104-ZRANK, "####

       END OF GS_SALARY.

DATA : GT_SALARY LIKE TABLE OF GS_SALARY.



DATA : BEGIN OF GS_SALARY_ALV, "####### ALV ###

         ZPERNR            LIKE ZEDT22_102-ZPERNR, "####

         ZPNAME            LIKE ZEDT22_103-ZPNAME, "####

         ZDEPCODE          LIKE ZEDT22_102-ZDEPCODE, "####

         ZDEPCODE_NAME(10), "###

         ZDEPRANK_NAME(6),  "###

         ZEDATE            LIKE ZEDT22_102-ZEDATE, "###

         ZSALARY           LIKE ZEDT22_106-ZSALARY, "####

         ZRANK             LIKE ZEDT22_104-ZRANK, "####

         ZMON              LIKE ZEDT22_105-ZMON01, "##

       END OF GS_SALARY_ALV.

DATA : GT_SALARY_ALV LIKE TABLE OF GS_SALARY_ALV.



DATA : BEGIN OF GS_ASSESS, "#####

         ZPERNR   LIKE ZEDT22_102-ZPERNR, "####

         ZPNAME   LIKE ZEDT22_103-ZPNAME, "####

         ZDEPCODE LIKE ZEDT22_102-ZDEPCODE, "####

         ZDEPRANK LIKE ZEDT22_102-ZDEPRANK, "##

         ZEDATE   LIKE ZEDT22_102-ZEDATE, "###

         ZSALARY  LIKE ZEDT22_106-ZSALARY, "####

         ZRANK    LIKE ZEDT22_104-ZRANK, "####

       END OF GS_ASSESS.

DATA : GT_ASSESS LIKE TABLE OF GS_ASSESS.



DATA : BEGIN OF GS_ASSESS_ALV, "##### ALV ###

         ZPERNR            LIKE ZEDT22_102-ZPERNR, "####

         ZPNAME            LIKE ZEDT22_103-ZPNAME, "####

         ZDEPCODE          LIKE ZEDT22_102-ZDEPCODE, "####

         ZDEPCODE_NAME(10), "###

         ZDEPRANK_NAME(6),  "###

         ZEDATE            LIKE ZEDT22_102-ZEDATE, "###

         ZSALARY           LIKE ZEDT22_106-ZSALARY, "####

         ZRANK             LIKE ZEDT22_104-ZRANK, "####

         ZMON              LIKE ZEDT22_105-ZMON01, "##

       END OF GS_ASSESS_ALV.

DATA : GT_ASSESS_ALV LIKE TABLE OF GS_ASSESS_ALV.



" ## #### ##

DATA : GS_FIELDCAT TYPE SLIS_FIELDCAT_ALV.

DATA : GT_FIELDCAT TYPE SLIS_T_FIELDCAT_ALV.

DATA : GS_LAYOUT TYPE SLIS_LAYOUT_ALV.

DATA : GS_SORT TYPE SLIS_SORTINFO_ALV.

DATA : GT_SORT TYPE SLIS_T_SORTINFO_ALV.



" ### ###

SELECTION-SCREEN BEGIN OF BLOCK B1 WITH FRAME.

SELECT-OPTIONS : S_PERNR FOR ZEDT22_102-ZPERNR.

SELECT-OPTIONS : S_DATE FOR ZEDT22_102-DATBI NO-EXTENSION MODIF ID M1. " ####

SELECT-OPTIONS : S_DEPT FOR ZEDT22_102-ZDEPCODE NO INTERVALS NO-EXTENSION MODIF ID M1.

PARAMETERS : P_YEAR LIKE ZEDT22_105-ZYEAR DEFAULT SY-DATUM+0(4) MODIF ID M2. "####/####

PARAMETERS : P_MONTH(2) DEFAULT SY-DATUM+4(2) MODIF ID M2. " TEXT ####.

SELECTION-SCREEN END OF BLOCK B1.



SELECTION-SCREEN BEGIN OF BLOCK B2 WITH FRAME.

PARAMETERS : P_RAD1 RADIOBUTTON GROUP R1 DEFAULT 'X' USER-COMMAND UC1.

PARAMETERS : P_RAD2 RADIOBUTTON GROUP R1.

PARAMETERS : P_RAD3 RADIOBUTTON GROUP R1.

SELECTION-SCREEN END OF BLOCK B2.



SELECTION-SCREEN BEGIN OF BLOCK B3 WITH FRAME.

PARAMETERS : P_CHK1 AS CHECKBOX DEFAULT 'X' MODIF ID M1.

SELECTION-SCREEN END OF BLOCK B3.



INITIALIZATION.

  PERFORM SET_DATE.



AT SELECTION-SCREEN OUTPUT.

  PERFORM SET_SCREEN.





START-OF-SELECTION. "### ####

  PERFORM CHECK_DATA. "### ### # ##.



  IF P_RAD1 = C_X."####

  PERFORM SELECT_DATA_R1.

  IF GT_PERNR[] IS INITIAL.

    MESSAGE I001.

    EXIT.

  ENDIF.

  PERFORM MODIFY_DATA_R1.

  PERFORM ALV_DISPLAY_R1.

ELSEIF P_RAD2 = C_X."####

  PERFORM SELECT_DATA_R2.

  IF GT_SALARY[] IS INITIAL.

    MESSAGE I001.

    EXIT.

  ENDIF.

  PERFORM MODIFY_DATA_R2.

  PERFORM ALV_DISPLAY_R2.

ELSEIF P_RAD3 = C_X."####

  PERFORM SELECT_DATA_R3.

  IF GT_ASSESS[] IS INITIAL.

    MESSAGE I001.

    EXIT.

  ENDIF.

  PERFORM MODIFY_DATA_R3.

  PERFORM ALV_DISPLAY_R3.

ENDIF.



END-OF-SELECTION.

  CHECK P_RAD2 = C_X.

  IF C_CHECK = C_X.

    MESSAGE I003. " ## ## ##

  ELSE.

    MESSAGE I002. " ## ## ##

  ENDIF.



  "




*&---------------------------------------------------------------------*

*&      Form  SET_DATE

*&---------------------------------------------------------------------*




FORM SET_DATE.

  IF S_DATE[] IS INITIAL.

    CONCATENATE SY-DATUM(4) '01' '01' INTO S_DATE-LOW.

    S_DATE-HIGH = SY-DATUM(6) && '01'.

    S_DATE-SIGN = C_I.

    S_DATE-OPTION = C_BT.



    CALL FUNCTION 'LAST_DAY_OF_MONTHS' " ## ### ## ####

      EXPORTING

        DAY_IN            = S_DATE-HIGH

      IMPORTING

        LAST_DAY_OF_MONTH = S_DATE-HIGH.

    APPEND S_DATE.

  ENDIF.

ENDFORM.






*&---------------------------------------------------------------------*

*&      Form  SET_SCREEN

*&---------------------------------------------------------------------*




FORM SET_SCREEN .



  LOOP AT SCREEN.

    IF ( P_RAD1 = C_X AND SCREEN-GROUP1 = 'M2' ) OR

       ( P_RAD1 <> C_X AND SCREEN-GROUP1 = 'M1' ).

      SCREEN-ACTIVE = C_0.

    ENDIF.

    MODIFY SCREEN.

  ENDLOOP.



ENDFORM.




*&---------------------------------------------------------------------*

*&      Form  CHECK_DATA

*&---------------------------------------------------------------------*




FORM CHECK_DATA .

  "#### ##

  IF P_RAD1 = C_X.

    IF  S_DATE IS INITIAL .

      MESSAGE I000. "## ## ######.

      STOP.

    ENDIF.

  ELSE.

    IF ( P_YEAR IS INITIAL ) OR ( P_MONTH IS INITIAL ).

      MESSAGE I000.

      STOP.

    ENDIF.

  ENDIF.



  "#### ##

  CLEAR : GV_YEAR, GV_MONTH, C_CHECK.

  GV_YEAR = P_YEAR.

  GV_MONTH = P_MONTH.



ENDFORM.




*&---------------------------------------------------------------------*

*&      Form  SELECT_DATA_R1

*&---------------------------------------------------------------------*




FORM SELECT_DATA_R1 .



  PERFORM SET_R_FLAG.



  SELECT A~ZPERNR     "####

         B~ZPNAME     "####

         A~ZDEPCODE   "####

         A~ZDEPRANK   "####

         A~ZEDATE     "###

         A~ZQFLAG     "####

         B~ZGENDER    "##

         B~ZADDRESS   "##

         C~ZBANKCODE  "####

         C~ZACCOUNT   "####

    INTO CORRESPONDING FIELDS OF TABLE GT_PERNR

    FROM ZEDT22_102 AS A

    INNER JOIN ZEDT22_103 AS B ON A~ZPERNR = B~ZPERNR

    INNER JOIN ZEDT22_106 AS C ON A~ZPERNR = C~ZPERNR

    WHERE A~ZPERNR   IN S_PERNR

      AND A~DATBI   <= S_DATE-HIGH

      AND A~DATAB   >  S_DATE-HIGH

      AND A~ZDEPCODE IN S_DEPT

      AND A~ZQFLAG   IN R_FLAG.



ENDFORM.






*&---------------------------------------------------------------------*

*&      Form  SET_R_FLAG

*&---------------------------------------------------------------------*




FORM SET_R_FLAG .



  CLEAR R_FLAG.



  R_FLAG-SIGN = C_I.

  R_FLAG-OPTION = C_EQ.

  R_FLAG-LOW = ''.

  APPEND R_FLAG.



  IF P_CHK1 NE C_X. "## + ### #

    R_FLAG-LOW = 'X'.

    APPEND R_FLAG.

  ENDIF.



ENDFORM.




*&---------------------------------------------------------------------*

*&      Form  MODIFY_DATA_R1

*&---------------------------------------------------------------------*




FORM MODIFY_DATA_R1 .

  LOOP AT GT_PERNR INTO GS_PERNR.

    CLEAR : GS_PERNR_ALV.

    MOVE-CORRESPONDING GS_PERNR TO GS_PERNR_ALV.



    PERFORM CHANGE_DEPCODE USING GS_PERNR_ALV-ZDEPCODE

                         CHANGING GS_PERNR_ALV-ZDEPCODE_NAME.

    PERFORM CHANGE_RANK USING GS_PERNR-ZDEPRANK

                      CHANGING GS_PERNR_ALV-ZDEPRANK_NAME.



    IF GS_PERNR-ZQFLAG = C_X.

      GS_PERNR_ALV-ZQFLAG_NAME = C_STATUS_RETIRE.

    ELSE.

      GS_PERNR_ALV-ZQFLAG_NAME = C_STATUS_WORK.

    ENDIF.



    IF GS_PERNR-ZGENDER = 'M'.

      GS_PERNR_ALV-ZGENDER_NAME = C_GENDER_M.

    ELSEIF GS_PERNR-ZGENDER = 'F'.

      GS_PERNR_ALV-ZGENDER_NAME = C_GENDER_F.

    ENDIF.



    PERFORM CHANGE_BANKCODE USING GS_PERNR-ZBANKCODE

                          CHANGING GS_PERNR_ALV-ZBANK_NAME.



    APPEND GS_PERNR_ALV TO GT_PERNR_ALV.

  ENDLOOP.

ENDFORM.




*&---------------------------------------------------------------------*

*&      Form  ALV_DISPLAY_R1

*&---------------------------------------------------------------------*




FORM ALV_DISPLAY_R1 .



  PERFORM FIELD_CATALOG.

  PERFORM SET_LAYOUT.

  PERFORM SET_SORT.

  PERFORM CALL_ALV USING GT_PERNR_ALV.



ENDFORM.




*&---------------------------------------------------------------------*

*&      Form  SELECT_DATA_R2

*&---------------------------------------------------------------------*




FORM SELECT_DATA_R2 .



  DATA : LV_DATE LIKE ZEDT22_102-DATBI.

  CLEAR : LV_DATE.

  CONCATENATE P_YEAR P_MONTH '01' INTO LV_DATE.



  SELECT A~ZPERNR "####

         B~ZPNAME "####

         A~ZDEPCODE "####

         A~ZDEPRANK "####

         A~ZEDATE "###

         A~ZQDATE "###

         A~ZQFLAG "####

         C~ZRANK "####

         D~ZSALARY "##

    INTO CORRESPONDING FIELDS OF TABLE GT_SALARY

    FROM ZEDT22_102 AS A INNER JOIN ZEDT22_103 AS B

    ON A~ZPERNR = B~ZPERNR

    INNER JOIN ZEDT22_104 AS C ON A~ZPERNR = C~ZPERNR

    INNER JOIN ZEDT22_106 AS D ON A~ZPERNR = D~ZPERNR

    WHERE A~ZPERNR IN S_PERNR

    AND   C~ZYEAR = P_YEAR

    AND   D~ZYEAR = P_YEAR

    AND   C~DATBI <= LV_DATE.



ENDFORM.




*&---------------------------------------------------------------------*

*&      Form  MODIFY_DATA_R2

*&---------------------------------------------------------------------*




FORM MODIFY_DATA_R2.



  DATA : LV_DATE2(6).

  CLEAR : LV_DATE2.

  CONCATENATE P_YEAR P_MONTH INTO LV_DATE2.



  LOOP AT GT_SALARY INTO GS_SALARY.

    IF GS_SALARY-ZQFLAG = C_X.

      IF GS_SALARY-ZQDATE+0(6) <= LV_DATE2.

        CONTINUE.

      ENDIF.

    ENDIF.



    GS_SALARY-ZPAY = GS_SALARY-ZSALARY / 12.

    IF GS_SALARY-ZRANK = 'A'.

      GS_SALARY-ZPAY = GS_SALARY-ZPAY + C_BONUS_A.

    ENDIF.



    CHECK GS_SALARY-ZPAY NE 0.



    PERFORM UPDATE_PAY USING GV_YEAR GV_MONTH

                             GS_SALARY-ZPERNR

                             GS_SALARY-ZPAY

                       CHANGING C_CHECK.

    IF C_CHECK = C_X.

      STOP.

    ENDIF.



    CLEAR : GS_SALARY_ALV.

    MOVE-CORRESPONDING GS_SALARY TO GS_SALARY_ALV.



    PERFORM GET_PAY USING GV_YEAR GV_MONTH GS_SALARY_ALV-ZPERNR CHANGING GS_SALARY_ALV-ZMON.

    PERFORM CHANGE_DEPCODE USING GS_SALARY_ALV-ZDEPCODE CHANGING GS_SALARY_ALV-ZDEPCODE_NAME.

    PERFORM CHANGE_RANK USING GS_SALARY-ZDEPRANK CHANGING GS_SALARY_ALV-ZDEPRANK_NAME.



    IF GS_SALARY_ALV-ZMON NE 0.

      APPEND GS_SALARY_ALV TO GT_SALARY_ALV.

    ENDIF.

  ENDLOOP.



ENDFORM.




*&---------------------------------------------------------------------*

*&      Form  ALV_DISPLAY_R2

*&---------------------------------------------------------------------*




FORM ALV_DISPLAY_R2 .



  PERFORM FIELD_CATALOG.

  PERFORM SET_LAYOUT.

  PERFORM SET_SORT.

  PERFORM CALL_ALV USING GT_SALARY_ALV.



ENDFORM.




*&---------------------------------------------------------------------*

*&      Form  SELECT_DATA_R3

*&---------------------------------------------------------------------*




FORM SELECT_DATA_R3.



  SELECT A~ZPERNR "####

         B~ZPNAME "####

         A~ZDEPCODE "####

         A~ZDEPRANK "####

         A~ZEDATE "###

         C~ZRANK "####

         D~ZSALARY "####

    INTO CORRESPONDING FIELDS OF TABLE GT_ASSESS

    FROM ZEDT22_102 AS A  INNER JOIN ZEDT22_103 AS B

    ON A~ZPERNR = B~ZPERNR

    INNER JOIN ZEDT22_104 AS C

    ON A~ZPERNR = C~ZPERNR

    INNER JOIN ZEDT22_106 AS D

    ON A~ZPERNR = D~ZPERNR

    WHERE A~ZPERNR IN S_PERNR

    AND   C~ZYEAR = P_YEAR

    AND   D~ZYEAR = P_YEAR.



ENDFORM.




*&---------------------------------------------------------------------*

*&      Form  MODIFY_DATA_R3

*&---------------------------------------------------------------------*




FORM MODIFY_DATA_R3.



  LOOP AT GT_ASSESS INTO GS_ASSESS.

    CLEAR : GS_ASSESS_ALV.

    MOVE-CORRESPONDING GS_ASSESS TO GS_ASSESS_ALV.



    PERFORM GET_PAY USING GV_YEAR GV_MONTH GS_ASSESS_ALV-ZPERNR CHANGING GS_ASSESS_ALV-ZMON.

    PERFORM CHANGE_DEPCODE USING GS_ASSESS_ALV-ZDEPCODE CHANGING GS_ASSESS_ALV-ZDEPCODE_NAME.

    PERFORM CHANGE_RANK USING GS_ASSESS-ZDEPRANK CHANGING GS_ASSESS_ALV-ZDEPRANK_NAME.



    IF GS_ASSESS_ALV-ZMON NE 0.

      APPEND GS_ASSESS_ALV TO GT_ASSESS_ALV.

    ENDIF.

  ENDLOOP.



ENDFORM.




*&---------------------------------------------------------------------*

*&      Form  ALV_DISPLAY_R3

*&---------------------------------------------------------------------*




FORM ALV_DISPLAY_R3.



  PERFORM FIELD_CATALOG.

  PERFORM SET_LAYOUT.

  PERFORM SET_SORT.

  PERFORM CALL_ALV USING GT_ASSESS_ALV.



ENDFORM.




*&---------------------------------------------------------------------*

*&      Form  CHANGE_DEPCODE

*&---------------------------------------------------------------------*




FORM CHANGE_DEPCODE USING P_ZEDPCODE CHANGING P_ZEDPCODE_NAME.

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

*&      Form  CHANGE_RANK

*&---------------------------------------------------------------------*




FORM CHANGE_RANK USING P_RANK CHANGING P_RANK_NAME.



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

*&      Form  CHANGE_BANKCODE

*&---------------------------------------------------------------------*




FORM CHANGE_BANKCODE USING P_BANKCODE CHANGING P_BANKNAME.

  CASE P_BANKCODE.

    WHEN '001'.

      P_BANKNAME = '##'.

    WHEN '002'.

      P_BANKNAME = '##'.

    WHEN '003'.

      P_BANKNAME = '##'.

    WHEN '004'.

      P_BANKNAME = '##'.

    WHEN '005'.

      P_BANKNAME = '###'.

  ENDCASE.

ENDFORM.




*&---------------------------------------------------------------------*

*&      Form  FIELD_CATALOG

*&---------------------------------------------------------------------*




FORM FIELD_CATALOG.



  DATA : L_TEXT(10).



  CLEAR : GS_FIELDCAT, GT_FIELDCAT.

  GS_FIELDCAT-COL_POS = 1.

  GS_FIELDCAT-FIELDNAME = 'ZPERNR'.

  GS_FIELDCAT-SELTEXT_M = '####'.

  GS_FIELDCAT-KEY = 'X'.

  APPEND GS_FIELDCAT TO GT_FIELDCAT.



  CLEAR : GS_FIELDCAT.

  GS_FIELDCAT-COL_POS = 2.

  GS_FIELDCAT-FIELDNAME = 'ZPNAME'.

  GS_FIELDCAT-SELTEXT_M = '####'.

  GS_FIELDCAT-KEY = 'X'.

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

  GS_FIELDCAT-OUTPUTLEN = '10'.

  APPEND GS_FIELDCAT TO GT_FIELDCAT.



  IF P_RAD1 = C_X.

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

  ELSE.

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




FORM SET_LAYOUT.



  CLEAR GS_LAYOUT.

  GS_LAYOUT-ZEBRA = C_X.



ENDFORM.




*&---------------------------------------------------------------------*

*&      Form  SET_SORT

*&---------------------------------------------------------------------*




FORM SET_SORT.



  CLEAR : GS_SORT, GT_SORT.



  GS_SORT-SPOS = 1.

  GS_SORT-FIELDNAME = 'ZPERNR'.

  GS_SORT-UP = C_X.

  APPEND GS_SORT TO GT_SORT.



ENDFORM.




*&---------------------------------------------------------------------*

*&      Form  CALL_ALV

*&---------------------------------------------------------------------*




FORM CALL_ALV USING PT_ALV TYPE STANDARD TABLE.



  CALL FUNCTION 'REUSE_ALV_GRID_DISPLAY'

    EXPORTING

      IT_FIELDCAT = GT_FIELDCAT

      IS_LAYOUT   = GS_LAYOUT

      IT_SORT     = GT_SORT

    TABLES

      T_OUTTAB    = PT_ALV.



ENDFORM.




*&---------------------------------------------------------------------*

*&      Form  GET_PAY

*&---------------------------------------------------------------------*




FORM GET_PAY USING PV_YEAR PV_MON P_ZPERNR "# # ##

                   CHANGING P_ZMONTH.



DATA : LV_FIELDNAME TYPE STRING.

DATA : LS_SALARY TYPE ZEDT22_105.

FIELD-SYMBOLS : <FS_MONTH> TYPE ANY. "## ## ##



CONCATENATE 'ZMON' PV_MON INTO LV_FIELDNAME. "#### ### ###



SELECT SINGLE * FROM ZEDT22_105 INTO LS_SALARY "## ### ##

                WHERE ZPERNR = P_ZPERNR

                AND ZYEAR = PV_YEAR.



   IF SY-SUBRC = 0.

     "## ### ## ### ##

     "'ZMONTH01' ### <FS_MONTH>### #####

     ASSIGN COMPONENT LV_FIELDNAME OF STRUCTURE LS_SALARY TO <FS_MONTH>.



     IF <FS_MONTH> IS ASSIGNED.

       P_ZMONTH = <FS_MONTH>."## ### # ####

     ENDIF.

   ENDIF.



ENDFORM.




*&---------------------------------------------------------------------*

*&      Form  UPDATE_PAY

*&---------------------------------------------------------------------*




FORM UPDATE_PAY USING PV_YEAR PV_MONTH P_ZPERNR P_ZPAY "# # ####

                CHANGING PV_CHECK.



  DATA : LV_FIELDNAME TYPE STRING.

  DATA : LS_SALARY TYPE ZEDT22_105.

  FIELD-SYMBOLS <FS_MONTH> TYPE ANY. "## ## ##



  CONCATENATE 'ZMON' PV_MONTH INTO LV_FIELDNAME."#### ### ###



  "## ### ##

  SELECT SINGLE * FROM ZEDT22_105 INTO LS_SALARY

                  WHERE ZPERNR = P_ZPERNR

                  AND ZYEAR = PV_YEAR.



   IF SY-SUBRC = 0.

     "## ### ## ### ##

     ASSIGN COMPONENT LV_FIELDNAME OF STRUCTURE LS_SALARY TO <FS_MONTH>.



     IF <FS_MONTH> IS ASSIGNED. "## ### # ##

       <FS_MONTH> = P_ZPAY. "## #### ## ##



       "### ### ### DB# ####

       UPDATE ZEDT22_105 FROM LS_SALARY.



       IF SY-SUBRC NE 0.

         PV_CHECK = C_X. "#### ##

       ENDIF.

    ELSE.

      PV_CHECK = C_X. "## ## ##

      ENDIF.

   ELSE.

     PV_CHECK = C_X."## ##

   ENDIF.



ENDFORM.