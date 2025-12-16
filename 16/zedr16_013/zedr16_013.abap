
*&---------------------------------------------------------------------*

*& Report ZEDR16_013

*&---------------------------------------------------------------------*

*&

*&---------------------------------------------------------------------*




REPORT zedr16_013.



DATA : lv_num TYPE i.

DATA : lv_sum TYPE i.



lv_num = 5.



DO lv_num TIMES.



  if sy-index = '3'.

    exit.

    endif.





  ADD sy-index TO lv_sum.

  WRITE :/ sy-index.



ENDDO.



WRITE :/ 'index##: ', lv_sum.