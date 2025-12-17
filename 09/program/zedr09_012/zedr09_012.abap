
*&---------------------------------------------------------------------*

*& Report ZEDR09_012

*&---------------------------------------------------------------------*

*&

*&---------------------------------------------------------------------*




REPORT ZEDR09_012.






* =====================================================================

* InternalTable ## - DELETE 5##



* 1. LOOP# ## ## ## (##)

* 2. TABLE KEY# ## ## ##

* 3. WHERE ### #### ###### ## ## (## ##)

* 4. INDEX# ### ## ## (## ##22)

* 5. ADJACENT DUPLICATE ### ###, ## ## ## -> ## ##!



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



DATA : GT_STUDENT LIKE TABLE OF GS_STUDENT.






* =====================================================================

* 1. LOOP# ## ## ##

* DELETE TABLE ###### FROM ###.

* =====================================================================



* ## ## 3# ### ##




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








* LOOP## ####, ZGENDER = '###'# ### ##






CLEAR : GS_STUDENT.







LOOP AT GT_STUDENT INTO GS_STUDENT.

  IF GS_STUDENT-ZGENDER NE 'M'. "#### ### ##

    DELETE TABLE GT_STUDENT FROM GS_STUDENT.



    IF SY-SUBRC = 0. "sy-subrc# ## ## ## ## ##, # ### ##### ### ###

    ELSE.

      WRITE : / '####'.

    ENDIF.



  ELSE. "##### ## ## ##

    WRITE : / GS_STUDENT-ZCODE, GS_STUDENT-ZKNAME, GS_STUDENT-ZGENDER.

  ENDIF.



  CLEAR : GS_STUDENT.

ENDLOOP.






* =====================================================================

*  2. TABLE KEY# ## ## ##

* key# ####, ###### ## ##

* DELETE TABLE ######A WITH TABLE KEY ##1

* =====================================================================



* ## ## 3# ### ##






DATA : GS_STUDENT2 TYPE ZEDT09_001.

DATA : GT_STUDENT2 LIKE TABLE OF GS_STUDENT2 WITH NON-UNIQUE KEY ZGENDER.




* => #### ## ##(ZGENDER) ####, KEY ##



* ## ## 3# ### ##




CLEAR : GS_STUDENT2, GT_STUDENT2.

GS_STUDENT2-ZPERNR = '0000000001'. "header ###

GS_STUDENT2-ZCODE = 'SSU-01'.

GS_STUDENT2-ZKNAME = '###'.

GS_STUDENT2-ZENAME = 'KANG'.

GS_STUDENT2-ZGENDER = 'M'.

GS_STUDENT2-ZTEL = '01012345678'.

APPEND GS_STUDENT2 TO GT_STUDENT2.



CLEAR : GS_STUDENT2.

GS_STUDENT2-ZPERNR = '0000000002'. "header ###

GS_STUDENT2-ZCODE = 'SSU-02'.

GS_STUDENT2-ZKNAME = '###'.

GS_STUDENT2-ZENAME = 'LEE'.

GS_STUDENT2-ZGENDER = 'M'.

GS_STUDENT2-ZTEL = '01012345678'.

APPEND GS_STUDENT2 TO GT_STUDENT2.



CLEAR : GS_STUDENT2.

GS_STUDENT2-ZPERNR = '0000000003'. "header ###

GS_STUDENT2-ZCODE = 'SSU-03'.

GS_STUDENT2-ZKNAME = '###'.

GS_STUDENT2-ZENAME = 'SON'.

GS_STUDENT2-ZGENDER = 'F'.

GS_STUDENT2-ZTEL = '01033334444'.

APPEND GS_STUDENT2 TO GT_STUDENT2.






* ## ### # # ####, #### ## ##




DELETE TABLE  GT_STUDENT2 WITH TABLE KEY ZGENDER = 'F'.



WRITE : / , / , '2# ##'.

IF SY-SUBRC = 0. "## ## #, ## ### ### ##

  LOOP AT GT_STUDENT2 INTO GS_STUDENT2.

    WRITE : / GS_STUDENT2-ZCODE, GS_STUDENT2-ZKNAME, GS_STUDENT2-ZGENDER.

  ENDLOOP.

ENDIF.






* =====================================================================

* 3. WHERE ### #### ###### ## ## (## ##)

* DELETE ######A WHRRE FIELD = VALUE

* =====================================================================






DATA : GS_STUDENT3 TYPE ZEDT09_001.

DATA : GT_STUDENT3 LIKE TABLE OF GS_STUDENT3. "## #####!






* ## ## 3# ### ##




CLEAR : GS_STUDENT3, GT_STUDENT3.

GS_STUDENT3-ZPERNR = '0000000001'. "header ###

GS_STUDENT3-ZCODE = 'SSU-01'.

GS_STUDENT3-ZKNAME = '###'.

GS_STUDENT3-ZENAME = 'KANG'.

GS_STUDENT3-ZGENDER = 'M'.

GS_STUDENT3-ZTEL = '01012345678'.

APPEND GS_STUDENT3 TO GT_STUDENT3.



CLEAR : GS_STUDENT3.

GS_STUDENT3-ZPERNR = '0000000002'. "header ###

GS_STUDENT3-ZCODE = 'SSU-02'.

GS_STUDENT3-ZKNAME = '###'.

GS_STUDENT3-ZENAME = 'LEE'.

GS_STUDENT3-ZGENDER = 'M'.

GS_STUDENT3-ZTEL = '01012345678'.

APPEND GS_STUDENT3 TO GT_STUDENT3.



CLEAR : GS_STUDENT3.

GS_STUDENT3-ZPERNR = '0000000003'. "header ###

GS_STUDENT3-ZCODE = 'SSU-03'.

GS_STUDENT3-ZKNAME = '###'.

GS_STUDENT3-ZENAME = 'SON'.

GS_STUDENT3-ZGENDER = 'F'.

GS_STUDENT3-ZTEL = '01033334444'.

APPEND GS_STUDENT3 TO GT_STUDENT3.






* ####### WHERE #### ####, ##




DELETE GT_STUDENT3 WHERE ZGENDER = 'F'.



WRITE : / , / , '3# ##'.

IF SY-SUBRC = 0. "## ## #, ## ### ### ##

  LOOP AT GT_STUDENT3 INTO GS_STUDENT3.

    WRITE : / GS_STUDENT3-ZCODE, GS_STUDENT3-ZKNAME, GS_STUDENT3-ZGENDER.

  ENDLOOP.

ENDIF.








* =====================================================================

* 4. INDEX# ### ## ## (## ##22)



* DELETE ######A INDEX idx



* DELETE ######A FROM n1 TO n2 : n1 ~ n2 ## ##

* DELETE ######A FROM n1 : n1## & n1## ## ## ##

* DELETE ######A TO n2 : '###'## n2'##' ##

* =====================================================================



* ## ## 3# ### ##




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






* DELETE ######A INDEX idx

* DELETE GT_STUDENT INDEX 2.



* WRITE : / , / , '4# ##'.

* IF SY-SUBRC = 0. "## ## #, ## ### ### ##

*   LOOP AT GT_STUDENT INTO GS_STUDENT.

*     WRITE : / GS_STUDENT-ZCODE, GS_STUDENT-ZKNAME, GS_STUDENT-ZGENDER.

*   ENDLOOP.

* ENDIF.



* DELETE ######A FROM n1 TO n2 : n1 ~ n2 ## ##

* DELETE GT_STUDENT FROM 2 TO 3.



* WRITE : / , / , '4# ##2'.

* IF SY-SUBRC = 0. "## ## #, ## ### ### ##

*   LOOP AT GT_STUDENT INTO GS_STUDENT.

*     WRITE : / GS_STUDENT-ZCODE, GS_STUDENT-ZKNAME, GS_STUDENT-ZGENDER.

*   ENDLOOP.

* ENDIF.



* DELETE ######A FROM n1 : n1## ## ## ## ##

* DELETE GT_STUDENT FROM 2.

* WRITE : / , / , '4# ##3'.

* IF SY-SUBRC = 0. "## ## #, ## ### ### ##

*   LOOP AT GT_STUDENT INTO GS_STUDENT.

*     WRITE : / GS_STUDENT-ZCODE, GS_STUDENT-ZKNAME, GS_STUDENT-ZGENDER.

*   ENDLOOP.

* ENDIF.



* DELETE ######A TO n2 : '###'## n2'##' ##




DELETE GT_STUDENT TO 2.



WRITE : / , / , '4# ##2'.

IF SY-SUBRC = 0. "## ## #, ## ### ### ##

  LOOP AT GT_STUDENT INTO GS_STUDENT.

    WRITE : / GS_STUDENT-ZCODE, GS_STUDENT-ZKNAME, GS_STUDENT-ZGENDER.

  ENDLOOP.

ENDIF.






* =====================================================================

* 5. ADJACENT DUPLICATE ### ###, ## ## ## -> ## ##!



* 1. ADJACENT DUPLICATE#? <-- #### ### ##

*   - DELETE ADJACENT DUPLICATE ENTRIES # ###(Adjacent) ## ## ## # ##.

*   - ### ## ##(SORT) # ## ## ##### #### #### ## ##.

*      #)

*        SORT itab BY zcode.

*        DELETE ADJACENT DUPLICATE ENTRIES FROM itab.

*        -> ## zcode## #### #####, #### ### #### ###



* 2. COMPARING ## <-- ### ##

*   - ## ### #### '##'# #### ### ##

*   - COMPARING f1 f2 ... ## ## # #### ##

*   - COMPARING# ####, TABLE KEY ####, ### #####!



* 3. TABLE KEY# ?

*   - intenalTable ### #, WITH [NON-]UNIQUE KEY ... # ######.

*   - Key# #### ## ##, ABAP# Default Key# ##.

*   - Default Key# ## character-like (N, D, T, C, String) ## ###.



*   #) Table key?

* DATA: BEGIN OF gs_student,

*         zcode   TYPE c LENGTH 10,

*         zname   TYPE c LENGTH 20,

*         zgender TYPE c LENGTH 1,

*       END OF gs_student.

* DATA: gt_student LIKE TABLE OF gs_student.



*  "Default key = zcode, zname, zgender (## character type)





* =====================================================================



* ## ## 3# ### ##




CLEAR : GS_STUDENT, GT_STUDENT.

GS_STUDENT-ZPERNR = '0000000001'.

GS_STUDENT-ZCODE = 'SSU-01'.

GS_STUDENT-ZKNAME = '###'.

GS_STUDENT-ZENAME = 'KANG'.

GS_STUDENT-ZGENDER = 'M'.

GS_STUDENT-ZTEL = '01012345678'.

APPEND GS_STUDENT TO GT_STUDENT.





CLEAR : GS_STUDENT.

GS_STUDENT-ZPERNR = '0000000003'.

GS_STUDENT-ZCODE = 'SSU-03'.

GS_STUDENT-ZKNAME = '###'.

GS_STUDENT-ZENAME = 'SON'.

GS_STUDENT-ZGENDER = 'F'.

GS_STUDENT-ZTEL = '01033334444'.

APPEND GS_STUDENT TO GT_STUDENT.





CLEAR : GS_STUDENT.

GS_STUDENT-ZPERNR = '0000000001'. "## ### ###! ### #

GS_STUDENT-ZCODE = 'SSU-01'.

GS_STUDENT-ZKNAME = '###'.

GS_STUDENT-ZENAME = 'KANG'.

GS_STUDENT-ZGENDER = 'M'.

GS_STUDENT-ZTEL = '01012345678'.

APPEND GS_STUDENT TO GT_STUDENT.






* ### ###### #### ###. sort ### ## #### #######

* => #### ####. sort##!






SORT GT_STUDENT.

DELETE ADJACENT DUPLICATES FROM GT_STUDENT.





WRITE : / , / , '5# ##1'.

IF SY-SUBRC = 0.

  LOOP AT GT_STUDENT INTO GS_STUDENT.

    WRITE : / GS_STUDENT-ZCODE, GS_STUDENT-ZKNAME, GS_STUDENT-ZGENDER.

  ENDLOOP.

ENDIF.






* == COMPARING ### ## == *



* ## ## 3# ### ##




CLEAR : GS_STUDENT, GT_STUDENT.

GS_STUDENT-ZPERNR = '0000000001'.

GS_STUDENT-ZCODE = 'SSU-01'.

GS_STUDENT-ZKNAME = '###'.

GS_STUDENT-ZENAME = 'KANG'.

GS_STUDENT-ZGENDER = 'M'.

GS_STUDENT-ZTEL = '01012345678'.

APPEND GS_STUDENT TO GT_STUDENT.





CLEAR : GS_STUDENT.

GS_STUDENT-ZPERNR = '0000000003'.

GS_STUDENT-ZCODE = 'SSU-03'.

GS_STUDENT-ZKNAME = '###'.

GS_STUDENT-ZENAME = 'SON'.

GS_STUDENT-ZGENDER = 'F'.

GS_STUDENT-ZTEL = '01033334444'.

APPEND GS_STUDENT TO GT_STUDENT.





CLEAR : GS_STUDENT.

GS_STUDENT-ZPERNR = '0000000001'. "## ### ###! ### #

GS_STUDENT-ZCODE = 'SSU-01'.

GS_STUDENT-ZKNAME = '###'.

GS_STUDENT-ZENAME = 'KANG'.

GS_STUDENT-ZGENDER = 'M'.

GS_STUDENT-ZTEL = '01012345678'.

APPEND GS_STUDENT TO GT_STUDENT.



CLEAR : GS_STUDENT.

GS_STUDENT-ZPERNR = '0000000001'. "#####, F

GS_STUDENT-ZCODE = 'SSU-01'.

GS_STUDENT-ZKNAME = '###'.

GS_STUDENT-ZENAME = 'KANG'.

GS_STUDENT-ZGENDER = 'F'.

GS_STUDENT-ZTEL = '01012345678'.

APPEND GS_STUDENT TO GT_STUDENT.



SORT GT_STUDENT BY ZGENDER.



BREAK-POINT.



"###### #, ### ##(ZCODE) #### ## #####!

DELETE ADJACENT DUPLICATES FROM GT_STUDENT COMPARING ZGENDER.







WRITE : / , / , '5# ##2'.

IF SY-SUBRC = 0.

  LOOP AT GT_STUDENT INTO GS_STUDENT.

    WRITE : / GS_STUDENT-ZCODE, GS_STUDENT-ZKNAME, GS_STUDENT-ZGENDER.

  ENDLOOP.

ENDIF.