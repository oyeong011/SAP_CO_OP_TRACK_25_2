
*&---------------------------------------------------------------------*

*&  Include           ZWORK16_002_TOP

*&---------------------------------------------------------------------*






TABLES : ZTCURR16.



INCLUDE <ICON>.         " ICON_EXPORT ## ## ### ##

INCLUDE OLE2INCL.



DATA : BEGIN OF GS_EXCHANGE_RATE.

    include structure
ZTCURR16
.

DATA : END OF GS_EXCHANGE_RATE.

DATA : GT_EXCHANGE_RATE LIKE TABLE OF GS_EXCHANGE_RATE.



" ZTUCRR16

" MANDT : #####

" KURST : ## ##

" FCURR : ## ##

" TCURR : ## ##

" GDATU : ## ## ###

" UKURS : ##

" FFACT : "##" ## ### ##

" TFACT : "##" ## ### ##



DATA : BEGIN OF GS_EXCHANGE_RATE_ALV,

         KURST   LIKE ZTCURR16-KURST, " ## ##

         FCURR   LIKE ZTCURR16-FCURR, " ## ##

         TCURR   LIKE ZTCURR16-TCURR, " ## ##

         GDATU   LIKE ZTCURR16-GDATU, " ## ## ###

         UKURS   LIKE ZTCURR16-UKURS, " ##




*         UKURS_DF TYPE DECFLOAT16,       " ALV ### DECFLOAT




         FFACT   LIKE ZTCURR16-FFACT, " ## ## ### ##

         TFACT   LIKE ZTCURR16-TFACT, " ## ## ### ##

         SYUNAME TYPE SY-UNAME,  " ###

         SYDATUM TYPE SY-DATUM,  " ###

       END OF GS_EXCHANGE_RATE_ALV.

DATA : GT_EXCHANGE_RATE_ALV LIKE TABLE OF GS_EXCHANGE_RATE_ALV.





DATA : OK_CODE TYPE SY-UCOMM.



DATA : GC_CUSTOM TYPE REF TO CL_GUI_CUSTOM_CONTAINER.



DATA : GC_GRID TYPE REF TO CL_GUI_ALV_GRID.



DATA : GO_EVENT TYPE REF TO EVENT.



DATA : GS_VARIANT TYPE DISVARIANT.



DATA : GS_FIELDCAT TYPE LVC_S_FCAT.

DATA : GT_FIELDCAT TYPE LVC_T_FCAT.

DATA : GS_LAYOUT TYPE LVC_S_LAYO.

DATA : GS_SORT TYPE LVC_S_SORT .

DATA : GT_SORT TYPE LVC_T_SORT.