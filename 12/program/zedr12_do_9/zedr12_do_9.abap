
*&---------------------------------------------------------------------*

*& Report ZEDR12_DO_9

*&---------------------------------------------------------------------*

*&

*&---------------------------------------------------------------------*




REPORT ZEDR12_DO_9.

CONSTANTS : C_RATE TYPE I VALUE '100'.



DATA: GV_SUM1 TYPE I,

      GV_SUM2 TYPE I,

      GV_SUM3 TYPE I.



GV_SUM1 = '10.00'. "1000### ## #####

GV_SUM2 = '20.00'. "2000### ## #####

GV_SUM3 = '30.00'. "3000### ## #####



GV_SUM1 = GV_SUM1 * C_RATE.

GV_SUM2 = GV_SUM2 * C_RATE.

GV_SUM3 = GV_SUM3 * C_RATE.



WRITE:/ GV_SUM1.

WRITE:/ GV_SUM2.

WRITE:/ GV_SUM3.