
*&---------------------------------------------------------------------*

*& Report ZEDR04_067

*&---------------------------------------------------------------------*

*&

*&---------------------------------------------------------------------*




REPORT ZEDR04_067.



DATA GT_STUDENT TYPE TABLE OF ZEDT04_001.



SELECTION-SCREEN BEGIN OF BLOCK B1 WITH FRAME.

  PARAMETERS P_ZCODE LIKE ZEDT04_001-ZCODE  LOWER CASE        " #### ## ##

                                            OBLIGATORY        " ## # ##

                                            VISIBLE LENGTH 5.

  PARAMETERS P_ZPERNR TYPE C LENGTH 10      NO-DISPLAY.

  PARAMETERS P_ZGEN LIKE ZEDT04_001-ZGENDER DEFAULT 'M'.

SELECTION-SCREEN END OF BLOCK B1.



SELECTION-SCREEN BEGIN OF BLOCK B2 WITH FRAME.  " ##

  PARAMETERS Z_CHECK AS CHECKBOX DEFAULT 'X'.           " CHECK BOX



  SELECTION-SCREEN BEGIN OF LINE.               " ##

    PARAMETERS P_R1 RADIOBUTTON GROUP R1 DEFAULT 'X'.   " RADIO BUTTON

    SELECTION-SCREEN POSITION 3.                    " ##

    SELECTION-SCREEN COMMENT (10) FOR FIELD P_R1.   " ###



    PARAMETERS P_R2 RADIOBUTTON GROUP R1.

    SELECTION-SCREEN POSITION 20.

    SELECTION-SCREEN COMMENT (10) FOR FIELD P_R2.

  SELECTION-SCREEN END OF LINE.



SELECTION-SCREEN END OF BLOCK B2.



" CHECK BOX ## ##

IF Z_CHECK = 'X'.

  WRITE / '#### ##1'.

ELSE.

  WRITE / '## ##1'.

ENDIF.



" RADIO BUTTON ## ##

IF P_R1 = 'X'.

  WRITE / '#### ##2'.

ELSEIF P_R2 = 'X'.

  WRITE / '## ##2'.

ENDIF.



" PARAMETERS# ### SELECT #

SELECT * FROM ZEDT04_001

  INTO CORRESPONDING FIELDS OF TABLE GT_STUDENT

  WHERE ZCODE = P_ZCODE

  AND   ZGENDER = P_ZGEN.



IF GT_STUDENT[] IS NOT INITIAL.

  WRITE / '### ##'.

ELSE.

  WRITE / '### ##'.

ENDIF.