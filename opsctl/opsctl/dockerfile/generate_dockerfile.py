from opsctl.utility import my_utilities

def generate(name):
    print("\n")
    print("Inside dockerfile --> generate")
    print("Name of the microservice -->", name)

    my_utilities.create_folder(name)
