
*&---------------------------------------------------------------------*

*& Report ZEDR13_PRACTICE007

*&---------------------------------------------------------------------*

*&

*&---------------------------------------------------------------------*




REPORT ZEDR13_PRACTICE007 MESSAGE-ID ZMED13.



DATA : BEGIN OF GS_PERINFO,             "#######"

  ZPERNR TYPE ZEDT13_102-ZPERNR,        "####"

  ZPNAME TYPE ZEDT13_103-ZPNAME,        "####"

  ZDEPCODE TYPE ZEDT13_104-ZDEPCODE,    "####"

  ZDEPRANK TYPE ZEDT13_102-ZDEPRANK,    "####"

  ZEDATE TYPE ZEDT13_102-ZEDATE,        "###"

  ZQFLAG TYPE ZEDT13_102-ZQFLAG,        "####"

  ZGENDER TYPE ZEDT13_103-ZGENDER,      "##"

  ZADDRESS TYPE ZEDT13_103-ZADDRESS,    "##"

  ZBANKCODE TYPE ZEDT13_106-ZBANKCODE,  "####"

  ZACCOUNT TYPE ZEDT13_106-ZACCOUNT,    "####"

  END OF GS_PERINFO.

 DATA : GT_PERINFO LIKE TABLE OF GS_PERINFO.



DATA : BEGIN OF GS_WPERINFO,            "#######"

  ZPERNR TYPE ZEDT13_102-ZPERNR,        "####"

  ZPNAME TYPE ZEDT13_103-ZPNAME,        "####"

  ZDEPCODE TYPE ZEDT13_104-ZDEPCODE,    "####"

  ZDEPNAME TYPE C LENGTH 6,             "### <- ####"

  ZDEPRANK TYPE C LENGTH 3,             "### <- ####"

  ZEDATE TYPE ZEDT13_102-ZEDATE,        "###"

  ZQSATUS TYPE C LENGTH 3,              "#### <- ####"

  ZGENDER TYPE C LENGTH 3,              "#/# <- ##"

  ZADDRESS TYPE ZEDT13_103-ZADDRESS,    "##"

  ZBANKCODE TYPE ZEDT13_106-ZBANKCODE,  "####"

  ZBANKNAME TYPE C LENGTH 4,            "### <- ####"

  ZACCOUNT TYPE ZEDT13_106-ZACCOUNT,    "####"

  END OF GS_WPERINFO.

 DATA : GT_WPERINFO LIKE TABLE OF GS_WPERINFO.



 DATA : GS_SALARY TYPE ZEDT13_105.      "#####"

 DATA : GT_SALARY LIKE TABLE OF GS_SALARY.



 DATA : BEGIN OF GS_EVALCHECK,          "#######"

  ZPERNR TYPE ZEDT13_102-ZPERNR,        "####"

  ZPNAME TYPE ZEDT13_103-ZPNAME,        "####"

  ZDEPCODE TYPE ZEDT13_104-ZDEPCODE,    "####"

  ZDEPRANK TYPE ZEDT13_102-ZDEPRANK,    "####"

  ZEDATE TYPE ZEDT13_102-ZEDATE,        "###"

  ZSALARY TYPE ZEDT13_106-ZSALARY,      "####"

  ZRANK TYPE ZEDT13_104-ZRANK,          "####"

  ZYEAR TYPE ZEDT13_104-ZYEAR,          "####"

  ZMON TYPE ZEDT13_105-ZMON01,          "O# ###"

  END OF GS_EVALCHECK.

 DATA : GT_EVALCHECK LIKE TABLE OF GS_EVALCHECK.



 DATA : BEGIN OF GS_WEVALCHECK,         "#######"

  ZPERNR TYPE ZEDT13_102-ZPERNR,        "####"

  ZPNAME TYPE ZEDT13_103-ZPNAME,        "####"

  ZDEPCODE TYPE ZEDT13_104-ZDEPCODE,    "####"

  ZDEPNAME TYPE C LENGTH 6,             "### <- ####"

  ZDEPRANK TYPE C LENGTH 3,             "### <- ####"

  ZEDATE TYPE ZEDT13_102-ZEDATE,        "###"

  ZSALARY TYPE ZEDT13_106-ZSALARY,      "####"

  ZRANK TYPE ZEDT13_104-ZRANK,          "####"

  ZMON TYPE ZEDT13_105-ZMON01,          "O# ###"

   END OF GS_WEVALCHECK.

 DATA : GT_WEVALCHECK LIKE TABLE OF GS_WEVALCHECK.



RANGES : R_QFG FOR ZEDT13_102-ZQFLAG. "## ### ## ## ### ##### ### ##"



DATA : GS_FIELDCAT TYPE SLIS_FIELDCAT_ALV, "ALV FIELDCAT"

       GT_FIELDCAT TYPE SLIS_T_FIELDCAT_ALV.



DATA : GS_LAYOUT TYPE SLIS_LAYOUT_ALV. "ALV LAYOUT"



DATA : GS_SORT TYPE SLIS_SORTINFO_ALV. "ALV SORT"

DATA : GT_SORT TYPE SLIS_T_SORTINFO_ALV.



DATA : LV_SUBRC TYPE I. "UPDATE ### ## ##"



CONSTANTS : C_X TYPE CHAR1 VALUE 'X'.

CONSTANTS : C_A TYPE CHAR1 VALUE 'A'.

CONSTANTS : C_B TYPE CHAR1 VALUE 'B'.

CONSTANTS : C_C TYPE CHAR1 VALUE 'C'.

CONSTANTS : C_D TYPE CHAR1 VALUE 'D'.

CONSTANTS : C_E TYPE CHAR1 VALUE 'E'.

CONSTANTS : C_F TYPE CHAR1 VALUE 'F'.

CONSTANTS : C_G TYPE CHAR1 VALUE 'G'.

CONSTANTS : C_01 TYPE CHAR2 VALUE '01'.

CONSTANTS : C_02 TYPE CHAR2 VALUE '02'.

CONSTANTS : C_03 TYPE CHAR2 VALUE '03'.

CONSTANTS : C_04 TYPE CHAR2 VALUE '04'.

CONSTANTS : C_05 TYPE CHAR2 VALUE '05'.

CONSTANTS : C_06 TYPE CHAR2 VALUE '06'.

CONSTANTS : C_07 TYPE CHAR2 VALUE '07'.

CONSTANTS : C_08 TYPE CHAR2 VALUE '08'.

CONSTANTS : C_09 TYPE CHAR2 VALUE '09'.

CONSTANTS : C_10 TYPE CHAR2 VALUE '10'.

CONSTANTS : C_11 TYPE CHAR2 VALUE '11'.

CONSTANTS : C_12 TYPE CHAR2 VALUE '12'.

CONSTANTS : C_SS1 TYPE CHAR6 VALUE 'SS0001'.

CONSTANTS : C_SS2 TYPE CHAR3 VALUE 'SS0002'.

CONSTANTS : C_SS3 TYPE CHAR3 VALUE 'SS0003'.

CONSTANTS : C_SS4 TYPE CHAR3 VALUE 'SS0004'.

CONSTANTS : C_SS5 TYPE CHAR3 VALUE 'SS0005'.

CONSTANTS : C_SS6 TYPE CHAR3 VALUE 'SS0006'.



TABLES : ZEDT13_102.



SELECTION-SCREEN BEGIN OF BLOCK B1 WITH FRAME.

  SELECT-OPTIONS : S_PERNR FOR ZEDT13_102-ZPERNR.                                       "####"

  SELECT-OPTIONS : S_DATE FOR ZEDT13_102-ZEDATE NO-EXTENSION MODIF ID M1.               "##"

  SELECT-OPTIONS : S_DEP FOR ZEDT13_102-ZDEPCODE NO INTERVALS NO-EXTENSION MODIF ID M1. "####"

  PARAMETERS P_YEAR TYPE GJAHR MODIF ID M2 DEFAULT SY-DATUM(4).                         "##"

  PARAMETERS P_MONTH TYPE MONAT MODIF ID M2 DEFAULT SY-DATUM+4(2).                      "#"

SELECTION-SCREEN END OF BLOCK B1.



SELECTION-SCREEN BEGIN OF BLOCK B2 WITH FRAME.                                          "#### ## USER EVENT ####"

  PARAMETERS P1 RADIOBUTTON GROUP R1 DEFAULT 'X' USER-COMMAND UC1.                      "####"

  PARAMETERS P2 RADIOBUTTON GROUP R1.                                                   "####"

  PARAMETERS P3 RADIOBUTTON GROUP R1.                                                   "####"

SELECTION-SCREEN END OF BLOCK B2.



SELECTION-SCREEN BEGIN OF BLOCK B3 WITH FRAME.

  PARAMETERS P4 AS CHECKBOX DEFAULT 'X' MODIF ID M1.                                    "####"

SELECTION-SCREEN END OF BLOCK B3.



FIELD-SYMBOLS: <FS_MONTH_SALARY> TYPE ANY. "#### ## FS ##"

DATA(LV_MON_FIELD) = |ZMON{ P_MONTH }|. "#### ZMON01~12# ## ##"



INITIALIZATION.

  PERFORM SET_DATE.         "S_DATE, ## ##"

START-OF-SELECTION.

  IF P1 = C_X.

    PERFORM SET_FG.         "##### ## -> ## ### ##"

    PERFORM GET_PERDATA.    "#### ##"

    PERFORM MODIFY_PERDATA. "#### ##### ##"

  ELSEIF P2 = C_X.

    PERFORM GET_EVALCHECK.

    PERFORM UPDATE_SALARY CHANGING LV_SUBRC.

    IF LV_SUBRC = 0.

      MESSAGE S002. "###"

    ELSE.

      MESSAGE E003. "###"

    ENDIF.

  ELSEIF P3 = C_X.

    PERFORM GET_EVALCHECK.

    PERFORM MODIFY_EVALCHECK.

  ENDIF.

AT SELECTION-SCREEN.

  IF P1 = C_X.

    IF S_DATE IS INITIAL.

      MESSAGE E000.

    ENDIF.

  ELSEIF P2 = C_X OR P3 = C_X.

    IF P_YEAR IS INITIAL OR P_MONTH IS INITIAL.

      MESSAGE E000.

    ENDIF.

  ENDIF.

AT SELECTION-SCREEN OUTPUT.

  PERFORM DISPLAY.

END-OF-SELECTION.

  PERFORM ALV_DISPLAY.




*&---------------------------------------------------------------------*

*&      Form  SET_DATE

*&---------------------------------------------------------------------*

*       text

*----------------------------------------------------------------------*

*  -->  p1        text

*  <--  p2        text

*----------------------------------------------------------------------*




FORM SET_DATE.

  S_DATE-SIGN   = 'I'.

  S_DATE-OPTION = 'BT'.

  S_DATE-LOW = SY-DATUM(4) && '0101'.         "## ### ### ###"

  CALL FUNCTION 'RP_LAST_DAY_OF_MONTHS'

    EXPORTING

      DAY_IN                  = S_DATE-LOW    "1### ###"

    IMPORTING

      LAST_DAY_OF_MONTH       = S_DATE-HIGH.  "1### ##"

  APPEND S_DATE.

ENDFORM.




*&---------------------------------------------------------------------*

*&      Form  SET_FG

*&---------------------------------------------------------------------*

*       text

*----------------------------------------------------------------------*

*  -->  p1        text

*  <--  p2        text

*----------------------------------------------------------------------*




FORM SET_FG .

  IF P1 = 'X'. "######"

    R_QFG-SIGN = 'I'. "## ##"

    R_QFG-OPTION = 'EQ'. "LOW# ## #### ## ##"

    R_QFG-LOW = ' '. "#### ##"

    APPEND R_QFG.

    IF P4 = ' '.     "### ######"

      R_QFG-LOW = C_X. "##### ##"

      APPEND R_QFG.

    ENDIF.

  ENDIF.

ENDFORM.




*&---------------------------------------------------------------------*

*&      Form  GET_PERDATA

*&---------------------------------------------------------------------*

*       text

*----------------------------------------------------------------------*

*  -->  p1        text

*  <--  p2        text

*----------------------------------------------------------------------*




FORM GET_PERDATA.

  SELECT *

    FROM ZEDT13_102 AS A

    INNER JOIN ZEDT13_103 AS B ON A~ZPERNR = B~ZPERNR

    INNER JOIN ZEDT13_106 AS C ON A~ZPERNR = C~ZPERNR

    WHERE A~ZPERNR IN @S_PERNR

    AND A~DATBI >= @S_DATE-LOW  "##### #### <= #### ###"

    AND A~ZEDATE < @S_DATE-HIGH "#### < ##### ##"

    AND A~DATAB > @S_DATE-HIGH  "##### ## < #### ##, #### 11## ##(##) ##### 3# 31###### ### ##### + ### ## ##### 9999.12.31###"

    AND A~ZDEPCODE IN @S_DEP    "####"

    AND A~ZQFLAG IN @R_QFG      "## ### ## ####"

    INTO CORRESPONDING FIELDS OF TABLE @GT_PERINFO.

ENDFORM.




*&---------------------------------------------------------------------*

*&      Form  MODIFY_PERDATA

*&---------------------------------------------------------------------*

*       text

*----------------------------------------------------------------------*

*  -->  p1        text

*  <--  p2        text

*----------------------------------------------------------------------*




FORM MODIFY_PERDATA .

  IF GT_PERINFO IS NOT INITIAL. "GET_DATA## ## ### ## ##"

    LOOP AT GT_PERINFO INTO GS_PERINFO.

      MOVE-CORRESPONDING GS_PERINFO TO GS_WPERINFO.

      CASE GS_PERINFO-ZDEPCODE.

        WHEN C_SS1. GS_WPERINFO-ZDEPNAME = '###'.

        WHEN C_SS2. GS_WPERINFO-ZDEPNAME = '###'.

        WHEN C_SS3. GS_WPERINFO-ZDEPNAME = '###'.

        WHEN C_SS4. GS_WPERINFO-ZDEPNAME = '###'.

        WHEN C_SS5. GS_WPERINFO-ZDEPNAME = '###'.

        WHEN C_SS6. GS_WPERINFO-ZDEPNAME = '###'.

      ENDCASE.

      CASE GS_PERINFO-ZDEPRANK.

        WHEN C_A. GS_WPERINFO-ZDEPRANK = '##'.

        WHEN C_B. GS_WPERINFO-ZDEPRANK = '##'.

        WHEN C_C. GS_WPERINFO-ZDEPRANK = '##'.

        WHEN C_D. GS_WPERINFO-ZDEPRANK = '##'.

        WHEN C_E. GS_WPERINFO-ZDEPRANK = '##'.

        WHEN C_F. GS_WPERINFO-ZDEPRANK = '##'.

        WHEN C_G. GS_WPERINFO-ZDEPRANK = '##'.

      ENDCASE.

      CASE GS_PERINFO-ZQFLAG.

        WHEN ' '.

          GS_WPERINFO-ZQSATUS = '##'.

        WHEN C_X.

          GS_WPERINFO-ZQSATUS = '##'.

      ENDCASE.

      CASE GS_PERINFO-ZGENDER.

        WHEN 'M'.

          GS_WPERINFO-ZGENDER = '##'.

        WHEN 'F'.

          GS_WPERINFO-ZGENDER = '##'.

      ENDCASE.

      CASE GS_PERINFO-ZBANKCODE.

        WHEN '001'. GS_WPERINFO-ZBANKNAME = '##'.

        WHEN '002'. GS_WPERINFO-ZBANKNAME = '##'.

        WHEN '003'. GS_WPERINFO-ZBANKNAME = '##'.

        WHEN '004'. GS_WPERINFO-ZBANKNAME = '##'.

        WHEN '005'. GS_WPERINFO-ZBANKNAME = '###'.

       ENDCASE.

      APPEND GS_WPERINFO TO GT_WPERINFO.

    ENDLOOP.

  ENDIF.

ENDFORM.




*&---------------------------------------------------------------------*

*&      Form  GET_EVALCHECK

*&---------------------------------------------------------------------*

*       text

*----------------------------------------------------------------------*

*  -->  p1        text

*  <--  p2        text

*----------------------------------------------------------------------*




FORM GET_EVALCHECK.

DATA: LV_YEAR_DAY TYPE DATUM,  "## ### ##"

      LV_FIRST_DAY TYPE DATUM, "## ## ## ### #"

      LV_LAST_DAY TYPE DATUM.  "## ## ## ### #"



  LV_YEAR_DAY = P_YEAR && '0101'.

  LV_FIRST_DAY = P_YEAR && P_MONTH && '01'.



  CALL FUNCTION 'RP_LAST_DAY_OF_MONTHS'

  EXPORTING

    DAY_IN                  = LV_FIRST_DAY

  IMPORTING

    LAST_DAY_OF_MONTH       = LV_LAST_DAY.



  SELECT *

    FROM ZEDT13_102 AS A

    INNER JOIN ZEDT13_103 AS B ON A~ZPERNR = B~ZPERNR

    INNER JOIN ZEDT13_104 AS C ON A~ZPERNR = C~ZPERNR

    INNER JOIN ZEDT13_106 AS D ON A~ZPERNR = D~ZPERNR

    WHERE A~ZPERNR IN @S_PERNR

    AND A~DATBI >= @LV_YEAR_DAY  "##### ## <= #### ###"

    AND A~ZEDATE < @LV_LAST_DAY  "#### < #### ## ##"

    AND A~DATAB > @LV_LAST_DAY   "#### ## ## < #### ##"

    INTO CORRESPONDING FIELDS OF TABLE @GT_EVALCHECK.



  IF P3 = 'X'.



    SELECT * FROM ZEDT13_105 "ZET13_105## ### GT_SALARY# ###"

      INTO TABLE GT_SALARY.



    LOOP AT GT_EVALCHECK INTO GS_EVALCHECK.

      READ TABLE GT_SALARY INTO GS_SALARY WITH KEY ZPERNR = GS_EVALCHECK-ZPERNR.



      "GS_SALARY ### ### LV_MON_FIELD ### #### ### <FS_MONTH_SALARY># ##"

      ASSIGN COMPONENT LV_MON_FIELD OF STRUCTURE GS_SALARY TO <FS_MONTH_SALARY>.

      GS_EVALCHECK-ZMON = <FS_MONTH_SALARY>. "### CASE# ## ##"






*      CASE P_MONTH. "## ### ##

*        WHEN C_01. GS_EVALCHECK-ZMON = GS_SALARY-ZMON01.

*        WHEN C_02. GS_EVALCHECK-ZMON = GS_SALARY-ZMON02.

*        WHEN C_03. GS_EVALCHECK-ZMON = GS_SALARY-ZMON03.

*        WHEN C_04. GS_EVALCHECK-ZMON = GS_SALARY-ZMON04.

*        WHEN C_05. GS_EVALCHECK-ZMON = GS_SALARY-ZMON05.

*        WHEN C_06. GS_EVALCHECK-ZMON = GS_SALARY-ZMON06.

*        WHEN C_07. GS_EVALCHECK-ZMON = GS_SALARY-ZMON07.

*        WHEN C_08. GS_EVALCHECK-ZMON = GS_SALARY-ZMON08.

*        WHEN C_09. GS_EVALCHECK-ZMON = GS_SALARY-ZMON09.

*        WHEN C_10. GS_EVALCHECK-ZMON = GS_SALARY-ZMON10.

*        WHEN C_11. GS_EVALCHECK-ZMON = GS_SALARY-ZMON11.

*        WHEN C_12. GS_EVALCHECK-ZMON = GS_SALARY-ZMON12.

*      ENDCASE.






      IF GS_EVALCHECK-ZMON IS INITIAL.

        MESSAGE S001 DISPLAY LIKE 'E'.              "0# ### ##### ### ##### ##"

        CONTINUE.                                   "### ##### 0## ##"

      ENDIF.

      MODIFY GT_EVALCHECK FROM GS_EVALCHECK TRANSPORTING ZMON.

    ENDLOOP.

  ENDIF.

ENDFORM.




*&---------------------------------------------------------------------*

*&      Form  UPDATE_SALARY

*&---------------------------------------------------------------------*

*       text

*----------------------------------------------------------------------*

*  -->  p1        text

*  <--  p2        text

*----------------------------------------------------------------------*




FORM UPDATE_SALARY CHANGING LV_SUBRC TYPE I.

  DATA : LV_SALARY TYPE ZEDT13_106-ZSALARY.



  LOOP AT GT_EVALCHECK INTO GS_EVALCHECK.

    LV_SALARY = GS_EVALCHECK-ZSALARY / 12.

    IF GS_EVALCHECK-ZRANK = C_A.

      LV_SALARY = LV_SALARY + 500.

    ENDIF.



    IF LV_SALARY = 0. "### 0## ###### ###"

      STOP.

    ENDIF.



    SELECT SINGLE *      "##### ##### ### ##### ###"

      FROM ZEDT13_105    "ZEDT13_105# ## #### # ## #### ###, ### ## ###"

      INTO GS_SALARY     "GS_SALARY# ZPERNR, ZYEAR# ##### #### ##"

      WHERE ZPERNR = GS_EVALCHECK-ZPERNR

      AND ZYEAR = GS_EVALCHECK-ZYEAR.



    "GS_SALARY ### ### LV_MON_FIELD ### #### ### <FS_MONTH_SALARY># ##"

    ASSIGN COMPONENT LV_MON_FIELD OF STRUCTURE GS_SALARY TO <FS_MONTH_SALARY>.

    <FS_MONTH_SALARY> = LV_SALARY. "### CASE# ## ##"






*    CASE : P_MONTH.

*      WHEN C_01. GS_SALARY-ZMON01 = LV_SALARY.

*      WHEN C_02. GS_SALARY-ZMON02 = LV_SALARY.

*      WHEN C_03. GS_SALARY-ZMON03 = LV_SALARY.

*      WHEN C_04. GS_SALARY-ZMON04 = LV_SALARY.

*      WHEN C_05. GS_SALARY-ZMON05 = LV_SALARY.

*      WHEN C_06. GS_SALARY-ZMON06 = LV_SALARY.

*      WHEN C_07. GS_SALARY-ZMON07 = LV_SALARY.

*      WHEN C_08. GS_SALARY-ZMON08 = LV_SALARY.

*      WHEN C_09. GS_SALARY-ZMON09 = LV_SALARY.

*      WHEN C_10. GS_SALARY-ZMON10 = LV_SALARY.

*      WHEN C_11. GS_SALARY-ZMON11 = LV_SALARY.

*      WHEN C_12. GS_SALARY-ZMON12 = LV_SALARY.

*    ENDCASE.






    GS_SALARY-AENAME = SY-UNAME.        "###"

    GS_SALARY-AEDATE = SY-DATUM.        "###"

    GS_SALARY-AEZEIT = SY-UZEIT.        "####"



    UPDATE ZEDT13_105 FROM GS_SALARY.



    LV_SUBRC = SY-SUBRC.



    IF SY-SUBRC <> 0.       "#### ### ## ##"

      EXIT.

    ENDIF.

  ENDLOOP.

ENDFORM.




*&---------------------------------------------------------------------*

*&      Form  MODIFY_EVALCHECK

*&---------------------------------------------------------------------*

*       text

*----------------------------------------------------------------------*

*  -->  p1        text

*  <--  p2        text

*----------------------------------------------------------------------*




FORM MODIFY_EVALCHECK .

  IF GT_EVALCHECK IS NOT INITIAL.

    LOOP AT GT_EVALCHECK INTO GS_EVALCHECK.

      CHECK GS_EVALCHECK-ZMON IS NOT INITIAL. "### 0## ### #### ## ## ##"

      MOVE-CORRESPONDING GS_EVALCHECK TO GS_WEVALCHECK.

      CASE GS_EVALCHECK-ZDEPCODE.

        WHEN C_SS1. GS_WEVALCHECK-ZDEPNAME = '###'.

        WHEN C_SS2. GS_WEVALCHECK-ZDEPNAME = '###'.

        WHEN C_SS3. GS_WEVALCHECK-ZDEPNAME = '###'.

        WHEN C_SS4. GS_WEVALCHECK-ZDEPNAME = '###'.

        WHEN C_SS5. GS_WEVALCHECK-ZDEPNAME = '###'.

        WHEN C_SS6. GS_WEVALCHECK-ZDEPNAME = '###'.

      ENDCASE.

      APPEND GS_WEVALCHECK TO GT_WEVALCHECK.

    ENDLOOP.

  ENDIF.

ENDFORM.






*&---------------------------------------------------------------------*

*&      Form  DISPLAY

*&---------------------------------------------------------------------*

*       text

*----------------------------------------------------------------------*

*  -->  p1        text

*  <--  p2        text

*----------------------------------------------------------------------*




FORM DISPLAY.

  LOOP AT SCREEN.

    IF SCREEN-GROUP1 = 'M1'.

      IF P1 = C_X.

        SCREEN-ACTIVE = '1'.

      ELSEIF P2 = C_X OR P3 = C_X.

        SCREEN-ACTIVE = '0'.

      ENDIF.

    ELSEIF SCREEN-GROUP1 = 'M2'.

      IF P1 = C_X.

        SCREEN-ACTIVE = '0'.

      ELSEIF P2 = C_X OR P3 = C_X.

        SCREEN-ACTIVE = '1'.

      ENDIF.

    ENDIF.

    MODIFY SCREEN.

  ENDLOOP.

ENDFORM.




*&---------------------------------------------------------------------*

*&      Form  ALV_DISPLAY

*&---------------------------------------------------------------------*

*       text

*----------------------------------------------------------------------*

*  -->  p1        text

*  <--  p2        text

*----------------------------------------------------------------------*




FORM ALV_DISPLAY .

  IF P1 = C_X.

    PERFORM ALV_PERINFO.

  ELSEIF P3 = C_X AND GT_WEVALCHECK IS NOT INITIAL. "### 0### ####### #### ### ### ## ##"

    PERFORM ALV_EVALCHECK.

  ENDIF.

ENDFORM.




*&---------------------------------------------------------------------*

*&      Form  FIELDCATLOG

*&---------------------------------------------------------------------*

*       text

*----------------------------------------------------------------------*

*  -->  p1        text

*  <--  p2        text

*----------------------------------------------------------------------*




FORM ALV_PERINFO.



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

  GS_FIELDCAT-FIELDNAME = 'ZDEPNAME'.

  GS_FIELDCAT-SELTEXT_M = '###'.

  APPEND GS_FIELDCAT TO GT_FIELDCAT.





  CLEAR : GS_FIELDCAT.

  GS_FIELDCAT-COL_POS = 5.

  GS_FIELDCAT-FIELDNAME = 'ZDEPRANK'.

  GS_FIELDCAT-SELTEXT_M = '###'.

  APPEND GS_FIELDCAT TO GT_FIELDCAT.



  CLEAR : GS_FIELDCAT.

  GS_FIELDCAT-COL_POS = 6.

  GS_FIELDCAT-FIELDNAME = 'ZEDATE'.

  GS_FIELDCAT-SELTEXT_M = '###'.

  GS_FIELDCAT-OUTPUTLEN = 12.

  APPEND GS_FIELDCAT TO GT_FIELDCAT.





  CLEAR : GS_FIELDCAT.

  GS_FIELDCAT-COL_POS = 7.

  GS_FIELDCAT-FIELDNAME = 'ZQSATUS'.

  GS_FIELDCAT-SELTEXT_M = '####'.

  APPEND GS_FIELDCAT TO GT_FIELDCAT.



  CLEAR : GS_FIELDCAT.

  GS_FIELDCAT-COL_POS = 8.

  GS_FIELDCAT-FIELDNAME = 'ZGENDER'.

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



  CLEAR : GS_LAYOUT.

  GS_LAYOUT-ZEBRA = C_X.



  GS_SORT-SPOS = 1. "## ##"

  GS_SORT-FIELDNAME = 'ZPERNR'. "## ###"

  GS_SORT-UP = C_X. "#### ##"

  APPEND GS_SORT TO GT_SORT.



  CALL FUNCTION 'REUSE_ALV_GRID_DISPLAY'

  EXPORTING

   IS_LAYOUT                         =  GS_LAYOUT

   IT_FIELDCAT                       =  GT_FIELDCAT

   IT_SORT                           =  GT_SORT

  TABLES

    T_OUTTAB                          = GT_WPERINFO.

ENDFORM.




*&---------------------------------------------------------------------*

*&      Form  ALV_EVALCHECK

*&---------------------------------------------------------------------*

*       text

*----------------------------------------------------------------------*

*  -->  p1        text

*  <--  p2        text

*----------------------------------------------------------------------*




FORM ALV_EVALCHECK.



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

  GS_FIELDCAT-FIELDNAME = 'ZDEPNAME'.

  GS_FIELDCAT-SELTEXT_M = '###'.

  APPEND GS_FIELDCAT TO GT_FIELDCAT.





  CLEAR : GS_FIELDCAT.

  GS_FIELDCAT-COL_POS = 5.

  GS_FIELDCAT-FIELDNAME = 'ZDEPRANK'.

  GS_FIELDCAT-SELTEXT_M = '###'.

  APPEND GS_FIELDCAT TO GT_FIELDCAT.



  CLEAR : GS_FIELDCAT.

  GS_FIELDCAT-COL_POS = 6.

  GS_FIELDCAT-FIELDNAME = 'ZEDATE'.

  GS_FIELDCAT-SELTEXT_M = '###'.

  GS_FIELDCAT-OUTPUTLEN = 12.

  APPEND GS_FIELDCAT TO GT_FIELDCAT.





  CLEAR : GS_FIELDCAT.

  GS_FIELDCAT-COL_POS = 7.

  GS_FIELDCAT-FIELDNAME = 'ZSALARY'.

  GS_FIELDCAT-SELTEXT_M = '####'.

  GS_FIELDCAT-JUST = 'RIGHT'.

  GS_FIELDCAT-DO_SUM = 'X'.

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

  GS_FIELDCAT-FIELDNAME = 'ZMON'.

  GS_FIELDCAT-SELTEXT_M =  P_MONTH && '####'.

  GS_FIELDCAT-JUST = 'RIGHT'.

  GS_FIELDCAT-DO_SUM = 'X'.

  GS_FIELDCAT-CURRENCY = 'KRW'.

  GS_FIELDCAT-OUTPUTLEN = 20.

  APPEND GS_FIELDCAT TO GT_FIELDCAT.





  CLEAR : GS_LAYOUT.

  GS_LAYOUT-ZEBRA = C_X.



  GS_SORT-SPOS = 1. "## ##"

  GS_SORT-FIELDNAME = 'ZPERNR'. "## ###"

  GS_SORT-UP = C_X. "#### ##"

  APPEND GS_SORT TO GT_SORT.



  CALL FUNCTION 'REUSE_ALV_GRID_DISPLAY'

  EXPORTING

   IS_LAYOUT                         =  GS_LAYOUT

   IT_FIELDCAT                       =  GT_FIELDCAT

   IT_SORT                           =  GT_SORT

  TABLES

    T_OUTTAB                          = GT_WEVALCHECK.

ENDFORM.