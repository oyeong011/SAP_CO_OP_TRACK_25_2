
*&---------------------------------------------------------------------*

*& Report ZEDR19_012

*&---------------------------------------------------------------------*

*&

*&---------------------------------------------------------------------*




REPORT ZEDR19_012.



TYPES T_HELLO(20) TYPE C. "T_HELLO## ### ####



DATA GV_TEXT1 TYPE T_HELLO. "TYPE(T_HELLO)# #### ##(object) ##

DATA GV_TEXT2 LIKE GV_TEXT1. "DATA Object# #### ##(object) ##



GV_TEXT1 = '#####'.

GV_TEXT2 = '#####'.



WRITE : GV_TEXT1.

WRITE :/ GV_TEXT2.