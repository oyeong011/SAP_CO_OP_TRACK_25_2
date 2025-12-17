
*&---------------------------------------------------------------------*

*& Report ZEDR018_011

*&---------------------------------------------------------------------*

*&

*&---------------------------------------------------------------------*




REPORT ZEDR018_011.

SELECTION-SCREEN BEGIN OF BLOCK b1 with FRAME. "#### ##.

PARAMETERS : p_zcode like zedt018_001-zcode LOWER CASE. " ### ###  LOWER CASE, ### ### obligatory.

PARAMETERS : p_zpernr type c length 10 no-display. "#### ## ##, ##### ##### ### #### ###,

" ## ### #### # ## ##.

PARAMETERS : p_znum type p DECIMALS 2.

SELECTION-SCREEN END OF BLOCK b1.



SELECTION-SCREEN BEGIN OF BLOCK B2 with FRAME.

PARAMETERS : p_zgen like zedt018_001-zgender default 'M'.

PARAMETERS : p_zcode2 like zedt018_001-zcode VISIBLE LENGTH 5. "#### 10## / ### ##### 5### ##.

PARAMETERS : z_check as CHECKBOX DEFAULT 'X'. "checkbox ### ## # ##.

SELECTION-SCREEN BEGIN OF LINE.

PARAMETERS : P_R1 RADIOBUTTON GROUP R1 DEFAULT 'X'.

SELECTION-SCREEN POSITION 3. " ### ## position ## ## ##.

SELECTION-SCREEN COMMENT (10) FOR FIELD P_R1. " ### ## ## #(###) ##

PARAMETERS : P_R2 RADIOBUTTON GROUP R1. "## ## ### ### ## ##### #.

SELECTION-SCREEN POSITION 20. " position ## ## ##.

SELECTION-SCREEN COMMENT (10) FOR FIELD P_R2. " ## #(###) ##

SELECTION-SCREEN END OF line.

SELECTION-SCREEN END OF BLOCK b2.

BREAK-POINT.



if z_check = 'X'.

  WRITE :/ '#### ##'.

else.

  WRITE :/ '## ##'.

endif.



data : BEGIN OF gs_student,

  zcode type ZEDT018_001-zcode,

  zgender type ZEDT018_001-zgender,

END OF gs_student.



data : gt_student like TABLE OF gs_student.







select * from zedt018_001

  into CORRESPONDING FIELDS OF TABLE gt_student

  WHERE zcode = p_zcode

  and zgender = p_zgen.





if gt_student[] is not INITIAL.

  WRITE :/ '### ##'.

ELSE.

  WRITE :/ '### ##'.

ENDIF.