
*&---------------------------------------------------------------------*

*& Report ZEDR12_SELECTOPTIONS004

*&---------------------------------------------------------------------*

*&

*&---------------------------------------------------------------------*




REPORT ZEDR12_SELECTOPTIONS004.

TABLES: ZEDT12_001.

"7) SEARCH HELP



SELECTION-SCREEN BEGIN OF BLOCK B1 WITH FRAME.

 SELECT-OPTIONS : S_ZCODE FOR ZEDT12_001-ZCODE. "SELECT-OPTIONS ### ##. #### ##.

 PARAMETERS: P_ZPERNR LIKE ZEDT12_001-ZPERNR MODIF ID M1.

 PARAMETERS: P_ZGEN LIKE ZEDT12_001-ZGENDER MATCHCODE OBJECT ZSH12_001 MODIF ID M2.

 "SEARCH HELP# #### ## ### ##### MATCHCODE OBJECT### ## ##

SELECTION-SCREEN END OF BLOCK B1.





SELECTION-SCREEN BEGIN OF BLOCK B2 WITH FRAME.

 PARAMETERS: P_R1 RADIOBUTTON GROUP R1 DEFAULT 'X' USER-COMMAND UC1.

 PARAMETERS: P_R2 RADIOBUTTON GROUP R1.

SELECTION-SCREEN END OF BLOCK B2.



AT SELECTION-SCREEN OUTPUT. "3. SELECTION-SCREEN# #### ####

  LOOP AT SCREEN.

    IF SCREEN-GROUP1 = 'M2'.  "4. MODIF ID# ## ### ##

       "SCREEN-INTENSIFIED = '1'.

       "SCREEN-DISPLAY_3D = '1'.

       "SCREEN-INVISIBLE = '1'.

      IF P_R1 = 'X'.          "5. ###### ## M2##

        SCREEN-ACTIVE = '1'.

      ELSEIF P_R2 = 'X'.

        SCREEN-ACTIVE = '0'.

      ENDIF.

    ENDIF.

    MODIFY SCREEN.

  ENDLOOP.



INITIALIZATION.

S_ZCODE-LOW = 'SSU-02'.

S_ZCODE-HIGH = 'SSU-99'.

APPEND S_ZCODE.






*AT SELECTION-SCREEN ON S_ZCODE.

*  IF S_ZCODE-LOW NE 'SSU-01'.

*    MESSAGE '##### SSU-01## #####' TYPE 'E'.

*  ENDIF.






AT SELECTION-SCREEN ON END OF S_ZCODE.

LOOP AT S_ZCODE.

  IF S_ZCODE-LOW NE 'SSU-01'.

    MESSAGE '##### SSU-01## #####.' TYPE 'E'.

  ENDIF.

ENDLOOP.








*Messages

*----------------------------------------------------------

*

* Message class: Hard coded

*   ##### SSU-01## #####.