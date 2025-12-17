
*&---------------------------------------------------------------------*

*&  Include           ZMM02_001_TOP

*&---------------------------------------------------------------------*




TABLES: ZLFA1_02, ZLFB1_02, ZLFM1_02.



DATA: GS_LFA1 TYPE ZLFA1_02,

      GS_LFB1 TYPE ZLFB1_02,

      GS_LFM1 TYPE ZLFM1_02,

      GT_LFA1 TYPE TABLE OF ZLFA1_02,

      GT_LFB1 TYPE TABLE OF ZLFB1_02,

      GT_LFM1 TYPE TABLE OF ZLFM1_02.



DATA: BEGIN OF GS_VENDOR,

  LIFNR TYPE LIFNR, "#####

  NAME1 TYPE NAME1_GP, "####

  LAND1 TYPE LAND1_GP, "###

  KTOKK TYPE KTOKK, "#####

  STCD1 TYPE STCD1, "####

  STCD2 TYPE STCD2, "#####

  STRAS TYPE STRAS_GP, "##

  BUKRS TYPE BUKRS, "####

  LOEVM_B TYPE LOEVM_B, "#### #####

  AKONT TYPE AKONT, "##

  ZTERM TYPE DZTERM, "####

  EKORG TYPE EKORG, "####

  EKGRP TYPE EKGRP, "####

  LOEVM_M TYPE LOEVM_M, "#### #####

  WAERS TYPE WAERS, "######

  MWSKZ TYPE MWSKZ, "####

END OF GS_VENDOR.

DATA: GT_VENDOR LIKE TABLE OF GS_VENDOR.



DATA : OK_CODE TYPE SY-UCOMM,

       G_KTOKK LIKE ZLFA1_02-KTOKK, "#####

       G_BUKRS LIKE ZLFB1_02-BUKRS, "####

       G_STRAS LIKE ZLFA1_02-STRAS, "##

       G_STCD1 LIKE ZLFA1_02-STCD1, "####

       G_STCD2 LIKE ZLFA1_02-STCD2, "#####

       G_AKONT LIKE ZLFB1_02-AKONT, "##

       G_ZTERM LIKE ZLFB1_02-ZTERM, "####

       G_MWSKZ LIKE ZLFM1_02-MWSKZ, "####

       G_EKORG LIKE ZLFM1_02-EKORG, "####

       G_EKGRP LIKE ZLFM1_02-EKGRP, "####

       G_WAERS LIKE ZLFM1_02-WAERS, "######

       G_NAME1 LIKE ZLFA1_02-NAME1, "####

       G_LAND1 LIKE ZLFA1_02-LAND1, "###

       G_LIFNR LIKE ZLFA1_02-LIFNR, "#####

       G_LOEVM_B LIKE ZLFB1_02-LOEVM, "#### #####

       G_LOEVM_M LIKE ZLFM1_02-LOEVM, "#### #####

       G_CURSOR_FIELD TYPE SCREEN-NAME. "## ##