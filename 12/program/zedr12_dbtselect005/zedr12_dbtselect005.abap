
*&---------------------------------------------------------------------*

*& Report ZEDR12_DBTSELECT005

*&---------------------------------------------------------------------*

*&

*&---------------------------------------------------------------------*




REPORT ZEDR12_DBTSELECT005.

DATA: BEGIN OF GS_SCARR,

  ZCHECK TYPE C,

  CARRID LIKE SCARR-CARRID,

  CARRNAME LIKE SCARR-CARRNAME,

  END OF GS_SCARR.

DATA: GT_SCARR LIKE TABLE OF GS_SCARR.



"1. RANGES ## ## ## # # ##.

RANGES GR_SCARR FOR SCARR-CARRID.

CLEAR: GR_SCARR.




*DATA: BEGIN OF GR_SCARR OCCURS 0,

*  SIGN TYPE DDSIGN, ####################: [I : INCLUDE (##), E : EXCLUDE(##) ####]

*  OPTION TYPE DDOPTION, ############

*  LOW LIKE SCARR-CARRID,

*  HIGH LIKE SCARR-CARRID,

*  END OF GR_SCARR.






GR_SCARR-SIGN = 'I'.

GR_SCARR-OPTION = 'EQ'.

GR_SCARR-LOW = 'AA'.   " *A / A* / *B / C*

APPEND GR_SCARR.



GR_SCARR-LOW = 'AC'.

APPEND GR_SCARR.



SELECT * FROM SCARR

  APPENDING CORRESPONDING FIELDS OF TABLE GT_SCARR

  WHERE CARRID IN GR_SCARR.



LOOP AT GT_SCARR INTO GS_SCARR.

  WRITE:/ GS_SCARR-CARRID, GS_SCARR-CARRNAME.

ENDLOOP.