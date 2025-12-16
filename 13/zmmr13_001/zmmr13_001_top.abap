
*&---------------------------------------------------------------------*

*&  Include           ZMMR13_001_TOP

*&---------------------------------------------------------------------*






DATA : GS_LFA1 TYPE ZLFA1_13, "#####"

       GT_LFA1 LIKE TABLE OF GS_LFA1,

       GS_LFB1 TYPE ZLFB1_13, "#######"

       GT_LFB1 LIKE TABLE OF GS_LFB1,

       GS_LFM1 TYPE ZLFM1_13, "#######"

       GT_LFM1 LIKE TABLE OF GS_LFM1,



       GV_LIFNR LIKE ZLFA1_13-LIFNR,    "#####"

       GV_NAME1 LIKE ZLFA1_13-NAME1,    "####"

       GV_LAND1 LIKE ZLFA1_13-LAND1,    "###"

       GV_KTOKK LIKE ZLFA1_13-KTOKK,    "#####, ####"

       GV_STCD1 LIKE ZLFA1_13-STCD1,    "####"

       GV_STCD2 LIKE ZLFA1_13-STCD2,    "#####"

       GV_STRAS LIKE ZLFA1_13-STRAS,    "##"

       GV_BUKRS LIKE ZLFB1_13-BUKRS,    "####"

       GV_LOEVM LIKE ZLFB1_13-LOEVM,    "#####, #####"

       GV_AKONT LIKE ZLFB1_13-AKONT,    "####"

       GV_ZTERM LIKE ZLFB1_13-ZTERM,    "####"

       GV_EKORG LIKE ZLFM1_13-EKORG,    "####"

       GV_EKGRP LIKE ZLFM1_13-EKGRP,    "####"

       GV_WAERS LIKE ZLFM1_13-WAERS,    "######"

       GV_MWSKZ LIKE ZLFM1_13-MWSKZ,    "####"



       BEGIN OF GS_ORDER,

       LIFNR LIKE ZLFA1_13-LIFNR,    "#####"

       NAME1 LIKE ZLFA1_13-NAME1,    "####"

       LAND1 LIKE ZLFA1_13-LAND1,    "###"

       KTOKK LIKE ZLFA1_13-KTOKK,    "#####, ####"

       STCD1 LIKE ZLFA1_13-STCD1,    "####"

       STCD2 LIKE ZLFA1_13-STCD2,    "#####"

       STRAS LIKE ZLFA1_13-STRAS,    "##"

       BUKRS LIKE ZLFB1_13-BUKRS,    "####"

       LOEVM LIKE ZLFB1_13-LOEVM,    "#####"

       AKONT LIKE ZLFB1_13-AKONT,    "####"

       ZTERM LIKE ZLFB1_13-ZTERM,    "####"

       EKORG LIKE ZLFM1_13-EKORG,    "####"

       EKGRP LIKE ZLFM1_13-EKGRP,    "####"

       WAERS LIKE ZLFM1_13-WAERS,    "######"

       MWSKZ LIKE ZLFM1_13-MWSKZ,    "####"

       END OF GS_ORDER,

       GT_ORDER LIKE TABLE OF GS_ORDER.



DATA : OK_CODE TYPE SY-UCOMM.



DATA : GC_DOCKING TYPE REF TO CL_GUI_DOCKING_CONTAINER.

DATA : GC_GRID TYPE REF TO CL_GUI_ALV_GRID.



DATA : GO_EVENT TYPE REF TO EVENT.



DATA : GS_FIELDCAT TYPE LVC_S_FCAT,

       GT_FIELDCAT TYPE LVC_T_FCAT.



DATA : GS_LAYOUT TYPE LVC_S_LAYO.



DATA : GS_SORT TYPE LVC_S_SORT.

DATA : GT_SORT TYPE LVC_T_SORT.



DATA : GS_VARIANT TYPE DISVARIANT.