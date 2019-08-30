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
client.create_bucket(Bucket=data.Bucket_value, CreateBucketConfiguration={'LocationConstraint': data.LocationConstraint_value})
