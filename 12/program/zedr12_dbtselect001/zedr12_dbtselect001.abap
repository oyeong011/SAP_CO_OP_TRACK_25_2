
*&---------------------------------------------------------------------*

*& Report ZEDR12_DBTSELECT001

*&---------------------------------------------------------------------*

*&

*&---------------------------------------------------------------------*




REPORT ZEDR12_DBTSELECT001.

DATA: BEGIN OF GS_SCARR,

  CARRID LIKE SCARR-CARRID,

  CARRNAME LIKE SCARR-CARRNAME,

END OF GS_SCARR.

DATA: GT_SCARR LIKE TABLE OF GS_SCARR.



" 1. ## ### ##.




*SELECT SINGLE CARRID CARRNAME INTO ( GS_SCARR-CARRID , GS_SCARR-CARRNAME )

*  FROM SCARR

*  WHERE CARRID = 'AA'.

*

*WRITE:/ GS_SCARR-CARRID, GS_SCARR-CARRNAME.






"2. ## ### #### ###### ##.

SELECT CARRID

       CARRNAME

  FROM SCARR

  INTO TABLE GT_SCARR

  WHERE CARRID = 'AA'.



LOOP AT GT_SCARR INTO GS_SCARR.

  WRITE:/ GS_SCARR-CARRID, GS_SCARR-CARRNAME.

ENDLOOP.