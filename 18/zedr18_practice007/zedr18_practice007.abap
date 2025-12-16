
*&---------------------------------------------------------------------*

*& Report ZEDR18_PRACTICE007

*&---------------------------------------------------------------------*

*&

*&---------------------------------------------------------------------*




REPORT ZEDR18_PRACTICE007 MESSAGE-ID ZMED18.



" ### ##

TABLES : ZEDT18_102, ZEDT18_103, ZEDT18_104, ZEDT18_105, ZEDT18_106.

CONSTANTS : C_X TYPE CHAR1 VALUE 'X'.

CONSTANTS : C_0 TYPE CHAR1 VALUE '0'.

CONSTANTS : C_I TYPE CHAR1 VALUE 'I'.

CONSTANTS : C_BT TYPE CHAR2 VALUE 'BT'.

CONSTANTS : C_EQ TYPE CHAR2 VALUE 'EQ'.

RANGES : R_FLAG FOR ZEDT18_102-ZQFLAG.



DATA : BEGIN OF GS_PERNR, "#######

         ZPERNR    LIKE ZEDT18_102-ZPERNR, "####

         ZPNAME    LIKE ZEDT18_103-ZPNAME, "####

         ZDEPCODE  LIKE ZEDT18_102-ZDEPCODE, "####

         ZDEPRANK  LIKE ZEDT18_102-ZDEPRANK, "##

         ZEDATE    LIKE ZEDT18_102-ZEDATE, "###

         ZQFLAG    LIKE ZEDT18_102-ZQFLAG, "####

         ZGENDER   LIKE ZEDT18_103-ZGENDER, "##

         ZADDRESS  LIKE ZEDT18_103-ZADDRESS, "##

         ZBANKCODE LIKE ZEDT18_106-ZBANKCODE, "####

         ZACCOUNT  LIKE ZEDT18_106-ZACCOUNT, "####

       END OF GS_PERNR.

DATA : GT_PERNR LIKE TABLE OF GS_PERNR.



DATA : BEGIN OF GS_PERNR_ALV, "#### ALV ###

         ZPERNR            LIKE ZEDT18_102-ZPERNR, "####

         ZPNAME            LIKE ZEDT18_103-ZPNAME, "####

         ZDEPCODE          LIKE ZEDT18_102-ZDEPCODE, "####

         ZDEPCODE_NAME(10), "###

         ZDEPRANK_NAME(6),  "###

         ZEDATE            LIKE ZEDT18_102-ZEDATE, "###

         ZQFLAG_NAME(4), "####

         ZGENDER_NAME(4), "##

         ZADDRESS          LIKE ZEDT18_103-ZADDRESS, "##

         ZBANKCODE         LIKE ZEDT18_106-ZBANKCODE, "####

         ZBANK_NAME(10),"###

         ZACCOUNT          LIKE ZEDT18_106-ZACCOUNT, "####

       END OF GS_PERNR_ALV.

DATA : GT_PERNR_ALV LIKE TABLE OF GS_PERNR_ALV.



DATA : BEGIN OF GS_SALARY, "#######

         ZPERNR   LIKE ZEDT18_102-ZPERNR, "####

         ZPNAME   LIKE ZEDT18_103-ZPNAME, "####

         ZDEPCODE LIKE ZEDT18_102-ZDEPCODE, "####

         ZDEPRANK LIKE ZEDT18_102-ZDEPRANK, "##

         ZEDATE   LIKE ZEDT18_102-ZEDATE, "###

         ZQDATE   LIKE ZEDT18_102-ZQDATE, "###

         ZQFLAG   LIKE ZEDT18_102-ZQFLAG, "####

         ZSALARY  LIKE ZEDT18_106-ZSALARY, "####

         ZPAY     LIKE ZEDT18_106-ZSALARY, "##

         ZRANK    LIKE ZEDT18_104-ZRANK, "####

       END OF GS_SALARY.

DATA : GT_SALARY LIKE TABLE OF GS_SALARY.



DATA : BEGIN OF GS_SALARY_ALV, "####### ALV ###

         ZPERNR            LIKE ZEDT18_102-ZPERNR, "####

         ZPNAME            LIKE ZEDT18_103-ZPNAME, "####

         ZDEPCODE          LIKE ZEDT18_102-ZDEPCODE, "####

         ZDEPCODE_NAME(10), "###

         ZDEPRANK_NAME(6),  "###

         ZEDATE            LIKE ZEDT18_102-ZEDATE, "###

         ZSALARY           LIKE ZEDT18_106-ZSALARY, "####

         ZRANK             LIKE ZEDT18_104-ZRANK, "####

         ZMON              LIKE ZEDT18_105-ZMON01, "##

       END OF GS_SALARY_ALV.

DATA : GT_SALARY_ALV LIKE TABLE OF GS_SALARY_ALV.



DATA : BEGIN OF GS_ASSESS, "#####

         ZPERNR   LIKE ZEDT18_102-ZPERNR, "####

         ZPNAME   LIKE ZEDT18_103-ZPNAME, "####

         ZDEPCODE LIKE ZEDT18_102-ZDEPCODE, "####

         ZDEPRANK LIKE ZEDT18_102-ZDEPRANK, "##

         ZEDATE   LIKE ZEDT18_102-ZEDATE, "###

         ZSALARY  LIKE ZEDT18_106-ZSALARY, "####

         ZRANK    LIKE ZEDT18_104-ZRANK, "####

       END OF GS_ASSESS.

DATA : GT_ASSESS LIKE TABLE OF GS_ASSESS.



DATA : BEGIN OF GS_ASSESS_ALV, "##### ALV ###

         ZPERNR            LIKE ZEDT18_102-ZPERNR, "####

         ZPNAME            LIKE ZEDT18_103-ZPNAME, "####

         ZDEPCODE          LIKE ZEDT18_102-ZDEPCODE, "####

         ZDEPCODE_NAME(10), "###

         ZDEPRANK_NAME(6),  "###

         ZEDATE            LIKE ZEDT18_102-ZEDATE, "###

         ZSALARY           LIKE ZEDT18_106-ZSALARY, "####

         ZRANK             LIKE ZEDT18_104-ZRANK, "####

         ZMON              LIKE ZEDT18_105-ZMON01, "##

       END OF GS_ASSESS_ALV.

DATA : GT_ASSESS_ALV LIKE TABLE OF GS_ASSESS_ALV.



DATA : GV_YEAR(4), GV_MONTH(2) TYPE N.

DATA : GV_CHECK. "## #### # ####. SY-SUBRC# ##. ## CLEAR, ## ## # 'X'



" ## ## ##

FIELD-SYMBOLS <FS_Y> LIKE GV_YEAR.

FIELD-SYMBOLS <FS_M> LIKE GV_MONTH.

FIELD-SYMBOLS <FS_CH> LIKE GV_CHECK.



ASSIGN GV_YEAR TO <FS_Y>.

ASSIGN GV_MONTH TO <FS_M>.

ASSIGN GV_CHECK TO <FS_CH>.



" ## #### ##

DATA : GS_FIELDCAT TYPE SLIS_FIELDCAT_ALV.

DATA : GT_FIELDCAT TYPE SLIS_T_FIELDCAT_ALV.

DATA : GS_LAYOUT TYPE SLIS_LAYOUT_ALV.

DATA : GS_SORT TYPE SLIS_SORTINFO_ALV.

DATA : GT_SORT TYPE SLIS_T_SORTINFO_ALV.



" ### ###

SELECTION-SCREEN BEGIN OF BLOCK B1 WITH FRAME.

SELECT-OPTIONS : S_ZPERNR FOR ZEDT18_102-ZPERNR.

SELECT-OPTIONS : S_DATE FOR ZEDT18_102-DATBI NO-EXTENSION MODIF ID M1. " ####

SELECT-OPTIONS : S_ZDEP FOR ZEDT18_102-ZDEPCODE NO INTERVALS NO-EXTENSION MODIF ID M1.

PARAMETERS : P_YEAR LIKE ZEDT18_105-ZYEAR DEFAULT SY-DATUM+0(4) MODIF ID M2. "####/####

PARAMETERS : P_MONTH(2) DEFAULT SY-DATUM+4(2) MODIF ID M2. " TEXT ####.

SELECTION-SCREEN END OF BLOCK B1.



SELECTION-SCREEN BEGIN OF BLOCK B2 WITH FRAME.

PARAMETERS : P_R1 RADIOBUTTON GROUP R1 DEFAULT 'X' USER-COMMAND UC1.

PARAMETERS : P_R2 RADIOBUTTON GROUP R1.

PARAMETERS : P_R3 RADIOBUTTON GROUP R1.

SELECTION-SCREEN END OF BLOCK B2.



SELECTION-SCREEN BEGIN OF BLOCK B3 WITH FRAME.

PARAMETERS : P_CH1 AS CHECKBOX DEFAULT 'X' MODIF ID M1.

SELECTION-SCREEN END OF BLOCK B3.



INITIALIZATION.

  PERFORM SET_DATE.



AT SELECTION-SCREEN OUTPUT.

  PERFORM SET_SCREEN.





START-OF-SELECTION. "### ####

  PERFORM CHECK_DATA. "### ### # ##.



  CASE C_X.

    WHEN P_R1. " ####

      PERFORM SELECT_DATA_R1.

      IF GT_PERNR[] IS INITIAL.

        MESSAGE I001.

        EXIT.

      ENDIF.

      PERFORM MODIFY_DATA_R1.

      PERFORM ALV_DISPLAY_R1.

    WHEN P_R2. "####

      PERFORM SELECT_DATA_R2.

      IF GT_SALARY[] IS INITIAL.

        MESSAGE I001.

        EXIT.

      ENDIF.

      PERFORM MODIFY_DATA_R2.

      PERFORM ALV_DISPLAY_R2.

    WHEN P_R3. "####

      PERFORM SELECT_DATA_R3.

      IF GT_ASSESS[] IS INITIAL.

        MESSAGE I001.

        EXIT.

      ENDIF.

      PERFORM MODIFY_DATA_R3.

      PERFORM ALV_DISPLAY_R3.

  ENDCASE.



END-OF-SELECTION. "###

  CHECK P_R2 = C_X.

  IF <FS_CH> = C_X.

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

    IF P_R1 = C_X.

      IF SCREEN-GROUP1 = 'M2'.

        SCREEN-ACTIVE = C_0.

      ENDIF.

    ELSE.

      IF SCREEN-GROUP1 = 'M1'.

        SCREEN-ACTIVE = C_0.

      ENDIF.

    ENDIF.

    MODIFY SCREEN.

  ENDLOOP.

ENDFORM.




*&---------------------------------------------------------------------*

*&      Form  CHECK_DATA

*&---------------------------------------------------------------------*




FORM CHECK_DATA .

  "#### ##

  IF P_R1 = C_X.

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

  IF <FS_Y> IS ASSIGNED.

    CLEAR <FS_Y>.

    <FS_Y> = P_YEAR.

  ENDIF.

  IF <FS_M> IS ASSIGNED.

    CLEAR <FS_M>.

    <FS_M> = P_MONTH.

  ENDIF.

  IF <FS_CH> IS ASSIGNED.

    CLEAR <FS_CH>.

  ENDIF.



ENDFORM.




*&---------------------------------------------------------------------*

*&      Form  SELECT_DATA_R1

*&---------------------------------------------------------------------*




FORM SELECT_DATA_R1 .



  CLEAR R_FLAG.

  "RANGE ## # ## -> PERFORM## #### # ##?

  R_FLAG-SIGN = C_I.

  R_FLAG-OPTION = C_EQ.

  R_FLAG-LOW = ''.

  APPEND R_FLAG.

  IF P_CH1 NE C_X. "## + ### #

    R_FLAG-LOW = 'X'.

    APPEND R_FLAG.

  ENDIF.



  SELECT A~ZPERNR "####

       B~ZPNAME "####

       A~ZDEPCODE "####

       A~ZDEPRANK "####

       A~ZEDATE "###

       A~ZQFLAG "####

       B~ZGENDER "##

       B~ZADDRESS "##

       C~ZBANKCODE "####

       C~ZACCOUNT "####

  INTO CORRESPONDING FIELDS OF TABLE GT_PERNR

  FROM ZEDT18_102 AS A INNER JOIN ZEDT18_103 AS B ON A~ZPERNR = B~ZPERNR

  INNER JOIN ZEDT18_106 AS C ON A~ZPERNR = C~ZPERNR

  WHERE A~ZPERNR IN S_ZPERNR

  AND A~DATBI <= S_DATE-HIGH

  AND A~DATAB > S_DATE-HIGH

  AND A~ZDEPCODE IN S_ZDEP

  AND A~ZQFLAG IN R_FLAG.



ENDFORM.




*&---------------------------------------------------------------------*

*&      Form  MODIFY_DATA_R1

*&---------------------------------------------------------------------*




FORM MODIFY_DATA_R1 .



  FIELD-SYMBOLS: <FS_A> LIKE GS_PERNR_ALV.

  ASSIGN GS_PERNR_ALV TO <FS_A>.



  LOOP AT GT_PERNR ASSIGNING FIELD-SYMBOL(<FS_P>).



    MOVE-CORRESPONDING <FS_P> TO <FS_A>.



    PERFORM MAKE_DEPCODE USING <FS_A>-ZDEPCODE

                         CHANGING <FS_A>-ZDEPCODE_NAME.

    PERFORM MAKE_RANK USING <FS_P>-ZDEPRANK

                      CHANGING <FS_A>-ZDEPRANK_NAME.



    IF <FS_P>-ZQFLAG = C_X.

      <FS_A>-ZQFLAG_NAME = '##'.

    ELSE.

      <FS_A>-ZQFLAG_NAME = '##'.

    ENDIF.



    IF <FS_P>-ZGENDER = 'M'.

      <FS_A>-ZGENDER_NAME = '##'.

    ELSEIF <FS_P>-ZGENDER = 'F'.

      <FS_A>-ZGENDER_NAME = '##'.

    ENDIF.



    PERFORM MAKE_BANKCODE USING <FS_P>-ZBANKCODE

                          CHANGING <FS_A>-ZBANK_NAME.



    APPEND <FS_A> TO GT_PERNR_ALV.

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



  DATA : LV_DATE LIKE ZEDT18_102-DATBI.

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

    FROM ZEDT18_102 AS A INNER JOIN ZEDT00_103 AS B

    ON A~ZPERNR = B~ZPERNR

    INNER JOIN ZEDT18_104 AS C ON A~ZPERNR = C~ZPERNR

    INNER JOIN ZEDT18_106 AS D ON A~ZPERNR = D~ZPERNR

    WHERE A~ZPERNR IN S_ZPERNR

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



  LOOP AT GT_SALARY ASSIGNING FIELD-SYMBOL(<FS_S>).

    IF <FS_S>-ZQFLAG = C_X.

      IF <FS_S>-ZQDATE+0(6) <= LV_DATE2.

        CONTINUE.

      ENDIF.

    ENDIF.



    <FS_S>-ZPAY = <FS_S>-ZSALARY / 12.

    IF <FS_S>-ZRANK = 'A'.

      <FS_S>-ZPAY = <FS_S>-ZPAY + '500.00'.

    ENDIF.



    CHECK <FS_S>-ZPAY NE 0.



    PERFORM UPDATE_PAY USING <FS_Y> <FS_M>

                             <FS_S>-ZPERNR

                             <FS_S>-ZPAY

                       CHANGING <FS_CH>.

    IF <FS_CH> = C_X.

      STOP.

    ENDIF.



    FIELD-SYMBOLS: <FS_A> LIKE GS_SALARY_ALV.

    ASSIGN GS_SALARY_ALV TO <FS_A>.



    MOVE-CORRESPONDING <FS_S> TO <FS_A>.



    PERFORM GET_PAY USING <FS_Y> <FS_M> <FS_A>-ZPERNR CHANGING <FS_A>-ZMON.



    PERFORM MAKE_DEPCODE USING <FS_A>-ZDEPCODE CHANGING <FS_A>-ZDEPCODE_NAME.

    PERFORM MAKE_RANK USING <FS_S>-ZDEPRANK CHANGING <FS_A>-ZDEPRANK_NAME.



    IF <FS_A>-ZMON NE 0.

      APPEND <FS_A> TO GT_SALARY_ALV.

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




*         A~ZQFLAG "####




         C~ZRANK "####

         D~ZSALARY "####

    INTO CORRESPONDING FIELDS OF TABLE GT_ASSESS

    FROM ZEDT18_102 AS A  INNER JOIN ZEDT18_103 AS B

    ON A~ZPERNR = B~ZPERNR

    INNER JOIN ZEDT18_104 AS C

    ON A~ZPERNR = C~ZPERNR

    INNER JOIN ZEDT18_106 AS D

    ON A~ZPERNR = D~ZPERNR

    WHERE A~ZPERNR IN S_ZPERNR




*    AND   A~ZQFLAG NE C_X




    AND   C~ZYEAR = P_YEAR

    AND   D~ZYEAR = P_YEAR.



ENDFORM.




*&---------------------------------------------------------------------*

*&      Form  MODIFY_DATA_R3

*&---------------------------------------------------------------------*




FORM MODIFY_DATA_R3.



  FIELD-SYMBOLS: <FS_ALV> LIKE GS_ASSESS_ALV.

  ASSIGN GS_ASSESS_ALV TO <FS_ALV>.



  LOOP AT GT_ASSESS ASSIGNING FIELD-SYMBOL(<FS_A>).

    CLEAR : <FS_ALV>.

    MOVE-CORRESPONDING <FS_A> TO <FS_ALV>.



    PERFORM GET_PAY USING <FS_Y> <FS_M> <FS_ALV>-ZPERNR CHANGING <FS_ALV>-ZMON.



    PERFORM MAKE_DEPCODE USING <FS_ALV>-ZDEPCODE CHANGING <FS_ALV>-ZDEPCODE_NAME.

    PERFORM MAKE_RANK USING <FS_A>-ZDEPRANK CHANGING <FS_ALV>-ZDEPRANK_NAME.



    IF <FS_ALV>-ZMON NE 0.

      APPEND <FS_ALV> TO GT_ASSESS_ALV.

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

*&      Form  MAKE_DEPCODE

*&---------------------------------------------------------------------*




FORM MAKE_DEPCODE USING P_ZEDPCODE CHANGING P_ZEDPCODE_NAME.

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




FORM MAKE_RANK USING P_RANK CHANGING P_RANK_NAME.



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

*&      Form  MAKE_BANKCODE

*&---------------------------------------------------------------------*




FORM MAKE_BANKCODE USING P_BANKCODE CHANGING P_BANKNAME.

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




FORM GET_PAY USING PV_YEAR PV_MON P_ZPERNR

                   CHANGING P_ZMONTH.



  CASE PV_MON.

    WHEN '01'.

      SELECT SINGLE ZMON01 FROM ZEDT18_105 INTO P_ZMONTH

        WHERE ZPERNR = P_ZPERNR

        AND ZYEAR = PV_YEAR.

    WHEN '02'.

      SELECT SINGLE ZMON02 FROM ZEDT18_105 INTO P_ZMONTH

        WHERE ZPERNR = P_ZPERNR

        AND ZYEAR = PV_YEAR.

    WHEN '03'.

      SELECT SINGLE ZMON03 FROM ZEDT18_105 INTO P_ZMONTH

        WHERE ZPERNR = P_ZPERNR

        AND ZYEAR = PV_YEAR.

    WHEN '04'.

      SELECT SINGLE ZMON04 FROM ZEDT18_105 INTO P_ZMONTH

        WHERE ZPERNR = P_ZPERNR

        AND ZYEAR = PV_YEAR.

    WHEN '05'.

      SELECT SINGLE ZMON05 FROM ZEDT18_105 INTO P_ZMONTH

        WHERE ZPERNR = P_ZPERNR

        AND ZYEAR = PV_YEAR.

    WHEN '06'.

      SELECT SINGLE ZMON06 FROM ZEDT18_105 INTO P_ZMONTH

        WHERE ZPERNR = P_ZPERNR

        AND ZYEAR = PV_YEAR.

    WHEN '07'.

      SELECT SINGLE ZMON07 FROM ZEDT18_105 INTO P_ZMONTH

        WHERE ZPERNR = P_ZPERNR

        AND ZYEAR = PV_YEAR.

    WHEN '08'.

      SELECT SINGLE ZMON08 FROM ZEDT18_105 INTO P_ZMONTH

        WHERE ZPERNR = P_ZPERNR

        AND ZYEAR = PV_YEAR.

    WHEN '09'.

      SELECT SINGLE ZMON09 FROM ZEDT18_105 INTO P_ZMONTH

        WHERE ZPERNR = P_ZPERNR

        AND ZYEAR = PV_YEAR.

    WHEN '10'.

      SELECT SINGLE ZMON10 FROM ZEDT18_105 INTO P_ZMONTH

        WHERE ZPERNR = P_ZPERNR

        AND ZYEAR = PV_YEAR.

    WHEN '11'.

      SELECT SINGLE ZMON11 FROM ZEDT18_105 INTO P_ZMONTH

        WHERE ZPERNR = P_ZPERNR

        AND ZYEAR = PV_YEAR.

    WHEN '012'.

      SELECT SINGLE ZMON12 FROM ZEDT18_105 INTO P_ZMONTH

        WHERE ZPERNR = P_ZPERNR

        AND ZYEAR = PV_YEAR.

  ENDCASE.



ENDFORM.




*&---------------------------------------------------------------------*

*&      Form  UPDATE_PAY

*&---------------------------------------------------------------------*




FORM UPDATE_PAY USING PV_YEAR PV_MONTH P_ZPERNR P_ZPAY

                CHANGING PV_CHECK.



  CASE PV_MONTH.

    WHEN '01'.

      UPDATE ZEDT18_105 SET ZMON01 = P_ZPAY

      WHERE ZPERNR = P_ZPERNR

      AND   ZYEAR = PV_YEAR.



      IF SY-SUBRC NE 0.

        PV_CHECK = C_X.

      ENDIF.

    WHEN '02'.

      UPDATE ZEDT18_105 SET ZMON02 = P_ZPAY

      WHERE ZPERNR = P_ZPERNR

      AND   ZYEAR = PV_YEAR.



      IF SY-SUBRC NE 0.

        PV_CHECK = C_X.

      ENDIF.

    WHEN '03'.

      UPDATE ZEDT18_105 SET ZMON03 = P_ZPAY

      WHERE ZPERNR = P_ZPERNR

      AND   ZYEAR = PV_YEAR.



      IF SY-SUBRC NE 0.

        PV_CHECK = C_X.

      ENDIF.

    WHEN '04'.

      UPDATE ZEDT18_105 SET ZMON04 = P_ZPAY

      WHERE ZPERNR = P_ZPERNR

      AND   ZYEAR = PV_YEAR.



      IF SY-SUBRC NE 0.

        PV_CHECK = C_X.

      ENDIF.

    WHEN '05'.

      UPDATE ZEDT18_105 SET ZMON05 = P_ZPAY

      WHERE ZPERNR = P_ZPERNR

      AND   ZYEAR = PV_YEAR.



      IF SY-SUBRC NE 0.

        PV_CHECK = C_X.

      ENDIF.

    WHEN '06'.

      UPDATE ZEDT18_105 SET ZMON06 = P_ZPAY

      WHERE ZPERNR = P_ZPERNR

      AND   ZYEAR = PV_YEAR.



      IF SY-SUBRC NE 0.

        PV_CHECK = C_X.

      ENDIF.

    WHEN '07'.

      UPDATE ZEDT18_105 SET ZMON07 = P_ZPAY

      WHERE ZPERNR = P_ZPERNR

      AND   ZYEAR = PV_YEAR.



      IF SY-SUBRC NE 0.

        PV_CHECK = C_X.

      ENDIF.

    WHEN '08'.

      UPDATE ZEDT18_105 SET ZMON08 = P_ZPAY

      WHERE ZPERNR = P_ZPERNR

      AND   ZYEAR = PV_YEAR.



      IF SY-SUBRC NE 0.

        PV_CHECK = C_X.

      ENDIF.

    WHEN '09'.

      UPDATE ZEDT18_105 SET ZMON09 = P_ZPAY

      WHERE ZPERNR = P_ZPERNR

      AND   ZYEAR = PV_YEAR.



      IF SY-SUBRC NE 0.

        PV_CHECK = C_X.

      ENDIF.

    WHEN '10'.

      UPDATE ZEDT18_105 SET ZMON10 = P_ZPAY

      WHERE ZPERNR = P_ZPERNR

      AND   ZYEAR = PV_YEAR.



      IF SY-SUBRC NE 0.

        PV_CHECK = C_X.

      ENDIF.

    WHEN '11'.

      UPDATE ZEDT18_105 SET ZMON11 = P_ZPAY

      WHERE ZPERNR = P_ZPERNR

      AND   ZYEAR = PV_YEAR.



      IF SY-SUBRC NE 0.

        PV_CHECK = C_X.

      ENDIF.

    WHEN '12'.

      UPDATE ZEDT18_105 SET ZMON12 = P_ZPAY

      WHERE ZPERNR = P_ZPERNR

      AND   ZYEAR = PV_YEAR.



      IF SY-SUBRC NE 0.

        PV_CHECK = C_X.

      ENDIF.

  ENDCASE.



ENDFORM.