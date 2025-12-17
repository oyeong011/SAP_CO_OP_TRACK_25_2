
*&---------------------------------------------------------------------*

*& Report ZEDR09_021

*&---------------------------------------------------------------------*

*&

*&---------------------------------------------------------------------*




REPORT ZEDR09_021.






* =====================================================================

* ABAP #### : PERFORM, FUNCTION MODULE



* ### PERFORM# ## ### ####.

* ## : ###, ###, ###

* =====================================================================





* =====================================================================

* 1) perform ## & ## & ## # ####

* =====================================================================

*  DATA : BEGIN OF GS_STUDENT.

*    INCLUDE TYPE ZEDT09_001.

*  DATA : END OF GS_STUDENT.

*  DATA : GT_STUDENT LIKE TABLE OF GS_STUDENT.

*

*  "perform ### ######, ## + ### ### ### ## ##

*  PERFORM GET_DATA. "perform ##

*

*

**  &---------------------------------------------------------------------*

**  &      Form  GET_DATA

**  &---------------------------------------------------------------------*

**         text

**  ----------------------------------------------------------------------*

**    -->  p1        text

**    <--  p2        text

**  ----------------------------------------------------------------------*

*  FORM GET_DATA . "form ## ##

*    WRITE : / 'PERFORM TEST01'.

*  ENDFORM.





* =====================================================================

* 2) #### -> # 3## ### #### ####



* - Actual parameter, Formal parameter

*     actual #### : ##### ### # #### ####

*     formal #### : ###### #### ####



* - perform## #### ## 4## (## using, using value, changing# ### ### ## ##)

*    1. FORM [form##] USING P1 TYPE 'type'

*       - ##(reference)####, #### ## ##### ### ###, ##### # ## ##

*       - #, #### ### P1# ####, #### ## ## ## (actual ####) ## ## ###



*    2. FORM [form##] USING VALUE(p2) TYPE 'type'

*       - # ## ####, #### ## ### ## #### ###### ####, ##### ## ## ###.

*       - #, #### ### P2# ####, ###### ## #### ### ###.



*    3. FORM [form##] CHANGING p3 TYPE 'type'

*       - ## ####, USING## ##### ####!

*       - USING# ### ####, ## #### ##### ### ##### #### ## ## ####.

*          #, USING#  '### ##'### ###, CHANGING# '#### #### ##'# ### ####.



*    4. FORM [form##] CHANGING VALUE(p4) TYPE 'type'



* =====================================================================



* >>>>>>>>> USING ##

*  DATA : BEGIN OF GS_STUDENT.

*    INCLUDE TYPE ZEDT09_001.

*  DATA : END OF GS_STUDENT.

*  DATA : GT_STUDENT LIKE TABLE OF GS_STUDENT.

*

*  DATA : GV_ZCODE LIKE ZEDT09_001-ZCODE.

*  DATA : GV_ZKNAME LIKE ZEDT09_001-ZKNAME.

*

*  GV_ZCODE = 'SSU-01'.

*

*  PERFORM GET_DATA USING GV_ZCODE GV_ZKNAME. "actual ####

*

*  WRITE : / GV_ZCODE.

*  WRITE : / GV_ZKNAME.

*

**  &---------------------------------------------------------------------*

**  &      Form  GET_DATA

**  &---------------------------------------------------------------------*

**         text

**  ----------------------------------------------------------------------*

**        -->P_GV_ZCODE  text

**        -->P_GV_ZKNAME  text

**  ----------------------------------------------------------------------*

*  FORM GET_DATA  USING    P_GV_ZCODE

*                          P_GV_ZKNAME. "formal #### # subroutine ## #, actual ####### # ####..

*

*    SELECT SINGLE ZKNAME FROM ZEDT09_001

*    INTO P_GV_ZKNAME "perform# formal ####

*    WHERE ZCODE = P_GV_ZCODE.""perform# formal ####

*

*  ENDFORM. "**ENDFORM## #### ## #, ## ###### formal ###### -> actual ##### # #####.





* >>>>>>>>> ### #### USING ####, actual ##### ### ###? ### ### ## ###..

*  DATA : GV_ZCODE LIKE ZEDT09_001-ZCODE.

*  DATA : GV_ZKNAME LIKE ZEDT09_001-ZKNAME.

*

*  PERFORM GET_DATA USING GV_ZCODE GV_ZKNAME.

*

*  WRITE : / GV_ZCODE.

*  WRITE : / GV_ZKNAME.

*

**  &---------------------------------------------------------------------*

**  &      Form  GET_DATA

**  &---------------------------------------------------------------------*

**         text

**  ----------------------------------------------------------------------*

**        -->P_GV_ZCODE  text

**        -->P_GV_ZKNAME  text

**  ----------------------------------------------------------------------*

*  FORM GET_DATA  USING    P_GV_ZCODE

*                          P_GV_ZKNAME.

*

*    DATA : LV_ZCODE LIKE ZEDT09_001-ZCODE. "#### ##, endform ### ##

*

*    LV_ZCODE = 'SSU-01'. "### ### ###!

*

*    SELECT SINGLE ZKNAME

*    FROM ZEDT09_001

*    INTO P_GV_ZKNAME

*    WHERE ZCODE = LV_ZCODe.

*

*    P_GV_ZCODE = LV_ZCODE.

*

*  ENDFORM.







* >>>>>>>>>>> ### USING VALUE# ### , ##!

* actual ##### (gv_zcode = 'ssu-02')# #### ###.. using# ####, ###### ### ## ######!

* -> ##, using value# ##### ##.

*

*  DATA : GV_ZCODE LIKE ZEDT09_001-ZCODE.

*  DATA : GV_ZKNAME LIKE ZEDT09_001-ZKNAME.

*

*  GV_ZCODE = 'SSU-02'. "###, # GV_ZCODE## ####, GV_ZKNAME# perform# ####, ssu-01# zkname# ##### ##!

*

*  PERFORM GET_DATA USING GV_ZCODE GV_ZKNAME.

*

*  WRITE : / GV_ZCODE.

*  WRITE : / GV_ZKNAME.

*

**  &---------------------------------------------------------------------*

**  &      Form  GET_DATA

**  &---------------------------------------------------------------------*

**         text

**  ----------------------------------------------------------------------*

**        -->P_GV_ZCODE  text

**        -->P_GV_ZKNAME  text

**  ----------------------------------------------------------------------*

*  FORM GET_DATA  USING VALUE(P_GV_ZCODE) P_GV_ZKNAME. "P_GV_ZCODE# ### ## ### #### ###. #, ##### ## ## x

*

*    DATA : LV_ZCODE LIKE ZEDT09_001-ZCODE.

*    LV_ZCODE = 'SSU-25'.

*

*    SELECT SINGLE ZKNAME

*    FROM ZEDT09_001

*    INTO P_GV_ZKNAME

*    WHERE ZCODE = LV_ZCODE.

*

*  ENDFORM.



* >>>>>>>>>>>> CHANGING ##

* - form #### value# #### ###, using# changing# ### ###

*   ### #### ## # ## vs ### ## ## ##### #### ## ##



*  DATA : GV_ZCODE LIKE ZEDT09_001-ZCODE.

*  DATA : GV_ZKNAME LIKE ZEDT09_001-ZKNAME.

*

*  GV_ZCODE = 'SSU-01'.

*

*  PERFORM GET_DATA USING GV_ZCODE

*                   CHANGING GV_ZKNAME.

*  " ##, changing# using# ##### ### #### ### ## #####..

*  " ## ##### gv_zcode## ####, gv_zkname# #### ##### # #### changing# #####..

*  WRITE : / GV_ZCODE.

*  WRITE : / GV_ZKNAME.

*

**  &---------------------------------------------------------------------*

**  &      Form  GET_DATA

**  &---------------------------------------------------------------------*

**         text

**  ----------------------------------------------------------------------*

**        -->P_GV_ZCODE  text

**        <--P_GV_ZKNAME  text

**  ----------------------------------------------------------------------*

*  FORM GET_DATA  USING    P_GV_ZCODE

*                 CHANGING P_GV_ZKNAME.

*

*    SELECT SINGLE ZKNAME

*    FROM ZEDT09_001

*    INTO P_GV_ZKNAME

*    WHERE ZCODE = P_GV_ZCODE.

*

*  ENDFORM.





* =====================================================================

* 3) Parameter TYPE ### -> #### abap ## ### #..



* - form## ## formal parameter# type, like### ###, ## abap ### ####.



* =====================================================================



* >>>>>>>> ### abap ### ####..

*  DATA : GV_ZCODE LIKE ZEDT09_001-ZCODE.

*  DATA : GV_ZKNAME LIKE ZEDT09_001-ZKNAME.

*

*  GV_ZCODE = 'SSU-01'.

*

*  PERFORM GET_DATA USING GV_ZCODE

*                   CHANGING GV_ZKNAME.

*

*  WRITE : / GV_ZCODE.

*  WRITE : / GV_ZKNAME.

*

**  &---------------------------------------------------------------------*

**  &      Form  GET_DATA

**  &---------------------------------------------------------------------*

**         text

**  ----------------------------------------------------------------------*

**        -->P_GV_ZCODE  text

**        <--P_GV_ZKNAME  text

**  ----------------------------------------------------------------------*

*

**   #### ##, type c# ## ###### 1## # #### ###?

**   -> perform# using ### gv_zcode# ### ## #### ### # ###, ###### ####..

**      ###, p_gv_zcode# gv_zcode# ## ### ### '####' ##.

*

*  FORM GET_DATA  USING VALUE(P_GV_ZCODE) TYPE C

*                 CHANGING P_GV_ZKNAME TYPE C.

*

*    SELECT SINGLE ZKNAME

*    FROM ZEDT09_001

*    INTO P_GV_ZKNAME

*    WHERE ZCODE = P_GV_ZCODE.

*

*  ENDFORM.





* =====================================================================

* 3) Parameter TYPE ### -> #### ####### ###?



* ###### #### ###### ##### ## ##, ### ### ### ##### ##.

* ### ###



* =====================================================================






" ### ##




*  DATA : GS_STUDENT LIKE ZEDT09_001.

*

*  GS_STUDENT-ZCODE = 'SSU-01'.

*

*  PERFORM GET_DATA USING GS_STUDENT.

*

*  WRITE : / GS_STUDENT-ZCODE.

*  WRITE : / GS_STUDENT-ZKNAME.

*

**  &---------------------------------------------------------------------*

**  &      Form  GET_DATA

**  &---------------------------------------------------------------------*

**         text

**  ----------------------------------------------------------------------*

**        -->P_GS_STUDENT  text

**  ----------------------------------------------------------------------*

*  FORM GET_DATA  USING  P_GS_STUDENT STRUCTURE GS_STUDENT.

*

*    SELECT SINGLE ZKNAME

*    FROM ZEDT09_001

*    INTO P_GS_STUDENT-ZKNAME "ZKNAME #### ## ### ##

*    WHERE ZCODE = P_GS_STUDENT-ZCODE.

*

*  ENDFORM.








" ###### ## -> like

" ####### # 3## ### ##.

"   like, type standard table, tables

"   ##, ### tables# ### # ## ## ## ####. (##### '##' #### ##### ## # #### ##..)




*  DATA : GS_STUDENT LIKE ZEDT09_001.

*  DATA : GT_STUDENT LIKE TABLE OF GS_STUDENT.

*

*  PERFORM GET_DATA USING GS_STUDENT

*                         GT_STUDENT.

*

*  " ###### ##

*  LOOP AT GT_STUDENT INTO GS_STUDENT.

*    WRITE : / GS_STUDENT-ZCODE, GS_STUDENT-ZKNAME.

*  ENDLOOP.

*

*

**  &---------------------------------------------------------------------*

**  &      Form  GET_DATA

**  &---------------------------------------------------------------------*

**         text

**  ----------------------------------------------------------------------*

**        -->P_GS_STUDENT  text

**        -->P_GT_STUDENT  text

**  ----------------------------------------------------------------------*

*  FORM GET_DATA  USING    P_GS_STUDENT STRUCTURE GS_STUDENT

*                          P_GT_STUDENT LIKE GT_STUDENT.

*

*    P_GS_STUDENT-ZCODE = 'SSU-01'.

*

*    SELECT SINGLE ZKNAME

*    FROM ZEDT09_001

*    INTO P_GS_STUDENT-ZKNAME

*    WHERE ZCODE = P_GS_STUDENT-ZCODE.

*    APPEND P_GS_STUDENT TO P_GT_STUDENT. "###### #### ###

*

*    P_GS_STUDENT-ZCODE = 'SSU-02'.

*

*    SELECT SINGLE ZKNAME

*    FROM ZEDT09_001

*    INTO P_GS_STUDENT-ZKNAME

*    WHERE ZCODE = P_GS_STUDENT-ZCODE.

*    APPEND P_GS_STUDENT TO P_GT_STUDENT. "###### #### ###

*

*

*  ENDFORM.








" ###### ## -> type standard table





  DATA : GS_STUDENT LIKE ZEDT09_001.

  DATA : GT_STUDENT LIKE TABLE OF GS_STUDENT.



  PERFORM GET_DATA USING GT_STUDENT.




*

*  " ###### ##




  LOOP AT GT_STUDENT INTO GS_STUDENT.

    WRITE : / GS_STUDENT-ZCODE, GS_STUDENT-ZKNAME.

  ENDLOOP.




*

*

**  &---------------------------------------------------------------------*

**  &      Form  GET_DATA

**  &---------------------------------------------------------------------*

**         text

**  ----------------------------------------------------------------------*

**        -->P_GS_STUDENT  text

**        -->P_GT_STUDENT  text

**  ----------------------------------------------------------------------*




  FORM GET_DATA  USING P_GT_STUDENT TYPE STANDARD TABLE.



    DATA : LS_STUDENT LIKE GS_STUDENT. "##### wa ### #####.



    LS_STUDENT-ZCODE = 'SSU-01'.



    SELECT SINGLE ZKNAME

    FROM ZEDT09_001

    INTO LS_STUDENT-ZKNAME

    WHERE ZCODE = LS_STUDENT-ZCODE.

    APPEND LS_STUDENT TO P_GT_STUDENT.



    LS_STUDENT-ZCODE = 'SSU-02'.



    SELECT SINGLE ZKNAME

    FROM ZEDT09_001

    INTO LS_STUDENT-ZKNAME

    WHERE ZCODE = LS_STUDENT-ZCODE.

    APPEND LS_STUDENT TO P_GT_STUDENT. "###### #### ###





  ENDFORM.