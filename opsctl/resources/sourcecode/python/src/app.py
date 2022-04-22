from flask import Flask # importing the flask class
app = Flask(__name__) # creating an instance of the Flask class
 
@app.route('/') # The primary url for our application
def main_path(): # 
   return 'Sample Dockerized Python Flask Application created using opsctl is up and running at API = / . Available APIs = /, /path1, /path2'

@app.route('/path1') # API = /path1
def path_1():
    return 'API = path1'

@app.route('/path2') # API = /path2
def path_2(): 
    return 'API = path2'



if __name__ == '__main__':
    app.run(debug=True, host='0.0.0.0') # This statement starts the server on your Docker Host.