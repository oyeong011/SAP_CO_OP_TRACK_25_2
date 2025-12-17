
*&---------------------------------------------------------------------*

*& Report ZEDR25_008

*&---------------------------------------------------------------------*

*&

*&---------------------------------------------------------------------*




REPORT ZEDR25_008.






*DATA : gs_student TYPE zedt25_001.

*DATA : gt_student LIKE TABLE OF gs_student.






" ### ### ## ##






*DATA : BEGIN OF gs_major,

*         zpernr  LIKE zedt25_001-zpernr,

*         zcode   LIKE zedt25_001-zcode,

*         zmname  LIKE zedt25_004-zmname,

*END OF gs_major.

*

*DATA : gt_major LIKE TABLE OF gs_major WITH NON-UNIQUE KEY zcode. "read ### ####### # # ##

*

*

*" #### ##### ###

*CLEAR : gs_student, gt_student, gs_major, gt_major.

*gs_student-zpernr  = '0000000001'.

*gs_student-zcode   = 'SSU-01'.

*gs_student-zkname  = '###'.

*gs_student-zename  = 'DONG'.

*gs_student-zgender = 'M'.

*gs_student-ztel    = '01011112222'.

*APPEND gs_student TO gt_student.

*

*gs_major-zpernr  = '0000000001'.

*gs_major-zcode   = 'SSU-01'.

*gs_major-zmname  = '####'.

*APPEND gs_major TO gt_major.

*

*LOOP AT gt_student INTO gs_student.

*   CLEAR : gs_major.

*   MOVE-CORRESPONDING gs_student TO gs_major.

*   " READ TABLE gt_major FROM gs_major INTO gs_major.

*   " READ TABLE gt_major WITH TABLE KEY zcode = gs_student-zcode INTO gs_major.

*

*   "## ## # # ### 2# ### ## ## ## ## # ### ##

*   READ TABLE gt_major WITH KEY zcode = gs_student-zcode zpernr = gs_student-zpernr

*

*   INTO gs_major.

*

*   IF SY-SUBRC = 0.

*     WRITE : / gs_student-zcode, gs_student-zkname, gs_major-zmname.

*   ELSE.

*     WRITE : / '#### #### #####.'.

*   ENDIF.

*ENDLOOP.



*DATA : BEGIN OF gs_major,

*         zpernr  LIKE zedt25_001-zpernr,

*         zcode   LIKE zedt25_001-zcode,

*         zkname LIKE zedt25_001-zkname,

*         zmname  LIKE zedt25_004-zmname,

*END OF gs_major.

*

*DATA : gt_major LIKE TABLE OF gs_major.

*

*

*" #### ##### ###

*CLEAR : gs_student, gt_student, gs_major, gt_major.

*gs_student-zpernr  = '0000000001'.

*gs_student-zcode   = 'SSU-01'.

*gs_student-zkname  = '###'.

*gs_student-zename  = 'DONG'.

*gs_student-zgender = 'M'.

*gs_student-ztel    = '01011112222'.

*APPEND gs_student TO gt_student.

*

*gs_major-zpernr  = '0000000001'.

*gs_major-zcode   = 'SSU-01'.

*gs_major-zmname  = '####'.

*APPEND gs_major TO gt_major.

*

*LOOP AT gt_student INTO gs_student.

*   CLEAR : gs_major.

*   MOVE-CORRESPONDING gs_student TO gs_major.

**   READ TABLE gt_major WITH TABLE KEY zcode = gs_student-zcode INTO gs_major

**   TRANSPORTING zmname.

*

*   READ TABLE gt_major INTO gs_major INDEX SY-TABIX.

*

*   IF SY-SUBRC = 0.

*     gs_student-zkanme = gs_major-zkname.

*     WRITE : / gs_student-zcode, gs_student-zkname, gs_major-zmname.

*   ELSE.

*     WRITE : / '#### #### #####.'.

*   ENDIF.

*ENDLOOP.






" ####




*DATA : LV_NUM type I.

*DATA : LV_SUM type I.

*

*LV_NUM = 5.

*

*DO LV_NUM TIMES.

*

*  IF SY-INDEX = '3'.

*    " EXIT. ### ###

*    " STOP. " ## #### ##

*    "CONTINUE. "## ## # #### ####

*    CHECK SY-INDEX = '3'. " check ## ## ## #### ### ###

*  ENDIF.

*

*  ADD SY-INDEX TO LV_SUM.

*  WRITE :/ SY-INDEX.

*ENDDO.

*

*WRITE :/ 'INDEX ##', LV_SUM.






DATA : gv_num TYPE I.

DATA : gv_check TYPE C.



gv_num = 5.



WHILE gv_num = 5.

  gv_check = 'X'.

ENDWHILE.



IF gv_check = 'X'.

  write :/ '#######.'.

ENDIF.