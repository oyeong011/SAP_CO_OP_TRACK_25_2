
*&---------------------------------------------------------------------*

*& Report ZEDR23_005

*&---------------------------------------------------------------------*

*&

*&---------------------------------------------------------------------*




REPORT ZEDR23_005.



" IF #

" 1. IF - ENDIF

" 2. IF - ELSE - ENDIF

" 3. IF - ELSEIF - ELSE - ENDIF



DATA : GS_STUDENT TYPE ZEDT23_001.

DATA : GT_STUDENT TYPE TABLE OF ZEDT23_001.



GS_STUDENT-ZCODE = 'SSU-01'.

GS_STUDENT-ZKNAME = '#'.

GS_STUDENT-ZENAME = 'KANG'.

GS_STUDENT-ZGENDER = 'M'.

GS_STUDENT-ZTEL = '01099991111'.



IF ( GS_STUDENT-ZGENDER EQ 'M' ) AND ( GS_STUDENT-ZKNAME EQ '#' ).

  GS_STUDENT-ZKNAME = '###'.

  ENDIF.



APPEND GS_STUDENT TO GT_STUDENT.

CLEAR GS_STUDENT.

BREAK-POINT.



""" Internal Table ### ## """

DATA : GV_NUM1 TYPE i,

      GV_NUM2 TYPE i,

      GV_NUM3 TYPE i,

      GV_MAX TYPE i.



GV_NUM1 = 100.

GV_NUM2 = 120.

GV_NUM3 = 110.



" 1#

WRITE : / '**1#-IF## WRITE# ##'.

IF GV_NUM1 < GV_NUM2.

  WRITE : / GV_NUM1,

  / GV_NUM2,

  / 'GV_NUM1 # GV_NUM2## ####.'.

ENDIF.



" 2#

WRITE : / '**2#-IF## WRITE# ##'.

IF GV_NUM1 < GV_NUM2 AND GV_NUM1 < GV_NUM3.

  WRITE : / GV_NUM1,

  / GV_NUM2,

  / GV_NUM3,

  / 'GV_NUM1# GV_NUM2, GV_NUM3## ####.'.

ENDIF.



" 3#

WRITE : / '**3#-ELSE## WRITE# ##'.

IF GV_NUM1 < GV_NUM2.

  WRITE : / GV_NUM1,

  / GV_NUM2,

  / 'GV_NUM2 # GV_NUM1## ###.'.

ELSEIF GV_NUM1 > GV_NUM2.

WRITE : / 'GV_NUM1# GV_NUM2## ###'.

ELSE.

  WRITE : / 'GV_NUM1# GV_NUM2# ####. ### # ###.'.

ENDIF.



" 4#

WRITE : / '**4#-NUM1, NUM2, NUM3 ## ### #### WRITE# ##'.

IF GV_NUM1 > GV_NUM2 AND GV_NUM1 > GV_NUM3.

  WRITE : / 'GV_NUM1', GV_NUM1, '# ## # # ###.'.

ELSEIF GV_NUM2 > GV_NUM1 AND GV_NUM2 > GV_NUM3.

  WRITE : / 'GV_NUM2', GV_NUM2, '# ## # # ###.'.

ELSE.

  WRITE : / 'GV_NUM3', GV_NUM3, '# ## # # ###.'.

ENDIF.