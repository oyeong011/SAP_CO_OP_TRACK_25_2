
*&---------------------------------------------------------------------*

*& Report ZEDR20_PRACTICE007

*&---------------------------------------------------------------------*

*&

*&---------------------------------------------------------------------*




REPORT ZEDR20_PRACTICE007 MESSAGE-ID ZMED20.



TABLES: ZEDT20_104.



CONSTANTS: C_BONUS TYPE I VALUE 500.    " ##### ## ###



DATA: GV_TODAY TYPE SY-DATUM.   " SELECTION-SCREEN ### ### ## ##

RANGES: GR_DATE FOR SY-DATUM.   " ##### ## ## ##

DATA: GV_SALARY TYPE ZEDT20_105-ZMON01.   " #### ### ##

DATA: GV_ZMON(10) VALUE 'ZMON'.

DATA: GT_FIELDCAT TYPE slis_t_fieldcat_alv.   " ## #### ### ## ######

DATA: GS_FIELDCAT TYPE slis_fieldcat_alv.   " ## #### ### ## ##

DATA: GS_LAYOUT TYPE SLIS_LAYOUT_ALV.   " #### ### ## ##

DATA: GS_SORT TYPE slis_sortinfo_alv.   " #### ### ## ##

DATA: GT_SORT TYPE slis_t_sortinfo_alv.   " #### ### ## ######

FIELD-SYMBOLS <FS> TYPE ANY.

FIELD-SYMBOLS <FS_STRUCTURE> TYPE ANY.

FIELD-SYMBOLS <FS_T> TYPE STANDARD TABLE.



DATA: BEGIN OF GS_ZPINFO_DATA,

  ZPERNR TYPE ZEDT20_103-ZPERNR,   " ####

  ZPNAME TYPE ZEDT20_103-ZPNAME,   " ## ##

  ZDEPCODE TYPE ZEDT20_102-ZDEPCODE,   " ####

  ZDEPRANK TYPE ZEDT20_102-ZDEPRANK,    " ####

  ZEDATE TYPE ZEDT20_102-ZEDATE,   " ###

  ZQFLAG TYPE ZEDT20_102-ZQFLAG,   " ####

  ZGENDER TYPE ZEDT20_103-ZGENDER,   " ##

  ZADDRESS TYPE ZEDT20_103-ZADDRESS,   " ##

  ZBANKCODE TYPE ZEDT20_106-ZBANKCODE,   " ####

  ZACCOUNT TYPE ZEDT20_106-ZACCOUNT,    " ####

  END OF GS_ZPINFO_DATA.

DATA: GT_ZPINFO_DATA LIKE TABLE OF GS_ZPINFO_DATA.



DATA: BEGIN OF GS_ZPINFO_ALV,

  ZPERNR TYPE ZEDT20_103-ZPERNR,   " ####

  ZPNAME TYPE ZEDT20_103-ZPNAME,   " ## ##

  ZDEPCODE TYPE ZEDT20_102-ZDEPCODE,   " ####

  ZDEPNAME(3),   " ###

  ZRNAME(2),   " ###

  ZEDATE TYPE ZEDT20_102-ZEDATE,   " ###

  ZQSTATUS(2),   " ####

  ZGEN(2),   " ##

  ZADDRESS TYPE ZEDT20_103-ZADDRESS,   " ##

  ZBANKCODE TYPE ZEDT20_106-ZBANKCODE,   " ####

  ZBANKNAME(3),   " ###

  ZACCOUNT TYPE ZEDT20_106-ZACCOUNT,    " ####

  END OF GS_ZPINFO_ALV.

DATA: GT_ZPINFO_ALV LIKE TABLE OF GS_ZPINFO_ALV.



DATA: BEGIN OF GS_ZSALARY_DATA,

  ZPERNR TYPE ZEDT20_102-ZPERNR,   " ####

  ZRANK TYPE ZEDT20_104-ZRANK,    " ####

  ZSALARY TYPE ZEDT20_106-ZSALARY,    " ###

  END OF GS_ZSALARY_DATA.

DATA: GT_ZSALARY_DATA LIKE TABLE OF GS_ZSALARY_DATA.



DATA: BEGIN OF GS_ZEDT20_105.

  include structure
ZEDT20_105
.    " ####, ##, ##

  DATA: END OF GS_ZEDT20_105.

DATA: GT_ZEDT20_105 LIKE TABLE OF GS_ZEDT20_105.



DATA: BEGIN OF GS_ZPACCOUNT_DATA,

  ZPERNR TYPE ZEDT20_103-ZPERNR,    " ## ##

  ZPNAME TYPE ZEDT20_103-ZPNAME,   " ## ##

  ZDEPCODE TYPE ZEDT20_102-ZDEPCODE,   " ####

  ZDEPRANK TYPE ZEDT20_102-ZDEPRANK,    " ####

  ZEDATE TYPE ZEDT20_102-ZEDATE,   " ###

  ZSALARY TYPE ZEDT20_106-ZSALARY,    " ####

  ZRANK TYPE ZEDT20_104-ZRANK,    " ####

  ZMON TYPE ZEDT20_105-ZMON01,    " ##

  END OF GS_ZPACCOUNT_DATA.

DATA: GT_ZPACCOUNT_DATA LIKE TABLE OF GS_ZPACCOUNT_DATA.



DATA: BEGIN OF GS_ZPACCOUNT_ALV,

  ZPERNR TYPE ZEDT20_103-ZPERNR,   " ####

  ZPNAME TYPE ZEDT20_103-ZPNAME,   " ## ##

  ZDEPCODE TYPE ZEDT20_102-ZDEPCODE,   " ####

  ZDEPNAME(3),   " ###

  ZRNAME(2),   " ###

  ZEDATE TYPE ZEDT20_102-ZEDATE,   " ###

  ZSALARY TYPE ZEDT20_106-ZSALARY,    " ####

  ZRANK TYPE ZEDT20_104-ZRANK,    " ####

  ZMON TYPE ZEDT20_105-ZMON01,    " # ###

  END OF GS_ZPACCOUNT_ALV.

DATA: GT_ZPACCOUNT_ALV LIKE TABLE OF GS_ZPACCOUNT_ALV.



SELECTION-SCREEN BEGIN OF BLOCK B1 WITH FRAME.

  SELECT-OPTIONS: S_ZPERNR FOR ZEDT20_104-ZPERNR.   " ####

  SELECT-OPTIONS: S_ZDATE FOR ZEDT20_104-DATBI NO-EXTENSION MODIF ID M1.    " ##

  SELECT-OPTIONS: S_ZDEP FOR ZEDT20_104-ZDEPCODE NO-EXTENSION NO INTERVALS MODIF ID M1.   " ##

  PARAMETERS: P_YEAR LIKE ZEDT20_104-ZYEAR MODIF ID M2.   " ##

  PARAMETERS: P_MONTH TYPE N LENGTH 2 MODIF ID M2.    " #

SELECTION-SCREEN END OF BLOCK B1.



SELECTION-SCREEN BEGIN OF BLOCK B2 WITH FRAME.

  PARAMETERS: P_R1 RADIOBUTTON GROUP R1 DEFAULT 'X' USER-COMMAND UC1.   " ####

  PARAMETERS: P_R2 RADIOBUTTON GROUP R1.    " ####

  PARAMETERS: P_R3 RADIOBUTTON GROUP R1.    " ####

SELECTION-SCREEN END OF BLOCK B2.



SELECTION-SCREEN BEGIN OF BLOCK B3 WITH FRAME.

  PARAMETERS: Z_CHECK AS CHECKBOX DEFAULT 'X' MODIF ID M1.    " ####

SELECTION-SCREEN END OF BLOCK B3.



AT SELECTION-SCREEN OUTPUT.

  LOOP AT SCREEN.

    IF P_R1 = 'X'.    " ####

      IF SCREEN-GROUP1 = 'M2'.    " ##, # ## x

        SCREEN-ACTIVE = '0'.

      ELSEIF SCREEN-GROUP1 = 'M1'.    " ##, ## ## x

        SCREEN-ACTIVE = '1'.

      ENDIF.

    ELSE.    " #### or ####

      IF SCREEN-GROUP1 = 'M2'.

        SCREEN-ACTIVE = '1'.

      ELSEIF SCREEN-GROUP1 = 'M1'.

        SCREEN-ACTIVE = '0'.

      ENDIF.

    ENDIF.

    MODIFY SCREEN.

  ENDLOOP.



INITIALIZATION.   " ##, ##, # ### ##

  GV_TODAY = SY-DATUM.

  PERFORM SET_DATE USING GV_TODAY+0(4) GV_TODAY+4(2)    " ## ##

                   CHANGING S_ZDATE.

  CONCATENATE GV_TODAY+0(4) '0101' INTO S_ZDATE-LOW.    " ## ### ##

  APPEND S_ZDATE.

  P_YEAR = GV_TODAY+0(4).   " ##

  P_MONTH = GV_TODAY+4(2).    " #





START-OF-SELECTION.

  PERFORM CHECK_INPUT_ERROR.    " ### ## ##



  IF P_R1 = 'X'.    " ####

    PERFORM CHECK_ZPINFO.



  ELSEIF P_R2 = 'X'.    " ####

    PERFORM PAY_SALARY.

  ELSE.   " ####

    PERFORM CHECK_EVELUATION.

  ENDIF.

END-OF-SELECTION.

  CHECK P_R2 <> 'X'.    " ##### ALV## X

  PERFORM ALV_DISPLAY.




*&---------------------------------------------------------------------*

*&      Form  ERROR_MESSAGE

*&---------------------------------------------------------------------*

*       text

*----------------------------------------------------------------------*

*  -->  p1        text

*  <--  p2        text

*----------------------------------------------------------------------*




FORM NO_INPUT_ERROR .   " ##### ###### ## # #### ##

  MESSAGE I000.

  EXIT.

ENDFORM.




*&---------------------------------------------------------------------*

*&      Form  GET_PINFO_DATA

*&---------------------------------------------------------------------*

*       text

*----------------------------------------------------------------------*

*  -->  p1        text

*  <--  p2        text

*----------------------------------------------------------------------*




FORM GET_ZPINFO_DATA .    " #### ### ### ### ##

    SELECT

        A~ZPERNR

        B~ZPNAME

        A~ZDEPCODE

        A~ZDEPRANK

        A~ZEDATE

        A~ZQFLAG

        B~ZGENDER

        B~ZADDRESS

        C~ZBANKCODE

        C~ZACCOUNT

      INTO CORRESPONDING FIELDS OF TABLE GT_ZPINFO_DATA

      FROM ZEDT20_102 AS A

        INNER JOIN ZEDT20_103 AS B ON B~ZPERNR = A~ZPERNR

        INNER JOIN ZEDT20_106 AS C ON C~ZPERNR = A~ZPERNR

      WHERE A~ZEDATE LE S_ZDATE-HIGH    " #### ## #### ####

      " ####### #### ###### ## TO### #### ## #### #####.

      AND ( A~ZQFLAG = '' OR ( A~ZQDATE NOT IN GR_DATE AND A~ZQDATE GT S_ZDATE-HIGH ) )

      AND A~ZPERNR IN S_ZPERNR

      AND A~ZDEPCODE IN S_ZDEP.



ENDFORM.




*&---------------------------------------------------------------------*

*&      Form  GET_PACCOUNT_DATA

*&---------------------------------------------------------------------*

*       text

*----------------------------------------------------------------------*

*  -->  p1        text

*  <--  p2        text

*----------------------------------------------------------------------*




FORM GET_ZPACCOUNT_DATA .    " #### ### ### ### ##

  PERFORM SET_DATE USING P_YEAR P_MONTH   " ##### ### ## ### ## ##

                     CHANGING GR_DATE.

  GR_DATE-SIGN = 'I'.

  GR_DATE-OPTION = 'BT'.

  APPEND GR_DATE.

  PERFORM GET_ZEDT20_105.   " ## ### ## ##### ## # #####

  IF GT_ZEDT20_105 IS NOT INITIAL.    " #### ### ### ## X

    SELECT

        A~ZPERNR

        B~ZPNAME

        A~ZDEPCODE

        A~ZDEPRANK

        A~ZEDATE

        C~ZRANK

        D~ZSALARY

      INTO CORRESPONDING FIELDS OF TABLE GT_ZPACCOUNT_DATA

      FROM ZEDT20_102 AS A

        INNER JOIN ZEDT20_103 AS B ON B~ZPERNR = A~ZPERNR

        INNER JOIN ZEDT20_104 AS C ON C~ZPERNR = A~ZPERNR

        INNER JOIN ZEDT20_106 AS D ON D~ZPERNR = A~ZPERNR

      FOR ALL ENTRIES IN GT_ZEDT20_105    " ### ### GT_ZMON# #### # ###

      WHERE A~ZPERNR = GT_ZEDT20_105-ZPERNR   " ###, ### ## ##### + ## 0## #### ##

      AND A~ZEDATE LE GR_DATE-LOW   " #### ###### ####

      " ###### #### ##### ##### ###### ## ##

      AND ( A~ZQFLAG = '' OR A~ZQDATE NOT IN GR_DATE OR A~ZQDATE GT GR_DATE-HIGH ).

      ENDIF.

ENDFORM.




*&---------------------------------------------------------------------*

*&      Form  GET_EXCEPTED_PINFO_DATA

*&---------------------------------------------------------------------*

*       text

*----------------------------------------------------------------------*

*  -->  p1        text

*  <--  p2        text

*----------------------------------------------------------------------*




FORM GET_EXCEPTED_ZPINFO_DATA .   " ##### ## ### ###

    SELECT

        A~ZPERNR

        B~ZPNAME

        A~ZDEPCODE

        A~ZDEPRANK

        A~ZEDATE

        A~ZQFLAG

        B~ZGENDER

        B~ZADDRESS

        C~ZBANKCODE

        C~ZACCOUNT

      INTO CORRESPONDING FIELDS OF TABLE GT_ZPINFO_DATA

      FROM ZEDT20_102 AS A

        INNER JOIN ZEDT20_103 AS B ON B~ZPERNR = A~ZPERNR

        INNER JOIN ZEDT20_106 AS C ON C~ZPERNR = A~ZPERNR

      WHERE A~ZEDATE LE S_ZDATE-HIGH    " #### ###### ####

      AND ( A~ZQFLAG = '').   " #######

ENDFORM.




*&---------------------------------------------------------------------*

*&      Form  MODIFY_DATA

*&---------------------------------------------------------------------*

*       text

*----------------------------------------------------------------------*

*  -->  p1        text

*  <--  p2        text

*----------------------------------------------------------------------*




FORM MODIFY_ZPINFO_DATA .   " ### ### #### ### #### ##

  LOOP AT GT_ZPINFO_DATA INTO GS_ZPINFO_DATA.

    MOVE-CORRESPONDING GS_ZPINFO_DATA TO GS_ZPINFO_ALV.   " ### #### ## ### ## ##

    PERFORM MODIFY_ZDEPCODE USING GS_ZPINFO_DATA-ZDEPCODE   " ##### #### ###

                            CHANGING GS_ZPINFO_ALV-ZDEPNAME.



    PERFORM MODIFY_ZQFLAG USING GS_ZPINFO_DATA-ZQFLAG   " ##### ### ##

                          CHANGING GS_ZPINFO_ALV-ZQSTATUS.



    PERFORM MODIFY_ZDEPRANK USING GS_ZPINFO_DATA-ZDEPRANK   " ##### ## #### ###

                            CHANGING GS_ZPINFO_ALV-ZRNAME.



    PERFORM MODIFY_ZGENDER USING GS_ZPINFO_DATA-ZGENDER   " ### ### ##

                           CHANGING GS_ZPINFO_ALV-ZGEN.





    PERFORM MODIFY_ZBANKCODE USING GS_ZPINFO_DATA-ZBANKCODE   " ##### ## #### ###

                             CHANGING GS_ZPINFO_ALV-ZBANKNAME.

    APPEND GS_ZPINFO_ALV TO GT_ZPINFO_ALV.   " ALV### ### #### APPEND

  ENDLOOP.

ENDFORM.




*&---------------------------------------------------------------------*

*&      Form  NO_DATA_ERROR

*&---------------------------------------------------------------------*

*       text

*----------------------------------------------------------------------*

*  -->  p1        text

*  <--  p2        text

*----------------------------------------------------------------------*




FORM NO_DATA_ERROR .

  MESSAGE I001.   " ## #### #### ##

  EXIT.   " #### ##

ENDFORM.




*&---------------------------------------------------------------------*

*&      Form  MODIFY_PACCOUNT_DATA

*&---------------------------------------------------------------------*

*       text

*----------------------------------------------------------------------*

*  -->  p1        text

*  <--  p2        text

*----------------------------------------------------------------------*




FORM MODIFY_ZPACCOUNT_DATA .    " ### ### #### ### #### ##

  LOOP AT GT_ZPACCOUNT_DATA INTO GS_ZPACCOUNT_DATA.

    CLEAR: GS_ZEDT20_105.

    " ## ### ##### #### ## #### ###

    READ TABLE GT_ZEDT20_105 WITH KEY ZPERNR = GS_ZPACCOUNT_DATA-ZPERNR

    INTO GS_ZEDT20_105.

    ASSIGN COMPONENT <FS> OF STRUCTURE GS_ZEDT20_105 TO <FS_STRUCTURE>.

    IF <FS_STRUCTURE> = 0.    " ### 0## ##

      CONTINUE.

    ENDIF.

    MOVE-CORRESPONDING GS_ZPACCOUNT_DATA TO GS_ZPACCOUNT_ALV.   " ### #### ## ### ## ##

    GS_ZPACCOUNT_ALV-ZMON = <FS_STRUCTURE>.

    PERFORM MODIFY_ZDEPCODE USING GS_ZPACCOUNT_DATA-ZDEPCODE    " ##### #### ###

                            CHANGING GS_ZPACCOUNT_ALV-ZDEPNAME.



    PERFORM MODIFY_ZDEPRANK USING GS_ZPACCOUNT_DATA-ZDEPRANK    " ##### ## #### ###

                            CHANGING GS_ZPACCOUNT_ALV-ZRNAME.



    APPEND GS_ZPACCOUNT_ALV TO GT_ZPACCOUNT_ALV.    " ALV### ### #### APPEND

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




FORM ALV_DISPLAY .    " ALV ##

  PERFORM ALV_LAYOUT.   " LAYOUT ##

  PERFORM ALV_SORT.   " ## ## ##



  IF P_R1 = 'X'.    " ####

    PERFORM ZPINFO_FIELD_CATALOG.

    ASSIGN GT_ZPINFO_ALV TO <FS_T>.

  ELSEIF P_R3 = 'X'.    " ####

    PERFORM ZPACCOUNT_FIELD_CATALOG.

    ASSIGN GT_ZPACCOUNT_ALV TO <FS_T>.

  ENDIF.

  PERFORM CALL_ALV.

ENDFORM.




*&---------------------------------------------------------------------*

*&      Form  ALV_LAYOUT

*&---------------------------------------------------------------------*

*       text

*----------------------------------------------------------------------*

*  -->  p1        text

*  <--  p2        text

*----------------------------------------------------------------------*




FORM ALV_LAYOUT .   " LAYOUT ##

  GS_LAYOUT-ZEBRA = 'X'.

ENDFORM.




*&---------------------------------------------------------------------*

*&      Form  CALL_ALV

*&---------------------------------------------------------------------*

*       text

*----------------------------------------------------------------------*

*  -->  p1        text

*  <--  p2        text

*----------------------------------------------------------------------*




FORM CALL_ALV.    " ALV ##

  CALL FUNCTION 'REUSE_ALV_GRID_DISPLAY'

   EXPORTING

     IT_SORT = GT_SORT

     IS_LAYOUT = GS_LAYOUT

     IT_FIELDCAT = GT_FIELDCAT

    TABLES

      T_OUTTAB = <FS_T>.

ENDFORM.




*&---------------------------------------------------------------------*

*&      Form  ALV_SORT

*&---------------------------------------------------------------------*

*       text

*----------------------------------------------------------------------*

*  -->  p1        text

*  <--  p2        text

*----------------------------------------------------------------------*




FORM ALV_SORT .   " ## ##

  GS_SORT-SPOS = 1.

  GS_SORT-FIELDNAME = 'ZPERNR'.

  GS_SORT-UP = 'X'.

  APPEND GS_SORT TO GT_SORT.

ENDFORM.




*&---------------------------------------------------------------------*

*&      Form  CHECK_PINFO

*&---------------------------------------------------------------------*

*       text

*----------------------------------------------------------------------*

*  -->  p1        text

*  <--  p2        text

*----------------------------------------------------------------------*




FORM CHECK_ZPINFO .

    PERFORM SET_DATE USING S_ZDATE-HIGH+0(4) S_ZDATE-HIGH+4(2)

                     CHANGING GR_DATE.

    GR_DATE-SIGN = 'I'.

    GR_DATE-OPTION = 'BT'.

    APPEND GR_DATE.

    IF Z_CHECK = 'X'.   " ##### ## ### ##

      PERFORM GET_EXCEPTED_ZPINFO_DATA.

    ELSE.    " ## ## ## ##

      PERFORM GET_ZPINFO_DATA.

    ENDIF.



    " #### ### ### '## #### ####.' ##

    IF GT_ZPINFO_DATA IS INITIAL.

      PERFORM NO_DATA_ERROR.

    ENDIF.



    PERFORM MODIFY_ZPINFO_DATA.   " #### ##### ##

ENDFORM.




*&---------------------------------------------------------------------*

*&      Form  CHECK_INPUT_ERROR

*&---------------------------------------------------------------------*

*       text

*----------------------------------------------------------------------*

*  -->  p1        text

*  <--  p2        text

*----------------------------------------------------------------------*




FORM CHECK_INPUT_ERROR .    " ### #### ####

  IF P_R1 = 'X'.    " ####

    IF ( S_ZDATE-LOW IS INITIAL ) AND ( S_ZDATE-HIGH IS INITIAL ).    " ##### ## #####

      PERFORM NO_INPUT_ERROR.

    ENDIF.

  ELSE.   " #### OR ####

    IF ( P_YEAR = '' ) OR ( P_MONTH = '' ).   " ### #### ## #####

      PERFORM NO_INPUT_ERROR.

    ENDIF.

  ENDIF.

ENDFORM.




*&---------------------------------------------------------------------*

*&      Form  PAY_SALARY

*&---------------------------------------------------------------------*

*       text

*----------------------------------------------------------------------*

*  -->  p1        text

*  <--  p2        text

*----------------------------------------------------------------------*




FORM PAY_SALARY .   " ####

  PERFORM SET_DATE USING P_YEAR P_MONTH   " ##### ## ## ##

                     CHANGING GR_DATE.

  CONCATENATE GV_ZMON P_MONTH INTO GV_ZMON.

  ASSIGN GV_ZMON TO <FS>.

  PERFORM GET_ZSALARY_DATA.   " ### ##

  PERFORM MODIFY_ZSALARY_DATA.    " ### ##

ENDFORM.




*&---------------------------------------------------------------------*

*&      Form  GET_DATA_FOR_SALARY

*&---------------------------------------------------------------------*

*       text

*----------------------------------------------------------------------*

*  -->  p1        text

*  <--  p2        text

*----------------------------------------------------------------------*




FORM GET_ZSALARY_DATA.    " ## ### ### ### ##

  SELECT

    A~ZPERNR

    B~ZRANK

    C~ZSALARY

    INTO CORRESPONDING FIELDS OF TABLE GT_ZSALARY_DATA

    FROM ZEDT20_102 AS A

    INNER JOIN ZEDT20_104 AS B ON B~ZPERNR = A~ZPERNR

    INNER JOIN ZEDT20_106 AS C ON C~ZPERNR = A~ZPERNR

    WHERE A~ZEDATE LE GR_DATE-LOW   " #### ###### ### ####

    AND ( A~ZQFLAG = '' OR A~ZQDATE GT GR_DATE-HIGH )   " ###### #### ###### ###

    AND B~ZRANK IS NOT NULL.    " ##### #####

ENDFORM.




*&---------------------------------------------------------------------*

*&      Form  MODIFY_ZSALARY_DATA

*&---------------------------------------------------------------------*

*       text

*----------------------------------------------------------------------*

*  -->  p1        text

*  <--  p2        text

*----------------------------------------------------------------------*




FORM MODIFY_ZSALARY_DATA .    " ## ### ## ### #### ## ##

  PERFORM GET_ZEDT20_105.   " ## ### ## ### #### ## ZEDT20_105# ## #### ###.

  LOOP AT GT_ZSALARY_DATA INTO GS_ZSALARY_DATA.

    GV_SALARY = GS_ZSALARY_DATA-ZSALARY.    " ## ## #### ## ###

    PERFORM CALCULATE_SALARY USING GS_ZSALARY_DATA-ZRANK    " ##### ## ### ### ##

                             CHANGING GV_SALARY.

    IF GV_SALARY = 0.   " 0# # ## ####

      CONTINUE.

    ENDIF.

    READ TABLE GT_ZEDT20_105    " ### ##### ## ##

    WITH KEY

      ZPERNR = GS_ZSALARY_DATA-ZPERNR

      ZYEAR = P_YEAR

    INTO GS_ZEDT20_105.

    ASSIGN COMPONENT <FS> OF STRUCTURE GS_ZEDT20_105 TO <FS_STRUCTURE>.

    <FS_STRUCTURE> = GV_SALARY.   " #### ### ## ##

    GS_ZEDT20_105-CRNAME = SY-UNAME.    " #### ### ### ##

    GS_ZEDT20_105-CRZEIT = SY-UZEIT.    " #### ## ##

    GS_ZEDT20_105-CRDATE = SY-DATUM.    " #### ## ##

    APPEND GS_ZEDT20_105 TO GT_ZEDT20_105.

  ENDLOOP.

  MODIFY ZEDT20_105 FROM TABLE GT_ZEDT20_105.   " ## #### ## ##, #### ## ## ##

  IF SY-SUBRC <> 0.   " ###

    MESSAGE I003.   " ## ### ##

    STOP.   " #### ##

  ELSE.   " ###

    MESSAGE I002.   " ### #######. ##

  ENDIF.

ENDFORM.




*&---------------------------------------------------------------------*

*&      Form  CALCULATE_SALARY

*&---------------------------------------------------------------------*

*       text

*----------------------------------------------------------------------*

*      -->P_GS_ZSALARY_DATA_ZRANK  text

*      <--P_GV_SALARY  text

*----------------------------------------------------------------------*




FORM CALCULATE_SALARY  USING    PV_ZRANK    " ## ### ## ## ##

                       CHANGING PV_SALARY.

  PV_SALARY = PV_SALARY / 12.

  IF PV_ZRANK = 'A'.    " ##### A# 5## ### ##

    PV_SALARY = PV_SALARY + C_BONUS.

  ENDIF.

ENDFORM.




*&---------------------------------------------------------------------*

*&      Form  GET_ZMON

*&---------------------------------------------------------------------*

*       text

*----------------------------------------------------------------------*

*  -->  p1        text

*  <--  p2        text

*----------------------------------------------------------------------*




FORM GET_ZEDT20_105.   " ### ## ## ### ##

  SELECT

      *

      FROM ZEDT20_105

      INTO CORRESPONDING FIELDS OF TABLE GT_ZEDT20_105

      WHERE ZYEAR = P_YEAR

      AND ZPERNR IN S_ZPERNR.

ENDFORM.




*&---------------------------------------------------------------------*

*&      Form  MODIFY_ZBANKCODE

*&---------------------------------------------------------------------*

*       text

*----------------------------------------------------------------------*

*      -->P_GS_ZPINFO_DATA_ZBANKCODE  text

*      <--P_GS_ZPINFO_ALV_ZBANKNAME  text

*----------------------------------------------------------------------*




FORM MODIFY_ZBANKCODE  USING    P_ZBANKCODE   " #### -> ###

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

*&      Form  MODIFY_ZGENDER

*&---------------------------------------------------------------------*

*       text

*----------------------------------------------------------------------*

*      -->P_GS_ZPINFO_DATA_ZGENDER  text

*      <--P_GS_ZPINFO_ALV_ZGEN  text

*----------------------------------------------------------------------*




FORM MODIFY_ZGENDER  USING    P_ZGENDER   " #### -> ##

                     CHANGING P_ZGEN.

    CASE P_ZGENDER.

      WHEN 'M'.

        P_ZGEN = '##'.

      WHEN 'F'.

        P_ZGEN = '##'.

      ENDCASE.

ENDFORM.




*&---------------------------------------------------------------------*

*&      Form  MODIFY_ZDEPRANK

*&---------------------------------------------------------------------*

*       text

*----------------------------------------------------------------------*

*      -->P_GS_ZPINFO_DATA_ZDEPRANK  text

*      <--P_GS_ZPINFO_ALV_ZRNAME  text

*----------------------------------------------------------------------*




FORM MODIFY_ZDEPRANK  USING    P_ZDEPRANK   " #### -> ###

                      CHANGING P_ZRNAME.

  CASE P_ZDEPRANK.

      WHEN 'A'.

        P_ZRNAME = '##'.

      WHEN 'B'.

        P_ZRNAME = '##'.

      WHEN 'C'.

        P_ZRNAME = '##'.

      WHEN 'D'.

        P_ZRNAME = '##'.

      WHEN 'E'.

        P_ZRNAME = '##'.

      WHEN 'F'.

        P_ZRNAME = '##'.

      WHEN 'G'.

        P_ZRNAME = '##'.

    ENDCASE.

ENDFORM.




*&---------------------------------------------------------------------*

*&      Form  MODIFY_ZQFLAG

*&---------------------------------------------------------------------*

*       text

*----------------------------------------------------------------------*

*      -->P_GS_ZPINFO_DATA_ZQFLAG  text

*      <--P_GS_ZPINFO_ALV_ZQSTATUS  text

*----------------------------------------------------------------------*




FORM MODIFY_ZQFLAG  USING    P_ZQFLAG   " #### -> #### ##

                    CHANGING P_ZQSTATUS.

  CASE P_ZQFLAG.

      WHEN 'X'.

        P_ZQSTATUS = '##'.

      WHEN OTHERS.

        P_ZQSTATUS = '##'.

    ENDCASE.

ENDFORM.




*&---------------------------------------------------------------------*

*&      Form  MODIFY_ZDEPCODE

*&---------------------------------------------------------------------*

*       text

*----------------------------------------------------------------------*

*      -->P_GS_ZPINFO_DATA_ZDEPCODE  text

*      <--P_GS_ZPINFO_ALV_ZDEPNAME  text

*----------------------------------------------------------------------*




FORM MODIFY_ZDEPCODE  USING    P_ZDEPCODE   " #### -> ###

                      CHANGING P_ZDEPNAME.

    CASE P_ZDEPCODE.

      WHEN 'SS0001'.

        P_ZDEPNAME = '###'.

      WHEN 'SS0002'.

        P_ZDEPNAME = '###'.

      WHEN 'SS0003'.

        P_ZDEPNAME = '###'.

      WHEN 'SS0004'.

        P_ZDEPNAME = '###'.

      WHEN 'SS0005'.

        P_ZDEPNAME = '###'.

      WHEN 'SS0006'.

        P_ZDEPNAME = '###'.

    ENDCASE.

ENDFORM.




*&---------------------------------------------------------------------*

*&      Form  ZPINFO_FIELD_CATALOG

*&---------------------------------------------------------------------*

*       text

*----------------------------------------------------------------------*

*  -->  p1        text

*  <--  p2        text

*----------------------------------------------------------------------*




FORM ZPINFO_FIELD_CATALOG .   " #### ### ### ## #### ##

  CLEAR: GT_FIELDCAT, GS_FIELDCAT.

  GS_FIELDCAT-COL_POS = 1.

  GS_FIELDCAT-FIELDNAME = 'ZPERNR'.

  GS_FIELDCAT-SELTEXT_M = '####'.

  GS_FIELDCAT-KEY = 'X'.

  APPEND GS_FIELDCAT TO GT_FIELDCAT.



  CLEAR: GS_FIELDCAT.

  GS_FIELDCAT-COL_POS = 2.

  GS_FIELDCAT-FIELDNAME = 'ZPNAME'.

  GS_FIELDCAT-SELTEXT_M = '## ##'.

  GS_FIELDCAT-KEY = 'X'.

  APPEND GS_FIELDCAT TO GT_FIELDCAT.



  CLEAR: GS_FIELDCAT.

  GS_FIELDCAT-COL_POS = 3.

  GS_FIELDCAT-FIELDNAME = 'ZDEPCODE'.

  GS_FIELDCAT-SELTEXT_M = '####'.

  APPEND GS_FIELDCAT TO GT_FIELDCAT.



  CLEAR: GS_FIELDCAT.

  GS_FIELDCAT-COL_POS = 4.

  GS_FIELDCAT-FIELDNAME = 'ZDEPNAME'.

  GS_FIELDCAT-SELTEXT_M = '###'.

  APPEND GS_FIELDCAT TO GT_FIELDCAT.



  CLEAR: GS_FIELDCAT.

  GS_FIELDCAT-COL_POS = 5.

  GS_FIELDCAT-FIELDNAME = 'ZRNAME'.

  GS_FIELDCAT-SELTEXT_M = '###'.

  APPEND GS_FIELDCAT TO GT_FIELDCAT.



  CLEAR: GS_FIELDCAT.

  GS_FIELDCAT-COL_POS = 6.

  GS_FIELDCAT-FIELDNAME = 'ZEDATE'.

  GS_FIELDCAT-SELTEXT_M = '###'.

  APPEND GS_FIELDCAT TO GT_FIELDCAT.



  CLEAR: GS_FIELDCAT.

  GS_FIELDCAT-COL_POS = 7.

  GS_FIELDCAT-FIELDNAME = 'ZQSTATUS'.

  GS_FIELDCAT-SELTEXT_M = '####'.

  APPEND GS_FIELDCAT TO GT_FIELDCAT.



  CLEAR: GS_FIELDCAT.

  GS_FIELDCAT-COL_POS = 8.

  GS_FIELDCAT-FIELDNAME = 'ZGEN'.

  GS_FIELDCAT-SELTEXT_M = '##'.

  APPEND GS_FIELDCAT TO GT_FIELDCAT.



  CLEAR: GS_FIELDCAT.

  GS_FIELDCAT-COL_POS = 9.

  GS_FIELDCAT-FIELDNAME = 'ZADDRESS'.

  GS_FIELDCAT-SELTEXT_M = '##'.

  APPEND GS_FIELDCAT TO GT_FIELDCAT.



  CLEAR: GS_FIELDCAT.

  GS_FIELDCAT-COL_POS = 10.

  GS_FIELDCAT-FIELDNAME = 'ZBANKCODE'.

  GS_FIELDCAT-SELTEXT_M = '####'.

  APPEND GS_FIELDCAT TO GT_FIELDCAT.



  CLEAR: GS_FIELDCAT.

  GS_FIELDCAT-COL_POS = 11.

  GS_FIELDCAT-FIELDNAME = 'ZBANKNAME'.

  GS_FIELDCAT-SELTEXT_M = '###'.

  APPEND GS_FIELDCAT TO GT_FIELDCAT.



  CLEAR: GS_FIELDCAT.

  GS_FIELDCAT-COL_POS = 12.

  GS_FIELDCAT-FIELDNAME = 'ZACCOUNT'.

  GS_FIELDCAT-SELTEXT_M = '####'.

  APPEND GS_FIELDCAT TO GT_FIELDCAT.

ENDFORM.




*&---------------------------------------------------------------------*

*&      Form  ZPACCOUNT_FIELD_CATALOG

*&---------------------------------------------------------------------*

*       text

*----------------------------------------------------------------------*

*  -->  p1        text

*  <--  p2        text

*----------------------------------------------------------------------*




FORM ZPACCOUNT_FIELD_CATALOG .    " #### ### ###### ##

  CLEAR: GT_FIELDCAT, GS_FIELDCAT.

  GS_FIELDCAT-COL_POS = 1.

  GS_FIELDCAT-FIELDNAME = 'ZPERNR'.

  GS_FIELDCAT-SELTEXT_M = '####'.

  GS_FIELDCAT-KEY = 'X'.

  APPEND GS_FIELDCAT TO GT_FIELDCAT.



  CLEAR: GS_FIELDCAT.

  GS_FIELDCAT-COL_POS = 2.

  GS_FIELDCAT-FIELDNAME = 'ZPNAME'.

  GS_FIELDCAT-SELTEXT_M = '## ##'.

  GS_FIELDCAT-KEY = 'X'.

  APPEND GS_FIELDCAT TO GT_FIELDCAT.



  CLEAR: GS_FIELDCAT.

  GS_FIELDCAT-COL_POS = 3.

  GS_FIELDCAT-FIELDNAME = 'ZDEPCODE'.

  GS_FIELDCAT-SELTEXT_M = '####'.

  APPEND GS_FIELDCAT TO GT_FIELDCAT.



  CLEAR: GS_FIELDCAT.

  GS_FIELDCAT-COL_POS = 4.

  GS_FIELDCAT-FIELDNAME = 'ZDEPNAME'.

  GS_FIELDCAT-SELTEXT_M = '###'.

  APPEND GS_FIELDCAT TO GT_FIELDCAT.



  CLEAR: GS_FIELDCAT.

  GS_FIELDCAT-COL_POS = 5.

  GS_FIELDCAT-FIELDNAME = 'ZRNAME'.

  GS_FIELDCAT-SELTEXT_M = '###'.

  APPEND GS_FIELDCAT TO GT_FIELDCAT.



  CLEAR: GS_FIELDCAT.

  GS_FIELDCAT-COL_POS = 6.

  GS_FIELDCAT-FIELDNAME = 'ZEDATE'.

  GS_FIELDCAT-SELTEXT_M = '###'.

  APPEND GS_FIELDCAT TO GT_FIELDCAT.



  CLEAR: GS_FIELDCAT.

  GS_FIELDCAT-COL_POS = 7.

  GS_FIELDCAT-FIELDNAME = 'ZSALARY'.

  GS_FIELDCAT-SELTEXT_M = '####'.

  GS_FIELDCAT-DO_SUM = 'X'.   " ## ##

  GS_FIELDCAT-CURRENCY = 'KRW'.   " ### ## ##

  APPEND GS_FIELDCAT TO GT_FIELDCAT.



  CLEAR: GS_FIELDCAT.

  GS_FIELDCAT-COL_POS = 8.

  GS_FIELDCAT-FIELDNAME = 'ZRANK'.

  GS_FIELDCAT-SELTEXT_M = '####'.

  APPEND GS_FIELDCAT TO GT_FIELDCAT.



  CLEAR: GS_FIELDCAT.

  GS_FIELDCAT-COL_POS = 9.

  GS_FIELDCAT-FIELDNAME = 'ZMON'.

  CONCATENATE P_MONTH '####' INTO GS_FIELDCAT-SELTEXT_M.

  GS_FIELDCAT-CURRENCY = 'KRW'.   " ### ## ##

  GS_FIELDCAT-DO_SUM = 'X'.   " ## ##

  APPEND GS_FIELDCAT TO GT_FIELDCAT.

ENDFORM.




*&---------------------------------------------------------------------*

*&      Form  SET_DATE

*&---------------------------------------------------------------------*

*       text

*----------------------------------------------------------------------*

*      -->P_P_YEAR  text

*      -->P_P_MONTH  text

*----------------------------------------------------------------------*




FORM SET_DATE  USING    PV_YEAR   " ### ## ## ##### ## ##

                        PV_MONTH

               CHANGING PR_DATE LIKE GR_DATE.   " #### ### ## # ## - ### ##

  CONCATENATE PV_YEAR PV_MONTH '01' INTO PR_DATE-LOW.

  CALL FUNCTION 'RP_LAST_DAY_OF_MONTHS'

    EXPORTING

      DAY_IN                  = PR_DATE-LOW

   IMPORTING

     LAST_DAY_OF_MONTH       = PR_DATE-HIGH.

ENDFORM.




*&---------------------------------------------------------------------*

*&      Form  CHECK_EVELUATION

*&---------------------------------------------------------------------*

*       text

*----------------------------------------------------------------------*

*  -->  p1        text

*  <--  p2        text

*----------------------------------------------------------------------*




FORM CHECK_EVELUATION .   " ####

  CONCATENATE GV_ZMON P_MONTH INTO GV_ZMON.

  ASSIGN GV_ZMON TO <FS>.

    PERFORM GET_ZPACCOUNT_DATA.   " ### ##




*    IF GT_ZPACCOUNT_DATA IS INITIAL.

*      PERFORM NO_DATA_ERROR.

*    ENDIF.




    PERFORM MODIFY_ZPACCOUNT_DATA.    " ##### ##

ENDFORM.