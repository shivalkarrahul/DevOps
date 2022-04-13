import os
import shutil

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

def copy_file(microservice, name):

    directory = os.getcwd()
    print("Current Working Directory -->",directory)


    source = directory+ "/resources/dockerfiles/Dockerfile-" +microservice
    destination = directory+ "/" +name+ "/Dockerfile"

    print ("source -->", source)
    print ("destination -->", destination)

    try:
        shutil.copyfile(source, destination)
        print("File copied successfully.")
    
    # If source and destination are same
    except shutil.SameFileError:
        print("Source and destination represents the same file.")
    
    # If destination is a directory.
    except IsADirectoryError:
        print("Destination is a directory.")
    
    # If there is any permission issue
    except PermissionError:
        print("Permission denied.")
    
    # For other errors
    except:
        print("Error occurred while copying file.")
            


def copy_sourcecode_folder(microservice, name):

    directory = os.getcwd()
    print("Current Working Directory -->",directory)


    source = directory+ "/resources/sourcecode/" +microservice
    destination = directory+ "/" +name+ "/"

    print ("source -->", source)
    print ("destination -->", destination)

    try:
        shutil.copytree(source, destination, dirs_exist_ok=True)
        print("File copied successfully.")
    
    # If source and destination are same
    except shutil.SameFileError:
        print("Source and destination represents the same file.")
    
    # If destination is a directory.
    except IsADirectoryError:
        print("Destination is a directory.")
    
    # If there is any permission issue
    except PermissionError:
        print("Permission denied.")
    
    # For other errors
    # except:
    #     print("Error occurred while copying file.")    