
*&---------------------------------------------------------------------*

*& Report ZEDR04_031

*&---------------------------------------------------------------------*

*&

*&---------------------------------------------------------------------*




REPORT ZEDR04_031.



"##### ## ###### ##

DATA GS_ZEDT04 TYPE ZEDT04_001.           " ### ##

DATA GT_ZEDT04 TYPE TABLE OF ZEDT04_001.  " ###### ##



"##### ## ###### ##

"DATA GS_ZEDT04 TYPE ZEDT04_001 OCCURS 0 WITH HEADER LINE. " ## GT_ZEDT04## #

" OR

"DATA GS_ZEDT04 TYPE TABLE OF ZED04_001 WITH HEADER LINE. " TYPE ## LIKE ## ##



" HEADER(###)# DATA # # ##

GS_ZEDT04-ZCODE = 'SSU-04'.

GS_ZEDT04-ZPERNR = '0000000004'.

GS_ZEDT04-ZKNAME = '###'.

GS_ZEDT04-ZENAME = 'KOO'.

GS_ZEDT04-ZGENDER = 'M'.

GS_ZEDT04-ZTEL = '01033334444'.



APPEND GS_ZEDT04 TO GT_ZEDT04.  " ### #### ##(BODY# ### ##)

"APPEND GS_ZEDT04 TO GS_ZEDT04.  " #### ## ### #### ##(BODY# ### ##)



" HEADER(###)# ### ### ##

GS_ZEDT04-ZCODE = 'SSU-02'.

GS_ZEDT04-ZPERNR = '0000000002'.

GS_ZEDT04-ZKNAME = '##'.

GS_ZEDT04-ZENAME = 'JENNY'.

GS_ZEDT04-ZGENDER = 'F'.

GS_ZEDT04-ZTEL = '01055554444'.



APPEND GS_ZEDT04 TO GT_ZEDT04.  " ### #### ##(BODY# ### ##)

"APPEND GS_ZEDT04. " #### ## ### #### ##(BODY# ### ##)



BREAK-POINT.