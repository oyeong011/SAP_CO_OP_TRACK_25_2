
*&---------------------------------------------------------------------*

*& Report ZEDR04_063

*&---------------------------------------------------------------------*

*&

*&---------------------------------------------------------------------*




REPORT ZEDR04_063.



DATA : BEGIN OF GS_SFLIGHT,   " SAP FLIGHT (###)

  CARRID TYPE SFLIGHT-CARRID,

  CONNID TYPE SFLIGHT-CONNID, " FLIGHT CONNECTION NUMBER

  GV_SUM TYPE I,

  END OF GS_SFLIGHT.

DATA GT_SFLIGHT LIKE TABLE OF GS_SFLIGHT.



" GROUP BY, HAVING, ORDER BY ##

SELECT  CARRID

        CONNID

        AVG( PRICE ) AS GV_SUM

  INTO CORRESPONDING FIELDS OF TABLE GT_SFLIGHT

  FROM SFLIGHT

  GROUP BY CARRID CONNID

  HAVING AVG( PRICE ) >= 1000  " GV_SUM ## ##

  ORDER BY GV_SUM DESCENDING.



LOOP AT GT_SFLIGHT INTO GS_SFLIGHT.

  WRITE : / GS_SFLIGHT-CARRID, GS_SFLIGHT-CONNID, GS_SFLIGHT-GV_SUM.

ENDLOOP.