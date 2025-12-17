
*&---------------------------------------------------------------------*

*&  Include           ZWORK05_001_PBO

*&---------------------------------------------------------------------*

*&  PBO Modules

*&---------------------------------------------------------------------*






" ## ## # ### ##

MODULE STATUS_0100 OUTPUT.

  SET PF-STATUS '0100'.

  SET TITLEBAR '0100'.

ENDMODULE.



" ALV ## ## ##

MODULE DISPLAY_ALV OUTPUT.

  PERFORM CREATE_OBJECT. " ## ##

  PERFORM FIELD_CATALOG. " ## #### ##

  PERFORM ALV_LAYOUT.    " #### ##

  PERFORM CALL_ALV.      " ALV ##

ENDMODULE.