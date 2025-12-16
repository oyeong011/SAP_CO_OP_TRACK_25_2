
*&---------------------------------------------------------------------*

*& Report ZEDR17_009

*&---------------------------------------------------------------------*

*&

*&---------------------------------------------------------------------*




report zedr17_009.






****************************##*************

*[Inertal Table ##]

*1. SELECT : ##

* select *(field) from source into target where ##

* 1) single line

*   select single carrname from scarr as A into l_carrname where carrid = 'AA'.

*   " from# into# ### ## ###

* 2) several lines

*   select ###1 ###2 from DB# into table gt_scarr where carrid = 'AA'.

*2. APPEND : ##

*3. INSERT : ##

*4. MODIFY : ##/##

*5. DELETE : ##



*[Database Table ##]

*1. SELECT : DB ##### ### ##

*2. APPEND : DB ##### ### ##

*3. UPDATE : DB #### # ##

*4. MODIFY ##/## ( Insert + Update)

* - update : ### # ## ## ##

* - insert : ### # ## #### ## ##

*5. DELETE : DB #### # ##



****##*******




data : begin of gs_scarr,

  carrid like scarr-carrid,

  carrname like scarr-carrname,

  end of gs_scarr.

data : gt_scarr like table of gs_scarr.




*

*" select into from

*select carrid carrname into gs_scarr

*  from scarr

*  where carrid = 'AA'.

*  write : / gs_scarr-carrid, gs_scarr-carrname.

*endselect.

*

*" select from into

*select carrid carrname

*  from scarr into  gs_scarr " from# into# ### ## ## #

*  where carrid = 'AA'.

*  write : / gs_scarr-carrid, gs_scarr-carrname.

*endselect.

*




select single a~carrid a~carrname into ( gs_scarr-carrid, gs_scarr-carrname )

  from scarr as a " from ## into# #### ok

  where carrid = 'AA'.

write : / gs_scarr-carrid, gs_scarr-carrname.




*

*" ## ## ## # itab ##

*data : begin of gs_scarr,

*  carrid like scarr-carrid,

*  carrname like scarr-carrname,

*  end of gs_scarr.

*data : gt_scarr like table of gs_scarr.

*

*select carrid carrname

*  from scarr

*  into table gt_scarr " ### ## ## # ## itab# ##

*  where carrid = 'AA'.

*loop at gt_scarr into gs_scarr.

*  write : / gs_scarr-carrid, gs_scarr-carrname.

*endloop.






" into table => #### itab# ##




*data : begin of gs_scarr,

*  zcheck type c, " type c# ## ### 1##

*  carrid like scarr-carrid,

*  carrname like scarr-carrname,

*  end of gs_scarr.

*data : gt_scarr like table of gs_scarr.

*

*select carrid carrname

*  from scarr

**  into table gt_scarr" zcheck# select## #### itab## ## ##### carrid## zcheck#### ### ## ## ###

*  into corresponding fields of table gt_scarr" ## ## ### ## ## - corresponding fields of(move corresponding# ### ##)

*  where carrid = 'AA'.

*

*  " itab# # #### ## #,into ### #### ###

*  " appending #### #### # ##

*  select carrid carrname

*  from scarr

**  into corresponding fields of table gt_scarr " #### ## ##

*  appending CORRESPONDING FIELDS OF TABLE gt_scarr

*  where carrid = 'AB'.

*

*loop at gt_scarr into gs_scarr.

*  write : / gs_scarr-carrid, gs_scarr-carrname.

*endloop.






" where ##




*data : begin of gs_scarr,

*  zcheck type c,

*  carrid like scarr-carrid,

*  carrname like scarr-carrname,

*  end of gs_scarr.

*data : gt_scarr like table of gs_scarr.



*" between A and B

*select carrid carrname

*  from scarr

*  into corresponding fields of table gt_scarr

*  where carrid between 'AA' and 'AB'.



*" string ##

*select carrid carrname

*  from scarr

*  into CORRESPONDING FIELDS OF table gt_scarr

*  where carrid like 'A%'. "A# #### ## ###



*" list value - ## ### ## ## # ####

*select carrid carrname

*  from scarr

*  into CORRESPONDING FIELDS OF table gt_scarr

*  where carrid in ( 'AA', 'AC' ).

*  " -> # ### ## ### ## ## ## ## ## ## ## #### ###

*  " -> itab #### #### range ## #### #### ##



*  ranges gr_scarr for scarr-carrid. " scarr-carrid ### ## gr_scarr## ##(ranges)## ##

*  " ## ## range ## ## # sign, option, low, high ## ### gr_scarr itab ## ##

*  " sign: I - include, E - exclude ### ## ### # ### # ##

*  " option:

*  "   eq : ##

*  "   bt : between .. and ...

*  "   cp : ## ## contain pattern

*  "   le : ### ##

*  "   ge : ### ##

*  "   ne : !=

*  "   nb : not between A and B

*  "   np : ## ## # # not (contain) pattern

*  "   gt : >

*  "   lt : <

*  clear : gr_scarr.

*

*  gr_scarr-sign = 'I'.

*  gr_scarr-option = 'CP'.

*  gr_scarr-low = '*A'.

*  append gr_scarr.

*

*  data : begin of gs_scarr.

*    include type scarr.

*    data : end of gs_scarr.

*  data : gt_scarr like table of gs_scarr.

*

*  select * from scarr

*    into corresponding fields of table gt_scarr

*    where carrid in gr_scarr. " gr_scarr# ### #### ## ##



* <range table>

*ranges gr_scarr for scarr-carrid. " scarr-carrid ### ## gr_scarr## ##(ranges)## ##

*

*data : begin of gs_scarr,

*  zcheck type c,

*  carrid like scarr-carrid,

*  carrname like scarr-carrname,

*  end of gs_scarr.

*data : gt_scarr like table of gs_scarr.

*

*gr_scarr-sign = 'I'. " include ##

*gr_scarr-option = 'EQ'.

*gr_scarr-low = 'AA'.

*append gr_scarr.

*

*gr_scarr-low = 'AC'.

*append gr_scarr.

*

*select carrid carrname

*  from scarr

*  into corresponding fields of table gt_scarr

*  where carrid in gr_scarr.

*

*loop at gt_scarr into gs_scarr.

*  write : / gs_scarr-carrid, gs_scarr-carrname.

*endloop.



* <grouping> - max, min, sum# ## #. ### #### ##

*data : begin of gs_sflight,

*         carrid type sflight-carrid,

*         connid type sflight-connid,

*         gv_sum type i,

*       end of gs_sflight.

*data : gt_sflight like table of gs_sflight.

*

*select carrid connid avg( price ) as gv_sum  " as ##

*  into corresponding FIELDS OF table gt_sflight

*  from sflight group by carrid connid.

*

*loop at gt_sflight into gs_sflight.

*  write : / gs_sflight-carrid, gs_sflight-connid, gs_sflight-gv_sum.

*endloop.



* <having> - group by# ### #### ## ##, <order by> - ##

*data : begin of gs_sflight,

*         carrid type sflight-carrid,

*         connid type sflight-connid,

*         gv_sum type i,

*       end of gs_sflight.

*data : gt_sflight like table of gs_sflight.

*

*select carrid connid avg( price ) as gv_sum  " as ##

*  into corresponding FIELDS OF table gt_sflight

*  from sflight group by carrid connid

*  having avg( price ) > 1000 " group by# ## ## ## ##

**  order by carrid.

**  order by connid descending.

*  order by gv_sum. " price### error. price### #### sort## ### #### ##

*

*loop at gt_sflight into gs_sflight.

*  write : / gs_sflight-carrid, gs_sflight-connid, gs_sflight-gv_sum.

*endloop.



* <subquery>

*data : begin of gs_sflight,

*         carrid type sflight-carrid,

*         connid type sflight-connid,

*         price  type sflight-price,

*       end of gs_sflight.

*data : gt_sflight like table of gs_sflight.

*

*select carrid connid price

*  into corresponding fields of table gt_sflight

*  from sflight as a " ## ##

*  where carrid in ( select carrid from spfli where carrid = a~carrid and connid = a~connid )

*  and carrid = 'AA'

*  and connid like '00%'.

*

*loop at gt_sflight into gs_sflight.

*  write : / gs_sflight-carrid, gs_sflight-connid, gs_sflight-price.

*endloop.



* <join>

** inner join : ###

*data : begin of gs_sflight,

*         carrid type sflight-carrid,

*         connid type sflight-connid,

*         carrname type scarr-carrname,

*       end of gs_sflight.

*data : gt_sflight like table of gs_sflight.

*

*select a~carrid a~connid b~carrname

*select a~carrid a~connid b~carrname

*  into CORRESPONDING FIELDS OF table gt_sflight

*  from sflight as a

*  inner join scarr as b

*    on a~carrid = b~carrid

*    where a~carrid = 'AA'.

*loop at gt_sflight into gs_sflight.

*  write : / gs_sflight-carrid, gs_sflight-connid, gs_sflight-carrname.

*endloop.



** outer joiin : ###

*data : begin of gs_sflight,

*         carrid type sflight-carrid,

*         connid type sflight-connid,

*         carrname type scarr-carrname,

*       end of gs_sflight.

*data : gt_sflight like table of gs_sflight.

*

*select a~carrid a~connid b~carrname

*  into CORRESPONDING FIELDS OF table gt_sflight

*  from sflight as a

*  left outer join scarr as b

*    on a~carrid = b~carrid

*    where a~carrid = 'AA'.

*loop at gt_sflight into gs_sflight.

*  write : / gs_sflight-carrid, gs_sflight-connid, gs_sflight-carrname.

*endloop.



* <for all entries>

*data : begin of gs_spfli,

*  carrid type spfli-carrid,

*  connid type spfli-connid,

*  end of gs_spfli.

*data : gt_spfli like table of gs_spfli.

*

*data : begin of gs_sflight,

*  carrid type sflight-carrid,

*  connid type sflight-connid,

*  fldate type sflight-fldate,

*  price type sflight-price,

*  end of gs_sflight.

*data : gt_sflight like table of gs_sflight.

*

*select carrid connid

*  from spfli

*  into corresponding fields of table gt_spfli

*  where carrid like 'A%'. " A# #### ## ###

*

*if gt_spfli is not initial. " ## itab1## ### 'A'## #### 0###, ### db# join## ## #### memory dumnp #####, ### if# ### #####

*  select carrid connid fldate price

*    from sflight

*    into CORRESPONDING FIELDS OF table gt_sflight

*    for all entries in gt_spfli

*    where carrid = gt_spfli-carrid

*    and connid = gt_spfli-connid.

*endif.

*

*loop at gt_sflight into gs_sflight.

*  write : / gs_sflight-carrid, gs_sflight-connid, gs_sflight-fldate, gs_sflight-price.

*endloop.