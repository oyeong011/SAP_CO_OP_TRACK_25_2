
*&---------------------------------------------------------------------*

*& Report ZEDR12_SELECTOPTIONS003

*&---------------------------------------------------------------------*

*&

*&---------------------------------------------------------------------*




REPORT ZEDR12_SELECTOPTIONS003.

TABLES: ZEDT12_001.

"1.### ### #### ###

SELECTION-SCREEN BEGIN OF BLOCK B1 WITH FRAME.

 SELECT-OPTIONS : S_ZCODE FOR ZEDT12_001-ZCODE. "SELECT-OPTIONS ### ##. #### ##.

 PARAMETERS: P_ZPERNR LIKE ZEDT12_001-ZPERNR MODIF ID M1.

 PARAMETERS: P_ZGEN LIKE ZEDT12_001-ZGENDER MODIF ID M2.

SELECTION-SCREEN END OF BLOCK B1.



"2. Selection Screen############## USER-COMMAND fcode#####

SELECTION-SCREEN BEGIN OF BLOCK B2 WITH FRAME.

 PARAMETERS: P_R1 RADIOBUTTON GROUP R1 DEFAULT 'X' USER-COMMAND UC1. "USER-COMMNAND#######?

 "PARAMETERS: P_R1 RADIOBUTTON GROUP R1 DEFAULT 'X' . "ENTER ### #### ####

 PARAMETERS: P_R2 RADIOBUTTON GROUP R1.

SELECTION-SCREEN END OF BLOCK B2.



AT SELECTION-SCREEN OUTPUT. "3. SELECTION-SCREEN# #### ####

  LOOP AT SCREEN.

    IF SCREEN-GROUP1 = 'M2'.  "4. MODIF ID# ## ### ##

       SCREEN-INTENSIFIED = '1'.

       SCREEN-DISPLAY_3D = '1'.

       "SCREEN-INVISIBLE = '1'.

      IF P_R1 = 'X'.          "5. ###### ## M2##

        SCREEN-ACTIVE = '1'.

      ELSEIF P_R2 = 'X'.

        SCREEN-ACTIVE = '0'.

      ENDIF.

    ENDIF.

    MODIFY SCREEN.

  ENDLOOP.