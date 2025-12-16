
*&---------------------------------------------------------------------*

*&  Include           ZMM06_001_PBO

*&---------------------------------------------------------------------*

*&---------------------------------------------------------------------*

*&      Module  STATUS_0200  OUTPUT

*&---------------------------------------------------------------------*

*       text

*----------------------------------------------------------------------*




MODULE STATUS_0200 OUTPUT.

  SET PF-STATUS 'STATUS_0200'.

  SET TITLEBAR 'T200'.

ENDMODULE.




*&---------------------------------------------------------------------*

*&      Module  CONTROL_SCREEN_0200_ELEMENTS  OUTPUT

*&---------------------------------------------------------------------*

*       text

*----------------------------------------------------------------------*




MODULE CONTROL_SCREEN_0200_ELEMENTS OUTPUT.



  LOOP AT SCREEN.

    IF GV_MODE <> 'A'.

      SCREEN-INPUT = 0.

    ENDIF.



    " ADD ### ## ## ##

    IF GV_MODE = 'A'.

      SCREEN-INPUT = 1.



      IF SCREEN-NAME = 'BUKRS'

      OR SCREEN-NAME = 'KTOKK'

      OR SCREEN-NAME = 'LIFNR_A1'

      OR SCREEN-NAME = 'LIFNR_B1'

      OR SCREEN-NAME = 'LIFNR_M1'.

        SCREEN-INPUT = 0.

      ENDIF.

    ENDIF.





    " ###### 3000# ## STCD1# ####.

    IF P_KTOKK = '3000'.

      IF SCREEN-NAME = 'STCD2'.

        SCREEN-ACTIVE = 0.

      ENDIF.

    ELSE.

      IF SCREEN-NAME = 'STCD1'.

        SCREEN-ACTIVE = 0.

      ENDIF.

    ENDIF.



    " ###### 2000# # STCD1, STCD2 ### ##.

    IF P_KTOKK = '2000'.

      IF SCREEN-NAME = 'STCD1' OR SCREEN-NAME = 'STCD2'.

        SCREEN-ACTIVE = 0.

      ENDIF.

    ENDIF.



    MODIFY SCREEN.

  ENDLOOP.



ENDMODULE.




*&---------------------------------------------------------------------*

*&      Module  STATUS_0300  OUTPUT

*&---------------------------------------------------------------------*

*       text

*----------------------------------------------------------------------*




MODULE STATUS_0300 OUTPUT.

  SET PF-STATUS 'STATUS_0300'.

  SET TITLEBAR 'T300'.

ENDMODULE.




*&---------------------------------------------------------------------*

*&      Module  CONTROL_SCREEN_0200_ELEMENTS  OUTPUT

*&---------------------------------------------------------------------*

*       text

*----------------------------------------------------------------------*




MODULE CONTROL_SCREEN_0300_ELEMENTS OUTPUT.

  LOOP AT SCREEN.



    SCREEN-INPUT  = 0.

    SCREEN-ACTIVE = 1.



    IF SCREEN-NAME = 'GS_ALV-STCD2'.

      IF GS_ALV-KTOKK = '2000'.

        SCREEN-INPUT = 0.

        SCREEN-ACTIVE = 0.

      ELSE.

        SCREEN-INPUT = 1.

        SCREEN-ACTIVE = 1.

      ENDIF.



      IF GS_ALV-KTOKK = '3000'.

        SCREEN-INPUT = 0.

        SCREEN-ACTIVE = 0.

      ENDIF.

    ENDIF.



    IF SCREEN-NAME = 'GS_ALV-STCD1'.

      IF GS_ALV-KTOKK = '3000'.

        SCREEN-ACTIVE = 1.

      ELSE.

        SCREEN-INPUT = 0.

        SCREEN-ACTIVE = 0.

      ENDIF.

    ENDIF.









    MODIFY SCREEN.

  ENDLOOP.



ENDMODULE.