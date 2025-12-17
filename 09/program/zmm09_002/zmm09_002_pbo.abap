
*&---------------------------------------------------------------------*

*&  Include           ZMM09_002_PBO

*&---------------------------------------------------------------------*

*&---------------------------------------------------------------------*

*&      Module  STATUS_0100  OUTPUT

*&---------------------------------------------------------------------*




MODULE STATUS_0100 OUTPUT.

  SET PF-STATUS 'STATUS_0100'.

  SET TITLEBAR 'T100'.

ENDMODULE.






*&---------------------------------------------------------------------*

*&      Module  GET_HEADER  OUTPUT

*&---------------------------------------------------------------------*




MODULE GET_HEADER OUTPUT.

  "###

  GF_BEDAT = P_BEDAT.



  "####/####

  SELECT SINGLE EKORG EKGRP

  FROM ZLFM1_09

  INTO ( GF_EKORG, GF_EKGRP )

  WHERE LIFNR = P_LIFN_C.



  "####

  GF_BUKRS = P_BUKR_C.



  "####

  SELECT SINGLE NAME1

  FROM ZLFA1_09

  INTO GF_NAME1

  WHERE LIFNR = P_LIFN_C.

ENDMODULE.








*&---------------------------------------------------------------------*

*&      Module  MODIFY_SCREEN  OUTPUT

*&---------------------------------------------------------------------*

*       text

*----------------------------------------------------------------------*




MODULE MODIFY_SCREEN OUTPUT.

  CLEAR : OK_CODE.

  "## #### ###### ## ####

  DESCRIBE TABLE GT_ITEM LINES TC_ITEMS-LINES.



  "######## ###### #### ####

  READ TABLE GT_ITEM INTO GS_ITEM INDEX TC_ITEMS-CURRENT_LINE.

ENDMODULE.






*&---------------------------------------------------------------------*

*&      Module  STATUS_0200  OUTPUT

*&---------------------------------------------------------------------*




MODULE STATUS_0200 OUTPUT.

  SET PF-STATUS 'STATUS_0200'.

  SET TITLEBAR 'T200'.

ENDMODULE.






*&---------------------------------------------------------------------*

*&      Module  SET_ALV  OUTPUT

*&---------------------------------------------------------------------*




MODULE SET_ALV OUTPUT.

  PERFORM CREATE_OBJECT.

  PERFORM FIELD_CATALOG.

  PERFORM ALV_LAYOUT.

  PERFORM CALL_ALV.

ENDMODULE.