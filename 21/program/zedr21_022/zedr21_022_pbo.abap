
*&---------------------------------------------------------------------*

*&  Include           ZEDR21_022_PBO

*&---------------------------------------------------------------------*

*&---------------------------------------------------------------------*

*&      Module  STATUS_0100  OUTPUT

*&---------------------------------------------------------------------*

*       text

*-------------------------------------------------------------------




MODULE STATUS_0100 OUTPUT.

  SET PF-STATUS 'STATUS_0100'.

  SET TITLEBAR 'T100'.

ENDMODULE.




*&---------------------------------------------------------------------*

*&      Module  SET_ALV  OUTPUT

*&---------------------------------------------------------------------*

*       text

*----------------------------------------------------------------------*




MODULE SET_ALV OUTPUT.



  IF gc_docking IS INITIAL.

    PERFORM create_object.

    PERFORM fieldcat.

    PERFORM alv_layout.

    PERFORM alv_sort.

    PERFORM CLASS_EVENT.

    PERFORM call_alv.

  ELSE.

    PERFORM refresh.

  ENDIF.





ENDMODULE.