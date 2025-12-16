
*&---------------------------------------------------------------------*

*& Report ZEDR07_006

*&---------------------------------------------------------------------*

*&

*&---------------------------------------------------------------------*




REPORT ZEDR07_006.






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

*    gs_student-zgname ='####'.

*

*    AT FIRST. "## # #### ##

*      gs_student-zgname ='####'.

*    ENDAT.

*

*    CLEAR : gs_student.

*  ENDLOOP.

*

*  BREAK-POINT.



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

*    gs_student-zgname ='####'.

*

*    AT LAST. "## ### ##### ##.

*      gs_student-zgname ='####'.

*    ENDAT.

*

*    CLEAR : gs_student.

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

*  gs_student-zpernr = '0000000001'.

*  gs_student-zcode = 'SSU-01'.

*  gs_student-zkname = '###'.

*  gs_student-zename = 'KANG'.

*  gs_student-zgender = 'M'.

*  gs_student-ztel = '01011112222'.

*  APPEND gs_student TO gt_student.

*

*  gs_student-zpernr = '0000000001'.

*  gs_student-zcode = 'SSU-01'.

*  gs_student-zkname = '###'.

*  gs_student-zename = 'DONG'.

*  gs_student-zgender = 'F'.

*  gs_student-ztel = '01011112222'.

*  APPEND gs_student TO gt_student.

*

*  gs_student-zpernr = '0000000001'.

*  gs_student-zcode = 'SSU-01'.

*  gs_student-zkname = '###'.

*  gs_student-zename = 'DONG'.

*  gs_student-zgender = 'A'.

*  gs_student-ztel = '01011112222'.

*  APPEND gs_student TO gt_student.

*

*  gs_student-zpernr = '0000000001'.

*  gs_student-zcode = 'SSU-01'.

*  gs_student-zkname = '###'.

*  gs_student-zename = 'DONG'.

*  gs_student-zgender = 'F'.

*  gs_student-ztel = '01011112222'.

*  APPEND gs_student TO gt_student.

*

*  CLEAR : gs_student.

*

*  SORT gt_student BY ZCODE ZKNAME ZENAME ZGENDER.

*

*  LOOP AT gt_student INTO gs_student.

*    gs_student-zgname ='####'.

*

*    AT NEW zename. "zename ## ## #### ## #### ## ##

*      gs_student-zgname ='####'.

*    ENDAT.

*

*    CLEAR : gs_student.

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

*  gs_student-zpernr = '0000000001'.

*  gs_student-zcode = 'SSU-01'.

*  gs_student-zkname = '###'.

*  gs_student-zename = 'KANG'.

*  gs_student-zgender = 'M'.

*  gs_student-ztel = '01011112222'.

*  APPEND gs_student TO gt_student.

*

*  gs_student-zpernr = '0000000001'.

*  gs_student-zcode = 'SSU-01'.

*  gs_student-zkname = '###'.

*  gs_student-zename = 'DONG'.

*  gs_student-zgender = 'F'.

*  gs_student-ztel = '01011112222'.

*  APPEND gs_student TO gt_student.

*

*  gs_student-zpernr = '0000000001'.

*  gs_student-zcode = 'SSU-01'.

*  gs_student-zkname = '###'.

*  gs_student-zename = 'DONG'.

*  gs_student-zgender = 'A'.

*  gs_student-ztel = '01011112222'.

*  APPEND gs_student TO gt_student.

*

*  gs_student-zpernr = '0000000001'.

*  gs_student-zcode = 'SSU-01'.

*  gs_student-zkname = '###'.

*  gs_student-zename = 'DONG'.

*  gs_student-zgender = 'F'.

*  gs_student-ztel = '01011112222'.

*  APPEND gs_student TO gt_student.

*

*  CLEAR : gs_student.

*

*  SORT gt_student BY ZCODE ZKNAME ZENAME ZGENDER.

*

*  LOOP AT gt_student INTO gs_student.

*    gs_student-zgname ='####'.

*

*    AT END OF zename. "zename ## ## #### ##### #### ## ##

*      gs_student-zgname ='####'.

*    ENDAT.

*

*    CLEAR : gs_student.

*  ENDLOOP.

*

*  BREAK-POINT.



************************************************************************






DATA : BEGIN OF gs_student,

  zpernr LIKE zedt07_001-zpernr,

  zcode LIKE zedt07_001-zcode,

  zkname LIKE zedt07_001-zkname,

  zename LIKE zedt07_001-zename,

  zgender LIKE zedt07_001-zgender,

  zgname TYPE c LENGTH 10,

  ztel LIKE zedt07_001-ztel,

  znum TYPE i,

  END OF gs_student.



  DATA : gt_student LIKE TABLE OF gs_student WITH NON-UNIQUE KEY zcode zkname zename zgender.



  DATA : gubun TYPE i.



  CLEAR : gs_student, gt_student.



  gs_student-zpernr = '0000000001'.

  gs_student-zcode = 'SSU-01'.

  gs_student-zkname = '###'.

  gs_student-zename = 'DONG'.

  gs_student-zgender = 'M'.

  gs_student-ztel = '01011112222'.

  APPEND gs_student TO gt_student.



  gs_student-zpernr = '0000000002'.

  gs_student-zcode = 'SSU-02'.

  gs_student-zkname = '###'.

  gs_student-zename = 'HOON'.

  gs_student-zgender = 'M'.

  gs_student-ztel = '01022223333'.

  APPEND gs_student TO gt_student.



  gs_student-zpernr = '0000000001'.

  gs_student-zcode = 'SSU-01'.

  gs_student-zkname = '###'.

  gs_student-zename = 'KANG'.

  gs_student-zgender = 'M'.

  gs_student-ztel = '01011112222'.

  APPEND gs_student TO gt_student.



  gs_student-zpernr = '0000000001'.

  gs_student-zcode = 'SSU-01'.

  gs_student-zkname = '###'.

  gs_student-zename = 'DONG'.

  gs_student-zgender = 'F'.

  gs_student-ztel = '01011112222'.

  APPEND gs_student TO gt_student.



  gs_student-zpernr = '0000000001'.

  gs_student-zcode = 'SSU-01'.

  gs_student-zkname = '###'.

  gs_student-zename = 'DONG'.

  gs_student-zgender = 'A'.

  gs_student-ztel = '01011112222'.

  APPEND gs_student TO gt_student.



  gs_student-zpernr = '0000000001'.

  gs_student-zcode = 'SSU-01'.

  gs_student-zkname = '###'.

  gs_student-zename = 'DONG'.

  gs_student-zgender = 'F'.

  gs_student-ztel = '01011112222'.

  APPEND gs_student TO gt_student.



  SORT gt_student BY ZCODE ZKNAME ZENAME.



  LOOP AT gt_student INTO gs_student.

    gs_student-zgname = '####'.

    gubun = 1.



    AT END OF zename. "zename ## ## #### ##### #### ## ##

      gubun = 2. "## ## ## # ##

      "### # #### ## ## ### modify# ## ##.

    ENDAT.



    IF gubun = 2. "C## ## ## ##

      gs_student-zgname ='####'.



    ENDIF.



    MODIFY gt_student FROM gs_student INDEX sy-tabix.

  ENDLOOP.





  WRITE :/ 'AT##'.



  SORT gt_student BY ZCODE ZKNAME ZENAME.



  LOOP AT gt_student INTO gs_student.

    WRITE :/ gs_student-zcode, gs_student-zkname, gs_student-zename, gs_student-zgname.

  ENDLOOP.



  BREAK-POINT .