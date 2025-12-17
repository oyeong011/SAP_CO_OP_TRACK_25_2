
*&---------------------------------------------------------------------*

*& Report ZEDR23_002

*&---------------------------------------------------------------------*

*&

*&---------------------------------------------------------------------*




REPORT ZEDR23_002.



" ### ## ##

" 1. Table## TYPE## ##

" GS_ TYPE ZEDT

DATA : GS_ZEDT23 TYPE ZEDT23_001.

GS_ZEDT23-ZCODE = 'SSU-23'.

WRITE : / GS_ZEDT23-ZCODE.



" 2. ## Table# Field# ## TYPE ##

DATA : BEGIN OF GS_ZEDT23_2,

  ZKNAME TYPE ZEDT23_001-ZKNAME,

  END OF GS_ZEDT23_2.

GS_ZEDT23_2-ZKNAME = '###'.

WRITE : / GS_ZEDT23_2-ZKNAME.



" 3. ## ELEMENT# TYPE## ##

DATA : BEGIN OF GS_ZEDT23_3,

  ZENAME TYPE ZENAME23,

  END OF GS_ZEDT23_3.

GS_ZEDT23_3-ZENAME = 'Kang'.

WRITE :/ GS_ZEDT23_3-ZENAME.



" 4. STRUCTURE# TYPE## ##

" DATA : GS_ TYPE

DATA : GS_ZEDT23_4 TYPE ZEDS23_001.

GS_ZEDT23_4-CRDATE = SY-DATUM.

WRITE :/ GS_ZEDT23_4-CRDATE.



" * TYPE GROUP# ## : ## ### ### ###"

DATA : GS_ZED23_5 TYPE ZTG23_ZED23.

DATA : GV_ZTITLE TYPE ZTG23_ZTITLE.

GS_ZED23_5-ZGENDER = 'F'.

WRITE :/ GS_ZED23_5-ZGENDER.