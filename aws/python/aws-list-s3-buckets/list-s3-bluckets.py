import boto3

def getVarFromFile(filename):
    import imp
    f = open(filename)
    global data
    data = imp.load_source('data', '', f)
    f.close()

getVarFromFile('config.properties')

client = boto3.client(
    's3',
    aws_access_key_id=data.aws_access_key_id_value,
    aws_secret_access_key=data.aws_secret_access_key_value
)

# Call S3 to list current buckets
response = client.list_buckets()

# Get a list of all bucket names from the response
buckets = [bucket['Name'] for bucket in response['Buckets']]

# Print the bucket list
print("Bucket List: %s" % buckets)
