
*&---------------------------------------------------------------------*

*& Report ZEDR25_006

*&---------------------------------------------------------------------*

*&

*&---------------------------------------------------------------------*




REPORT ZEDR25_006.








*DATA : BEGIN OF gs_student,

*         zpernr  LIKE zedt25_001-zpernr,

*         zcode   LIKE zedt25_001-zcode,

*         zkname  LIKE zedt25_001-zkname,

*         zename  LIKE zedt25_001-zename,

*         zgender LIKE zedt25_001-zgender,

*         zgname  TYPE c LENGTH 4,

*         ztel    LIKE zedt25_001-ztel,

*       END OF gs_student.

*

*DATA : gt_student LIKE TABLE OF gs_student.

*

*" #### ##### ###

*CLEAR : gs_student, gt_student.

*

*" ## 1

*gs_student-zpernr  = '0000000001'.

*gs_student-zcode   = 'SSU-01'.

*gs_student-zkname  = '###'.

*gs_student-zename  = 'DONG'.

*gs_student-zgender = 'M'.

*gs_student-ztel    = '01011112222'.

*APPEND gs_student TO gt_student.

*

*" ## 2

*CLEAR gs_student.

*gs_student-zpernr  = '0000000002'.

*gs_student-zcode   = 'SSU-02'.

*gs_student-zkname  = '###'.

*gs_student-zename  = 'HOON'.

*gs_student-zgender = 'M'.

*gs_student-ztel    = '01022223333'.

*APPEND gs_student TO gt_student.

*

*" ## 3

*CLEAR gs_student.

*gs_student-zpernr  = '0000000003'.

*gs_student-zcode   = 'SSU-03'.

*gs_student-zkname  = '###'.

*gs_student-zename  = 'SON'.

*gs_student-zgender = 'F'.

*gs_student-ztel    = '01033334444'.

*APPEND gs_student TO gt_student.

*

*" ### #### ### ###

*

*gs_student-zename = 'KANG'.

*gs_student-zgender = 'M'.

*

*" table key# ### # ### ### # ##

*MODIFY TABLE gt_student FROM gs_student TRANSPORTING zgender.






" LOOP ### ##(ZGENDER)# ## ###(ZGNAME) ##

" ### EX. F# ##- LOOP AT INTO GS_STUDENT WHERE ZGUBUN = 'F'.

" WHERE## ## ### # #### ## LOOP ## IF## #### #




*LOOP AT gt_student INTO gs_student.

*  IF gs_student-zgender = 'M'.

*    gs_student-zgname = '##'.

*  ELSEIF gs_student-zgender = 'F'.

*    gs_student-zgname = '##'.

*  ELSE.

*    gs_student-zgname = '##'.

*  ENDIF.

*

*" ### ## gs_student## ## ## ### gt_student# ##

*

*  " where### ### #### ##

*  MODIFY gt_student FROM gs_student TRANSPORTING zgname

*  WHERE zcode = gs_student-zcode.

*

*  " # ### ##

*  "MODIFY gt_studENt from gs_student INDEX SY-TABIX.

*

*  CLEAR : GS_STUDENT.

*ENDLOOP.






" LOOP INDEX##




*LOOP AT gt_student INTO gs_student FROM 2 TO 3.

*  IF gs_student-zgender = 'M'.

*    gs_student-zgname = '##'.

*  ELSEIF gs_student-zgender = 'F'.

*    gs_student-zgname = '##'.

*  ELSE.

*    gs_student-zgname = '##'.

*  ENDIF.

*  " BREAK-POINT.

*  CLEAR : GS_STUDENT.

*ENDLOOP.






" BREAK-POINT.



" delete




*LOOP AT gt_student INTO gs_student.

*  IF gs_student-zgender NE 'M'.

*    DELETE TABLE gt_student FROM gs_student.

*  IF SY-SUBRC = 0.

*  ELSE.

*     WRITE : / '####'.

*  ENDIF.

*  ELSE.

*    WRITE :/ gs_student-zcode , gs_student-zkname, gs_student-zgender.

*  ENDIF.

*  ENDLOOP.










DATA : BEGIN OF gs_student,

         zpernr  LIKE zedt25_001-zpernr,

         zcode   LIKE zedt25_001-zcode,

         zkname  LIKE zedt25_001-zkname,

         zename  LIKE zedt25_001-zename,

         zgender LIKE zedt25_001-zgender,

         zgname  TYPE c LENGTH 4,

         ztel    LIKE zedt25_001-ztel,

       END OF gs_student.



" table key # ### ##

"DATA : gt_student LIKE TABLE OF gs_student WITH NON-UNIQUE KEY zgender.



DATA : gt_student LIKE TABLE OF gs_student.



" #### ##### ###

CLEAR : gs_student, gt_student.



" ## 1

gs_student-zpernr  = '0000000001'.

gs_student-zcode   = 'SSU-01'.

gs_student-zkname  = '###'.

gs_student-zename  = 'DONG'.

gs_student-zgender = 'M'.

gs_student-ztel    = '01011112222'.

APPEND gs_student TO gt_student.



gs_student-zpernr  = '0000000001'.

gs_student-zcode   = 'SSU-01'.

gs_student-zkname  = '###'.

gs_student-zename  = 'DONG'.

gs_student-zgender = 'M'.

gs_student-ztel    = '01011112222'.

APPEND gs_student TO gt_student.



" ## 2




*CLEAR gs_student.

*gs_student-zpernr  = '0000000002'.

*gs_student-zcode   = 'SSU-02'.

*gs_student-zkname  = '###'.

*gs_student-zename  = 'HOON'.

*gs_student-zgender = 'M'.

*gs_student-ztel    = '01022223333'.

*APPEND gs_student TO gt_student.






" ## 3

CLEAR gs_student.

gs_student-zpernr  = '0000000003'.

gs_student-zcode   = 'SSU-03'.

gs_student-zkname  = '###'.

gs_student-zename  = 'SON'.

gs_student-zgender = 'F'.

gs_student-ztel    = '01033334444'.

APPEND gs_student TO gt_student.



" # ## #### ## ## ## ##

"DELETE TABLE gt_student WITH TABLE KEY zgender = 'F'.



"where## #### ##

"delete gt_student where zgender = 'F'.



"index# ### ## ##

" delete gt_student index 2.



"index 2~3 ##

"delete gt_student FROM 2 to 3.



" ## ##

"DELETE gt_student from 2.



"### ## # #### ## (# ### ## ##, # ## x)

" DELETE ADJACENT DUPLICATES FROM gt_student.



"### ## ##### ### ##

DELETE ADJACENT DUPLICATES FROM gt_student COMPARING zcode.



IF SY-SUBRC = 0. "## 0## ##### ##

  LOOP AT gt_student INTO gs_student.

     WRITE :/ gs_student-zcode , gs_student-zkname, gs_student-zgender.

  ENDLOOP.

ENDIF.