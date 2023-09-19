import json
import boto3
dynamodb = boto3.resource('dynamodb')
table = dynamodb.Table('resume-count')
def lambda_handler (event, context):
    response = table.get_item(Key={
        'count': '0' 
    })
    number = response['Item']['number']
    number = number + 1
    print(number)
    response = table.put_item(Item={
        'count' : '0',
        'number' : number
    })
        
    return number
