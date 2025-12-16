
*&---------------------------------------------------------------------*

*& Report ZEDR07_009

*&---------------------------------------------------------------------*

*&

*&---------------------------------------------------------------------*




REPORT ZEDR07_009.






*DATA : BEGIN OF gs_scarr,

*  carrid LIKE scarr-carrid,

*  carrname LIKE scarr-carrname,

*  END OF gs_scarr.

*DATA : gt_scarr LIKE TABLE OF gs_scarr.



*SELECT carrid carrname INTO gs_scarr "select ~endselect ## ## ##

*  FROM scarr

*  WHERE carrid = 'AA'.

*

*  WRITE :/ gs_scarr-carrid, gs_scarr-carrname.

*ENDSELECT.



*SELECT SINGLE carrid carrname INTO ( gs_scarr-carrid, gs_scarr-carrname ) "### #### select single#

*  "# ## #####

*  FROM scarr

*  WHERE carrid = 'AA'.

*

*WRITE :/ gs_scarr-carrid, gs_scarr-carrname.



*SELECT carrid "# ## #### ### #### ## -> select ~endselect## ###

*       carrname

*  FROM scarr

*  INTO TABLE gt_scarr

*  WHERE carrid = 'AA'.

*

*  LOOP AT gt_scarr INTO gs_scarr.

*    WRITE :/ gs_scarr-carrid, gs_scarr-carrname.

*  ENDLOOP.



************************************************************************



*DATA : BEGIN OF gs_scarr,

*  zcheck type c, "# ### #### ####

*  carrid LIKE scarr-carrid,

*  carrname LIKE scarr-carrname,

*  END OF gs_scarr.

*DATA : gt_scarr LIKE TABLE OF gs_scarr.

*

*SELECT carrid

*       carrname

*  FROM scarr

*  "INTO TABLE gt_scarr

*  "### into table# ## into corresponding fields of ### ####.

*  INTO CORRESPONDING FIELDS OF TABLE gt_scarr

*  WHERE carrid = 'AA'.

*

*  SELECT carrid

*       carrname

*  FROM scarr

*  "INTO CORRESPONDING FIELDS OF TABLE gt_scarr "### # into# #### #### #### ##

*    "## #### ## #####

*    "APPENDING CORRESPONDING# ####.

*  APPENDING CORRESPONDING FIELDS OF TABLE gt_scarr

*  WHERE carrid = 'AB'.

*

*  LOOP AT gt_scarr INTO gs_scarr.

*    WRITE :/ gs_scarr-carrid, gs_scarr-carrname. "#### #### #### ### ### ## ###.

*  ENDLOOP.



************************************************************************



*DATA : BEGIN OF gs_scarr,

*  zcheck type c,

*  carrid LIKE scarr-carrid,

*  carrname LIKE scarr-carrname,

*  END OF gs_scarr.

*DATA : gt_scarr LIKE TABLE OF gs_scarr.

*

*SELECT carrid

*       carrname

*  FROM scarr

*  INTO CORRESPONDING FIELDS OF TABLE gt_scarr

**  WHERE carrid BETWEEN 'AA' AND 'AB'. "AA ## AB

**  WHERE carrid LIKE 'A%'. "A# #### ## carrid ##

*  WHERE carrid IN ( 'AA', 'AC' ). "AA ## AC

*  " -> ## ## ###### ### ##### ranges# ####.

*

*  LOOP AT gt_scarr INTO gs_scarr.

*    WRITE :/ gs_scarr-carrid, gs_scarr-carrname. "#### #### #### ### ### ## ###.

*  ENDLOOP.



************************************************************************



*RANGES : gr_scarr FOR scarr-carrid.

*

*CLEAR : gr_scarr.

*

*gr_scarr-sign = 'I'.

*gr_scarr-option = 'CP'.

*gr_scarr-low = '*A'.

*APPEND gr_scarr.

*

*DATA : BEGIN OF gs_scarr.

*  INCLUDE TYPE scarr.

*DATA : END OF gs_scarr.

*DATA : gt_scarr LIKE TABLE OF gs_scarr.

*

*SELECT * FROM scarr

*  INTO CORRESPONDING FIELDS OF TABLE gt_scarr

*  WHERE carrid IN gr_scarr.

*

*  BREAK-POINT.



************************************************************************



*RANGES : gr_scarr FOR scarr-carrid.

*

*DATA : BEGIN OF gs_scarr,

*  zcheck TYPE c,

*  carrid LIKE scarr-carrid,

*  carrname LIKE scarr-carrname,

*  END OF gs_scarr.

*DATA : gt_scarr LIKE TABLE OF gs_scarr.

*

*

*gr_scarr-sign = 'I'.

*gr_scarr-option = 'EQ'.

*gr_scarr-low = 'AA'.

*APPEND gr_scarr.

*

*gr_scarr-low = 'AC'.

*APPEND gr_scarr.

*

*SELECT carrid

*       carrname

*  FROM scarr

*  INTO CORRESPONDING FIELDS OF TABLE gt_scarr

*  WHERE carrid IN gr_scarr.

*

*LOOP AT gt_scarr INTO gs_scarr.

*  WRITE :/ gs_scarr-carrid, gs_scarr-carrname.

*ENDLOOP.



*************************************************************************

*

*DATA : BEGIN OF gs_sflight,

*  carrid TYPE sflight-carrid,

*  connid TYPE sflight-connid,

*  gv_sum TYPE i,

*  END OF gs_sflight.

*

*  DATA : gt_sflight LIKE TABLE OF gs_sflight.

*

*  SELECT carrid

*         connid

*         AVG( price ) AS gv_sum "AVG ## ## ## ##

*    INTO CORRESPONDING FIELDS OF TABLE gt_sflight

*    FROM sflight GROUP BY carrid connid

*    HAVING AVG( price ) > 1000 "## ##

*    "ORDER BY carrid. "## ##

*    "ORDER BY connid DESCENDING.

*    "ORDER BY price. "# #### ####

*    ORDER BY gv_sum. "#### ### #

*

*  LOOP AT gt_sflight INTO gs_sflight.

*    WRITE :/ gs_sflight-carrid, gs_sflight-connid, gs_sflight-gv_sum.

*  ENDLOOP.



**************************************************************************

*

*DATA : BEGIN OF gs_sflight,

*  carrid TYPE sflight-carrid,

*  connid TYPE sflight-connid,

*  price TYPE sflight-price,

*  END OF gs_sflight.

*

*  DATA : gt_sflight LIKE TABLE OF gs_sflight.

*

*  SELECT carrid

*         connid

*         price

*    INTO CORRESPONDING FIELDS OF TABLE gt_sflight

*    FROM sflight AS A "## ##

*    WHERE carrid IN ( SELECT carrid FROM spfli WHERE carrid = A~carrid "sflight~carrid# ## a~carrid

*                                                 AND connid = A~connid )

*    AND carrid = 'AA'

*    AND connid LIKE '00%'.

*

*  LOOP AT gt_sflight INTO gs_sflight.

*    WRITE :/ gs_sflight-carrid, gs_sflight-connid, gs_sflight-price.

*  ENDLOOP.



***************************************************************************

*

*DATA : BEGIN OF gs_sflight,

*  carrid TYPE sflight-carrid,

*  connid TYPE sflight-connid,

*  carrname TYPE scarr-carrname,

*  END OF gs_sflight.

*

*  DATA : gt_sflight LIKE TABLE OF gs_sflight.

*

*  SELECT a~carrid

*         a~connid

*         b~carrname

*    INTO CORRESPONDING FIELDS OF TABLE gt_sflight

*    FROM sflight AS A "## ##

*    INNER JOIN scarr AS B "###

*    ON a~carrid = b~carrid

*    WHERE a~carrid = 'AA'.

*

*  LOOP AT gt_sflight INTO gs_sflight.

*    WRITE :/ gs_sflight-carrid, gs_sflight-connid, gs_sflight-carrname.

*  ENDLOOP.



***************************************************************************






DATA : BEGIN OF gs_spfli,

  carrid TYPE spfli-carrid,

  connid TYPE spfli-connid,

  END OF gs_spfli.

DATA : gt_spfli LIKE TABLE OF gs_spfli.



DATA : BEGIN OF gs_sflight,

  carrid TYPE sflight-carrid,

  connid TYPE sflight-connid,

  fldate TYPE sflight-fldate,

  price TYPE sflight-price,

  END OF gs_sflight.

DATA : gt_sflight LIKE TABLE OF gs_sflight.



  SELECT carrid

         connid

    FROM spfli

    INTO CORRESPONDING FIELDS OF TABLE gt_spfli

    WHERE carrid LIKE 'A%'.



IF gt_spfli IS NOT INITIAL. "gt_spfi# NULL### FILLSCAN## ## ## ## MEMORY DUMP

  SELECT carrid

         connid

         fldate

         price

    FROM sflight

    INTO CORRESPONDING FIELDS OF TABLE gt_sflight

    FOR ALL ENTRIES IN gt_spfli

    WHERE carrid = gt_spfli-carrid "FOR ALL ENTRIES ### where ###

                                   "GT_SPFLI# #### ### #####

                                   "LIKE, BETWEEN, IN## ## ### # # # #.

    AND   connid = gt_spfli-connid.

ENDIF.



  LOOP AT gt_sflight INTO gs_sflight.

    WRITE :/ gs_sflight-carrid, gs_sflight-connid, gs_sflight-fldate, gs_sflight-price.

  ENDLOOP.