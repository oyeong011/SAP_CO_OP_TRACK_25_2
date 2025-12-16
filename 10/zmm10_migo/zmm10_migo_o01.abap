
*&---------------------------------------------------------------------*

*&  Include           ZMM10_MIGO_O01

*&---------------------------------------------------------------------*




MODULE STATUS_0100 OUTPUT.

  SET PF-STATUS 'S100'. " GUI Status ##

  SET TITLEBAR 'T100'.  " ### ##

ENDMODULE.




*&---------------------------------------------------------------------*

*&      Module  SET_ALV  OUTPUT

*&---------------------------------------------------------------------*

*       text

*----------------------------------------------------------------------*




MODULE SET_ALV OUTPUT.



  IF GO_CONTAINER IS INITIAL.

    " 1. #### # ALV ##

    CREATE OBJECT GO_CONTAINER

      EXPORTING CONTAINER_NAME = 'CC_ALV'.



    CREATE OBJECT GO_ALV

      EXPORTING I_PARENT = GO_CONTAINER.



    " 2. #### # FCAT ##

    PERFORM SET_LAYOUT.

    PERFORM SET_FCAT.



    " 3. [##] ### ### ## (ALV ## ## ## ##)

    PERFORM REGI_EVENT.



    " 4. ALV ##

    CALL METHOD GO_ALV->SET_TABLE_FOR_FIRST_DISPLAY

      EXPORTING

        IS_LAYOUT       = GS_LAYOUT

      CHANGING

        IT_OUTTAB       = GT_ITEM

        IT_FIELDCATALOG = GT_FCAT.

  ELSE.

    " ## ##

    PERFORM REFRESH_ALV.

  ENDIF.



ENDMODULE.