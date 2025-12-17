
*&---------------------------------------------------------------------*

*&  Include           ZMM12_002_PBO

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

*&      Module  ALV_DISPLAY  OUTPUT

*&---------------------------------------------------------------------*

*       text

*----------------------------------------------------------------------*




MODULE ALV_DISPLAY OUTPUT.



IF GC_CUSTOM IS INITIAL.

  PERFORM CREATE_OBJECT.

  PERFORM FIELD_CATALOG.

  PERFORM ALV_LAYOUT.




*  PERFORM ALV_SORT.




 	PERFORM CLASS_EVENT.

  PERFORM ALV_DISPLAY.

ELSE.

  "REFRESH ####

  PERFORM REFRESH.

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

*&      Module  ALV_DISPLAY2  OUTPUT

*&---------------------------------------------------------------------*

*       text

*----------------------------------------------------------------------*




MODULE ALV_DISPLAY2 OUTPUT.



IF GC_CUSTOM IS INITIAL.

  PERFORM CREATE_OBJECT2.

  PERFORM FIELD_CATALOG2.

  PERFORM ALV_LAYOUT.

  PERFORM ALV_SORT.

  PERFORM ALV_DISPLAY2.




*  PERFORM CLASS_EVENT.




ELSE.

  "REFRESH ####

  PERFORM REFRESH.

ENDIF.

ENDMODULE.