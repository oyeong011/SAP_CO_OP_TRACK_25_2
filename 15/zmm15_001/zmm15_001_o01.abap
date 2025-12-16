
*&---------------------------------------------------------------------*

*&  Include           ZMM15_001_O01

*&---------------------------------------------------------------------*

*&---------------------------------------------------------------------*

*&      Module  STATUS_0100  OUTPUT

*&---------------------------------------------------------------------*

*       text

*----------------------------------------------------------------------*




MODULE STATUS_0100 OUTPUT.

  SET PF-STATUS 'STATUS100'.

  SET TITLEBAR 'T100'.

ENDMODULE.




*&---------------------------------------------------------------------*

*&      Module  MODIFY_0100  OUTPUT

*&---------------------------------------------------------------------*

*       text

*----------------------------------------------------------------------*




MODULE MODIFY_0100 OUTPUT.

  LOOP AT SCREEN.

    "#### ###

    IF SCREEN-GROUP1 = 'MOD'.

      IF GV_APND_MODE = 'X'.

        SCREEN-INPUT = '1'. "####

      ELSE.

        SCREEN-INPUT = '0'. "####(####)

      ENDIF.



      MODIFY SCREEN.

    ENDIF.



    " #### ## ##

    IF SCREEN-GROUP2 = 'M3'.

      IF P_KTOKK = '3000'. "###### 3000# ## ###

        SCREEN-ACTIVE = '1'.

      ELSE.

        SCREEN-ACTIVE = '0'.

      ENDIF.

    ENDIF.



    " ##### ## ##

    IF SCREEN-GROUP2 = 'M4'.

      IF P_KTOKK = '2000' OR P_KTOKK = '3000'. "###### 2000,3000(##, ##)# ## ##

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

  SET PF-STATUS 'STATUS200'.

  SET TITLEBAR 'T200'.

ENDMODULE.




*&---------------------------------------------------------------------*

*&      Module  ALV_0200  OUTPUT

*&---------------------------------------------------------------------*

*       text

*----------------------------------------------------------------------*




MODULE ALV_0200 OUTPUT.

  IF GC_DOCKING IS INITIAL.

    PERFORM CREATE_OBJECT.

    PERFORM FIELD_CATALOG.

    PERFORM ALV_LAYOUT.

    PERFORM CLASS_EVENT.

    PERFORM ALV_DISPLAY.

  ELSE.

    PERFORM REFRESH.

  ENDIF.



ENDMODULE.