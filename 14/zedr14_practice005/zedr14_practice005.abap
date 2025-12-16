
*&---------------------------------------------------------------------*

*& Report ZEDR14_PRACTICE005

*&---------------------------------------------------------------------*

*&

*&---------------------------------------------------------------------*




REPORT ZEDR14_PRACTICE005.



"FUNCTION ##2

DATA : GV_DATE TYPE DATS,

       GV_LAST_DATE TYPE SY-DATUM.



RANGES GR_MONTH FOR BKPF-MONAT.

GR_MONTH-SIGN = 'I'.

GR_MONTH-OPTION = 'BT'.

GR_MONTH-LOW = '01'.

GR_MONTH-HIGH = '12'.

APPEND GR_MONTH.



SELECTION-SCREEN BEGIN OF BLOCK B1 WITH FRAME.

  PARAMETERS : P_YEAR  TYPE BKPF-GJAHR,

               P_MONTH TYPE BKPF-MONAT.

SELECTION-SCREEN END OF BLOCK B1.



INITIALIZATION.



  P_YEAR = SY-DATUM(4).

  P_MONTH = SY-DATUM+4(2).



START-OF-SELECTION.



  IF P_MONTH IN GR_MONTH.

    CONCATENATE P_YEAR P_MONTH '01' INTO GV_DATE.



    CALL FUNCTION 'RP_LAST_DAY_OF_MONTHS'

      EXPORTING

        DAY_IN = GV_DATE

      IMPORTING

        LAST_DAY_OF_MONTH = GV_LAST_DATE.



    IF SY-SUBRC = 0.

      WRITE :/ P_YEAR, '#', P_MONTH, '## #####', GV_LAST_DATE, '###'.

    ELSE.

      WRITE :/ '## ## # ### ######.'.

    ENDIF.

  ELSE.

    MESSAGE '# ### #### ####' TYPE 'S' DISPLAY LIKE 'E'.

  ENDIF.








*Messages

*----------------------------------------------------------

*

* Message class: Hard coded

*   # ### #### ####