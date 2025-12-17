
*&---------------------------------------------------------------------*

*& Report ZDEL11

*&---------------------------------------------------------------------*

*&

*&---------------------------------------------------------------------*




REPORT ZDEL11.



PARAMETERS p_check AS CHECKBOX DEFAULT ' '.



START-OF-SELECTION.

  IF p_check IS INITIAL.

    MESSAGE '####: ##### ## #####.' TYPE 'E'.

  ENDIF.



  " ## ##

  DELETE FROM ztcurr11.

  IF sy-subrc = 0.

    COMMIT WORK.

    MESSAGE 'ZTCURR11 ## ## ##' TYPE 'S'.

  ELSE.

    ROLLBACK WORK.

    MESSAGE '## ##' TYPE 'E'.

  ENDIF.








*Messages

*----------------------------------------------------------

*

* Message class: Hard coded

*   ####: ##### ## #####.