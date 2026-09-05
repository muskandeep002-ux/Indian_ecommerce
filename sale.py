import pandas as pd
df= pd.read_csv('sales.csv')

# Data Cleaning
# check the number of rows and columns 
# print(df.shape)

# check the datatype
# print(df.info())

# check the first 10 rows
# print(df.head(10))

# check the summary statistics 
# print(df.describe())

# check the last 5 rows
# print(df.tail(5))

# clean column names
df.columns= df.columns.str.strip().str.lower().str.replace(' ', '_')
print(df.columns)

# check for null values
# print(df.isnull().sum())

# check percentage of null values
# print(df.isnull().sum()/ len(df)*100)

# check duplicates
print(df.duplicated().sum())

# Correct data types
df['order_date'] = pd.to_datetime(df['order_date'])
df['delivery_date'] = pd.to_datetime(df['delivery_date'])
df['order_time'] = pd.to_datetime(df['order_time'], format='%H:%M:%S').dt.time

# Null handling
df['shipping_cost'] = df['shipping_cost'].fillna(df['shipping_cost'].median())
df['review_text'] = df['review_text'].fillna('No Review')
df['coupon_code'] = df['coupon_code'].fillna('No Coupon')
df['rating']= df['rating'].fillna(0)

# # download data
df.to_csv('sales_cleaned.csv', index=False)
print("saved successfully!")