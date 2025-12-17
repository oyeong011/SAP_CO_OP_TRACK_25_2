
*&---------------------------------------------------------------------*

*& Report ZEDR022_014

*&---------------------------------------------------------------------*

*&

*&---------------------------------------------------------------------*




REPORT ZEDR022_014.






*SELECT-OPTION

*-parameter# ### ### ## #### input ### # ## ### range## #### ###

*-sign, option## ##. sign : ###, option:###

*-low, high ## ### ### sign : i, option : bt ## ##

*-low## ## ### option:EQ##, #, parameter# ##

*-low# ## & high## # ### error






TABLES : ZEDT022_001. "select-option ###, FOR ## ### #### tables# ##



data : begin of gs_student.

  include structure
zedt022_001
.

  data : end of gs_student.

data : gt_student like table of gs_student.




*

*selection-screen begin of block b1 with frame.

*  select-options : s_zcode for zedt022_001-zcode.

*selection-screen end of block b1.

*

*selection-screen begin of block b2 with frame.

*  parameters : p_zgen like zedt022_001-zgender.

*selection-screen end of block b2.

*

*PARAMETERS : s_zcode like zedt022_001-zcode,

*             p_zgen like zedt022_001-zgender.

*

*DATA : GT_STUDENT TYPE TABLE OF ZEDT022_001,

*       GS_STUDENT TYPE ZEDT022_001.



*select * from zedt022_001

*  into corresponding fields of table gt_student

*  where zcode in s_zcode

*  and zgender = p_zgen.

*

*if gt_student[] is not initial.

*  clear : gs_student.

*  loop at gt_student into gs_student.

*    write :/ gs_student-zcode, gs_student-zkname.

*  endroop.

*else.

*  write :/ '#####'.

*endif.



*SELECT-OPTIONS : S_ZCODE FOR ZEDT022_001-ZCODE DEFAULT 'SSU-01' TO 'SSU-99' SIGN I OPTION BT.




" default# #### 1#### option# BQ ## ##




*SELECT-OPTIONS : S_ZCODE FOR ZEDT022_001-ZCODE DEFAULT 'SSU-01' VISIBLE LENGTH 3.




"NO INTERVALS : ~T0(###)# #### ##

"NO-EXTENSION : multiple selections ### ##

"VISIBLE LENGTH : ## ##




*PARAMETERS : P_ZGEN LIKE ZEDT022_001-ZGENDER.



*MODIF ID ## : MODIF ID : ## 3### ###

*-#### ### ## ## ## #####




SELECTION-SCREEN BEGIN OF BLOCK B1 WITH FRAME.

  SELECT-OPTIONS : S_ZCODE FOR ZEDT022_001-ZCODE.

  PARAMETERS : P_ZGEN LIKE ZEDT022_001-ZGENDER.

SELECTION-SCREEN END OF BLOCK B1.




**1. ### ### #### ###(#### ### ### 3## #### ##)




SELECTION-SCREEN BEGIN OF BLOCK B2 WITH FRAME.

  PARAMETERS : P_CH1 AS CHECKBOX DEFAULT 'X' MODIF ID M1. "selection screen : #### group1##

  PARAMETERS : P_CH2 AS CHECKBOX MODIF ID M2.

SELECTION-SCREEN END OF BLOCK B2.



AT SELECTION-SCREEN OUTPUT. "2. SELECTION-SCREEN# #### ## ##

  LOOP AT SCREEN.

    IF SCREEN-GROUP1 = 'M2'. "3. MODIF ID# ## ### ##

      SCREEN-ACTIVE = '0'.

      "SCREEN-INPUT = '0'. "4. ### # ##(input : 0, screen # input# 0 #, #### ## ####

      "SCREEN-INOUT = '1'. "REQUIRED = 1 : ### # ## ## ##

      MODIFY SCREEN.

      ENDIF.

  ENDLOOP.






*AT SELECTION-SCREEN OUTPUT. "2. SELECTION-SCREEN# #### ## ##

*  LOOP AT SCREEN.

*    IF SCREEN-NAME = 'P_CH2'.

*      SCREEN-INPUT = '0'. "### # ##(input : 0, screen # input# 0 #, #### ## ####

*      MODIFY SCREEN.

*      ENDIF.

*  ENDLOOP.





* ### ## # ##

*SELECT * FROM zedt022_001

*  INTO CORRESPONDING FIELDS OF TABLE gt_student

*  WHERE zcode IN s_zcode AND zgender = p_zgen.

*

*IF gt_student IS NOT INITIAL.

*  LOOP AT gt_student INTO gs_student.

*    WRITE: / gs_student-zcode, gs_student-zkname.

*  ENDLOOP.

*ELSE.

*  WRITE: / '### ##'.

*ENDIF.



*USERCOMMAND : #### ## usercommand ### ##

*-selection screen# ## ### ## ### ### user-command fcode# ####

*- user-command# #### #### ## ### ## ###

*-(## ### ## ##, selection screen ##)

*-EX. ### ## ### ## ## ## ##

*SELECTION-SCREEN BEGIN OF BLOCK B1 WITH FRAME.

*  SELECT-OPTIONS : S_ZCODE FOR ZEDT022_001-ZCODE.

*  PARAMETERS : P_ZPERNR LIKE ZEDT022_001-ZPERNR MODIF ID M1.

*  PARAMETERS : P_ZGEN LIKE ZEDT022_001-ZGENDER MODIF ID M2.

*SELECTION-SCREEN BEGIN OF BLOCK B2 WITH FRAME."1. ### ### #### ###.

*  PARAMETERS : P_R1 RADIOBUTTON GROUP R1 DEFAULT 'X' USER-COMMAND UC1.

**#### #### ## # user-command ##

*  PARAMETERS : P_R2 RADIOBUTTON GROUP R1.

*SELECTION-SCREEN END OF BLOCK B2.




"2. selection screen# ## ### ## ### ### USER-COMMAND FCODE# ####.






*AT SELECTION-SCREEN OUTPUT. "3. SELECTION-SCREEN# #### ## ##

*  LOOP AT SCREEN.

*    IF SCREEN-GROUP1 = 'M2'."4. MODIF ID# ## ### ##

*      IF P_R1 = 'X'.

*        SCREEEN-ACTIVE = '1'.

*      ELSEIF P_R2 = 'X'.

*        SCREEN-ACTIVE = '0'.

*      ENDIF. "5. ###### ## M2##

*    ENDIF.

*    MODIFY SCREEN.

*  ENDLOOP.



*  AT SELECTION-SCREEN OUTPUT. "3. SELECTION-SCREEN# #### ## ##

*  LOOP AT SCREEN.

*    IF SCREEN-GROUP1 = 'M2'."4. MODIF ID# ## ### ##

*      IF P_R1 = 'X'.

*        SCREEN-INENSIFIED = '1'.

*      ENDIF. "5. ###### ## M2##

*    ENDIF.

*    MODIFY SCREEN.

*  ENDLOOP.