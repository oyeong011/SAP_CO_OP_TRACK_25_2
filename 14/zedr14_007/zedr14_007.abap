
*&---------------------------------------------------------------------*

*& Report ZEDR14_007

*&---------------------------------------------------------------------*

*&

*&---------------------------------------------------------------------*




REPORT ZEDR14_007.



"IF ~ ENDIF

DATA : BEGIN OF GS_STUDENT,

  ZPERNR LIKE ZEDT14_001-ZPERNR,

  ZCODE LIKE ZEDT14_001-ZCODE,

  ZKNAME LIKE ZEDT14_001-ZKNAME,

  ZENAME LIKE ZEDT14_001-ZENAME,

  ZGENDER LIKE ZEDT14_001-ZGENDER,

  ZGNAME TYPE C LENGTH 4,

  ZTEL LIKE ZEDT14_001-ZTEL,

  END OF GS_STUDENT.



DATA : GT_STUDENT LIKE TABLE OF GS_STUDENT.



CLEAR : GS_STUDENT, GT_STUDENT.



GS_STUDENT-ZPERNR = '0000000001'.

GS_STUDENT-ZCODE = '###'.

GS_STUDENT-ZKNAME = '###'.

GS_STUDENT-ZENAME = 'KANG'.

GS_STUDENT-ZGENDER = 'G'.

GS_STUDENT-ZTEL = '01011112222'.



IF GS_STUDENT-ZGENDER = 'M'.

  GS_STUDENT-ZGNAME = '##'.

ENDIF.






*APPEND GS_STUDENT TO GT_STUDENT.

*BREAK-POINT.






IF GS_STUDENT-ZGENDER = 'M'.

  GS_STUDENT-ZGNAME = '##'.

ELSE.

  GS_STUDENT-ZGNAME = '##'.

ENDIF.






*APPEND GS_STUDENT TO GT_STUDENT.

*BREAK-POINT.






IF GS_STUDENT-ZGENDER = 'M'.

  GS_STUDENT-ZGNAME = '##'.

ELSEIF GS_STUDENT-ZGENDER = 'F'.

  GS_STUDENT-ZGNAME = '##'.

ELSE.

  GS_STUDENT-ZGNAME = '##'.

ENDIF.






*APPEND GS_STUDENT TO GT_STUDENT.

*BREAK-POINT.



*&---------------------------------------------------------------------*






"IF ~ AND(OR) ~ ENDIF

IF ( GS_STUDENT-ZGENDER = 'M' ) OR ( GS_STUDENT-ZKNAME = '###' ).

  GS_STUDENT-ZGNAME = '##'.

ENDIF.



APPEND GS_STUDENT TO GT_STUDENT.




*BREAK-POINT.



*&---------------------------------------------------------------------*






"IF# ##

DATA : GV_NUM1 TYPE I,

       GV_NUM2 TYPE I,

       GV_NUM3 TYPE I.



GV_NUM1 = 100.

GV_NUM2 = 120.

GV_NUM3 = 110.





WRITE :/ '**1# - IF## WRITE ##'.

WRITE :/ GV_NUM1.

WRITE :/ GV_NUM2.



IF GV_NUM1 < GV_NUM2.

  WRITE :/ 'GV_NUM1# GV_NUM2## ####.'.

ENDIF.



WRITE :/ '----------------------------------------'.

WRITE :/ '**2# - IF## WRITE ##'.

WRITE :/ GV_NUM1.

WRITE :/ GV_NUM2.

WRITE :/ GV_NUM3.

IF ( GV_NUM1 < GV_NUM2 ) AND ( GV_NUM1 < GV_NUM3 ).

  WRITE :/ 'GV_NUM1# GV_NUM2, GV_NUM3## ####.'.

ENDIF.



WRITE :/ '----------------------------------------'.

WRITE :/ '**3# - ELSE## WRITE ##'.

WRITE :/ GV_NUM1.

WRITE :/ GV_NUM2.



IF GV_NUM1 >= GV_NUM2.

ELSE.

  WRITE :/ 'GV_NUM2# GV_NUM1## ###.'.

ENDIF.



WRITE :/ '----------------------------------------'.

WRITE :/ '** 4# - ## ### #### WRITE# ##'.



IF ( GV_NUM2 > GV_NUM1 ) AND ( GV_NUM2 > GV_NUM3 ).

  WRITE :/ |GV_NUM2# { GV_NUM2 } ## # ####.|.

ENDIF.