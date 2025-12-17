
*&---------------------------------------------------------------------*

*& Report ZEDR23_PRACTICE001

*&---------------------------------------------------------------------*

*&

*&---------------------------------------------------------------------*




REPORT ZEDR23_PRACTICE001.







" ##### ## Itable ##

DATA : GS_GRADE TYPE ZEDT23_004.

DATA : GT_GRADE TYPE TABLE OF ZEDT23_004.



" ZEDT00_004 #### #### GT_GRADE # COPY

SELECT * FROM ZEDT23_004

  INTO CORRESPONDING FIELDS OF TABLE GT_GRADE.





SORT GT_GRADE BY ZCODE.



DATA : zflag(1) TYPE C.

zflag = '1'.        " 1 = ### ##, 0 = ### ## ##

DATA : zschool(1) TYPE C.                " ZSCHOOL # ## ##

DATA : zsum TYPE P LENGTH 7 DECIMALS 2.  " ZSUM # ## ##



LOOP AT GT_GRADE INTO GS_GRADE.

  zschool = GS_GRADE-ZSCHOOL.

  zsum = GS_GRADE-ZSUM.



  AT FIRST.

    WRITE : / 'TITLE : LOOP## (AT##)', / .

  ENDAT.



  "##### ##

  AT NEW ZCODE.

      zflag = '1'.

  ENDAT.



  IF GS_GRADE-ZGRADE NE 'A'.

    zflag = '0'.

  ENDIF.



  "##### #

  AT END OF ZCODE.

    "### ##

    IF zflag EQ '1'.

      "ZFLAG = 1# # ###

      "### ## ##

      GS_GRADE-ZFLAG = 'X'.

      IF zschool EQ 'A'.  " ### (20## ##)

        GS_GRADE-ZAMOUNT = zsum * 80 / 100.

      ELSEIF zschool EQ 'B'. " #### (10## ##)

        GS_GRADE-ZAMOUNT = zsum * 90 / 100.

      ENDIF.

    "### ## ##

    ELSEIF zflag EQ '0'.

      GS_GRADE-ZAMOUNT = zsum.

      GS_GRADE-ZFLAG = ' '.

    ENDIF.

      MODIFY GT_GRADE FROM GS_GRADE TRANSPORTING ZFLAG ZAMOUNT

        WHERE ZCODE = GS_GRADE-ZCODE.

  ENDAT.



  "## ##

  AT LAST.

    DELETE ADJACENT DUPLICATES FROM GT_GRADE COMPARING ZCODE.

  ENDAT.



ENDLOOP.





CLEAR GS_GRADE.



zsum = 0.

SORT GT_GRADE BY ZCODE.



" ### ##

" ### # => LOOP ## # ## # # ###

LOOP AT GT_GRADE INTO GS_GRADE.

   zsum = zsum + GS_GRADE-ZAMOUNT.

  AT FIRST.

    WRITE :/ '--------------------------------------------------------------------------'.

    WRITE :/ '|   ####   |          ###          |####|       ####      |'.

    WRITE :/ '--------------------------------------------------------------------------'.

  ENDAT.



  WRITE :/ '|  ', GS_GRADE-ZCODE, '|    ',GS_GRADE-ZMNAME,'|',  GS_GRADE-ZFLAG  ,'     | ' ,     GS_GRADE-ZAMOUNT CURRENCY 'KRW',' |'.

  WRITE :/ '--------------------------------------------------------------------------'.



  AT LAST.

    WRITE :/ '|' ,'               ','#      #','                     ','|' ,'',  zsum CURRENCY 'KRW'  ,' ','|'  .

    WRITE :/ '--------------------------------------------------------------------------'.

  ENDAT.



ENDLOOP.