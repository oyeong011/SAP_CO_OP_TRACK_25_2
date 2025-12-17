
*&---------------------------------------------------------------------*

*& Report ZEDR25_022

*&---------------------------------------------------------------------*

*&

*&---------------------------------------------------------------------*




REPORT ZEDR25_022.






*"## ##

*DATA : GV_VAR TYPE C VALUE 'A'.

*

*"#### ##

*"### # ##### ## ### ## ### ##### ### # ## #### ##

*FIELD-SYMBOLS <FS> TYPE C. "<FS> ### ##

*

*"#### ### ##### ##

*ASSIGN GV_VAR TO <FS>. "FS# GV_VAR# #

*

*"#### # ##

*<FS> = 'B'.

*

*WRITE :/ GV_VAR.

*

*DATA : GV_1 TYPE C VALUE 'A'.

*DATA : GV_2 TYPE C VALUE 'B'.

*DATA : GV_3 TYPE C VALUE 'C'.

*

*DATA : GV_FNAME(10).

*DATA : GV_INDEX TYPE N.

*

*FIELD-SYMBOLS <FA> TYPE ANY.

*

*DO 3 TIMES.

*  CLEAR GV_FNAME.

*  GV_FNAME = 'GV_'.

*  GV_INDEX = SY-INDEX.

*  CONCATENATE GV_FNAME GV_INDEX INTO GV_FNAME.

*

*  ASSIGN (GV_FNAME) TO <FA>. "#### #### ### ### #### ## # ##

*

*  WRITE :/ GV_FNAME , ':', <FA>.

*ENDDO.



*" 1) ### ##

*DATA: BEGIN OF gs_sum,

*        mon01 TYPE dmbtr VALUE '10.00',

*        mon02 TYPE dmbtr VALUE '20.00',

*        mon03 TYPE dmbtr VALUE '30.00',

*        mon04 TYPE dmbtr VALUE '40.00',

*        mon05 TYPE dmbtr VALUE '50.00',

*        mon06 TYPE dmbtr VALUE '60.00',

*      END OF gs_sum.

*

*DATA: zindex TYPE n LENGTH 2.   " -> '01' ~ '06'## 0#### ####

*DATA: zmon   TYPE c LENGTH 6.   " -> 'MON01' ## ### ## ##

*

*" 2) ## ## ##

*FIELD-SYMBOLS: <fs1> LIKE gs_sum,  " ### ### ### '### ###' FS

*               <fs2> TYPE any.     " ####(##)# #### ### '###' FS

*

*" 3) #### <fs1># ##

*ASSIGN gs_sum TO <fs1>.

*

*" 4) 6# #### 'MON01'..'MON06'# ### ## ### ## ##

*DO 6 TIMES.

*  zindex = sy-index.

*  CONCATENATE 'MON' zindex INTO zmon.

*  "###(zmon)# #### #### ## ### ####, # ### ### <fs2># ##

*  ASSIGN COMPONENT zmon OF STRUCTURE <fs1> TO <fs2>.

*  WRITE: / <fs2>.



*DATA : BEGIN OF GS_STUDENT,

*  ZCODE LIKE ZEDT25_001-ZCODE,

*  ZKNAME LIKE ZEDT25_001-ZKNAME,

*  ZENAME LIKE ZEDT25_001-ZENAME,

*  END OF GS_STUDENT.

*DATA : GT_STUDENT LIKE TABLE OF GS_STUDENT.

*DATA : GV_ZCODE(10) VALUE 'ZCODE'.

*

*SELECT * FROM ZEDT25_001 INTO CORRESPONDING FIELDS OF TABLE GT_STUDENT.

*

*FIELD-SYMBOLS <FS> TYPE ANY TABLE.

*ASSIGN GT_STUDENT TO <FS>.

*

*READ TABLE <FS> WITH KEY (GV_ZCODE) = 'SSU-01' INTO GS_STUDENT.

*

*WRITE :/ GS_STUDENT-ZCODE.

*WRITE :/ GS_STUDENT-ZKNAME.

*WRITE :/ GS_STUDENT-ZENAME.



*DATA : BEGIN OF GS_STUDENT,

*  ZCODE LIKE ZEDT25_001-ZCODE,

*  ZKNAME LIKE ZEDT25_001-ZKNAME,

*  ZENAME LIKE ZEDT25_001-ZENAME,

*  END OF GS_STUDENT.

*DATA : GT_STUDENT LIKE TABLE OF GS_STUDENT.

*DATA : GV_ZCODE(10) VALUE 'ZCODE'.

*

*SELECT * FROM ZEDT25_001 INTO CORRESPONDING FIELDS OF TABLE GT_STUDENT.

*

*FIELD-SYMBOLS <FS> TYPE ANY TABLE.

*ASSIGN GT_STUDENT TO <FS>.

*

*FIELD-SYMBOLS: <FS_GS_STUDENT> TYPE ANY.

*

*READ TABLE <FS> WITH KEY (GV_ZCODE) = 'SSU-01' ASSIGNING <FS_GS_STUDENT>.

*

*WRITE <FS_GS_STUDENT>.






DATA : BEGIN OF GS_STUDENT,

  ZCODE LIKE ZEDT25_001-ZCODE,

  ZKNAME LIKE ZEDT25_001-ZKNAME,

  ZENAME LIKE ZEDT25_001-ZENAME,

  ZMEMO(10),

  END OF GS_STUDENT.

DATA : GT_STUDENT LIKE TABLE OF GS_STUDENT.

DATA : GV_ZCODE(10) VALUE 'ZCODE'.



SELECT * FROM ZEDT25_001 INTO CORRESPONDING FIELDS OF TABLE GT_STUDENT.



LOOP AT GT_STUDENT ASSIGNING FIELD-SYMBOL(<FS_T>).

  IF <FS_T>-ZENAME = 'FANG'.

  <FS_T>-ZMEMO = '####'.

  ENDIF.

ENDLOOP.