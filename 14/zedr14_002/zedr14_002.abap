
*&---------------------------------------------------------------------*

*& Report ZEDR14_002

*&---------------------------------------------------------------------*

*&

*&---------------------------------------------------------------------*




REPORT ZEDR14_002.






* ABAP Dictionary Table# ## ### ##




DATA : GS_ZEDT14 TYPE ZEDT14_001.



GS_ZEDT14-ZCODE = 'SSU-01'.

GS_ZEDT14-ZKNAME = '###'.

GS_ZEDT14-ZENAME = 'DONG'.

GS_ZEDT14-ZGENDER = 'M'.

GS_ZEDT14-ZTEL = '01011112222'.



WRITE :/ GS_ZEDT14-ZCODE.

WRITE :/ GS_ZEDT14-ZKNAME.

WRITE :/ GS_ZEDT14-ZENAME.

WRITE :/ GS_ZEDT14-ZGENDER.

WRITE :/ GS_ZEDT14-ZTEL.

WRITE :/ .






*&---------------------------------------------------------------------*



* ABAP Dictionary Table# ## ### ##




DATA : BEGIN OF GS_ZEDT14_2,

  ZCODE TYPE ZEDT14_001-ZCODE,

  ZKNAME TYPE ZEDT14_001-ZKNAME,

  ZENAME TYPE ZEDT14_001-ZENAME,

  ZGENDER TYPE ZEDT14_001-ZGENDER,

  ZTEL TYPE ZEDT14_001-ZTEL,

  END OF GS_ZEDT14_2.



GS_ZEDT14_2-ZCODE = 'SSU-02'.

GS_ZEDT14_2-ZKNAME = '###'.

GS_ZEDT14_2-ZENAME = 'DONG'.

GS_ZEDT14_2-ZGENDER = 'M'.

GS_ZEDT14_2-ZTEL = '01011112222'.



WRITE :/ GS_ZEDT14_2-ZCODE.

WRITE :/ GS_ZEDT14_2-ZKNAME.

WRITE :/ GS_ZEDT14_2-ZENAME.

WRITE :/ GS_ZEDT14_2-ZGENDER.

WRITE :/ GS_ZEDT14_2-ZTEL.

WRITE :/ .






*&---------------------------------------------------------------------*



* DATA ELEMENT# ## ### ##




DATA : BEGIN OF GS_ZEDT14_3,

  ZCODE TYPE ZCODE14,

  ZKNAME TYPE ZKNAME14,

  ZENAME TYPE ZENAME14,

  ZGENDER TYPE ZGUBUN14,

  ZTEL TYPE ZTEL14,

  END OF GS_ZEDT14_3.



GS_ZEDT14_3-ZCODE = 'SSU-03'.

GS_ZEDT14_3-ZKNAME = '###'.

GS_ZEDT14_3-ZENAME = 'DONG'.

GS_ZEDT14_3-ZGENDER = 'M'.

GS_ZEDT14_3-ZTEL = '01011112222'.



WRITE :/ GS_ZEDT14_3-ZCODE.

WRITE :/ GS_ZEDT14_3-ZKNAME.

WRITE :/ GS_ZEDT14_3-ZENAME.

WRITE :/ GS_ZEDT14_3-ZGENDER.

WRITE :/ GS_ZEDT14_3-ZTEL.

WRITE :/ .






*&---------------------------------------------------------------------*



* STRUCTURE# ## ### ##




DATA : GS_ZEDS14 TYPE ZEDS14_001.



GS_ZEDS14-ZCODE = 'SSU-04'.

GS_ZEDS14-ZKNAME = '###'.

GS_ZEDS14-ZENAME = 'DONG'.

GS_ZEDS14-ZGENDER = 'M'.

GS_ZEDS14-ZTEL = '01011112222'.



WRITE :/ GS_ZEDS14-ZCODE.

WRITE :/ GS_ZEDS14-ZKNAME.

WRITE :/ GS_ZEDS14-ZENAME.

WRITE :/ GS_ZEDS14-ZGENDER.

WRITE :/ GS_ZEDS14-ZTEL.

WRITE :/ .






*&---------------------------------------------------------------------*



* TYPE GROUP# ## ### ##




DATA : GS_ZEDG14 TYPE ZTG14_ZED14.

DATA : GV_ZTITLE TYPE ZTG14_ZTITLE.



GS_ZEDG14-ZCODE = 'SSU-05'.

GS_ZEDG14-ZKNAME = '###'.

GS_ZEDG14-ZENAME = 'DONG'.

GS_ZEDG14-ZGENDER = 'M'.

GS_ZEDG14-ZTEL = '01011112222'.

GV_ZTITLE = '####'.



WRITE :/ GS_ZEDG14-ZCODE.

WRITE :/ GS_ZEDG14-ZKNAME.

WRITE :/ GS_ZEDG14-ZENAME.

WRITE :/ GS_ZEDG14-ZGENDER.

WRITE :/ GS_ZEDG14-ZTEL.

WRITE :/ GV_ZTITLE.

WRITE :/ .