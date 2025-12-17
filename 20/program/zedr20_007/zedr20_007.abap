
*&---------------------------------------------------------------------*

*& Report ZEDR20_007

*&---------------------------------------------------------------------*

*&

*&---------------------------------------------------------------------*




REPORT ZEDR20_007.






*DATA: BEGIN OF GS_STUDENT,    " ### ##

*  ZPERNR TYPE ZEDT20_001-ZPERNR,    " ####

*  ZCODE TYPE ZEDT20_001-ZCODE,    " ####

*  ZKNAME TYPE ZEDT20_001-ZKNAME,    " ##

*  ZENAME TYPE ZEDT20_001-ZENAME,    " ####

*  ZGENDER TYPE ZEDT20_001-ZGENDER,    " ##

*  ZGNAME TYPE C LENGTH 4,   " ## ##

*  ZTEL TYPE ZEDT20_001-ZTEL,    " ####

*  END OF GS_STUDENT.

*

*DATA: GT_STUDENT LIKE TABLE OF GS_STUDENT.    " ### ### ##

*

*CLEAR: GS_STUDENT.

*

*GS_STUDENT-ZCODE = 'SSU-01'.

*GS_STUDENT-ZPERNR = '0000000001'.

*GS_STUDENT-ZKNAME = '###'.

*GS_STUDENT-ZENAME = 'DONG'.

*GS_STUDENT-ZGENDER = 'M'."'F'."'M'.

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

*CLEAR: GS_STUDENT.

*BREAK-POINT.



*DATA: GV_NUM1 TYPE I VALUE 100,

*      GV_NUM2 TYPE I VALUE 120,

*      GV_NUM3 TYPE I VALUE 110,

*      GV_STATE TYPE STRING VALUE '#-IF## WRITE# ##'.

*

*WRITE: '**1', GV_STATE.

*WRITE:/ GV_NUM1.

*WRITE:/ GV_NUM2.

*WRITE:/ 'GV_NUM1# GV_NUM2'.

*IF GV_NUM1 LT GV_NUM2.

*  WRITE: '## ####.'.

*ELSEIF GV_NUM1 GT GV_NUM2.

*  WRITE: '## ###.'.

*ELSE.

*  WRITE: '# ####.'.

*ENDIF.

*

*ULINE.

*

*WRITE:/ '**2', GV_STATE.

*WRITE:/ GV_NUM1.

*WRITE:/ GV_NUM2.

*WRITE:/ GV_NUM3.

*WRITE:/ 'GV_NUM1# '.

*IF ( GV_NUM1 LT GV_NUM2 ) AND ( GV_NUM1 LT GV_NUM3 ).

*  WRITE: 'GV_NUM2, GV_NUM3## ####.'.

*ELSEIF ( GV_NUM1 GT GV_NUM2 ) AND ( GV_NUM1 GT GV_NUM3 ).

*  WRITE: 'GV_NUM2, GV_NUM3## ###'.

*ELSEIF ( GV_NUM1 EQ GV_NUM2 ) AND ( GV_NUM1 EQ GV_NUM3 ).

*  WRITE: 'GV_NUM2, GV_NUM3# ####.'.

*ELSE.

*  WRITE: 'GV_NUM2'.

*  IF GV_NUM1 LT GV_NUM2.

*    WRITE: '## ## '.

*  ELSEIF GV_NUM1 GT GV_NUM2.

*    WRITE: '## ## '.

*  ELSE.

*    WRITE: '# ## '.

*  ENDIF.

*

*  WRITE: 'GV_NUM3'.

*  IF GV_NUM1 LT GV_NUM3.

*    WRITE: '## ####.'.

*  ELSEIF GV_NUM1 GT GV_NUM3.

*    WRITE: '## ###.'.

*  ELSE.

*    WRITE: '# ####.'.

*  ENDIF.

*ENDIF.

*

*ULINE.

*

*WRITE:/ '**3#-ELSE## WRITE###'.

*WRITE:/ GV_NUM1.

*WRITE:/ GV_NUM2.

*IF GV_NUM1 LT GV_NUM2.

*  WRITE:/ 'GV_NUM2# GV_NUM1## ###.'.

*ELSEIF GV_NUM1 GT GV_NUM2.

*  WRITE:/ 'GV_NUM1# GV_NUM2## ###.'.

*ELSE.

*  WRITE:/ 'GV_NUM1# GV_NUM2# ####.'.

*ENDIF.

*

*ULINE.

*

*WRITE:/ '**4#-NUM1, NUM2, NUM3##### #### WRITE# ##'.

*IF ( GV_NUM1 GT GV_NUM2 ) AND ( GV_NUM1 GT GV_NUM3 ).

*  WRITE:/ 'GV_NUM1# ', GV_NUM1.

*ELSEIF ( GV_NUM2 GT GV_NUM1 ) AND ( GV_NUM2 GT GV_NUM3 ).

*  WRITE:/ 'GV_NUM2# ', GV_NUM2.

*ELSEIF ( GV_NUM3 GT GV_NUM1 ) AND ( GV_NUM3 GT GV_NUM2 ).

*  WRITE:/ 'GV_NUM3# ', GV_NUM3.

*ENDIF.

*

*WRITE: ' ## #####.'.