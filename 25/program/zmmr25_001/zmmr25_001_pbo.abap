
*&---------------------------------------------------------------------*

*&  Include           ZMMR25_001_PBO

*&---------------------------------------------------------------------*

*&---------------------------------------------------------------------*

*&      Module  STATUS_0100  OUTPUT

*&---------------------------------------------------------------------*




MODULE status_0100 OUTPUT.

  IF p_view = c_x.

    SET PF-STATUS '0100' EXCLUDING 'ADD'.

  ELSE.

    SET PF-STATUS '0100'.

  ENDIF.



  SET TITLEBAR '0100'.



  zedt25_lfa1-ktokk = gv_ktokk.

  zedt25_lfb1-bukrs = gv_bukrs.



  LOOP AT SCREEN.

    " 1) ##### ##/## (## + ###)

    IF GV_KTOKK = '1000'.

      " 1000(##): #####(STCD2)# ##, ####(STCD1) ##

      IF SCREEN-NAME CS 'STCD1'.  " ## + ### ##

        SCREEN-ACTIVE = 0.

      ELSEIF SCREEN-NAME CS 'STCD2'.  " ## + ### ##

        SCREEN-ACTIVE = 1.

      ENDIF.

    ELSEIF GV_KTOKK = '3000'.

      " 3000(##): ####(STCD1) + #####(STCD2) # # ##

      IF SCREEN-NAME CS 'STCD1' OR SCREEN-NAME CS 'STCD2'.

        SCREEN-ACTIVE = 1.

      ENDIF.

    ELSE.

      " 2000 # ##: # # ## (## + ###)

      IF SCREEN-NAME CS 'STCD1' OR SCREEN-NAME CS 'STCD2'.

        SCREEN-ACTIVE = 0.

      ENDIF.

    ENDIF.



    " 2) ## ##: ## ##

    IF P_VIEW = C_X.

      " ##### ##### ####

      IF SCREEN-NAME = 'GV_NAME1' OR SCREEN-NAME = 'GV_LAND1' OR

         SCREEN-NAME = 'GV_STRAS' OR SCREEN-NAME = 'GV_AKONT' OR

         SCREEN-NAME = 'GV_ZTERM' OR SCREEN-NAME = 'GV_EKORG' OR

         SCREEN-NAME = 'GV_EKGRP' OR SCREEN-NAME = 'GV_WAERS' OR

         SCREEN-NAME = 'GV_MWSKZ' OR SCREEN-NAME = 'GV_LIFNR' OR

         SCREEN-NAME = 'GV_BUKRS' OR SCREEN-NAME = 'ZEDT25_LFA1-KTOKK' OR

         SCREEN-NAME = 'ZEDT25_LFB1-BUKRS'.

        SCREEN-INPUT = 0.

      ENDIF.



      " #### ## ## ##: ###### # ###

      IF GV_KTOKK = '1000' AND SCREEN-NAME CS 'STCD2'.

        IF SCREEN-NAME = 'GV_STCD2'.  " ### ## ##

          SCREEN-INPUT = 1.

        ENDIF.

        SCREEN-ACTIVE = 1.  " ## + ### ##

      ELSEIF GV_KTOKK = '3000'.

        IF SCREEN-NAME CS 'STCD1'.

          IF SCREEN-NAME = 'GV_STCD1'.  " STCD1# ## ##

            SCREEN-INPUT = 1.

          ENDIF.

          SCREEN-ACTIVE = 1.  " ## + ### ##

        ELSEIF SCREEN-NAME CS 'STCD2'.

          IF SCREEN-NAME = 'GV_STCD2'.  " STCD2# ## ##

            SCREEN-INPUT = 0.

          ENDIF.

          SCREEN-ACTIVE = 1.  " ## + ### ##

        ENDIF.

      ENDIF.



      " ## ## ###

      IF SCREEN-NAME CS 'EXPLANATION'.

        SCREEN-ACTIVE = 0.

      ENDIF.

    ENDIF.



    MODIFY SCREEN.

  ENDLOOP.

ENDMODULE.






*&---------------------------------------------------------------------*

*&      Module  SET_ALV  OUTPUT

*&---------------------------------------------------------------------*




MODULE set_alv OUTPUT.

  IF p_cre = c_x.

    IF go_container IS INITIAL.

      PERFORM create_alv_object.

      PERFORM build_fieldcatalog.

      PERFORM build_layout.

      PERFORM display_alv.

    ELSE.

      PERFORM refresh_alv.

    ENDIF.

  ENDIF.

ENDMODULE.