import argparse

from opsctl.dockerfile import generate_dockerfile

global args

def opsCtl():


    parser = argparse.ArgumentParser()

    parser.add_argument('-o', '--operation', required=True, action="store", dest="operation",
                    help="Operation that you want to perform using ops-ctl.", default=None, choices=['generate', 'create', 'delete'], type=str)
    parser.add_argument('-t', '--template', required=True, action="store", dest="tool",
                    help="Template that you want to generate using ops-ctl", default=None, choices=['jenkinsfile', 'dockerfile', 'helmchart'], type=str)
    parser.add_argument('-m', '--microservice', required=True, action="store", dest="microservice",
                    help="Name of the microservice that you want to specify in the templates using ops-ctl", default=None, type=str)
    args = parser.parse_args()


    operation = args.operation
    tool = args.tool
    microservice = args.microservice

    print("Printing values")
    print("operation", operation)
    print("tool", tool)
    print("microservice", microservice)

    generate_dockerfile.generate()




if __name__ == '__main__':
    opsCtl() # pragma: no cover    