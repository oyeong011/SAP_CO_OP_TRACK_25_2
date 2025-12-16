
*&---------------------------------------------------------------------*

*& Report ZEDR21_030

*&---------------------------------------------------------------------*

*&

*&---------------------------------------------------------------------*




REPORT ZEDR21_030.

PARAMETERS: P_MBLNR TYPE MKPF-MBLNR MEMORY ID MBN OBLIGATORY,

            P_MJAHR TYPE MKPF-MJAHR MEMORY ID MJA OBLIGATORY.



CALL FUNCTION 'MIGO_DIALOG'

  EXPORTING

    I_ACTION                  = 'A04'       "##

    I_REFDOC                  = 'R02'       "####




*   I_NOTREE                  = 'X'

*   I_NO_AUTH_CHECK           =

*   I_SKIP_FIRST_SCREEN       = 'X'

*   I_DEADEND                 = 'X'

*   I_OKCODE                  = 'OK_GO'

*   I_LEAVE_AFTER_POST        =

*   I_NEW_ROLLAREA            = 'X'

*   I_SYTCODE                 =

*   I_EBELN                   =

*   I_EBELP                   =




    I_MBLNR                   = P_MBLNR     "#### ##

    I_MJAHR                   = P_MJAHR     "#### ##




*   I_ZEILE                   =

*   I_TRANSPORT               =

*   I_ORDER_NUMBER            =

*   I_ORDER_ITEM              =

*   I_TRANSPORT_MEANS         =

*   I_TRANSPORTIDENT          =

*   I_INBOUND_DELIV           =

*   I_OUTBOUND_DELIV          =

*   I_RESERVATION_NUMB        =

*   I_RESERVATION_ITEM        =

*   EXT                       =

*   I_MOVE_TYPE               =

*   I_SPEC_STOCK              =

*   I_PSTNG_DATE              =

*   I_DOC_DATE                =

*   I_REF_DOC_NO              =

*   I_HEADER_TXT              =




  EXCEPTIONS

    ILLEGAL_COMBINATION       = 1

    OTHERS                    = 2

          .

IF SY-SUBRC <> 0.

  MESSAGE ID SY-MSGID TYPE SY-MSGTY NUMBER SY-MSGNO

        WITH SY-MSGV1 SY-MSGV2 SY-MSGV3 SY-MSGV4.

ENDIF.