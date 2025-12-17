
*&---------------------------------------------------------------------*

*& Report ZEDR24_007

*&---------------------------------------------------------------------*

*&

*&---------------------------------------------------------------------*




REPORT ZEDR24_007.



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

GS_STUDENT = VALUE #( ZCODE = 'SSU-02'

                      ZPERNR = '0000000002'

                      ZKNAME = '###'

                      ZENAME = 'HOON'

                      ZGENDER = 'M'

                      ZTEL = '01022223333' ).

APPEND GS_STUDENT TO GT_STUDENT.



CLEAR GS_STUDENT.

GS_STUDENT = VALUE #( ZCODE = 'SSU-03'

                      ZPERNR = '0000000003'

                      ZKNAME = '###'

                      ZENAME = 'SON'

                      ZGENDER = 'F'

                      ZTEL = '01033334444' ).

APPEND GS_STUDENT TO GT_STUDENT.



CLEAR GS_STUDENT.



BREAK-POINT.



GS_STUDENT-ZGNAME = '##'.



MODIFY GT_STUDENT FROM GS_STUDENT TRANSPORTING ZGNAME

WHERE ZGENDER = 'M'.



BREAK-POINT.