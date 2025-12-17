
*&---------------------------------------------------------------------*

*& Report ZEDR12_011

*&---------------------------------------------------------------------*

*&

*&---------------------------------------------------------------------*




REPORT ZEDR12_011.

TYPES T_HELLO(20) TYPE C.   "T_HELLO## ### ### ##



DATA GV_TEXT1 TYPE T_HELLO.   "TYPE(T_HELLO)# #### ##(OBJECT) ##

DATA GV_TEXT2 LIKE GV_TEXT1. "DATA OBJECT# #### ## ##



GV_TEXT1 = 'HIHI'.

GV_TEXT2 = 'BYE'.



WRITE: GV_TEXT1.

WRITE:/ GV_TEXT2.