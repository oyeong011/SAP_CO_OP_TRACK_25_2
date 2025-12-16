
*&---------------------------------------------------------------------*

*& Report ZEDR04_073

*&---------------------------------------------------------------------*

*&

*&---------------------------------------------------------------------*




REPORT ZEDR04_073.



DATA GS_STUDENT TYPE ZEDT04_002.

DATA : BEGIN OF GS_WRITE,

  ZMGNAME TYPE ZMGNAME04, " ####

  ZMNAME TYPE ZMNAME04,   " ###

  END OF GS_WRITE.



SELECT SINGLE * FROM ZEDT04_002

  INTO GS_STUDENT.



" IF# ##

IF GS_STUDENT-ZMGUBUN = 'A'.

  GS_WRITE-ZMGNAME = '###'.

ELSEIF GS_STUDENT-ZMGUBUN = 'A'.

  GS_WRITE-ZMGNAME = '####'.

ENDIF.



" CASE# ##

CASE GS_STUDENT-ZMAJOR.

  WHEN 'A'.

    GS_WRITE-ZMNAME = '####'.

  WHEN 'B'.

    GS_WRITE-ZMNAME = '####'.

  WHEN 'C'.

    GS_WRITE-ZMNAME = '###'.

  WHEN 'D'.

    GS_WRITE-ZMNAME = '#####'.

  WHEN 'E'.

    GS_WRITE-ZMNAME = '#####'.

  WHEN 'F'.

    GS_WRITE-ZMNAME = '###'.

  WHEN 'G'.

    GS_WRITE-ZMNAME = '###'.

  WHEN 'H'.

    GS_WRITE-ZMNAME = '###'.

ENDCASE.



WRITE : GS_WRITE-ZMGNAME, GS_WRITE-ZMNAME.