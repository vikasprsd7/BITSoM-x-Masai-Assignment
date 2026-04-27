## Steps Involved ##

- To perform a lookup based on two criteria (Date and Currency) in Excel, We cannot use a standard VLOOKUP because it only supports one search key.
  
=XLOOKUP(1, (ExchangeRates!$A:$A=B2) * (ExchangeRates!$B:$B=E2), ExchangeRates!$C:$C)
