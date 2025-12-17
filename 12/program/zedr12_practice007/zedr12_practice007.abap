
*&---------------------------------------------------------------------*

*& Report ZEDR12_PRACTICE007

*&---------------------------------------------------------------------*

*&

*&---------------------------------------------------------------------*




REPORT ZEDR12_PRACTICE007 MESSAGE-ID ZMED12.

DATA: GV_CHECK.

"1.TABLE ##.

TABLES: ZEDT12_102, "A

        ZEDT12_103, "B

        ZEDT12_104, "C

        ZEDT12_105, "D

        ZEDT12_106. "E

RANGES GR_ZQFLAG FOR ZEDT12_102-ZQFLAG. "### #####, ## ##



DATA:GT_ZEDT12_105 TYPE TABLE OF ZEDT12_105.

"######

DATA : GS_FIELDCAT TYPE SLIS_FIELDCAT_ALV.

DATA : GT_FIELDCAT TYPE SLIS_T_FIELDCAT_ALV.

"####

DATA : GS_LAYOUT TYPE SLIS_LAYOUT_ALV.

"SORT

DATA : GS_SORT TYPE SLIS_SORTINFO_ALV.

DATA : GT_SORT TYPE SLIS_T_SORTINFO_ALV.

"2-1. #### ###

DATA: BEGIN OF GS_WORKERINFO,

  ZPERNR TYPE ZEDT12_102-ZPERNR,        "####"

  ZPNAME TYPE ZEDT12_103-ZPNAME,        "####"

  ZDEPCODE TYPE ZEDT12_102-ZDEPCODE,    "####"

  ZDEPRANK TYPE ZEDT12_102-ZDEPRANK,    "####"

  ZEDATE TYPE ZEDT12_102-ZEDATE,        "###"

  ZQFLAG TYPE ZEDT12_102-ZQFLAG,        "####"

  ZGENDER TYPE ZEDT12_103-ZGENDER,      "##"

  ZADDRESS TYPE ZEDT12_103-ZADDRESS,    "##"

  ZBANKCODE TYPE ZEDT12_106-ZBANKCODE,  "####"

  ZACCOUNT TYPE ZEDT12_106-ZACCOUNT,    "####"

  END OF GS_WORKERINFO.

DATA: GT_WORKERINFO LIKE TABLE OF GS_WORKERINFO.



"2-2. #### ## ###

DATA: BEGIN OF GS_WORKERINFO_OUT,

  ZPERNR TYPE ZEDT12_102-ZPERNR,        "####

  ZPNAME TYPE ZEDT12_103-ZPNAME,        "####

  ZDEPCODE TYPE ZEDT12_102-ZDEPCODE,    "####"

  ZDEPCODE_NAME TYPE C LENGTH 9,        "###"

  ZDEPRANK TYPE ZEDT12_102-ZDEPRANK,    "####"

  ZDEPRANK_NAME TYPE C LENGTH 6,        "###"

  ZEDATE TYPE ZEDT12_102-ZEDATE,        "###"

  ZQFLAG TYPE ZEDT12_102-ZQFLAG,        "####"

  ZQSTATUS TYPE C LENGTH 3,             "#### ##"

  ZGENDER TYPE C LENGTH 3,              "## ##<-##"

  ZADDRESS TYPE ZEDT12_103-ZADDRESS,    "##"

  ZBANKCODE TYPE ZEDT12_106-ZBANKCODE,  "####"

  ZBANKNAME TYPE C LENGTH 4,            "####"

  ZACCOUNT TYPE ZEDT12_106-ZACCOUNT,    "####"

END OF GS_WORKERINFO_OUT.

DATA: GT_WORKERINFO_OUT LIKE TABLE OF GS_WORKERINFO_OUT.



DATA : BEGIN OF GS_SAL,   " ##### ### ##

  ZPERNR TYPE ZEDT12_102-ZPERNR,  " ####

  DATBI TYPE ZEDT12_102-DATBI,  " ####

  DATAB TYPE ZEDT12_102-DATAB,  " ####

  ZRANK TYPE ZEDT12_104-ZRANK,  " ####

  ZSALARY TYPE ZEDT12_106-ZSALARY,  " ##

  ZPAY TYPE ZEDT12_106-ZSALARY,     " ##

  END OF GS_SAL.

DATA GT_SAL LIKE TABLE OF GS_SAL.



"2-3. #### ## ###

 DATA : BEGIN OF GS_EVAL,

  ZPERNR TYPE ZEDT12_102-ZPERNR,        "####"

  ZPNAME TYPE ZEDT12_103-ZPNAME,        "####"

  ZDEPCODE TYPE ZEDT12_102-ZDEPCODE,    "####"

  ZDEPRANK TYPE ZEDT12_102-ZDEPRANK,    "####"

  ZEDATE TYPE ZEDT12_102-ZEDATE,        "###"

  ZSALARY TYPE ZEDT12_106-ZSALARY,      "####"

  ZRANK TYPE ZEDT12_104-ZRANK,          "####"

   END OF GS_EVAL.

 DATA : GT_EVAL LIKE TABLE OF GS_EVAL.



 "2-4. #### ### ###

 DATA : BEGIN OF GS_EVAL_OUT,

  ZPERNR TYPE ZEDT12_102-ZPERNR,        "####"

  ZPNAME TYPE ZEDT12_103-ZPNAME,        "####"

  ZDEPCODE TYPE ZEDT12_102-ZDEPCODE,    "####"

  ZDEPCODE_NAME TYPE C LENGTH 9,        "###"

  ZDEPRANK TYPE ZEDT12_102-ZDEPRANK,    "####"

  ZDEPRANK_NAME TYPE C LENGTH 6,        "###"

  ZEDATE TYPE ZEDT12_102-ZEDATE,        "###"

  ZSALARY TYPE ZEDT12_106-ZSALARY,      "####"

  ZRANK TYPE ZEDT12_104-ZRANK,          "####"

  ZMON TYPE ZEDT12_105-ZMON01,          "## ###"

   END OF GS_EVAL_OUT.

 DATA : GT_EVAL_OUT LIKE TABLE OF GS_EVAL_OUT.



" SELECTION-SCREEN

SELECTION-SCREEN BEGIN OF BLOCK B1 WITH FRAME.

 SELECT-OPTIONS: S_ZPERNR FOR ZEDT12_102-ZPERNR.              "####



 "1)######

 SELECT-OPTIONS: S_DATE FOR ZEDT12_102-DATAB MODIF ID M1.     "##

 SELECT-OPTIONS: S_DEPT FOR ZEDT12_102-ZDEPCODE MODIF ID M1.  "####



 "2)###### ,"3)######

 PARAMETERS : P_YEAR TYPE GJAHR  MODIF ID M2. "##

 PARAMETERS : P_MON TYPE MONAT  MODIF ID M2. "#



SELECTION-SCREEN END OF BLOCK B1.



SELECTION-SCREEN BEGIN OF BLOCK B2 WITH FRAME.

 PARAMETERS: P_R1 RADIOBUTTON GROUP R1 DEFAULT 'X' USER-COMMAND UC1. "####

 PARAMETERS: P_R2 RADIOBUTTON GROUP R1.                              "####

 PARAMETERS: P_R3 RADIOBUTTON GROUP R1.                              "####

SELECTION-SCREEN END OF BLOCK B2.



SELECTION-SCREEN BEGIN OF BLOCK B3 WITH FRAME.

  PARAMETERS P4 AS CHECKBOX DEFAULT 'X' MODIF ID M1.                              "####

SELECTION-SCREEN END OF BLOCK B3.



INITIALIZATION.

  PERFORM SET_DATE.

  " ##, # ### # ##

  P_YEAR = SY-DATUM(4).

  P_MON = SY-DATUM+4(2).





AT SELECTION-SCREEN OUTPUT.

  PERFORM SET_SCREEN.



AT SELECTION-SCREEN.

  PERFORM CHECK_SEARCH_CONDITIONS.

END-OF-SELECTION.



START-OF-SELECTION.

  CASE 'X'.

    WHEN P_R1. "####

      PERFORM SELECT_DATA_R1.

      PERFORM MODIFY_DATA_R1.

      PERFORM SHOW_DATA_R1.

    WHEN P_R2. "####

      PERFORM SELECT_DATA_R2.

      IF GT_SAL[] IS INITIAL.

        MESSAGE I001.

        EXIT.

      ENDIF.

      PERFORM MODIFY_DATA_R2.

    WHEN P_R3. "####

      PERFORM SELECT_DATA_R3.

      PERFORM MODIFY_DATA_R3.

      PERFORM SHOW_DATA_R3.










*    W




  ENDCASE.

END-OF-SELECTION.

CHECK P_R2 = 'X' AND

    P_YEAR IS NOT INITIAL AND P_MON IS NOT INITIAL.

    IF GV_CHECK = 'X'.

      MESSAGE I003.

    ELSE.

      MESSAGE I002.

    ENDIF.






*&---------------------------------------------------------------------*

*&      Form  SET_SCREEN

*&---------------------------------------------------------------------*

*       text

*----------------------------------------------------------------------*

*  -->  p1        text

*  <--  p2        text

*----------------------------------------------------------------------*




FORM SET_SCREEN .

  LOOP AT SCREEN.

    IF SCREEN-GROUP1 = 'M1'.      " #### ## # ##

      IF P_R1 = 'X'.

        SCREEN-ACTIVE = '1'.

      ELSE.

        SCREEN-ACTIVE = '0'.

      ENDIF.

    ELSEIF SCREEN-GROUP1 = 'M2'.  " ####, #### ## # ##

      IF P_R1 = 'X'.

        SCREEN-ACTIVE = '0'.

      ELSE.

        SCREEN-ACTIVE = '1'.

      ENDIF.

    ENDIF.

      MODIFY SCREEN.

    ENDLOOP.

ENDFORM.




*&---------------------------------------------------------------------*

*&      Form  SET_DATE

*&---------------------------------------------------------------------*

*       text

*----------------------------------------------------------------------*

*  -->  p1        text

*  <--  p2        text

*----------------------------------------------------------------------*




FORM SET_DATE . "#, #, #

  DATA: GV_FIRST_DATE TYPE DATS, "####

        GV_LAST_DATE TYPE DATS. "####

  GV_FIRST_DATE = |{ SY-DATUM+0(4) }0101|.



  CALL FUNCTION 'LAST_DAY_OF_MONTHS'

    exporting

      DAY_IN            = SY-DATUM

    importing

      LAST_DAY_OF_MONTH = GV_LAST_DATE.

  CLEAR: S_DATE[].

   S_DATE-SIGN = 'I'.

   S_DATE-OPTION = 'BT'.

   S_DATE-LOW = GV_FIRST_DATE.

   S_DATE-HIGH = GV_LAST_DATE.

   APPEND S_DATE.



ENDFORM.




*&---------------------------------------------------------------------*

*&      Form  CHECK_SEARCH_CONDITIONS

*&---------------------------------------------------------------------*

*       text

*----------------------------------------------------------------------*

*  -->  p1        text

*  <--  p2        text

*----------------------------------------------------------------------*




FORM CHECK_SEARCH_CONDITIONS .

  IF P_R1 = 'X'.

    IF ( S_DATE-LOW IS INITIAL ) AND ( S_DATE-HIGH IS INITIAL ).

      MESSAGE : '##### ######' TYPE 'S' DISPLAY LIKE 'E'.

    ENDIF.

  ENDIF.



  IF ( P_R2 = 'X' ) OR ( P_R3 = 'X' ).

    IF ( P_YEAR IS INITIAL ) AND ( P_MON IS INITIAL ).

      MESSAGE : '##### ######' TYPE 'S' DISPLAY LIKE 'E'.

    ENDIF.

  ENDIF.

ENDFORM.




*&---------------------------------------------------------------------*

*&      Form  SELECT_DATA_R1

*&---------------------------------------------------------------------*




FORM SELECT_DATA_R1 .




*  ZPERNR TYPE ZEDT12_102-ZPERNR,        "####"

*  ZPNAME TYPE ZEDT12_103-ZPNAME,        "####"

*  ZDEPCODE TYPE ZEDT12_104-ZDEPCODE,    "####"

*  ZDEPRANK TYPE ZEDT12_102-ZDEPRANK,    "####"

*  ZEDATE TYPE ZEDT12_102-ZEDATE,        "###"

*  ZQFLAG TYPE ZEDT12_102-ZQFLAG,        "####"

*  ZGENDER TYPE ZEDT12_103-ZGENDER,      "##"

*  ZADDRESS TYPE ZEDT12_103-ZADDRESS,    "##"

*  ZBANKCODE TYPE ZEDT12_106-ZBANKCODE,  "####"

*  ZACCOUNT TYPE ZEDT12_106-ZACCOUNT,    "####"




  "3)#### ##### ##### #### ### #### ##, # ##### ### ## # #### #### ### ##, #### ### # ##

  "RANGES GR_ZQFLAG FOR ZEDT12_102-ZQFLAG.

  "4)##### ### #######(ZEDT00_102)### # ####_FROM(DATBI) ~####_TO(DATAB) # ## #### #### #####



  IF P4 = 'X'. "### ####

    GR_ZQFLAG-SIGN = 'I'.

    GR_ZQFLAG-OPTION = 'EQ'.

    GR_ZQFLAG-LOW = ' '.

    APPEND GR_ZQFLAG.

  ELSE. "##+## ####

    GR_ZQFLAG-SIGN = 'I'.

    GR_ZQFLAG-OPTION = 'EQ'.

    GR_ZQFLAG-LOW = ' '.

    APPEND GR_ZQFLAG.

    GR_ZQFLAG-SIGN = 'I'.

    GR_ZQFLAG-OPTION = 'EQ'.

    GR_ZQFLAG-LOW = 'X'.

    APPEND GR_ZQFLAG.

  ENDIF.



  SELECT A~ZPERNR

         B~ZPNAME

         A~ZDEPCODE

         A~ZDEPRANK

         A~ZEDATE

         A~ZQFLAG

         B~ZGENDER

         B~ZADDRESS

         E~ZBANKCODE

         E~ZACCOUNT

  INTO CORRESPONDING FIELDS OF TABLE GT_WORKERINFO

  FROM ZEDT12_102 AS A INNER JOIN ZEDT12_103 AS B

    ON A~ZPERNR = B~ZPERNR

    INNER JOIN ZEDT12_106 AS E

    ON A~ZPERNR = E~ZPERNR

  WHERE A~ZPERNR IN S_ZPERNR "### SELECT OPTION## ###.

    AND A~DATBI <= S_DATE-HIGH  "DATBI# ##### ## #.

    AND A~DATAB > S_DATE-HIGH

    AND A~ZDEPCODE IN S_DEPT

    AND A~ZQFLAG IN GR_ZQFLAG.



ENDFORM.




*&---------------------------------------------------------------------*

*&      Form  MODIFY_DATA_R1

*&---------------------------------------------------------------------*




FORM MODIFY_DATA_R1 .




*  '5)### ##### ##

*  '6)### ##,## ### ### ## # # ##

*  '7)###, ### ### ##




  LOOP AT GT_WORKERINFO INTO GS_WORKERINFO.

    CLEAR GS_WORKERINFO_OUT.

    MOVE-CORRESPONDING GS_WORKERINFO TO GS_WORKERINFO_OUT.



    PERFORM WRITE_DEPRANK_NAME USING GS_WORKERINFO_OUT-ZDEPRANK CHANGING GS_WORKERINFO_OUT-ZDEPRANK_NAME. "###

    PERFORM WRITE_DEPCODE_NAME USING GS_WORKERINFO_OUT-ZDEPCODE CHANGING GS_WORKERINFO_OUT-ZDEPCODE_NAME. "###

    PERFORM WRITE_BANKNAME USING GS_WORKERINFO_OUT-ZBANKCODE CHANGING GS_WORKERINFO_OUT-ZBANKNAME. "###



    IF GS_WORKERINFO-ZGENDER = 'M'.

      GS_WORKERINFO_OUT-ZGENDER = '##'.

    ELSE.

      GS_WORKERINFO_OUT-ZGENDER = '##'.

    ENDIF.



    IF GS_WORKERINFO-ZQFLAG = 'X'.

      GS_WORKERINFO_OUT-ZQSTATUS = '##'.

    ELSE.

      GS_WORKERINFO_OUT-ZQSTATUS = '##'.

    ENDIF.



    APPEND GS_WORKERINFO_OUT TO GT_WORKERINFO_OUT.

  ENDLOOP.

ENDFORM.




*&---------------------------------------------------------------------*

*&      Form  WRITE_DEPRANK_NAME

*&---------------------------------------------------------------------*

*       text

*----------------------------------------------------------------------*

*      -->P_GS_WORKERINFO_OUT_ZDEPRANK  text

*      <--P_GS_WORKERINFO_OUT_ZDEPRANK_NAM  text

*----------------------------------------------------------------------*




FORM WRITE_DEPRANK_NAME  USING    P_ZDEPRANK

                         CHANGING P_ZDEPRANK_NAME.

  CASE P_ZDEPRANK.

    WHEN 'A'.

      P_ZDEPRANK_NAME = '##'.

    WHEN 'B'.

      P_ZDEPRANK_NAME = '##'.

    WHEN 'C'.

      P_ZDEPRANK_NAME = '##'.

    WHEN 'D'.

      P_ZDEPRANK_NAME = '##'.

    WHEN 'E'.

      P_ZDEPRANK_NAME = '##'.

    WHEN 'F'.

      P_ZDEPRANK_NAME = '##'.

    WHEN 'G'.

      P_ZDEPRANK_NAME = '##'.

  ENDCASE.



ENDFORM.




*&---------------------------------------------------------------------*

*&      Form  WRITE_DEPCODE_NAME

*&---------------------------------------------------------------------*

*       text

*----------------------------------------------------------------------*

*      -->P_GS_WORKERINFO_OUT_ZDEPCODE  text

*      <--P_GS_WORKERINFO_OUT_ZDEPCODE_NAM  text

*----------------------------------------------------------------------*




FORM WRITE_DEPCODE_NAME  USING    P_ZDEPCODE

                         CHANGING P_ZDEPCODE_NAME.



    CASE P_ZDEPCODE.

      WHEN 'SS0001'.

        P_ZDEPCODE_NAME = '###'.

      WHEN 'SS0002'.

        P_ZDEPCODE_NAME = '###'.

      WHEN 'SS0003'.

        P_ZDEPCODE_NAME = '###'.

      WHEN 'SS0004'.

        P_ZDEPCODE_NAME = '###'.

      WHEN 'SS0005'.

        P_ZDEPCODE_NAME = '###'.

      WHEN 'SS0006'.

        P_ZDEPCODE_NAME = '###'.

    ENDCASE.



ENDFORM.




*&---------------------------------------------------------------------*

*&      Form  WRITE_BANKNAME

*&---------------------------------------------------------------------*

*       text

*----------------------------------------------------------------------*

*      -->P_GS_WORKERINFO_OUT_ZBANKCODE  text

*      <--P_GS_WORKERINFO_OUT_ZBANKNAME  text

*----------------------------------------------------------------------*




FORM WRITE_BANKNAME  USING    P_ZBANKCODE

                     CHANGING P_ZBANKNAME.

  CASE P_ZBANKCODE.

    WHEN '001'.

      P_ZBANKNAME = '##'.

    WHEN '002'.

      P_ZBANKNAME = '##'.

    WHEN '003'.

      P_ZBANKNAME = '##'.

    WHEN '004'.

      P_ZBANKNAME = '##'.

    WHEN '005'.

      P_ZBANKNAME = '###'.

  ENDCASE.

ENDFORM.




*&---------------------------------------------------------------------*

*&      Form  SHOW_DATA_R1

*&---------------------------------------------------------------------*




FORM SHOW_DATA_R1 .

  "1)ALV# ##

  PERFORM FIELD_CATALOG.

  PERFORM ALV_LAYOUT.

  PERFORM SET_SORT.

  PERFORM ALV_DISPLAY USING GT_WORKERINFO_OUT.

ENDFORM.




*&---------------------------------------------------------------------*

*&      Form  FIELD_CATALOG

*&---------------------------------------------------------------------*




FORM FIELD_CATALOG .

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



  IF P_R1 = 'X'.

    CLEAR : GS_FIELDCAT.

    GS_FIELDCAT-COL_POS = 7.

    GS_FIELDCAT-FIELDNAME = 'ZQSTATUS'.

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

    GS_FIELDCAT-COL_POS = 11.

    GS_FIELDCAT-FIELDNAME = 'ZACCOUNT'.

    GS_FIELDCAT-SELTEXT_M = '####'.

    APPEND GS_FIELDCAT TO GT_FIELDCAT.

  ELSEIF P_R3 = 'X'.

    CLEAR : GS_FIELDCAT.

    GS_FIELDCAT-COL_POS = 7.

    GS_FIELDCAT-FIELDNAME = 'ZSALARY'.

    GS_FIELDCAT-SELTEXT_M = '####'.

    GS_FIELDCAT-OUTPUTLEN = '20'.

    GS_FIELDCAT-CURRENCY = 'KRW'.

    GS_FIELDCAT-DO_SUM = 'X'.

    APPEND GS_FIELDCAT TO GT_FIELDCAT.



    CLEAR : GS_FIELDCAT.

    GS_FIELDCAT-COL_POS = 8.

    GS_FIELDCAT-FIELDNAME = 'ZRANK'.

    GS_FIELDCAT-SELTEXT_M = '####'.

    APPEND GS_FIELDCAT TO GT_FIELDCAT.



    CLEAR : GS_FIELDCAT, L_TEXT.

    GS_FIELDCAT-COL_POS = 9.

    GS_FIELDCAT-FIELDNAME = 'ZMON'.

    CONCATENATE P_MON '####' INTO L_TEXT.

    GS_FIELDCAT-SELTEXT_M = L_TEXT.

    GS_FIELDCAT-CURRENCY = 'KRW'.

    GS_FIELDCAT-DO_SUM = 'X'.

    APPEND GS_FIELDCAT TO GT_FIELDCAT.

  ENDIF.

ENDFORM.




*&---------------------------------------------------------------------*

*&      Form  ALV_LAYOUT

*&---------------------------------------------------------------------*




FORM ALV_LAYOUT .

  CLEAR GS_LAYOUT.

  GS_LAYOUT-ZEBRA = 'X'.

ENDFORM.




*&---------------------------------------------------------------------*

*&      Form  SET_SORT

*&---------------------------------------------------------------------*




FORM SET_SORT .

  CLEAR : GS_SORT, GT_SORT.



  GS_SORT-SPOS = 1.

  GS_SORT-FIELDNAME = 'ZPERNR'.

  GS_SORT-UP = 'X'.

  APPEND GS_SORT TO GT_SORT.



ENDFORM.




*&---------------------------------------------------------------------*

*&      Form  ALV_DISPLAY

*&---------------------------------------------------------------------*

*       text

*----------------------------------------------------------------------*

*      -->P_GS_WORKERINFO_OUT  text

*----------------------------------------------------------------------*




FORM ALV_DISPLAY  USING PT_ALV TYPE STANDARD TABLE.



  CALL FUNCTION 'REUSE_ALV_GRID_DISPLAY'

   EXPORTING

     IT_FIELDCAT = GT_FIELDCAT

     IS_LAYOUT = GS_LAYOUT

     IT_SORT = GT_SORT

    TABLES

      T_OUTTAB = PT_ALV.



ENDFORM.




*&---------------------------------------------------------------------*

*&      Form  SELECT_DATA_R2

*&---------------------------------------------------------------------*




FORM SELECT_DATA_R2 .

  IF P_YEAR IS INITIAL OR P_MON IS INITIAL.

    MESSAGE I000.   " #### ## ### ##

    EXIT.           " END-OF-SELECTION## ##

  ENDIF.

  SELECT

          A~ZPERNR

          A~DATBI

          A~DATAB

          B~ZRANK

          C~ZSALARY

  INTO CORRESPONDING FIELDS OF TABLE GT_SAL

  FROM ZEDT12_102 AS A

    INNER JOIN ZEDT12_104 AS B

    ON A~ZPERNR = B~ZPERNR

    INNER JOIN ZEDT12_106 AS C "#### ###

    ON A~ZPERNR = C~ZPERNR AND B~ZYEAR = C~ZYEAR

  WHERE A~ZPERNR IN S_ZPERNR

    AND B~ZYEAR = P_YEAR

    AND C~ZSALARY <> 0.

ENDFORM.




*&---------------------------------------------------------------------*

*&      Form  MODIFY_DATA_R2

*&---------------------------------------------------------------------*




FORM MODIFY_DATA_R2 .

  DATA LV_ZMONTH(6).

    CONCATENATE P_YEAR P_MON INTO LV_ZMONTH.



  LOOP AT GT_SAL INTO GS_SAL.

    IF ( GS_SAL-DATBI(6) > LV_ZMONTH ) OR ( GS_SAL-DATAB(6) <= LV_ZMONTH ).

      CONTINUE.

    ENDIF.



  GS_SAL-ZPAY = GS_SAL-ZSALARY / 12.

  IF GS_SAL-ZRANK = 'A'.

    GS_SAL-ZPAY = GS_SAL-ZPAY + '500.00'.

  ENDIF.



  CHECK GS_SAL-ZPAY <> 0.

    PERFORM UPDATE_PAY. "ZEDT12_105# ## ##

    IF GV_CHECK = 'X'.

      STOP.

    ENDIF.

 ENDLOOP.

ENDFORM.




*&---------------------------------------------------------------------*

*&      Form  UPDATE_PAY

*&---------------------------------------------------------------------*




FORM UPDATE_PAY .

  DATA: LV_ZMON(6).

  CONCATENATE 'ZMON' P_MON INTO LV_ZMON.



  FIELD-SYMBOLS <FS_GS_ZEDT12_105> TYPE ZEDT12_105. "### ###

  READ TABLE GT_ZEDT12_105 WITH KEY ZPERNR = GS_SAL-ZPERNR

                                    ZYEAR = P_YEAR

                                    ASSIGNING <FS_GS_ZEDT12_105>.

  FIELD-SYMBOLS <FS_MON> TYPE ANY.  "MON###

  ASSIGN COMPONENT LV_ZMON OF STRUCTURE <FS_GS_ZEDT12_105> TO <FS_MON>.



  <FS_MON> = GS_SAL-ZPAY.



  <FS_GS_ZEDT12_105>-AENAME = SY-UNAME.

  <FS_GS_ZEDT12_105>-AEDATE = SY-DATUM.

  <FS_GS_ZEDT12_105>-AEZEIT = SY-UZEIT.



  UPDATE ZEDT12_105 FROM <FS_GS_ZEDT12_105>.



  IF SY-SUBRC <> 0.

    GV_CHECK = 'X'.

  ENDIF.

ENDFORM.




*&---------------------------------------------------------------------*

*&      Form  SELECT_DATA_R3

*&---------------------------------------------------------------------*




FORM SELECT_DATA_R3 .

  " #### ##

  SELECT  A~ZPERNR

          B~ZPNAME

          A~ZDEPCODE

          A~ZDEPRANK

          A~ZEDATE

          D~ZSALARY

          C~ZRANK

    INTO CORRESPONDING FIELDS OF TABLE GT_EVAL

    FROM ZEDT12_102 AS A

      INNER JOIN ZEDT12_103 AS B

      ON A~ZPERNR = B~ZPERNR

      INNER JOIN ZEDT12_104 AS C

      ON A~ZPERNR = C~ZPERNR

      INNER JOIN ZEDT12_106 AS D

      ON A~ZPERNR = D~ZPERNR AND C~ZYEAR = D~ZYEAR

    WHERE A~ZPERNR IN S_ZPERNR

      AND C~ZYEAR = P_YEAR

      AND D~ZSALARY <> 0.

ENDFORM.




*&---------------------------------------------------------------------*

*&      Form  MODIFY_DATA_R3

*&---------------------------------------------------------------------*




FORM MODIFY_DATA_R3 .




*  ZPERNR TYPE ZEDT12_102-ZPERNR,        "####"

*  ZPNAME TYPE ZEDT12_103-ZPNAME,        "####"

*  ZDEPCODE TYPE ZEDT12_102-ZDEPCODE,    "####"

*  ZDEPCODE_NAME TYPE C LENGTH 9,        "###"

*  ZDEPRANK TYPE ZEDT12_102-ZDEPRANK,    "####"

*  ZDEPRANK_NAME TYPE C LENGTH 6,        "###"

*  ZEDATE TYPE ZEDT12_102-ZEDATE,        "###"

*  ZSALARY TYPE ZEDT12_106-ZSALARY,      "####"

*  ZRANK TYPE ZEDT12_104-ZRANK,          "####"

*  ZMON TYPE ZEDT12_105-ZMON01,          "## ###"




  LOOP AT GT_EVAL INTO GS_EVAL.

    CLEAR GS_EVAL_OUT.

    MOVE-CORRESPONDING GS_EVAL TO GS_EVAL_OUT.



    PERFORM WRITE_DEPCODE_NAME USING GS_EVAL_OUT-ZDEPCODE

                              CHANGING GS_EVAL_OUT-ZDEPCODE_NAME.



    PERFORM WRITE_DEPRANK_NAME USING GS_EVAL_OUT-ZDEPRANK

                               CHANGING GS_EVAL_OUT-ZDEPRANK_NAME.



    PERFORM GET_PAY USING P_YEAR P_MON GS_EVAL_OUT-ZPERNR

                    CHANGING GS_EVAL_OUT-ZMON.



    IF GS_EVAL_OUT-ZMON <> 0.

      APPEND GS_EVAL_OUT TO GT_EVAL_OUT.

    ENDIF.

  ENDLOOP.

ENDFORM.




*&---------------------------------------------------------------------*

*&      Form  GET_PAY

*&---------------------------------------------------------------------*

*       text

*----------------------------------------------------------------------*

*      -->P_P_YEAR  text

*      -->P_P_ZMONTH  text

*      -->P_GS_EVAL_ZPERNR  text

*      <--P_GS_EVAL_OUT_ZMON  text

*----------------------------------------------------------------------*




FORM GET_PAY  USING    P_P_YEAR

                       P_P_ZMONTH

                       P_GS_EVAL_OUT_ZPERNR

              CHANGING P_GS_EVAL_OUT_ZMON.

  CASE P_P_ZMONTH.

    WHEN '1'.

      SELECT SINGLE ZMON01 FROM ZEDT12_105 INTO P_GS_EVAL_OUT_ZMON

        WHERE ZPERNR = P_GS_EVAL_OUT_ZPERNR

        AND ZYEAR = P_P_YEAR.

    WHEN '2'.

      SELECT SINGLE ZMON02 FROM ZEDT12_105 INTO P_GS_EVAL_OUT_ZMON

        WHERE ZPERNR = P_GS_EVAL_OUT_ZPERNR

        AND ZYEAR = P_P_YEAR.

    WHEN '3'.

      SELECT SINGLE ZMON03 FROM ZEDT12_105 INTO P_GS_EVAL_OUT_ZMON

        WHERE ZPERNR = P_GS_EVAL_OUT_ZPERNR

        AND ZYEAR = P_P_YEAR.

    WHEN '4'.

      SELECT SINGLE ZMON04 FROM ZEDT12_105 INTO P_GS_EVAL_OUT_ZMON

        WHERE ZPERNR = P_GS_EVAL_OUT_ZPERNR

        AND ZYEAR = P_P_YEAR.

    WHEN '5'.

      SELECT SINGLE ZMON05 FROM ZEDT12_105 INTO P_GS_EVAL_OUT_ZMON

        WHERE ZPERNR = P_GS_EVAL_OUT_ZPERNR

        AND ZYEAR = P_P_YEAR.

    WHEN '6'.

      SELECT SINGLE ZMON06 FROM ZEDT12_105 INTO P_GS_EVAL_OUT_ZMON

        WHERE ZPERNR = P_GS_EVAL_OUT_ZPERNR

        AND ZYEAR = P_P_YEAR.

    WHEN '7'.

      SELECT SINGLE ZMON07 FROM ZEDT12_105 INTO P_GS_EVAL_OUT_ZMON

        WHERE ZPERNR = P_GS_EVAL_OUT_ZPERNR

        AND ZYEAR = P_P_YEAR.

    WHEN '8'.

      SELECT SINGLE ZMON08 FROM ZEDT12_105 INTO P_GS_EVAL_OUT_ZMON

        WHERE ZPERNR = P_GS_EVAL_OUT_ZPERNR

        AND ZYEAR = P_P_YEAR.

    WHEN '9'.

      SELECT SINGLE ZMON09 FROM ZEDT12_105 INTO P_GS_EVAL_OUT_ZMON

        WHERE ZPERNR = P_GS_EVAL_OUT_ZPERNR

        AND ZYEAR = P_P_YEAR.

    WHEN '10'.

      SELECT SINGLE ZMON10 FROM ZEDT12_105 INTO P_GS_EVAL_OUT_ZMON

        WHERE ZPERNR = P_GS_EVAL_OUT_ZPERNR

        AND ZYEAR = P_P_YEAR.

    WHEN '11'.

      SELECT SINGLE ZMON11 FROM ZEDT12_105 INTO P_GS_EVAL_OUT_ZMON

        WHERE ZPERNR = P_GS_EVAL_OUT_ZPERNR

        AND ZYEAR = P_P_YEAR.

    WHEN '12'.

      SELECT SINGLE ZMON12 FROM ZEDT12_105 INTO P_GS_EVAL_OUT_ZMON

        WHERE ZPERNR = P_GS_EVAL_OUT_ZPERNR

        AND ZYEAR = P_P_YEAR.

  ENDCASE.

ENDFORM.




*&---------------------------------------------------------------------*

*&      Form  SHOW_DATA_R3

*&---------------------------------------------------------------------*




FORM SHOW_DATA_R3 .

  PERFORM FIELD_CATALOG_EVAL.

  PERFORM ALV_LAYOUT.

  PERFORM SET_SORT.

  PERFORM ALV_DISPLAY USING GT_EVAL_OUT.

ENDFORM.




*&---------------------------------------------------------------------*

*&      Form  FIELD_CATALOG_RANK

*&---------------------------------------------------------------------*

*       text

*----------------------------------------------------------------------*

*  -->  p1        text

*  <--  p2        text

*----------------------------------------------------------------------*




FORM FIELD_CATALOG_EVAL .

  CLEAR : GS_FIELDCAT, GT_FIELDCAT.

  GS_FIELDCAT-COL_POS = 1.

  GS_FIELDCAT-FIELDNAME = 'ZPERNR'.

  GS_FIELDCAT-seltext_m = '####'.

  GS_FIELDCAT-KEY = 'X'.  " ###. ## ##. #### # ##.

  APPEND GS_FIELDCAT TO GT_FIELDCAT.



  CLEAR : GS_FIELDCAT.

  GS_FIELDCAT-COL_POS = 2.

  GS_FIELDCAT-FIELDNAME = 'ZPNAME'.

  GS_FIELDCAT-seltext_m = '####'.

  GS_FIELDCAT-KEY = 'X'.

  APPEND GS_FIELDCAT TO GT_FIELDCAT.



  CLEAR : GS_FIELDCAT.

  GS_FIELDCAT-COL_POS = 3.

  GS_FIELDCAT-FIELDNAME = 'ZDEPCODE'.

  GS_FIELDCAT-seltext_m = '####'.

  APPEND GS_FIELDCAT TO GT_FIELDCAT.



  CLEAR : GS_FIELDCAT.

  GS_FIELDCAT-COL_POS = 4.

  GS_FIELDCAT-FIELDNAME = 'ZDEPCODE_NAME'.

  GS_FIELDCAT-seltext_m = '###'.

  APPEND GS_FIELDCAT TO GT_FIELDCAT.



  CLEAR : GS_FIELDCAT.

  GS_FIELDCAT-COL_POS = 5.

  GS_FIELDCAT-FIELDNAME = 'ZDEPRANK_NAME'.

  GS_FIELDCAT-seltext_m = '###'.

  APPEND GS_FIELDCAT TO GT_FIELDCAT.



  CLEAR : GS_FIELDCAT.

  GS_FIELDCAT-COL_POS = 6.

  GS_FIELDCAT-FIELDNAME = 'ZEDATE'.

  GS_FIELDCAT-seltext_m = '###'.

  GS_FIELDCAT-OUTPUTLEN = 10.

  APPEND GS_FIELDCAT TO GT_FIELDCAT.



  CLEAR : GS_FIELDCAT.

  GS_FIELDCAT-COL_POS = 7.

  GS_FIELDCAT-FIELDNAME = 'ZSALARY'.

  GS_FIELDCAT-seltext_m = '####'.

  GS_FIELDCAT-CURRENCY = 'KRW'.   " ### ##

  GS_FIELDCAT-JUST = 'R'.         " ### ### ##

  GS_FIELDCAT-DO_SUM = 'X'.       " ## ##.

  GS_FIELDCAT-OUTPUTLEN = 15.

  APPEND GS_FIELDCAT TO GT_FIELDCAT.



  CLEAR : GS_FIELDCAT.

  GS_FIELDCAT-COL_POS = 8.

  GS_FIELDCAT-FIELDNAME = 'ZRANK'.

  GS_FIELDCAT-seltext_m = '####'.

  APPEND GS_FIELDCAT TO GT_FIELDCAT.



  CLEAR : GS_FIELDCAT.

  GS_FIELDCAT-COL_POS = 9.

  GS_FIELDCAT-FIELDNAME = 'ZMON'.

  GS_FIELDCAT-seltext_m = P_MON && '####'. "&&## ## ## (=CONCATENATE)

  GS_FIELDCAT-CURRENCY = 'KRW'.   " ### ##

  GS_FIELDCAT-JUST = 'R'.         " ### ### ##

  GS_FIELDCAT-DO_SUM = 'X'.       " ## ##.

  GS_FIELDCAT-OUTPUTLEN = 15.

  APPEND GS_FIELDCAT TO GT_FIELDCAT.

ENDFORM.








*Messages

*----------------------------------------------------------

*

* Message class: Hard coded

*   ##### ######