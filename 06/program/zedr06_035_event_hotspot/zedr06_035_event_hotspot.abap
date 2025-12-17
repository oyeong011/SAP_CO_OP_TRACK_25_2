
*&---------------------------------------------------------------------*

*& Report ZEDR06_035_EVENT_HOTSPOT

*&---------------------------------------------------------------------*

*&

*&---------------------------------------------------------------------*




REPORT ZEDR06_035_EVENT_HOTSPOT MESSAGE-ID ZMED06.



include
ZEDR06_035_EVENT_HOTSPOT_CLS
.

include
ZEDR06_035_EVENT_HOTSPOT_TOP
.

include
ZEDR06_035_EVENT_HOTSPOT_SCR
.

include
ZEDR06_035_EVENT_HOTSPOT_F01
.

include
ZEDR06_035_EVENT_HOTSPOT_PBO
.

include
ZEDR06_035_EVENT_HOTSPOT_PAI
.



INITIALIZATION.

" # ###



AT SELECTION-SCREEN OUTPUT.

" # ### ## (## ## #)



AT SELECTION-SCREEN.

" ## ## ##.



START-OF-SELECTION.

  PERFORM GET_DATA.

  PERFORM MODIFY_DATA.



  CALL SCREEN 100.



END-OF-SELECTION.








*Messages

*----------------------------------------------------------

*

* Message class: Hard coded

*   ####