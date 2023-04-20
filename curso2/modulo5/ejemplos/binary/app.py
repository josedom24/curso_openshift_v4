from flask import Flask
import os

app = Flask(__name__)

@app.route('/')
def hello():
    return "<h1>Curso OpenShift v4</h1>"

if __name__ == '__main__':
    app.run(8080,host='0.0.0.0')