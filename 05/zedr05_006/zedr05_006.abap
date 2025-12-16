
REPORT ZEDR05_006.



include
ZEDR05_024_TOP
.

include
ZEDR05_024_SCR
.

include
ZEDR05_024_F01
.

include
ZEDR05_024_PBO
.

include
ZEDR05_024_PAI
.



INITIALIZATION.

  PERFORM SET_INIT.



START-OF-SELECTION.

  PERFORM GET_DATA.



  CALL SCREEN 100.






*GUI Texts

*----------------------------------------------------------

* T100 --> #####





*Messages

*----------------------------------------------------------

*

* Message class: Hard coded

*   ALV Grid ### #### #####.