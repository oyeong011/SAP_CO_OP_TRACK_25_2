
*&---------------------------------------------------------------------*

*& Report ZEDR24_008

*&---------------------------------------------------------------------*

*&

*&---------------------------------------------------------------------*




REPORT ZEDR24_008.



DATA : BEGIN OF GS_STUDENT,

  ZCODE TYPE ZEDT24_001-ZCODE,

  ZPERNR TYPE ZEDT24_001-ZPERNR,

  ZKNAME TYPE ZEDT24_001-ZKNAME,

  ZENAME TYPE ZEDT24_001-ZENAME,

  ZGENDER TYPE ZEDT24_001-ZGENDER,

  ZGNAME TYPE C LENGTH 2,

  ZTEL TYPE ZEDT24_001-ZTEL,

  END OF GS_STUDENT.



DATA : GT_STUDENT LIKE TABLE OF GS_STUDENT WITH NON-UNIQUE KEY ZCODE.

CLEAR GT_STUDENT.



CLEAR GS_STUDENT.

GS_STUDENT = VALUE #( ZCODE = 'SSU-01'

                      ZPERNR = '0000000001'

                      ZKNAME = '###'

                      ZENAME = 'DONG'

                      ZGENDER = 'M'

                      ZTEL = '01011112222' ).

APPEND GS_STUDENT TO GT_STUDENT.



CLEAR GS_STUDENT.

GS_STUDENT = VALUE #( ZCODE = 'SSU-01'

                      ZPERNR = '0000000002'

                      ZKNAME = '###'

                      ZENAME = 'LEE'

                      ZGENDER = 'M'

                      ZTEL = '01022223333' ).

APPEND GS_STUDENT TO GT_STUDENT.



CLEAR GS_STUDENT.

GS_STUDENT = VALUE #( ZCODE = 'SSU-01'

                      ZPERNR = '0000000001'

                      ZKNAME = '###'

                      ZENAME = 'DONG'

                      ZGENDER = 'F'

                      ZTEL = '01011112222' ).

APPEND GS_STUDENT TO GT_STUDENT.



CLEAR GS_STUDENT.

GS_STUDENT = VALUE #( ZCODE = 'SSU-01'

                      ZPERNR = '0000000001'

                      ZKNAME = '###'

                      ZENAME = 'DONG'

                      ZGENDER = 'F'

                      ZTEL = '01011112222' ).

APPEND GS_STUDENT TO GT_STUDENT.



CLEAR GS_STUDENT.

GS_STUDENT = VALUE #( ZCODE = 'SSU-01'

                      ZPERNR = '0000000001'

                      ZKNAME = '###'

                      ZENAME = 'DONG'

                      ZGENDER = 'M'

                      ZTEL = '01011112222' ).

APPEND GS_STUDENT TO GT_STUDENT.



CLEAR GS_STUDENT.

GS_STUDENT = VALUE #( ZCODE = 'SSU-01'

                      ZPERNR = '0000000001'

                      ZKNAME = '###'

                      ZENAME = 'KANG'

                      ZGENDER = 'M'

                      ZTEL = '01011112222' ).

APPEND GS_STUDENT TO GT_STUDENT.



CLEAR GS_STUDENT.



BREAK-POINT.



SORT GT_STUDENT BY ZCODE ZKNAME ZENAME ZGENDER.



LOOP AT GT_STUDENT INTO GS_STUDENT.

  GS_STUDENT-ZGNAME = '####'.



  AT NEW ZGENDER.

    GS_STUDENT-ZGNAME = '####'.

    WRITE :/ GS_STUDENT-ZPERNR.

    "MODIFY GT_STUDENT FROM GS_STUDENT.

  ENDAT.



  CLEAR GS_STUDENT.

ENDLOOP.



BREAK-POINT.