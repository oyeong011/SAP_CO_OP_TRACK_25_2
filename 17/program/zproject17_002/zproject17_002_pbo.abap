
*&---------------------------------------------------------------------*

*&  Include           ZPROJECT17_002_PBO

*&---------------------------------------------------------------------*






MODULE status_0100 OUTPUT.



 DATA: lt_ex_func TYPE STANDARD TABLE OF sy-ucomm,

        lv_func    TYPE sy-ucomm.



  IF gv_mode = c_mode_create.



    " ## ## : ## ## ###

    SET PF-STATUS 'STATUS_0100'.

    SET TITLEBAR 'T0100' WITH '##'.



  ELSE. " ## ##



    " ## #### ## ### ##

    REFRESH lt_ex_func.

    lv_func = 'ADD'.   APPEND lv_func TO lt_ex_func. " #### +

    lv_func = 'DEL'.   APPEND lv_func TO lt_ex_func. " #### -

    lv_func = 'SAVE'.  APPEND lv_func TO lt_ex_func. " PO##(##)



    " # 3# #### #### STATUS_0100 ##

    SET PF-STATUS 'STATUS_0100' EXCLUDING lt_ex_func.

    SET TITLEBAR 'T0100' WITH '##'.



  ENDIF.



ENDMODULE.



MODULE set_alv_0100 OUTPUT.

  " ## ## ## (### ### #)

  " ## ##### ## ## ## (### ### #)

  IF gv_mode = c_mode_create.

    PERFORM check_vendor_valid.

  ENDIF.



  " ## ## ### ##

  gv_bukrs_disp = gs_ekko-bukrs.

  gv_lifnr_disp = gs_ekko-lifnr.

  gv_bedat_disp = gs_ekko-bedat.

  gv_ekorg_disp = gs_ekko-ekorg.

  gv_ekgrp_disp = gs_ekko-ekgrp.

  gv_waers_disp = gs_ekko-waers.



  " ## ## ####

  PERFORM disable_header_fields.





  " alv ##

  IF go_container IS INITIAL.

    PERFORM create_object_0100.

    PERFORM alv_display_0100.



    " ### ### ##

    IF go_handler IS INITIAL.

      CREATE OBJECT go_handler.

      SET HANDLER go_handler->handler_data_changed FOR go_alv.

    ENDIF.



  ELSE.

    PERFORM refresh_alv_0100.

  ENDIF.



ENDMODULE.