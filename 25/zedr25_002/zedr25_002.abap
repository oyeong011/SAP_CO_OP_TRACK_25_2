
*&---------------------------------------------------------------------*

*& Report ZEDR25_002

*&---------------------------------------------------------------------*

*&

*&---------------------------------------------------------------------*




REPORT ZEDR25_002.



DATA : gs_zedt25 type ZEDT25_001.



gs_zedt25-ZCODE = 'ssu-01'.

gs_zedt25-ZKNAME = '###'.

gs_zedt25-ZENAME = 'Dong'.

gs_zedt25-ZGENDER = 'M'.

gs_zedt25-ZTEL = '01027273737'.



write :/ gs_zedt25-ZCODE.

write :/ gs_zedt25-ZKNAME.

write :/ gs_zedt25-ZENAME.

write :/ gs_zedt25-ZGENDER.

write :/ gs_zedt25-ZTEL.



DATA : begin of gs_zedt25_001,

  ZCODE type ZEDT25_001-ZCODE,

  ZKNAME type ZEDT25_001-ZKNAME,

  ZENAME type ZEDT25_001-ZENAME,

  ZGENDER type ZEDT25_001-ZGENDER,

  ZTEL type ZEDT25_001-ZTEL,

  end of gs_zedt25_001.





gs_zedt25_001-ZCODE = 'ssu-25'.

gs_zedt25_001-ZKNAME = '#'.

gs_zedt25_001-ZENAME = 'Nom'.

gs_zedt25_001-ZGENDER = 'M'.

gs_zedt25_001-ZTEL = '01027273738'.





write :/ gs_zedt25_001-ZCODE.

write :/ gs_zedt25_001-ZKNAME.

write :/ gs_zedt25_001-ZENAME.

write :/ gs_zedt25_001-ZGENDER.

write :/ gs_zedt25_001-ZTEL.



DATA : begin of gs_zedt25_002,

  ZCODE type ZCODE25,

  ZKNAME type ZKNAME25,

  ZENAME type ZENAME25,

  ZGENDER type ZGENDER25,

  ZTEL type ZTEL25,

  end of gs_zedt25_002.



gs_zedt25_002-ZCODE = 'ssu-25'.

gs_zedt25_002-ZKNAME = '#'.

gs_zedt25_002-ZENAME = 'Nom'.

gs_zedt25_002-ZGENDER = 'M'.

gs_zedt25_002-ZTEL = '01027273738'.



write :/ gs_zedt25_002-ZCODE.

write :/ gs_zedt25_002-ZKNAME.

write :/ gs_zedt25_002-ZENAME.

write :/ gs_zedt25_002-ZGENDER.

write :/ gs_zedt25_002-ZTEL.



DATA gs_zeds25 type ZEDS25_001.



gs_zeds25-ZCODE = 'ssu-2525'.

gs_zeds25-ZKNAME = '#'.

gs_zeds25-ZENAME = 'Nom'.

gs_zeds25-ZGENDER = 'M'.

gs_zeds25-ZTEL = '01027273738'.



write :/ gs_zeds25-ZCODE.

write :/ gs_zeds25-ZKNAME.

write :/ gs_zeds25-ZENAME.

write :/ gs_zeds25-ZGENDER.

write :/ gs_zeds25-ZTEL.