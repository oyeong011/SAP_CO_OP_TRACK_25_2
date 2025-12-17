
REPORT ZEDR13_039.



DATA : GV_NUM1 TYPE i VALUE 100,

       GV_NUM2 TYPE i VALUE 120,

       GV_NUM3 TYPE i VALUE 110.



WRITE : '**1#-IF## WRITE# ##'.

WRITE :/ GV_NUM1.

WRITE :/ GV_NUM2.

IF ( GV_NUM1 > GV_NUM2 ).

  WRITE :/ 'GV_NUM1# GV_NUM2## ###.'.

ELSE.

  WRITE :/ 'GV_NUM1# GV_NUM2## ####.'.

ENDIF.



WRITE :/ '**2#-IF## WRITE# ##'.

WRITE :/ GV_NUM1.

WRITE :/ GV_NUM2.

WRITE :/ GV_NUM3.

IF ( GV_NUM1 > GV_NUM2 ) AND ( GV_NUM1 > GV_NUM3 ).

  WRITE :/ 'GV_NUM1# GV_NUM2, GV_NUM3## ###.'.

ELSEIF ( GV_NUM1 > GV_NUM2 ) AND ( GV_NUM1 < GV_NUM3 ).

  WRITE :/ 'GV_NUM1# GV_NUM2## ###  GV_NUM3## ####.'.

ELSEIF ( GV_NUM1 < GV_NUM2 ) AND ( GV_NUM1 > GV_NUM3 ).

  WRITE :/ 'GV_NUM1# GV_NUM2## ###  GV_NUM3## ###.'.

ELSE.

  WRITE :/ 'GV_NUM1# GV_NUM2, GV_NUM3## ####.'.

ENDIF.



WRITE :/ '**3#-ELSE## WRITE# ##'.

WRITE :/ GV_NUM1.

WRITE :/ GV_NUM2.

IF ( GV_NUM1 > GV_NUM2 ).

  WRITE :/ 'GV_NUM2# GV_NUM1## ####.'.

ELSE.

  WRITE :/ 'GV_NUM2# GV_NUM1## ###.'.

ENDIF.



WRITE :/ '**4#-NUM1, NUM2, NUM3##### #### WRITE# ##'.

IF ( GV_NUM1 > GV_NUM2 ) AND ( GV_NUM1 > GV_NUM3 ).

  WRITE :/ 'GV_NUM1#'.

  WRITE : GV_NUM1.

  WRITE : '## #####.'.

ELSEIF ( GV_NUM1 > GV_NUM2 ) AND ( GV_NUM1 < GV_NUM3 ).

  WRITE :/ 'GV_NUM3#'.

  WRITE : GV_NUM3.

  WRITE : '## #####.'.

ELSEIF ( GV_NUM1 < GV_NUM2 ) AND ( GV_NUM1 > GV_NUM3 ).

  WRITE :/ 'GV_NUM2#'.

  WRITE : GV_NUM2.

  WRITE : '## #####.'.

ELSEIF ( GV_NUM1 < GV_NUM2 ) AND ( GV_NUM1 < GV_NUM3 ) AND ( GV_NUM2 < GV_NUM3 ).

  WRITE :/ 'GV_NUM3#'.

  WRITE : GV_NUM3.

  WRITE : '## #####.'.

ELSE.

  WRITE :/ 'GV_NUM2#'.

  WRITE : GV_NUM2.

  WRITE : '## #####.'.

ENDIF.