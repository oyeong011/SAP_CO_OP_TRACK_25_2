
*&---------------------------------------------------------------------*

*&  Include           ZEDR17_PRACTICE008_SCR

*&---------------------------------------------------------------------*






" ####(ZORDNO), ##ID(ZIDCODE), ####(ZMATNR), ####/####(ZJDATE)

selection-screen begin of block b1 with frame.

select-options : s_zordno for zedt17_100-zordno. " ####

parameters : p_zidcd like zedt17_100-zidcode. " ##ID, ### 8#### ##

select-options : s_zmatnr for zedt17_100-zmatnr. " ####

select-options : s_ordate for gv_char_date modif id sc1. " ####, ## ### ## modif id ##

select-options : s_shdate for gv_char_date modif id sc2. " ####, ## ### ## modif id ##

selection-screen end of block b1.



" radio button: ####(zedt17_100), ####(zedt17_101)

selection-screen begin of block b2 with frame.

parameters : p_order radiobutton group r1 default 'X' user-command uc1. " ####, selection-screen ## ### ###### user-command fcode ### (uc1)

parameters : p_ship radiobutton group r1. " ####

selection-screen end of block b2.



" check box: ######/####(ZRET_FG)

selection-screen begin of block b3 with frame.

parameters : p_return as checkbox default 'X'. " ######

selection-screen end of block b3.