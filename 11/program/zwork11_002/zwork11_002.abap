
*&---------------------------------------------------------------------*

*& Report ZWORK11_002

*&---------------------------------------------------------------------*




REPORT zwork11_002.



include
zwork11_002_top
.

include
zwork11_002_scr
.

include
zwork11_002_f01
.

include
zwork11_002_pbo
.

include
zwork11_002_pai
.



INITIALIZATION.

  PERFORM set_init.



START-OF-SELECTION.

  PERFORM get_data.



  IF gt_list IS INITIAL.

    MESSAGE '#### ####.' TYPE 'S' DISPLAY LIKE 'E'.

    EXIT.

  ENDIF.



  PERFORM set_add_info.



  CALL SCREEN 100.








*Messages

*----------------------------------------------------------

*

* Message class: Hard coded

*   #######.