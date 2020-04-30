import boto3
ec2 = boto3.resource('ec2',region_name='eu-west-3')
volume_ids = ['vol-029af2107c0a0807d', ‘vol-029af2107c0a08123’]
def lambda_handler(event, context):
    for volid in volume_ids:
        vid=volid
        v=ec2.Volume(vid)
        v.delete()
        print ('Deleted ' +vid)
