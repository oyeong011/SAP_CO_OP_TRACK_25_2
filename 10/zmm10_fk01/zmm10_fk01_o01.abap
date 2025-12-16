
*&---------------------------------------------------------------------*

*&  Include           ZMM10_FK01_O01

*&---------------------------------------------------------------------*

*&---------------------------------------------------------------------*

*&      Module  STATUS_0100  OUTPUT

*&---------------------------------------------------------------------*

*       text

*----------------------------------------------------------------------*




MODULE STATUS_0100 OUTPUT.

  SET PF-STATUS 'STATUS0100'.

  SET TITLEBAR 'T0100'.

  DATA:

    LT_DEACT_TXT TYPE C LENGTH 20.

  CASE P_KTOKK.

    WHEN '3000'.

      " KTOKK=3000: STCD1 ##, STCD2 ####

      LT_DEACT_TXT = 'STCD2'.

    WHEN '2000'.

      " KTOKK=2000: STCD1/STCD2 ## ## (#### ## ##)

      LT_DEACT_TXT = 'STCD'.  " <--- [##] #### ### ## ### ##

    WHEN OTHERS.

      " # #: STCD1 ####, STCD2 ##

      LT_DEACT_TXT = 'STCD1'.

  ENDCASE.



  LOOP AT SCREEN.

    IF SCREEN-NAME CS LT_DEACT_TXT .

      SCREEN-ACTIVE = 0.



    ENDIF.

    IF SCREEN-NAME CS 'LIFNR' AND PR_SEAR = 'X'.

      SCREEN-INPUT = 0.

    ENDIF.

    MODIFY SCREEN.

  ENDLOOP.

ENDMODULE.