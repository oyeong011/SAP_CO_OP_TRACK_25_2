
*&---------------------------------------------------------------------*

*& Report ZEDR25_004

*&---------------------------------------------------------------------*

*&

*&---------------------------------------------------------------------*




REPORT ZEDR25_004.






*###

*- ### # #

*- ## ## ## # #### ## ###

*

*internal table

*- ### ## ## ## ##

*- #### #### ### ### ## x ## # + ## ####






 "#### O"



"DATA : gt_zedt25 type zedt25_001 occurs 0 with header line.



 "## ## X"

DATA : gs_zedt25 type ZEDT25_001. "### ##

DATA : gt_zedt25 type table of ZEDT25_001. "###### ##



gs_zedt25-ZCODE = 'ssu-01'.

gs_zedt25-ZPERNR = '0000000001'.

gs_zedt25-ZKNAME = '###'.

gs_zedt25-ZENAME = 'Dong'.

gs_zedt25-ZGENDER = 'M'.

gs_zedt25-ZTEL = '01027273737'.



"break-point. "## ##"



append gs_zedt25 to gt_zedt25.



gs_zedt25-ZCODE = 'ssu-02'.

gs_zedt25-ZPERNR = '0000000002'.

gs_zedt25-ZKNAME = '##'.

gs_zedt25-ZENAME = 'J'.

gs_zedt25-ZGENDER = 'F'.

gs_zedt25-ZTEL = '01027273333'.



"break-point.



append gs_zedt25 to gt_zedt25.



"##### ## ###### ##



DATA : begin of gs_student,

  ZCODE type zedt25_001-ZCODE,

  ZPERNR type zedt25_001-ZPERNR,

  ZKNAME type zedt25_001-ZKNAME,

  ZENAME type zedt25_001-ZENAME,

  ZGENDER type zedt25_001-ZGENDER,

  ZTEL type zedt25_001-ZTEL,

  ZNAME type zedt25_002-ZMNAME,

end of gs_student.



DATA : gt_student like table of gs_student.



gs_student-ZCODE = 'ssu-01'.

gs_student-ZPERNR = '0000000001'.

gs_student-ZKNAME = '###'.

gs_student-ZENAME = 'Dong'.

gs_student-ZGENDER = 'M'.

gs_student-ZTEL = '01027273737'.

gs_student-ZNAME = '####'.



append gs_student to gt_student.



"Dictionary ### ### # # TYPE ##, ## ##/### #### ### ## #(Dictionary ### ######, ## ### ### #) # LIKE ##."



" # ## ##

DATA: BEGIN OF gs_student2,

        zcode   TYPE c LENGTH 10,

        zkname  TYPE c LENGTH 10,

        zename  TYPE c LENGTH 10,

        zclass  TYPE c,

      END OF gs_student2.



DATA: BEGIN OF gs_student3,

        zcode   TYPE c LENGTH 10,

        zkname  TYPE c LENGTH 10,

        zename  TYPE c LENGTH 10,

        zclass  TYPE c,

      END OF gs_student3.



DATA: gt_student2  LIKE TABLE OF gs_student2.

DATA: gt_student3 LIKE TABLE OF gs_student2.



gs_student2-zcode  = 'SSU-01'.

gs_student2-zkname = '###'.

gs_student2-zename = 'DONG'.



gs_student3-zcode  = 'SSU-01'.

gs_student3-zkname = '###'.

gs_student3-zename = 'DONG'.



"APPEND gs_student2  TO gt_student2. "###(Work Area, Header Line)# ## # ## #### Internal Table Body ## ##

" break-point.

"APPEND gs_student3 TO gt_student3. "

" break-point.



"move gs_student2 to gs_student3. "head copy -> ### 1# ## ##

" break-point.

"MOVE gs_student2 TO gs_student3. "body copy -> ## ### ## ##

" break-point.



" move-corresponding gt_student2 to gt_student3



DATA: BEGIN OF gt_student4 occurs 0, " OCCURS 0: #### ### # ##, ### APPEND # # #### ###.

        zcode   TYPE c LENGTH 10,

        zkname  TYPE c LENGTH 10,

        zename  TYPE c LENGTH 10,

        zclass  TYPE c,

      END OF gt_student4.



gt_student4-zcode  = 'SSU-04'.

gt_student4-zkname = '#'.

gt_student4-zename = 'MO'.



append gt_student4.

"break-point.



"clear : gt_student4. "### ###

" break-point.



"clear : gt_student4[]. "### ###

"break-point.



"refresh : gt_student4. "Internal Table# ###(Body)# ##, ### ### ### ## # ## APPEND ## ## ## ##.

"free : gt_student4. " Internal Table# ### ## + #### ##, ## ### ### ### ## ##.