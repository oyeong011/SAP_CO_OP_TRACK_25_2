
*&---------------------------------------------------------------------*

*& Report ZEDR05_PRACTICE002

*&---------------------------------------------------------------------*

*&

*&---------------------------------------------------------------------*




REPORT ZEDR05_PRACTICE002.




*0. ## #### ## ####

*1. ##### ## ###### ##

*2. DATA# ### #, ## ### #### #### #### (### COPY###)

*3. COLLECT 1# ## ##

*4. READ~COMPAIRNG 1### ##

*5. EXIT, CONTINUE, STOP, CHECK ## 1# ## ##

*6. MODIFY# ## ## ##

*7. LOOP# MODIFY#, WRITE### #### # 2## ##

*------------------------------------------------------------------------------

*8. ### ### ## ## ### ##### #### ##

*9. ##(ZEDT00_004) # D## F# 1# ##### ### ######

* (# ###### #### ##, ##, ### ###### ## ## ### # ### ## ##### ##)

*10. ###### ### #### ### ## # ## #### ###

*11. ####(ZEDT00_002)# ## ## # ### #####(ZEDT00_004)# ## ### ### ####### ##

*12. ### ###(ZEDT00_004-ZSUM) ##, ### ###(ZEDT00_004-ZSUM)  ## ##

* (# ###### #### ##, ##, ### ###### ## ## ###  # ### ###### # ##### ## ZSUM## ####)

*13. ### #### ####, # ## ##

*------------------------------------------------------------------------------










"------------------------------------------------------------------

" ## ### #### ##

DATA : BEGIN OF GS_STUDENT,

  ZCODE LIKE ZEDT05_001-ZCODE, " ####

  ZKNAME LIKE ZEDT05_001-ZKNAME, " ####

  ZMNAME LIKE ZEDT05_002-ZMNAME, " ####

  ZMOVEMAJOR TYPE I VALUE 0, " ####

  ZTEL LIKE ZEDT05_001-ZTEL, " ####

  ZWARNING TYPE I VALUE 0, " #### ##

  ZSUM LIKE ZEDT05_004-ZSUM, " ##

  ZGRADE LIKE ZEDT05_004-ZGRADE, " ##

  ZGENDER LIKE ZEDT05_001-ZGENDER, " ##

  END OF GS_STUDENT.



" ### ### ###

DATA : BEGIN OF GS_SUM,

  ZGENDER LIKE ZEDT05_001-ZGENDER,

  ZSUM LIKE ZEDT05_002-ZSUM,

  END OF GS_SUM.








*##, ### ### ### ##




DATA : GT_STUDENT LIKE TABLE OF GS_STUDENT.

DATA : GT_SUM LIKE TABLE OF GS_SUM.



" # ZEDT# ## # ### ### ##

"------------------------------------------------------------------

DATA : GS_ZEDT001 TYPE ZEDT05_001.

DATA : GT_ZEDT001 LIKE TABLE OF GS_ZEDT001.



DATA : GS_ZEDT002 TYPE ZEDT05_002.

DATA : GT_ZEDT002 LIKE TABLE OF GS_ZEDT002.



DATA : GS_ZEDT004 TYPE ZEDT05_004.

DATA : GT_ZEDT004 LIKE TABLE OF GS_ZEDT004.

"------------------------------------------------------------------



CLEAR : GT_ZEDT001, GT_ZEDT002, GT_ZEDT004, GS_STUDENT, GT_STUDENT.





"------------------------------------------------------------------



" ## ### ##

GS_SUM-ZGENDER = 'M'.

APPEND GS_SUM TO GT_SUM.



GS_SUM-ZGENDER = 'F'.

APPEND GS_SUM TO GT_SUM.







" ZEDT ### ##



"------------------------------------------------------------------




* ZCODE ZPERNR  ZKNAME  ZENAME  ZGENDER ZTEL




SELECT * FROM ZEDT00_001

INTO CORRESPONDING FIELDS OF TABLE GT_ZEDT001.






*ZCODE  ZPERNR  ZMAJOR  ZMNAME  ZMGUBUN ZUM ZWAERS




SELECT * FROM ZEDT00_002

INTO CORRESPONDING FIELDS OF TABLE GT_ZEDT002.






*ZCODE  ZPERNR  ZSCHOOL ZSEM  ZEXAM ZMAJOR  ZMNAME  ZSUM  ZWAERS  ZGRADE




SELECT * FROM ZEDT00_004

INTO CORRESPONDING FIELDS OF TABLE GT_ZEDT004.

"------------------------------------------------------------------





" zcode### ##

SORT GT_ZEDT001 BY ZCODE.

SORT GT_ZEDT002 BY ZCODE.



" ### #### ##

SORT GT_ZEDT004 BY ZCODE ASCENDING ZGRADE DESCENDING.



" ### #### ## ## ### ### ###

DELETE ADJACENT DUPLICATES FROM GT_ZEDT004 COMPARING ZCODE.











LOOP AT GT_ZEDT002 INTO GS_ZEDT002.






*### ### ## ## ### ##### #### ##




  CLEAR : GS_STUDENT.

  READ TABLE GT_ZEDT004 WITH KEY ZCODE = GS_ZEDT002-ZCODE INTO GS_ZEDT004.

  IF SY-SUBRC NE 0.

    CONTINUE.

  ENDIF.






*  ####(ZEDT00_002)# ## ## # ### #####(ZEDT00_004)# ## ### ### ####### ##




  IF GS_ZEDT002-ZMAJOR NE GS_ZEDT004-ZMAJOR.

    GS_STUDENT-ZMOVEMAJOR = 1.

  ENDIF.








*  ##(ZEDT00_004) # D## F# 1# ##### ### ######

*  ###### ### #### ### ## # ## #### ###




  IF GS_ZEDT004-ZGRADE = 'D' OR GS_ZEDT004-ZGRADE = 'F'.

    GS_STUDENT-ZWARNING = 1.

  ENDIF.








* 001## zkname, ztel, gender## ####




  READ TABLE GT_ZEDT001 WITH KEY ZCODE = GS_ZEDT004-ZCODE INTO GS_ZEDT001 TRANSPORTING ZKNAME ZTEL ZGENDER.

  GS_STUDENT-ZKNAME = GS_ZEDT001-ZKNAME.

  GS_STUDENT-ZTEL = GS_ZEDT001-ZTEL.

  GS_STUDENT-ZGENDER = GS_ZEDT001-ZGENDER.

  MOVE-CORRESPONDING GS_ZEDT004 TO GS_STUDENT.



  APPEND GS_STUDENT TO GT_STUDENT.



" ZSUM###

 GS_SUM-ZSUM = GS_ZEDT004-ZSUM.

 GS_SUM-ZGENDER = GS_STUDENT-ZGENDER.

 IF GS_STUDENT-ZGENDER = 'F'.

  COLLECT GS_SUM INTO GT_SUM.

 ELSEIF GS_STUDENT-ZGENDER = 'M'.

  COLLECT GS_SUM INTO GT_SUM.

  ENDIF.

ENDLOOP.









" ## ##

LOOP AT GT_STUDENT INTO GS_STUDENT.



  "## ##

 AT FIRST.

    WRITE: / '-----------------------------------------------------------------'.

    WRITE: / '|', ' ####', 14 '|', ' ##',  23 '|', '  ####',  38 '|', '   ####',  55 '|' , '  ##', 65 '|'.

    WRITE: / '-----------------------------------------------------------------'.

  ENDAT.





  WRITE : / '|', GS_STUDENT-ZCODE.

  WRITE : 14 '|', GS_STUDENT-ZKNAME , 23 '|'.

  IF GS_STUDENT-ZMOVEMAJOR = 1. " ###### ##

    WRITE : '  ####'.

  ENDIF.

  IF GS_STUDENT-ZWARNING = 1. " ##### ##

    WRITE : 38 '|', GS_STUDENT-ZTEL.

    WRITE : 55 '|', '####'.

  ELSE.

     WRITE : 38 '|',  55 '|'.

  ENDIF.

     WRITE : 65 '|'.



WRITE: / '-----------------------------------------------------------------'.



  AT LAST. " ###### ### ##

    READ TABLE GT_SUM WITH KEY ZGENDER = 'M' INTO GS_SUM TRANSPORTING ZSUM.

    GS_SUM-ZSUM = GS_SUM-ZSUM * 100.

    WRITE : / '###### : ', GS_SUM-ZSUM currency 'krw' DECIMALS 0.



    READ TABLE GT_SUM WITH KEY ZGENDER = 'F' INTO GS_SUM TRANSPORTING ZSUM.

    GS_SUM-ZSUM = GS_SUM-ZSUM * 100.

    WRITE : / '###### : ', GS_SUM-ZSUM currency 'krw' DECIMALS 0.

  ENDAT.

ENDLOOP.