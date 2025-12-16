
*&---------------------------------------------------------------------*

*& Report ZEDR04_064

*&---------------------------------------------------------------------*

*&

*&---------------------------------------------------------------------*




REPORT ZEDR04_064.



DATA : BEGIN OF GS_SFLIGHT,

  CARRID TYPE SFLIGHT-CARRID,

  CONNID TYPE SFLIGHT-CONNID,

  PRICE TYPE SFLIGHT-PRICE,

  END OF GS_SFLIGHT.

DATA GT_SFLIGHT LIKE TABLE OF GS_SFLIGHT.



SELECT CARRID CONNID PRICE

  INTO CORRESPONDING FIELDS OF TABLE GT_SFLIGHT

  FROM SFLIGHT AS A

  WHERE CARRID IN ( SELECT CARRID

                      FROM SPFLI                  " FLIGHT SCHEDULE

                      WHERE CARRID = A~CARRID     " ### ~ ?

                      AND CONNID = A~CONNID )

  AND CARRID = 'AA'

  AND CONNID LIKE '00%'.



LOOP AT GT_SFLIGHT INTO GS_SFLIGHT.

  WRITE : / GS_SFLIGHT-CARRID, GS_SFLIGHT-CONNID, GS_SFLIGHT-PRICE.

ENDLOOP.