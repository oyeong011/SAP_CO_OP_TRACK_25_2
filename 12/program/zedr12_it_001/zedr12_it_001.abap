
*&---------------------------------------------------------------------*

*& Report ZEDR12_IT_1

*&---------------------------------------------------------------------*

*&

*&---------------------------------------------------------------------*




REPORT ZEDR12_IT_001.



DATA: GS_ZEDT12 TYPE ZEDT12_001. "### ##

DATA: GT_ZEDT12 TYPE TABLE OF ZEDT12_001. "###### ##



GS_ZEDT12-ZCODE = 'SSU-01'.

GS_ZEDT12-ZPERNR = '0000000001'.

GS_ZEDT12-ZKNAME = '###'.

GS_ZEDT12-ZENAME = 'KANG'.

GS_ZEDT12-ZGENDER = 'M'.

GS_ZEDT12-ZTEL = '01011111111'.  "HEADER(###)# ### ##.






*BREAK-POINT. "HEADER##






APPEND GS_ZEDT12 TO GT_ZEDT12.   "BODY(######)# ### ##.






*BREAK-POINT. "########






GS_ZEDT12-ZCODE = 'SSU-02'.

GS_ZEDT12-ZPERNR = '0000000002'.

GS_ZEDT12-ZKNAME = '##'.

GS_ZEDT12-ZENAME = 'JENNY'.

GS_ZEDT12-ZGENDER = 'F'.

GS_ZEDT12-ZTEL = '01011111112'. "HEADER(###)# ### ##.






*BREAK-POINT. "HEADER##






APPEND GS_ZEDT12 TO GT_ZEDT12.  "BODY(######)# ### ##.



BREAK-POINT. "########