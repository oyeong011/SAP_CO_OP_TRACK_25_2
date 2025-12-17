
*&---------------------------------------------------------------------*

*& Report ZEDR08_005

*&---------------------------------------------------------------------*

*&

*&---------------------------------------------------------------------*




REPORT ZEDR08_005.



DATA : GV_NUM1 TYPE i.

DATA : GV_NUM2 TYPE i.



GV_NUM1 = 100.

GV_NUM2 = 120.



IF GV_NUM1 > GV_NUM2.

  WRITE :/ 'GV_NUM1# GV_NUM2## ###.'.

ELSEIF GV_NUM1 < GV_NUM2.

  WRITE :/ 'GV_NUM1# GV_NUM2## ####.'.

ELSE.

  WRITE :/ 'GV_NUM1# GV_NUM2# ####.'.

ENDIF.



"---------------------------------------------------------------



DATA : GV_NUM21 TYPE i.

DATA : GV_NUM22 TYPE i.

DATA : GV_NUM23 TYPE i.



GV_NUM21 = 100.

GV_NUM22 = 120.

GV_NUM23 = 110.



IF GV_NUM21 < GV_NUM22.

  IF GV_NUM21 < GV_NUM23.

    WRITE :/ 'GV_NUM1# GV_NUM2, GV_NUM3## ####.'.

  ELSEIF GV_NUM21 > GV_NUM23.

    WRITE :/ 'GV_NUM1# GV_NUM2## ## GV_NUM3## ###.'.

  ELSE.

    WRITE :/ 'GV_NUM1# GV_NUM2## ## GV_NUM3# ####.'.

  ENDIF.

ELSEIF GV_NUM21 > GV_NUM22.

  IF GV_NUM21 < GV_NUM23.

    WRITE :/ 'GV_NUM1# GV_NUM2## ## GV_NUM3## ####.'.

  ELSEIF GV_NUM21 > GV_NUM23.

    WRITE :/ 'GV_NUM1# GV_NUM2, GV_NUM3## ###.'.

  ELSE.

    WRITE :/ 'GV_NUM1# GV_NUM2## ## GV_NUM3# ####.'.

  ENDIF.

ELSE.

  IF GV_NUM21 < GV_NUM23.

    WRITE :/ 'GV_NUM1# GV_NUM2# ## GV_NUM3## ####.'.

  ELSEIF GV_NUM21 > GV_NUM23.

    WRITE :/ 'GV_NUM1# GV_NUM2# ## GV_NUM3## ###.'.

  ELSE.

    WRITE :/ 'GV_NUM1# GV_NUM2, GV_NUM3# ####.'.

  ENDIF.

ENDIF.



"---------------------------------------------------------------



DATA : GV_NUM31 TYPE i.

DATA : GV_NUM32 TYPE i.



GV_NUM31 = 100.

GV_NUM32 = 120.



IF GV_NUM31 > GV_NUM32.

  WRITE :/ 'GV_NUM1# GV_NUM2## ###'.

ELSEIF GV_NUM31 = GV_NUM32.

  WRITE :/ 'GV_NUM1# GV_NUM2 ## ####.'.

ELSE.

  WRITE :/ 'GV_NUM2# GV_NUM1## ###.'.

ENDIF.



"---------------------------------------------------------------



DATA : GV_NUM41 TYPE i.

DATA : GV_NUM42 TYPE i.

DATA : GV_NUM43 TYPE i.



GV_NUM41 = 100.

GV_NUM42 = 120.

GV_NUM43 = 110.



IF GV_NUM41 > GV_NUM42.

  IF GV_NUM41 > GV_NUM43.

    WRITE :/ 'GV_NUM1# ', GV_NUM41, '## #####.'.

  ELSE.

    WRITE :/ 'GV_NUM3#', GV_NUM43, '## #####.'.

  ENDIF.

ELSE.

  IF GV_NUM42 > GV_NUM43.

    WRITE :/ 'GV_NUM2#', GV_NUM42, '## #####.'.

  ELSE.

    WRITE :/ 'GV_NUM3#', GV_NUM43, '## #####.'.

  ENDIF.

ENDIF.

"---------------------------------------------------------------