
*&---------------------------------------------------------------------*

*&  Include           ZDOCKING_CONTAINER11_O01

*&---------------------------------------------------------------------*






MODULE SET_ALV OUTPUT.



  PERFORM create_object.

  PERFORM field_catalog.

  PERFORM alv_layout.

  PERFORM alv_sort.

  PERFORM call_alv.



ENDMODULE.









MODULE STATUS_0100 OUTPUT.

  SET PF-STATUS 'STATUS 0100'.

  SET TITLEBAR 'T100'.

ENDMODULE.




*&---------------------------------------------------------------------*

*&      Module  EXIT_COMMNAD  INPUT

*&---------------------------------------------------------------------*

*       text

*----------------------------------------------------------------------*




MODULE EXIT_COMMNAD INPUT.



CASE ok_code.

    WHEN 'BACK' or 'CANC'.

      LEAVE TO SCREEN 0.

    WHEN 'EXIT'.

      LEAVE PROGRAM.

    ENDCASE.

ENDMODULE.