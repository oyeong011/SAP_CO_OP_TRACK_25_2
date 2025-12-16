
*&---------------------------------------------------------------------*

*& Report ZEDR07_017

*&---------------------------------------------------------------------*

*&

*&---------------------------------------------------------------------*




REPORT ZEDR07_017.






************************************************************************



*DATA : gv_var TYPE c VALUE 'A'.

*

*"FIELD-SYMBOLS <FS> TYPE c.

*FIELD-SYMBOLS <FS> TYPE ANY. "generic type simbol## ### # ##.

*

*ASSIGN gv_var TO <FS>. "FS# gv_var# ##

*

*<FS> = 'B'. "fs# ##

*

*WRITE :/ gv_var.



************************************************************************



*DATA : gv_1 TYPE c VALUE 'A'.

*DATA : gv_2 TYPE c VALUE 'B'.

*DATA : gv_3 TYPE c VALUE 'C'.

*

*DATA : gv_fname(10).

*DATA : gv_index TYPE n.

*

*FIELD-SYMBOLS <FS> TYPE any.

*

*DO 3 TIMES.

*  CLEAR gv_fname.

*  gv_fname = 'GV_'.

*  gv_index = sy-index.

*  CONCATENATE gv_fname gv_index INTO gv_fname.

*

*  ASSIGN (gv_fname) TO <FS>.

*

*  WRITE :/ gv_fname , ':' , <FS>.

*ENDDO.



************************************************************************



*DATA : BEGIN OF gs_sum,

*  mon01 TYPE dmbtr VALUE '10.00',

*  mon02 TYPE dmbtr VALUE '20.00',

*  mon03 TYPE dmbtr VALUE '30.00',

*  mon04 TYPE dmbtr VALUE '40.00',

*  mon05 TYPE dmbtr VALUE '50.00',

*  mon06 TYPE dmbtr VALUE '60.00',

*END OF gs_sum.

*

*DATA : zindex(2).

*DATA : zmon(6).

*

*FIELD-SYMBOLS : <FS1> LIKE gs_sum,

*                <FS2> TYPE any.

*

*ASSIGN gs_sum TO <FS1>.

*

*DO 6 TIMES.

*  zindex = sy-index.

*  CONCATENATE 'MON0' zindex INTO zmon.

*

*  ASSIGN COMPONENT zmon OF STRUCTURE <FS1> TO <FS2>.

*  WRITE :/ <FS2>.

*ENDDO.



************************************************************************



*DATA : BEGIN OF gs_student,

*  zcode LIKE zedt07_001-zcode,

*  zkname LIKE zedt07_001-zkname,

*  zename LIKE zedt07_001-zename,

*END OF gs_student.

*

*DATA : gt_student LIKE TABLE OF gs_student.

*DATA : gv_zcode(10) VALUE 'ZCODE'.

*

*SELECT * FROM zedt07_001 INTO CORRESPONDING FIELDS OF TABLE gt_student.

*

*FIELD-SYMBOLS <FS> TYPE ANY TABLE.

*ASSIGN gt_student TO <FS>.

*

*"READ TABLE <FS> WITH KEY (gv_zcode) = 'SSU-01' INTO gs_student. "### ###

*

*FIELD-SYMBOLS <fs_gs_student> TYPE any. "### ### #### ##

*READ TABLE <FS> WITH KEY (gv_zcode) = 'SSU-01' ASSIGNING <fs_gs_student>.

*

**WRITE :/ gs_student-zcode.

**WRITE :/ gs_student-zkname.

**WRITE :/ gs_student-zename.

*

*WRITE <fs_gs_student>.



************************************************************************






DATA : BEGIN OF gs_student,

  zcode LIKE zedt07_001-zcode,

  zkname LIKE zedt07_001-zkname,

  zename LIKE zedt07_001-zename,

  zmemo(10),

END OF gs_student.



DATA : gt_student LIKE TABLE OF gs_student.

DATA : gv_zcode(10) VALUE 'ZCODE'.



SELECT * FROM zedt07_001 INTO CORRESPONDING FIELDS OF TABLE gt_student.



FIELD-SYMBOLS <fs_t> LIKE LINE OF gt_student.



LOOP AT gt_student ASSIGNING <FS_T>.

  IF <FS_T>-zename = 'SON'.

    <FS_T>-zmemo = '####'.

  ENDIF.

ENDLOOP.






************************************************************************