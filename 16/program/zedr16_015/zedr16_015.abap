
*&---------------------------------------------------------------------*

*& Report ZEDR16_015

*&---------------------------------------------------------------------*

*&

*&---------------------------------------------------------------------*




REPORT zedr16_015.





" p.9






*DATA : BEGIN OF gs_scarr,

*         carrid   LIKE scarr-carrid,

*         carrname LIKE scarr-carrname,

*       END OF gs_scarr.

*DATA : gt_scarr LIKE TABLE OF gs_scarr.

*

*SELECT carrid carrname INTO gs_scarr

*  FROM scarr

*  WHERE carrid = 'AA'.

*

*  WRITE :/ gs_scarr-carrid, gs_scarr-carrname.

*ENDSELECT.








" p.10




*DATA : BEGIN OF gs_scarr,

*         carrid   LIKE scarr-carrid,

*         carrname LIKE scarr-carrname,

*       END OF gs_scarr.

*DATA : gt_scarr LIKE TABLE OF gs_scarr.

*

*SELECT SINGLE carrid carrname INTO ( gs_scarr-carrid, gs_scarr-carrname )

*  FROM scarr

*  WHERE carrid = 'AA'.

*

*WRITE :/ gs_scarr-carrid, gs_scarr-carrname.








" p.12




*DATA : BEGIN OF gs_scarr,

*         carrid   LIKE scarr-carrid,

*         carrname LIKE scarr-carrname,

*       END OF gs_scarr.

*DATA : gt_scarr LIKE TABLE OF gs_scarr.

*

*SELECT carrid

*  carrname

*  FROM scarr

*  INTO TABLE gt_scarr

*  WHERE carrid = 'AA'.

*WRITE :/ gs_scarr-carrid, gs_scarr-carrname.

*

*LOOP AT gt_scarr INTO gs_scarr.

*  WRITE :/ gs_scarr-carrid, gs_scarr-carrname.

*ENDLOOP.








" p.13




*DATA : BEGIN OF gs_scarr,

*         zcheck   TYPE c,

*         carrid   LIKE scarr-carrid,

*         carrname LIKE scarr-carrname,

*       END OF gs_scarr.

*DATA : gt_scarr LIKE TABLE OF gs_scarr.

*

*SELECT carrid

*  carrname

*  FROM scarr

*  INTO TABLE gt_scarr

*  WHERE carrid = 'AA'.

*

*LOOP AT gt_scarr INTO gs_scarr.

*  WRITE :/ gs_scarr-carrid, gs_scarr-carrname.

*ENDLOOP.

*






" p.15




*DATA : BEGIN OF gs_scarr,

*         zcheck   TYPE c,

*         carrid   LIKE scarr-carrid,

*         carrname LIKE scarr-carrname,

*       END OF gs_scarr.

*DATA : gt_scarr LIKE TABLE OF gs_scarr.

*

*SELECT carrid

*  carrname

*  FROM scarr

*  INTO CORRESPONDING FIELDS OF TABLE gt_scarr

*  WHERE carrid = 'AA'.

*

*LOOP AT gt_scarr INTO gs_scarr.

*  WRITE :/ gs_scarr-carrid, gs_scarr-carrname.

*ENDLOOP.








" p.17




*DATA : BEGIN OF gs_scarr,

*         zcheck   TYPE c,

*         carrid   LIKE scarr-carrid,

*         carrname LIKE scarr-carrname,

*       END OF gs_scarr.

*DATA : gt_scarr LIKE TABLE OF gs_scarr.

*

*SELECT carrid

*  carrname

*  FROM scarr

*  INTO CORRESPONDING FIELDS OF TABLE gt_scarr

*  WHERE carrid = 'AA'.

*

*SELECT carrid

*  carrname

*  FROM scarr

*  INTO CORRESPONDING FIELDS OF TABLE gt_scarr

*  WHERE carrid = 'AB'.

*

*LOOP AT gt_scarr INTO gs_scarr.

*  WRITE :/ gs_scarr-carrid, gs_scarr-carrname.

*ENDLOOP.








" p.18




*DATA : BEGIN OF gs_scarr,

*         zcheck   TYPE c,

*         carrid   LIKE scarr-carrid,

*         carrname LIKE scarr-carrname,

*       END OF gs_scarr.

*DATA : gt_scarr LIKE TABLE OF gs_scarr.

*

*SELECT carrid

*  carrname

*  FROM scarr

*  INTO CORRESPONDING FIELDS OF TABLE gt_scarr

*  WHERE carrid = 'AA'.

*

*SELECT carrid

*  carrname

*  FROM scarr

*  APPENDING CORRESPONDING FIELDS OF TABLE gt_scarr

*  WHERE carrid = 'AB'.

*

*LOOP AT gt_scarr INTO gs_scarr.

*  WRITE :/ gs_scarr-carrid, gs_scarr-carrname.

*ENDLOOP.








" p.22




*DATA : BEGIN OF gs_scarr,

*         zcheck   TYPE c,

*         carrid   LIKE scarr-carrid,

*         carrname LIKE scarr-carrname,

*       END OF gs_scarr.

*DATA : gt_scarr LIKE TABLE OF gs_scarr.

*

*SELECT carrid

*  carrname

*  FROM scarr

*  INTO CORRESPONDING FIELDS OF TABLE gt_scarr

*  WHERE carrid BETWEEN 'AA' AND 'AB'.

*

*LOOP AT gt_scarr INTO gs_scarr.

*  WRITE :/ gs_scarr-carrid, gs_scarr-carrname.

*ENDLOOP.








" p.24




*DATA : BEGIN OF gs_scarr,

*         zcheck   TYPE c,

*         carrid   LIKE scarr-carrid,

*         carrname LIKE scarr-carrname,

*       END OF gs_scarr.

*DATA : gt_scarr LIKE TABLE OF gs_scarr.

*

*SELECT carrid

*  carrname

*  FROM scarr

*  INTO CORRESPONDING FIELDS OF TABLE gt_scarr

*  WHERE carrid LIKE 'A%'.

*

*LOOP AT gt_scarr INTO gs_scarr.

*  WRITE :/ gs_scarr-carrid, gs_scarr-carrname.

*ENDLOOP.








" p.26




*DATA : BEGIN OF gs_scarr,

*         zcheck   TYPE c,

*         carrid   LIKE scarr-carrid,

*         carrname LIKE scarr-carrname,

*       END OF gs_scarr.

*DATA : gt_scarr LIKE TABLE OF gs_scarr.

*

*SELECT carrid

*  carrname

*  FROM scarr

*  INTO CORRESPONDING FIELDS OF TABLE gt_scarr

*  WHERE carrid IN ( 'AA', 'AC' ).

*

*LOOP AT gt_scarr INTO gs_scarr.

*  WRITE :/ gs_scarr-carrid, gs_scarr-carrname.

*ENDLOOP.








" p.33




*RANGES : gr_scarr FOR scarr-carrid.

*

*CLEAR : gr_scarr.

*

*gr_scarr-sign = 'I'.

*gr_scarr-option = 'CP'.

*gr_scarr-low = '*A'.

*APPEND gr_scarr.

*

*

*DATA : BEGIN OF gs_scarr.

*    INCLUDE TYPE scarr.

*DATA : END OF gs_scarr.

*DATA : gt_scarr LIKE TABLE OF gs_scarr.

*

*SELECT * FROM scarr

*  INTO CORRESPONDING FIELDS OF TABLE gt_scarr

*  WHERE carrid IN gr_scarr.

*

*LOOP AT gt_scarr INTO gs_scarr.

*  WRITE :/ gs_scarr-carrid, gs_scarr-carrname.

*ENDLOOP.








" p.37




*RANGES : gr_scarr FOR scarr-carrid.

*

*DATA : BEGIN OF gs_scarr,

*         zcheck   TYPE c,

*         carrid   LIKE scarr-carrid,

*         carrname LIKE scarr-carrname,

*       END OF gs_scarr.

*DATA : gt_scarr LIKE TABLE OF gs_scarr.

*

*CLEAR : gr_scarr.

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

*  carrname

*  FROM scarr

*  INTO CORRESPONDING FIELDS OF TABLE gt_scarr

*  WHERE carrid IN gr_scarr.

*

*LOOP AT gt_scarr INTO gs_scarr.

*  WRITE :/ gs_scarr-carrid, gs_scarr-carrname.

*ENDLOOP.








" p.39




*DATA : BEGIN OF gs_sflight,

*         carrid TYPE sflight-carrid,

*         connid TYPE sflight-connid,

*         gv_sum TYPE i,

*       END OF gs_sflight.

*DATA : gt_sflight LIKE TABLE OF gs_sflight.

*

*SELECT carrid

*  connid

*  AVG( price ) AS gv_sum

*  INTO CORRESPONDING FIELDS OF TABLE gt_sflight

*  FROM sflight GROUP BY carrid connid.

*

*LOOP AT gt_sflight INTO gs_sflight.

*  WRITE :/ gs_sflight-carrid, gs_sflight-connid, gs_sflight-gv_sum.

*ENDLOOP.








" p.41




*DATA : BEGIN OF gs_sflight,

*         carrid TYPE sflight-carrid,

*         connid TYPE sflight-connid,

*         gv_sum TYPE i,

*       END OF gs_sflight.

*DATA : gt_sflight LIKE TABLE OF gs_sflight.

*

*SELECT carrid

*  connid

*  AVG( price ) AS gv_sum

*  INTO CORRESPONDING FIELDS OF TABLE gt_sflight

*  FROM sflight GROUP BY carrid connid

*  HAVING AVG( price ) > 1000.

*

*LOOP AT gt_sflight INTO gs_sflight.

*  WRITE :/ gs_sflight-carrid, gs_sflight-connid, gs_sflight-gv_sum.

*ENDLOOP.








" p.43




*DATA : BEGIN OF gs_sflight,

*         carrid TYPE sflight-carrid,

*         connid TYPE sflight-connid,

*         gv_sum TYPE i,

*       END OF gs_sflight.

*DATA : gt_sflight LIKE TABLE OF gs_sflight.

*

*SELECT carrid

*  connid

*  AVG( price ) AS gv_sum

*  INTO CORRESPONDING FIELDS OF TABLE gt_sflight

*  FROM sflight GROUP BY carrid connid

*  HAVING AVG( price ) > 1000

*  ORDER BY carrid.

*

*LOOP AT gt_sflight INTO gs_sflight.

*  WRITE :/ gs_sflight-carrid, gs_sflight-connid, gs_sflight-gv_sum.

*ENDLOOP.








" p.44




*DATA : BEGIN OF gs_sflight,

*         carrid TYPE sflight-carrid,

*         connid TYPE sflight-connid,

*         gv_sum TYPE i,

*       END OF gs_sflight.

*DATA : gt_sflight LIKE TABLE OF gs_sflight.

*

*SELECT carrid

*  connid

*  AVG( price ) AS gv_sum

*  INTO CORRESPONDING FIELDS OF TABLE gt_sflight

*  FROM sflight GROUP BY carrid connid

*  HAVING AVG( price ) > 1000

*  ORDER BY connid DESCENDING.

*

*LOOP AT gt_sflight INTO gs_sflight.

*  WRITE :/ gs_sflight-carrid, gs_sflight-connid, gs_sflight-gv_sum.

*ENDLOOP.








" p.46




*DATA : BEGIN OF gs_sflight,

*         carrid TYPE sflight-carrid,

*         connid TYPE sflight-connid,

*         gv_sum TYPE i,

*       END OF gs_sflight.

*DATA : gt_sflight LIKE TABLE OF gs_sflight.

*

*SELECT carrid

*  connid

*  AVG( price ) AS gv_sum

*  INTO CORRESPONDING FIELDS OF TABLE gt_sflight

*  FROM sflight GROUP BY carrid connid

*  HAVING AVG( price ) > 1000

*  ORDER BY gv_sum.

*

*LOOP AT gt_sflight INTO gs_sflight.

*  WRITE :/ gs_sflight-carrid, gs_sflight-connid, gs_sflight-gv_sum.

*ENDLOOP.








" p.48




*DATA : BEGIN OF gs_sflight,

*         carrid TYPE sflight-carrid,

*         connid TYPE sflight-connid,

*         price  TYPE sflight-price,

*       END OF gs_sflight.

*DATA : gt_sflight LIKE TABLE OF gs_sflight.

*

*SELECT carrid

*  connid

*  price

*  INTO CORRESPONDING FIELDS OF TABLE gt_sflight

*  FROM sflight

*  WHERE carrid IN ( SELECT carrid

*                      FROM spfli

*                      WHERE carrid = sflight~carrid

*                        AND connid = sflight~connid )

*  AND carrid = 'AA'

*  AND connid LIKE '00%'.

*

*

*LOOP AT gt_sflight INTO gs_sflight.

*  WRITE :/ gs_sflight-carrid, gs_sflight-connid, gs_sflight-price.

*ENDLOOP.








" p.49




*DATA : BEGIN OF gs_sflight,

*         carrid TYPE sflight-carrid,

*         connid TYPE sflight-connid,

*         price  TYPE sflight-price,

*       END OF gs_sflight.

*DATA : gt_sflight LIKE TABLE OF gs_sflight.

*

*SELECT carrid

*  connid

*  price

*  INTO CORRESPONDING FIELDS OF TABLE gt_sflight

*  FROM sflight AS a

*  WHERE carrid IN ( SELECT carrid

*                      FROM spfli

*                      WHERE carrid = a~carrid

*                        AND connid = a~connid )

*  AND carrid = 'AA'

*  AND connid LIKE '00%'.

*

*

*LOOP AT gt_sflight INTO gs_sflight.

*  WRITE :/ gs_sflight-carrid, gs_sflight-connid, gs_sflight-price.

*ENDLOOP.








" p.54




*DATA : BEGIN OF gs_sflight,

*         carrid   TYPE sflight-carrid,

*         connid   TYPE sflight-connid,

*         carrname TYPE scarr-carrname,

*       END OF gs_sflight.

*DATA : gt_sflight LIKE TABLE OF gs_sflight.

*

*SELECT a~carrid

*       a~connid

*       b~carrname

*  INTO CORRESPONDING FIELDS OF TABLE gt_sflight

*  FROM sflight AS a

*  INNER JOIN scarr AS b

*  ON a~carrid = b~carrid

*  WHERE a~carrid = 'AA'.

*

*LOOP AT gt_sflight INTO gs_sflight.

*  WRITE :/ gs_sflight-carrid, gs_sflight-connid, gs_sflight-carrname.

*ENDLOOP.








" p.55




*DATA : BEGIN OF gs_sflight,

*         carrid   TYPE sflight-carrid,

*         connid   TYPE sflight-connid,

*         carrname TYPE scarr-carrname,

*       END OF gs_sflight.

*DATA : gt_sflight LIKE TABLE OF gs_sflight.

*

*SELECT a~carrid

*       a~connid

*       b~carrname

*  INTO CORRESPONDING FIELDS OF TABLE gt_sflight

*  FROM sflight AS a

*  LEFT OUTER JOIN scarr AS b

*  ON a~carrid = b~carrid

*  WHERE a~carrid = 'AA'.

*

*LOOP AT gt_sflight INTO gs_sflight.

*  WRITE :/ gs_sflight-carrid, gs_sflight-connid, gs_sflight-carrname.

*ENDLOOP.








" p. 57




*

*DATA : BEGIN OF gs_spfli,

*         carrid TYPE spfli-carrid,

*         connid TYPE spfli-connid,

*       END OF gs_spfli.

*DATA : gt_spfli LIKE TABLE OF gs_spfli.

*

*DATA : BEGIN OF gs_sflight,

*         carrid TYPE sflight-carrid,

*         connid TYPE sflight-connid,

*         fldate TYPE sflight-fldate,

*         price  TYPE sflight-price,

*       END OF gs_sflight.

*DATA : gt_sflight LIKE TABLE OF gs_sflight.

*

*SELECT carrid

*       connid

*  fldate

*  price

*FROM sflight

*INTO CORRESPONDING FIELDS OF TABLE gt_sflight

*  FOR ALL ENTRIES IN gt_spfli

*  WHERE carrid = gt_spfli-carrid

*  AND connid = gt_spfli-connid.

*

*LOOP AT gt_sflight INTO gs_sflight.

*  WRITE :/ gs_sflight-carrid, gs_sflight-connid, gs_sflight-fldate, gs_sflight-price.

*ENDLOOP.








" p. 59



DATA : BEGIN OF gs_spfli,

         carrid TYPE spfli-carrid,

         connid TYPE spfli-connid,

       END OF gs_spfli.

DATA : gt_spfli LIKE TABLE OF gs_spfli.



DATA : BEGIN OF gs_sflight,

         carrid TYPE sflight-carrid,

         connid TYPE sflight-connid,

         fldate TYPE sflight-fldate,

         price  TYPE sflight-price,

       END OF gs_sflight.

DATA : gt_sflight LIKE TABLE OF gs_sflight.



SELECT carrid

  connid

  FROM spfli

  INTO CORRESPONDING FIELDS OF TABLE gt_spfli

  WHERE carrid LIKE 'A%'.



IF gt_spfli IS NOT INITIAL.

  SELECT carrid

         connid

    fldate

    price

  FROM sflight

  INTO CORRESPONDING FIELDS OF TABLE gt_sflight

    FOR ALL ENTRIES IN gt_spfli

    WHERE carrid = gt_spfli-carrid

    AND connid = gt_spfli-connid.

ENDIF.



LOOP AT gt_sflight INTO gs_sflight.

  WRITE :/ gs_sflight-carrid, gs_sflight-connid, gs_sflight-fldate, gs_sflight-price.

ENDLOOP.