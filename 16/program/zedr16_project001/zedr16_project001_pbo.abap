
*&---------------------------------------------------------------------*

*&  Include           ZEDR16_PROJECT001_PBO

*&---------------------------------------------------------------------*

*&---------------------------------------------------------------------*

*&      Module  STATUS_0100  OUTPUT

*&---------------------------------------------------------------------*

*       text

*----------------------------------------------------------------------*




MODULE STATUS_0100 OUTPUT.

  SET PF-STATUS 'STATUS 0100'.



  IF P_CRE = 'X'.

    SET TITLEBAR 'T100'. " ### ##

  ELSEIF P_DIS = 'X'.

    SET TITLEBAR 'T101'. " ### ##

  ENDIF.



  LOOP AT SCREEN.



    " =======================================================

    " 1. ###/### ## (Active) - ## ## ##

    " =======================================================



    " 1-1. INPUT_STCD1 & ### ## (3000# ## ##)

    IF SCREEN-NAME = 'INPUT_STCD1' OR SCREEN-NAME = 'STCD1'.

      IF INPUT_KTOKK = '3000'.

        SCREEN-ACTIVE = '1'.

      ELSE.

        SCREEN-ACTIVE = '0'.

      ENDIF.

    ENDIF.



    " 1-2. INPUT_STCD2 & ### ## (2000# # ##)

    IF SCREEN-NAME = 'INPUT_STCD2' OR SCREEN-NAME = 'STCD2'.

      IF INPUT_KTOKK = '2000'.

        SCREEN-ACTIVE = '0'.

      ENDIF.

    ENDIF.



    " =======================================================

    " 2. ## ##/### ## (Input) - ## ## ##

    " =======================================================



    " CASE 1: ## ## (P_DIS = 'X')

    IF P_DIS = 'X'.

      " INPUT_STCD2# ## #### ##

      IF SCREEN-NAME = 'INPUT_STCD2'.

        SCREEN-INPUT = '1'.



        " ### ## ## ##(INPUT_## #### ##)# ## ##

      ELSEIF SCREEN-NAME CS 'INPUT_'.

        SCREEN-INPUT = '0'.

      ENDIF.

    ENDIF.



    " CASE 2: ## ## (P_CRE = 'X')

    IF P_CRE = 'X'.

      " # ##(####, ####, ##)# ## ##(##)

      IF SCREEN-NAME = 'INPUT_LIFNR' OR

         SCREEN-NAME = 'INPUT_BUKRS' OR

         SCREEN-NAME = 'INPUT_KTOKK'.

        SCREEN-INPUT = '0'.

      ELSE.

        " #### ## ## (##### 1### ##### ##)

        " #, ###(##) ## #### ## ## INPUT_ ### #### #

        IF SCREEN-NAME CS 'INPUT_'.

          SCREEN-INPUT = '1'.

        ENDIF.

      ENDIF.

    ENDIF.



    " ### ## ##

    MODIFY SCREEN.



  ENDLOOP.



ENDMODULE.