
*&---------------------------------------------------------------------*

*&  Include           ZMM05_001_PBO

*&---------------------------------------------------------------------*

*&---------------------------------------------------------------------*

*&      Module  STATUS_0100  OUTPUT

*&---------------------------------------------------------------------*

*       text

*----------------------------------------------------------------------*








MODULE status_0100 OUTPUT.

  SET PF-STATUS '0100'.

  SET TITLEBAR '0100'.



  LOOP AT SCREEN.



    IF p_view = c_x.

      screen-input = 0.

      IF GV_KTOKK <> '2000'

         AND screen-name = 'GV_STCD2'.

        screen-input = 1.

      ENDIF.



      MODIFY SCREEN.

      CONTINUE.

    ENDIF.



    IF screen-name CS 'STCD1'.

      screen-active = 0.

    ENDIF.





    IF gv_ktokk = '2000'.

      IF screen-name CS 'STCD2'.

        screen-active = 0.

      ENDIF.

    ELSEIF gv_ktokk = '3000'.

      IF screen-name CS 'STCD1'

         OR screen-name CS 'STCD2'.

        screen-active = 1.

      ENDIF.

    ENDIF.



    MODIFY SCREEN.

  ENDLOOP.



ENDMODULE.