
*&---------------------------------------------------------------------*

*& Report ZEDR022_013

*&---------------------------------------------------------------------*

*&

*&---------------------------------------------------------------------*




REPORT ZEDR022_013.



DATA : GT_STUDENT TYPE TABLE OF ZEDT022_001.






* Parameter ##

*- ### ### ### ### ## ##### ###### #### ### ## ##(## : 8##)

*- #### ## # ## #### ##

*- DATA ## VALUE(# ##)# ## ### #######, #### # ## ##



*more->text element ### selection texts # DDIC REF CHECK : ## ##### ### # ####

*### #### ## ### ### ## ### ## ##

*PARAMETERS : P_ZCODE LIKE ZEDT022_001-ZCODE VISIBLE LENGTH 5.

*LOWER CASE : ### ## ##

*OBLIGATORY : #### ## ## # ## # - ### fill out requried entry fileds.

*VISIBLE LENGTH 5 : ### ### ## ## ## ## ## ssu-02## ### ## ### su-02# ##

*PARAMETERS : P_ZPERNR TYPE C LENGTH 10 NO-DISPLAY.

*NO-DISPLAY : #### ####, ##### ##### ### #### ### ## ### #### # ## ##




"PARAMETERS : P_ZNUM TYPE P DECIMALS 2. "### ### #### ### ## ### ###: P TYPE




*PARAMETERS : P_ZGEN LIKE ZEDT022_001-ZGENDER DEFAULT 'M'."default #### ## # ## # ###

*search help : #### ### value## ## search help# ### ### ### #### ##

*PARAMETERS : P_R1 RADIOBUTTON GROUP R1 DEFAULT 'X'.

*PARAMETERS : P_R2 RADIOBUTTON GROUP R1."### ## ### ## # ##

*PARAMETERS : Z_CHECK AS CHECKBOX DEFAULT 'X'."CHECK BOX ### ### ##

*

*IF Z_CHECK = 'X'.

*  WRITE : / '#### ##'.

*ELSE.

*  WRITE : / '## ##'.

*ENDIF.

*#### ### ## ##



*###### ## ### ##

*IF P_R1 = 'X'.

*  WRITE : / '#### ##'.

*ELSEIF P_R2 = 'X'..

*  WRITE : / '## ##'.

*ENDIF.



*#### #### ###




SELECTION-SCREEN BEGIN OF BLOCK B1 WITH FRAME.

PARAMETERS : P_ZCODE LIKE ZEDT022_001-ZCODE.

PARAMETERS : P_ZPERNR TYPE C LENGTH 10 NO-DISPLAY.

PARAMETERS : P_ZGEN LIKE ZEDT022_001-ZGENDER DEFAULT 'M'.

SELECTION-SCREEN END OF BLOCK B1.






*SELECTION-SCREEN BEGIN OF BLOCK B2 WITH FRAME.

*SELECTION-SCREEN BEGIN OF LINE.

*  PARAMETERS : P_R1 RADIOBUTTON GROUP R1 DEFAULT 'X'.

*SELECTION-SCREEN POSITION 3. "3: postion ## ## ##

*SELECTION-SCREEN COMMENT (10) FOR FIELD P_R1."10: ###(###) ##

*PARAMETERS : P_R1 RADIOBUTTON GROUP R1 DEFAULT 'X'.

*PARAMETERS : P_R2 RADIOBUTTON GROUP R1.

*PARAMETERS : Z_CHECK AS CHECKBOX DEFAULT 'X'.

*SELECTION-SCREEN END OF BLOCK B2.






SELECT * FROM ZEDT022_001

  INTO CORRESPONDING FIELDS OF TABLE GT_STUDENT

  WHERE ZCODE = P_ZCODE

  AND ZGENDER = P_ZGEN.



IF GT_STUDENT[] IS NOT INITIAL.

  WRITE :/ '### ##'.

ELSE.

  WRITE :/ '### ##'.

ENDIF.