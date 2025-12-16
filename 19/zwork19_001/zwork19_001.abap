
*&---------------------------------------------------------------------*

*& Report ZWORK19_001

*&---------------------------------------------------------------------*

*&

*&---------------------------------------------------------------------*




REPORT ZWORK19_001 MESSAGE-ID ZMED19.



include
ZWORK19_001_TOP
. "## ##/##/###

include
ZWORK19_001_SCR
. "####(Selection Screen)

include
ZWORK19_001_F01
. "FORM ##

include
ZWORK19_001_PBO
. "## PBO

include
ZWORK19_001_PAI
. "## PAI



INITIALIZATION. "### ##

  PERFORM INIT_DEFAULTS.



AT SELECTION-SCREEN OUTPUT. "## ## ## (#### = M ##)

  PERFORM SET_SCREEN.



AT SELECTION-SCREEN.

  CASE sscrfields-ucomm.

    WHEN 'FC01'.              "Application Toolbar: ### ####

      PERFORM download_template.

      CLEAR sscrfields-ucomm.



    WHEN 'ONLI'.              "F8 ##

      IF p_file IS INITIAL.

        MESSAGE e000(zmed19) WITH '## ### #####.'.

      ENDIF.

  ENDCASE.





"--- ###(F8### ##)

START-OF-SELECTION.

  PERFORM read_excel_to_itab.

  PERFORM build_fieldcat.

  CALL SCREEN 100.






*GUI Texts

*----------------------------------------------------------

* TIT1 --> ## ####





*Messages

*----------------------------------------------------------

*

* Message class: Hard coded

*   ## ### #######.