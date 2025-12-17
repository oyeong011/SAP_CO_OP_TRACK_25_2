
*&---------------------------------------------------------------------*

*& Report ZEDR12_DOENDDO

*&---------------------------------------------------------------------*

*&

*&---------------------------------------------------------------------*




REPORT ZEDR12_DOENDDO.



DATA: LV_NUM TYPE I.

DATA: LV_SUM TYPE I.

LV_NUM = 5.



DO LV_NUM TIMES. "LV_NUM## ## ##.

  ADD SY-INDEX TO LV_SUM.

  WRITE:/ SY-INDEX.



ENDDO.



WRITE:/ 'INDEX##:', LV_SUM.

WRITE:/ '======================='.



LV_SUM = 0.

DO LV_NUM TIMES. "LV_NUM## ## ##.

  IF SY-INDEX = '3'.

    EXIT. "### ##.

    ENDIF.



  ADD SY-INDEX TO LV_SUM.

  WRITE:/ SY-INDEX.



ENDDO.

WRITE:/ 'INDEX##:', LV_SUM.

WRITE:/ '======================='.



LV_SUM = 0.

DO LV_NUM TIMES. "LV_NUM## ## ##.

  IF SY-INDEX = '3'.

    CONTINUE. "CONTINUE ## ## # ### #### ####.

    ENDIF.



  ADD SY-INDEX TO LV_SUM.

  WRITE:/ SY-INDEX.



ENDDO.

WRITE:/ 'INDEX##:', LV_SUM.

WRITE:/ '======================='.



LV_SUM = 0.

DO LV_NUM TIMES. "LV_NUM## ## ##.



  CHECK SY-INDEX = '3'.

  ADD SY-INDEX TO LV_SUM.

  WRITE:/ SY-INDEX.



ENDDO.

WRITE:/ 'INDEX##:', LV_SUM.

WRITE:/ '======================='.



LV_SUM = 0.

DO LV_NUM TIMES. "LV_NUM## ## ##.

  IF SY-INDEX = '3'.

    STOP. "#### ##

    ENDIF.



  ADD SY-INDEX TO LV_SUM.

  WRITE:/ SY-INDEX.



ENDDO.

WRITE:/ 'INDEX##:', LV_SUM.