
*&---------------------------------------------------------------------*

*& Report ZEDR12_DBTSELECT002

*&---------------------------------------------------------------------*

*&

*&---------------------------------------------------------------------*




REPORT ZEDR12_DBTSELECT002.

DATA: BEGIN OF GS_SCARR,

  ZCHECK TYPE C,

  CARRID LIKE SCARR-CARRID,

  CARRNAME LIKE SCARR-CARRNAME,

END OF GS_SCARR.

DATA: GT_SCARR LIKE TABLE OF GS_SCARR.



"2. ## ### #### ###### ##.




*SELECT CARRID

*       CARRNAME

*  FROM SCARR

*  INTO TABLE GT_SCARR

*  WHERE CARRID = 'AA'.  #### ### ###. ZCHECK# ## ## ### ###. MOVECORRESPONDING### ##.






SELECT CARRID "AIRLINE CODE

       CARRNAME "AIRLINE NAME

  FROM SCARR

  INTO CORRESPONDING FIELDS OF TABLE GT_SCARR

  WHERE CARRID = 'AA'.



LOOP AT GT_SCARR INTO GS_SCARR.

  WRITE:/ GS_SCARR-CARRID, GS_SCARR-CARRNAME.

ENDLOOP.