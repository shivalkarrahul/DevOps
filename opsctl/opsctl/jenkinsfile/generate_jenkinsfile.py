from opsctl.utility import my_utilities

def generate(microservice, name):
    print("\n")
    print("Inside jenkinsfile --> generate")
    print("Name of the microservice -->", name)

    my_utilities.create_folder(name)
    my_utilities.copy_jenkinsfile(microservice, name)