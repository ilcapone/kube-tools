from flask import Flask, request
from pymongo import MongoClient
import os , urllib, json
app = Flask(__name__)
import logging, subprocess
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

@app.route('/bionicvanilla')
def vanilla():
    mongo_client = Mongo_c('10.156.15.240')
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
  def __init__ (self, ip_db):
    self.token_path = '/etc/credentials/'
    self.usr = ''
    self.pasw = ''
    self.get_creds()
    self.ip_db = urllib.quote_plus(ip_db)
    self.client = MongoClient('mongodb://%s:%s@%s/?authSource=vulndb' % (self.usr, self.pasw, self.ip_db))

  def get_creds(self):
    print("[*] Obtaining credentials")
    process = subprocess.Popen(['ls', self.token_path], stdout=subprocess.PIPE)
    out, err = process.communicate()
    if out is not None:
         out_parse = out.decode('utf8')
         filename = out_parse.split('\n')[0]
         self.token_path = self.token_path + filename
         with open(self.token_path) as source:
            credentials = json.load(source)
            self.usr = urllib.quote_plus(credentials['username'])
            self.pasw = urllib.quote_plus(credentials['password'])
    if err is not None:
         print("[-] Error trilling to search tocken")
         pprint.pprint(err)

if __name__ == '__main__':
    app.run(debug=True,host='0.0.0.0')
