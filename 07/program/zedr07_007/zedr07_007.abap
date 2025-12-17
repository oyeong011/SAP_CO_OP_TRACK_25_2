
*&---------------------------------------------------------------------*

*& Report ZEDR07_007

*&---------------------------------------------------------------------*

*&

*&---------------------------------------------------------------------*




REPORT ZEDR07_007.






*DATA : gs_student TYPE zedt07_001.

*DATA : gt_student LIKE TABLE OF gs_student.

*

*DATA : BEGIN OF gs_major,

*  zcode LIKE zedt07_001-zcode,

*  zpernr LIKE zedt07_001-zpernr,

*  zmname LIKE zedt07_001-zmname,

*  END OF gs_major.

*

*  DATA : gt_major LIKE TABLE OF gs_major WITH NON-UNIQUE KEY zcode.

*

*  CLEAR : gs_student, gt_student, gs_major, gt_major.

*  gs_student-zpernr = '0000000001'.

*  gs_student-zcode = 'SSU-01'.

*  gs_student-zkname = '###'.

*  gs_student-zename = 'DONG'.

*  gs_student-zgender = 'M'.

*  gs_student-ztel = '01011112222'.

*  APPEND gs_student TO gt_student.

*

*  gs_major-zpernr = '0000000001'.

*  gs_major-zcode = 'SSU-01'.

*  gs_major-zmname = '####'.

*  APPEND gs_major TO gt_major.

*

*  BREAK-POINT.



************************************************************************



*DATA : gs_student TYPE zedt07_001. "## read ##

*DATA : gt_student LIKE TABLE OF gs_student.

*

*DATA : BEGIN OF gs_major,

*  zcode LIKE zedt07_001-zcode,

*  zpernr LIKE zedt07_001-zpernr,

*  zmname LIKE zedt07_001-zmname,

*  END OF gs_major.

*

*  DATA : gt_major LIKE TABLE OF gs_major WITH NON-UNIQUE KEY zcode.

*

*  CLEAR : gs_student, gt_student, gs_major, gt_major.

*  gs_student-zpernr = '0000000001'.

*  gs_student-zcode = 'SSU-01'.

*  gs_student-zkname = '###'.

*  gs_student-zename = 'DONG'.

*  gs_student-zgender = 'M'.

*  gs_student-ztel = '01011112222'.

*  APPEND gs_student TO gt_student.

*

*  gs_major-zpernr = '0000000001'.

*  gs_major-zcode = 'SSU-01'.

*  gs_major-zmname = '####'.

*  APPEND gs_major TO gt_major.

*

*  LOOP AT gt_student INTO gs_student.

*    CLEAR : gs_major.

*    MOVE-CORRESPONDING gs_student TO gs_major.

*    READ TABLE gt_major FROM gs_major INTO gs_major.

*

*    IF sy-subrc = 0.

*      WRITE :/ gs_student-zcode, gs_student-zkname, gs_major-zmname.

*    ELSE.

*      WRITE :/ '#### #### #####.'.

*    ENDIF.

*

*  ENDLOOP.



************************************************************************



*DATA : gs_student TYPE zedt07_001. "table key ##

*DATA : gt_student LIKE TABLE OF gs_student.

*

*DATA : BEGIN OF gs_major,

*  zcode LIKE zedt07_001-zcode,

*  zpernr LIKE zedt07_001-zpernr,

*  zmname LIKE zedt07_004-zmname,

*  END OF gs_major.

*

*  DATA : gt_major LIKE TABLE OF gs_major WITH NON-UNIQUE KEY zcode.

*

*  CLEAR : gs_student, gt_student, gs_major, gt_major.

*  gs_student-zpernr = '0000000001'.

*  gs_student-zcode = 'SSU-01'.

*  gs_student-zkname = '###'.

*  gs_student-zename = 'DONG'.

*  gs_student-zgender = 'M'.

*  gs_student-ztel = '01011112222'.

*  APPEND gs_student TO gt_student.

*

*  gs_major-zpernr = '0000000001'.

*  gs_major-zcode = 'SSU-01'.

*  gs_major-zmname = '####'.

*  APPEND gs_major TO gt_major.

*

* LOOP AT gt_student INTO gs_student.

*    CLEAR : gs_major.

*    READ TABLE gt_major WITH TABLE KEY zcode = gs_student-zcode INTO gs_major. "## ### ##### # ## ## ### ##

*

*    IF sy-subrc = 0.

*      WRITE :/ gs_student-zcode, gs_student-zkname, gs_major-zmname.

*    ELSE.

*      WRITE :/ '#### #### #####.'.

*    ENDIF.

*

*  ENDLOOP.



************************************************************************



*DATA : gs_student TYPE zedt07_001. "work area ##

*DATA : gt_student LIKE TABLE OF gs_student.

*

*DATA : BEGIN OF gs_major,

*  zcode LIKE zedt07_001-zcode,

*  zpernr LIKE zedt07_001-zpernr,

*  zmname LIKE zedt07_004-zmname,

*  END OF gs_major.

*

*  DATA : gt_major LIKE TABLE OF gs_major.

*

*  CLEAR : gs_student, gt_student, gs_major, gt_major.

*  gs_student-zpernr = '0000000001'.

*  gs_student-zcode = 'SSU-01'.

*  gs_student-zkname = '###'.

*  gs_student-zename = 'DONG'.

*  gs_student-zgender = 'M'.

*  gs_student-ztel = '01011112222'.

*  APPEND gs_student TO gt_student.

*

*  gs_major-zpernr = '0000000001'.

*  gs_major-zcode = 'SSU-01'.

*  gs_major-zmname = '####'.

*  APPEND gs_major TO gt_major.

*

* LOOP AT gt_student INTO gs_student.

*    CLEAR : gs_major.

*    READ TABLE gt_major WITH KEY zcode = gs_student-zcode INTO gs_major. "# ## ## # ### ##

*

**

**    READ TABLE gt_major WITH KEY zcode = gs_student-zcode

**                                 zpernr = gs_student-zpernr "##### ## ## 2# ### ## ## ## ## # ### ##.

**                    INTO gs_major.

*    IF sy-subrc = 0.

*      WRITE :/ gs_student-zcode, gs_student-zkname, gs_major-zmname.

*    ELSE.

*      WRITE :/ '#### #### #####.'.

*    ENDIF.

*

*  ENDLOOP.



************************************************************************

*

*DATA : gs_student TYPE zedt07_001. "comparing ##

*DATA : gt_student LIKE TABLE OF gs_student.

*

*DATA : BEGIN OF gs_major,

*  zcode LIKE zedt07_001-zcode,

*  zpernr LIKE zedt07_001-zpernr,

*  zmname LIKE zedt07_004-zmname,

*  END OF gs_major.

*

*  DATA : gt_major LIKE TABLE OF gs_major.

*

*  CLEAR : gs_student, gt_student, gs_major, gt_major.

*  gs_student-zpernr = '0000000001'.

*  gs_student-zcode = 'SSU-01'.

*  gs_student-zkname = '###'.

*  gs_student-zename = 'DONG'.

*  gs_student-zgender = 'M'.

*  gs_student-ztel = '01011112222'.

*  APPEND gs_student TO gt_student.

*

*  gs_major-zpernr = '0000000001'.

*  gs_major-zcode = 'SSU-01'.

*  gs_major-zmname = '####'.

*  APPEND gs_major TO gt_major.

*

* LOOP AT gt_student INTO gs_student.

*    CLEAR : gs_major.

*    MOVE-CORRESPONDING gs_student to gs_major. "### gs_major# ## #

*

*    READ TABLE gt_major WITH KEY zcode = gs_student-zcode INTO gs_major COMPARING zcode. "# ## gs_major# ## #

*

*    IF sy-subrc = 0. "gs_major# gt_major# ### # # # ##

*      WRITE :/ gs_student-zcode, gs_student-zkname, gs_major-zmname.

*    ELSE.

*      WRITE :/ '#### #### #####.'.

*    ENDIF.

*

*  ENDLOOP.



************************************************************************



*DATA : gs_student TYPE zedt07_001. "transporting ##

*DATA : gt_student LIKE TABLE OF gs_student.

*

*DATA : BEGIN OF gs_major,

*  zcode LIKE zedt07_001-zcode,

*  zpernr LIKE zedt07_001-zpernr,

*  zmname LIKE zedt07_004-zmname,

*  zkname LIKE zedt07_001-zkname,

*  END OF gs_major.

*

*  DATA : gt_major LIKE TABLE OF gs_major.

*

*  CLEAR : gs_student, gt_student, gs_major, gt_major.

*  gs_student-zpernr = '0000000001'.

*  gs_student-zcode = 'SSU-01'.

*  gs_student-zkname = '###'.

*  gs_student-zename = 'DONG'.

*  gs_student-zgender = 'M'.

*  gs_student-ztel = '01011112222'.

*  APPEND gs_student TO gt_student.

*

*  gs_major-zpernr = '0000000001'.

*  gs_major-zcode = 'SSU-01'.

*  gs_major-zmname = '####'.

*  APPEND gs_major TO gt_major.

*

* LOOP AT gt_student INTO gs_student.

*    CLEAR : gs_major.

*    MOVE-CORRESPONDING gs_student to gs_major.

*

*    READ TABLE gt_major WITH KEY zcode = gs_student-zcode INTO gs_major TRANSPORTING zmname. "gt_major# zkname#### ### read ## -> ##### #### ### #### # ##.

*

*    IF sy-subrc = 0.

*      gs_student-zkname = gs_major-zkname.

*      WRITE :/ gs_student-zcode, gs_student-zkname, gs_major-zmname.

*    ELSE.

*      WRITE :/ '#### #### #####.'.

*    ENDIF.

*

*  ENDLOOP.



************************************************************************



*DATA : gs_student TYPE zedt07_001. "### ## sy-tabix.

*DATA : gt_student LIKE TABLE OF gs_student.

*

*DATA : BEGIN OF gs_major,

*  zcode LIKE zedt07_001-zcode,

*  zpernr LIKE zedt07_001-zpernr,

*  zmname LIKE zedt07_004-zmname,

*  zkname LIKE zedt07_001-zkname,

*  END OF gs_major.

*

*  DATA : gt_major LIKE TABLE OF gs_major.

*

*  CLEAR : gs_student, gt_student, gs_major, gt_major.

*  gs_student-zpernr = '0000000001'.

*  gs_student-zcode = 'SSU-01'.

*  gs_student-zkname = '###'.

*  gs_student-zename = 'DONG'.

*  gs_student-zgender = 'M'.

*  gs_student-ztel = '01011112222'.

*  APPEND gs_student TO gt_student.

*

*  gs_major-zpernr = '0000000001'.

*  gs_major-zcode = 'SSU-01'.

*  gs_major-zmname = '####'.

*  APPEND gs_major TO gt_major.

*

* LOOP AT gt_student INTO gs_student.

*    CLEAR : gs_major.

*    MOVE-CORRESPONDING gs_student to gs_major.

*

*    READ TABLE gt_major INTO gs_major INDEX sy-tabix.

*

*    IF sy-subrc = 0.

*      gs_student-zkname = gs_major-zkname.

*      WRITE :/ gs_student-zcode, gs_student-zkname, gs_major-zmname.

*    ELSE.

*      WRITE :/ '#### #### #####.'.

*    ENDIF.

*

*  ENDLOOP.

*

*  BREAK-POINT.



*************************************************************



*DATA : gs_student TYPE zedt07_001. "read binary search

*DATA : gt_student LIKE TABLE OF gs_student.

*

*DATA : BEGIN OF gs_major,

*  zcode LIKE zedt07_001-zcode,

*  zpernr LIKE zedt07_001-zpernr,

*  zmname LIKE zedt07_004-zmname,

*  zkname LIKE zedt07_001-zkname,

*  END OF gs_major.

*

*  DATA : gt_major LIKE TABLE OF gs_major.

*

*  CLEAR : gs_student, gt_student, gs_major, gt_major.

*  gs_student-zpernr = '0000000001'.

*  gs_student-zcode = 'SSU-01'.

*  gs_student-zkname = '###'.

*  gs_student-zename = 'DONG'.

*  gs_student-zgender = 'M'.

*  gs_student-ztel = '01011112222'.

*  APPEND gs_student TO gt_student.

*

*  gs_major-zpernr = '0000000001'.

*  gs_major-zcode = 'SSU-01'.

*  gs_major-zmname = '####'.

*  APPEND gs_major TO gt_major.

*

*  SORT gt_student by zcode.

*  SORT gt_major by zcode.

*

* LOOP AT gt_student INTO gs_student.

*    CLEAR : gs_major.

*    MOVE-CORRESPONDING gs_student to gs_major.

*

*    READ TABLE gt_major WITH KEY zcode = gs_student-zcode INTO gs_major BINARY SEARCH. "#### ## # ### ### ### ##.

*

*    IF sy-subrc = 0.

*      gs_student-zkname = gs_major-zkname.

*      WRITE :/ gs_student-zcode, gs_student-zkname, gs_major-zmname.

*    ELSE.

*      WRITE :/ '#### #### #####.'.

*    ENDIF.

*

*  ENDLOOP.

*

*  BREAK-POINT.



*************************************************************



*"DO-ENDDO

*DATA : lv_num TYPE i.

*DATA : lv_sum TYPE i.

*

*lv_num = 5.

*

*DO lv_num TIMES.

*

**  IF sy-index = '3'.

**    EXIT. "EXIT## ## ### ##.

**  ENDIF.

*

**  IF sy-index = '3'.

**    STOP. "STOP## ## #### ##.

**  ENDIF.

*

**  IF sy-index = '3'.

**    CONTINUE. "CONTINUE## ## # ### #### ####.

**  ENDIF.

*

**  CHECK sy-index = '3'. "CHECK ## ###### ## #### # #### ##.

*

*  ADD sy-index TO lv_sum.

*  WRITE :/ sy-index.

*

*ENDDO.

*

*WRITE :/ 'index##: ', lv_sum.



*************************************************************






"WHILE-ENDWHILE



DATA : gv_num TYPE i.

DATA : gv_check TYPE c.



gv_num = 5.



WHILE gv_num = 5.

  gv_check = 'X'.

ENDWHILE.



IF gv_check = 'X'.

  WRITE :/ '#######.'.

ENDIF.