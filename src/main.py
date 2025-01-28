import pandas as pd
import snowflake.connector as snow
from snowflake.connector.pandas_tools import write_pandas
import os
from dotenv import load_dotenv
from google.cloud import storage

load_dotenv()

conn = snow.connect(
    user=os.environ['user'],
    password=os.environ['password'],
    account=os.environ['account'],
    warehouse=os.environ['warehouse'],
    database=os.environ['database'],
    schema=os.environ['schema'],
)

cur = conn.cursor()

storage_client = storage.Client()
bucket = storage_client.bucket('sp-trans')

file_list = [c.name for c in storage_client.list_blobs('sp-trans')]
del file_list[0]

def create_tables():
    for file in file_list:
        df = pd.read_csv(f'gs://sp-trans/{file}')
        table_name = file.replace('data/', '').replace('.txt', '')
        write_pandas(conn, df, table_name, auto_create_table=True)
create_tables()

