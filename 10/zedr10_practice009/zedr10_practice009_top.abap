
*&---------------------------------------------------------------------*

*& Include ZEDR10_PRACTICE009_TOP

*&---------------------------------------------------------------------*






" 1. ### ## (ZEDT10 ### ##)

" ####(102), ####(103), ####(104), ####(106)

TABLES: ZEDT10_102, ZEDT10_103, ZEDT10_104, ZEDT10_106.



" 2. ## ## (### #### ## # #### ##)

" ####: CONSTANTS ### ## 1# ## ##

" ###(Traffic Light) # ## ##, #### #### ##

CONSTANTS: GC_X      TYPE C VALUE 'X',       " ####/### ###

           GC_KRW    TYPE WAERS VALUE 'KRW', " ## ## (#### 001~010)

           GC_YELLOW TYPE C LENGTH 4 VALUE '@09@', " ###: ## (##)

           GC_GREEN  TYPE C LENGTH 4 VALUE '@08@', " ###: ## (##)

           GC_RED    TYPE C LENGTH 4 VALUE '@0A@'. " ###: ## (##)



" 3. Ranges ## ## (### #### ##)

" ####: RANGE ## ## 1# ## ##

" ### ## ### #### ## Range ##

RANGES: R_FG FOR ZEDT10_102-ZQFLAG.



" 4. ### ### # ### ### ##

" F01 ##(JOIN)# ## ### ### ### ######.



" 4-1. ## ### ## (ZEDT10_102 + 103)

DATA: BEGIN OF GS_EMP,

        ZPERNR   LIKE ZEDT10_102-ZPERNR,    " ####

        ZPNAME   LIKE ZEDT10_103-ZPNAME,    " ###

        ZDEPCODE LIKE ZEDT10_102-ZDEPCODE,  " ####

        DATBI    LIKE ZEDT10_102-DATBI,     " ###

        DATAB    LIKE ZEDT10_102-DATAB,     " ###

        ZDEPRANK LIKE ZEDT10_102-ZDEPRANK,  " ## (102### ## ##)

        ZGENDER  LIKE ZEDT10_103-ZGENDER,   " ##

        ZEDATE   LIKE ZEDT10_102-ZEDATE,    " ###

        ZQDATE   LIKE ZEDT10_102-ZQDATE,    " ###

        ZQFLAG   LIKE ZEDT10_102-ZQFLAG,    " #####

        ZADDRESS LIKE ZEDT10_103-ZADDRESS,  " ##

      END OF GS_EMP.



DATA: GT_EMP LIKE TABLE OF GS_EMP.



" 4-2. ## ## ALV ### (### ## ## # ### ##)

DATA: BEGIN OF GS_EMP_ALV,

        ICON          TYPE C LENGTH 4,      " ### ###

        ZPERNR        LIKE ZEDT10_102-ZPERNR,

        ZPNAME        LIKE ZEDT10_103-ZPNAME,

        ZDEPCODE_NAME TYPE C LENGTH 10,     " ###(###)

        DATBI         LIKE ZEDT10_102-DATBI,

        DATAB         LIKE ZEDT10_102-DATAB,

        ZRANK_NAME(8),                      " ###(###)

        ZGENDER_NAME(4),                    " ##(###)

        ZEDATE        LIKE ZEDT10_102-ZEDATE,

        ZQDATE        LIKE ZEDT10_102-ZQDATE,

        ZQFLAG        LIKE ZEDT10_102-ZQFLAG,

        ZADDRESS      LIKE ZEDT10_103-ZADDRESS,

      END OF GS_EMP_ALV.



DATA: GT_EMP_ALV LIKE TABLE OF GS_EMP_ALV.



" 4-3. ## ## (ZEDT10_106)

DATA: BEGIN OF GS_PAY.

        include structure
ZEDT10_106
.            " 106 ### ## ## ##

DATA: END OF GS_PAY.



DATA: GT_PAY LIKE TABLE OF GS_PAY.



" 4-4. ## ## ALV ###

DATA: BEGIN OF GS_PAY_ALV,

        ZPERNR     LIKE ZEDT10_106-ZPERNR,

        ZYEAR      LIKE ZEDT10_106-ZYEAR,

        DATBI      LIKE ZEDT10_106-DATBI,

        DATAB      LIKE ZEDT10_106-DATAB,

        ZSALARY    LIKE ZEDT10_106-ZSALARY,

        ZWAERS     TYPE WAERS,              " ###

        ZBANK_NAME TYPE C LENGTH 10,        " ###(###)

        ZACCOUNT   LIKE ZEDT10_106-ZACCOUNT,

      END OF GS_PAY_ALV.



DATA: GT_PAY_ALV LIKE TABLE OF GS_PAY_ALV.



" 4-5. ## ## (ZEDT10_104)

DATA: BEGIN OF GS_EVAL,

        ZPERNR   LIKE ZEDT10_104-ZPERNR,

        ZDEPCODE LIKE ZEDT10_104-ZDEPCODE,

        ZYEAR    LIKE ZEDT10_104-ZYEAR,

        DATBI    LIKE ZEDT10_104-DATBI,

        DATAB    LIKE ZEDT10_104-DATAB,

        ZRANK    LIKE ZEDT10_104-ZRANK,

      END OF GS_EVAL.



DATA: GT_EVAL LIKE TABLE OF GS_EVAL.



" 4-6. ## ## ALV ###

DATA: BEGIN OF GS_EVAL_ALV,

        ZPERNR        LIKE ZEDT10_104-ZPERNR,

        ZDEPCODE_NAME TYPE C LENGTH 10,     " ###(###)

        ZYEAR         LIKE ZEDT10_104-ZYEAR,

        DATBI         LIKE ZEDT10_104-DATBI,

        DATAB         LIKE ZEDT10_104-DATAB,

        ZRANK         LIKE ZEDT10_104-ZRANK,

      END OF GS_EVAL_ALV.



DATA: GT_EVAL_ALV LIKE TABLE OF GS_EVAL_ALV.



" 5. ALV # #### ## ##

DATA: OK_CODE TYPE SY-UCOMM.



" #### ## (Docking 1#, Splitter 2#)

DATA: GC_DOCKING       TYPE REF TO CL_GUI_DOCKING_CONTAINER.

DATA: GC_SPLITTER      TYPE REF TO CL_GUI_SPLITTER_CONTAINER, " #/# ##

      GC_SPLITTER2     TYPE REF TO CL_GUI_SPLITTER_CONTAINER. " ## #/# ##



" #### ## ## (Top, Bottom, TopEval, TopPay)

DATA: GC_CONTAINER_TOP     TYPE REF TO CL_GUI_CONTAINER,

      GC_CONTAINER_BOTTOM  TYPE REF TO CL_GUI_CONTAINER,

      GC_CONTAINER_TOPEVAL TYPE REF TO CL_GUI_CONTAINER,

      GC_CONTAINER_TOPPAY  TYPE REF TO CL_GUI_CONTAINER.



" ALV Grid ##

DATA: GC_GRID_TOPEVAL TYPE REF TO CL_GUI_ALV_GRID,

      GC_GRID_TOPPAY  TYPE REF TO CL_GUI_ALV_GRID,

      GC_GRID_BOTTOM  TYPE REF TO CL_GUI_ALV_GRID.



" ALV ## ## (Field Catalog, Layout, Sort, Variant)

DATA: GS_FIELDCAT         TYPE LVC_S_FCAT,

      GT_FIELDCAT_BOTTOM  TYPE LVC_T_FCAT,

      GT_FIELDCAT_TOPPAY  TYPE LVC_T_FCAT,

      GT_FIELDCAT_TOPEVAL TYPE LVC_T_FCAT,

      GS_LAYOUT           TYPE LVC_S_LAYO,

      GS_SORT             TYPE LVC_S_SORT,

      GT_SORT1            TYPE LVC_T_SORT.



" ALV #### ### ##

DATA: GS_VARIANT TYPE DISVARIANT.