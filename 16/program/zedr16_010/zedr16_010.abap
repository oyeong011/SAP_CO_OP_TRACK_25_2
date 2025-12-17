
*&---------------------------------------------------------------------*

*& Report ZEDR16_010

*&---------------------------------------------------------------------*

*&

*&---------------------------------------------------------------------*




REPORT zedr16_010.



" p.4






*DATA : gs_student TYPE zedt16_001.

*DATA : gt_student LIKE TABLE OF gs_student.

*

*CLEAR : gs_student, gt_student.

*

*gs_student-zpernr = '0000000001'.

*gs_student-zcode = 'SSU-01'.

*gs_student-zkname = '###'.

*gs_student-zename = 'DONG'.

*gs_student-zgender = 'M'.

*gs_student-ztel = '01011112222'.

*APPEND gs_student TO gt_student.

*

*CLEAR : gs_student.

*

*gs_student-zpernr = '0000000002'.

*gs_student-zcode = 'SSU-02'.

*gs_student-zkname = '###'.

*gs_student-zename = 'HOON'.

*gs_student-zgender = 'M'.

*gs_student-ztel = '01022223333'.

*APPEND gs_student TO gt_student.

*

*CLEAR : gs_student.

*

*gs_student-zpernr = '0000000003'.

*gs_student-zcode = 'SSU-03'.

*gs_student-zkname = '###'.

*gs_student-zename = 'SON'.

*gs_student-zgender = 'F'.

*gs_student-ztel = '01033334444'.

*APPEND gs_student TO gt_student.

*

*CLEAR gs_student.

*

*BREAK-POINT.

*

*LOOP AT gt_student INTO gs_student.

*  IF gs_student-zgender NE 'M'.

*    DELETE TABLE gt_student FROM gs_student.

*

*    IF sy-subrc = 0.

*    ELSE.

*      WRITE :/ '####'.

*    ENDIF.

*  ELSE.

*    WRITE :/ gs_student-zcode, gs_student-zkname, gs_student-zgender.

*  ENDIF.

*ENDLOOP.

*

*BREAK-POINT.






" p.22




*

*DATA : gs_student TYPE zedt16_001.

*DATA : gt_student LIKE TABLE OF gs_student WITH NON-UNIQUE KEY zgender.

*

*CLEAR : gs_student, gt_student.

*

*gs_student-zpernr = '0000000001'.

*gs_student-zcode = 'SSU-01'.

*gs_student-zkname = '###'.

*gs_student-zename = 'DONG'.

*gs_student-zgender = 'M'.

*gs_student-ztel = '01011112222'.

*APPEND gs_student TO gt_student.

*

*CLEAR : gs_student.

*

*gs_student-zpernr = '0000000002'.

*gs_student-zcode = 'SSU-02'.

*gs_student-zkname = '###'.

*gs_student-zename = 'HOON'.

*gs_student-zgender = 'M'.

*gs_student-ztel = '01022223333'.

*APPEND gs_student TO gt_student.

*

*CLEAR : gs_student.

*

*gs_student-zpernr = '0000000003'.

*gs_student-zcode = 'SSU-03'.

*gs_student-zkname = '###'.

*gs_student-zename = 'SON'.

*gs_student-zgender = 'F'.

*gs_student-ztel = '01033334444'.

*APPEND gs_student TO gt_student.

*

*DELETE TABLE gt_student WITH TABLE KEY zgender = 'F'.

*

*IF sy-subrc = 0.

*  LOOP AT gt_student INTO gs_student.

*    WRITE :/ gs_student-zcode, gs_student-zkname, gs_student-zgender.

*  ENDLOOP.

*ENDIF.






"p.26






*

*DATA : gs_student TYPE zedt16_001.

*DATA : gt_student like table of gs_student.

*

*CLEAR : gs_student, gt_student.

*

*gs_student-zpernr = '0000000001'.

*gs_student-zcode = 'SSU-01'.

*gs_student-zkname = '###'.

*gs_student-zename = 'DONG'.

*gs_student-zgender = 'M'.

*gs_student-ztel = '01011112222'.

*APPEND gs_student TO gt_student.

*

*CLEAR : gs_student.

*

*gs_student-zpernr = '0000000002'.

*gs_student-zcode = 'SSU-02'.

*gs_student-zkname = '###'.

*gs_student-zename = 'HOON'.

*gs_student-zgender = 'M'.

*gs_student-ztel = '01022223333'.

*APPEND gs_student TO gt_student.

*

*CLEAR : gs_student.

*

*gs_student-zpernr = '0000000003'.

*gs_student-zcode = 'SSU-03'.

*gs_student-zkname = '###'.

*gs_student-zename = 'SON'.

*gs_student-zgender = 'F'.

*gs_student-ztel = '01033334444'.

*APPEND gs_student TO gt_student.

*

*DELETE gt_student where zgender = 'F'.

*

*IF sy-subrc = 0.

*  LOOP AT gt_student INTO gs_student.

*    WRITE :/ gs_student-zcode, gs_student-zkname, gs_student-zgender.

*  ENDLOOP.

*ENDIF.








" p.30






*DATA : gs_student TYPE zedt16_001.

*DATA : gt_student LIKE TABLE OF gs_student.

*

*CLEAR : gs_student, gt_student.

*

*gs_student-zpernr = '0000000001'.

*gs_student-zcode = 'SSU-01'.

*gs_student-zkname = '###'.

*gs_student-zename = 'DONG'.

*gs_student-zgender = 'M'.

*gs_student-ztel = '01011112222'.

*APPEND gs_student TO gt_student.

*

*CLEAR : gs_student.

*

*gs_student-zpernr = '0000000002'.

*gs_student-zcode = 'SSU-02'.

*gs_student-zkname = '###'.

*gs_student-zename = 'HOON'.

*gs_student-zgender = 'M'.

*gs_student-ztel = '01022223333'.

*APPEND gs_student TO gt_student.

*

*CLEAR : gs_student.

*

*gs_student-zpernr = '0000000003'.

*gs_student-zcode = 'SSU-03'.

*gs_student-zkname = '###'.

*gs_student-zename = 'SON'.

*gs_student-zgender = 'F'.

*gs_student-ztel = '01033334444'.

*APPEND gs_student TO gt_student.

*

*DELETE gt_student TO 2.

*

*IF sy-subrc = 0.

*  LOOP AT gt_student INTO gs_student.

*    WRITE :/ gs_student-zcode, gs_student-zkname, gs_student-zgender.

*  ENDLOOP.

*ENDIF.








" p. 35



DATA : gs_student TYPE zedt16_001.

DATA : gt_student LIKE TABLE OF gs_student.



CLEAR : gs_student, gt_student.



gs_student-zpernr = '0000000001'.

gs_student-zcode = 'SSU-01'.

gs_student-zkname = '###'.

gs_student-zename = 'DONG'.

gs_student-zgender = 'M'.

gs_student-ztel = '01011112222'.

APPEND gs_student TO gt_student.



CLEAR : gs_student.



gs_student-zpernr = '0000000001'.

gs_student-zcode = 'SSU-01'.

gs_student-zkname = '###'.

gs_student-zename = 'DONG'.

gs_student-zgender = 'M'.

gs_student-ztel = '01011112223'.

APPEND gs_student TO gt_student.



gs_student-zpernr = '0000000002'.

gs_student-zcode = 'SSU-02'.

gs_student-zkname = '###'.

gs_student-zename = 'HOON'.

gs_student-zgender = 'M'.

gs_student-ztel = '01022223333'.

APPEND gs_student TO gt_student.



SORT gt_student.



DELETE ADJACENT DUPLICATES FROM gt_student COMPARING zcode.



IF sy-subrc = 0.

  LOOP AT gt_student INTO gs_student.

    WRITE :/ gs_student-zcode, gs_student-zkname, gs_student-zgender.

  ENDLOOP.

ENDIF.