
*&---------------------------------------------------------------------*

*& Report ZEDR12_IT_17

*&---------------------------------------------------------------------*

*&

*&---------------------------------------------------------------------*




REPORT ZEDR12_IT_017.

DATA: VAL1 TYPE I.

DATA: VAL2 TYPE I.

DATA: VAL3 TYPE I.



VAL1 = '100'.

VAL2 = '120'.

VAL3 = '110'.



IF VAL1 > VAL2.

  WRITE:/ 'VAL1# VAL2## #'.

ELSEIF VAL1 = VAL2.

  WRITE:/ 'VAL1#  VAL2 ##'.

  ELSE.

    WRITE:/ 'VAL1# VAL2## ##'.

 ENDIF.



 IF ( VAL1 < VAL2 ) AND ( VAL1 < VAL3 ).

   WRITE:/ 'VAL1# VAL2, VAL3 ## ##'.

   ENDIF.



   IF VAL1 < VAL2.

     WRITE:/ 'VAL2# VAL1## #'.

     ELSE.

       WRITE:/ 'VAL2# VAL1 ##'.

       ENDIF.



  IF ( VAL1 > VAL2 ) AND ( VAL1 > VAL3 ).

    WRITE:/ 'VAL1 # #'.

  ELSEIF ( VAL2 > VAL1 ) AND ( VAL2 > VAL3 ).

    WRITE:/ 'VAL2 # #'.

  ELSEIF ( VAL3 > VAL1 ) AND ( VAL3 > VAL2 ).

    WRITE:/ 'VAL3 # #'.

  ELSE.

    WRITE:/ '##'.

    ENDIF.