
*&---------------------------------------------------------------------*

*&  Include           ZMM09_001_PBO

*&---------------------------------------------------------------------*

*&---------------------------------------------------------------------*

*&      Module  STATUS_0100  OUTPUT

*&---------------------------------------------------------------------*

*       text

*----------------------------------------------------------------------*




MODULE STATUS_0100 OUTPUT.

  SET PF-STATUS 'STATUS_0100'.

  SET TITLEBAR 'T100'.

ENDMODULE.






*&---------------------------------------------------------------------*

*&      Module  PBO_0100  OUTPUT

*&---------------------------------------------------------------------*




MODULE PBO_0100 OUTPUT.

  LOOP AT SCREEN.

    IF GV_EDIT_MODE = ABAP_TRUE.

      SCREEN-INPUT = 1. "####

    ELSE.

      SCREEN-INPUT = 0. "####

    ENDIF.



    IF SCREEN-GROUP1 = 'ST1'. "#### ##

      IF P_KTOKK = '3000'.

        SCREEN-ACTIVE = 1.

      ELSE.

        SCREEN-ACTIVE = 0.

      ENDIF.



    ELSEIF SCREEN-GROUP1 = 'ST2'. "##### ##

      IF P_KTOKK = '2000' OR P_KTOKK = '3000'.

        SCREEN-ACTIVE = 0.

      ENDIF.

    ENDIF.



    "### ### ## #### (####)

    IF SCREEN-GROUP1 = 'LF1'.

      SCREEN-ACTIVE = 0.

    ENDIF.



    "#### ## ##

    IF SCREEN-NAME = 'GF_KTOKK'.

      SCREEN-INPUT = 0.

    ENDIF.

    MODIFY SCREEN.

  ENDLOOP.

ENDMODULE.






*&---------------------------------------------------------------------*

*&      Module  STATUS_0200  OUTPUT

*&---------------------------------------------------------------------*




MODULE STATUS_0200 OUTPUT.

  SET PF-STATUS 'STATUS_0200'.

  SET TITLEBAR 'T200'.

ENDMODULE.






*&---------------------------------------------------------------------*

*&      Module  SET_ALV  OUTPUT

*&---------------------------------------------------------------------*




MODULE SET_ALV OUTPUT.

  IF GC_DOCKING IS INITIAL.

    PERFORM CREATE_OBJECT.

    PERFORM FIELD_CATALOG.

    PERFORM ALV_LAYOUT.

    PERFORM CLASS_EVENT.

    PERFORM CALL_ALV.



  ELSE.

    PERFORM REFRESH.

  ENDIF.

ENDMODULE.