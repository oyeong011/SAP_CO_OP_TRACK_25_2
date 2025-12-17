
*&---------------------------------------------------------------------*

*& Report ZEDR07_004

*&---------------------------------------------------------------------*

*&

*&---------------------------------------------------------------------*




REPORT ZEDR07_004.






************************************************************************

*

*DATA : BEGIN OF gs_student,

*  zcode TYPE c LENGTH 10,

*  zkname TYPE c LENGTH 10,

*  zename TYPE c LENGTH 10,

*  END OF gs_student.

*

*  DATA : gt_student LIKE TABLE OF gs_student.

*

*  gs_student-zcode = 'SSU-02'.

*  gs_student-zkname = '###'.

*  gs_student-zename = 'LEE'.

*  APPEND gs_student TO gt_student.

*

*  gs_student-zcode = 'SSU-01'.

*  gs_student-zkname = '###'.

*  gs_student-zename = 'DONG'.

*  APPEND gs_student TO gt_student.

*

*  gs_student-zcode = 'SSU-03'.

*  gs_student-zkname = '###'.

*  gs_student-zename = 'SONG'.

*  APPEND gs_student TO gt_student.

*

*  BREAK-POINT.

*

*  SORT gt_student. "ASCENDING # ### # ### ####.

*  BREAK-POINT.



************************************************************************

*

*DATA : BEGIN OF gs_student,

*  zcode TYPE c LENGTH 10,

*  zkname TYPE c LENGTH 10,

*  zename TYPE c LENGTH 10,

*  END OF gs_student.

*

*  DATA : gt_student LIKE TABLE OF gs_student.

*

*  gs_student-zcode = 'SSU-02'.

*  gs_student-zkname = '###'.

*  gs_student-zename = 'LEE'.

*  APPEND gs_student TO gt_student.

*

*  gs_student-zcode = 'SSU-01'.

*  gs_student-zkname = '###'.

*  gs_student-zename = 'DONG'.

*  APPEND gs_student TO gt_student.

*

*  gs_student-zcode = 'SSU-03'.

*  gs_student-zkname = '###'.

*  gs_student-zename = 'SONG'.

*  APPEND gs_student TO gt_student.

*  BREAK-POINT.

*

*  SORT gt_student DESCENDING.

*  BREAK-POINT.



*************************************************************************

*

*DATA : BEGIN OF gs_student,

*  zcode TYPE c LENGTH 10,

*  zkname TYPE c LENGTH 10,

*  zename TYPE c LENGTH 10,

*END OF gs_student.

*

*DATA : gt_student LIKE TABLE OF gs_student.

*

*  gs_student-zcode = 'SSU-02'.

*  gs_student-zkname = '###'.

*  gs_student-zename = 'LEE'.

*  APPEND gs_student TO gt_student.

*

*  gs_student-zcode = 'SSU-01'.

*  gs_student-zkname = '###'.

*  gs_student-zename = 'DONG'.

*  APPEND gs_student TO gt_student.

*

*  gs_student-zcode = 'SSU-03'.

*  gs_student-zkname = '###'.

*  gs_student-zename = 'SONG'.

*  APPEND gs_student TO gt_student.

*

*  BREAK-POINT.

*

*  SORT gt_student BY zkname.

*  BREAK-POINT.



**************************************************************************

*

*DATA : BEGIN OF gs_student,

*  zcode TYPE c LENGTH 10,

*  zkname TYPE c LENGTH 10,

*  zename TYPE c LENGTH 10,

*END OF gs_student.

*

*DATA : gt_student LIKE TABLE OF gs_student.

*

*  gs_student-zcode = 'SSU-02'.

*  gs_student-zkname = '###'.

*  gs_student-zename = 'LEE'.

*  APPEND gs_student TO gt_student.

*

*  gs_student-zcode = 'SSU-01'.

*  gs_student-zkname = '###'.

*  gs_student-zename = 'DONG'.

*  APPEND gs_student TO gt_student.

*

*  gs_student-zcode = 'SSU-03'.

*  gs_student-zkname = '###'.

*  gs_student-zename = 'SONG'.

*  APPEND gs_student TO gt_student.

*

*  BREAK-POINT.

*

*  SORT gt_student BY zkname DESCENDING.

*  BREAK-POINT.



***************************************************************************

*

*DATA : BEGIN OF gs_student,

*  zcode TYPE c LENGTH 10,

*  zkname TYPE c LENGTH 10,

*  zename TYPE c LENGTH 10,

*END OF gs_student.

*

*DATA : gt_student LIKE TABLE OF gs_student.

*

*  gs_student-zcode = 'SSU-02'.

*  gs_student-zkname = '###'.

*  gs_student-zename = 'LEE'.

*  APPEND gs_student TO gt_student.

*

*  gs_student-zcode = 'SSU-01'.

*  gs_student-zkname = '###'.

*  gs_student-zename = 'DONG'.

*  APPEND gs_student TO gt_student.

*

*  gs_student-zcode = 'SSU-03'.

*  gs_student-zkname = '###'.

*  gs_student-zename = 'SONG'.

*  APPEND gs_student TO gt_student.

*

*  gs_student-zcode = 'SSU-04'.

*  gs_student-zkname = '###'.

*  gs_student-zename = 'LEE'.

*  APPEND gs_student TO gt_student.

*

*  BREAK-POINT.

*

*  SORT gt_student BY zkname zcode DESCENDING.

*  BREAK-POINT.



*****************************************************************************

*

*DATA : BEGIN OF gs_line,

*  col1 TYPE c,

*  END OF gs_line.

*

*  DATA : gt_line LIKE TABLE OF gs_line.

*

*  DATA : gv_line TYPE i.

*

*  gs_line-col1 = SY-INDEX.

*  APPEND gs_line TO gt_line.

*

*  gs_line-col1 = '2'.

*  APPEND gs_line TO gt_line.

*

*  gs_line-col1 = '3'.

*  APPEND gs_line TO gt_line.

*

*  DESCRIBE TABLE gt_line LINES gv_line. "### #### #### ## ## # ##.

*

*  WRITE : gv_line.



******************************************************************************

*

*DATA : BEGIN OF gs_student,

*  zcode TYPE c LENGTH 10,

*  zkname TYPE c LENGTH 10,

*  zename TYPE c LENGTH 10,

*END OF gs_student.

*

*DATA : gt_student LIKE TABLE OF gs_student.

*

*  CLEAR : gs_student.

*  gs_student-zcode = 'SSU-02'.

*  gs_student-zkname = '###'.

*  gs_student-zename = 'LEE'.

*  INSERT gs_student INTO TABLE gt_student.

*

*  CLEAR : gs_student.

*  gs_student-zcode = 'SSU-01'.

*  gs_student-zkname = '###'.

*  gs_student-zename = 'DONG'.

*  INSERT gs_student INTO TABLE gt_student.

*

*  CLEAR : gs_student.

*  gs_student-zcode = 'SSU-03'.

*  gs_student-zkname = '###'.

*  gs_student-zename = 'SONG'.

*  INSERT gs_student INTO gt_student INDEX 2. "#### #### #### ### ### ####.

*

*  BREAK-POINT.



*******************************************************************************

*

*DATA : BEGIN OF gs_student,

*  zcode TYPE c LENGTH 10,

*  zkname TYPE c LENGTH 10,

*  zename TYPE c LENGTH 10,

*  zsum TYPE i,

*END OF gs_student.

*

*DATA : gt_student LIKE TABLE OF gs_student.

*

*  CLEAR : gs_student.

*  gs_student-zcode = 'SSU-02'.

*  gs_student-zkname = '###'.

*  gs_student-zename = 'LEE'.

*  gs_student-zsum = '10000'.

*  COLLECT gs_student INTO gt_student.

*

*  CLEAR : gs_student.

*  gs_student-zcode = 'SSU-02'.

*  gs_student-zkname = '###'.

*  gs_student-zename = 'LEE'.

*  gs_student-zsum = '10000'.

*  COLLECT gs_student INTO gt_student.

*

*  CLEAR : gs_student.

*  gs_student-zcode = 'SSU-03'.

*  gs_student-zkname = '###'.

*  gs_student-zename = 'SONG'.

*  gs_student-zsum = '10000'.

*  COLLECT gs_student INTO gt_student. "#### ### ### ####.

*

*  BREAK-POINT.



*********************************************************************************

*

*DATA : BEGIN OF gs_student,

*  zpernr LIKE zedt07_001-zpernr,

*  zcode LIKE zedt07_001-zcode,

*  zkname LIKE zedt07_001-zkname,

*  zename LIKE zedt07_001-zename,

*  zgender LIKE zedt07_001-zgender,

*  zgname TYPE c LENGTH 4,

*  ztel LIKE zedt07_001-ztel,

*  END OF gs_student.

*

*  DATA : gt_student LIKE TABLE OF gs_student.

*

*  CLEAR : gs_student, gt_student.

*

*  gs_student-zpernr = '0000000001'.

*  gs_student-zcode = 'SSU-01'.

*  gs_student-zkname = '###'.

*  gs_student-zename = 'DONG'.

*  gs_student-zgender = 'M'.

*  gs_student-ztel = '01011112222'.

*

*  IF gs_student-zgender ='M'.

*    gs_student-zgname = '##'.

*  ENDIF.

*

*  APPEND gs_student TO gt_student.

*

*  CLEAR : gs_student.

*

*  BREAK-POINT.



**********************************************************************************

*

*DATA : BEGIN OF gs_student,

*  zpernr LIKE zedt07_001-zpernr,

*  zcode LIKE zedt07_001-zcode,

*  zkname LIKE zedt07_001-zkname,

*  zename LIKE zedt07_001-zename,

*  zgender LIKE zedt07_001-zgender,

*  zgname TYPE c LENGTH 4,

*  ztel LIKE zedt07_001-ztel,

*  END OF gs_student.

*

*  DATA : gt_student LIKE TABLE OF gs_student.

*

*  CLEAR : gs_student, gt_student.

*

*  gs_student-zpernr = '0000000001'.

*  gs_student-zcode = 'SSU-01'.

*  gs_student-zkname = '###'.

*  gs_student-zename = 'DONG'.

*  gs_student-zgender = 'F'.

*  gs_student-ztel = '01011112222'.

*

*  IF gs_student-zgender ='M'.

*    gs_student-zgname = '##'.

*  ENDIF.

*

*  APPEND gs_student TO gt_student. "body# zgname# # ## ##. if# ### # ###.

*

*  CLEAR : gs_student.

*

*  BREAK-POINT.



*********************************************************************************

*

*DATA : BEGIN OF gs_student,

*  zpernr LIKE zedt07_001-zpernr,

*  zcode LIKE zedt07_001-zcode,

*  zkname LIKE zedt07_001-zkname,

*  zename LIKE zedt07_001-zename,

*  zgender LIKE zedt07_001-zgender,

*  zgname TYPE c LENGTH 4,

*  ztel LIKE zedt07_001-ztel,

*  END OF gs_student.

*

*  DATA : gt_student LIKE TABLE OF gs_student.

*

*  CLEAR : gs_student, gt_student.

*

*  gs_student-zpernr = '0000000001'.

*  gs_student-zcode = 'SSU-01'.

*  gs_student-zkname = '###'.

*  gs_student-zename = 'DONG'.

*  gs_student-zgender = 'F'.

*  gs_student-ztel = '01011112222'.

*

*  IF gs_student-zgender = 'M'. "### ## ### #### ##.

*    gs_student-zgname = '##'.

*  ELSE.

*    gs_student-zgname = '##'.

*  ENDIF.

*

*  APPEND gs_student TO gt_student.

*

*  CLEAR : gs_student.

*

*  BREAK-POINT.

*

********************************************************************************

*

*DATA : BEGIN OF gs_student,

*  zpernr LIKE zedt07_001-zpernr,

*  zcode LIKE zedt07_001-zcode,

*  zkname LIKE zedt07_001-zkname,

*  zename LIKE zedt07_001-zename,

*  zgender LIKE zedt07_001-zgender,

*  zgname TYPE c LENGTH 4,

*  ztel LIKE zedt07_001-ztel,

*  END OF gs_student.

*

*  DATA : gt_student LIKE TABLE OF gs_student.

*

*  CLEAR : gs_student, gt_student.

*

*  gs_student-zpernr = '0000000001'.

*  gs_student-zcode = 'SSU-01'.

*  gs_student-zkname = '###'.

*  gs_student-zename = 'DONG'.

*  gs_student-zgender = 'A'.

*  gs_student-ztel = '01011112222'.

*

*  IF gs_student-zgender = 'M'. "### ## ### #### ##.

*    gs_student-zgname = '##'.

*  ELSEIF gs_student-zgender ='F'. "## 3~4## if## elif# ##.

*    gs_student-zgname = '##'.

*  ELSE.

*    gs_student-zgname ='##'.

*  ENDIF.

*

*  APPEND gs_student TO gt_student.

*

*  CLEAR : gs_student.

*

*  BREAK-POINT.



**********************************************************************************

*

*DATA : BEGIN OF gs_student,

*  zpernr LIKE zedt07_001-zpernr,

*  zcode LIKE zedt07_001-zcode,

*  zkname LIKE zedt07_001-zkname,

*  zename LIKE zedt07_001-zename,

*  zgender LIKE zedt07_001-zgender,

*  zgname TYPE c LENGTH 4,

*  ztel LIKE zedt07_001-ztel,

*  END OF gs_student.

*

*  DATA : gt_student LIKE TABLE OF gs_student.

*

*  CLEAR : gs_student, gt_student.

*

*  gs_student-zpernr = '0000000001'.

*  gs_student-zcode = 'SSU-01'.

*  gs_student-zkname = '###'.

*  gs_student-zename = 'DONG'.

*  gs_student-zgender = 'M'.

*  gs_student-ztel = '01011112222'.

*

*  IF ( gs_student-zgender = 'M' ) AND ( gs_student-zkname = '###'). "## ### #### ## ##.

*    gs_student-zgname = '##'.

*  ENDIF.

*

*  APPEND gs_student TO gt_student.

*

*  CLEAR : gs_student.

*

*  BREAK-POINT.

*

***********************************************************************************

*

*DATA : BEGIN OF gs_student,

*  zpernr LIKE zedt07_001-zpernr,

*  zcode LIKE zedt07_001-zcode,

*  zkname LIKE zedt07_001-zkname,

*  zename LIKE zedt07_001-zename,

*  zgender LIKE zedt07_001-zgender,

*  zgname TYPE c LENGTH 4,

*  ztel LIKE zedt07_001-ztel,

*  END OF gs_student.

*

*  DATA : gt_student LIKE TABLE OF gs_student.

*

*  CLEAR : gs_student, gt_student.

*

*  gs_student-zpernr = '0000000001'.

*  gs_student-zcode = 'SSU-01'.

*  gs_student-zkname = '###'.

*  gs_student-zename = 'DONG'.

*  gs_student-zgender = 'M'.

*  gs_student-ztel = '01011112222'.

*

*  IF ( gs_student-zgender = 'M' ) OR ( gs_student-zkname = '###'). "## # ### #### ## ##.

*    gs_student-zgname = '##'.

*  ENDIF.

*

*  APPEND gs_student TO gt_student.

*

*  CLEAR : gs_student.

*

*  BREAK-POINT.



***********************************************************************************






WRITE :/ '**1#-if## write# ##'.

DATA : gv_num1 TYPE i, gv_num2 TYPE i.



gv_num1 ='100'.

gv_num2 ='120'.



WRITE :/ gv_num1.

WRITE :/ gv_num2.



IF gv_num1 < gv_num2.

  WRITE :/ 'gv_num1# gv_num2## ####.'.

ENDIF.



WRITE :/ '-----------------------------------'.

WRITE :/ '2#-if## write# ##'.

DATA : gv_num3 TYPE i.



gv_num1 ='100'.

gv_num2 ='120'.

gv_num3 ='110'.



WRITE :/ gv_num1.

WRITE :/ gv_num2.

WRITE :/ gv_num3.



IF ( gv_num1 < gv_num2 ) AND ( gv_num1 < gv_num3 ).

  WRITE :/ 'gv_num1# gv_num2, gv_num3## ####.'.

ENDIF.



WRITE :/ '-----------------------------------'.

WRITE :/ '3#-else## write# ##'.



gv_num1 ='100'.

gv_num2 ='120'.



WRITE :/ gv_num1.

WRITE :/ gv_num2.



IF gv_num1 > gv_num2.

  WRITE :/ 'gv_num1# gv_num2## ####.'.

ELSE.

  WRITE :/ 'gv_num2# gv_num1## ###.'.

ENDIF.



WRITE :/ '-----------------------------------'.

WRITE :/ '4#-num1, num2, num3## ### #### write# ##'.



gv_num1 ='100'.

gv_num2 ='120'.

gv_num3 ='110'.



IF gv_num1 > gv_num2.

  IF gv_num1 > gv_num3.

    WRITE :/ 'gv_num1#'.

    WRITE : gv_num1.

    WRITE : '## #####.'.

  ENDIF.

ELSEIF gv_num1 < gv_num2.

  IF gv_num2 > gv_num3.

    WRITE :/ 'gv_num2#'.

    WRITE : gv_num2.

    WRITE : '## #####.'.

  ENDIF.

ELSE.

  WRITE :/ 'gv_num3#'.

    WRITE : gv_num3.

    WRITE : '## #####.'.

ENDIF.