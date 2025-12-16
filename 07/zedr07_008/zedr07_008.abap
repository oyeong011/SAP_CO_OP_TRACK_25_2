
*&---------------------------------------------------------------------*

*& Report ZEDR07_008

*&---------------------------------------------------------------------*

*&

*&---------------------------------------------------------------------*




REPORT ZEDR07_008.






*DATA : BEGIN OF gs_student.

*  INCLUDE TYPE zedt07_001.

*  DATA : END OF gs_student.

*DATA : gt_student LIKE TABLE OF gs_student.

*

*gs_student-mandt = sy-mandt.

*gs_student-zcode = 'SSU-11'.

*gs_student-zpernr = '0000000011'.

*gs_student-zkname = '###'.

*gs_student-zename = 'DO'.

*gs_student-zgender = 'F'.

*gs_student-ztel = '01000001111'.

*

*INSERT INTO zedt07_001 VALUES gs_student. "# # ## ##

*

*IF sy-subrc = 0.

*  WRITE :/ '##'.

*ELSE.

*  WRITE :/ '##'.

*ENDIF.



*************************************************************************

*

*DATA : BEGIN OF gs_student.

*  INCLUDE TYPE zedt07_001.

*  DATA : END OF gs_student.

*DATA : gt_student LIKE TABLE OF gs_student.

*

*CLEAR : gs_student, gt_student.

*

*gs_student-zcode = 'SSU-12'.

*gs_student-zpernr = '0000000012'.

*gs_student-zkname = '###'.

*gs_student-zename = 'DA'.

*gs_student-zgender = 'F'.

*gs_student-ztel = '01000002222'.

*

*APPEND gs_student TO gt_student.

*

*CLEAR : gs_student.

*

*gs_student-zcode = 'SSU-14'.

*gs_student-zpernr = '0000000014'.

*gs_student-zkname = '###'.

*gs_student-zename = 'SOO'.

*gs_student-zgender = 'M'.

*gs_student-ztel = '01000004444'.

*

*APPEND gs_student TO gt_student.

*

*INSERT zedt07_001 FROM TABLE gt_student ACCEPTING DUPLICATE KEYS. "## # ## ##

*"## # #### ##### # INSERT## DUMP ERROR ##

*"### ACCEPTING DUPLICATE KEYS# ### # #### #### #### ##.

*

*IF sy-subrc = 0.

*  WRITE :/ '##'.

*ELSE.

*  WRITE :/ '##'.

*ENDIF.



*************************************************************************



*DATA : BEGIN OF gs_student.

*  INCLUDE TYPE zedt07_001.

*  DATA : END OF gs_student.

*DATA : gt_student LIKE TABLE OF gs_student.

*

*gs_student-zcode = 'SSU-12'.

*gs_student-zpernr = '0000000012'.

*gs_student-zkname = '###'.

*gs_student-zename = 'JAE'.

*gs_student-zgender = 'M'.

*gs_student-ztel = '01000002222'.

*

*UPDATE zedt07_001 FROM gs_student. "# # ## ##

*

*IF sy-subrc = 0.

*  WRITE :/ '##### ##'.

*ENDIF.



*************************************************************************



*DATA : BEGIN OF gs_student.

*  INCLUDE TYPE zedt07_001.

*  DATA : END OF gs_student.

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

*

*APPEND gs_student TO gt_student.

*

*CLEAR : gs_student.

*

*gs_student-zcode = 'SSU-12'.

*gs_student-zpernr = '0000000012'.

*gs_student-zkname = '###'.

*gs_student-zename = 'JAE'.

*gs_student-zgender = 'M'.

*gs_student-ztel = '01000002222'.

*

*APPEND gs_student TO gt_student.

*

*UPDATE zedt07_001 FROM TABLE gt_student. "## # ## ## #### ## # table# ####

*

*IF sy-subrc = 0.

*  WRITE :/ '##### ##'.

*ENDIF.



*************************************************************************



*DATA : BEGIN OF gs_student.

*  INCLUDE TYPE zedt07_001.

*  DATA : END OF gs_student.

*DATA : gt_student LIKE TABLE OF gs_student.

*

*UPDATE zedt07_001 SET zename = 'JUNG'

*WHERE zcode = 'SSU-03'. "### ### ## ####

*

*IF sy-subrc = 0.

*  WRITE :/ '##### ##'.

*ENDIF.



*************************************************************************



*DATA : BEGIN OF gs_student.

*  INCLUDE TYPE zedt07_001.

*  DATA : END OF gs_student.

*DATA : gt_student LIKE TABLE OF gs_student.

*

*gs_student-zcode = 'SSU-14'.

*gs_student-zpernr = '0000000014'.

*

*DELETE zedt07_001 FROM gs_student. "# # ###

*

*IF sy-subrc = 0.

*  WRITE :/ '##### ##'.

*ENDIF.



*************************************************************************

*

*DATA : BEGIN OF gs_student.

*  INCLUDE TYPE zedt07_001.

*  DATA : END OF gs_student.

*DATA : gt_student LIKE TABLE OF gs_student.

*

*DELETE FROM zedt07_001 WHERE ztel = '01000002222'. "### ## # ###

*

*IF sy-subrc = 0.

*  WRITE :/ '##### ##'.

*ENDIF.



**************************************************************************

*

*DATA : BEGIN OF gs_student.

*  INCLUDE TYPE zedt07_001.

*  DATA : END OF gs_student.

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

*DELETE zedt07_001 FROM TABLE gt_student. "#### ## # ## # ##

*

*IF sy-subrc = 0.

*  WRITE :/ '##### ##'.

*ENDIF.



**************************************************************************



*DATA : BEGIN OF gs_student.

*  INCLUDE TYPE zedt07_001.

*  DATA : END OF gs_student.

*DATA : gt_student LIKE TABLE OF gs_student.

*

*gs_student-zcode = 'SSU-11'.

*gs_student-zpernr = '0000000011'.

*gs_student-zkname = '##'.

*gs_student-zename = 'YOON'.

*gs_student-zgender = 'F'.

*gs_student-ztel = '01011112222'.

*

*MODIFY zedt07_001 FROM gs_student. "#### ##### ## #

*

*IF sy-subrc = 0.

*  WRITE :/ '##### ##'.

*ENDIF.



**************************************************************************

*

*DATA : BEGIN OF gs_student.

*  INCLUDE TYPE zedt07_001.

*  DATA : END OF gs_student.

*DATA : gt_student LIKE TABLE OF gs_student.

*

*gs_student-zcode = 'SSU-11'.

*gs_student-zpernr = '0000000011'.

*gs_student-zkname = '##'.

*gs_student-zename = 'AH'.

*gs_student-zgender = 'F'.

*gs_student-ztel = '01011112222'.

*

*MODIFY zedt07_001 FROM gs_student. "#### ##### ## #

*"#### ### #### ### #### ##.

*

*IF sy-subrc = 0.

*  WRITE :/ '##### ##'.

*ENDIF.



**************************************************************************

*

*DATA : BEGIN OF gs_student.

*  INCLUDE TYPE zedt07_001.

*  DATA : END OF gs_student.

*DATA : gt_student LIKE TABLE OF gs_student.

*

*gs_student-zcode = 'SSU-10'.

*gs_student-zpernr = '0000000010'.

*gs_student-zkname = '###'.

*gs_student-zename = 'JOON'.

*gs_student-zgender = 'M'.

*gs_student-ztel = '01012220000'.

*APPEND gs_student TO gt_student.

*

*gs_student-zcode = 'SSU-11'.

*gs_student-zpernr = '0000000011'.

*gs_student-zkname = '##'.

*gs_student-zename = 'YOON'.

*gs_student-zgender = 'F'.

*gs_student-ztel = '01000002222'.

*APPEND gs_student TO gt_student.

*

*MODIFY zedt07_001 FROM TABLE gt_student. "### ##

*

*IF sy-subrc = 0.

*  WRITE :/ '##### ##'.

*ENDIF.