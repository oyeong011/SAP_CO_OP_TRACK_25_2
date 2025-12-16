
*&---------------------------------------------------------------------*

*&  Include           ZMM02_002_PBO

*&---------------------------------------------------------------------*

*&---------------------------------------------------------------------*

*&      Module  STATUS_0100  OUTPUT

*&---------------------------------------------------------------------*

*       text

*----------------------------------------------------------------------*




MODULE STATUS_0100 OUTPUT.

  SET PF-STATUS 'STATUS 0100'.

  SET TITLEBAR 'T100'.

ENDMODULE.




*&---------------------------------------------------------------------*

*&      Module  SET_ALV  OUTPUT

*&---------------------------------------------------------------------*

*       text

*----------------------------------------------------------------------*




MODULE SET_ALV OUTPUT.

  IF GC_CUSTOM IS INITIAL. "#### ##

    PERFORM CREATE_OBJECT.

    IF P_CRE = 'X'. "##

      PERFORM FIELD_CATALOG_100.

    ELSEIF P_VIEW = 'X'. "##

      PERFORM FIELD_CATALOG_200.

    ENDIF.

    PERFORM ALV_LAYOUT.

    PERFORM ALV_SORT.

    PERFORM CLASS_EVENT.

    IF P_CRE = 'X'. "##

      PERFORM CALL_ALV_100.

    ELSEIF P_VIEW = 'X'. "##

      PERFORM CALL_ALV_200.

    ENDIF.

  ELSE.

    PERFORM REFRESH.

  ENDIF.

ENDMODULE.




*&---------------------------------------------------------------------*

*&      Module  SET_DATA100  OUTPUT

*&---------------------------------------------------------------------*

*       text

*----------------------------------------------------------------------*




MODULE SET_DATA100 OUTPUT. "### ##

  G_BUKRS = P_BUKRS. "####

  G_EKGRP = GS_LFM1-EKGRP. "####

  G_EKORG = GS_LFM1-EKORG. "####

  G_LIFNR = P_LIFNRC. "###

  G_BEDAT = P_BEDAT. "###

  G_WAERS = GS_LFM1-WAERS. "##

ENDMODULE.




*&---------------------------------------------------------------------*

*&      Module  STATUS_0200  OUTPUT

*&---------------------------------------------------------------------*

*       text

*----------------------------------------------------------------------*




MODULE STATUS_0200 OUTPUT.

  SET PF-STATUS 'STATUS 0200'.

  SET TITLEBAR 'T200'.

ENDMODULE.




*&---------------------------------------------------------------------*

*&      Module  SET_DATA200  OUTPUT

*&---------------------------------------------------------------------*

*       text

*----------------------------------------------------------------------*




MODULE SET_DATA200 OUTPUT. "### ##

  G_EBELN = P_EBELN. "######

  G_BUKRS = P_BUKRS. "####

  G_EKGRP = GS_EKKO-EKGRP. "####

  G_EKORG = GS_EKKO-EKORG. "####

  G_LIFNR = P_LIFNRV. "###

  G_BEDAT = GS_EKKO-BEDAT. "###

  G_WAERS = GS_EKKO-WAERS. "##

ENDMODULE.