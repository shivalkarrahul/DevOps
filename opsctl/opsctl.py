import configparser
import argparse

from opsctl.dockerfile import generate_dockerfile
from opsctl.helmchart import generate_helmchart
from opsctl.jenkinsfile import generate_jenkinsfile
#from opsctl.microservice import generate_java_microservice
#from opsctl.microservice import generate_nodejs_microservice
from opsctl.microservice import generate_microservice


global args

def readProperties():
    
    print("Reading conf/opsctl.properties file")
    
    config = configparser.ConfigParser()
    config.read('conf/opsctl.properties')

    global ip
    global url
    global user
    global password
    global key

    ip=config.get("jenkins", "ip")
    url=config.get("jenkins", "url")
    user=config.get("jenkins", "user")
    password=config.get("jenkins", "password")
    key=config.get("jenkins", "key")

def opsCtl():

    # parser = argparse.ArgumentParser(prog='opsctl.py')

    # parser.add_argument('-o', '--operation', required=True, action="store", dest="operation",
    #                 help="Operation that you want to perform using opsctl.", default=None, choices=['generate'], type=str)
    # parser.add_argument('-t', '--template', required=True, action="store", dest="tool",
    #                 help="Template that you want to generate using opsctl", default=None, choices=['jenkinsfile', 'dockerfile', 'helmchart', 'microservice'], type=str)
    # parser.add_argument('-m', '--microservice', required=True, action="store", dest="microservice",
    #                 help="Type of the microservice for which you want to generate the templates using opsctl", default=None, choices=['java', 'nodejs', 'python'], type=str)
    # parser.add_argument('-n', '--name', required=False, action="store", dest="name",
    #                 help="Name of the microservice that you want to specify in the templates using opsctl", default="my-sample-service", type=str)

    # # subparsers = parser.add_subparsers(help='sub-command help')

    # args = parser.parse_args()

    parser = argparse.ArgumentParser()
    subparser = parser.add_subparsers(dest='command', required=True)

    generate = subparser.add_parser('generate')
    deploy = subparser.add_parser('deploy')

    generate.add_argument('-t', '--template', type=str, required=True, choices=['jenkinsfile', 'dockerfile', 'helmchart', 'microservice'], help="Tool Template that you want to generate using opsctl")
    generate.add_argument('-m', '--microservice', type=str, required=True, choices=['java', 'nodejs', 'python'], help="Type of Microservice that you want to generate using opsctl")
    generate.add_argument('-n', '--name', type=str, required=True, help="Name of Microservice that you want to generate using opsctl", default="my-sample-repo")

    deploy.add_argument('-a', '--application', type=str, required=True, choices=['jenkins', 'microservice'], help="Application that you want to deploy using opsctl")

    args = parser.parse_args()

    if args.command == 'generate':
        print('Generating a template:', args.template , 'for microservice of type:', args.microservice, 'with name:', args.name)
        if args.template == 'jenkinsfile':
            print('Generating a', args.template, 'template' )
            generate_jenkinsfile.generate(args.microservice, args.name)

        elif args.template == 'dockerfile':
            print('Generating a', args.template, 'template' )
            generate_dockerfile.generate(args.microservice, args.name)

        elif args.template == 'helmchart':
            print('Generating a', args.template, 'template' )
            generate_helmchart.generate()

        elif args.template == 'microservice':
            print('Generating a', args.template, 'template' )
            generate_java_microservice.generate(args.microservice, args.name)

        else:
            print('Generating a template: Invalid')    
                                 
        if args.microservice == 'java':
            print('Microservice Type:', args.microservice )
            generate_microservice.generate(args.microservice, args.name)

        elif args.microservice == 'nodejs':
            print('Microservice Type:', args.microservice )
            generate_microservice.generate(args.microservice, args.name)

        elif args.microservice == 'python':
            print('Microservice Type:', args.microservice )
            generate_microservice.generate(args.microservice, args.name)
            
        else:
            print('Generating a template: Invalid')         

    elif args.command == 'deploy':
        print('Deploying an application:', args.application)

if __name__ == '__main__':
    readProperties()
    print(ip)
    print(url)
    print(user)
    print(password)
    print(key)  
    opsCtl()