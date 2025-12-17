
*&---------------------------------------------------------------------*

*& Report ZEDR11_PRACTICE004

*&---------------------------------------------------------------------*




REPORT ZEDR11_PRACTICE004.



" 1. ### ### #### (### ## # ### ##)

DATA: lt_target TYPE TABLE OF zedt11_001. " gt_student -> lt_target

DATA: lr_scope  TYPE RANGE OF zedt11_001-zcode. " gr_zcode -> lr_scope



" 2. Range ## (VALUE ### #### ### ##)

" ### append ## ## ## ### #### # ## ##

lr_scope = VALUE #( ( sign   = 'I'

                      option = 'BT'

                      low    = 'SSU-90'

                      high   = 'SSU-99' ) ).



START-OF-SELECTION.



  " 3. ### ## (ZEDT00_001 -> ZEDT11_001)

  " ## ##: 00#(##) ##### #### # ###(11#)# ##

  SELECT *

    FROM zedt00_001

    INTO CORRESPONDING FIELDS OF TABLE lt_target

    WHERE zcode IN lr_scope.



  IF sy-subrc <> 0.

    WRITE: / '## #### ## # ####.'.

    EXIT.

  ENDIF.



  " 4. ## # ## ## (Field-Symbol #### ## ## # ## ###)

  " ##: INTO wa -> MODIFY ... INDEX ...

  " ##: ASSIGNING <fs> (## ### ##)

  FIELD-SYMBOLS: <ls_line> TYPE zedt11_001.



  LOOP AT lt_target ASSIGNING <ls_line>.



    " Alpha ## ## ##

    CALL FUNCTION 'CONVERSION_EXIT_ALPHA_INPUT'

      EXPORTING

        input  = <ls_line>-zpernr

      IMPORTING

        output = <ls_line>-zpernr.



    " Field-Symbol# ## MODIFY ### ## ## ### ###

  ENDLOOP.



  " 5. DB ##

  IF lt_target IS NOT INITIAL.

    MODIFY zedt11_001 FROM TABLE lt_target.



    IF sy-subrc = 0.

      WRITE: / 'ZEDT11_001 ### #### ## (##:', lines( lt_target ), ')'.

    ELSE.

      WRITE: / 'DB #### ##'.

    ENDIF.

  ENDIF.