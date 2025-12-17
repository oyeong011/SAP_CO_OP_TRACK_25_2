
*&---------------------------------------------------------------------*

*& Report ZEDR16_012

*&---------------------------------------------------------------------*

*&

*&---------------------------------------------------------------------*




REPORT zedr16_012.



" p.4






*DATA : gs_student TYPE zedt16_001.

*DATA : gt_student LIKE TABLE OF gs_student.

*

*DATA : BEGIN OF gs_major,

*         zcode  LIKE zedt16_001-zcode,

*         zpernr LIKE zedt16_001-zpernr,

*         zmname LIKE zedt16_004-zmname,

*       END OF gs_major.

*DATA : gt_major LIKE TABLE OF gs_major WITH NON-UNIQUE KEY zcode.

*

*CLEAR : gs_student, gt_student, gs_major, gt_major.

*gs_student-zpernr = '0000000001'.

*gs_student-zcode = 'SSU-01'.

*gs_student-zkname = '###'.

*gs_student-zename = 'DONG'.

*gs_student-zgender = 'M'.

*gs_student-ztel = '01011112222'.

*APPEND gs_student TO gt_student.

*

*gs_major-zpernr = '0000000001'.

*gs_major-zcode = 'SSU-01'.

*gs_major-zmname = '####'.

*APPEND gs_major TO gt_major.








" p.6






*LOOP AT gt_student INTO gs_student.

*  CLEAR : gs_major.

*  MOVE-CORRESPONDING gs_student TO gs_major.

*  READ TABLE gt_major FROM gs_major INTO gs_major.

*

*  IF sy-subrc = 0.

*    WRITE :/ gs_student-zcode, gs_student-zkname, gs_major-zmname.

*  ELSE.

*    WRITE :/ '#### #### #####.'.

*  ENDIF.

*ENDLOOP.








" p. 13




*LOOP AT gt_student INTO gs_student.

*  CLEAR : gs_major.

*  READ TABLE gt_major WITH TABLE KEY zcode = gs_student-zcode

*  INTO gs_major.

*

*  IF sy-subrc = 0.

*    WRITE :/ gs_student-zcode, gs_student-zkname, gs_major-zmname.

*  ELSE.

*    WRITE :/ '#### #### #####.'.

*  ENDIF.

*ENDLOOP.








" p. 15

DATA : gs_student TYPE zedt16_001.

DATA : gt_student LIKE TABLE OF gs_student.



DATA : BEGIN OF gs_major,

         zcode  LIKE zedt16_001-zcode,

         zpernr LIKE zedt16_001-zpernr,

         zmname LIKE zedt16_004-zmname,

       END OF gs_major.

DATA : gt_major LIKE TABLE OF gs_major.



CLEAR : gs_student, gt_student, gs_major, gt_major.

gs_student-zpernr = '0000000001'.

gs_student-zcode = 'SSU-01'.

gs_student-zkname = '###'.

gs_student-zename = 'DONG'.

gs_student-zgender = 'M'.

gs_student-ztel = '01011112222'.

APPEND gs_student TO gt_student.



gs_major-zpernr = '0000000001'.

gs_major-zcode = 'SSU-01'.

gs_major-zmname = '####'.

APPEND gs_major TO gt_major.





" p. 16






*LOOP AT gt_student INTO gs_student.

*  CLEAR : gs_major.

*  READ TABLE gt_major WITH KEY zcode = gs_student-zcode

*  zpernr = gs_student-zpernr

*  INTO gs_major.

*

*

*  IF sy-subrc = 0.

*    WRITE :/ gs_student-zcode, gs_student-zkname, gs_major-zmname.

*  ELSE.

*    WRITE :/ '#### #### #####.'.

*  ENDIF.

*ENDLOOP.








" p. 19






*LOOP AT gt_student INTO gs_student.

*  CLEAR : gs_major.

*  MOVE-CORRESPONDING gs_student TO gs_major.

*

*  READ TABLE gt_major WITH KEY zcode = gs_student-zcode INTO gs_major

*  COMPARING zcode.

*

*

*  IF sy-subrc = 0.

*    WRITE :/ gs_student-zcode, gs_student-zkname, gs_major-zmname.

*  ELSE.

*    WRITE :/ '#### #### #####.'.

*  ENDIF.

*ENDLOOP.








" p.33




*LOOP AT gt_student INTO gs_student.

*  CLEAR : gs_major.

*  MOVE-CORRESPONDING gs_student TO gs_major.

*

*  READ TABLE gt_major INTO gs_major INDEX sy-tabix.

*

*

*

*  IF sy-subrc = 0.

*    WRITE :/ gs_student-zcode, gs_student-zkname, gs_major-zmname.

*  ELSE.

*    WRITE :/ '#### #### #####.'.

*  ENDIF.

*ENDLOOP.








" p. 37

LOOP AT gt_student INTO gs_student.

  CLEAR : gs_major.

  MOVE-CORRESPONDING gs_student TO gs_major.



  READ TABLE gt_major with key zcode = gs_student-zcode into gs_major BINARY SEARCH.







  IF sy-subrc = 0.

    WRITE :/ gs_student-zcode, gs_student-zkname, gs_major-zmname.

  ELSE.

    WRITE :/ '#### #### #####.'.

  ENDIF.



ENDLOOP.