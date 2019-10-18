from flask import Flask, request
from pymongo import MongoClient
import os , urllib, argparse
app = Flask(__name__)
import logging
logging.basicConfig(level=logging.DEBUG)
user = None
passw = None

@app.route('/')
def hello_world():
    return 'Vulnerable App'

@app.route('/ls/<path:filename>')
def ls(filename):
    output="</br>".join(os.popen('ls ' + filename).readlines())
    return """
    <html><body>""" + output + """</body></html>"
    """

@app.route('/bionicvanilla')
def vanilla():
    mongo_client = Mongo_c(user, passw, '10.156.15.240')
    db = mongo_client.client.vulndb
    collection = db.list_collection_names()
    out = ''
    if collection is not None:
         for int in collection:
              out = out + "<p>" + int + "</p>"
    return """
    <html><body>""" + out + """</body></html>"
    """

class Mongo_c:
  def __init__ (self, usr, pasw, ip_db):
    self.usr = urllib.quote_plus(usr)
    self.pasw = urllib.quote_plus(pasw)
    self.ip_db = urllib.quote_plus(ip_db)
    self.client = MongoClient('mongodb://%s:%s@%s/?authSource=vulndb' % (self.usr, self.pasw, self.ip_db))

if __name__ == '__main__':
    ap = argparse.ArgumentParser()
    ap.add_argument("-user", "--User", required=True,
                    help="Necesary know the user")
    ap.add_argument("-pass", "--Password", required=True,
                    help="Necesssary know pass")
    args = vars(ap.parse_args())
    user = args['User']
    passw = args['Password']
    app.run(debug=True,host='0.0.0.0')
