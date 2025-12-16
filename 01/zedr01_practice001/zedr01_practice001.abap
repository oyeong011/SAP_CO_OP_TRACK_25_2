
*&---------------------------------------------------------------------------------------------------------*

*& Report LOOP ## (AT ##)

*&---------------------------------------------------------------------------------------------------------*






REPORT ZEDR01_PRACTICE001.






*&---------------------------------------------------------------------------------------------------------*




" ### ### ### ##

DATA : BEGIN OF GS_WRITE_STUDENT,                                     " ### ### ##"

  ZCODE LIKE ZEDT00_004-ZCODE,                                        " #### "

  ZMNAME LIKE ZEDT00_004-ZMNAME,                                      " ### "

  ZFLAG LIKE ZEDT00_004-ZFLAG,                                        " #### "

  ZWAERS LIKE ZEDT00_004-ZWAERS,                                      " ### "

  ZAMOUNT LIKE ZEDT00_004-ZAMOUNT,                                    " #### "

  END OF GS_WRITE_STUDENT.

DATA : GT_WRITE_STUDENT LIKE TABLE OF GS_WRITE_STUDENT.               " ### ### ## "




*&---------------------------------------------------------------------------------------------------------*




" ### ### ### ##

DATA: GS_STUDENT TYPE ZEDT00_004,                                     " ### ### ## "

      GT_GRADE TYPE TABLE OF ZEDT00_004.                              " ### ### ## "

SELECT * FROM ZEDT00_004 INTO CORRESPONDING FIELDS OF TABLE GT_GRADE. " ZEDT00_004# ### GT_GRADE# COPY




*&---------------------------------------------------------------------------------------------------------*




" ### ## ## (## ## , ## )

DATA : LV_CODE LIKE ZEDT00_004-ZCODE,            " ## ## "

       LV_MNAME LIKE ZEDT00_004-ZMNAME,          " #### "

       LV_WAERS LIKE ZEDT00_004-ZWAERS,          " ### "

       LV_AMOUNT LIKE ZEDT00_004-ZAMOUNT,        " ## ## "

       LV_TOTAL_PAY LIKE ZEDT00_004-ZAMOUNT,     " ## ## "

       LV_ZSCHOOL LIKE ZEDT00_004-ZSCHOOL,       " ## "

       LV_RATE TYPE p DECIMALS 2,                " ### "

       LV_FLAG_ALL_A TYPE i.                     " #### ## 0 : ## X , 1 : ## O "

CONSTANTS:

       C_DISCOUNT_UG TYPE p DECIMALS 2 VALUE '0.20',  " ###   ### "

       C_DISCOUNT_GS TYPE p DECIMALS 2 VALUE '0.10'.  " #### ### "




*&---------------------------------------------------------------------------------------------------------*




" ### LOOP "

SORT GT_GRADE BY ZPERNR ZGRADE. "## # SORT "

LOOP AT GT_GRADE INTO GS_STUDENT.

" #### ### "

  LV_CODE = GS_STUDENT-ZCODE.      " #### "

  LV_MNAME = GS_STUDENT-ZMNAME.    " #### "

  LV_WAERS = GS_STUDENT-ZWAERS.    " ### "

  LV_ZSCHOOL = GS_STUDENT-ZSCHOOL. " ## "

  LV_AMOUNT = GS_STUDENT-ZSUM.

 AT NEW ZPERNR.                 " ##### ##### ## "

   IF LV_ZSCHOOL = 'A'.         " ## ## A : ### B : #### "

     LV_RATE = C_DISCOUNT_UG.   " ### ### ## "

   ELSEIF LV_ZSCHOOL = 'B'.

     LV_RATE = C_DISCOUNT_GS.   " #### ### ## "

   ELSE.

     LV_RATE = 0.               " ## ## "

     WRITE /'#### 0001 ####'.

   ENDIF.

 ENDAT.

" #### ## ZGRADE SORT ## "

 IF GS_STUDENT-ZGRADE <> 'A'.   " LOOP## 1#### A# ### ### x "

   LV_FLAG_ALL_A = 0.

 ELSE.

   LV_FLAG_ALL_A = 1.

 ENDIF.



 AT END OF ZPERNR.

   " #### ##### #### ## ## ## "

   LV_AMOUNT = LV_AMOUNT - ( LV_AMOUNT * LV_RATE * LV_FLAG_ALL_A ). " #### = ##### - ### "

   " MODIFY APPEND # ## ### "

   GS_STUDENT-ZAMOUNT = LV_AMOUNT.                                  " #### ### "

   IF LV_FLAG_ALL_A = 1.                                            " ### O "

     GS_STUDENT-ZFLAG = 'X'.

   ELSEIF LV_FLAG_ALL_A = 0.                                        " ### X "

     GS_STUDENT-ZFLAG = ' '.

   ELSE.                                                            " ## ## "

     WRITE /'#### 0002 #### ##'.

   ENDIF.

   " ### #### ##### ## ### MODIFY "

   MODIFY GT_GRADE FROM GS_STUDENT TRANSPORTING ZAMOUNT.            " ### ## "

   MODIFY GT_GRADE FROM GS_STUDENT TRANSPORTING ZFLAG.              " #### ## "

   " ### #### ### "

   GS_WRITE_STUDENT-ZCODE = LV_CODE.                                " #### "

   GS_WRITE_STUDENT-ZMNAME = LV_MNAME.                              " ### "

   GS_WRITE_STUDENT-ZFLAG = GS_STUDENT-ZFLAG.                       " #### "

   GS_WRITE_STUDENT-ZWAERS = LV_WAERS.                              " ### "

   IF LV_WAERS = 'KRW'.

     GS_WRITE_STUDENT-ZAMOUNT = LV_AMOUNT * 100.                    " ### "

   ELSE.

     WRITE : / '#### 0003 NOT KRW '.

   ENDIF.

   " ### #### APPEND "

   APPEND GS_WRITE_STUDENT TO GT_WRITE_STUDENT.

 ENDAT.

ENDLOOP.






*&---------------------------------------------------------------------------------------------------------*




" ###,### TABLE #### "

SORT GT_GRADE BY ZCODE ASCENDING ZAMOUNT DESCENDING.

SORT GT_WRITE_STUDENT BY ZCODE.



DELETE ADJACENT DUPLICATES FROM GT_GRADE COMPARING ZCODE.            " ## ## "

DELETE ADJACENT DUPLICATES FROM GT_WRITE_STUDENT COMPARING ZCODE.    " ## ## "




*&---------------------------------------------------------------------------------------------------------*




" ### LOOP "



DATA LV_SUM_TEXT TYPE C LENGTH 10 VALUE '#    #'.                                   " ### TEXT ## "



SORT GT_WRITE_STUDENT BY ZCODE.

LOOP AT GT_WRITE_STUDENT INTO GS_WRITE_STUDENT.

  AT FIRST.                                                                         " HEADER ## - Text Element ## ## "

    WRITE : SY-ULINE(70).

    WRITE : / SY-VLINE ,TEXT-000 CENTERED,                                          " #### "

           15 SY-VLINE ,TEXT-001 CENTERED,                                          " ### "

           40 SY-VLINE ,TEXT-002 CENTERED,                                           " #### "

           50 SY-VLINE ,TEXT-003 CENTERED,                                          " #### "

           70 SY-VLINE.

    WRITE : / SY-ULINE(70).

  ENDAT.

                                                                                     " BODY ## "

  WRITE : / SY-VLINE ,GS_WRITE_STUDENT-ZCODE UNDER TEXT-000,                         " #### "

           15 SY-VLINE ,GS_WRITE_STUDENT-ZMNAME UNDER TEXT-001,                      " ### "

           40 SY-VLINE ,GS_WRITE_STUDENT-ZFLAG UNDER TEXT-002,                       " #### "

           50 SY-VLINE ,GS_WRITE_STUDENT-ZAMOUNT CENTERED DECIMALS 0 UNDER TEXT-003, " #### "

           70 SY-VLINE.

  WRITE : / SY-ULINE(70).

  LV_TOTAL_PAY = LV_TOTAL_PAY + GS_WRITE_STUDENT-ZAMOUNT.                             " ## = ## + ### ## ### "



  AT LAST.                                                                            " ## ## "

    WRITE: / SY-VLINE NO-GAP,

             LV_SUM_TEXT UNDER TEXT-001,                                              " ## ###(### # ##)

             50 SY-VLINE, LV_TOTAL_PAY CENTERED DECIMALS 0 UNDER TEXT-003,

             70 SY-VLINE.

    WRITE :  / SY-ULINE(70).

  ENDAT.

ENDLOOP.