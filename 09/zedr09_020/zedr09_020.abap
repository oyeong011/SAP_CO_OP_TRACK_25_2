
*&---------------------------------------------------------------------*

*& Report ZEDR09_020

*&---------------------------------------------------------------------*

*&

*&---------------------------------------------------------------------*




REPORT ZEDR09_020.






* =====================================================================

* ####, SELECT-OPTIONS ## ABAP## ###### #### ###, ### ### #### ## ##

* ### ## WHERE## ### ### #####, ### ### ### ##.



* 1. ####     -> like ### ### #

*    - '###'# #### # ##

*    - ex) "## ### ### ######"# ##, '##'# ### #### ##



* 2. SELECT-OPTIONS    -> like ### ##

*    - ##(range)# #### ## #### # ##

*    - #### ## ### #####, #### ## ## #### ### # ## ##.

*    - ex) "1## ###, ## #### ### ### ######" # ##, #### ##



* << ####. 2# select-options# ####



* =====================================================================



* =====================================================================

* 2. SELECT-OPTIONS

*   - input### 2## ### range## #####, sing, option, low, high## ##

*   - #, parameters# ## ## #### ###!!

* =====================================================================



* >> select-options ## ### <<<<<<<<<<<<<<<<<<<<<<<<<<<<<<



*  TABLES : ZEDT09_001. "SELECT-OPTIONS ## #, FOR# ## ### #### TABLES# ##### #

*

*  DATA : BEGIN OF GS_STUDENT.

*    INCLUDE TYPE ZEDT09_001.

*    DATA : END OF GS_STUDENT.

*  DATA : GT_STUDENT LIKE TABLE OF GS_STUDENT.

*

*  " #### ###

*  SELECTION-SCREEN BEGIN OF BLOCK B1 WITH FRAME.

*    SELECT-OPTIONS : S_ZCODE FOR ZEDT09_001-ZCODE.

*  SELECTION-SCREEN END OF BLOCK B1.

*  SELECTION-SCREEN BEGIN OF BLOCK B2 WITH FRAME.

*    PARAMETERS : P_ZGEN LIKE ZEDT09_001-ZGENDER.

*  SELECTION-SCREEN END OF BLOCK B2.

*

**   3. # select-options# ####, ##### #### #####

*  SELECT *

*    FROM ZEDT09_001

*    INTO CORRESPONDING FIELDS OF TABLE GT_STUDENT

*    WHERE ZCODE IN S_ZCODE "## ####, IN # #### ..

*    AND ZGENDER = P_ZGEN.

*

*  IF GT_STUDENT[] IS NOT INITIAL.

*    CLEAR : GS_STUDENT.

*    LOOP AT GT_STUDENT INTO GS_STUDENT.

*      WRITE : / GS_STUDENT-ZCODE , GS_STUDENT-ZKNAME.

*    ENDLOOP.

*  ELSE.

*    WRITE : / '### ##'.

*  ENDIF.





* >> select-options ### ## <<<<<<<<<<<<<<<<<<<<<<<<<<



**   "### ## ## ###!!

*  TABLES : ZEDT09_001.

*

*  DATA : BEGIN OF GS_STUDENT.

*    INCLUDE TYPE ZEDT09_001.

*    DATA : END OF GS_STUDENT.

*  DATA : GT_STUDENT LIKE TABLE OF GS_STUDENT.

*

*  " select-options# #### ####, range table## ### sign, option, low, high# ### # # ##.

*  " SELECT-OPTIONS : S_ZCODE FOR ZEDT09_001-ZCODE DEFAULT 'SSU-01' SIGN E OPTION EQ.

*  " SELECT-OPTIONS : S_ZCODE FOR ZEDT09_001-ZCODE DEFAULT 'SSU-01' TO 'SSU-09' SIGN I OPTION BT.

*  SELECT-OPTIONS : S_ZCODE FOR ZEDT09_001-ZCODE DEFAULT 'SSU-01' TO 'SSU-09'.

*  " -> ### abap# TO#### ##, LOW# HIGH## ## ####, SIGN I# OPTION BT# #### ##### !

*  PARAMETERS : P_ZGEN LIKE ZEDT09_001-ZGENDER DEFAULT 'M'.

*

*  SELECT *

*    FROM ZEDT09_001

*    INTO CORRESPONDING FIELDS OF TABLE GT_STUDENT

*    WHERE ZCODE IN S_ZCODE "## ####, IN # #### ..

*    AND ZGENDER = P_ZGEN.

*

*  IF GT_STUDENT[] IS NOT INITIAL.

*    CLEAR : GS_STUDENT.

*    LOOP AT GT_STUDENT INTO GS_STUDENT.

*      WRITE : / GS_STUDENT-ZCODE , GS_STUDENT-ZKNAME.

*    ENDLOOP.

*  ELSE.

*    WRITE : / '### ##'.

*  ENDIF.







* >> select-options ## ###.. (### ####, multiple selections## ###,  ####) <<<<<<<<<<<<<<<<<<<<<<<<<<

*  TABLES : ZEDT09_001.

*

*  " ### ####, multiple selections ## ###

*  " SELECT-OPTIONS : S_ZCODE FOR ZEDT09_001-ZCODE DEFAULT 'SSU-01' NO INTERVALS NO-EXTENSION.

*  SELECT-OPTIONS : S_ZCODE FOR ZEDT09_001-ZCODE VISIBLE LENGTH 3. "#### ### ##

*  PARAMETERS : P_ZGEN LIKE ZEDT09_001-ZGENDER.







* >> MODIF ID ### ## <<<<<<<<<<<<<<<<<<<<<<<<<<

* - ####, ### ## #, ### ### ## ## #### #### / ####### / ## #### ### ##

*   ### ## ### #### ## !



* - MODIF ID# "## ##"## #### #### ## "###"### ###.

* - ## # #### ## 3####.



* ## ### #### ####, #### ## ##### ###### ## -> ## ####(zcode, zgen) ###/#### ## ##

*  TABLES : ZEDT09_001.

*

*  SELECTION-SCREEN BEGIN OF BLOCK B1 WITH FRAME.

*    SELECT-OPTIONS : S_ZCODE FOR ZEDT09_001-ZCODE.

*    PARAMETERS : P_ZGEN LIKE ZEDT09_001-ZGENDER.

*  SELECTION-SCREEN END OF BLOCK B1.

*

*  " 1. ### #### #### ###. (## MODIF ID# ## 3## #### ####!)

*  SELECTION-SCREEN BEGIN OF BLOCK B2 WITH FRAME.

*    PARAMETERS : P_CH1 AS CHECKBOX DEFAULT 'X' MODIF ID M1.

*    PARAMETERS : P_CH2 AS CHECKBOX MODIF ID M2.

*  SELECTION-SCREEN END OF BLOCK B2.






" 2. SELECTION-SCREEN# ####, ## ##




* AT SELECTION-SCREEN #### #### ### F8# ## ###, ### ##### #### ### ###

* ### ### ###, ## ### ### ## ##

*  AT SELECTION-SCREEN OUTPUT.

*    LOOP AT SCREEN. "### ## ## #### (SCREEN ###)# ### ##..

*      IF SCREEN-GROUP1 = 'M2'. "## #### ### 'M2'##? == P_Ch2 ##### ## ####

*        SCREEN-INPUT = '0'. "#### ### 0 (####)

*        MODIFY SCREEN.

*      ENDIF.

*    ENDLOOP.

*  " => ####, P_CH2 ##### ### ####, MODIF ID M2# ### ## ### ####



* => # ### M2 ### ## ## ## ####, ### P_CH2 ### ## ### ####

*  AT SELECTION-SCREEN OUTPUT.

*    LOOP AT SCREEN.

*      IF SCREEN-NAME = 'P_CH2'.

*        SCREEN-INPUT = '0'.

*        MODIFY SCREEN.

*      ENDIF.

*    ENDLOOP.



* => ## ### group1# #####, active ### ###

*  AT SELECTION-SCREEN OUTPUT.

*    LOOP AT SCREEN.

*      IF SCREEN-GROUP1 = 'M2'.

*        SCREEN-ACTIVE = '0'. "##### #### ### # ####, ####

*        MODIFY SCREEN.

*      ENDIF.

*    ENDLOOP.



* => ## ### required = '1' : ### # ## ## ##

*  AT SELECTION-SCREEN OUTPUT.

*    LOOP AT SCREEN.

*      IF SCREEN-GROUP1 = 'M2'.

*        SCREEN-REQUIRED = '1'.

*        MODIFY SCREEN.

*      ENDIF.

*    ENDLOOP.



* => ## ### OUTPUT = 0 : ## ## ####

*  AT SELECTION-SCREEN OUTPUT.

*    LOOP AT SCREEN.

*      IF SCREEN-GROUP1 = 'M2'.

*        SCREEN-OUTPUT = '0'.

*        MODIFY SCREEN.

*      ENDIF.

*    ENDLOOP.







* >> USERCOMMAND ## <<<<<<<<<<<<<<<<<<<<<<<<<<

* - USER-COMMAND# #### #### '## ##'# ## # #### ##(###)### ##

* - ##, ####### ##### ## ####, ## ### #### ##, ## ### ##### ###.



* - #, USER-COMMAND# ### ###, #### ### #### ##

*   AT SELECTION-SCREEN ON #### ## #####.






TABLES : ZEDT09_001.



SELECTION-SCREEN BEGIN OF BLOCK B1 WITH FRAME.

  SELECT-OPTIONS : S_ZCODE FOR ZEDT09_001-ZCODE.

  PARAMETERS : P_ZPERNR LIKE ZEDT09_001-ZPERNR MODIF ID M1.

  PARAMETERS : P_ZGEN LIKE ZEDT09_001-ZGENDER MODIF ID M2.

SELECTION-SCREEN END OF BLOCK B1.



"Selection Screen# ## ### ## ######, USER-COMMAND fcode# ####.

"P_R1 ###### USER-COMMAND UC1# #### ##



SELECTION-SCREEN BEGIN OF BLOCK B2 WITH FRAME.

  PARAMETERS : P_R1 RADIOBUTTON GROUP R1 DEFAULT 'X' USER-COMMAND UC1. "user-command #####, ### ### ## #### #### ..

  PARAMETERS : P_R2 RADIOBUTTON GROUP R1.

SELECTION-SCREEN END OF BLOCK B2.



" SELECTION-SCREEN# #### ## ##

" ###, #### P_R1 ###### ####, P_ZGEN ### #####, P_R2# #### #### ##!

AT SELECTION-SCREEN OUTPUT.

  LOOP AT SCREEN.

    IF SCREEN-GROUP1 = 'M2'. "## #### SCREEN## GROUP1# ##




*      IF P_R1 = 'X'.

*        SCREEN-ACTIVE = '1'.

*      ELSEIF P_R2 = 'X'.

*        SCREEN-ACTIVE = '0'.

*      ENDIF.




       SCREEN-INTENSIFIED = '1'. "## ## (1# ## ###)

       SCREEN-DISPLAY_3D = '1'. "### ### ##

       SCREEN-INVISIBLE = '0'. "###### ####

    ENDIF.

    MODIFY SCREEN. "## ### ### ## !!

  ENDLOOP.








* ===========> # ######, SCREEN #### ## ## , ## # GROUP1# ##??   P_R1## USER-COMMAND# #### ##? (### P_R1, P_R2# ## ### ####..)