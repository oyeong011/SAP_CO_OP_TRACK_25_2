
*&---------------------------------------------------------------------*

*& Report ZEDR19_019

*&---------------------------------------------------------------------*

*&

*&---------------------------------------------------------------------*




REPORT ZEDR19_019.



DATA : GV_NUM1 TYPE I VALUE 100,

      GV_NUM2 TYPE I VALUE 120,

      GV_NUM3 TYPE I VALUE 110.



WRITE :/ '**1#-IF## WRITE# ##'.

IF GV_NUM1 < GV_NUM2.

  WRITE :/ GV_NUM1.

  WRITE :/ GV_NUM2.

  WRITE :/ 'GV_NUM1# GV_NUM2## ####.'.

ELSE.

  WRITE :/ 'GV_NUM1# GV_NUM2## ## ####.'.

ENDIF.



WRITE :/.

WRITE :/.

WRITE :/ '**2#-IF## WRITE# ##'.

IF ( GV_NUM1 < GV_NUM2 ) AND ( GV_NUM1 < GV_NUM3 ).

  WRITE :/ GV_NUM1.

  WRITE :/ GV_NUM2.

  WRITE :/ GV_NUM3.

  WRITE :/ 'GV_NUM1# GV_NUM2, GV_NUM3## ####.'.

ELSE.

  WRITE :/ 'GV_NUM1# GV_NUM2, GV_NUM3## ## ####.'.

ENDIF.



WRITE :/.

WRITE :/.

WRITE :/ '**3#-ELSE## WRITE# ##'.

IF GV_NUM1 > GV_NUM2.

  WRITE :/ GV_NUM1.

  WRITE :/ GV_NUM2.

  WRITE :/ 'GV_NUM1# GV_NUM2## ###.'.

ELSE.

  WRITE :/ 'GV_NUM2# GV_NUM1## ###.'.

ENDIF.



WRITE :/.

WRITE :/.

WRITE :/ '**4#-NUM1, NUM2, NUM3 ## ### #### WRITE# ##'.

IF GV_NUM1 > GV_NUM2.

  IF GV_NUM1 > GV_NUM3.

    WRITE :/ 'GV_NUM1#'.

    WRITE : GV_NUM1.

    WRITE : '## # ####.'.

  ENDIF.

ELSEIF GV_NUM2 > GV_NUM1.

  IF GV_NUM2 > GV_NUM3.

    WRITE :/ 'GV_NUM2#'.

    WRITE : GV_NUM2.

    WRITE : '## # ####.'.

  ENDIF.

ELSE.

    WRITE :/ 'GV_NUM3#'.

    WRITE : GV_NUM3.

    WRITE : '## # ####.'.

ENDIF.