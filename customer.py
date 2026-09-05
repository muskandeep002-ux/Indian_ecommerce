import pandas as pd
df= pd.read_csv('customers.csv')

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

# Check column names
# column_names= df.columns.tolist()
# print(column_names)

# clean column names
df.columns= df.columns.str.strip().str.lower().str.replace(' ', '_')
print(df.columns)

# check for null values
# print(df.isnull().sum())

# check percentage of null values
# print(df.isnull().sum()/ len(df)*100)

# check duplicates
# print(df.duplicated().sum())

# clean text
df['gender']= df['gender'].str.strip().str.lower()
df['customer_tier']= df['customer_tier'].str.strip().str.lower()

# Change datatype
df['date_of_birth'] = pd.to_datetime(df['date_of_birth'])

# download data
df.to_csv('customers_cleaned.csv', index=False)
print("saved successfully!")