import os

def create_folder(name):
    print("\n")
    print("Inside create_folder")
    print("Name of the folder to be created -->", name)
    directory = os.getcwd()
    print("Current Working Directory -->",directory)


    path = directory+ "/" +name

    try:
        os.makedirs(path)
    except FileExistsError as e:
         print(e)
            