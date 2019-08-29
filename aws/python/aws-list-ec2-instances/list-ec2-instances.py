import boto3

def getVarFromFile(filename):
    import imp
    f = open(filename)
    global data
    data = imp.load_source('data', '', f)
    f.close()

getVarFromFile('config.properties')

#ec2client = boto3.client(
ec2client = boto3.resource(

    'ec2',
    aws_access_key_id=data.aws_access_key_id_value,
    aws_secret_access_key=data.aws_secret_access_key_value
)

for instance in ec2client.instances.all():
     print(
         "Id: {0}\nPlatform: {1}\nType: {2}\nPublic IPv4: {3}\nAMI: {4}\nState: {5}\n".format(
         instance.id, instance.platform, instance.instance_type, instance.public_ip_address, instance.image.id, instance.state
         )
     )
