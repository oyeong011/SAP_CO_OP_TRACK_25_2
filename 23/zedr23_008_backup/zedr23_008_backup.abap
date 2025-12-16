
*&---------------------------------------------------------------------*

*& Report ZEDR23_008_BACKUP

*&---------------------------------------------------------------------*

*&

*&---------------------------------------------------------------------*




REPORT ZEDR23_008_BACKUP.







" ##### ## Itable ##

DATA : GS_GRADE TYPE ZEDT23_004.

DATA : GT_GRADE TYPE TABLE OF ZEDT23_004.



" ZEDT00_004 #### #### GT_GRADE # COPY

SELECT * FROM ZEDT00_004

  INTO CORRESPONDING FIELDS OF TABLE GT_GRADE.





SORT GT_GRADE BY ZCODE.



DATA : flag(1) TYPE C.

flag = '1'. " 1 = ###

DATA : school(1) TYPE C.

DATA : sum TYPE P LENGTH 7 DECIMALS 2.



LOOP AT GT_GRADE INTO GS_GRADE.

  school = GS_GRADE-ZSCHOOL.

  sum = GS_GRADE-ZSUM.



  AT FIRST.

    WRITE : / 'TITLE : LOOP## (AT##)', / .

  ENDAT.



  AT NEW ZCODE.

    "BREAK-POINT.

      flag = '1'.

  ENDAT.



  IF GS_GRADE-ZGRADE NE 'A'.

    flag = '0'.

  ENDIF.



  AT END OF ZCODE.

    "BREAK-POINT.

    IF flag EQ '1'.

      " BREAK-POINT.

      "ZFLAG = 1# # ###

      "### ##

      GS_GRADE-ZFLAG = 'X'.

      IF school EQ 'A'.  " ### (20## ##)

        GS_GRADE-ZAMOUNT = sum * 80 / 100.

      ELSEIF school EQ 'B'. " #### (10## ##)

        GS_GRADE-ZAMOUNT = sum * 90 / 100.

      ENDIF.

    ELSEIF flag EQ '0'.

      GS_GRADE-ZAMOUNT = sum.

      GS_GRADE-ZFLAG = ' '.

    ENDIF.

      MODIFY GT_GRADE FROM GS_GRADE TRANSPORTING ZFLAG ZAMOUNT

        WHERE ZCODE = GS_GRADE-ZCODE.

      "BREAK-POINT.

  ENDAT.



  AT LAST.

    DELETE ADJACENT DUPLICATES FROM GT_GRADE COMPARING ZCODE.

  ENDAT.



ENDLOOP.

"BREAK-POINT.



CLEAR GS_GRADE.





sum = 0.

SORT GT_GRADE BY ZCODE.



"4. WRITE DATA

LOOP AT GT_GRADE INTO GS_GRADE.

   sum = sum + GS_GRADE-ZAMOUNT.

  AT FIRST.

    WRITE :/ '--------------------------------------------------------------------------'.

    WRITE :/ '|   ####   |          ###          |####|       ####      |'.

    WRITE :/ '--------------------------------------------------------------------------'.

  ENDAT.



  WRITE :/ '|  ', GS_GRADE-ZCODE, '|    ',GS_GRADE-ZMNAME,'|',  GS_GRADE-ZFLAG  ,'     | ' ,     GS_GRADE-ZAMOUNT CURRENCY 'KRW',' |'.

  WRITE :/ '--------------------------------------------------------------------------'.



  AT LAST.

    WRITE :/ '|' ,'               ','#      #','                     ','|' ,'',  sum CURRENCY 'KRW'  ,' ','|'  .

    WRITE :/ '--------------------------------------------------------------------------'.

  ENDAT.



ENDLOOP.