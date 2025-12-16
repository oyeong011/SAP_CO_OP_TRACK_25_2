
*&---------------------------------------------------------------------*

*&  Include           ZMM06_003_F01

*&---------------------------------------------------------------------*

*&---------------------------------------------------------------------*

*&      Form  CONTROL_SCREEN

*&---------------------------------------------------------------------*

*       text

*----------------------------------------------------------------------*

*  -->  p1        text

*  <--  p2        text

*----------------------------------------------------------------------*




FORM CONTROL_SCREEN .



  LOOP AT SCREEN.

    IF P_FIND = 'X'.

      IF SCREEN-GROUP1 = 'M1'.

        SCREEN-ACTIVE = 0.

      ENDIF.

    ENDIF.



  MODIFY SCREEN.



  ENDLOOP.

ENDFORM.




*&---------------------------------------------------------------------*

*&      Form  CHECK_INPUT_VAILDATION

*&---------------------------------------------------------------------*

*       text

*----------------------------------------------------------------------*

*  -->  p1        text

*  <--  p2        text

*----------------------------------------------------------------------*




FORM CHECK_INPUT_VAILDATION .

  IF SY-UCOMM = 'UC1'.

    RETURN.

  ENDIF.



  IF P_EBELN IS INITIAL.

    MESSAGE '##### #####.' TYPE 'E'.

  ENDIF.



  IF P_WERKS IS INITIAL.

    MESSAGE '#### #####.' TYPE 'E'.

  ENDIF.



  IF P_GR = 'X'.

    IF P_BUDAT IS INITIAL.

      MESSAGE '###### #####.' TYPE 'E'.

    ENDIF.

  ENDIF.



  SELECT SINGLE *

    FROM ZEDT06_EKKO

    INTO @DATA(LS_EKKO)

    WHERE EBELN = @P_EBELN.



  IF SY-SUBRC <> 0.

    MESSAGE '#### ## #######.' TYPE 'E'.

  ENDIF.





  DATA LV_VALUE TYPE LVC_VALUE.



  LV_VALUE = P_WERKS.

  PERFORM CHECK_DOMAIN_VALUE USING 'ZWERKS06' LV_VALUE.

ENDFORM.




*&---------------------------------------------------------------------*

*&      Form  ALV_HANDLE_DATA_CHANGED

*&---------------------------------------------------------------------*

*       text

*----------------------------------------------------------------------*

*      -->P_ER_DATA_CHANGED  text

*      -->P_E_ONF4  text

*      -->P_E_ONF4_BEFORE  text

*      -->P_E_ONF4_AFTER  text

*      -->P_E_UCOMM  text

*----------------------------------------------------------------------*




FORM ALV_HANDLE_DATA_CHANGED

  USING PR_DATA_CHANGED TYPE REF TO CL_ALV_CHANGED_DATA_PROTOCOL

        P_ONF4

        P_ONF4_BEFORE

        P_ONF4_AFTER

        P_UCOMM.



  DATA: LS_MODI      TYPE LVC_S_MODI,

        LV_NEW_MENGE TYPE MENGE_D.



  LOOP AT PR_DATA_CHANGED->MT_MOD_CELLS INTO LS_MODI.



    " ### # ## (1##)

    READ TABLE GT_EKPO INTO GS_EKPO INDEX LS_MODI-ROW_ID.

    IF SY-SUBRC <> 0.

      CONTINUE.

    ENDIF.



    CASE LS_MODI-FIELDNAME.



      WHEN 'MENGE_IN'.

        LV_NEW_MENGE = LS_MODI-VALUE.



          IF LV_NEW_MENGE <= 0.

            PR_DATA_CHANGED->ADD_PROTOCOL_ENTRY(

              I_MSGID     = '00'

              I_MSGNO     = '001'

              I_MSGTY     = 'E'

              I_MSGV1     = '## ### 0## ## ###.'

              I_FIELDNAME = 'MENGE_IN'

              I_ROW_ID    = LS_MODI-ROW_ID

            ).

            CONTINUE.

          ENDIF.



        " ## ## ##

        IF LV_NEW_MENGE > GS_EKPO-MENGE_MAX.



          PR_DATA_CHANGED->ADD_PROTOCOL_ENTRY(

            I_MSGID     = '00'

            I_MSGNO     = '001'

            I_MSGTY     = 'E'

            I_MSGV1     = |## ### { GS_EKPO-MENGE_MAX }####.|

            I_FIELDNAME = 'MENGE_IN'

            I_ROW_ID    = LS_MODI-ROW_ID

          ).



          CONTINUE.

        ENDIF.



        " ## ## # # ##

        GS_EKPO-MENGE_IN = LV_NEW_MENGE.

        GS_EKPO-MENGE = GS_EKPO-MENGE_IN.



      WHEN 'SEL'.

        GS_EKPO-SEL = LS_MODI-VALUE.

        GS_MSEG_ALV-SEL = LS_MODI-VALUE.



      WHEN OTHERS.

        CONTINUE.



    ENDCASE.



    " ## ### ##

    MODIFY GT_EKPO FROM GS_EKPO INDEX LS_MODI-ROW_ID.



  ENDLOOP.



ENDFORM.




*&---------------------------------------------------------------------*

*&      Form  HANDLE_DATA_CHANGED_300

*&---------------------------------------------------------------------*

*       text

*----------------------------------------------------------------------*

*      -->P_ER_DATA_CHANGED  text

*      -->P_E_ONF4  text

*      -->P_E_ONF4_BEFORE  text

*      -->P_E_ONF4_AFTER  text

*      -->P_E_UCOMM  text

*----------------------------------------------------------------------*




FORM ALV_HANDLE_DATA_CHANGED_300

  USING PR_DATA_CHANGED TYPE REF TO CL_ALV_CHANGED_DATA_PROTOCOL

        P_ONF4

        P_ONF4_BEFORE

        P_ONF4_AFTER

        P_UCOMM.



  DATA: LS_MODI TYPE LVC_S_MODI,

        LS_MSEG TYPE TY_MSEG.



  LOOP AT PR_DATA_CHANGED->MT_MOD_CELLS INTO LS_MODI.



    READ TABLE GT_MSEG_ALV INTO LS_MSEG INDEX LS_MODI-ROW_ID.

    IF SY-SUBRC <> 0.

      CONTINUE.

    ENDIF.



    CASE LS_MODI-FIELDNAME.

      WHEN 'SEL'.

        LS_MSEG-SEL = LS_MODI-VALUE.

    ENDCASE.



    MODIFY GT_MSEG_ALV FROM LS_MSEG INDEX LS_MODI-ROW_ID.



  ENDLOOP.



ENDFORM.




*&---------------------------------------------------------------------*

*&      Form  CHECK_DOMAIN_VALUE

*&---------------------------------------------------------------------*

*       text

*----------------------------------------------------------------------*

*      -->P_0093   text

*      -->P_LV_VALUE  text

*----------------------------------------------------------------------*




FORM CHECK_DOMAIN_VALUE

  USING

    P_DOMNAME TYPE DD07L-DOMNAME

    P_VALUE   TYPE LVC_VALUE.



  DATA LV_DUMMY TYPE DD07L-DOMVALUE_L.



  SELECT SINGLE DOMVALUE_L

    INTO LV_DUMMY

    FROM DD07L

    WHERE DOMNAME    = P_DOMNAME

      AND DOMVALUE_L = P_VALUE.



  IF SY-SUBRC <> 0.

    MESSAGE |### { P_DOMNAME }# #### ## ####.| TYPE 'E'.

  ENDIF.



ENDFORM.