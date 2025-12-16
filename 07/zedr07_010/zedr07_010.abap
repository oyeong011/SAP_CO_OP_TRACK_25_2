
*&---------------------------------------------------------------------*

*& Report ZEDR07_010

*&---------------------------------------------------------------------*

*&

*&---------------------------------------------------------------------*




REPORT ZEDR07_010.








************************************************************************



*"PARAMETERS : p_zcode LIKE zedt07_001-zcode.

*"PARAMETERS : p_zcode LIKE zedt07_001-zcode LOWER CASE. "### ### ##

*"PARAMETERS : p_zcode LIKE zedt07_001-zcode OBLIGATORY. "### ## #####, # ## ##

*PARAMETERS : p_zcode LIKE zedt07_001-zcode VISIBLE LENGTH 5. "### ### ## ## # ##

*

*PARAMETERS : p_zpernr TYPE c LENGTH 10.

*

*"PARAMETERS : p_znum TYPE p DECIMALS 2.

*PARAMETERS : p_znum TYPE p DECIMALS 2 NO-DISPLAY. "#### ####.

*

*PARAMETERS : p_zgen LIKE zedt07_001-zgender DEFAULT 'M'. "## # ## # ##

*"# zedt07_001-zgender# search help ### ### parameter# ####.

*

*PARAMETERS : z_check AS CHECKBOX DEFAULT 'X'. "#### ### ## # ##

*

*PARAMETERS : p_r1 RADIOBUTTON GROUP r1 DEFAULT 'X'.

*PARAMETERS : p_r2 RADIOBUTTON GROUP r1.

*

*IF p_r1 = 'X'.

*  WRITE :/ '#### ##'.

*ELSEIF p_r2 = 'X'.

*  WRITE :/ '## ##'.

*ENDIF.



*************************************************************************

*

*SELECTION-SCREEN BEGIN OF BLOCK b1 WITH FRAME. "### ## #### ####.

*  PARAMETERS : p_zcode LIKE zedt07_001-zcode.

*  PARAMETERS : p_zpernr TYPE c LENGTH 10 NO-DISPLAY.

*  PARAMETERS : p_zgen LIKE zedt07_001-zgender DEFAULT 'M'.

*SELECTION-SCREEN END OF BLOCK b1.

*

*SELECTION-SCREEN BEGIN OF BLOCK b2 WITH FRAME.

*  PARAMETERS : p_r1 RADIOBUTTON GROUP r1 DEFAULT 'X'.

*  PARAMETERS : p_r2 RADIOBUTTON GROUP r1.

*  PARAMETERS : z_check AS CHECKBOX DEFAULT 'X'.

*SELECTION-SCREEN END OF BLOCK b2.



*************************************************************************



*SELECTION-SCREEN BEGIN OF BLOCK b1 WITH FRAME. "### ## #### ####.

*  PARAMETERS : p_zcode LIKE zedt07_001-zcode.

*  PARAMETERS : p_zpernr TYPE c LENGTH 10 NO-DISPLAY.

*  PARAMETERS : p_zgen LIKE zedt07_001-zgender DEFAULT 'M'.

*SELECTION-SCREEN END OF BLOCK b1.

*

*SELECTION-SCREEN BEGIN OF BLOCK b2 WITH FRAME.

*  SELECTION-SCREEN BEGIN OF LINE.

*    PARAMETERS : p_r1 RADIOBUTTON GROUP r1 DEFAULT 'X'.

*  SELECTION-SCREEN POSITION 3. "## ## ##

*  SELECTION-SCREEN COMMENT (10) FOR FIELD p_r1. "## # (## #) ##.

*

*    PARAMETERS : p_r2 RADIOBUTTON GROUP r1.

*  SELECTION-SCREEN POSITION 20. "## ## ##

*  SELECTION-SCREEN COMMENT (10) FOR FIELD p_r2. "## # (## #) ##.

*  SELECTION-SCREEN END OF LINE.

*SELECTION-SCREEN END OF BLOCK b2.



*************************************************************************



*SELECTION-SCREEN BEGIN OF BLOCK b1 WITH FRAME. "### ## #### ####.

*  PARAMETERS : p_zcode LIKE zedt07_001-zcode.

*  PARAMETERS : p_zpernr TYPE c LENGTH 10 NO-DISPLAY.

*  PARAMETERS : p_zgen LIKE zedt07_001-zgender DEFAULT 'M'.

*SELECTION-SCREEN END OF BLOCK b1.

*

*DATA : gt_student LIKE TABLE OF zedt07_001.

*

*SELECT * FROM zedt07_001

*  INTO CORRESPONDING FIELDS OF TABLE gt_student

*  WHERE zcode = p_zcode "parameter# DB ## #

*  AND zgender = p_zgen.

*

*IF gt_student[] IS NOT INITIAL.

*  WRITE :/ '### ##'.

*ELSE.

*  WRITE :/ '### ##'.

*ENDIF.



**************************************************************************

*

*TABLES : ZEDT07_001.

*

*DATA : BEGIN OF gs_student.

*  INCLUDE TYPE zedt07_001.

*  DATA : END OF gs_student.

*DATA : gt_student LIKE TABLE OF gs_student.

*

*"### #### # ## ### ##

**SELECT-OPTIONS : s_zcode FOR zedt07_001-zcode.

**PARAMETERS : p_zgen LIKE zedt07_001-zgender.

*

*"## ### #### ### ##

*SELECTION-SCREEN BEGIN OF BLOCK b1 WITH FRAME.

*  "SELECT-OPTIONS : s_zcode FOR zedt07_001-zcode.

*

*  "SELECT-OPTIONS : s_zcode FOR zedt07_001-zcode DEFAULT 'SSU-01'. "01## SIGN I OPTION EQ#

*  "### ### ###.

*

*  "SELECT-OPTIONS : s_zcode FOR zedt07_001-zcode DEFAULT 'SSU-01' SIGN E OPTION EQ.

*  "# ### ## ## ### # ####.

*

*  "SELECT-OPTIONS : s_zcode FOR zedt07_001-zcode DEFAULT 'SSU-01' TO 'SSU-99' SIGN I OPTION BT.

*  "BT# default #### 1## ## ####.

*

*  "SELECT-OPTIONS : s_zcode FOR zedt07_001-zcode DEFAULT 'SSU-01' NO INTERVALS.

*  "## ## #### ##. -> ##### ####

*

*  "SELECT-OPTIONS : s_zcode FOR zedt07_001-zcode DEFAULT 'SSU-01' NO INTERVALS NO-EXTENSION.

*  "Multiple selections ### ##

*

*  SELECT-OPTIONS : s_zcode FOR zedt07_001-zcode DEFAULT 'SSU-01' VISIBLE LENGTH 3.

*  "## ## ## ##

*

*SELECTION-SCREEN END OF BLOCK b1.

*

*SELECTION-SCREEN BEGIN OF BLOCK b2 WITH FRAME.

*  PARAMETERS : p_zgen LIKE zedt07_001-zgender.

*SELECTION-SCREEN END OF BLOCK b2.

*

*SELECT * FROM zedt07_001

*  INTO CORRESPONDING FIELDS OF TABLE gt_student

*  WHERE zcode IN s_zcode

*  AND zgender = p_zgen.

*

*IF gt_student[] IS NOT INITIAL.

*  CLEAR : gs_student.

*  LOOP AT gt_student INTO gs_student.

*    WRITE :/ gs_student-zcode , gs_student-zkname.

*  ENDLOOP.

*ELSE.

*  WRITE :/ '### ##'.

*ENDIF.



**************************************************************************



*TABLES : ZEDT07_001.

*

*DATA : BEGIN OF gs_student.

*  INCLUDE TYPE zedt07_001.

*  DATA : END OF gs_student.

*DATA : gt_student LIKE TABLE OF gs_student.

*

*SELECTION-SCREEN BEGIN OF BLOCK b1 WITH FRAME.

*  SELECT-OPTIONS : s_zcode FOR zedt07_001-zcode.

*SELECTION-SCREEN END OF BLOCK b1.

*

*SELECTION-SCREEN BEGIN OF BLOCK b2 WITH FRAME.

*  PARAMETERS : p_ch1 AS CHECKBOX DEFAULT 'X' MODIF ID m1.

*  PARAMETERS : p_ch2 AS CHECKBOX MODIF ID m2.

*SELECTION-SCREEN END OF BLOCK b2.

*

*AT SELECTION-SCREEN OUTPUT.

*  LOOP AT SCREEN.

*    IF screen-group1 = 'M2'. "# ### ##

*      "screen-input = '0'. "#### ###.

*      "screen-active = '0'. " ### ### ###### -> #### ## # ##

*      "screen-required = '1'. "### # ## ## ##

*      screen-output = '0'. "#### ## ## ####.

*      MODIFY SCREEN.

*    ENDIF.

*  ENDLOOP.



**************************************************************************






TABLES : ZEDT07_001.



DATA : BEGIN OF gs_student.

  include structure
zedt07_001
.

  DATA : END OF gs_student.

DATA : gt_student LIKE TABLE OF gs_student.



SELECTION-SCREEN BEGIN OF BLOCK b1 WITH FRAME. "## ### ### 1. ### ### #### ##

  SELECT-OPTIONS : s_zcode FOR zedt07_001-zcode.

  PARAMETERS : p_zpernr LIKE zedt07_001-zpernr MODIF ID m1.

  "PARAMETERS : p_zgen LIKE zedt07_001-zgender MODIF ID m2.

  PARAMETERS : p_zgen LIKE zedt07_001-zgender MATCHCODE OBJECT zsh07_001 MODIF ID m2.

  ""SEARCH HELP# #### ## ### ##### MATCHCODE OBJECT### ## ##.



SELECTION-SCREEN END OF BLOCK b1.



SELECTION-SCREEN BEGIN OF BLOCK b2 WITH FRAME. "2. ### #### ## ### ## ### ###

  "## ### fcode# ###.

  PARAMETERS : p_r1 RADIOBUTTON GROUP r1 DEFAULT 'X' USER-COMMAND uc1. "#### #### ## #

  ""## # ## USER-COMMAND uc1# # ###

  ""### #### #### # ### ##.

  PARAMETERS : p_r2 RADIOBUTTON GROUP r1.

SELECTION-SCREEN END OF BLOCK b2.



AT SELECTION-SCREEN OUTPUT. "3. ### #### #### ## ##

  LOOP AT SCREEN.

    IF screen-group1 = 'M2'. "# ### ###

      IF p_r1 = 'X'. "#### ##### #####

        "screen-active = '1'.

        screen-intensified = '1'. "## ## 1# ## ###

        screen-display_3d = '1'. "### ### ##

        screen-invisible = '1'. "#### ##

        ""# ###### ### #### ## ### ### ### ## ##.



      ELSEIF p_r2 = 'X'. "##### ##### # ### ##.

        screen-active = '0'.

      ENDIF.

    ENDIF.

    MODIFY SCREEN.

  ENDLOOP.