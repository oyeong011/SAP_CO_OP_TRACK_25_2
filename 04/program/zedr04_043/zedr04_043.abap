
*&---------------------------------------------------------------------*

*& Report ZEDR04_043

*&---------------------------------------------------------------------*

*&

*&---------------------------------------------------------------------*




REPORT ZEDR04_043.



DATA : GV_NUM1 TYPE I VALUE 100,

      GV_NUM2 TYPE I VALUE 120,

      GV_NUM3 TYPE I VALUE 110.



WRITE / '**1#'.

IF GV_NUM1 < GV_NUM2.

  WRITE / 'GV_NUM1# GV_NUM2## ####.'.

ENDIF.



WRITE / '**2#'.

IF ( GV_NUM1 < GV_NUM2 ) AND ( GV_NUM1 < GV_NUM3 ).

  WRITE / 'GV_NUM1# GV_NUM2, GV_NUM3## ####.'.

ENDIF.



WRITE / '**3#'.

IF GV_NUM1 >= GV_NUM2 .

  WRITE / 'GV_NUM1# GV_NUM2## ### ####.'.

ELSE.

  WRITE / 'GV_NUM2# GV_NUM1## ###.'.

ENDIF.



WRITE / '**4#'.

IF GV_NUM1 > GV_NUM2.

  IF GV_NUM1 > GV_NUM3.

    WRITE / 'GV_NUM1# ## # ####.'.

  ELSE.

    WRITE / 'GV_NUM3# ## # ####.'.

  ENDIF.

ELSEIF GV_NUM2 > GV_NUM3.

  WRITE / 'GV_NUM2# ## # ####.'.

ELSE.

  WRITE / 'GV_NUM3# ## # ####.'.

ENDIF.