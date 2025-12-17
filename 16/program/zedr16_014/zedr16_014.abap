
*&---------------------------------------------------------------------*

*& Report ZEDR16_014

*&---------------------------------------------------------------------*

*&

*&---------------------------------------------------------------------*




REPORT zedr16_014.



" p.4






*DATA : BEGIN OF gs_student.

*    INCLUDE TYPE zedt16_001.

*DATA: END OF gs_student.

*DATA : gt_student LIKE TABLE OF gs_student.

*

*gs_student-mandt = sy-mandt.

*gs_student-zcode = 'SSU-13'.

*gs_student-zpernr = '0000000011'.

*gs_student-zkname = '###'.

*gs_student-zename = 'DO'.

*gs_student-zgender = 'F'.

*gs_student-ztel = '01000001111'.

*

*INSERT INTO zedt16_001 VALUES gs_student.

*

*IF sy-subrc = 0.

*  WRITE :/ '##'.

*ELSE.

*  WRITE :/ '##'.

*ENDIF.






" p. 7




*DATA : BEGIN OF gs_student.

*    INCLUDE TYPE zedt16_001.

*DATA: END OF gs_student.

*DATA : gt_student LIKE TABLE OF gs_student.

*

*CLEAR : gs_student, gt_student.

*

*gs_student-zcode = 'SSU-19'.

*gs_student-zpernr = '0000000019'.

*gs_student-zkname = '###'.

*gs_student-zename = 'DO'.

*gs_student-zgender = 'F'.

*gs_student-ztel = '01000001111'.

*APPEND gs_student TO gt_student.

*

*CLEAR : gs_student.

*

*gs_student-zcode = 'SSU-20'.

*gs_student-zpernr = '0000000020'.

*gs_student-zkname = '###'.

*gs_student-zename = 'DO'.

*gs_student-zgender = 'F'.

*gs_student-ztel = '01000001111'.

*APPEND gs_student TO gt_student.

*

*INSERT INTO zedt16_001 VALUES gs_student.

*

*IF sy-subrc = 0.

*  WRITE :/ '##'.

*ELSE.

*  WRITE :/ '##'.

*ENDIF.








" p.13






*DATA : BEGIN OF gs_student.

*    INCLUDE TYPE zedt16_001.

*DATA: END OF gs_student.

*DATA : gt_student LIKE TABLE OF gs_student.

*

*gs_student-zcode = 'SSU-12'.

*gs_student-zpernr = '0000000012'.

*gs_student-zkname = '###'.

*gs_student-zename = 'JAE'.

*gs_student-zgender = 'M'.

*gs_student-ztel = '01000002222'.

*

*

*UPDATE zedt16_001 FROM gs_student.

*

*IF sy-subrc = 0.

*  WRITE :/ '##### ##'.

*ENDIF.








" p.16






*DATA : BEGIN OF gs_student.

*    INCLUDE TYPE zedt16_001.

*DATA: END OF gs_student.

*DATA : gt_student LIKE TABLE OF gs_student.

*

*CLEAR : gs_student, gt_student.

*

*gs_student-zcode = 'SSU-11'.

*gs_student-zpernr = '0000000011'.

*gs_student-zkname = '##'.

*gs_student-zename = 'YOON'.

*gs_student-zgender = 'F'.

*gs_student-ztel = '01000002222'.

*APPEND gs_student TO gt_student.

*

*CLEAR : gs_student.

*gs_student-zcode = 'SSU-12'.

*gs_student-zpernr = '0000000012'.

*gs_student-zkname = '###'.

*gs_student-zename = 'HOON'.

*gs_student-zgender = 'M'.

*gs_student-ztel = '01000002222'.

*APPEND gs_student TO gt_student.

*

*UPDATE zedt16_001 FROM TABLE gt_student.

*

*IF sy-subrc = 0.

*  WRITE :/ '##### ##'.

*ENDIF.








" P.19




*DATA : BEGIN OF gs_student.

*    INCLUDE TYPE zedt16_001.

*DATA: END OF gs_student.

*DATA : gt_student LIKE TABLE OF gs_student.

*

*UPDATE zedt16_001 SET zename = 'JUNG'

*WHERE zcode = 'SSU-03'.

*

*IF sy-subrc = 0.

*  WRITE :/ '##### ##'.

*ENDIF.








" P.23




*DATA : BEGIN OF gs_student.

*    INCLUDE TYPE zedt16_001.

*DATA: END OF gs_student.

*DATA : gt_student LIKE TABLE OF gs_student.

*

*gs_student-zcode = 'SSU-14'.

*gs_student-zpernr = '0000000014'.

*

*DELETE zedt16_001 FROM gs_student.

*

*IF sy-subrc = 0.

*  WRITE :/ '##### ##'.

*ENDIF.








" P. 25




*DATA : BEGIN OF gs_student.

*    INCLUDE TYPE zedt16_001.

*DATA: END OF gs_student.

*DATA : gt_student LIKE TABLE OF gs_student.

*

*DELETE FROM zedt16_001 WHERE ztel = '01000002222'.

*

*IF sy-subrc = 0.

*  WRITE :/ '##### ##'.

*ENDIF.








" P.28




*DATA : BEGIN OF gs_student.

*    INCLUDE TYPE zedt16_001.

*DATA: END OF gs_student.

*DATA : gt_student LIKE TABLE OF gs_student.

*

*CLEAR : gs_student, gt_student.

*gs_student-zcode = 'SSU-10'.

*gs_student-zpernr = '0000000010'.

*APPEND gs_student TO gt_student.

*

*CLEAR : gs_student.

*gs_student-zcode = 'SSU-13'.

*gs_student-zpernr = '0000000013'.

*APPEND gs_student TO gt_student.

*

*DELETE zedt16_001 FROM TABLE gt_student.

*

*IF sy-subrc = 0.

*  WRITE :/ '##### ##'.

*ENDIF.








" P.32



DATA : BEGIN OF gs_student.

    include structure
zedt16_001
.

DATA: END OF gs_student.

DATA : gt_student LIKE TABLE OF gs_student.



CLEAR : gs_student, gt_student.



gs_student-zcode = 'SSU-10'.

gs_student-zpernr = '0000000010'.

gs_student-zkname = '###'.

gs_student-zename = 'JOON'.

gs_student-zgender = 'M'.

gs_student-ztel = '01012220000'.

APPEND gs_student TO gt_student.



CLEAR : gs_student.



gs_student-zcode = 'SSU-11'.

gs_student-zpernr = '0000000011'.

gs_student-zkname = '##'.

gs_student-zename = 'YOON'.

gs_student-zgender = 'F'.

gs_student-ztel = '01000002222'.

APPEND gs_student TO gt_student.





MODIFY zedt16_001 FROM TABLE gt_student.







IF sy-subrc = 0.

  WRITE :/ '##### ##'.

ENDIF.