import argparse

from opsctl.dockerfile import generate_dockerfile
from opsctl.helmchart import generate_helmchart
from opsctl.jenkinsfile import generate_jenkinsfile
from opsctl.microservice import generate_java_microservice


global args

def opsCtl():


    parser = argparse.ArgumentParser(prog='opsctl.py')

    parser.add_argument('-o', '--operation', required=True, action="store", dest="operation",
                    help="Operation that you want to perform using opsctl.", default=None, choices=['generate'], type=str)
    parser.add_argument('-t', '--template', required=True, action="store", dest="tool",
                    help="Template that you want to generate using opsctl", default=None, choices=['jenkinsfile', 'dockerfile', 'helmchart', 'microservice'], type=str)
    parser.add_argument('-m', '--microservice', required=True, action="store", dest="microservice",
                    help="Type of the microservice for which you want to generate the templates using opsctl", default=None, choices=['java', 'nodejs', 'python'], type=str)
    parser.add_argument('-n', '--name', required=False, action="store", dest="name",
                    help="Name of the microservice that you want to specify in the templates using opsctl", default="my-sample-service", type=str)


    # subparsers = parser.add_subparsers(help='sub-command help')

    args = parser.parse_args()





    operation = args.operation
    tool = args.tool
    microservice = args.microservice
    name = args.name

    print("Printing values")
    print("operation", operation)
    print("template", tool)
    print("microservice", microservice)
    print("name", name)

    generate_dockerfile.generate(microservice, name)
    generate_jenkinsfile.generate(microservice, name)
    generate_helmchart.generate()
    generate_java_microservice.generate(microservice, name)






if __name__ == '__main__':
    opsCtl()