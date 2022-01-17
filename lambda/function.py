import json
import boto3
import hashlib

def lambda_handler(event, context):
  print(f'Received event: {json.dumps(event)}')
  object_date = event['Records'][0]['eventTime']
  object_name = event['Records'][0]['s3']['object']['key'].split('/')[1]
  object_type = object_name.split('.')[1]

  # Simulate a unique ID for each object
  hash_object = hashlib.sha1(bytes(object_date, encoding='utf-8'))
  record_id = hash_object.hexdigest()
  
  record = {}
  record['ID'] = record_id
  record['Date'] = object_date
  record['Name'] = object_name
  record['Type'] = object_type
  
  dynamodb_client = boto3.resource('dynamodb', region_name='us-east-1')
  table = dynamodb_client.Table('dev-exam-raul-table')
  response = table.put_item(Item=record)
  
  return response