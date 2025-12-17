
*&---------------------------------------------------------------------*

*& Report ZMM11_001

*&---------------------------------------------------------------------*




REPORT ZMM11_001.



include
zmm11_001_cls
.

include
zmm11_001_top
.

include
zmm11_001_scr
.

include
zmm11_001_f01
.

include
zmm11_001_pbo
.

include
zmm11_001_pai
.



AT SELECTION-SCREEN.

  PERFORM verify_ktokk.



AT SELECTION-SCREEN OUTPUT.

  PERFORM set_screen.



START-OF-SELECTION.

  IF p_rad1 = 'X'.

    gv_mode = 'E'.    " <--- [##] # ### # #####! (## ## ###)

    CALL SCREEN 100.

  ELSE.

    PERFORM get_data.



    IF gt_search IS INITIAL.

      MESSAGE '#### #### ####!' TYPE 'I'.

      RETURN.

    ENDIF.



    CALL SCREEN 200.

  ENDIF.






*GUI Texts

*----------------------------------------------------------

* T100 --> #####





*Messages

*----------------------------------------------------------

*

* Message class: Hard coded

*   #### # #### #####