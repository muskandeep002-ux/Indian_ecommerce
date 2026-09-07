# This script loads all three cleaned CSVs directly into 
# MySQL database using SQLAlchemy
from sqlalchemy import create_engine
import pandas as pd

# Read your cleaned files
customers = pd.read_csv('customers_cleaned.csv')
products = pd.read_csv('products_cleaned.csv')
sales = pd.read_csv('sales_cleaned.csv')

# Connect to MySQL
engine = create_engine('mysql+pymysql://root:79922@localhost/ecommerce')

# Import all three
customers.to_sql('customers_cleaned', engine, if_exists='replace', index=False)
products.to_sql('products_cleaned', engine, if_exists='replace', index=False)
sales.to_sql('sales_cleaned', engine, if_exists='replace', index=False)

print("Done!")
