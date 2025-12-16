
*&---------------------------------------------------------------------*

*& Report ZEDR09_011

*&---------------------------------------------------------------------*

*&

*&---------------------------------------------------------------------*




REPORT ZEDR09_011.








* =====================================================================

* INTERNAL TABLE ## 3##

* 1. TABLE KEY# ### # '##' ##

* 1. TABLE KEY# ### # '##' ##



* 2. WHERE ### ### '## ##' ##

* 3. INDEX# ### '# ##' ##

* =====================================================================



* ## ### ##### ### ###, ######




DATA : BEGIN OF GS_STUDENT, "### ##

  ZPERNR TYPE ZEDT09_001-ZPERNR, "#### - TYPE# ##? (#)

  ZCODE LIKE ZEDT09_001-ZCODE, "####

  ZKNAME LIKE ZEDT09_001-ZKNAME, "##

  ZENAME LIKE ZEDT09_001-ZENAME, "####

  ZGENDER LIKE ZEDT09_001-ZGENDER, "##

  ZGNAME TYPE C LENGTH 4, "####

  ZTEL LIKE ZEDT09_001-ZTEL, "####

END OF GS_STUDENT.






*DATA : GT_STUDENT LIKE TABLE OF GS_STUDENT. "###### ##

*

** modify ### ## ### 1# ##

*CLEAR : GS_STUDENT, GT_STUDENT.

*GS_STUDENT-ZPERNR = '0000000001'. "header ###

*GS_STUDENT-ZCODE = 'SSU-01'.

*GS_STUDENT-ZKNAME = '###'.

*GS_STUDENT-ZENAME = 'KANG'.

*GS_STUDENT-ZGENDER = 'F'. "M## F# ## ## ##

*GS_STUDENT-ZTEL = '01012345678'.

*APPEND GS_STUDENT TO GT_STUDENT.

*

*

** 1. TABLE KEY# ### # '##' ##

*

*GS_STUDENT-ZGENDER = 'M'.

*APPEND GS_STUDENT TO GT_STUDENT.



* ####

* => 1. GS_STUDENT ####, ### ### ##### (ZGENDER# F -> M) <-- ### #!

* => 2. GT_STUDENT ####, # ### GS_STUDENT ### ### ###!

*   => ###.. ## ### # ## ###, ### #### #### #### ..??





* DATA : GT_STUDENT LIKE TABLE OF GS_STUDENT WITH NON-UNIQUE KEY ZCODE. "ZPERNR# ## ####.



* CLEAR : GS_STUDENT, GT_STUDENT.

* GS_STUDENT-ZPERNR = '0000000001'. "header ###

* GS_STUDENT-ZCODE = 'SSU-01'.

* GS_STUDENT-ZKNAME = '###'.

* GS_STUDENT-ZENAME = 'KANG'.

* GS_STUDENT-ZGENDER = 'F'. "M## F# ## ## ##

* GS_STUDENT-ZTEL = '01012345678'.

* APPEND GS_STUDENT TO GT_STUDENT.





* GS_STUDENT-ZGENDER = 'M'.

* GS_STUDENT-ZENAME = 'KANG2'.



* MODIFY TABLE GT_STUDENT FROM GS_STUDENT. " Upsert, ### insert### ### update







** 1. TABLE KEY# ### # '##' ##

*




DATA : GT_STUDENT2 LIKE TABLE OF GS_STUDENT. "### non-unique key ## ##




*




CLEAR : GS_STUDENT.

GS_STUDENT-ZPERNR = '0000000001'. "header ###

GS_STUDENT-ZCODE = 'SSU-01'.

GS_STUDENT-ZKNAME = '###'.

GS_STUDENT-ZENAME = 'KANG'.

GS_STUDENT-ZGENDER = 'F'. "M## F# ## ## ##

GS_STUDENT-ZTEL = '01012345678'.

APPEND GS_STUDENT TO GT_STUDENT2.




*

* ## ### work Area# ##




GS_STUDENT-ZENAME = 'KANG2'.

GS_STUDENT-ZGENDER = 'M'.




*




MODIFY TABLE GT_STUDENT2 FROM GS_STUDENT TRANSPORTING ZGENDER. "### ## ##




*




BREAK-POINT.






* 2. WHERE ### ### '## ##' ##



* ### ## data 3# insert






DATA : GT_STUDENT LIKE TABLE OF GS_STUDENT. "###### ##



CLEAR : GS_STUDENT, GT_STUDENT.

GS_STUDENT-ZPERNR = '0000000001'. "header ###

GS_STUDENT-ZCODE = 'SSU-01'.

GS_STUDENT-ZKNAME = '###'.

GS_STUDENT-ZENAME = 'KANG'.

GS_STUDENT-ZGENDER = 'M'.

GS_STUDENT-ZTEL = '01012345678'.

APPEND GS_STUDENT TO GT_STUDENT.



CLEAR : GS_STUDENT.

GS_STUDENT-ZPERNR = '0000000002'. "header ###

GS_STUDENT-ZCODE = 'SSU-02'.

GS_STUDENT-ZKNAME = '###'.

GS_STUDENT-ZENAME = 'LEE'.

GS_STUDENT-ZGENDER = 'M'.

GS_STUDENT-ZTEL = '01012345678'.

APPEND GS_STUDENT TO GT_STUDENT.



CLEAR : GS_STUDENT.

GS_STUDENT-ZPERNR = '0000000003'. "header ###

GS_STUDENT-ZCODE = 'SSU-03'.

GS_STUDENT-ZKNAME = '###'.

GS_STUDENT-ZENAME = 'SON'.

GS_STUDENT-ZGENDER = 'F'.

GS_STUDENT-ZTEL = '01033334444'.

APPEND GS_STUDENT TO GT_STUDENT.



" ### 3# ## #### ##!





CLEAR : GS_STUDENT.



" LOOP# ###, WHERE ### ## ## ##

LOOP AT GT_STUDENT INTO GS_STUDENT.

  IF GS_STUDENT-ZGENDER = 'M'.

    GS_STUDENT-ZGNAME = '##'.

  ELSEIF GS_STUDENT-ZGENDER = 'F'.

    GS_STUDENT-ZGNAME = '##'.

  ELSE.

    GS_STUDENT-ZGNAME = '##'.

  ENDIF.



  "if### ## ## # GS ###.

  " ### ## modify# ### ##### ## ####.

  MODIFY GT_STUDENT FROM GS_STUDENT TRANSPORTING ZGNAME

  WHERE ZCODE = GS_STUDENT-ZCODE.

  " ### ZCODE - ## #### ##

  " #### GS_STUDENT-ZCODE : workArea #

  " #, WHERE GT_STUDENT-ZCODE = GS_STUDENT-ZCODE # ###

  " gt_student ####### ZCODE##, ## ### gs_student-zcode# ##, ##(##) ## zcode# ####!



  CLEAR GS_STUDENT.

ENDLOOP.








* 3. INDEX# ### '# ##' ##



* # ### ## 3## ### ##




CLEAR : GS_STUDENT, GT_STUDENT.

GS_STUDENT-ZPERNR = '0000000001'. "header ###

GS_STUDENT-ZCODE = 'SSU-01'.

GS_STUDENT-ZKNAME = '###'.

GS_STUDENT-ZENAME = 'KANG'.

GS_STUDENT-ZGENDER = 'M'.

GS_STUDENT-ZTEL = '01012345678'.

APPEND GS_STUDENT TO GT_STUDENT.



CLEAR : GS_STUDENT.

GS_STUDENT-ZPERNR = '0000000002'. "header ###

GS_STUDENT-ZCODE = 'SSU-02'.

GS_STUDENT-ZKNAME = '###'.

GS_STUDENT-ZENAME = 'LEE'.

GS_STUDENT-ZGENDER = 'M'.

GS_STUDENT-ZTEL = '01012345678'.

APPEND GS_STUDENT TO GT_STUDENT.



CLEAR : GS_STUDENT.

GS_STUDENT-ZPERNR = '0000000003'. "header ###

GS_STUDENT-ZCODE = 'SSU-03'.

GS_STUDENT-ZKNAME = '###'.

GS_STUDENT-ZENAME = 'SON'.

GS_STUDENT-ZGENDER = 'F'.

GS_STUDENT-ZTEL = '01033334444'.

APPEND GS_STUDENT TO GT_STUDENT.








* LOOP# ### #### ## #######(GS_STUDENT#), MODIFY ~ INDEX### # ## ####






CLEAR : GS_STUDENT.



BREAK-POINT.



LOOP AT GT_STUDENT INTO GS_STUDENT.

  " ### #### ##### sy-tabix## ## ## ## ###(# ##)# ## ####!

  IF GS_STUDENT-ZGENDER = 'M'.

    GS_STUDENT-ZGNAME = '##'.

  ELSEIF GS_STUDENT-ZGENDER = 'F'.

    GS_STUDENT-ZGNAME = '##'.

  ELSE.

    GS_STUDENT-ZGNAME = '##'.

  ENDIF.



  " MODIFY ~ INDEX #

  MODIFY GT_STUDENT FROM GS_STUDENT INDEX SY-TABIX.

    " INDEX sy-tabix -> ###### sy-tabix## ## #####.

    " FROM gs_student -> ### ## ###### gs_student# #### ### ##### !



  CLEAR : GS_STUDENT.

ENDLOOP.