
*&---------------------------------------------------------------------*

*&  Include           ZMM22_002_PBO

*&---------------------------------------------------------------------*

*&---------------------------------------------------------------------*

*&      Module  STATUS_0100  OUTPUT

*&---------------------------------------------------------------------*

*       text

*----------------------------------------------------------------------*




MODULE STATUS_0100 OUTPUT.

  SET PF-STATUS 'STATUS_0100'.

  SET TITLEBAR 'T100'.

ENDMODULE.




*&---------------------------------------------------------------------*

*&      Module  INIT_HEADER  OUTPUT

*&---------------------------------------------------------------------*

*       text

*----------------------------------------------------------------------*




MODULE INIT_HEADER OUTPUT.



  " ## # ### ## ##

  IF GS_HEADER-BUKRS IS INITIAL.



    " selection-screen ### ## ##

    IF P_CRE = 'X'.

      GS_HEADER-BUKRS = P_BUKRS.

      GS_HEADER-LIFNR = P_LIFNR.

      GS_HEADER-BEDAT = P_BEDAT.

      "GS_HEADER-WAERS = 'KRW'.

    ENDIF.



    " ####/#### ##

    CLEAR ZLFM1_22.

    SELECT SINGLE *

      INTO @ZLFM1_22

      FROM ZLFM1_22

     WHERE LIFNR = @P_LIFNR.



    IF sy-subrc = 0.

      GS_HEADER-EKORG = ZLFM1_22-EKORG.

      GS_HEADER-EKGRP = ZLFM1_22-EKGRP.

    ENDIF.



  ENDIF.



  " ## ### ## ##

  LOOP AT SCREEN.

    IF screen-name = 'GS_HEADER-BUKRS'

    OR screen-name = 'GS_HEADER-LIFNR'

    OR screen-name = 'GS_HEADER-BEDAT'

    OR screen-name = 'GS_HEADER-EKORG'

    OR screen-name = 'GS_HEADER-EKGRP'.

      screen-input = 0.

      MODIFY SCREEN.

    ENDIF.

  ENDLOOP.



ENDMODULE.




*&---------------------------------------------------------------------*

*&      Module  SET_ALV  OUTPUT

*&---------------------------------------------------------------------*

*       text

*----------------------------------------------------------------------*




MODULE SET_ALV OUTPUT.

  IF GC_GRID IS INITIAL.

    PERFORM CREATE_OBJECT.

    PERFORM FIELD_CATALOG.

    PERFORM ALV_LAYOUT.

    PERFORM CALL_ALV.

    PERFORM CLASS_EVENT.

  ENDIF.

ENDMODULE.




*&---------------------------------------------------------------------*

*&      Module  STATUS_0200  OUTPUT

*&---------------------------------------------------------------------*

*       text

*----------------------------------------------------------------------*




MODULE STATUS_0200 OUTPUT.

  SET PF-STATUS 'STATUS_0200'.

  SET TITLEBAR 'T200'.

ENDMODULE.




*&---------------------------------------------------------------------*

*&      Module  SET_ALV_0200  OUTPUT

*&---------------------------------------------------------------------*

*       text

*----------------------------------------------------------------------*




MODULE SET_ALV_0200 OUTPUT.

  IF GC_DOCKING IS INITIAL.

    PERFORM CREATE_OBJECT_200.

    PERFORM FIELD_CATALOG_200.

    PERFORM ALV_LAYOUT_200.

    PERFORM CALL_ALV_200.

  ELSE.

    PERFORM REFRESH.

  ENDIF.



ENDMODULE.