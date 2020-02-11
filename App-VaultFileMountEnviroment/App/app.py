from flask import Flask, request
from pymongo import MongoClient
import os , urllib, json
app = Flask(__name__)
import logging, subprocess
from google.cloud import storage
from google.oauth2 import service_account
logging.basicConfig(level=logging.DEBUG)

@app.route('/')
def hello_world():
    return 'Vulnerable App'

@app.route('/birth')
def ls():
    bucket = Bucket()
    data = bucket.download_as_string()
    return """
    <html><body>""" + data + """</body></html>"
    """

@app.route('/bionicvanilla')
def vanilla():
    mongo_client = Mongo_c('192.168.1.1')
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
    self.usr = ''
    self.pasw = ''
    self.get_creds()
    self.ip_db = urllib.quote_plus(ip_db)
    self.client = MongoClient('mongodb://%s:%s@%s/?authSource=vulndb' % (self.usr, self.pasw, self.ip_db))

  def get_creds(self):
    print("[*] Obtaining credentials")
    source = os.environ['credDB']
    credentials = json.loads(source)
    self.usr = urllib.quote_plus(credentials['username'])
    self.pasw = urllib.quote_plus(credentials['password'])

class Bucket:
  def __init__ (self):
    self.project_id = 'project-id'
    self.bucket_name = 'buckt-name'
    self.source_blob_name = 'birth'

  def download_as_string(self):
    print("[+] Download blog from bucket ...")
    source = os.environ['saBucket']
    info = json.loads(source)
    storage_credentials = service_account.Credentials.from_service_account_info(info)
    storage_client = storage.Client(project=self.project_id, credentials=storage_credentials)
    bucket = storage_client.get_bucket(self.bucket_name)
    blob = bucket.blob(self.source_blob_name)
    blob_string = blob.download_as_string()
    return blob_string


if __name__ == '__main__':
    app.run(debug=True,host='0.0.0.0')
