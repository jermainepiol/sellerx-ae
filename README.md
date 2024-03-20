# sellerx-ae
Public repo for SellerX AE take home test 
## Contents
1. ![Setup](https://github.com/jermainepiol/sellerx-ae/blob/main/README.md#setup)
3. ![Assumptions/ Explanations](https://github.com/jermainepiol/sellerx-ae/blob/main/README.md#assumptions-explanations)
4. ![Answers](https://github.com/jermainepiol/sellerx-ae/blob/main/README.md#answers)
5. ![Diagrams](https://github.com/jermainepiol/sellerx-ae/blob/main/README.md#diagrams
)

## Setup
### Dataset
Data provided is in .xlsx file, namely: transaction.xlsx, store.xlsx and device.xlsx

### Datawarehouse
Datawarehouse used in this project is Google Bigquery

### Data transformation
dbt was used for data transformation

### Flow
Below are the general steps that I used in creating this project:
1. Downloaded and converted files in CSV, using these as datasets in Bigquery
2. Setup dbt credentials, initialize the project
3. Create data transformation and tests in dbt
4. dbt generates the views (staging) and tables (mart/core) to Bigquery

## Assumptions/ Explanations
1. 'product_name' exists twice in the original dataset, to prevent confusion, I have merged these two columns and now labeled as 'product_name' in all tables/views in this project.
2. Not all columns are exported because they do not have any immediate purpose to the questions (example, customer_id)
3. Due to different transaction statuses, only transactions that are 'accepted' in status are considered as valid (i.e. only counts towards revenue/sales). These are applied in calculating top products, top stores and transacted amount. I believe that filtering the transactions in this status will yield a true reflection of the metrics being asked in this case.
4. The transaction table has created_at and happened_at, which I have interpreted as the following:
   * created_at - the time the transaction was created (the transaction is created when a device has "scanned" the SKU)
   * happened_at - the time the transaction has updated or moved its latest status
5. In this scenario, some transactions were created before a store was created. These transactions were excluded in determining the first 5 transactions.
6. Staging tables are located in ![models/staging](https://github.com/jermainepiol/sellerx-ae/tree/main/models/staging), while final models are in ![models/mart/core](https://github.com/jermainepiol/sellerx-ae/tree/main/models/mart/core)
7. Dataset properties are located in ![src_datasets.yml](https://github.com/jermainepiol/sellerx-ae/blob/main/models/staging/src_datasets.yaml), including basic tests for values (especially primary IDs)
8. A ![positive_transaction_value.sql](https://github.com/jermainepiol/sellerx-ae/blob/main/tests/positive_transaction_value.sql) was also created to check that all transactions do not have a zero or negative amount.
9. Source freshness (dbt) is purposely not included, as it was not required.

## Answers
Here are the main tables/queries that answer the questions asked:
  * Top 10 stores per transacted amount - ![top_store.sql](https://github.com/jermainepiol/sellerx-ae/blob/main/models/marts/core/top_stores.sql)
  * Top 10 products sold - ![top_products.sql](https://github.com/jermainepiol/sellerx-ae/blob/main/models/marts/core/top_products.sql)
  * Average transacted amount per store typology and country - ![amt_per_typology_country](https://github.com/jermainepiol/sellerx-ae/blob/main/models/marts/core/amt_per_typology_country.sql)
  * Percentage of transactions per device type - ![transactions_per_device](https://github.com/jermainepiol/sellerx-ae/blob/main/models/marts/core/transactions_per_device.sql)
  * Average time for a store to perform its 5 first transactions - ![avg_time_five_transactions](https://github.com/jermainepiol/sellerx-ae/blob/main/models/marts/core/avg_time_five_transactions.sql)

## Diagrams
### ERD
![Database ER diagram](https://github.com/jermainepiol/sellerx-ae/assets/44722197/485c52e9-45e8-45ff-95a8-a0169373ca16)

### Final lineage graph
![image](https://github.com/jermainepiol/sellerx-ae/assets/44722197/f8731700-a4b9-4cb5-a833-7f21701a1ff0)

