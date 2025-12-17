
*&---------------------------------------------------------------------*

*&  Include           ZMM02_001_PBO

*&---------------------------------------------------------------------*

*&---------------------------------------------------------------------*

*&      Module  STATUS_0100  OUTPUT

*&---------------------------------------------------------------------*

*       text

*----------------------------------------------------------------------*




MODULE STATUS_0100 OUTPUT.

  SET PF-STATUS 'STATUS 0100'.

  SET TITLEBAR 'T100'.

  IF G_CURSOR_FIELD IS NOT INITIAL.

    SET CURSOR FIELD G_CURSOR_FIELD. "### # ## ##

    CLEAR: G_CURSOR_FIELD.

  ENDIF.

  LOOP AT SCREEN.



    IF SCREEN-GROUP1 = 'M1'.

      IF G_KTOKK = '3000'. "##### 3000->#### ## ##

        SCREEN-ACTIVE = '1'.

      ELSE.

        SCREEN-ACTIVE = '0'.

      ENDIF.

    ENDIF.

    IF SCREEN-GROUP1 = 'M2'. "##### 2000->##### ## # ##

      IF G_KTOKK = '2000' OR G_KTOKK = '3000'.

        SCREEN-ACTIVE = '0'.

      ELSE.

        SCREEN-ACTIVE = '1'.

      ENDIF.

    ENDIF.

    MODIFY SCREEN.

  ENDLOOP.

ENDMODULE.




*&---------------------------------------------------------------------*

*&      Module  STATUS_0200  OUTPUT

*&---------------------------------------------------------------------*

*       text

*----------------------------------------------------------------------*




MODULE STATUS_0200 OUTPUT.

  SET PF-STATUS 'STATUS 0200'.

  SET TITLEBAR 'T200'.

  LOOP AT SCREEN.

    IF SCREEN-NAME = 'G_STCD2' OR SCREEN-NAME = 'T_STCD2'.

      IF GS_VENDOR-KTOKK = '2000' OR GS_VENDOR-KTOKK = '3000'.

        SCREEN-ACTIVE = 0.

      ENDIF.

    ENDIF.

    IF SCREEN-NAME = 'G_STCD1' OR SCREEN-NAME = 'T_STCD1'.

      IF GS_VENDOR-KTOKK <> '3000'.

        SCREEN-ACTIVE = 0.

      ENDIF.

    ENDIF.

    MODIFY SCREEN.

  ENDLOOP.

ENDMODULE.