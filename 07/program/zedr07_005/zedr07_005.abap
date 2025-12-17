
*&---------------------------------------------------------------------*

*& Report ZEDR07_005

*&---------------------------------------------------------------------*

*&

*&---------------------------------------------------------------------*




REPORT ZEDR07_005.






************************************************************************

*

*DATA : BEGIN OF gs_student,

*  zpernr TYPE c LENGTH 10,

*  zcode TYPE c LENGTH 10,

*  zkname TYPE c LENGTH 10,

*  zename TYPE c LENGTH 10,

*  zgender TYPE c LENGTH 1,

*  ztel TYPE c LENGTH 10,

*  zgname TYPE c LENGTH 4,

*  END OF gs_student.

*

*  DATA : gt_student LIKE TABLE OF gs_student.

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

*gs_student-zpernr = '0000000002'.

*gs_student-zcode = 'SSU-02'.

*gs_student-zkname = '###'.

*gs_student-zename = 'HOON'.

*gs_student-zgender = 'M'.

*gs_student-ztel = '01022223333'.

*APPEND gs_student TO gt_student.

*

*CLEAR : gs_student.

*gs_student-zpernr = '0000000003'.

*gs_student-zcode = 'SSU-03'.

*gs_student-zkname = '###'.

*gs_student-zename = 'SON'.

*gs_student-zgender = 'F'.

*gs_student-ztel = '01033334444'.

*APPEND gs_student TO gt_student.

*

*CLEAR : gs_student.

*

*LOOP AT gt_student INTO gs_student.

*  IF gs_student-zgender = 'M'.

*    gs_student-zgname ='##'.

*  ELSEIF gs_student-zgender ='F'.

*    gs_student-zgname ='##'.

*  ELSE.

*    gs_student-zgname ='##'.

*  ENDIF.

*

*  CLEAR : gs_student.

*

*ENDLOOP.

*

*BREAK-POINT.



************************************************************************

*

*DATA : BEGIN OF gs_student,

*  zpernr TYPE c LENGTH 10,

*  zcode TYPE c LENGTH 10,

*  zkname TYPE c LENGTH 10,

*  zename TYPE c LENGTH 10,

*  zgender TYPE c LENGTH 1,

*  ztel TYPE c LENGTH 10,

*  zgname TYPE c LENGTH 4,

*  END OF gs_student.

*

*  DATA : gt_student LIKE TABLE OF gs_student.

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

*gs_student-zpernr = '0000000002'.

*gs_student-zcode = 'SSU-02'.

*gs_student-zkname = '###'.

*gs_student-zename = 'HOON'.

*gs_student-zgender = 'M'.

*gs_student-ztel = '01022223333'.

*APPEND gs_student TO gt_student.

*

*CLEAR : gs_student.

*gs_student-zpernr = '0000000003'.

*gs_student-zcode = 'SSU-03'.

*gs_student-zkname = '###'.

*gs_student-zename = 'SON'.

*gs_student-zgender = 'F'.

*gs_student-ztel = '01033334444'.

*APPEND gs_student TO gt_student.

*

*CLEAR : gs_student.

*

*LOOP AT gt_student INTO gs_student WHERE zgender ='F'. "### where# ### ## ### F### ## ##.

*  IF gs_student-zgender = 'M'.

*    gs_student-zgname ='##'.

*  ELSEIF gs_student-zgender ='F'.

*    gs_student-zgname ='##'.

*  ELSE.

*    gs_student-zgname ='##'.

*  ENDIF.

*

*  CLEAR : gs_student.

*

*ENDLOOP.

*

*BREAK-POINT.



************************************************************************

*

*DATA : BEGIN OF gs_student,

*  zpernr TYPE c LENGTH 10,

*  zcode TYPE c LENGTH 10,

*  zkname TYPE c LENGTH 10,

*  zename TYPE c LENGTH 10,

*  zgender TYPE c LENGTH 1,

*  ztel TYPE c LENGTH 10,

*  zgname TYPE c LENGTH 4,

*  END OF gs_student.

*

*  DATA : gt_student LIKE TABLE OF gs_student.

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

*gs_student-zpernr = '0000000002'.

*gs_student-zcode = 'SSU-02'.

*gs_student-zkname = '###'.

*gs_student-zename = 'HOON'.

*gs_student-zgender = 'M'.

*gs_student-ztel = '01022223333'.

*APPEND gs_student TO gt_student.

*

*CLEAR : gs_student.

*gs_student-zpernr = '0000000003'.

*gs_student-zcode = 'SSU-03'.

*gs_student-zkname = '###'.

*gs_student-zename = 'SON'.

*gs_student-zgender = 'F'.

*gs_student-ztel = '01033334444'.

*APPEND gs_student TO gt_student.

*

*CLEAR : gs_student.

*

*LOOP AT gt_student INTO gs_student FROM 2 TO 3. "## #### ## ##.

*  IF gs_student-zgender = 'M'.

*    gs_student-zgname ='##'.

*  ELSEIF gs_student-zgender ='F'.

*    gs_student-zgname ='##'.

*  ELSE.

*    gs_student-zgname ='##'.

*  ENDIF.

*

*  CLEAR : gs_student.

*

*ENDLOOP.

*

*BREAK-POINT.



************************************************************************



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

*  APPEND gs_student TO gt_student.

*

*  gs_student-zgender = 'M'.

*  APPEND gs_student TO gt_student. "### ### ## ## ### ## ### #### ##

*  "## ## ## ### # ## ###.

*

*  BREAK-POINT.



************************************************************************

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

*  DATA : gt_student LIKE TABLE OF gs_student WITH NON-UNIQUE KEY zcode. " # # ### ## ####

*

*  CLEAR : gs_student, gt_student.

*

*  gs_student-zpernr = '0000000001'.

*  gs_student-zcode = 'SSU-01'.

*  gs_student-zkname = '###'.

*  gs_student-zename = 'DONG'.

*  gs_student-zgender = 'F'.

*  gs_student-ztel = '01011112222'.

*  APPEND gs_student TO gt_student.

*

*  gs_student-zgender = 'M'.

*  MODIFY TABLE gt_student FROM gs_student. " # # #### ##### ### ## ### ###.

*

*  BREAK-POINT.



************************************************************************

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

*  DATA : gt_student LIKE TABLE OF gs_student WITH NON-UNIQUE KEY zcode.

*

*  CLEAR : gs_student, gt_student.

*

*  gs_student-zpernr = '0000000001'.

*  gs_student-zcode = 'SSU-01'.

*  gs_student-zkname = '###'.

*  gs_student-zename = 'DONG'.

*  gs_student-zgender = 'F'.

*  gs_student-ztel = '01011112222'.

*  APPEND gs_student TO gt_student.

*

*  gs_student-zename = 'KANG'.

*  gs_student-zgender = 'M'.

*  MODIFY TABLE gt_student FROM gs_student TRANSPORTING zgender. "##### ## ### ## ####.

*

*  BREAK-POINT.



************************************************************************

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

*  DATA : gt_student LIKE TABLE OF gs_student WITH NON-UNIQUE KEY zcode.

*

*  CLEAR : gs_student, gt_student.

*

*  gs_student-zpernr = '0000000001'.

*  gs_student-zcode = 'SSU-01'.

*  gs_student-zkname = '###'.

*  gs_student-zename = 'DONG'.

*  gs_student-zgender = 'M'.

*  gs_student-ztel = '01011112222'.

*  APPEND gs_student TO gt_student.

*

*  gs_student-zpernr = '0000000002'.

*  gs_student-zcode = 'SSU-02'.

*  gs_student-zkname = '###'.

*  gs_student-zename = 'HOON'.

*  gs_student-zgender = 'M'.

*  gs_student-ztel = '01022223333'.

*  APPEND gs_student TO gt_student.

*

*  gs_student-zpernr = '0000000003'.

*  gs_student-zcode = 'SSU-03'.

*  gs_student-zkname = '###'.

*  gs_student-zename = 'SON'.

*  gs_student-zgender = 'F'.

*  gs_student-ztel = '01033334444'.

*  APPEND gs_student TO gt_student.

*

*  LOOP AT gt_student INTO gs_student.

*    IF gs_student-zgender ='M'.

*      gs_student-zgname = '##'.

*    ELSEIF gs_student-zgender ='F'.

*      gs_student-zgname ='##'.

*    ELSE.

*      gs_student-zgname ='##'.

*    ENDIF.

*

*  MODIFY gt_student FROM gs_student TRANSPORTING zgname

*  WHERE zcode = gs_student-zcode.

*

*  CLEAR gs_student.

*  ENDLOOP.

*

*  BREAK-POINT.



************************************************************************

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

*  DATA : gt_student LIKE TABLE OF gs_student WITH NON-UNIQUE KEY zcode.

*

*  CLEAR : gs_student, gt_student.

*

*  gs_student-zpernr = '0000000001'.

*  gs_student-zcode = 'SSU-01'.

*  gs_student-zkname = '###'.

*  gs_student-zename = 'DONG'.

*  gs_student-zgender = 'M'.

*  gs_student-ztel = '01011112222'.

*  APPEND gs_student TO gt_student.

*

*  gs_student-zpernr = '0000000002'.

*  gs_student-zcode = 'SSU-02'.

*  gs_student-zkname = '###'.

*  gs_student-zename = 'HOON'.

*  gs_student-zgender = 'M'.

*  gs_student-ztel = '01022223333'.

*  APPEND gs_student TO gt_student.

*

*  gs_student-zpernr = '0000000003'.

*  gs_student-zcode = 'SSU-03'.

*  gs_student-zkname = '###'.

*  gs_student-zename = 'SON'.

*  gs_student-zgender = 'F'.

*  gs_student-ztel = '01033334444'.

*  APPEND gs_student TO gt_student.

*

*  LOOP AT gt_student INTO gs_student.

*    IF gs_student-zgender ='M'.

*      gs_student-zgname = '##'.

*    ELSEIF gs_student-zgender ='F'.

*      gs_student-zgname ='##'.

*    ELSE.

*      gs_student-zgname ='##'.

*    ENDIF.

*

*    MODIFY gt_student FROM gs_student INDEX sy-tabix.

*

*    CLEAR gs_student.

*  ENDLOOP.

*

*  BREAK-POINT.



************************************************************************

*

*DATA : gs_student TYPE zedt07_001.

*DATA : gt_student LIKE TABLE OF gs_student.

*

*CLEAR : gs_student, gt_student.

*

*  gs_student-zpernr = '0000000001'.

*  gs_student-zcode = 'SSU-01'.

*  gs_student-zkname = '###'.

*  gs_student-zename = 'DONG'.

*  gs_student-zgender = 'M'.

*  gs_student-ztel = '01011112222'.

*  APPEND gs_student TO gt_student.

*

*  gs_student-zpernr = '0000000002'.

*  gs_student-zcode = 'SSU-02'.

*  gs_student-zkname = '###'.

*  gs_student-zename = 'HOON'.

*  gs_student-zgender = 'M'.

*  gs_student-ztel = '01022223333'.

*  APPEND gs_student TO gt_student.

*

*  gs_student-zpernr = '0000000003'.

*  gs_student-zcode = 'SSU-03'.

*  gs_student-zkname = '###'.

*  gs_student-zename = 'SON'.

*  gs_student-zgender = 'F'.

*  gs_student-ztel = '01033334444'.

*  APPEND gs_student TO gt_student.

*

*  CLEAR gs_student.

*

*  LOOP AT  gt_student INTO gs_student.

*    IF gs_student-zgender NE 'M'. "NE# NOT EQUAL.

*      DELETE TABLE gt_student FROM gs_student.

*

*      IF  sy-subrc = 0.

*      ELSE.

*        WRITE :/ '####'.

*      ENDIF.

*

*    ELSE.

*      WRITE :/ gs_student-zcode, gs_student-zkname, gs_student-zgender.

*

*    ENDIF.

*  ENDLOOP.

*

*  BREAK-POINT.



************************************************************************

*

*DATA : gs_student TYPE zedt07_001.

*DATA : gt_student LIKE TABLE OF gs_student WITH NON-UNIQUE KEY zgender. "#### ##

*"## #### ## ##

*

*CLEAR : gs_student, gt_student.

*

*  gs_student-zpernr = '0000000001'.

*  gs_student-zcode = 'SSU-01'.

*  gs_student-zkname = '###'.

*  gs_student-zename = 'DONG'.

*  gs_student-zgender = 'M'.

*  gs_student-ztel = '01011112222'.

*  APPEND gs_student TO gt_student.

*

*  gs_student-zpernr = '0000000002'.

*  gs_student-zcode = 'SSU-02'.

*  gs_student-zkname = '###'.

*  gs_student-zename = 'HOON'.

*  gs_student-zgender = 'M'.

*  gs_student-ztel = '01022223333'.

*  APPEND gs_student TO gt_student.

*

*  gs_student-zpernr = '0000000003'.

*  gs_student-zcode = 'SSU-03'.

*  gs_student-zkname = '###'.

*  gs_student-zename = 'SON'.

*  gs_student-zgender = 'F'.

*  gs_student-ztel = '01033334444'.

*  APPEND gs_student TO gt_student.

*

*  CLEAR gs_student.

*

*  DELETE TABLE gt_student WITH TABLE KEY zgender = 'F'.

*

*  IF sy-subrc = 0.

*    LOOP AT gt_student INTO gs_student.

*      WRITE :/ gs_student-zcode, gs_student-zkname, gs_student-zgender.

*    ENDLOOP.

*  ENDIF.

*

*  BREAK-POINT.



************************************************************************

*

*DATA : gs_student TYPE zedt07_001.

*DATA : gt_student LIKE TABLE OF gs_student.

*

*CLEAR : gs_student, gt_student.

*

*  gs_student-zpernr = '0000000001'.

*  gs_student-zcode = 'SSU-01'.

*  gs_student-zkname = '###'.

*  gs_student-zename = 'DONG'.

*  gs_student-zgender = 'M'.

*  gs_student-ztel = '01011112222'.

*  APPEND gs_student TO gt_student.

*

*  gs_student-zpernr = '0000000002'.

*  gs_student-zcode = 'SSU-02'.

*  gs_student-zkname = '###'.

*  gs_student-zename = 'HOON'.

*  gs_student-zgender = 'M'.

*  gs_student-ztel = '01022223333'.

*  APPEND gs_student TO gt_student.

*

*  gs_student-zpernr = '0000000003'.

*  gs_student-zcode = 'SSU-03'.

*  gs_student-zkname = '###'.

*  gs_student-zename = 'SON'.

*  gs_student-zgender = 'F'.

*  gs_student-ztel = '01033334444'.

*  APPEND gs_student TO gt_student.

*

*  DELETE gt_student WHERE zgender = 'F'. "## ### ### ##### ### #####.

*

*  IF sy-subrc = 0.

*    LOOP AT gt_student INTO gs_student.

*      WRITE :/ gs_student-zcode, gs_student-zkname, gs_student-zgender.

*    ENDLOOP.

*  ENDIF.

*

*  BREAK-POINT.



************************************************************************

*

*DATA : gs_student TYPE zedt07_001.

*DATA : gt_student LIKE TABLE OF gs_student.

*

*CLEAR : gs_student, gt_student.

*

*  gs_student-zpernr = '0000000001'.

*  gs_student-zcode = 'SSU-01'.

*  gs_student-zkname = '###'.

*  gs_student-zename = 'DONG'.

*  gs_student-zgender = 'M'.

*  gs_student-ztel = '01011112222'.

*  APPEND gs_student TO gt_student.

*

*  gs_student-zpernr = '0000000002'.

*  gs_student-zcode = 'SSU-02'.

*  gs_student-zkname = '###'.

*  gs_student-zename = 'HOON'.

*  gs_student-zgender = 'M'.

*  gs_student-ztel = '01022223333'.

*  APPEND gs_student TO gt_student.

*

*  gs_student-zpernr = '0000000003'.

*  gs_student-zcode = 'SSU-03'.

*  gs_student-zkname = '###'.

*  gs_student-zename = 'SON'.

*  gs_student-zgender = 'F'.

*  gs_student-ztel = '01033334444'.

*  APPEND gs_student TO gt_student.

*

*  "DELETE gt_student INDEX 2. "## ### ### ##

*  "DELETE gt_student FROM 2 TO 3. "### #### ##

*  "DELETE gt_student FROM 2. "## ### ## ## ## ##

*  DELETE gt_student TO 2. "## ### ## # ## ##

*

*  IF sy-subrc = 0.

*    LOOP AT gt_student INTO gs_student.

*      WRITE :/ gs_student-zcode, gs_student-zkname, gs_student-zgender.

*    ENDLOOP.

*  ENDIF.



************************************************************************

*

*DATA : gs_student TYPE zedt07_001.

*DATA : gt_student LIKE TABLE OF gs_student.

*

*CLEAR : gs_student, gt_student.

*

*  gs_student-zpernr = '0000000001'.

*  gs_student-zcode = 'SSU-01'.

*  gs_student-zkname = '###'.

*  gs_student-zename = 'DONG'.

*  gs_student-zgender = 'M'.

*  gs_student-ztel = '01011112222'.

*  APPEND gs_student TO gt_student.

*

*  gs_student-zpernr = '0000000001'.

*  gs_student-zcode = 'SSU-01'.

*  gs_student-zkname = '###'.

*  gs_student-zename = 'DONG'.

*  gs_student-zgender = 'M'.

*  gs_student-ztel = '01011112222'.

*  APPEND gs_student TO gt_student.

*

*  gs_student-zpernr = '0000000002'.

*  gs_student-zcode = 'SSU-02'.

*  gs_student-zkname = '###'.

*  gs_student-zename = 'HOON'.

*  gs_student-zgender = 'M'.

*  gs_student-ztel = '01022223333'.

*  APPEND gs_student TO gt_student.

*

*  SORT gt_student.

*

*  "DELETE ADJACENT DUPLICATES FROM gt_student. "## ## ##. ### ## ### ### ####.

*  DELETE ADJACENT DUPLICATES FROM gt_student COMPARING zcode. "### # ### ### ### ## ##.

*

*  IF sy-subrc = 0.

*    LOOP AT gt_student INTO gs_student.

*      WRITE :/ gs_student-zcode, gs_student-zkname, gs_student-zgender.

*    ENDLOOP.

*  ENDIF.