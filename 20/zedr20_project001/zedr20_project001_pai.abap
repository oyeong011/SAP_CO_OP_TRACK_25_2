
*&---------------------------------------------------------------------*

*&  Include           ZEDR20_PROJECT001_PAI

*&---------------------------------------------------------------------*

*&---------------------------------------------------------------------*

*&      Module  USER_COMMAND_0100  INPUT

*&---------------------------------------------------------------------*

*       text

*----------------------------------------------------------------------*




MODULE USER_COMMAND_0100 INPUT.

  CASE OK_CODE.

    WHEN 'SAVE'.

      PERFORM SAVE_DATA.

    ENDCASE.

ENDMODULE.




*&---------------------------------------------------------------------*

*&      Module  EXIT_COMMAND  INPUT

*&---------------------------------------------------------------------*

*       text

*----------------------------------------------------------------------*




MODULE EXIT_COMMAND INPUT.

  CASE OK_CODE.

    WHEN 'BACK' OR 'CANC'.

      LEAVE TO SCREEN 0.

    WHEN 'EXIT'.

      LEAVE PROGRAM.

    ENDCASE.

ENDMODULE.

MODULE F4_KTOKK INPUT.

  TYPES: BEGIN OF TY_KTOKK,

           KTOKK TYPE ZLFA1_05-KTOKK, " ##

           TEXT  TYPE C LENGTH 20,    " ##

         END OF TY_KTOKK.

  DATA: LT_KTOKK TYPE TABLE OF TY_KTOKK,

        LS_KTOKK TYPE TY_KTOKK.



  " ## ### ##

  LS_KTOKK-KTOKK = '1000'. LS_KTOKK-TEXT = '##'.       APPEND LS_KTOKK TO LT_KTOKK.

  LS_KTOKK-KTOKK = '2000'. LS_KTOKK-TEXT = '##'.       APPEND LS_KTOKK TO LT_KTOKK.

  LS_KTOKK-KTOKK = '3000'. LS_KTOKK-TEXT = '##'.       APPEND LS_KTOKK TO LT_KTOKK.

  LS_KTOKK-KTOKK = '3000'. LS_KTOKK-TEXT = '##'.       APPEND LS_KTOKK TO LT_KTOKK.

  LS_KTOKK-KTOKK = '4000'. LS_KTOKK-TEXT = '####'.   APPEND LS_KTOKK TO LT_KTOKK.

  LS_KTOKK-KTOKK = '5000'. LS_KTOKK-TEXT = '####'.   APPEND LS_KTOKK TO LT_KTOKK.

  LS_KTOKK-KTOKK = '9000'. LS_KTOKK-TEXT = '1##'.      APPEND LS_KTOKK TO LT_KTOKK.

  " ## Form ## (ITAB###, #####, ######)

  PERFORM CALL_F4_HELP USING 'KTOKK' 'GV_KTOKK' LT_KTOKK.

ENDMODULE.





MODULE F4_MWSKZ INPUT.

  TYPES: BEGIN OF TY_MWSKZ,

           MWSKZ TYPE ZLFM1_05-MWSKZ,

           TEXT  TYPE C LENGTH 20,

         END OF TY_MWSKZ.

  DATA: LT_MWSKZ TYPE TABLE OF TY_MWSKZ,

        LS_MWSKZ TYPE TY_MWSKZ.



  LS_MWSKZ-MWSKZ = 'V1'. LS_MWSKZ-TEXT = '####10%'.   APPEND LS_MWSKZ TO LT_MWSKZ.

  LS_MWSKZ-MWSKZ = 'V2'. LS_MWSKZ-TEXT = '####0%'.    APPEND LS_MWSKZ TO LT_MWSKZ.

  LS_MWSKZ-MWSKZ = 'V3'. LS_MWSKZ-TEXT = '####0%'.    APPEND LS_MWSKZ TO LT_MWSKZ.

  LS_MWSKZ-MWSKZ = 'V4'. LS_MWSKZ-TEXT = '#####'.    APPEND LS_MWSKZ TO LT_MWSKZ.

  LS_MWSKZ-MWSKZ = 'V5'. LS_MWSKZ-TEXT = '######'.  APPEND LS_MWSKZ TO LT_MWSKZ.



  PERFORM CALL_F4_HELP USING 'MWSKZ' 'GV_MWSKZ' LT_MWSKZ.

ENDMODULE.








*&---------------------------------------------------------------------*

*&      Module  F4_AKONT  INPUT

*&---------------------------------------------------------------------*




MODULE F4_AKONT INPUT.

  TYPES: BEGIN OF TY_AKONT,

           AKONT TYPE ZLFB1_05-AKONT, " #### ##

           TEXT  TYPE C LENGTH 40,    " ## (### #### ##)

         END OF TY_AKONT.



  DATA: LT_AKONT TYPE TABLE OF TY_AKONT,

        LS_AKONT TYPE TY_AKONT.



  " ## ### ## ##

  LS_AKONT-AKONT = '2100001010'. LS_AKONT-TEXT = '#####_##'.       APPEND LS_AKONT TO LT_AKONT.

  LS_AKONT-AKONT = '2100001020'. LS_AKONT-TEXT = '#####_##'.       APPEND LS_AKONT TO LT_AKONT.

  LS_AKONT-AKONT = '2100001030'. LS_AKONT-TEXT = '#####_##'.       APPEND LS_AKONT TO LT_AKONT.

  LS_AKONT-AKONT = '2100001040'. LS_AKONT-TEXT = '####'.              APPEND LS_AKONT TO LT_AKONT.

  LS_AKONT-AKONT = '2100002010'. LS_AKONT-TEXT = '####_##'.         APPEND LS_AKONT TO LT_AKONT.

  LS_AKONT-AKONT = '2100002020'. LS_AKONT-TEXT = '####_##'.         APPEND LS_AKONT TO LT_AKONT.

  LS_AKONT-AKONT = '2100002030'. LS_AKONT-TEXT = '####_####'.     APPEND LS_AKONT TO LT_AKONT.

  LS_AKONT-AKONT = '2100003010'. LS_AKONT-TEXT = '#####_####'.   APPEND LS_AKONT TO LT_AKONT.

  LS_AKONT-AKONT = '2100003020'. LS_AKONT-TEXT = '#####_##'.       APPEND LS_AKONT TO LT_AKONT.

  LS_AKONT-AKONT = '2100003030'. LS_AKONT-TEXT = '#####_###'.     APPEND LS_AKONT TO LT_AKONT.

  LS_AKONT-AKONT = '2100003040'. LS_AKONT-TEXT = '#####_###'.     APPEND LS_AKONT TO LT_AKONT.

  LS_AKONT-AKONT = '2100003050'. LS_AKONT-TEXT = '#####_##'.       APPEND LS_AKONT TO LT_AKONT.

  LS_AKONT-AKONT = '2100004010'. LS_AKONT-TEXT = '######'.          APPEND LS_AKONT TO LT_AKONT.

  LS_AKONT-AKONT = '2100005010'. LS_AKONT-TEXT = '######'.          APPEND LS_AKONT TO LT_AKONT.



  " ## ## ## (ITAB###, #####, ######)

  PERFORM CALL_F4_HELP USING 'AKONT' 'GV_AKONT' LT_AKONT.



ENDMODULE.








*&---------------------------------------------------------------------*

*&      Module  F4_ZTERM  INPUT

*&---------------------------------------------------------------------*




MODULE F4_ZTERM INPUT.

  TYPES: BEGIN OF TY_ZTERM,

           ZTERM TYPE ZLFB1_05-ZTERM, " #### ##

           TEXT  TYPE C LENGTH 30,    " ##

         END OF TY_ZTERM.



  DATA: LT_ZTERM TYPE TABLE OF TY_ZTERM,

        LS_ZTERM TYPE TY_ZTERM.



  " ## ### ## ##

  LS_ZTERM-ZTERM = 'M001'. LS_ZTERM-TEXT = '##10###'.    APPEND LS_ZTERM TO LT_ZTERM.

  LS_ZTERM-ZTERM = 'M002'. LS_ZTERM-TEXT = '##25###'.    APPEND LS_ZTERM TO LT_ZTERM.

  LS_ZTERM-ZTERM = 'M003'. LS_ZTERM-TEXT = '##10###'.    APPEND LS_ZTERM TO LT_ZTERM.

  LS_ZTERM-ZTERM = 'M004'. LS_ZTERM-TEXT = '##25###'.    APPEND LS_ZTERM TO LT_ZTERM.

  LS_ZTERM-ZTERM = 'M005'. LS_ZTERM-TEXT = '###10###'.  APPEND LS_ZTERM TO LT_ZTERM.

  LS_ZTERM-ZTERM = 'M006'. LS_ZTERM-TEXT = '###25###'.  APPEND LS_ZTERM TO LT_ZTERM.

  LS_ZTERM-ZTERM = 'P010'. LS_ZTERM-TEXT = '10#####'.    APPEND LS_ZTERM TO LT_ZTERM.

  LS_ZTERM-ZTERM = 'P015'. LS_ZTERM-TEXT = '15#####'.    APPEND LS_ZTERM TO LT_ZTERM.

  LS_ZTERM-ZTERM = 'P020'. LS_ZTERM-TEXT = '20#####'.    APPEND LS_ZTERM TO LT_ZTERM.

  LS_ZTERM-ZTERM = 'P030'. LS_ZTERM-TEXT = '30#####'.    APPEND LS_ZTERM TO LT_ZTERM.

  LS_ZTERM-ZTERM = 'P060'. LS_ZTERM-TEXT = '60#####'.    APPEND LS_ZTERM TO LT_ZTERM.

  LS_ZTERM-ZTERM = 'P090'. LS_ZTERM-TEXT = '90#####'.    APPEND LS_ZTERM TO LT_ZTERM.



  " ## ## ##

  PERFORM CALL_F4_HELP USING 'ZTERM' 'GV_ZTERM' LT_ZTERM.



ENDMODULE.






*&---------------------------------------------------------------------*

*&      Module  F4_EKGRP  INPUT

*&---------------------------------------------------------------------*




MODULE F4_EKGRP INPUT.

  TYPES: BEGIN OF TY_EKGRP,

           EKGRP TYPE ZLFM1_05-EKGRP, " #### ##

           TEXT  TYPE C LENGTH 20,    " ##

         END OF TY_EKGRP.



  DATA: LT_EKGRP TYPE TABLE OF TY_EKGRP,

        LS_EKGRP TYPE TY_EKGRP.



  " ### ##

  LS_EKGRP-EKGRP = '101'.  APPEND LS_EKGRP TO LT_EKGRP.

  LS_EKGRP-EKGRP = '102'.  APPEND LS_EKGRP TO LT_EKGRP.



  " ## ## ## (ITAB###, #####, ######)

  PERFORM CALL_F4_HELP USING 'EKGRP' 'GV_EKGRP' LT_EKGRP.



ENDMODULE.