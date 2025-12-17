
*&---------------------------------------------------------------------*

*& Report ZEDR06_PRACTICE001

*&---------------------------------------------------------------------*

*&

*&---------------------------------------------------------------------*




REPORT ZEDR06_PRACTICE001.






*&---------------------------------------------------------------------*




" ### STRUCTURE & INNERTABLE ##

DATA : GS_GRADE TYPE ZEDT06_004.

DATA : GT_GRADE TYPE TABLE OF ZEDT06_004.




*&---------------------------------------------------------------------*




" ### ## ##

CONSTANTS : GV_ZSCHOOL_A_SALE_PERCENT TYPE I VALUE 20.                      " ## ### 20% ## ##

CONSTANTS : GV_ZSCHOOL_B_SALE_PERCENT TYPE I VALUE 10.                      " ### ### 10% ## ##




*&---------------------------------------------------------------------*




" AT ## ### ### ### ##

DATA : GV_FLAG TYPE C.

DATA : GV_GRADE TYPE C.

DATA : GV_ZMNAME TYPE C LENGTH 20.                                          " ## ###

DATA : GV_ZSCHOOL TYPE C.                                                   " ## ####

DATA : GV_ZSUM TYPE P.                                                      " ## ####

DATA : GV_ZFLAG TYPE C.                                                     " ## ####

DATA : GV_ZAMOUNT TYPE I.                                                   " ## ###

DATA : GV_ALLSUM TYPE I VALUE 0.                                            " ### ##

DATA : GV_END TYPE C.




*&---------------------------------------------------------------------*




" ### ### ##

SELECT * FROM ZEDT06_004 INTO CORRESPONDING FIELDS OF TABLE GT_GRADE.

CLEAR : GS_GRADE.                                                           " GS_GRADE STRUCTURE ###

SORT GT_GRADE BY ZCODE ZPERNR ZGRADE.                                       " ZCODE, ZPERNR, ZGRADE ## ###### ## -> AT ## # ##.




*&---------------------------------------------------------------------*




" ## + ## : ## # EXAM# ### ## # ## ## # ### ## # ##

LOOP AT GT_GRADE INTO GS_GRADE.



  " 1.### ## ##

  AT FIRST.

    WRITE :/ '-----------------------------------------------------------------------'.

    WRITE :/ '|   ####   |          ###          |####|     ####     |'.

    WRITE :/ '-----------------------------------------------------------------------'.

  ENDAT.



  " # ## # ## ## ### ####

  GV_ZSCHOOL = GS_GRADE-ZSCHOOL.

  GV_ZSUM = GS_GRADE-ZSUM.

  GV_ZMNAME = GS_GRADE-ZMNAME.



  " ##### #### ## + ## ## TRUE# ##

  AT NEW ZCODE.

    GV_FLAG = 'X'.

  ENDAT.



  " A## #### #### FLASE# ##.

  IF GV_FLAG = 'X'.

    IF GS_GRADE-ZGRADE <> 'A'.

      GV_FLAG = ''.

    ENDIF.

  ENDIF.



  " 2. AT END OF # ## ### FLAG## ## # ## ##

  AT END OF ZCODE.

    GV_END = 'X'.



    " ### A# ## FLAG# X# #### ### ## ### ##.

    IF GV_FLAG = 'X'.

      GS_GRADE-ZFLAG = 'X'.



      " ### ## ### ### ZAMOUNT ##.

      IF GV_ZSCHOOL = 'A'.

        GS_GRADE-ZAMOUNT = GV_ZSUM * ( 100 - GV_ZSCHOOL_A_SALE_PERCENT ) / 100 * 100.

      ELSEIF GV_ZSCHOOL = 'B'.

        GS_GRADE-ZAMOUNT = GV_ZSUM * ( 100 - GV_ZSCHOOL_B_SALE_PERCENT ) / 100 * 100.

      ENDIF.

    ELSE.

      GS_GRADE-ZAMOUNT = GV_ZSUM * 100.

    ENDIF.



     " ZFLAG, ZAMOUNT# ## #### ##

     MODIFY GT_GRADE FROM GS_GRADE TRANSPORTING ZFLAG ZAMOUNT WHERE ZCODE = GS_GRADE-ZCODE.



     " ## # ZAMOUNT# ##.

     GV_ZAMOUNT = GS_GRADE-ZAMOUNT.

     GV_ALLSUM = GV_ALLSUM + GS_GRADE-ZAMOUNT.



     " ZFLAG# X# X## ### ## ## ##.

     IF GS_GRADE-ZFLAG = 'X'.

       GS_GRADE-ZFLAG = 'X'.

       GV_ZFLAG = 'X'.

     ELSE.

       GS_GRADE-ZFLAG = ' '.

       GV_ZFLAG = ' '.

     ENDIF.

     " 3. ### ## ##. (## # ## # ##)

     WRITE :/ '|  ', GS_GRADE-ZCODE, '|   ', GV_ZMNAME,' |',  GV_ZFLAG  ,'     |' , GV_ZAMOUNT, '     |'.

     WRITE :/ '-----------------------------------------------------------------------'.



     " GS_GRADE ###.

     CLEAR : GS_GRADE.



  ENDAT.



  " 4. ### ## ##

  AT LAST.

    WRITE :/ '|', '             ','#      #','                       ', '|','', GV_ALLSUM, '   |   '.

    WRITE :/ '-----------------------------------------------------------------------'.

  ENDAT.



ENDLOOP.