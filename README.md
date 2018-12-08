# IGC
Tools and Utilities in support of [IBM Infosphere Governance Catalog](https://www.ibm.com/us-en/marketplace/information-governance-catalog)

## Balancesheet
The Balancesheet is a stand-alone Excel based viewpoint showing the Information Assets within any IGC Catalog.  Many a time, a simple, clear view on assets under management is required.  This utility make use of the IGC Rest API to calculate the view.  Typically clients are using this to show what quickly show what is in IGC or to track progress.

![Overview](https://raw.githubusercontent.com/deonpollard/igc/master/wiki-images/BalanceSheet.png)

### To Run
```
Download, enable macros and follow the instructions in the sheet.
You will be required to supply the HostName of the IGC Server and a UserName, Password.
```
## Utilities
List of Utilities
* GetTypes Get a List of valid IGC AssetTypes in a CSV file
* InsertCategoryRID Insert list of Categories from CSV file into IGC
** CSV File
