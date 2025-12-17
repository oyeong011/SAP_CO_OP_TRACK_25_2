
*&---------------------------------------------------------------------*

*& Report ZEDR02_007

*&---------------------------------------------------------------------*

*&

*&---------------------------------------------------------------------*




REPORT ZEDR02_007.






*DATA : BEGIN OF GS_STUDENT,

*  ZPERNR LIKE ZEDT02_001-ZPERNR, "####

*  ZCODE LIKE ZEDT02_001-ZCODE, "####

*  ZKNAME LIKE ZEDT02_001-ZKNAME, "##

*  ZENAME LIKE ZEDT02_001-ZENAME, "####

*  ZGENDER LIKE ZEDT02_001-ZGENDER, "##

*  ZGNAME TYPE C LENGTH 4, "####

*  ZTEL LIKE ZEDT02_001-ZTEL, "####

*END OF GS_STUDENT.

*

*DATA : GT_STUDENT LIKE TABLE OF GS_STUDENT.

*

*CLEAR : GS_STUDENT, GT_STUDENT.

*

*GS_STUDENT-ZPERNR = '0000000001'.

*GS_STUDENT-ZCODE = 'SSU-01'.

*GS_STUDENT-ZKNAME = '###'.

*GS_STUDENT-ZENAME = 'DONG'.

*GS_STUDENT-ZGENDER = 'M'.

*GS_STUDENT-ZTEL = '01011112222'.

*

**IF GS_STUDENT-ZGENDER = 'M'.

**  GS_STUDENT-ZGNAME = '##'.

**ELSEIF GS_STUDENT-ZGENDER = 'F'.

**  GS_STUDENT-ZGNAME = '##'.

**ELSE.

**  GS_STUDENT-ZGNAME = '##'.

**ENDIF.

*

**IF ( GS_STUDENT-ZGENDER = 'M' ) AND ( GS_STUDENT-ZKNAME = '###' ).

**  GS_STUDENT-ZGNAME = '##'.

**ENDIF.

*

*IF ( GS_STUDENT-ZGENDER = 'M' ) OR ( GS_STUDENT-ZKNAME = '###' ).

*  GS_STUDENT-ZGNAME = '##'.

*ENDIF.

*

*APPEND GS_STUDENT TO GT_STUDENT.

*

*CLEAR : GS_STUDENT.

*

*BREAK-POINT.






"###: EQ= LT< GT> LE<= GE>= NE<>

DATA : GV_NUM1 TYPE I VALUE 100.

DATA : GV_NUM2 TYPE I VALUE 120.

DATA : GV_NUM3 TYPE I VALUE 110.



WRITE : / '1#-IF## WRITE# ##', / GV_NUM1, / GV_NUM2.



IF GV_NUM1 LT GV_NUM2.

  WRITE : / 'GV_NUM1# GV_NUM2## ####.'.

ELSEIF GV_NUM1 GT GV_NUM2.

  WRITE : / 'GV_NUM1# GV_NUM2## ####.'.

ELSE.

  WRITE : / 'GV_NUM1# GV_NUM2# ####.'.

ENDIF.



WRITE : / '2#-IF## WRITE# ##', / GV_NUM1, / GV_NUM2, / GV_NUM3.



IF GV_NUM1 LT GV_NUM2.

  IF GV_NUM1 LT GV_NUM3.

    WRITE : / 'GV_NUM1# GV_NUM2, GV_NUM3## ####.'.

  ELSEIF GV_NUM1 GT GV_NUM3.

    WRITE : / 'GV_NUM3# GV_NUM1, GV_NUM2## ####.'.

  ELSE.

    WRITE : / 'GV_NUM1, GV_NUM3# GV_NUM2## ####.'.

  ENDIF.

ELSEIF GV_NUM1 GT GV_NUM2.

  IF GV_NUM2 LT GV_NUM3.

    WRITE : / 'GV_NUM2# GV_NUM1, GV_NUM3## ####.'.

  ELSEIF GV_NUM2 GT GV_NUM3.

    WRITE : / 'GV_NUM3# GV_NUM1, GV_NUM2## ####.'.

  ELSE.

    WRITE : / 'GV_NUM2, GV_NUM3# GV_NUM1## ####.'.

  ENDIF.

ELSE.

  IF GV_NUM1 LT GV_NUM3.

    WRITE : / 'GV_NUM1, GV_NUM2# GV_NUM3## ####.'.

  ELSE.

    WRITE : / 'GV_NUM3# GV_NUM1, GV_NUM2## ####.'.

  ENDIF.

ENDIF.



WRITE : / '3#-ELSE## WRITE# ##', / GV_NUM1, / GV_NUM2.



IF GV_NUM1 LT GV_NUM2.

  WRITE : / 'GV_NUM2# GV_NUM1## ###.'.

ELSEIF GV_NUM1 GT GV_NUM2.

  WRITE : / 'GV_NUM1# GV_NUM2## ###.'.

ELSE.

  WRITE : / 'GV_NUM1# GV_NUM2# ####.'.

ENDIF.



WRITE : / '4#-NUM1, NUM2, NUM3 ## ### #### WRITE# ##'.



IF GV_NUM1 LT GV_NUM2.

  IF GV_NUM2 LT GV_NUM3.

    WRITE : / 'GV_NUM3#',  GV_NUM3, '## #####.'.

  ELSEIF GV_NUM2 GT GV_NUM3.

    WRITE : / 'GV_NUM2#',  GV_NUM2, '## #####.'.

  ELSE.

    WRITE : / 'GV_NUM2, GVNUM3#',  GV_NUM3, '## #####.'.

  ENDIF.

ELSEIF GV_NUM1 GT GV_NUM2.

  IF GV_NUM1 LT GV_NUM3.

    WRITE : / 'GV_NUM3#',  GV_NUM3, '## #####.'.

  ELSEIF GV_NUM1 GT GV_NUM3.

    WRITE : / 'GV_NUM1#',  GV_NUM1, '## #####.'.

  ELSE.

    WRITE : / 'GV_NUM1, GV_NUM3#',  GV_NUM3, '## #####.'.

  ENDIF.

ELSE.

  IF GV_NUM1 LT GV_NUM3.

    WRITE : / 'GV_NUM3#',  GV_NUM3, '## #####.'.

  ELSE.

    WRITE : / 'GV_NUM1, GV_NUM2#',  GV_NUM2, '## #####.'.

  ENDIF.

ENDIF.