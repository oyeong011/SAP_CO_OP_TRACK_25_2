
*&---------------------------------------------------------------------*

*& Report ZEDR04_030

*&---------------------------------------------------------------------*

*&

*&---------------------------------------------------------------------*




REPORT ZEDR04_030.



" ##### ##. INTO WA ## ##



TABLES ZEDT04_001.



SELECT SINGLE * FROM ZEDT04_001.



WRITE / ZEDT04_001-ZCODE.

WRITE / ZEDT04_001-ZKNAME.

WRITE / ZEDT04_001-ZENAME.

WRITE / ZEDT04_001-ZGENDER.

WRITE / ZEDT04_001-ZTEL.



"""""""

" ##2



TABLES SCARR.



SELECT * FROM SCARR.

  WRITE : / SCARR-CARRID, SCARR-CARRNAME.

ENDSELECT.