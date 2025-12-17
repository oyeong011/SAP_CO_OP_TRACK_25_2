
*&---------------------------------------------------------------------*

*&  Include           ZEDR16_PROJECT002_PBO

*&---------------------------------------------------------------------*

*&---------------------------------------------------------------------*

*&      Module  STATUS_0100  OUTPUT

*&---------------------------------------------------------------------*

*       text

*----------------------------------------------------------------------*




MODULE STATUS_0100 OUTPUT.




*  SET PF-STATUS 'STATUS 0100'.

*  SET TITLEBAR 'T100'.




  " ### ### ## ## ### ##

  DATA : LT_EXCLUDE TYPE TABLE OF SY-UCOMM.



  CLEAR LT_EXCLUDE.



  " 1. ## ##(P_DIS)# # ## ## ## ##

  IF P_DIS = 'X'.

    APPEND 'ADD'    TO LT_EXCLUDE.

    APPEND 'REMOVE' TO LT_EXCLUDE.

    APPEND 'SAVE'   TO LT_EXCLUDE.

  ENDIF.



  " 2. EXCLUDING ### #### STATUS ##

  " LT_EXCLUDE# #### ### ##(Toolbar)## ###

  SET PF-STATUS 'STATUS 0100' EXCLUDING LT_EXCLUDE.

  SET TITLEBAR 'T100'.



  LOOP AT SCREEN.

    " ## ## ### 'GS_HEADER-'# #### ###

    IF SCREEN-NAME CS 'GS_HEADER-'.

      SCREEN-INPUT = 0. " ## #### (0: Output Only, 1: Input possible)

    ENDIF.



    IF SCREEN-NAME = 'GS_HEADER-EBELN' OR SCREEN-NAME = 'TF_EBELN'.



      IF P_CRE = 'X'.

        " ## ### ## ##

        SCREEN-ACTIVE = 0.

      ELSE.

        " ## ##(P_DIS)# ## ##

        SCREEN-ACTIVE = 1.

      ENDIF.



    ENDIF.



    MODIFY SCREEN.    " ## ## ##

  ENDLOOP.



ENDMODULE.




*&---------------------------------------------------------------------*

*&      Module  SET_ALV  OUTPUT

*&---------------------------------------------------------------------*

*       text

*----------------------------------------------------------------------*




MODULE SET_ALV OUTPUT.



  IF GC_CUSTOM IS INITIAL.

    PERFORM CREATE_OBJECT.

    PERFORM FIELD_CATALOG.

    PERFORM ALV_LAYOUT.




*    PERFORM ALV_SORT.




    PERFORM CLASS_EVENT.

    PERFORM CALL_ALV.

  ELSE.

    PERFORM REFRESH.

  ENDIF.



ENDMODULE.