from flask import Flask, request
import os
app = Flask(__name__)
import logging
logging.basicConfig(level=logging.DEBUG)

@app.route('/')
def hello_world():
    return 'Vulnerable App'

@app.route('/ls/<path:filename>')
def ls(filename):
    output="</br>".join(os.popen('ls ' + filename).readlines())
    return """
    <html><body>""" + output + """</body></html>"
    """

if __name__ == '__main__':
    app.run(debug=True,host='0.0.0.0')
