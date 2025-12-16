
*&---------------------------------------------------------------------*

*&  Include           ZMM06_003_FF

*&---------------------------------------------------------------------*




" 1xxx=####(####),

" 2xxx=##(GR/IR#####),

" 3xxx=##(######),

" 4xxx=##(##),

" 5xxx=##(####),

" 6xxx=##(###),

" 9xxx=###/####






*&---------------------------------------------------------------------*

*&  Include           ZMM06_003_F02

*&---------------------------------------------------------------------*

*&---------------------------------------------------------------------*

*&      Form  RECEIVING_PROCESSING

*&---------------------------------------------------------------------*

*       text

*----------------------------------------------------------------------*

*  -->  p1        text

*  <--  p2        text

*----------------------------------------------------------------------*




FORM CREATE_FI_DOC_FOR_GR

  USING

    PV_MBLNR TYPE ZEDT06_MKPF-MBLNR

    PV_MJAHR TYPE ZEDT06_MKPF-MJAHR

    PV_BUKRS TYPE ZEDT06_BKPF-BUKRS.



  DATA: LV_BELNR TYPE ZEDT06_BKPF-BELNR,  " FI ####

        LV_GJAHR TYPE ZEDT06_BKPF-GJAHR,  " FI ## ####

        LV_BUZEI TYPE ZEDT06_BSEG-BUZEI,  " ## ### ##

        LV_TOTAL TYPE ZEDT06_BSEG-DMBTR.  " GR/IR ### ###

  DATA: LS_LFM1 TYPE ZEDT06_LFM1.



  "---------------------------------------------------------------

  " 1. FI #### ##

  "---------------------------------------------------------------

  PERFORM GET_NEXT_BELNR CHANGING LV_BELNR LV_GJAHR.



  "---------------------------------------------------------------

  " 2. BKPF (## ##) ##

  "   - # ### GR(##)### ##### ##

  "---------------------------------------------------------------

  PERFORM INSERT_BKPF

    USING LV_BELNR

          LV_GJAHR

          PV_MBLNR

          PV_MJAHR

          PV_BUKRS.



  "---------------------------------------------------------------

  " 3. BSEG  ## ## ##

  "   - ### ##(MSEG) ####

  "   - ### #### ##

  "---------------------------------------------------------------

  LV_BUZEI = 10.

  CLEAR LV_TOTAL.



  " ### ## #### ##.

  SELECT SINGLE * FROM ZEDT06_LFM1

    INTO CORRESPONDING FIELDS OF LS_LFM1

    WHERE LIFNR = GS_EKKO-LIFNR.



  LOOP AT GT_MSEG INTO GS_MSEG

    WHERE MBLNR = PV_MBLNR

      AND MJAHR = PV_MJAHR.



    " ### ## ## ## ##

    PERFORM INSERT_BSEG_STOCK

      USING LV_BELNR

            LV_GJAHR

            LV_BUZEI

            LS_LFM1-MWSKZ

            GS_MSEG.



    " GR/IR ## ### ## ### ##

    LV_TOTAL = LV_TOTAL + GS_MSEG-DMBTR.

    " SAP ## ### ##: 10, 20, 30 ...

    LV_BUZEI = LV_BUZEI + 10.



  ENDLOOP.



  "---------------------------------------------------------------

  " 4. BSEG  GR/IR ## ##

  "   - ## ## ## ### ####

  "   - GR/IR ### ## 1## ##

  "---------------------------------------------------------------

  PERFORM INSERT_BSEG_GRIR

    USING LV_BELNR

          LV_GJAHR

          LV_BUZEI

          LS_LFM1-MWSKZ

          LV_TOTAL.



ENDFORM.




*&---------------------------------------------------------------------*

*&  Include           ZMM06_003_F02

*&---------------------------------------------------------------------*

*&---------------------------------------------------------------------*

*&      Form  RECEIVING_PROCESSING

*&---------------------------------------------------------------------*

*       FI #### ##

*----------------------------------------------------------------------*

*  -->  p1        text

*  <--  p2        text

*----------------------------------------------------------------------*




FORM GET_NEXT_BELNR

  CHANGING

    PV_BELNR TYPE ZEDT06_BKPF-BELNR

    PV_GJAHR TYPE ZEDT06_BKPF-GJAHR.



  SELECT MAX( BELNR ) INTO PV_BELNR

    FROM ZEDT06_BKPF

    WHERE BELNR LIKE '9%'.



  IF PV_BELNR IS INITIAL.

    PV_BELNR = '9000000000'.

  ELSE.

    PV_BELNR = PV_BELNR + 1.

  ENDIF.



  PV_GJAHR = SY-DATUM(4).



ENDFORM.




*&---------------------------------------------------------------------*

*&  Include           ZMM06_003_F02

*&---------------------------------------------------------------------*

*&---------------------------------------------------------------------*

*&      Form  RECEIVING_PROCESSING

*&---------------------------------------------------------------------*

*       FI ## ##(BKPF) ##

*----------------------------------------------------------------------*

*  -->  p1        text

*  <--  p2        text

*----------------------------------------------------------------------*




FORM INSERT_BKPF

  USING

    PV_BELNR TYPE ZEDT06_BKPF-BELNR

    PV_GJAHR TYPE ZEDT06_BKPF-GJAHR

    PV_MBLNR TYPE ZEDT06_MKPF-MBLNR

    PV_MJAHR TYPE ZEDT06_MKPF-MJAHR

    PV_BUKRS TYPE ZEDT06_BKPF-BUKRS.



  DATA LS_BKPF TYPE ZEDT06_BKPF.



  CLEAR LS_BKPF.

  LS_BKPF-BELNR        = PV_BELNR.

  LS_BKPF-GJAHR        = PV_GJAHR.

  LS_BKPF-BUKRS        = PV_BUKRS.

  LS_BKPF-BLART        = 'WE'.

  LS_BKPF-BLDAT        = SY-DATUM.

  LS_BKPF-BUDAT        = SY-DATUM.

  LS_BKPF-REF_DOC_TYPE = 'GR'.

  LS_BKPF-REF_DOC_NO   = PV_MBLNR.

  LS_BKPF-REF_DOC_YEAR = PV_MJAHR.



  INSERT ZEDT06_BKPF FROM LS_BKPF.



ENDFORM.




*&---------------------------------------------------------------------*

*&  Include           ZMM06_003_F02

*&---------------------------------------------------------------------*

*&---------------------------------------------------------------------*

*&      Form  RECEIVING_PROCESSING

*&---------------------------------------------------------------------*

*       ## ## ## ### ##

*----------------------------------------------------------------------*

*  -->  p1        text

*  <--  p2        text

*----------------------------------------------------------------------*




FORM INSERT_BSEG_STOCK

  USING

    PV_BELNR TYPE ZEDT06_BSEG-BELNR

    PV_GJAHR TYPE ZEDT06_BSEG-GJAHR

    PV_BUZEI TYPE ZEDT06_BSEG-BUZEI

    PV_MWSKZ TYPE ZEDT06_LFM1-MWSKZ

    PS_MSEG  TYPE ZEDT06_MSEG.



  DATA LS_BSEG TYPE ZEDT06_BSEG.



  CLEAR LS_BSEG.

  LS_BSEG-BELNR = PV_BELNR.

  LS_BSEG-GJAHR = PV_GJAHR.

  LS_BSEG-BUZEI = PV_BUZEI.

  LS_BSEG-HKONT = '30000000'.

  LS_BSEG-SHKZG = 'S'.

  LS_BSEG-DMBTR = PS_MSEG-DMBTR.

  LS_BSEG-WAERS = PS_MSEG-WAERS.

  LS_BSEG-MWSKZ = PV_MWSKZ.

  LS_BSEG-MATNR = PS_MSEG-MATNR.



  INSERT ZEDT06_BSEG FROM LS_BSEG.



ENDFORM.




*&---------------------------------------------------------------------*

*&  Include           ZMM06_003_F02

*&---------------------------------------------------------------------*

*&---------------------------------------------------------------------*

*&      Form  RECEIVING_PROCESSING

*&---------------------------------------------------------------------*

*       GR/IR ## ## ### ##

*----------------------------------------------------------------------*

*  -->  p1        text

*  <--  p2        text

*----------------------------------------------------------------------*




FORM INSERT_BSEG_GRIR

  USING

    PV_BELNR TYPE ZEDT06_BSEG-BELNR

    PV_GJAHR TYPE ZEDT06_BSEG-GJAHR

    PV_BUZEI TYPE ZEDT06_BSEG-BUZEI

    PV_MWSKZ TYPE ZEDT06_LFM1-MWSKZ

    PV_TOTAL TYPE ZEDT06_BSEG-DMBTR.



  DATA LS_BSEG TYPE ZEDT06_BSEG.



  CLEAR LS_BSEG.

  LS_BSEG-BELNR = PV_BELNR.       " ####

  LS_BSEG-GJAHR = PV_GJAHR.       " ####

  LS_BSEG-BUZEI = PV_BUZEI.       " #####

  LS_BSEG-HKONT = '20000000'.     " GR/IR ##

  LS_BSEG-SHKZG = 'H'.            " ##

  LS_BSEG-DMBTR = PV_TOTAL.       " ## ## ##

  LS_BSEG-MWSKZ = PV_MWSKZ.  " ####

  LS_BSEG-WAERS = GS_EKKO-WAERS.



  INSERT ZEDT06_BSEG FROM LS_BSEG.



ENDFORM.




*&---------------------------------------------------------------------*

*&      Form  CREATE_REVERSE_FI_DOC

*&---------------------------------------------------------------------*

*       text

*----------------------------------------------------------------------*

*      -->P_LT_CANCEL  text

*----------------------------------------------------------------------*




FORM CREATE_REVERSE_FI_DOC

  USING

    PT_CANCEL TYPE STANDARD TABLE OF TY_MSEG.



ENDFORM.