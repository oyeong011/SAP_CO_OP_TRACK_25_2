
*&---------------------------------------------------------------------*

*& Report ZEDR16_PRACTICE001

*&---------------------------------------------------------------------*

*&

*&---------------------------------------------------------------------*




REPORT ZEDR16_PRACTICE001.



" (1) #### ## ##

DATA GT_GRADE TYPE STANDARD TABLE OF ZEDT16_004 WITH EMPTY KEY. "DATA gt_grade TYPE TABLE OF zedt16_004. -> ###.

DATA GS_GRADE TYPE ZEDT16_004. "DATA gs_grade LIKE LINE OF gt_grade. -> ###




*DATA : BEGIN OF gs_grade.

*  INCLUDE TYPE zedt16_004.

*  DATA END OF gs_grade.

*DATA : gt_grade like TABLE OF gs_grade.








" (2) ### ####

SELECT * FROM ZEDT16_004

  INTO CORRESPONDING FIELDS OF TABLE GT_GRADE.





" (9) ## ##

SORT GT_GRADE BY MANDT ZCODE ZPERNR ZSCHOOL ZSEM ZEXAM ZMAJOR ZMNAME ZSUM ZWAERS ZGRADE ZFLAG ZAMOUNT.

DELETE ADJACENT DUPLICATES FROM GT_GRADE COMPARING ALL FIELDS.





" LOOP # ##

SORT GT_GRADE BY ZCODE ZEXAM.



" ##### ## ##,#### ##

DATA: LV_ALL_A          TYPE ABAP_BOOL,      "### ## ### A##

      LV_AMT            TYPE ZEDT16_004-ZSUM,

      LV_CURRENT_SUM    TYPE ZEDT16_004-ZSUM,

      LV_CURRENT_SCHOOL TYPE ZEDT16_004-ZSCHOOL,

      LV_CURRENT_MNAME  TYPE ZEDT16_004-ZMNAME,

      GV_TOTAL          TYPE ZEDT16_004-ZAMOUNT.





LOOP AT GT_GRADE INTO GS_GRADE.




*  WRITE :/ gs_grade-zsum.

*  WRITE :/ 'hello'.




  " 3) AT FIRST

  AT FIRST.

    WRITE :/ '--------------------------------------------------------------------------'.

    WRITE :/ '|   ####   |          ###          |####|       ####      |'.

    WRITE :/ '--------------------------------------------------------------------------'.

  ENDAT.







  " 5) AT NEW zcode: # ## ## # ## A# ##

  AT NEW ZCODE.

    LV_ALL_A = ABAP_TRUE.

  ENDAT.



  " #### ## # #### A ### ### ##

  IF GS_GRADE-ZGRADE <> 'A'.

    LV_ALL_A = ABAP_FALSE.

  ENDIF.



  LV_CURRENT_SUM = GS_GRADE-ZSUM.

  LV_CURRENT_SCHOOL = GS_GRADE-ZSCHOOL.

  LV_CURRENT_MNAME = GS_GRADE-ZMNAME.






*  DATA: lv_temp_flag TYPE c LENGTH 1.

*  DATA: lv_temp_sum TYPE zedt16_004-zsum.






  " 6) AT END OF zcode: # ### ### # -> ## ## ## # ## ## modify

  AT END OF ZCODE.






*  lv_temp_flag = gs_grade-zflag.

*  write :/ lv_temp_flag.

*  lv_temp_sum = gs_grade-zsum.

*  write :/ lv_temp_sum.




    " ## ## ##

    IF LV_ALL_A = ABAP_TRUE.



      GS_GRADE-ZFLAG = 'X'.







      CLEAR LV_ALL_A.




*




    ELSE.

      GS_GRADE-ZFLAG = ''.

      CLEAR LV_ALL_A.

    ENDIF.





    " ## ## ##

    LV_AMT = LV_CURRENT_SUM.




*    WRITE :/ 'TEST1'.



*    WRITE :/ gs_grade-zsum.






    IF GS_GRADE-ZFLAG = 'X'.



      IF LV_CURRENT_SCHOOL = 'A'.



        LV_AMT = LV_CURRENT_SUM * '0.8'.





      ELSEIF LV_CURRENT_SCHOOL = 'B'.

        LV_AMT = LV_CURRENT_SUM * '0.9'.

      ENDIF.

    ENDIF.

    GS_GRADE-ZAMOUNT = LV_AMT.

    GS_GRADE-ZMNAME = LV_CURRENT_MNAME.



    CLEAR LV_AMT.



    " 7) MODIFY

    MODIFY GT_GRADE FROM GS_GRADE TRANSPORTING ZFLAG ZAMOUNT

           WHERE ZCODE = GS_GRADE-ZCODE.





    WRITE :/ '|  ', GS_GRADE-ZCODE, '|    ',GS_GRADE-ZMNAME,'|',  GS_GRADE-ZFLAG  ,'     |  ' ,GS_GRADE-ZAMOUNT CURRENCY 'KRW',' |'.

    WRITE :/ '--------------------------------------------------------------------------'.



    " ## ##

    GV_TOTAL = GV_TOTAL + GS_GRADE-ZAMOUNT.



  ENDAT.



  AT LAST.

    WRITE :/ '|' ,'               ','#      #','                     ','|'   ,'  ',    GV_TOTAL CURRENCY 'KRW'   ,'|'  .

    WRITE :/ '--------------------------------------------------------------------------'.

  ENDAT.



ENDLOOP.