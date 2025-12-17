
*&---------------------------------------------------------------------*

*& Report ZEDR018_010

*&---------------------------------------------------------------------*

*&

*&---------------------------------------------------------------------*




REPORT ZEDR018_010.



data : BEGIN OF gs_sflight,

  carrid type sflight-carrid,

  connid type sflight-connid,

  price type sflight-price,

  end of gs_sflight.

data : gt_sflight like TABLE OF gs_sflight.



select carrid connid price

into corresponding fields of table gt_sflight

from sflight

  WHERE carrid in ( select carrid from spfli where carrid = sflight~carrid and connid = sflight~connid )

  and carrid = 'AA'

  and connid like '00%'.



loop at gt_sflight into gs_sflight.

  write :/ gs_sflight-carrid, gs_sflight-connid, gs_sflight-price.

endloop.