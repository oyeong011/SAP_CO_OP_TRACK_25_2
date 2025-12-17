
*&---------------------------------------------------------------------*

*& Report ZEDR12_DBTSELECT006

*&---------------------------------------------------------------------*

*&

*&---------------------------------------------------------------------*




REPORT ZEDR12_DBTSELECT006.

DATA: BEGIN OF GS_SFLIGHT,

  CARRID TYPE SFLIGHT-CARRID,

  CONNID TYPE SFLIGHT-CONNID,

  GV_SUM TYPE I,

  END OF GS_SFLIGHT.

DATA: GT_SFLIGHT LIKE TABLE OF GS_SFLIGHT.



SELECT CARRID "airline code

       CONNID "Airline Connection Number

       AVG( PRICE ) AS GV_SUM "Airfare

  INTO CORRESPONDING FIELDS OF TABLE GT_SFLIGHT

  FROM SFLIGHT GROUP BY CARRID CONNID

  HAVING AVG( PRICE ) > 1000

  ORDER BY GV_SUM DESCENDING.



  LOOP AT GT_SFLIGHT INTO GS_SFLIGHT.

    WRITE:/ GS_SFLIGHT-CARRID, GS_SFLIGHT-CONNID, GS_SFLIGHT-GV_SUM.

  ENDLOOP.