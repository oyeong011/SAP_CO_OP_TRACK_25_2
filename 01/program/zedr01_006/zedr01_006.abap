
*&---------------------------------------------------------------------*

*& Report ZEDR01_006

*&---------------------------------------------------------------------*

*&

*&---------------------------------------------------------------------*




REPORT ZEDR01_006.



DATA : gv_num1 type i VALUE 100.

DATA : gv_num2 type i VALUE 120.

DATA : gv_num3 type i VALUE 110.



WRITE /'************************************************************'.




***********************************




WRITE /'**1#-IF## WRITE# ##'.

WRITE / gv_num1.

WRITE / gv_num2.



IF gv_num1 > gv_num2.

  WRITE /'GV_NUM1# GV_NUM2## ###.'.

ELSEIF gv_num1 = gv_num2.

  WRITE /'GV_NUM1# GV_NUM2# ####.'.

ELSE.

  WRITE /'GV_NUM1# GV_NUM2## ####.'.

ENDIF.



WRITE /'************************************************************'.




***********************************




WRITE /'**2#-IF## WRITE# ##'.

WRITE / gv_num1.

WRITE / gv_num2.

WRITE / gv_num3.



IF gv_num1 > gv_num2.

  IF gv_num1 > gv_num3.

    WRITE /'GV_NUM1# GV_NUM2,GV_NUM3## ###.'.

  ELSEIF gv_num1 = gv_num3.

    WRITE /'GV_NUM1# GV_NUM2## ## GV_NUM3# ####.'.

  ELSE.

    WRITE /'GV_NUM1# GV_NUM2## ### GV_NUM3## ####.'.

  ENDIF.

ELSEIF gv_num1 = gv_num2.

  IF gv_num1 > gv_num3.

    WRITE /'GV_NUM1# GV_NUM2# ### GV_NUM3## ###.'.

  ELSEIF gv_num1 = gv_num3.

    WRITE /'GV_NUM1# GV_NUM2# ## GV_NUM3# ####.'.

  ELSE.

    WRITE /'GV_NUM1# GV_NUM2# ##  GV_NUM3## ####.'.

  ENDIF.

ELSE.

    IF gv_num1 < gv_num3.

    WRITE /'GV_NUM1# GV_NUM2,GV_NUM3## ####.'.

  ELSEIF gv_num1 = gv_num3.

    WRITE /'GV_NUM1# GV_NUM2## ### GV_NUM3# ####.'.

  ELSE.

    WRITE /'GV_NUM1# GV_NUM2## ### GV_NUM3## ###.'.

  ENDIF.

ENDIF.



WRITE /'************************************************************'.




***********************************




WRITE /'**3#-ELSE## WRITE# ##'.

WRITE / gv_num1.

WRITE / gv_num2.



IF gv_num2 < gv_num1.

  WRITE /'GV_NUM2# GV_NUM1## ####.'.

ELSEIF gv_num2 = gv_num1.

  WRITE /'GV_NUM2# GV_NUM1# ####.'.

ELSE.

  WRITE /'GV_NUM2# GV_NUM1## ###.'.

ENDIF.



WRITE /'************************************************************'.

WRITE /'**4#-NUM1, NUM2, NUM3## ### #### WRITE# ##'.

WRITE / gv_num1.

WRITE / gv_num2.

WRITE / gv_num3.

IF ( gv_num1 > gv_num2 ) AND ( gv_num1 > gv_num3 ).

  WRITE /'GV_NUM1# ## # # ###.'.

ELSEIF ( gv_num2 > gv_num3 ) AND ( gv_num2 > gv_num3 ).

  WRITE /'GV_NUM2# ## # # ###'.

ELSEIF ( gv_num3 > gv_num1 ) AND ( gv_num3 > gv_num2 ).

  WRITE /'GV_NUM3# ## # # ###.'.

ENDIF.