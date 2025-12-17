
*&---------------------------------------------------------------------*

*& Report ZEDR07_PRACTICE002

*&---------------------------------------------------------------------*

*&

*&---------------------------------------------------------------------*




REPORT ZEDR07_PRACTICE002.



"### ## + #####

DATA : BEGIN OF gs_zedt01.

  include structure
zedt07_001
.




*  DATA : zmajor TYPE c LENGTH 10,

*        zwarned TYPE c LENGTH 10.




DATA : END OF gs_zedt01.



DATA : gs_zedt02 TYPE zedt07_002.

DATA : gs_zedt04 TYPE zedt07_004.



"### # ## ### ###

DATA : BEGIN OF gs_sum,

  zgender TYPE zedt07_001-zgender,

  zsum TYPE zedt07_004-zsum,

  END OF gs_sum.



"### ###

DATA : BEGIN OF gs_print,

  zcode TYPE zedt07_004-zcode,

  zkname TYPE c LENGTH 10,

  major_transport TYPE c LENGTH 10,

  ztel TYPE c LENGTH 13,

  warning TYPE c LENGTH 10,

  END OF gs_print.



"##### ## ### ##

DATA : gt_zedt01 TYPE TABLE OF zedt07_001.

DATA : gt_zedt02 TYPE TABLE OF zedt07_002.

DATA : gt_zedt04 TYPE TABLE OF zedt07_004.

DATA : gt_sum LIKE TABLE OF gs_sum.

DATA : gt_print LIKE TABLE OF gs_print.



"### #### # ##

SELECT * FROM ZEDT07_001

INTO CORRESPONDING FIELDS OF TABLE GT_ZEDT01.



SELECT * FROM ZEDT07_002

INTO CORRESPONDING FIELDS OF TABLE GT_ZEDT02.



SELECT * FROM ZEDT07_004

INTO CORRESPONDING FIELDS OF TABLE GT_ZEDT04.

"8# ### ### # ## ## ## ### ##### #### ##

"9# ### #### ## gs_zedt07# #### ### #### ##? -> X

"## 1# ### ## #### FLAG(####) #### #### -> ## ## ### #### #### ## #



"## 10# ##### READ_COMPARING #### # ## ### 4# ##### 1# ###

"11#### READ_COMPARING ##

"12# ### #### ##, ## #### IF# #### ### ## ### ### ### ## ### ## ###



"#### WRITE 2# ### #

"12# #### 4# #### ### # ## ## ## ### ##### ##### 8# ### #####





SORT gt_zedt01 BY zcode.

SORT gt_zedt02 BY zcode.

SORT gt_zedt04 BY zcode.



SORT gt_zedt04 BY zcode zgrade DESCENDING.



DELETE ADJACENT DUPLICATES FROM gt_zedt04 COMPARING zcode. "### 8# ##

SORT gt_zedt04 BY zcode. "## ####



LOOP AT gt_zedt04 INTO gs_zedt04.



  MOVE-CORRESPONDING gs_zedt04 TO gs_zedt01.

  MOVE-CORRESPONDING gs_zedt04 TO gs_zedt02.



  READ TABLE gt_zedt01 WITH KEY zcode = gs_zedt04-zcode INTO gs_zedt01. "### ## ### ####

  READ TABLE gt_zedt02 WITH KEY zcode = gs_zedt04-zcode INTO gs_zedt02 COMPARING zmajor.

  "### ### ####



  IF sy-subrc = 2.

    gs_print-major_transport = '####'. "02# 04### ### ### SY-SUBRC ## 2# #.

  ENDIF.



  IF gs_zedt04-zgrade = ' '. "### ##### ###

    CONTINUE.

  ELSE. "# ##### #####

    MOVE-CORRESPONDING gs_zedt01 TO gs_print.



    gs_sum-zgender = gs_zedt01-zgender.

    gs_sum-zsum = gs_zedt04-zsum.

    COLLECT gs_sum INTO gt_sum. " ## # ###



    IF gs_zedt04-zgrade = 'D' OR gs_zedt04-zgrade = 'F'. "#### ##



     gs_print-warning ='####'. "#### ##



    ELSE.

      CLEAR: gs_print-ztel.



    ENDIF.



  ENDIF.



  CLEAR : gs_zedt04.

  APPEND gs_print TO gt_print. "#### ##



  CLEAR : gs_print.

ENDLOOP.





DATA : gv_male TYPE i.

DATA : gv_female TYPE i.



CLEAR : gs_sum.



LOOP AT gt_print INTO gs_print.

  AT FIRST.

    WRITE :/ '-------------------------------------------------------------------------------------'.

    WRITE :/ '|    ####    |       ##       |   ####     |     ####    |    ##    |'.

    WRITE :/ '-------------------------------------------------------------------------------------'.

  ENDAT.



  WRITE :/ '|    ', gs_print-zcode, '|     ', gs_print-zkname,' |  ', gs_print-major_transport,'  | ', gs_print-ztel, ' |', gs_print-warning,'|'.

  WRITE :/ '-------------------------------------------------------------------------------------'.



  IF sy-tabix = 1.

    READ TABLE gt_sum INTO gs_sum INDEX 1.

    gv_male = gs_sum-zsum * 100.



  ELSEIF sy-tabix = 2.

    READ TABLE gt_sum INTO gs_sum INDEX 2.

    gv_female = gs_sum-zsum * 100.

  ENDIF.





  AT LAST.

    WRITE :/ '### ### : ' , gv_male.

    WRITE :/ '### ### : ' , gv_female.

  ENDAT.



ENDLOOP.