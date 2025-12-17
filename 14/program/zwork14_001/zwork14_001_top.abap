
*&---------------------------------------------------------------------*

*&  Include           ZWORK14_001_TOP

*&---------------------------------------------------------------------*






" ### ##

TABLES : ZTCURR14, SSCRFIELDS.



" ## #### ### ##

TYPES : BEGIN OF TY_EXCEL,

  KURST TYPE ZTCURR14-KURST,  " ####

  FCURR TYPE ZTCURR14-FCURR,  " ####

  TCURR TYPE ZTCURR14-TCURR,  " ####

  GDATU TYPE CHAR10,          " ##

  UKURS TYPE ZTCURR14-UKURS,  " ##

  FFACT TYPE ZTCURR14-FFACT,  " ####

  TFACT TYPE ZTCURR14-TFACT,  " ####

  END OF TY_EXCEL.



DATA : GS_EXCEL TYPE TY_EXCEL,

       GT_EXCEL TYPE TABLE OF TY_EXCEL.



" ALV ### ### ##

TYPES : BEGIN OF TY_OUT.

  include structure
ZTCURR14
.

TYPES : MARK TYPE CHAR1,

  END OF TY_OUT.



DATA : GS_OUT TYPE TY_OUT,

       GT_OUT TYPE TABLE OF TY_OUT.



DATA : OK_CODE TYPE SY-UCOMM.



DATA : GO_DOCKING TYPE REF TO CL_GUI_DOCKING_CONTAINER,

       GO_GRID TYPE REF TO CL_GUI_ALV_GRID.



DATA : GT_FCAT TYPE LVC_T_FCAT,

       GS_FCAT TYPE LVC_S_FCAT,

       GS_LAYOUT TYPE LVC_S_LAYO,

       GS_VARIANT TYPE DISVARIANT.