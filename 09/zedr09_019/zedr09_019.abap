
*&---------------------------------------------------------------------*

*& Report ZEDR09_019

*&---------------------------------------------------------------------*

*&

*&---------------------------------------------------------------------*




REPORT ZEDR09_019.








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



* =====================================================================





* =====================================================================

* 0. #### ## & ## ###

*    - Parameter ### ## : 8###



* 0. #### ##

*      1. Text-Elements > Selection Texts > Text## ## ####

*      2. Data Element

*         - Text-Elements > Selection Texts > Text## ### data element####,

*           DDIC REF CHECK # ## ##

*             - ## ##### ABAP Dictionary(DDIC)# ### ### #### ### ### #### ###

*             - ####, ### ### ## .. ## ## ##



* =====================================================================



**   1. #### ### (TYPE ##, ###, Default#, ###, ###, #### ##

*

*  " ###, ###, #### ## (### 10#### ## 5# ##, #### 5### ##)

*  PARAMETERS : P_ZCODE LIKE ZEDT09_001-ZCODE LOWER CASE OBLIGATORY VISIBLE LENGTH 5.

*  PARAMETERS : P_ZPERNR TYPE C LENGTH 10 NO-DISPLAY. "## ##, ## ##

*  PARAMETERS : P_ZNUM TYPE P DECIMALS 2. "### ##

*

*  " search help# ### ### ###, parameter ## / ###

*  PARAMETERS : P_ZGEN LIKE ZEDT09_001-ZGENDER DEFAULT 'M'.

*

*

**   2. checkbox# ### ## ####

*  PARAMETERS : Z_CHECK AS CHECKBOX DEFAULT 'X'. "abap### ### 'X'# ## ###, ## ### ### ###

*

*  IF Z_CHECK = 'X'.

*     WRITE : / '#### ##'.

*  ELSE.

*    WRITE : / '## ##'.

*  ENDIF.

*

*

**   3. radio button

**   - ## #### ## ## ### ## ##!

*  PARAMETERS : P_R1 RADIOBUTTON GROUP R1 DEFAULT 'X'.

*  PARAMETERS : P_R2 RADIOBUTTON GROUP R1.

*

*  IF P_R1 = 'X'.

*    WRITE : / 'p_r1 ##### ###'.

*  ELSEIF P_R2 = 'X'.

*    WRITE : / 'p_r2 ##### ###'.

*  ENDIF.





* 4. ## ## parameters #### ####, BLOCK## #### ####

*  SELECTION-SCREEN BEGIN OF BLOCK B1 WITH FRAME.

*    PARAMETERS : P_ZCODE LIKE ZEDT09_001-ZCODE.

*    PARAMETERS : P_ZPERNR TYPE C LENGTH 10 NO-DISPLAY.

*    PARAMETERS : P_ZGEN LIKE ZEDT09_001-ZGENDER DEFAULT 'M'.

*  SELECTION-SCREEN END OF BLOCK B1.

*

*  SELECTION-SCREEN BEGIN OF BLOCK B2 WITH FRAME.

*    PARAMETERS : P_R1 RADIOBUTTON GROUP R1 DEFAULT 'X'.

*    PARAMETERS : P_R2 RADIOBUTTON GROUP R1.

*    PARAMETERS : Z_CHECK AS CHECKBOX DEFAULT 'X'.

*  SELECTION-SCREEN END OF BLOCK B2.



* 5. #### RADIO BUTTON# # ###, #### ###, ### ####.




SELECTION-SCREEN BEGIN OF BLOCK B1 WITH FRAME.

  PARAMETERS : P_ZCODE LIKE ZEDT09_001-ZCODE.

  PARAMETERS : P_ZPERNR TYPE C LENGTH 10 NO-DISPLAY.

  PARAMETERS : P_ZGEN LIKE ZEDT09_001-ZGENDER DEFAULT 'M'.

SELECTION-SCREEN END OF BLOCK B1.



SELECTION-SCREEN BEGIN OF BLOCK B2 WITH FRAME.

  SELECTION-SCREEN BEGIN OF LINE.

    PARAMETERS : P_R1 RADIOBUTTON GROUP R1 DEFAULT 'X'.

  SELECTION-SCREEN POSITION 3. "position ## ## ##

  SELECTION-SCREEN COMMENT (10) FOR FIELD P_R1. "10 : ###(###) ##

    PARAMETERS : P_R2 RADIOBUTTON GROUP R1.

  SELECTION-SCREEN POSITION 20.

  SELECTION-SCREEN COMMENT (10) FOR FIELD P_R2. "10 : ###(###) ##

  SELECTION-SCREEN END OF LINE.

SELECTION-SCREEN END OF BLOCK B2.



DATA : GS_STUDENT LIKE ZEDT09_001.

DATA : GT_STUDENT LIKE TABLE OF GS_STUDENT.






* 5. ##, ## PARAMETERS# SELECT## ###### ###.!




SELECT *

  FROM ZEDT09_001

  INTO CORRESPONDING FIELDS OF TABLE GT_STUDENT

  WHERE ZCODE = P_ZCODE

  AND   ZGENDER = P_ZGEN.



CLEAR : GS_STUDENT.

LOOP AT GT_STUDENT INTO GS_STUDENT.

  WRITE : 'zcode : ', GS_STUDENT-ZCODE.



  CLEAR : GS_STUDENT.

ENDLOOP.