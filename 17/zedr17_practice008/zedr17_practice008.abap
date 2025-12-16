
*&---------------------------------------------------------------------*

*& Report ZEDR17_PRACTICE008

*&---------------------------------------------------------------------*

*&

*&---------------------------------------------------------------------*




report zedr17_practice008 message-id zmed17.



include
zedr17_practice008_top
.

include
zedr17_practice008_scr
.

include
zedr17_practice008_f01
.

include
zedr17_practice008_o01
.

include
zedr17_practice008_i01
.



initialization.

  perform set_init.



" output## selection screen ### layout ## ##. ### ### ##

at selection-screen output.

  if p_order = 'X'. " #### ## ### ##

    gv_order_active_flag = '1'.

    gv_ship_active_flag = '0'.

  elseif p_ship = 'X'. " #### ## ### ##

    gv_order_active_flag = '0'.

    gv_ship_active_flag = '1'.

  endif.



  loop at screen.

    if screen-group1 = 'SC1'. " ## #### ### ##

      screen-active = gv_order_active_flag.

    elseif screen-group1 = 'SC2'. " ## #### ### ##

      screen-active = gv_ship_active_flag.

    endif.

    modify screen.

  endloop.



start-of-selection. " inialization ## ### # #### ### error# ##

  perform build_date_range. " ## ## yyyy.mm.dd -> yyyymmdd



  if p_order = 'X'. " #### ##### ### ##

    perform get_order_data. " ### ##

    if gt_order_print[] is initial.

      message i001.

      exit.

    endif.

    call screen 100.

    exit.

  else. " #### ##### ### ##

    perform get_shipping_data. " ### ##

    if gt_shipping_print[] is initial.

      message i001.

      exit.

    endif.

    call screen 200.

    exit.

  endif.






*GUI Texts

*----------------------------------------------------------

* T100 --> R1 ######

* T200 --> R2 ######

* T100 --> R1 ######

* T200 --> R2 ######