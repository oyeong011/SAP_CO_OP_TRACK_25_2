
*&---------------------------------------------------------------------*

*& Include          ZMM10_IV_MGT_SCR

*&---------------------------------------------------------------------*






SELECTION-SCREEN BEGIN OF BLOCK B1 WITH FRAME TITLE TEXT-T01. " ## ##



" 1. #### (PO) - ## ##, ## ## ## [3]

" ## ##: ZEDT10_EKKO-EBELN (#### ##) [4]

SELECT-OPTIONS: S_EBELN FOR ZEDT10_EKKO-EBELN NO-EXTENSION NO INTERVALS

MATCHCODE OBJECT ZSH10_EBELN.



" 2. ### (Plant) - ## ##, ## ## ## [3]

" ## ##: ZEDT10_EKPO-WERKS (###) [5]

SELECT-OPTIONS: S_WERKS FOR ZEDT10_EKPO-WERKS NO-EXTENSION NO INTERVALS

DEFAULT '1000'.



" 3. ##### (Invoice Date) - ##, ### ## ## [7]

" ## ##: ZEDT10_RBKP-BUDAT (###) [6]

PARAMETERS: P_BUDAT TYPE ZEDT10_RBKP-BUDAT DEFAULT SY-DATUM MODIF ID M01.



SELECTION-SCREEN END OF BLOCK B1.



SELECTION-SCREEN BEGIN OF BLOCK B2 WITH FRAME TITLE TEXT-T02. " ## ##



" ## ##: ####(##) / #### [7]

PARAMETERS: R_CREA RADIOBUTTON GROUP G1 DEFAULT 'X' USER-COMMAND UC1,

            R_DISP RADIOBUTTON GROUP G1.



SELECTION-SCREEN END OF BLOCK B2.