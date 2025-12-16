
*&---------------------------------------------------------------------*

*& Report ZEDR03_004_IF_PRACTICE

*&---------------------------------------------------------------------*

*&

*&---------------------------------------------------------------------*




REPORT ZEDR03_004_IF_PRACTICE.



DATA : GV_NUM1 TYPE I.

DATA : GV_NUM2 TYPE I.

DATA : GV_NUM3 TYPE I.



GV_NUM1 = '100'.

GV_NUM2 = '120'.

GV_NUM3 = '110'.



WRITE : '**1#-IF## WRITE# ##'.

WRITE :/ GV_NUM1.

WRITE :/ GV_NUM2.



IF GV_NUM1 < GV_NUM2.

  WRITE :/ 'GV_NUM1# GV_NUM2## ####.'.

ELSE.

  WRITE :/ 'GV_NUM1# GV_NUM2## ### ####.'.

ENDIF.



WRITE :/ '-----------------------------------------'.



WRITE :/ '**2#-IF## WRITE# ##'.

WRITE :/ GV_NUM1.

WRITE :/ GV_NUM2.

WRITE :/ GV_NUM3.



IF GV_NUM1 < GV_NUM2.

  IF GV_NUM1 < GV_NUM3.

    WRITE :/ 'GV_NUM1# GV_NUM2, GV_NUM3## ####.'.

  ENDIF.

ENDIF.



WRITE :/ '-----------------------------------------'.



WRITE :/ '**3#-ELSE## WRITE# ##'.

WRITE :/ GV_NUM1.

WRITE :/ GV_NUM2.

IF GV_NUM1 > GV_NUM2.

  WRITE :/ 'GV_NUM1# GV_NUM2## ###.'.

ELSE.

  WRITE :/ 'GV_NUM2# GV_NUM2## ###.'.

ENDIF.



WRITE :/ '-----------------------------------------'.



WRITE :/ '4#-NUM1, NUM2, NUM3 ## ### #### WRITE# ##'.

IF GV_NUM1 > GV_NUM2.

  IF GV_NUM1 > GV_NUM3.

    WRITE :/ 'GV_NUM1#'.

    WRITE : GV_NUM1.

  ELSE.

    WRITE :/ 'GV_NUM3#'.

    WRITE : GV_NUM3.

  ENDIF.

ELSE.

  IF GV_NUM2 > GV_NUM3.

    WRITE :/ 'GV_NUM2#'.

    WRITE : GV_NUM2.

  ELSE.

    WRITE :/ 'GV_NUM3#'.

    WRITE : GV_NUM3.

  ENDIF.

ENDIF.



WRITE : '## # ####.'.