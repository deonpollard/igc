# IGC
Welcome to my IGC Repo!  It contains some Tools and Utilities in support of [IBM Infosphere Governance Catalog](https://www.ibm.com/us-en/marketplace/information-governance-catalog).

# Balancesheet
The Balancesheet is a stand-alone Excel based viewpoint showing the Information Assets within any IGC Catalog.  Many a time, a simple, clear view on assets under management is required.  This utility make use of the IGC Rest API to calculate the view.  Typically clients are using this to show what quickly show what is in IGC or to track progress.

![Overview](https://raw.githubusercontent.com/deonpollard/igc/master/wiki-images/BalanceSheet.png)

## To Run
* Download from Repo
* Being an Excel XLSM file you will be prompted to enable content/macros
* Follow instructions within the sheet
  * Must supply Hostname of the IGC Instance
  * Must supply UserName and Password so that the relevent REST call be made using these credentials
  
```
Every time the Refresh button is pressed within the Balancesheet a new view of the assets are build
```

# Utilities
List of IGC Utilities
* GetTypes Get a List of valid IGC AssetTypes in a CSV file
* InsertCategoryRID Insert list of Categories from CSV file into IGC
```
CSV File for InsertCategoryRID
name                name of category
short_description   description of category
parent_category     parent, leave blank for root otherwise use this column to create hierarchy
```
## To Run
For IGC scripts you must use Powershell 6.0 or later.  Reason for this is that I am using the skipcheck certificate feature.
Download scripts and run in Powershell 6.0 environment.
