
*&---------------------------------------------------------------------*

*& Report ZEDR14_PRACTICE007

*&---------------------------------------------------------------------*

*&

*&---------------------------------------------------------------------*




REPORT ZEDR14_PRACTICE007.



"######

TABLES : ZEDT14_102, ZEDT14_103, ZEDT14_104, ZEDT14_105, ZEDT14_106.



"CONSTANTS ##

CONSTANTS FIRST_DATE(5) VALUE '01.01'.



"ALV ITAB

DATA : GS_FIELDCAT TYPE SLIS_FIELDCAT_ALV,

       GT_FIELDCAT TYPE SLIS_T_FIELDCAT_ALV.

DATA : GS_LAYOUT TYPE SLIS_LAYOUT_ALV.

DATA : GS_SORT TYPE SLIS_SORTINFO_ALV,

       GT_SORT TYPE SLIS_T_SORTINFO_ALV.



"### ITAB

DATA : BEGIN OF GS_FINAL1,

  ZPERNR LIKE ZEDT14_102-ZPERNR,       "####

  ZPNAME LIKE ZEDT14_103-ZPNAME,       "####

  ZDEPCODE LIKE ZEDT14_102-ZDEPCODE,   "####

  ZDEPNAME TYPE C LENGTH 3,            "###

  ZDEPRANK LIKE ZEDT14_102-ZDEPRANK,   "####

  ZDEPRANKNAME TYPE C LENGTH 2,        "###

  ZEDATE LIKE ZEDT14_102-ZEDATE,       "###

  ZQFLAG LIKE ZEDT14_102-ZQFLAG,       "####

  ZQFLAGNAME TYPE C LENGTH 2,          "#### ##

  ZGENDER LIKE ZEDT14_103-ZGENDER,     "##

  ZGENDERNAME TYPE C LENGTH 2,         "## ##

  ZADDRESS LIKE ZEDT14_103-ZADDRESS,   "##

  ZBANKCODE LIKE ZEDT14_106-ZBANKCODE, "####

  ZBANKNAME TYPE C LENGTH 3,           "###

  ZACCOUNT LIKE ZEDT14_106-ZACCOUNT,   "####

  END OF GS_FINAL1.

DATA : GT_FINAL1 LIKE TABLE OF GS_FINAL1.



DATA : BEGIN OF GS_FINAL2,

  ZPERNR LIKE ZEDT14_102-ZPERNR,       "####

  ZPNAME LIKE ZEDT14_103-ZPNAME,       "####

  ZDEPCODE LIKE ZEDT14_102-ZDEPCODE,   "####

  ZDEPNAME TYPE C LENGTH 3,            "###

  ZDEPRANK LIKE ZEDT14_102-ZDEPRANK,   "####

  ZDEPRANKNAME TYPE C LENGTH 2,        "###

  ZEDATE LIKE ZEDT14_102-ZEDATE,       "###

  ZSALARY LIKE ZEDT14_106-ZSALARY,     "####

  ZRANK LIKE ZEDT14_104-ZRANK,         "####

  ZMONSAL LIKE ZEDT14_106-ZSALARY,     "####

  END OF GS_FINAL2.

DATA : GT_FINAL2 LIKE TABLE OF GS_FINAL2.



"### ## ##

SELECTION-SCREEN BEGIN OF BLOCK B1 WITH FRAME.

  SELECT-OPTIONS : S_ZPERNR FOR ZEDT14_102-ZPERNR.                     "####

  SELECT-OPTIONS : S_ZDATE FOR ZEDT14_102-ZEDATE MODIF ID M1.          "##

  PARAMETERS : P_ZDEPCO LIKE ZEDT14_102-ZDEPCODE MODIF ID M1.          "####

  PARAMETERS : P_ZYEAR TYPE N LENGTH 4 MODIF ID M2 DEFAULT 2025.       "##

  PARAMETERS : P_ZMONTH TYPE N LENGTH 2 MODIF ID M2 DEFAULT SY-DATUM+4(2).                   "#

SELECTION-SCREEN END OF BLOCK B1.

SELECTION-SCREEN BEGIN OF BLOCK B2 WITH FRAME.

  PARAMETERS : P_R1 RADIOBUTTON GROUP R1 DEFAULT 'X' USER-COMMAND UC1. "####

  PARAMETERS : P_R2 RADIOBUTTON GROUP R1.                              "####

  PARAMETERS : P_R3 RADIOBUTTON GROUP R1.                              "####

SELECTION-SCREEN END OF BLOCK B2.

SELECTION-SCREEN BEGIN OF BLOCK B3 WITH FRAME.

  PARAMETERS : P_CH1 AS CHECKBOX DEFAULT 'X' MODIF ID M3.              "####

SELECTION-SCREEN END OF BLOCK B3.



AT SELECTION-SCREEN OUTPUT.

  LOOP AT SCREEN.

    IF SCREEN-GROUP1 = 'M1'.

      IF P_R1 = 'X'.

        SCREEN-ACTIVE = '1'.

      ELSE.

        SCREEN-ACTIVE = '0'.

      ENDIF.

    ELSEIF SCREEN-GROUP1 = 'M2'.

      IF P_R1 = 'X'.

        SCREEN-ACTIVE = '0'.

      ELSE.

        SCREEN-ACTIVE = '1'.

      ENDIF.

    ELSEIF SCREEN-GROUP1 = 'M3'.

      IF P_R1 = 'X'.

        SCREEN-ACTIVE = '1'.

      ELSE.

        SCREEN-ACTIVE = '0'.

      ENDIF.

    ENDIF.

    MODIFY SCREEN.

  ENDLOOP.



INITIALIZATION.

S_ZDATE-LOW = SY-DATUM.

S_ZDATE-LOW+4(4) = FIRST_DATE.  "### # #



CALL FUNCTION 'SLS_MISC_GET_LAST_DAY_OF_MONTH'   "#### ## ##

  EXPORTING

    DAY_IN = SY-DATUM

  IMPORTING

    LAST_DAY_OF_MONTH = S_ZDATE-HIGH.



APPEND S_ZDATE.



START-OF-SELECTION.

  IF P_R1 = 'X'.         "####

    PERFORM GET_DATA1.

    PERFORM MODIFY_DATA1.

  ELSEIF P_R2 = 'X'.     "####

    PERFORM GET_DATA2.

    PERFORM MODIFY_DATA2.

  ELSE.                  "####

    PERFORM GET_DATA3.

    PERFORM MODIFY_DATA3.

  ENDIF.

END-OF-SELECTION.

  IF P_R1 = 'X'.         "####

    PERFORM ALV_DISPLAY1.

  ELSEIF P_R3 = 'X'.     "####

    PERFORM ALV_DISPLAY3.

  ENDIF.




*&---------------------------------------------------------------------*

*&      Form  GET_DATA

*&---------------------------------------------------------------------*

*       text

*----------------------------------------------------------------------*




FORM GET_DATA1 .



  IF P_CH1 = 'X'.   "#### ##

    SELECT * INTO CORRESPONDING FIELDS OF TABLE GT_FINAL1

      FROM ZEDT14_102 AS A

      INNER JOIN ZEDT14_103 AS B

      ON A~ZPERNR = B~ZPERNR

      INNER JOIN ZEDT14_106 AS C

      ON A~ZPERNR = C~ZPERNR

      WHERE A~ZPERNR IN S_ZPERNR AND ZEDATE IN S_ZDATE AND ZQFLAG = ''.

  ELSE.

    SELECT * INTO CORRESPONDING FIELDS OF TABLE GT_FINAL1

      FROM ZEDT14_102 AS A

      INNER JOIN ZEDT14_103 AS B

      ON A~ZPERNR = B~ZPERNR

      INNER JOIN ZEDT14_106 AS C

      ON A~ZPERNR = C~ZPERNR

      WHERE A~ZPERNR IN S_ZPERNR AND ZEDATE IN S_ZDATE AND ZQDATE NOT IN S_ZDATE.

  ENDIF.



ENDFORM.




*&---------------------------------------------------------------------*

*&      Form  MODIFY_DATA

*&---------------------------------------------------------------------*

*       text

*----------------------------------------------------------------------*




FORM MODIFY_DATA1 .



  LOOP AT GT_FINAL1 INTO GS_FINAL1.

    CASE GS_FINAL1-ZDEPCODE.    "### ### ##

      WHEN 'SS0001'. GS_FINAL1-ZDEPNAME = '###'.

      WHEN 'SS0002'. GS_FINAL1-ZDEPNAME = '###'.

      WHEN 'SS0003'. GS_FINAL1-ZDEPNAME = '###'.

      WHEN 'SS0004'. GS_FINAL1-ZDEPNAME = '###'.

      WHEN 'SS0005'. GS_FINAL1-ZDEPNAME = '###'.

      WHEN 'SS0006'. GS_FINAL1-ZDEPNAME = '###'.

    ENDCASE.



    CASE GS_FINAL1-ZDEPRANK.    "### ### ##

      WHEN 'A'. GS_FINAL1-ZDEPRANKNAME = '##'.

      WHEN 'B'. GS_FINAL1-ZDEPRANKNAME = '##'.

      WHEN 'C'. GS_FINAL1-ZDEPRANKNAME = '##'.

      WHEN 'D'. GS_FINAL1-ZDEPRANKNAME = '##'.

      WHEN 'E'. GS_FINAL1-ZDEPRANKNAME = '##'.

      WHEN 'F'. GS_FINAL1-ZDEPRANKNAME = '##'.

      WHEN 'G'. GS_FINAL1-ZDEPRANKNAME = '##'.

    ENDCASE.



    CASE GS_FINAL1-ZQFLAG.    "#### ### ##

      WHEN 'X'. GS_FINAL1-ZQFLAGNAME = '##'.

      WHEN ''. GS_FINAL1-ZQFLAGNAME = '##'.

    ENDCASE.



    CASE GS_FINAL1-ZGENDER.    "## ### ##

      WHEN 'M'. GS_FINAL1-ZGENDERNAME = '##'.

      WHEN 'F'. GS_FINAL1-ZGENDERNAME = '##'.

    ENDCASE.



    CASE GS_FINAL1-ZBANKCODE.    "### ### ##

      WHEN '001'. GS_FINAL1-ZBANKNAME = '##'.

      WHEN '002'. GS_FINAL1-ZBANKNAME = '##'.

      WHEN '003'. GS_FINAL1-ZBANKNAME = '##'.

      WHEN '004'. GS_FINAL1-ZBANKNAME = '##'.

      WHEN '005'. GS_FINAL1-ZBANKNAME = '###'.

    ENDCASE.



    MODIFY GT_FINAL1 FROM GS_FINAL1.

  ENDLOOP.



ENDFORM.




*&---------------------------------------------------------------------*

*&      Form  GET_DATA2

*&---------------------------------------------------------------------*

*       text

*----------------------------------------------------------------------*




FORM GET_DATA2 .



  DATA : LV_FIRST_DATE TYPE DATS,

         LV_LAST_DATE  TYPE DATS.



  "## ## ### #### ##

  CONCATENATE P_ZYEAR P_ZMONTH '01' INTO LV_FIRST_DATE.



  CALL FUNCTION 'SLS_MISC_GET_LAST_DAY_OF_MONTH'

    EXPORTING

      DAY_IN            = LV_FIRST_DATE

    IMPORTING

      LAST_DAY_OF_MONTH = LV_LAST_DATE.



  "## ### ### ## # ##/## ## ##

  CLEAR : GT_FINAL2, GT_FINAL2[].



  SELECT A~ZPERNR B~ZPNAME A~ZDEPCODE A~ZDEPRANK A~ZEDATE C~ZSALARY D~ZRANK

    INTO CORRESPONDING FIELDS OF TABLE GT_FINAL2

    FROM ZEDT14_102 AS A

    INNER JOIN ZEDT14_103 AS B ON A~ZPERNR = B~ZPERNR

    INNER JOIN ZEDT14_106 AS C ON A~ZPERNR = C~ZPERNR

    INNER JOIN ZEDT14_104 AS D ON A~ZPERNR = D~ZPERNR

    WHERE A~ZPERNR IN S_ZPERNR

      AND C~ZYEAR  EQ P_ZYEAR        "## ## ##

      AND D~ZYEAR  EQ P_ZYEAR        "## ##

      AND A~DATBI  LE LV_FIRST_DATE  "#### ### # ##

      AND A~DATAB  GT LV_LAST_DATE.  "#### ### # ##



  IF GT_FINAL2 IS INITIAL.

    MESSAGE '## #### ####.' TYPE 'S' DISPLAY LIKE 'E'.

  ENDIF.



ENDFORM.




*&---------------------------------------------------------------------*

*&      Form  MODIFY_DATA2

*&---------------------------------------------------------------------*

*       text

*----------------------------------------------------------------------*




FORM MODIFY_DATA2 .



  DATA : LV_CALC_SAL TYPE ZEDT14_106-ZSALARY. "### ##

  DATA : LS_105      TYPE ZEDT14_105.         "## ###

  DATA : LV_FIELDNAME TYPE STRING.            "## ###



  FIELD-SYMBOLS : <FS_MON> TYPE ANY.



  IF GT_FINAL2 IS INITIAL.

    EXIT.

  ENDIF.



  LOOP AT GT_FINAL2 INTO GS_FINAL2.

    CLEAR : LV_CALC_SAL, LS_105.



    "## ## (## / 12)

    LV_CALC_SAL = GS_FINAL2-ZSALARY / 12.



    "### ## (### A## + 500)

    IF GS_FINAL2-ZRANK = 'A'.

      LV_CALC_SAL = LV_CALC_SAL + 500.

    ENDIF.



    "## ### ####

    SELECT SINGLE * FROM ZEDT14_105 INTO LS_105

      WHERE ZPERNR = GS_FINAL2-ZPERNR AND ZYEAR = P_ZYEAR.



    IF SY-SUBRC = 0.

      LS_105-AENAME = SY-UNAME.

      LS_105-AEDATE = SY-DATUM.

      LS_105-AEZEIT = SY-UZEIT.



      LV_FIELDNAME = |ZMON{ P_ZMONTH }|.



      "### ##### ### ##### ## ### ##

      ASSIGN COMPONENT LV_FIELDNAME OF STRUCTURE LS_105 TO <FS_MON>.

      "### #### # ##

      IF <FS_MON> IS ASSIGNED.

        <FS_MON> = LV_CALC_SAL.

      ENDIF.



      MODIFY ZEDT14_105 FROM LS_105.

    ENDIF.



    UNASSIGN <FS_MON>.  "## ## ###

  ENDLOOP.



  IF SY-SUBRC = 0.

    MESSAGE '## ### #######.' TYPE 'S'.

  ENDIF.



ENDFORM.




*&---------------------------------------------------------------------*

*&      Form  GET_DATA3

*&---------------------------------------------------------------------*

*       text

*----------------------------------------------------------------------*




FORM GET_DATA3 .



  DATA : LV_FIRST_DATE TYPE DATS,

         LV_LAST_DATE  TYPE DATS.

  "## ##

  CONCATENATE P_ZYEAR P_ZMONTH '01' INTO LV_FIRST_DATE.



  CALL FUNCTION 'SLS_MISC_GET_LAST_DAY_OF_MONTH'

    EXPORTING

      DAY_IN            = LV_FIRST_DATE

    IMPORTING

      LAST_DAY_OF_MONTH = LV_LAST_DATE.



  CLEAR : GT_FINAL2, GT_FINAL2[].



  SELECT A~ZPERNR B~ZPNAME A~ZDEPCODE A~ZDEPRANK A~ZEDATE C~ZSALARY D~ZRANK

    INTO CORRESPONDING FIELDS OF TABLE GT_FINAL2

    FROM ZEDT14_102 AS A

    INNER JOIN ZEDT14_103 AS B ON A~ZPERNR = B~ZPERNR

    INNER JOIN ZEDT14_106 AS C ON A~ZPERNR = C~ZPERNR

    INNER JOIN ZEDT14_104 AS D ON A~ZPERNR = D~ZPERNR

    WHERE A~ZPERNR IN S_ZPERNR

      AND C~ZYEAR  EQ P_ZYEAR

      AND D~ZYEAR  EQ P_ZYEAR

      AND A~DATBI  LE LV_FIRST_DATE

      AND A~DATAB  GT LV_LAST_DATE.



  IF GT_FINAL2 IS INITIAL.

    MESSAGE '### #### ####.' TYPE 'S' DISPLAY LIKE 'E'.

  ENDIF.



ENDFORM.




*&---------------------------------------------------------------------*

*&      Form  MODIFY_DATA3

*&---------------------------------------------------------------------*

*       text

*----------------------------------------------------------------------*




FORM MODIFY_DATA3 .



  DATA : LS_105 TYPE ZEDT14_105.



  LOOP AT GT_FINAL2 INTO GS_FINAL2.

    "## ### ##(###)

    CASE GS_FINAL2-ZDEPCODE.

      WHEN 'SS0001'. GS_FINAL2-ZDEPNAME = '###'.

      WHEN 'SS0002'. GS_FINAL2-ZDEPNAME = '###'.

      WHEN 'SS0003'. GS_FINAL2-ZDEPNAME = '###'.

      WHEN 'SS0004'. GS_FINAL2-ZDEPNAME = '###'.

      WHEN 'SS0005'. GS_FINAL2-ZDEPNAME = '###'.

      WHEN 'SS0006'. GS_FINAL2-ZDEPNAME = '###'.

    ENDCASE.



    "## ### ##(###)

    CASE GS_FINAL2-ZDEPRANK.

      WHEN 'A'. GS_FINAL2-ZDEPRANKNAME = '##'.

      WHEN 'B'. GS_FINAL2-ZDEPRANKNAME = '##'.

      WHEN 'C'. GS_FINAL2-ZDEPRANKNAME = '##'.

      WHEN 'D'. GS_FINAL2-ZDEPRANKNAME = '##'.

      WHEN 'E'. GS_FINAL2-ZDEPRANKNAME = '##'.

      WHEN 'F'. GS_FINAL2-ZDEPRANKNAME = '##'.

      WHEN 'G'. GS_FINAL2-ZDEPRANKNAME = '##'.

    ENDCASE.



    "## ## ### ####

    CLEAR LS_105.

    SELECT SINGLE * FROM ZEDT14_105 INTO LS_105

     WHERE ZPERNR = GS_FINAL2-ZPERNR

       AND ZYEAR  = P_ZYEAR.



    IF SY-SUBRC = 0.

      CASE P_ZMONTH.

        WHEN '01'. GS_FINAL2-ZMONSAL = LS_105-ZMON01.

        WHEN '02'. GS_FINAL2-ZMONSAL = LS_105-ZMON02.

        WHEN '03'. GS_FINAL2-ZMONSAL = LS_105-ZMON03.

        WHEN '04'. GS_FINAL2-ZMONSAL = LS_105-ZMON04.

        WHEN '05'. GS_FINAL2-ZMONSAL = LS_105-ZMON05.

        WHEN '06'. GS_FINAL2-ZMONSAL = LS_105-ZMON06.

        WHEN '07'. GS_FINAL2-ZMONSAL = LS_105-ZMON07.

        WHEN '08'. GS_FINAL2-ZMONSAL = LS_105-ZMON08.

        WHEN '09'. GS_FINAL2-ZMONSAL = LS_105-ZMON09.

        WHEN '10'. GS_FINAL2-ZMONSAL = LS_105-ZMON10.

        WHEN '11'. GS_FINAL2-ZMONSAL = LS_105-ZMON11.

        WHEN '12'. GS_FINAL2-ZMONSAL = LS_105-ZMON12.

      ENDCASE.

    ENDIF.



    "### 0#### ### ### ## ##

    IF GS_FINAL2-ZMONSAL IS INITIAL.

      DELETE GT_FINAL2.

      CONTINUE.

    ENDIF.



    MODIFY GT_FINAL2 FROM GS_FINAL2.

  ENDLOOP.



ENDFORM.




*&---------------------------------------------------------------------*

*&      Form  ALV_DISPLAY

*&---------------------------------------------------------------------*

*       text

*----------------------------------------------------------------------*




FORM ALV_DISPLAY1 .



  PERFORM FIELD_CATALOG1.

  PERFORM ALV_LAYOUT1.

  PERFORM ALV_SORT.



ENDFORM.




*&---------------------------------------------------------------------*

*&      Form  FIELD_CATALOG

*&---------------------------------------------------------------------*

*       text

*----------------------------------------------------------------------*




FORM FIELD_CATALOG1 .



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

  GS_FIELDCAT-FIELDNAME = 'ZDEPNAME'.

  GS_FIELDCAT-SELTEXT_M = '###'.

  APPEND GS_FIELDCAT TO GT_FIELDCAT.



  CLEAR : GS_FIELDCAT.

  GS_FIELDCAT-COL_POS = 5.

  GS_FIELDCAT-FIELDNAME = 'ZDEPRANKNAME'.

  GS_FIELDCAT-SELTEXT_M = '###'.

  APPEND GS_FIELDCAT TO GT_FIELDCAT.



  CLEAR : GS_FIELDCAT.

  GS_FIELDCAT-COL_POS = 6.

  GS_FIELDCAT-FIELDNAME = 'ZEDATE'.

  GS_FIELDCAT-SELTEXT_M = '###'.

  APPEND GS_FIELDCAT TO GT_FIELDCAT.



  CLEAR : GS_FIELDCAT.

  GS_FIELDCAT-COL_POS = 7.

  GS_FIELDCAT-FIELDNAME = 'ZQFLAGNAME'.

  GS_FIELDCAT-SELTEXT_M = '####'.

  APPEND GS_FIELDCAT TO GT_FIELDCAT.



  CLEAR : GS_FIELDCAT.

  GS_FIELDCAT-COL_POS = 8.

  GS_FIELDCAT-FIELDNAME = 'ZGENDERNAME'.

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



ENDFORM.




*&---------------------------------------------------------------------*

*&      Form  ALV_LAYOUT

*&---------------------------------------------------------------------*

*       text

*----------------------------------------------------------------------*




FORM ALV_LAYOUT1 .



  GS_LAYOUT-ZEBRA = 'X'.



  CALL FUNCTION 'REUSE_ALV_GRID_DISPLAY'

  EXPORTING

    IT_FIELDCAT = GT_FIELDCAT

    IS_LAYOUT = GS_LAYOUT

  TABLES

    T_OUTTAB = GT_FINAL1.



ENDFORM.




*&---------------------------------------------------------------------*

*&      Form  ALV_SORT

*&---------------------------------------------------------------------*

*       text

*----------------------------------------------------------------------*




FORM ALV_SORT .

ENDFORM.




*&---------------------------------------------------------------------*

*&      Form  ALV_DISPLAY3

*&---------------------------------------------------------------------*

*       text

*----------------------------------------------------------------------*




FORM ALV_DISPLAY3 .



  PERFORM FIELD_CATALOG3.

  PERFORM ALV_LAYOUT3.

  PERFORM ALV_SORT.



ENDFORM.




*&---------------------------------------------------------------------*

*&      Form  FIELD_CATALOG3

*&---------------------------------------------------------------------*

*       text

*----------------------------------------------------------------------*




FORM FIELD_CATALOG3 .



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

  GS_FIELDCAT-FIELDNAME = 'ZDEPNAME'.

  GS_FIELDCAT-SELTEXT_M = '###'.

  APPEND GS_FIELDCAT TO GT_FIELDCAT.



  CLEAR : GS_FIELDCAT.

  GS_FIELDCAT-COL_POS = 5.

  GS_FIELDCAT-FIELDNAME = 'ZDEPRANKNAME'.

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

  GS_FIELDCAT-CURRENCY = 'KRW'.

  GS_FIELDCAT-DO_SUM = 'X'.

  GS_FIELDCAT-OUTPUTLEN = 15.

  APPEND GS_FIELDCAT TO GT_FIELDCAT.



  CLEAR : GS_FIELDCAT.

  GS_FIELDCAT-COL_POS = 8.

  GS_FIELDCAT-FIELDNAME = 'ZRANK'.

  GS_FIELDCAT-SELTEXT_M = '####'.

  APPEND GS_FIELDCAT TO GT_FIELDCAT.



  CLEAR : GS_FIELDCAT.

  GS_FIELDCAT-COL_POS = 9.

  GS_FIELDCAT-FIELDNAME = 'ZMONSAL'.

  GS_FIELDCAT-SELTEXT_M = |{ P_ZMONTH }####|.

  GS_FIELDCAT-CURRENCY = 'KRW'.

  GS_FIELDCAT-DO_SUM = 'X'.

  GS_FIELDCAT-OUTPUTLEN = 15.

  APPEND GS_FIELDCAT TO GT_FIELDCAT.



ENDFORM.




*&---------------------------------------------------------------------*

*&      Form  ALV_LAYOUT3

*&---------------------------------------------------------------------*

*       text

*----------------------------------------------------------------------*




FORM ALV_LAYOUT3 .



  GS_LAYOUT-ZEBRA = 'X'.



  CALL FUNCTION 'REUSE_ALV_GRID_DISPLAY'

  EXPORTING

    IT_FIELDCAT = GT_FIELDCAT

    IS_LAYOUT = GS_LAYOUT

  TABLES

    T_OUTTAB = GT_FINAL2.



ENDFORM.








*Messages

*----------------------------------------------------------

*

* Message class: Hard coded

*   ## #### ####.