# Spreadsheet Answers

## Cleaning Steps
- **Whitespace Normalization :** Applied the **Trim()** across the table, especially across text-based fields (merchant_name, status, currency) to eliminate     inconsistencies caused by leading, trailing, or duplicate spaces, thereby reducing lookup and matching errors.
- **Case Standardization :** Used the **PROPER()** to standardize text for merchant names and **LOWER()** for status values, to remove all the inconsistency.
- **Risk Score Extraction :** Used **SUBSTITUTE()** and **VALUE()** functions to strip non-numeric prefixes like "score:" and "risk-" from the risk column, converting them into calculable integers.
- **Date Harmonization :**  Utilized the **Text-to-Columns** feature to enforce a consistent **(DD-MM-YYYY)** format for transaction dates, enabling accurate chronological sorting, time-series analysis, and reliable cross-referencing in financial models.
- **Invalid or missing rows handled :** The **row 12**, and especifically **G12** is the cell where value was missing so the average of the column G was used to propagate the cell G12.

## Standardization Rules
- **Merchant Names :** After the brief look on data one can see that merchant names are not consistent and rule used was "All Variations in the Merchant Name (e.g., "alpha mart" vs "ALPHA MART") standardized to Title Case ("Alpha Mart")."
- **Transaction Status :** All statuses are converted to Proper case; specifically, variations of timeout errors are grouped to maintain data integrity.
- **Currency:** All currency codes are forced to uppercase (e.g., "usd", "inr") to match the reference exchange rate table.
## Lookup and Enrichment Logic
- **Currency Conversion :** Implemented a SUMIFS formula (or nested IF logic) to perform a multi-criteria lookup against exchange_rates.csv based on both the Transaction Date and the Currency Code.
- **Merchant Master Data :** Used VLOOKUP to retrieve the merchant_id, account_manager, merchant_category, and default_region from the merchant_master.csv file.
- **Dynamic Flagging :**
- - High Value: A nested IF condition checks the default_region and applies specific thresholds (APAC > $5k, EU > $6k, US > $7k).
  - High Risk: A logical OR condition flags any transaction with a cleaned risk score $\ge 70$ or a status containing the word "chargeback". 

## Formula Samples
- **Cleaning Risk Score :** =VALUE(SUBSTITUTE(SUBSTITUTE(transaction_raw!G2, "score:", ""), "risk-", ""))
- **Populating the column :** =VLOOKUP(C2,CHOOSE({1,2},merchant_master!$B:$B,merchant_master!$A:$A),2,0)
- **USD Exchange Rate Lookup :** =SUMIFS(exchange_rate!$C:$C,exchange_rate!$A:$A, B2,exchange_rate!$B:$B, E2)
- **High Value Flag :** =IF(OR(AND(P2="APAC", L2>5000), AND(P2="EU", L2>6000), AND(P2="US", L2>7000)), 1, 0)
- **High Risk Flag :** =IF(OR(G2 >= 70, ISNUMBER(SEARCH("chargeback", F2))), 1, 0)
- **Number of high value transactions :** =SUM(Q2:Q31)
- **Number of high risk transactions :** ==SUM(R2:R31)
## Final Answers:

- **Total raw rows :** 30
- **Total cleaned rows :** 30
- **Invalid or missing rows handled :** 1 
- **Top region by GMV :** APAC — driven by large INR transactions from Alpha Mart and Beta Stores.
- **Number of high value transactions :** 7
- **Number of high risk transactions :** 9
- **Top merchant by captured GMV :** Beta Stores ($33431)
