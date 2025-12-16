
*&---------------------------------------------------------------------*

*& Report ZEDR07_003

*&---------------------------------------------------------------------*

*&

*&---------------------------------------------------------------------*




REPORT ZEDR07_003.






************************************************************************

*

*DATA : gs_zedt07 TYPE ZEDT07_001.

*DATA : gt_zedt07 TYPE TABLE OF ZEDT07_001.

*

*gs_zedt07-ZCODE = 'SSU-01'.

*gs_zedt07-ZPERNR = '0000000001'.

*gs_zedt07-ZKNAME = '###'.

*gs_zedt07-ZENAME = 'DONG'.

*gs_zedt07-ZGENDER = 'M'.

*gs_zedt07-ZTEL = '01011112222'.

*

*APPEND gs_zedt07 TO gt_zedt07.

*

*gs_zedt07-ZCODE = 'SSU-02'.

*gs_zedt07-ZPERNR = '0000000002'.

*gs_zedt07-ZKNAME = '##'.

*gs_zedt07-ZENAME = 'JENNY'.

*gs_zedt07-ZGENDER = 'F'.

*gs_zedt07-ZTEL = '01022223333'.

*

*APPEND gs_zedt07 TO gt_zedt07.

*

*BREAK-POINT.



**************************************************************************



*"##### ## ### ###

**DATA : gs_zedt07 TYPE ZEDT07_001.

**DATA : gt_zedt07 TYPE TABLE OF ZEDT07_001.

*

*"##### ## ### ###

*DATA : gt_zedt07 TYPE ZEDT07_001 OCCURS 0 WITH HEADER LINE.

**DATA : gt_zedt07 LIKE ZEDT07_001 OCCURS 0 WITH HEADER LINE.

**DATA : gt_zedt07 TYPE TABLE OF ZEDT07_001 WITH HEADER LINE.

**DATA : gt_zedt07 LIKE TABLE OF ZEDT07_001 WITH HEADER LINE.

*

*gt_zedt07-ZCODE = 'SSU-01'.

*gt_zedt07-ZPERNR = '0000000001'.

*gt_zedt07-ZKNAME = '###'.

*gt_zedt07-ZENAME = 'DONG'.

*gt_zedt07-ZGENDER = 'M'.

*gt_zedt07-ZTEL = '01011112222'.

*

*APPEND gt_zedt07 TO gt_zedt07. "TO gt_zedt07. ####

*

*BREAK-POINT.



***************************************************************************

*

*DATA : BEGIN OF gs_student,

*  zpernr TYPE ZEDT07_001-ZPERNR,

*  zcode TYPE ZEDT07_001-ZCODE,

*  zkname TYPE ZEDT07_001-ZKNAME,

*  zename TYPE ZEDT07_001-ZENAME,

*  zgender TYPE ZEDT07_001-ZGENDER,

*  ztel TYPE ZEDT07_001-ZTEL,

*  zmname TYPE ZEDT07_002-ZMAJOR,

*  END OF gs_student.

*

*  DATA : gt_student LIKE TABLE OF gs_student.

*

*  gs_student-zcode = 'SSU-01'.

*  gs_student-zpernr = '0000000001'.

*  gs_student-zkname = '###'.

*  gs_student-zename = 'DONG'.

*  gs_student-zgender = 'M'.

*  gs_student-ztel = '01011112222'.

*  gs_student-zmname = '####'.

*

*  APPEND gs_student TO gt_student.

*

*  BREAK-POINT.



***************************************************************************

*

*DATA : BEGIN OF gs_student,

*  zcode TYPE c LENGTH 10,

*  zkname TYPE c LENGTH 10,

*  zename TYPE c LENGTH 10,

*  zclass TYPE c,

*  END OF gs_student.

*

*  DATA : BEGIN OF gs_student2,

*    zcode TYPE c LENGTH 10,

*    zkname TYPE c LENGTH 10,

*    zename TYPE c LENGTH 10,

*    zclass TYPE c,

*    END OF gs_student2.

*

*    DATA : gt_student LIKE TABLE OF gs_student.

*    DATA : gt_student2 LIKE TABLE OF gs_student2.

*

*    gs_student-zcode = 'SSU-01'.

*    gs_student-zkname = '###'.

*    gs_student-zename = 'DONG'.

*

*    gs_student2-zcode = 'SSU-01'.

*    gs_student2-zkname = '###'.

*    gs_student2-zename = 'DONG'.

*

*    APPEND gs_student TO gt_student.

*    APPEND gs_student2 TO gt_student2.

*

*    BREAK-POINT.



******************************************************************************

*

*DATA : BEGIN OF gs_student,

*  zcode TYPE c LENGTH 10,

*  zkname TYPE c LENGTH 10,

*  zename TYPE c LENGTH 10,

*  zclass TYPE c,

*  END OF gs_student.

*

*  DATA : BEGIN OF gs_student2,

*    zcode TYPE c LENGTH 10,

*    zkname TYPE c LENGTH 10,

*    zename TYPE c LENGTH 10,

*    zclass TYPE c,

*    END OF gs_student2.

*

*    DATA : gt_student LIKE TABLE OF gs_student.

*    DATA : gt_student2 LIKE TABLE OF gs_student2.

*

*    gs_student-zcode = 'SSU-01'.

*    gs_student-zkname = '###'.

*    gs_student-zename = 'DONG'.

*

*    APPEND gs_student TO gt_student.

*

**    MOVE gs_student TO gs_student2.

**

**    APPEND gs_student2 TO gt_student2.

*

*    MOVE gt_student[] to gt_student2[].

*

*    BREAK-POINT.



******************************************************************************

*

*DATA : BEGIN OF gt_student OCCURS 0,

*  zcode TYPE c LENGTH 10,

*  zkname TYPE c LENGTH 10,

*  zename TYPE c LENGTH 10,

*  END OF gt_student.

*

*DATA : BEGIN OF gt_student2 OCCURS 0,

*  zcode TYPE c LENGTH 10,

*  zkname TYPE c LENGTH 10,

*  zename TYPE c LENGTH 10,

*  END OF gt_student2.

*

*  gt_student-zcode = 'SSU-01'.

*  gt_student-zkname = '###'.

*  gt_student-zename = 'DONG'.

*

*  APPEND gt_student.

*

** MOVE gt_student TO gt_student2. "## ## ## ## # #.

*  MOVE gt_student[] TO gt_student2[]. "## ## ## ## # #.

*

*  BREAK-POINT.



******************************************************************************

*

*DATA : BEGIN OF gt_student OCCURS 0,

*  zcode TYPE c LENGTH 10,

*  zkname TYPE c LENGTH 10,

*  zename TYPE c LENGTH 10,

*  END OF gt_student.

*

*DATA : BEGIN OF gt_student2 OCCURS 0,

*  zclass TYPE c, "### ## ### move# ### ## # #.

*  zcode TYPE c LENGTH 10,

*  zkname TYPE c LENGTH 10,

*  zename TYPE c LENGTH 10,

*  END OF gt_student2.

*

*  gt_student-zcode = 'SSU-01'.

*  gt_student-zkname = '###'.

*  gt_student-zename = 'DONG'.

*

*  APPEND gt_student.

*

** MOVE gt_student TO gt_student2. "## ## ## ## # #.

*  MOVE gt_student[] TO gt_student2[]. "## ## ## ## # #.

*

*  BREAK-POINT.



******************************************************************************

*

*DATA : BEGIN OF gt_student OCCURS 0,

*  zcode TYPE c LENGTH 10,

*  zkname TYPE c LENGTH 10,

*  zename TYPE c LENGTH 10,

*  END OF gt_student.

*

*DATA : BEGIN OF gt_student2 OCCURS 0,

*  zclass TYPE c,

*  zcode TYPE c LENGTH 10,

*  zkname TYPE c LENGTH 10,

*  zename TYPE c LENGTH 10,

*  END OF gt_student2.

*

*  gt_student-zcode = 'SSU-01'.

*  gt_student-zkname = '###'.

*  gt_student-zename = 'DONG'.

*

*  APPEND gt_student.

*

*  MOVE-CORRESPONDING gt_student TO gt_student2.

*

*  APPEND gt_student2. "### ##

*

*  BREAK-POINT.



******************************************************************************

*

*DATA : BEGIN OF gt_student OCCURS 0,

*  zcode TYPE c LENGTH 10,

*  zkname TYPE c LENGTH 10,

*  zename TYPE c LENGTH 10,

*  END OF gt_student.

*

*DATA : BEGIN OF gt_student2 OCCURS 0,

*  zclass TYPE c,

*  zcode TYPE c LENGTH 10,

*  zkname TYPE c LENGTH 10,

*  zename TYPE c LENGTH 10,

*  END OF gt_student2.

*

*  gt_student-zcode = 'SSU-01'.

*  gt_student-zkname = '###'.

*  gt_student-zename = 'DONG'.

*

*  APPEND gt_student.

*

*  MOVE-CORRESPONDING gt_student[] TO gt_student2[]. "### ### ## ## ### # ## # #.

*

*  BREAK-POINT.



******************************************************************************

*

*DATA : BEGIN OF gs_student,

*  zcode TYPE c LENGTH 10,

*  zkname TYPE c LENGTH 10,

*  zename TYPE c LENGTH 10,

*  END OF gs_student.

*

*  DATA : gt_student LIKE TABLE OF gs_student.

*

*  gs_student-zcode = 'SSU-01'.

*  gs_student-zkname = '###'.

*  gs_student-zename = 'DONG'.

*

*  APPEND gs_student TO gt_student.

*

*  BREAK-POINT.

*

*  CLEAR : gt_student.

*

*  BREAK-POINT.



******************************************************************************

*

*DATA : BEGIN OF gt_student OCCURS 0,

*  zcode TYPE c LENGTH 10,

*  zkname TYPE c LENGTH 10,

*  zename TYPE c LENGTH 10,

*  END OF gt_student.

*

*  gt_student-zcode = 'SSU-01'.

*  gt_student-zkname = '###'.

*  gt_student-zename = 'DONG'.

*

*  APPEND gt_student.

*

*  CLEAR : gt_student. "### ###### append ##### #### ####.

*

*  BREAK-POINT.



******************************************************************************

*

*DATA : BEGIN OF gt_student OCCURS 0,

*  zcode TYPE c LENGTH 10,

*  zkname TYPE c LENGTH 10,

*  zename TYPE c LENGTH 10,

*  END OF gt_student.

*

*  gt_student-zcode = 'SSU-01'.

*  gt_student-zkname = '###'.

*  gt_student-zename = 'DONG'.

*

*  APPEND gt_student.

*

*  CLEAR : gt_student[]. "#### ##### ##### ###.

*

*  BREAK-POINT.

*

*****************************************************************************

*

*DATA : BEGIN OF gt_student OCCURS 0,

*  zcode TYPE c LENGTH 10,

*  zkname TYPE c LENGTH 10,

*  zename TYPE c LENGTH 10,

*  END OF gt_student.

*

*  gt_student-zcode = 'SSU-01'.

*  gt_student-zkname = '###'.

*  gt_student-zename = 'DONG'.

*

*  APPEND gt_student.

*

*  REFRESH : gt_student. "#### ##### ### ### ##

*

*  BREAK-POINT.



*****************************************************************************

*

*DATA : BEGIN OF gt_student OCCURS 0,

*  zcode TYPE c LENGTH 10,

*  zkname TYPE c LENGTH 10,

*  zename TYPE c LENGTH 10,

*  END OF gt_student.

*

*  gt_student-zcode = 'SSU-01'.

*  gt_student-zkname = '###'.

*  gt_student-zename = 'DONG'.

*

*  APPEND gt_student.

*

*  BREAK-POINT.

*

*  FREE : gt_student. "refresh # ### ### ##.

*

*  BREAK-POINT.