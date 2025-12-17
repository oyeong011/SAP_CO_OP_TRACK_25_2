
*&---------------------------------------------------------------------*

*& Report ZEDR018_PRACTICE002

*&---------------------------------------------------------------------*

*&

*&---------------------------------------------------------------------*




REPORT ZEDR018_PRACTICE002.



" ### ### ###

data : BEGIN OF gs_zedt001,

  zcode type zedt018_001-zcode,

  zpernr type zedt018_001-zpernr,

  zkname type zedt018_001-zkname,

  zename type zedt018_001-zename,

  zgender type zedt018_001-zgender,

  ztel type zedt018_001-ztel,

END OF gs_zedt001.



data : BEGIN OF gs_zedt002,

  zcode type zedt018_002-zcode,

  zpernr type zedt018_002-zpernr,

  zmajor type zedt018_002-zmajor,

  zmname type zedt018_002-zmname,

  zsum type zedt018_002-zsum,

  zmgubun type zedt018_002-zmgubun,

  zwaers type zedt018_002-zwaers,

END OF gs_zedt002.



data : BEGIN OF gs_zedt004,

  zcode type zedt00_004-zcode,

  zpernr type zedt00_004-zpernr,

  zschool type zedt00_004-zschool,

  zsem type zedt00_004-zsem,

  zexam type zedt00_004-zexam,

  zmajor type zedt00_004-zmajor,

  zmname type zedt00_004-zmname,

  zsum type zedt00_004-zsum,

  zwaers type zedt00_004-zwaers,

  zgrade type zedt00_004-zgrade,

  zgender type zedt018_001-zgender,

  zkname type zedt018_001-zkname,

  ztel type zedt018_001-ztel,

END OF gs_zedt004.



data : gt_zedt001 like TABLE OF gs_zedt001.

data : gt_zedt002 like TABLE OF gs_zedt002.

data : gt_zedt004 like TABLE OF gs_zedt004.



data : gv_sum_boy type i, gv_sum_girl type i.

data : gv_is_warn(10) type c, gv_major(10) type c, gv_end type c.



" ### ##.

SELECT * FROM ZEDT00_001

INTO CORRESPONDING FIELDS OF TABLE GT_ZEDT001.



SELECT * FROM ZEDT00_002

INTO CORRESPONDING FIELDS OF TABLE GT_ZEDT002.



SELECT * FROM ZEDT00_004

INTO CORRESPONDING FIELDS OF TABLE GT_ZEDT004.



BREAK-point.

sort gt_zedt001 by zcode.

sort gt_zedt002 by zcode.

sort gt_zedt004 by zcode zgrade. "## ## ### #### ### ##. -> ## ## ### ###### zsum # # ### ##.



loop at gt_zedt004 into gs_zedt004.

  at first.

    WRITE :/ '---------------------------------------------------------------------'.

    WRITE :/ '|  ####  |    ##    |  ####  |   ####    |    ##    |'.

    WRITE :/ '---------------------------------------------------------------------'.

  ENDAT.



  " zcode# ##### # ### -> continue. #### ### ###.

  READ TABLE gt_zedt001 with key zcode = gs_zedt004-zcode into gs_zedt001 BINARY SEARCH.

  if sy-subrc <> 0.

    CONTINUE.

  ENDIF.



  " #### ##

  read table gt_zedt002 with key zcode = gs_zedt004-zcode into gs_zedt002 BINARY SEARCH.

  if sy-subrc = 0.

    if gs_zedt004-zmajor <> gs_zedt002-zmajor.

      gv_major = '####'.

    ENDIF.

  ENDIF.



  at new zcode.

    clear gv_is_warn.

    clear gv_major.

    clear gv_end.

  endat.



  " #### ## ##

  if gs_zedt004-zgrade CA 'dDfF'.

    gv_is_warn = '####'.

  else.

    if gv_is_warn ne '####'.

      clear gs_zedt001-ztel.

    endif.

  endif.



  at END OF zcode.

    gv_end = 'X'.

  endat.



  if gv_end = 'X'.

    if gs_zedt001-zgender = 'M'.

      gv_sum_boy = gv_sum_boy + gs_zedt004-zsum * 100.

    elseif gs_zedt001-zgender = 'F'.

      gv_sum_girl = gv_sum_girl + gs_zedt004-zsum * 100.

    endif.

    write :/ '|', gs_zedt004-zcode(10), '|', gs_zedt001-zkname(10),'| ',  gv_major(9)  ,'|' , gs_zedt001-ztel(13) ,'|', gv_is_warn(10) ,'|'.

    WRITE :/ '---------------------------------------------------------------------'.

  endif.



  at last.

    write :/ '###### : ', gv_sum_boy .

    write :/ '###### : ', gv_sum_girl.

  ENDAT.

ENDLOOP.



" ### # ## ## ## ## -> ## ### continue. (xexam >=1 ### #. > 0 ###.

"

" ### D ## F# ###(## ## ###)  ## ##.

" ## ## ### #### #### #.

" ### ### ### #### ####.

" ### ###(gv), ### ###(gv) ####.

" ## ## ### zsum ## ## ##.

" ### #### ### ##.