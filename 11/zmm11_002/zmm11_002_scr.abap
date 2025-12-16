
*&---------------------------------------------------------------------*

*& Include ZMM11_002_SCR

*&---------------------------------------------------------------------*




SELECTION-SCREEN BEGIN OF BLOCK b1 WITH FRAME TITLE text-t01.

  PARAMETERS: p_bukrs TYPE zmm11_po_head-bukrs MODIF ID key,

              p_lifnr TYPE zmm11_po_head-lifnr MODIF ID key,

              p_bedat TYPE zmm11_po_head-bedat MODIF ID gr1,

              p_ebeln TYPE zmm11_po_item-ebeln MODIF ID gr2.

SELECTION-SCREEN END OF BLOCK b1.



" [##] ### DATA #### ### ### ###. ## ### DATA ## ### #####.

SELECTION-SCREEN BEGIN OF BLOCK b2 WITH FRAME TITLE gv_titl.

  SELECTION-SCREEN BEGIN OF LINE.

    PARAMETERS: rb_new RADIOBUTTON GROUP rb1 DEFAULT 'X' USER-COMMAND cmd.

    SELECTION-SCREEN COMMENT 3(10) gv_txt1 FOR FIELD rb_new.



    PARAMETERS: rb_inq RADIOBUTTON GROUP rb1.

    SELECTION-SCREEN COMMENT 18(10) gv_txt2 FOR FIELD rb_inq.

  SELECTION-SCREEN END OF LINE.

SELECTION-SCREEN END OF BLOCK b2.