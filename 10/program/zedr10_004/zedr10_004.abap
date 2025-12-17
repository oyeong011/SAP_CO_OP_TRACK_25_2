
*&---------------------------------------------------------------------*

*& Report ZEDR10_004

*&---------------------------------------------------------------------*

*&

*&---------------------------------------------------------------------*




REPORT ZEDR10_004.



DATA: gs_zedt00 TYPE ZEDT10_001. " def. structure

DATA: gt_zedt00 TYPE TABLE OF ZEDT10_001. " def. internal table



GS_ZEDT00-ZCODE = 'SSU-01'.

GS_ZEDT00-ZPERNR = '000000001'.

GS_ZEDT00-ZKNAME ='###'.

GS_ZEDT00-ZENAME = 'DONG'.

GS_ZEDT00-ZGENDER = 'M'.

GS_ZEDT00-ZTEL = '01011112222'.



APPEND gs_zedt00 TO gt_zedt00.






*BREAK-POINT.






GS_ZEDT00-ZCODE = 'SSU-02'.

GS_ZEDT00-ZPERNR = '000000002'.

GS_ZEDT00-ZKNAME ='##'.

GS_ZEDT00-ZENAME = 'JENNY'.

GS_ZEDT00-ZGENDER = 'F'.

GS_ZEDT00-ZTEL = '01022223333'.



APPEND gs_zedt00 TO gt_zedt00.






*BREAK-POINT.






ULINE /. "deperated ##



DATA: GT_ZEDT01 TYPE ZEDT10_001 OCCURS 0 WITH HEADER LINE.




*DATA: GT_ZEDT01 LIKE ZEDT10_001 OCCURS 0 WITH HEADER LINE.

*DATA: GT_ZEDT01 TYPE TABLE OF ZEDT10_001 WITH HEADER LINE.

*DATA: GT_ZEDT01 LIKE TABLE OF ZEDT10_001 WITH HEADER LINE.






GT_ZEDT01-ZPERNR = '000000001'.

GT_ZEDT01-ZCODE = 'SSU-01'.

GT_ZEDT01-ZKNAME ='###'.

GT_ZEDT01-ZENAME = 'DONG'.

GT_ZEDT01-ZGENDER = 'M'.

GT_ZEDT01-ZTEL = '01011112222'.



BREAK-POINT.



APPEND GT_ZEDT01 TO GT_ZEDT01.

" APPEND GT_ZEDT01.

" ## ### ####.



BREAK-POINT.