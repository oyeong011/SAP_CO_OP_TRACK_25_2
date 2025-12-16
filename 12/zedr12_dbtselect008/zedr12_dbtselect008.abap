
*&---------------------------------------------------------------------*

*& Report ZEDR12_DBTSELECT008

*&---------------------------------------------------------------------*

*&

*&---------------------------------------------------------------------*




REPORT ZEDR12_DBTSELECT008.

DATA: BEGIN OF GS_SFLIGHT,

  CARRID TYPE SFLIGHT-CARRID,

  CONNID TYPE SFLIGHT-CONNID,

  CARRNAME TYPE SCARR-CARRNAME,

  END OF GS_SFLIGHT.

DATA: GT_SFLIGHT LIKE TABLE OF GS_SFLIGHT.






*WHERE### ON### #### ### WHERE## ## ####,

*# #### #### ## ON#### #####JOIN#

*1.INNER JOIN

*SELECT A~CARRID "airline code

*       A~CONNID "FLIHGT Connection Number

*       B~CARRNAME "AIRLINE NAME

*  INTO CORRESPONDING FIELDS OF TABLE GT_SFLIGHT

*  FROM SFLIGHT AS A "TABLE ## ##

*  INNER JOIN SCARR AS B "TABLE ## ##

*  ON A~CARRID = B~CARRID

*  WHERE A~CARRID = 'AA'.

**2.OUTERJOIN




SELECT A~CARRID

       A~CONNID

       B~CARRNAME

  INTO CORRESPONDING FIELDS OF TABLE GT_SFLIGHT

  FROM SFLIGHT AS A

  LEFT OUTER JOIN SCARR AS B

  ON A~CARRID = B~CARRID

  WHERE A~CARRID = 'AA'.



  LOOP AT GT_SFLIGHT INTO GS_SFLIGHT.

    WRITE:/ GS_SFLIGHT-CARRID, GS_SFLIGHT-CONNID, GS_SFLIGHT-CARRNAME.

  ENDLOOP.