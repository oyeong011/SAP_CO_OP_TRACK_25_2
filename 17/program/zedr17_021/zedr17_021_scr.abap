
*&---------------------------------------------------------------------*

*&  Include           ZEDR17_021_SCR

*&---------------------------------------------------------------------*




selection-screen begin of block b1 with frame.

  select-options : s_zcode for zedt17_001-zcode.

  parameters : p_zpernr like zedt17_001-zpernr.

  parameters : p_zgen like zedt17_001-zgender modif id sc1.

selection-screen end of block b1.