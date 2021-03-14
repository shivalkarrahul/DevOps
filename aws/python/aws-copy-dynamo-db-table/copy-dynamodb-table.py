import boto3
import os
import sys
import argparse
import datetime



global args
parser = argparse.ArgumentParser()

parser.add_argument('-sa', '--source_aws_access_key_id', required=True, action="store", dest="source_aws_access_key_id",
                    help="Source AWS Account aws_access_key_id", default=None)
parser.add_argument('-ss', '--source_aws_secret_access_key', required=True, action="store", dest="source_aws_secret_access_key",
                    help="Source AWS Account aws_secret_access_key", default=None)
parser.add_argument('-da', '--destination_aws_access_key_id', required=True, action="store", dest="destination_aws_access_key_id",
                    help="Destination AWS Account aws_access_key_id", default=None)
parser.add_argument('-ds', '--destination_aws_secret_access_key', required=True, action="store", dest="destination_aws_secret_access_key",
                    help="Destination AWS Account aws_secret_access_key", default=None)
parser.add_argument('-st', '--sourceTableName', required=True, action="store", dest="sourceTableName",
                    help="Source AWS Account DyanamoDB Table", default=None)
parser.add_argument('-dt', '--destinationTableName', required=True, action="store", dest="destinationTableName",
                    help="Destination AWS Account DyanamoDB Table", default=None) 
args = parser.parse_args()                                                                                                                       

source_aws_access_key_id = args.source_aws_access_key_id
source_aws_secret_access_key = args.source_aws_secret_access_key

destination_aws_access_key_id = args.destination_aws_access_key_id
destination_aws_secret_access_key = args.destination_aws_secret_access_key


sourceTableName=args.sourceTableName 
destinationTableName=args.destinationTableName 

sourceTableExists = "false" 
destinationTableExists = "false" 

print("Printing values")
print("source_aws_access_key_id", source_aws_access_key_id)
print("source_aws_secret_access_key", source_aws_secret_access_key)
print("destination_aws_access_key_id", destination_aws_access_key_id)
print("destination_aws_secret_access_key", destination_aws_secret_access_key)
print("sourceTableName", sourceTableName)
print("destinationTableName", destinationTableName)


timeStamp = datetime.datetime.now()
backupName = destinationTableName + str(timeStamp.strftime("-%Y_%m_%d_%H_%M_%S"))

item_count = 1000 #Specify total number of items to be copied here, this helps when a specified number of items need to be copied
counter = 1 # Don't not change this

source_session = boto3.Session(region_name='eu-west-3', aws_access_key_id=source_aws_access_key_id, aws_secret_access_key=source_aws_secret_access_key)
source_dynamo_client = source_session.client('dynamodb')

target_session = boto3.Session(region_name='eu-west-3', aws_access_key_id=destination_aws_access_key_id, aws_secret_access_key=destination_aws_secret_access_key)
target_dynamodb = target_session.resource('dynamodb')


dynamoclient = boto3.client('dynamodb', region_name='eu-west-3', #Specify the region here
    aws_access_key_id=source_aws_access_key_id,  #Add you source account's access key here
    aws_secret_access_key=source_aws_secret_access_key) #Add you source account's secret key here

dynamotargetclient = boto3.client('dynamodb', region_name='eu-west-3', #Specify the region here
    aws_access_key_id=destination_aws_access_key_id, #Add you destination account's access key here
    aws_secret_access_key=destination_aws_secret_access_key) #Add you destination account's secret key here
# response = dynamotargetclient.list_tables()
# print("List of tables", response)

dynamopaginator = dynamoclient.get_paginator('scan')

def validateTables(sourceTable, destinationTable):
    print("Inside validateTables")
    try:
        dynamoclient.describe_table(TableName=sourceTable)
        sourceTableExists = "true"
    except dynamotargetclient.exceptions.ResourceNotFoundException:
        sourceTableExists = "false"


    try:
        dynamotargetclient.describe_table(TableName=destinationTable)
        destinationTableExists = "true"
    except dynamotargetclient.exceptions.ResourceNotFoundException:
        destinationTableExists = "false"
    
    return {'sourceTableExists': sourceTableExists, 'destinationTableExists':destinationTableExists}        



def copyTable(sourceTable, destinationTable,item_count,counter):
    
    print("Inside copyTable")
    print("Coping", sourceTable, "to", destinationTable)

    print('Start Reading the Source Table')
    try:
            dynamoresponse = dynamopaginator.paginate(
            TableName=sourceTable,
            Select='ALL_ATTRIBUTES',
            ReturnConsumedCapacity='NONE',
            ConsistentRead=True
        )
    except dynamotargetclient.exceptions.ResourceNotFoundException:
        print("Table does not exist")
        print("Exiting")
        sys.exit()

    print('Finished Reading the Table')
    print('Proceed with writing to the Destination Table')
    print("Writing first", item_count , "items" )
    print(dynamoresponse)
    for page in dynamoresponse:
        for item in page['Items']:
            if (counter ==  item_count):
                print("exiting")
                sys.exit()
            else:      
                print('writing item no', counter)
                dynamotargetclient.put_item(
                    TableName=destinationTable,
                    Item=item
                    )   
            counter = counter + 1

def backupTable(destTableName, backupTimeStamp):
    print("Inside backupTable")
    print("Taking backup of = ", destTableName)
    print("Backup Name = ", backupTimeStamp)

    response = dynamotargetclient.create_backup(
        TableName=destTableName,
        BackupName=backupTimeStamp
    )
    print("Backup ARN =", response["BackupDetails"]["BackupArn"])

def deleteDestinationTable(destTableName):
    print("Inside deleteDestinationTable")
    try:
        dynamotargetclient.delete_table(TableName=destTableName)
        waiter = dynamotargetclient.get_waiter('table_not_exists')
        waiter.wait(TableName=destTableName)
        print("Table deleted")
    except dynamotargetclient.exceptions.ResourceNotFoundException:
        print("Table does not exist")





def doesNotExist():
    print("Inside doesNotExist")
    print("Destination table does not exist ")
    print("Exiting the execution")
    # sys.exit()

def createDestinationTable(sourceTable):
    print("Inside createDestinationTable")
    source_table = source_session.resource('dynamodb').Table(sourceTable)

    target_table = target_dynamodb.create_table(
    TableName=destinationTableName,
    KeySchema=source_table.key_schema,
    AttributeDefinitions=source_table.attribute_definitions,
    ProvisionedThroughput={
        'ReadCapacityUnits': 5,
        'WriteCapacityUnits': 5
    })

    target_table.wait_until_exists()
    target_table.reload()



result = validateTables(sourceTableName, destinationTableName)
print("value of sourceTableExists = ", result['sourceTableExists'])
print("value of destinationTableExists = ", result['destinationTableExists'])

if (result['sourceTableExists'] == "false" ) and (result['destinationTableExists'] == "false" ):
    print("Both the tables do not exist")

elif (result['sourceTableExists'] == "false" ) and (result['destinationTableExists'] == "true" ):
    print("Source Table does not exist")

elif (result['sourceTableExists'] == "true" ) and (result['destinationTableExists'] == "false" ):
    createDestinationTable(sourceTableName)
    copyTable(sourceTableName, destinationTableName, item_count, counter)

elif (result['sourceTableExists'] == "true" ) and (result['destinationTableExists'] == "true" ):
    backupTable(destinationTableName, backupName)
    deleteDestinationTable(destinationTableName)

    createDestinationTable(sourceTableName)
    copyTable(sourceTableName, destinationTableName, item_count, counter)

else:
    print("Something is wrong")






