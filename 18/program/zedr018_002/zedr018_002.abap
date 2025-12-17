
REPORT ZEDR018_002.






*&data : GS_ZEDT018 Type ZEDT018_001.



*& data table# ## ## #### ## ##




data : begin of GS_ZEDT018,

  zcode type ZEDT018_001-zcode,

  zkname type ZEDT018_001-zkname,

  zename type ZEDT018_001-zename,

  zgender type ZEDT018_001-zgender,

  ztel type ZEDT018_001-ztel,

  END OF GS_ZEDT018.






*& data element #### type+## ##




data : begin of GS_ZEDT018_002,

  zcodezcode type ZEDT018_001-zcode,

  zknamezcode type ZEDT018_001-zkname,

  zenamezcode type ZEDT018_001-zename,

  zgenderzcode type ZEDT018_001-zgender,

  ztelzcode type ZEDT018_001-ztel,

  END OF GS_ZEDT018_002.



GS_zedt018-zcode = 'SSU-01'.

GS_zedt018-ZKNAME = '###'.

GS_zedt018-zename = 'DONG'.

GS_zedt018-zgender = 'M'.

GS_zedt018-zTEL = '01011112222'.



move gs_zedt018 to gs_zedt018_002.



WRITE :/ GS_ZEDT018_002-zcodezcode.

WRITE :/ GS_ZEDT018_002-ZKNAMEzcode.

WRITE :/ GS_ZEDT018_002-zenamezcode.

WRITE :/ GS_ZEDT018_002-zgenderzcode.

WRITE :/ GS_ZEDT018_002-zTELzcode.