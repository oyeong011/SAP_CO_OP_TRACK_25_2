
*&---------------------------------------------------------------------*

*&  Include           ZMMR01_010_PBO

*&---------------------------------------------------------------------*

*&---------------------------------------------------------------------*

*&      Module  STATUS_0100  OUTPUT

*&---------------------------------------------------------------------*

*       text

*----------------------------------------------------------------------*




MODULE STATUS_0100 OUTPUT.

  SET PF-STATUS 'STATUS_0100'.

  SET TITLEBAR 'T001'.

ENDMODULE.




*&---------------------------------------------------------------------*

*&      Module  SET_ALV  OUTPUT

*&---------------------------------------------------------------------*




MODULE SET_ALV OUTPUT.

  PERFORM CREATE_OBJECT.

  PERFORM EXCLUDE_TOOLBAR_100.

  IF GV_MODE = 'CREATE'.

    PERFORM FIELD_CATALOG.

  ELSEIF GV_MODE = 'DISPLAY'.

    PERFORM FIELD_CATALOG_DISP.

  ENDIF.

  PERFORM ALV_LAYOUT.

  PERFORM ALV_SORT.

  PERFORM CLASS_EVENT.

  PERFORM ALV_DISPLAY USING GT_DISP_100.

ENDMODULE.




*&---------------------------------------------------------------------*

*&      Module  SET_SCREEN  OUTPUT

*&---------------------------------------------------------------------*

*       text

*----------------------------------------------------------------------*




MODULE SET_SCREEN OUTPUT.

  LOOP AT SCREEN.

    IF GV_MODE = 'DISPLAY'.

      IF SCREEN-GROUP1 = 'M1'.

        SCREEN-INPUT = 0.



      ENDIF.

    ENDIF.



    MODIFY SCREEN.

  ENDLOOP.



ENDMODULE.