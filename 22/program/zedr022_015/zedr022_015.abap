
*&---------------------------------------------------------------------*

*& Report ZEDR022_015

*&---------------------------------------------------------------------*

*&

*&---------------------------------------------------------------------*




REPORT ZEDR022_015.






*perform

*-abap program# subroutine : perform, function module

*-subroutine# perform# form## #### endform## #### ## ##

*- ##### ###, ###,### ##



*DATA : GS_STUDENT TYPE ZEDT022_001.

*DATA : GT_STUDENT TYPE TABLE OF ZEDT022_001.



*DATA : GV_ZCODE LIKE ZEDT022_001-ZCODE.

*DATA : GV_ZKNAME LIKE ZEDT022_001-ZKNAME.

*

*GV_ZCODE = 'SSU-02'.

**USING ##

*PERFORM GET_DATA USING GV_ZCODE GV_ZKNAME."Acutal parameter

**FORM GET_DATA. ## # ### # ####->YES ##-> ZEDT022_015 ##

*

*WRITE :/ GV_ZCODE.

*WRITE :/ GV_ZKNAME.

***&---------------------------------------------------------------------*

***&      Form  GET_DATA

***&---------------------------------------------------------------------*

***       text

***----------------------------------------------------------------------*

***  -->  p1        text

***  <--  p2        text

***----------------------------------------------------------------------*

*FORM GET_DATA USING P_ZCODE P_ZKNAME."formal parameter

*  DATA : LV_ZCODE LIKE ZEDT022_001-ZCODE."#### # #### ## ##, ENDFORM### ##

*  LV_ZCODE = 'SSU-01'."##### ZCODE# ##

*  SELECT SINGLE ZKNAME FROM ZEDT022_001

*    INTO P_ZKNAME

*    WHERE ZCODE = LV_ZCODE.

*

*    P_ZCODE = LV_ZCODE.

*

*ENDFORM.



*PARAMETER : ##### #### ### ## ## ## ### ## ## #

*Actual parameter : #### ### # #### ####(#### ##)

*Formal parameter : ###### #### ####(## ##)



*perform## #### ## : using, changing ## ##

*-# ##### ## ## ##



*DATA : GV_ZCODE LIKE ZEDT022_001-ZCODE.

*DATA : GV_ZKNAME LIKE ZEDT022_001-ZKNAME.

*

*GV_ZCODE = 'SSU-02'.

*

**USING VALUE ## : P_ZCODE = SSU-01# #### GV_ZCODE ## ## ### ## #### ###?

*PERFORM GET_DATA USING GV_ZCODE GV_ZKNAME.

*

*WRITE :/ GV_ZCODE.

*WRITE :/ GV_ZKNAME.

*

*FORM GET_DATA USING VALUE(P_ZCODE) P_ZKNAME."P_ZCODE = SSU-02

** (P_ZCODE) ### ## ## ## # #### ##

*  DATA : LV_ZCODE LIKE ZEDT022_001-ZCODE.

*  LV_ZCODE = 'SSU-01'.

*

*  SELECT SINGLE ZKNAME FROM ZEDT022_001

*    INTO P_ZKNAME

*    WHERE ZCODE = LV_ZCODE.

*

*    P_ZCODE = LV_ZCODE."P_ZCODE = SSU-01

*

*ENDFORM.

*-Actual parameter# ## ####### #### #### ## #### using value ##



*CHANGING ## - USING# ## ##

*DATA : GV_ZCODE LIKE ZEDT022_001-ZCODE.

*DATA : GV_ZKNAME LIKE ZEDT022_001-ZKNAME.

*

*GV_ZCODE = 'SSU-01'.

*

*PERFORM GET_DATA USING GV_ZCODE "USING : ### ##

*                 CHANGING GV_ZKNAME. "CHANGING : #### #### ##

*

*WRITE :/ GV_ZCODE.

*WRITE :/ GV_ZKNAME.

*

*FORM GET_DATA USING P_ZCODE

*              CHANGING P_ZKNAME.

*  SELECT SINGLE ZKNAME FROM ZEDT022_001

*    INTO P_ZKNAME

*    WHERE ZCODE = P_ZCODE.

*

*ENDFORM.

*-FORM #### VALUE# #### ### using# changing# ### ###, ### #### ##/##### ##

*-##### #### ## #### ##



*CHANGING VALUE##

*DATA : GV_ZCODE LIKE ZEDT022_001-ZCODE.

*DATA : GV_ZKNAME LIKE ZEDT022_001-ZKNAME.

*

*GV_ZCODE = 'SSU-01'.

*

*PERFORM GET_DATA USING GV_ZCODE "USING : ### ##

*                 CHANGING GV_ZKNAME. "CHANGING : #### #### ##

*

*WRITE :/ GV_ZCODE.

*WRITE :/ GV_ZKNAME.

*

*FORM GET_DATA USING P_ZCODE

*              CHANGING VALUE(P_ZKNAME).

*  SELECT SINGLE ZKNAME FROM ZEDT022_001

*    INTO P_ZKNAME

*    WHERE ZCODE = P_ZCODE.

*

*    P_ZKNAME = 'TEST'.

*

*ENDFORM.

*-FORM #### VALUE# #### ### using# changing# ### ###, ### #### ##/##### ##

*-##### #### ## #### ##



*DATA : GV_ZCODE LIKE ZEDT022_001-ZCODE.

*DATA : GV_ZKNAME LIKE ZEDT022_001-ZKNAME.



*GV_ZCODE = 'SSU-01'.

*PARAMETER TYPE ##

*PERFORM GET_DATA USING GV_ZCODE

*                 CHANGING GV_ZKNAME.



*WRITE :/ GV_ZCODE.

*WRITE :/ GV_ZKNAME.

*FORM GET_DATA USING P_ZOCDE TYPE C

*              CHANGING P_ZKNAME TYPE C."Actual parameter# ## ## ##

*  SELECT SINGLE ZKNAME FROM ZEDT022_001

*    INTO P_ZKNAME

*    WHERE ZCODE = P_ZCODE.

*

*ENDFORM.



*WRITE :/ GV_ZCODE.

*WRITE :/ GV_ZKNAME.

*FORM GET_DATA USING P_ZOCDE LIKE ZEDT022_001-ZCODE

*              CHANGING P_ZKNAME LIKE ZEDT022_001-ZKNAME."Actual parameter# ## ## ## ##

*  SELECT SINGLE ZKNAME FROM ZEDT022_001

*    INTO P_ZKNAME

*    WHERE ZCODE = P_ZCODE.

*

*ENDFORM.



*PARAMETER ###

*-FORM## ## FORMAL PARAMETER# ## ##### STRUCTURE### ### ### ## ##

*-### ### #### ### ### #### ### ## ##

*GS_STUDENT-ZCODE = 'SSU-01'.

*

*PERFORM GET_DATA USING GS_STUDENT.

*

*WRITE :/ GS_STUDENT-ZCODE.

*WRITE :/ GS_STUDENT-ZKNAME.

*

*FORM GET_DATA USING PS_STUDENT STRUCTURE GS_STUDENT."### ## ### ## ##

*

*  SELECT SINGLE ZKNAME FROM ZEDT022_001

*    INTO PS_STUDENT-ZKNAME

*    WHERE ZCODE = PS_STUDENT-ZCODE.

*

*ENDFORM.



*PARAMETER ######

*-FORM## ## FORMAL PARAMETER# ## ##### ####### ### ## ##

*-######### ##### ### ### #### ### ## ##



*PERFORM GET_DATA USING GS_STUDENT

*                       GT_STUDENT.

*

*LOOP AT GT_STUDENT INTO GS_STUDENT.

*  WRITE :/ GS_STUDENT-ZCODE, GS_STUDENT-ZKNAME.

*ENDLOOP.

*FORM GET_DATA USING PS_STUDENT STRUCTURE GS_STUDENT

*                    PT_STUDENT LIKE GT_STUDENT.

** FORM GET_DATA USING PS_STUDENT LIKE GS_STUDENT

**                     PT_STUDENT LIKE GT_STUDENT.

** FORM GET_DATA USING PT_STUDENT TYPE STANDARD TABLE.

** DATA : LS_STUDENT LIKE GS_STUDENT.

**- # # # # ## ###

*  PS_STUDENT-ZCODE = 'SSU-01'.

*

*  SELECT SINGLE ZKNAME FROM ZEDT022_001

*    INTO PS_STUDENT-ZKNAME

*    WHERE ZCODE = GS_STUDENT-ZCODE.

*    APPEND PS_STUDENT TO PT_STUDENT.

*

*    PS_STUDENT-ZCODE = 'SSU-02'.

*

*    SELECT SINGLE ZKNAME FROM ZEDT022_001

*      INTO PS_STUDENT-ZKNAME

*      WHERE ZCODE = GS_STUDENT-ZCODE.

*      APPEND PS_STUDENT TO PT_STUDENT.

*ENDFORM.



*External

*-## ## ##### ##### #### ##

*-####### ### ## IF FOUND ### #### ## ##### ##### ## ##

*-(## if found ## ## ## #### ## ##### #### ## ###)



*External ##




DATA : BEGIN OF GS_STUDENT.

  include structure
ZEDT022_001
.

  DATA : END OF GS_STUDENT.

DATA : GT_STUDENT LIKE TABLE OF GS_STUDENT.



DATA : GV_ZCODE LIKE ZEDT022_001-ZCODE.

DATA : GV_ZKNAME LIKE ZEDT022_001-ZKNAME.



PERFORM GET_DATA(ZEDT022_014) IF FOUND CHANGING GT_STUDENT.



LOOP AT GT_STUDENT INTO GS_STUDENT.

  WRITE :/ GS_STUDENT-ZCODE, GS_STUDENT-ZKNAME.

ENDLOOP.




*

*FORM GET_DATA CHANGING PT_STUDENT LIKE GT_STUDENT.

*  DATA : LS_STUDENT LIKE GS_STUDENT.

*

*  LS_STUDENT-ZCODE = 'SSU-01'.

*

*  SELECT SINGLE ZKNAME FROM ZEDT022_001

*    INTO LS_STUDENT-ZKNAME

*    WHERE ZCODE = LS_STUDENT-ZCODE.

*    APPEND LS_STUDENT TO PT_STUDENT.

*

*    LS_STUDENT-ZCODE = 'SSU-02'.

*

*    SELECT SINGLE ZKNAME FROM ZEDT022_001

*      INTO LS_STUDENT-ZKNAME

*      WHERE ZCODE = LS_STUDENT-ZCODE.

*      APPEND LS_STUDENT TO PT_STUDENT.

*

*ENDFORM.