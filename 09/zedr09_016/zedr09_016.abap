
*&---------------------------------------------------------------------*

*& Report ZEDR09_016

*&---------------------------------------------------------------------*

*&

*&---------------------------------------------------------------------*




REPORT ZEDR09_016.






* =====================================================================

* ABAP## ## ## ## ##



* 1. DO ~ ENDDO : ### ## ##, EXIT STOP CONTINUE CHECK # #### !!

* 2. WHILE ~ ENDWHILE : ### ## ### ##

* 3. LOOP ~ ENDLOOP



* - ## LOOP## ## ###, # ### #

* - LOOP## sy-tabix, DO# & WHILE## sy-index ## ###, # #### #!



* =====================================================================





* 1. DO ~ ENDDO

* DO (N) TIMES

*   ####..

* ENDDO








DATA : LV_NUM TYPE I,

       LV_SUM TYPE I.



LV_NUM = 5.



DO LV_NUM TIMES. "LV_NUM## ## ##

  ADD sy-index TO LV_SUM.

  WRITE : / SY-INDEX.

ENDDO.



WRITE : / 'INDEX## : ', LV_SUM.



LV_SUM = 0.






* 1. DO ~ ENDDO -> EXIT ###






DO LV_NUM TIMES.



  IF sy-index = '3'. "EXIT ### ##, #### ## -> ### ### ### INDEX ### #####

    EXIT.

  ENDIF.



  ADD sy-index TO LV_SUM.

  WRITE : / SY-INDEX.

ENDDO.



WRITE : / 'INDEX## : ', LV_SUM.



LV_SUM = 0.






* 1. DO ~ ENDDO -> STOP ###






DO LV_NUM TIMES.



  IF sy-index = '3'. "STOP ### ##, #### ##. -> ### ### ## ####.




*    STOP.




  ENDIF.



  ADD sy-index TO LV_SUM.

  WRITE : / SY-INDEX.

ENDDO.



WRITE : / 'INDEX## : ', LV_SUM.

LV_SUM = 0.








* 1. DO ~ ENDDO -> CONTINUE ###






WRITE : / 'CONTINUE ## ##'.

DO LV_NUM TIMES.



  IF sy-index = '3'. "CONTINUM ### ##, # ### #### ####

    CONTINUE.

  ENDIF.



  ADD sy-index TO LV_SUM.

  WRITE : / SY-INDEX.

ENDDO.



WRITE : / 'INDEX## : ', LV_SUM.

LV_SUM = 0.








* 1. DO ~ ENDDO -> CHECK ###






WRITE : / 'CHECK ## ##'.

DO LV_NUM TIMES.



  CHECK sy-index = 3. "CHECK ## ###### ## ####, "#" #### ##



  ADD sy-index TO LV_SUM.

  WRITE : / SY-INDEX.

ENDDO.



WRITE : / 'INDEX## : ', LV_SUM.














* 2. WHILE ~ ENDWHILE

* WHILE [###].

*   ####..

* ENDWHILE.

* => ##### ## #### ## ##








DATA : GV_NUM TYPE I,

       GV_CHECK TYPE C.



GV_NUM = 5.



WHILE GV_NUM = 5.

  GV_CHECK = 'X'.

ENDWHILE.



IF GV_CHECK = 'X'.

   WRITE : / '#######.'.

ENDIF.