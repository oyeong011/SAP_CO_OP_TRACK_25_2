
*&---------------------------------------------------------------------*

*& Report ZEDR23_PRACTICE003

*&---------------------------------------------------------------------*

*&

*&---------------------------------------------------------------------*




REPORT ZEDR23_PRACTICE003.





CONSTANTS : TRUE TYPE C LENGTH 1 VALUE 'X'.



TABLES : ZEDT23_100.

TABLES : ZEDT23_101.



DATA : ZFIRST_DAY TYPE SY-DATUM,

      ZLAST_DAY TYPE SY-DATUM.





" ### 100 Itable

DATA : BEGIN OF GS_ZEDT100,

  ZORDNO LIKE ZEDT23_100-ZORDNO,

  ZIDCODE LIKE ZEDT23_100-ZIDCODE,

  ZMATNR LIKE ZEDT23_100-ZMATNR,

  ZMATNAME LIKE ZEDT23_100-ZMATNAME,

  ZMTART LIKE ZEDT23_100-ZMTART,

  ZVOLUM LIKE ZEDT23_100-ZVOLUM,

  VRKME LIKE ZEDT23_100-VRKME,

  ZNSAMT LIKE ZEDT23_100-ZNSAMT,

  ZSLAMT LIKE ZEDT23_100-ZSLAMT,

  ZDCAMT LIKE ZEDT23_100-ZDCAMT,

  ZSALE_FG LIKE ZEDT23_100-ZSALE_FG,

  ZJDATE LIKE ZEDT23_100-ZJDATE,

  ZRET_FG LIKE ZEDT23_100-ZRET_FG,

  ZRDATE LIKE ZEDT23_100-ZRDATE,

  ZMTART_STR TYPE STRING,

  ZSALE_FG_STR TYPE STRING,

  ZRET_FG_STR TYPE STRING,

  ZRDATE_STR TYPE STRING,

  END OF GS_ZEDT100.

DATA : GT_ZEDT100 LIKE TABLE OF GS_ZEDT100.



" ### 101 ITable

DATA : BEGIN OF GS_ZEDT101,

  ZORDNO LIKE ZEDT23_101-ZORDNO,

  ZIDCODE LIKE ZEDT23_101-ZIDCODE,

  ZMATNR LIKE ZEDT23_101-ZMATNR,

  ZMATNAME LIKE ZEDT23_101-ZMATNAME,

  ZMTART LIKE ZEDT23_101-ZMTART,

  ZVOLUM LIKE ZEDT23_101-ZVOLUM,

  VRKME LIKE ZEDT23_101-VRKME,

  ZSLAMT LIKE ZEDT23_101-ZSLAMT,

  ZDFLAG LIKE ZEDT23_101-ZDFLAG,

  ZDGUBUN LIKE ZEDT23_101-ZDGUBUN,

  ZDDATE LIKE ZEDT23_101-ZDDATE,

  ZRDATE LIKE ZEDT23_101-ZRDATE,

  ZFLAG LIKE ZEDT23_101-ZFLAG,

  ZMTART_STR TYPE STRING,

  ZDFLAG_STR TYPE STRING,

  ZDGUBUN_STR TYPE STRING,

  ZRDATE_STR TYPE STRING,

  END OF GS_ZEDT101.

DATA : GT_ZEDT101 LIKE TABLE OF GS_ZEDT101.



DATA : MAX_ORDNO TYPE ZEDT23_100-ZORDNO.

SELECT MAX( ZORDNO ) INTO MAX_ORDNO FROM ZEDT23_100.

DATA : MAX_ID TYPE ZEDT23_100-ZIDCODE.

SELECT MAX( ZIDCODE ) INTO MAX_ID FROM ZEDT23_100.

DATA : MAX_MATNR TYPE ZEDT23_100-ZMATNR.

SELECT MAX( ZMATNR ) INTO MAX_MATNR FROM ZEDT23_100.





RANGES : GR_ZIDCODE FOR ZEDT23_100-ZIDCODE.

  GR_ZIDCODE-SIGN = 'I'.

  GR_ZIDCODE-OPTION = 'BT'.

  GR_ZIDCODE-LOW = 'SSU-00'.

  GR_ZIDCODE-HIGH = MAX_ID.

  APPEND GR_ZIDCODE.





SELECTION-SCREEN BEGIN OF BLOCK B1 WITH FRAME.

  SELECT-OPTIONS : S_ORDNO FOR ZEDT23_100-ZORDNO.  "####

  SELECT-OPTIONS : S_IDCODE FOR ZEDT23_100-ZIDCODE NO INTERVALS NO-EXTENSION. "##ID

  SELECT-OPTIONS : S_MATNR FOR ZEDT23_100-ZMATNR.  "####

  SELECT-OPTIONS : S_JDATE FOR ZEDT23_100-ZJDATE MODIF ID M1.  "####(####)

  SELECT-OPTIONS : S_DDATE FOR ZEDT23_101-ZDDATE MODIF ID M2.  "####

SELECTION-SCREEN END OF BLOCK B1.



SELECTION-SCREEN BEGIN OF BLOCK B2 WITH FRAME.

  PARAMETERS : P_R1 RADIOBUTTON GROUP R1 USER-COMMAND UC1 DEFAULT 'X'.  "####

  PARAMETERS : P_R2 RADIOBUTTON GROUP R1. "####

SELECTION-SCREEN END OF BLOCK B2.



SELECTION-SCREEN BEGIN OF BLOCK B3 WITH FRAME.

  PARAMETERS : P_CHECK AS CHECKBOX DEFAULT TRUE. "######

SELECTION-SCREEN END OF BLOCK B3.



INITIALIZATION.

  PERFORM GET_DATE.

  S_JDATE-LOW = ZFIRST_DAY.

  S_JDATE-HIGH = ZLAST_DAY.

  S_JDATE-SIGN = 'I'.

  APPEND S_JDATE.

  S_DDATE-LOW = ZFIRST_DAY.

  S_DDATE-HIGH = ZLAST_DAY.

  S_DDATE-SIGN = 'I'.

  APPEND S_DDATE.





AT SELECTION-SCREEN OUTPUT.

  LOOP AT SCREEN.

    IF SCREEN-GROUP1 = 'M2'.  "####"

      IF P_R1 = TRUE.

        SCREEN-ACTIVE = '0'.

      ELSEIF P_R2 = TRUE.

        SCREEN-ACTIVE = '1'.

      ENDIF.

      MODIFY SCREEN.

     ENDIF.



     IF SCREEN-GROUP1 = 'M1'. "####

       IF P_R1 = TRUE.

         SCREEN-ACTIVE = '1'.

       ELSEIF P_R2 = TRUE.

         SCREEN-ACTIVE = '0'.

       ENDIF.

       MODIFY SCREEN.

     ENDIF.

   ENDLOOP.





START-OF-SELECTION.

" ## ID # ## # # #

  IF S_IDCODE[] IS NOT INITIAL.

    LOOP AT S_IDCODE INTO DATA(line).

       READ TABLE GR_ZIDCODE WITH KEY low = line-low TRANSPORTING NO FIELDS.

         IF SY-SUBRC <> 0.

           MESSAGE '#### ## ## ID ###.' TYPE 'E'.

         ENDIF.

    ENDLOOP.

  ENDIF.



  IF P_R1 EQ TRUE. "#### ##

    PERFORM GET_100DATA.

    PERFORM VALUE_TO_DSCRIPT_100.

    PERFORM WRITE_100DATA.

   ENDIF.



   IF P_R2 EQ TRUE.  "#### ##

     PERFORM GET_101DATA.

     PERFORM VALUE_TO_DSCRIPT_101.

     PERFORM WRITE_101DATA.

   ENDIF.





FORM GET_DATE.

  DATA :LV_YEAR TYPE I,

        LV_MONTH TYPE I,

        LV_NEXT_MONTH TYPE SY-DATUM.



  ZFIRST_DAY = SY-DATUM.

  ZFIRST_DAY+6(2) = '01'.



  LV_YEAR = ZFIRST_DAY+0(4).

  LV_MONTH = ZFIRST_DAY+4(2).

  IF LV_MONTH = 12.

    LV_NEXT_MONTH = |{ LV_YEAR + 1 }0101 |.

  ELSE.

    LV_NEXT_MONTH = |{ LV_YEAR }{ LV_MONTH + 1 WIDTH = 2 PAD = '0' }01 |.

  ENDIF.

  ZLAST_DAY = LV_NEXT_MONTH - 1.



ENDFORM.



" Search ### ## DATA ####

FORM GET_100DATA.

  IF P_CHECK EQ TRUE. "#### ##

    SELECT * FROM ZEDT23_100

      INTO CORRESPONDING FIELDS OF TABLE GT_ZEDT100

      WHERE ZORDNO IN S_ORDNO

      AND ZIDCODE IN S_IDCODE

      AND ZMATNR IN S_MATNR

      AND ZJDATE IN S_JDATE.

  ELSE. "#### ###

    SELECT * FROM ZEDT23_100

      INTO CORRESPONDING FIELDS OF TABLE GT_ZEDT100

      WHERE ZORDNO IN S_ORDNO

      AND ZIDCODE IN S_IDCODE

      AND ZMATNR IN S_MATNR

      AND ( ( ZJDATE IN S_JDATE ) AND ( ZSALE_FG EQ 1 ) ).

  ENDIF.

ENDFORM.



" Search ### ## DATA ####

FORM GET_101DATA.

  IF P_CHECK EQ TRUE.  "#### ##

    SELECT * FROM ZEDT23_101

      INTO CORRESPONDING FIELDS OF TABLE GT_ZEDT101

      WHERE ZORDNO IN S_ORDNO

      AND ZIDCODE IN S_IDCODE

      AND ZMATNR IN S_MATNR

      AND ZDDATE IN S_DDATE.

  ELSE. "#### ###

    SELECT * FROM ZEDT23_101

      INTO CORRESPONDING FIELDS OF TABLE GT_ZEDT101

      WHERE ZORDNO IN S_ORDNO

      AND ZIDCODE IN S_IDCODE

      AND ZMATNR IN S_MATNR

      AND ( ( ZDDATE IN S_DDATE ) AND ( ZFLAG NE 'X' ) ).

  ENDIF.

ENDFORM.



" ### ##

FORM WRITE_100DATA.

  WRITE : '#######'.

  ULINE AT /01(160).

  IF P_CHECK EQ TRUE. "#### ##

    WRITE : /01 '|', 02(10) '####' CENTERED,

    12 '|', 13(10) 'ID' CENTERED,

    23 '|', 24(10) '####' CENTERED,

    34 '|', 35(20) '###' CENTERED,

    55 '|', 56(10) '####' CENTERED,

    76 '|', 77(5) '##' CENTERED,

    82 '|', 83(5) '##' CENTERED,

    88 '|', 89(10) '####' CENTERED,

    99 '|', 100(10) '####' CENTERED,

    110 '|', 111(10) '####' CENTERED,

    121 '|', 122(5) '##' CENTERED,

    127 '|', 128(10) '####' CENTERED,

    138 '|', 139(10) '####' CENTERED,

    149 '|', 150(10) '####' CENTERED,

    160 '|'.

    ULINE AT /01(160).



    LOOP AT GT_ZEDT100 INTO DATA(line).

      WRITE : /01 '|', 02(10) line-ZORDNO CENTERED,

      12 '|', 13(10) line-ZIDCODE CENTERED,

      23 '|', 24(10) line-ZMATNR CENTERED,

      34 '|', 35(20) line-ZMATNAME CENTERED,

      55 '|', 56(10) line-ZMTART_STR CENTERED,

      76 '|', 77(5) line-ZVOLUM CENTERED,

      82 '|', 83(5) line-VRKME CENTERED,

      88 '|', 89(10) line-ZNSAMT CENTERED CURRENCY 'KRW',

      99 '|', 100(10) line-ZSLAMT CENTERED CURRENCY 'KRW',

      110 '|', 111(10) line-ZDCAMT CENTERED CURRENCY 'KRW',

      121 '|', 122(5) line-ZSALE_FG_STR CENTERED,

      127 '|', 128(10) line-ZJDATE CENTERED,

      138 '|', 139(10) line-ZRET_FG_STR CENTERED,

      149 '|', 150(10) line-ZRDATE_STR CENTERED,

      160 '|'.

      ULINE AT /01(160).

    ENDLOOP.



  ELSE. "#### ###

    WRITE : /01 '|', 02(10) '####' CENTERED,

    12 '|', 13(10) 'ID' CENTERED,

    23 '|', 24(10) '####' CENTERED,

    34 '|', 35(20) '###' CENTERED,

    55 '|', 56(10) '####' CENTERED,

    76 '|', 77(5) '##' CENTERED,

    82 '|', 83(5) '##' CENTERED,

    88 '|', 89(10) '####' CENTERED,

    99 '|', 100(10) '####' CENTERED,

    110 '|', 111(10) '####' CENTERED,

    121 '|', 122(5) '##' CENTERED,

    127 '|', 128(10) '####' CENTERED,

    138 '|'.

    ULINE AT /01(138).



    LOOP AT GT_ZEDT100 INTO DATA(line2).

      WRITE : /01 '|', 02(10) line2-ZORDNO CENTERED,

      12 '|', 13(10) line2-ZIDCODE CENTERED,

      23 '|', 24(10) line2-ZMATNR CENTERED,

      34 '|', 35(20) line2-ZMATNAME CENTERED,

      55 '|', 56(10) line2-ZMTART_STR CENTERED,

      76 '|', 77(5) line2-ZVOLUM CENTERED,

      82 '|', 83(5) line2-VRKME CENTERED,

      88 '|', 89(10) line2-ZNSAMT CENTERED CURRENCY 'KRW',

      99 '|', 100(10) line2-ZSLAMT CENTERED CURRENCY 'KRW',

      110 '|', 111(10) line2-ZDCAMT CENTERED CURRENCY 'KRW',

      121 '|', 122(5) line2-ZSALE_FG_STR CENTERED,

      127 '|', 128(10) line2-ZJDATE CENTERED,

      138 '|'.

      ULINE AT /01(138).

    ENDLOOP.



  ENDIF.

ENDFORM.





FORM WRITE_101DATA.

  WRITE : '#######'.

  ULINE AT /01(143).

  IF P_CHECK EQ TRUE. "#### ##

    WRITE : /01 '|', 02(10) '####' CENTERED,

    12 '|', 13(10) 'ID' CENTERED,

    23 '|', 24(10) '####' CENTERED,

    34 '|', 35(20) '###' CENTERED,

    55 '|', 56(10) '####' CENTERED,

    76 '|', 77(5) '##' CENTERED,

    82 '|', 83(5) '##' CENTERED,

    88 '|', 89(10) '####' CENTERED,

    99 '|', 100(10) '####' CENTERED,

    110 '|', 111(10) '##' CENTERED,

    121 '|', 122(10) '####' CENTERED,

    132 '|', 133(10) '####' CENTERED,

    143 '|'.

    ULINE AT /01(143).



    LOOP AT GT_ZEDT101 INTO DATA(line).

      WRITE : /01 '|', 02(10) line-ZORDNO CENTERED,

      12 '|', 13(10) line-ZIDCODE CENTERED,

      23 '|', 24(10) line-ZMATNR CENTERED,

      34 '|', 35(20) line-ZMATNAME CENTERED,

      55 '|', 56(10) line-ZMTART_STR CENTERED,

      76 '|', 77(5) line-ZVOLUM CENTERED,

      82 '|', 83(5) line-VRKME CENTERED,

      88 '|', 89(10) line-ZSLAMT CENTERED CURRENCY 'KRW',

      99 '|', 100(10) line-ZDFLAG_STR CENTERED,

      110 '|', 111(10) line-ZDGUBUN_STR CENTERED,

      121 '|', 122(10) line-ZDDATE CENTERED,

      132 '|', 133(10) line-ZRDATE_STR CENTERED,

      143 '|'.

      ULINE AT /01(143).

    ENDLOOP.



  ELSE. "#### ###

    WRITE : /01 '|', 02(10) '####' CENTERED,

    12 '|', 13(10) 'ID' CENTERED,

    23 '|', 24(10) '####' CENTERED,

    34 '|', 35(20) '###' CENTERED,

    55 '|', 56(10) '####' CENTERED,

    76 '|', 77(5) '##' CENTERED,

    82 '|', 83(5) '##' CENTERED,

    88 '|', 89(10) '####' CENTERED,

    99 '|', 100(10) '####' CENTERED,

    110 '|', 111(10) '##' CENTERED,

    121 '|', 122(10) '####' CENTERED,

    132 '|'.

    ULINE AT /01(132).



    LOOP AT GT_ZEDT101 INTO DATA(line2).

      WRITE : /01 '|', 02(10) line2-ZORDNO CENTERED,

      12 '|', 13(10) line2-ZIDCODE CENTERED,

      23 '|', 24(10) line2-ZMATNR CENTERED,

      34 '|', 35(20) line2-ZMATNAME CENTERED,

      55 '|', 56(10) line2-ZMTART_STR CENTERED,

      76 '|', 77(5) line2-ZVOLUM CENTERED,

      82 '|', 83(5) line2-VRKME CENTERED,

      88 '|', 89(10) line2-ZSLAMT CENTERED CURRENCY 'KRW',

      99 '|', 100(10) line2-ZDFLAG_STR CENTERED,

      110 '|', 111(10) line2-ZDGUBUN_STR CENTERED,

      121 '|', 122(10) line2-ZDDATE CENTERED,

      132 '|'.

      ULINE AT /01(132).

    ENDLOOP.



  ENDIF.

ENDFORM.



" Value# Description## ### ##

FORM VALUE_TO_DSCRIPT_100.

  LOOP AT GT_ZEDT100 INTO DATA(line).

    CASE line-ZMTART.

      WHEN '001'.

        line-ZMTART_STR = '##'.

      WHEN '002'.

        line-ZMTART_STR = '##'.

      WHEN '003'.

        line-ZMTART_STR = '##'.

      WHEN '004'.

        line-ZMTART_STR = '##'.

      WHEN '005'.

        line-ZMTART_STR = '##'.

      WHEN '006'.

        line-ZMTART_STR = '###'.

      WHEN OTHERS.

    ENDCASE.



    CASE line-ZSALE_FG.

      WHEN '1'.

        line-ZSALE_FG_STR = '##'.

      WHEN '2'.

        line-ZSALE_FG_STR = '##'.

      WHEN OTHERS.

    ENDCASE.



    CASE line-ZRET_FG.

      WHEN '1'.

        line-ZRET_FG_STR = '####'.

        line-ZRDATE_STR = line-ZRDATE+0(4) && '.' && line-ZRDATE+4(2) && '.' && line-ZRDATE+6(2).

      WHEN '2'.

        line-ZRET_FG_STR = '####'.

        line-ZRDATE_STR = line-ZRDATE+0(4) && '.' && line-ZRDATE+4(2) && '.' && line-ZRDATE+6(2).

      WHEN '3'.

        line-ZRET_FG_STR = '####'.

        line-ZRDATE_STR = line-ZRDATE+0(4) && '.' && line-ZRDATE+4(2) && '.' && line-ZRDATE+6(2).

      WHEN OTHERS.  "#### 0000.00.00"

        line-ZRDATE_STR = ' '.

    ENDCASE.



    MODIFY GT_ZEDT100 FROM line

    TRANSPORTING ZMTART_STR ZSALE_FG_STR ZRET_FG_STR ZRDATE_STR

    WHERE ZORDNO = line-ZORDNO.



  ENDLOOP.

ENDFORM.





FORM VALUE_TO_DSCRIPT_101.

  LOOP AT GT_ZEDT101 INTO DATA(line).

    CASE line-ZMTART.

      WHEN '001'.

        line-ZMTART_STR = '##'.

      WHEN '002'.

        line-ZMTART_STR = '##'.

      WHEN '003'.

        line-ZMTART_STR = '##'.

      WHEN '004'.

        line-ZMTART_STR = '##'.

      WHEN '005'.

        line-ZMTART_STR = '##'.

      WHEN '006'.

        line-ZMTART_STR = '###'.

      WHEN OTHERS.

    ENDCASE.



    CASE line-ZDFLAG.

      WHEN '1'.

        line-ZDFLAG_STR = '####'.

      WHEN '2'.

        line-ZDFLAG_STR = '###'.

      WHEN '3'.

        line-ZDFLAG_STR = '####'.

      WHEN OTHERS.

    ENDCASE.



    CASE line-ZDGUBUN.

      WHEN '1'.

        line-ZDGUBUN_STR = '###'.

      WHEN '2'.

        line-ZDGUBUN_STR = '###'.

      WHEN '3'.

        line-ZDGUBUN_STR = '###'.

      WHEN '4'.

        line-ZDGUBUN_STR = '###'.

      WHEN '5'.

        line-ZDGUBUN_STR = '###'.

      WHEN '6'.

        line-ZDGUBUN_STR = '###'.

      WHEN '7'.

        line-ZDGUBUN_STR = '###'.

      WHEN OTHERS.

    ENDCASE.



    CASE line-ZFLAG.

      WHEN TRUE.

        line-ZDFLAG_STR = ' '.

        line-ZRDATE_STR = line-ZRDATE+0(4) && '.' && line-ZRDATE+4(2) && '.' && line-ZRDATE+6(2).

      WHEN OTHERS.

        line-ZRDATE_STR = ' '.

    ENDCASE.



    MODIFY GT_ZEDT101 FROM line

    TRANSPORTING ZMTART_STR ZDFLAG_STR ZDGUBUN_STR ZRDATE_STR

    WHERE ZORDNO = line-ZORDNO.



  ENDLOOP.

ENDFORM.








*Messages

*----------------------------------------------------------

*

* Message class: Hard coded

*   #### ## ## ID ###.