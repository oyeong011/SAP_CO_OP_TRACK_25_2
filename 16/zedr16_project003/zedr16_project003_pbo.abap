
*&---------------------------------------------------------------------*

*&  Include           ZEDR16_PROJECT003_PBO

*&---------------------------------------------------------------------*

*&---------------------------------------------------------------------*

*&      Module  STATUS_0100  OUTPUT

*&---------------------------------------------------------------------*

*       text

*----------------------------------------------------------------------*




MODULE STATUS_0100 OUTPUT.



  SET PF-STATUS 'STATUS 0100'.

  SET TITLEBAR 'T100'.



  LOOP AT SCREEN.

    " 1. ## ### # ### ## ## ##

    IF SCREEN-NAME CS 'GS_MKPF-'.

      SCREEN-INPUT = 0.

    ENDIF.



    MODIFY SCREEN.

  ENDLOOP.



ENDMODULE.




*&---------------------------------------------------------------------*

*&      Module  SET_ALV  OUTPUT

*&---------------------------------------------------------------------*

*       text

*----------------------------------------------------------------------*




MODULE SET_ALV OUTPUT.



  IF GC_CUSTOM IS INITIAL.

    PERFORM CREATE_OBJECT.

    PERFORM FIELD_CATALOG.

    PERFORM ALV_LAYOUT.

    PERFORM CLASS_EVENT.

    PERFORM CALL_ALV.

  ELSE.

    PERFORM REFRESH.

  ENDIF.



ENDMODULE.




*&---------------------------------------------------------------------*

*&      Module  STATUS_0200  OUTPUT

*&---------------------------------------------------------------------*

*       text

*----------------------------------------------------------------------*




MODULE STATUS_0200 OUTPUT.

  SET PF-STATUS 'STATUS 0200'.

  SET TITLEBAR 'T200'.

ENDMODULE.




*&---------------------------------------------------------------------*

*&      Module  SET_ALV_200  OUTPUT

*&---------------------------------------------------------------------*

*       text

*----------------------------------------------------------------------*




MODULE SET_ALV_200 OUTPUT.



  IF GC_DOCKING IS INITIAL.

    PERFORM CREATE_OBJECT_200.

    PERFORM FIELD_CATALOG_200.

    PERFORM ALV_LAYOUT_200.

    PERFORM CALL_ALV_200.

  ELSE.

    PERFORM REFRESH_200.

  ENDIF.



ENDMODULE.