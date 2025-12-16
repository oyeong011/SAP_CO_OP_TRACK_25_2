
*&---------------------------------------------------------------------*

*& Include ZMM11_002_PBO

*&---------------------------------------------------------------------*




MODULE status_0100 OUTPUT.

  SET PF-STATUS 'S100'.

  SET TITLEBAR 'T100'.

ENDMODULE.



MODULE status_0200 OUTPUT.

  SET PF-STATUS 'S200'.

  SET TITLEBAR 'T200'.

ENDMODULE.



MODULE prepare_alv OUTPUT.

  IF go_docker IS INITIAL.

    PERFORM init_alv_container.

    PERFORM set_layout_and_variant.



    IF rb_new = abap_true.

      PERFORM build_fcat_create.

      PERFORM register_events.

      PERFORM display_alv USING gt_alv_data.

    ELSE.

      PERFORM build_fcat_display.

      PERFORM display_alv USING gt_item_ins.

    ENDIF.



  ELSE.

    PERFORM refresh_grid.

  ENDIF.

ENDMODULE.