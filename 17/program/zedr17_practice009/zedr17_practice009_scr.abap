
*&---------------------------------------------------------------------*

*&  Include           ZEDR17_PRACTICE009_SCR

*&---------------------------------------------------------------------*




selection-screen begin of block b1 with frame.

select-options : s_zpernr for zedt17_102-zpernr. " ####

parameters : p_date type datbi. " #### - ####(datbi)# ####(datab) ### ##### #

parameters : p_zdepcd like zedt17_102-zdepcode. " ####

selection-screen end of block b1.



" check box: ####(ZQFLAG)

selection-screen begin of block b2 with frame.

parameters : p_zqflag as checkbox default 'X'. " #####

selection-screen end of block b2.