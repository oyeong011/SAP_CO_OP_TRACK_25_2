
*&---------------------------------------------------------------------*

*&  Include           ZWORK18_001_TOP

*&---------------------------------------------------------------------*




TABLES : SSCRFIELDS.



DATA : GS_FUNCTXT TYPE SMP_DYNTXT.



DATA : BEGIN OF GS_CURR,

         KURST     LIKE ZTCURR18-KURST,

         FCURR     LIKE ZTCURR18-FCURR,

         TCURR     LIKE ZTCURR18-TCURR,

         GDATU     LIKE ZTCURR18-GDATU,   "#### ### ##

         UKURS     LIKE ZTCURR18-UKURS,     "EDIT ##

         FFACT     LIKE ZTCURR18-FFACT,

         TFACT     LIKE ZTCURR18-TFACT,

         ERNAM     LIKE SY-UNAME,   "###

         ERDAT     LIKE SY-DATUM,

         UKURS_RAW TYPE C LENGTH 20,

       END OF GS_CURR.

DATA : GT_CURR LIKE TABLE OF GS_CURR.



DATA : GC_DOCKING TYPE REF TO CL_GUI_DOCKING_CONTAINER.

DATA : GC_GRID TYPE REF TO CL_GUI_ALV_GRID.



DATA : OK_CODE TYPE SY-UCOMM.



DATA : GS_FIELDCAT TYPE LVC_S_FCAT.

DATA : GT_FIELDCAT TYPE LVC_T_FCAT.



DATA : GS_LAYOUT TYPE LVC_S_LAYO.



DATA : GS_SORT TYPE LVC_S_SORT.

DATA : GT_SORT TYPE LVC_T_SORT.