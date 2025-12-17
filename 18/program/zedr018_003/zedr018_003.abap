
*&---------------------------------------------------------------------*

*& Report ZEDR018_003

*&---------------------------------------------------------------------*

*&

*&---------------------------------------------------------------------*




REPORT ZEDR018_003.








*constants  c_rate type i value '100'.

*

*data : gv_sum1 type i,

*      gv_sum2 type i,

*      gv_sum3 type i.

*

*gv_sum1 = '10.00'.

*gv_sum2 = '20.00'.

*gv_sum3 = '30.00'.

*

*gv_sum1 = gv_sum1 * c_rate.

*gv_sum2 = gv_sum2 * c_rate.

*gv_sum3 = gv_sum3 * c_rate.

*

*

*write :/ gv_sum1.

*write :/ gv_sum2.

*write :/ gv_sum3.








tables scarr.



select * from scarr.

   write :/ scarr-carrid, scarr-carrname.

endselect.