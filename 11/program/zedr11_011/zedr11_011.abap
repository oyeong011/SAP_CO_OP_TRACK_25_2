
*&---------------------------------------------------------------------*

*& Report ZEDR11_011

*&---------------------------------------------------------------------*

*&

*&---------------------------------------------------------------------*




REPORT ZEDR11_011 MESSAGE-ID ZMED11.



TABLES : ZEDT11_001.



SELECTION-SCREEN BEGIN OF BLOCK B1 WITH FRAME.

  SELECT-OPTIONS : S_ZCODE FOR ZEDT11_001-ZCODE.

  PARAMETERS : P_ZPERNR LIKE ZEDT11_001-ZPERNR.

  PARAMETERS : P_ZGEN LIKE ZEDT11_001-ZGENDER DEFAULT 'M'.

  SELECTION-SCREEN END OF BLOCK B1.



  INITIALIZATION.

  S_ZCODE-LOW = 'SSU-02'.

  S_ZCODE-HIGH = 'SSU-09'.

  APPEND S_ZCODE.





  AT SELECTION-SCREEN ON S_ZCODE.

    IF S_ZCODE-LOW NE 'SSU-01'.

      MESSAGE '##### SSU-01## #####.' TYPE 'E'.

ENDIF.








*Messages

*----------------------------------------------------------

*

* Message class: Hard coded

*   ##### SSU-01## #####.