import boto3

def getVarFromFile(filename):
    import imp
    f = open(filename)
    global data
    data = imp.load_source('data', '', f)
    f.close()


getVarFromFile('config.properties')

ec2 = boto3.resource(
'ec2',
    aws_access_key_id=data.aws_access_key_id_value,
    aws_secret_access_key=data.aws_secret_access_key_value,
    region_name=data.region_name_value
)

instance = ec2.create_instances(
    ImageId = data.ImageId_value,
    MinCount = data.MinCount_value,
    MaxCount = data.MaxCount_value,
    InstanceType = data.InstanceType_value,
    KeyName = data.KeyName_value)
print (instance[0].id)
