#!python3
#from flask import Flask,jsonify,request
from flask import Flask,make_response,redirect

app = Flask(__name__)
app.config['UPLOAD_FOLDER']="/tmp/"
app.config['MAX_CONTENT_LENGTH'] = 16 * 1000 * 1000

@app.route("/")
def main_page():
    response = make_response(redirect('https://jvspin.com'))
    response.set_cookie(key='SESSION', value='1337',domain='.domain.dom')
    #response.set_cookie(key='SESSION', value='e3510865849aece0606a352caa538594')
    return response

if __name__ == '__main__':
    app.run(host="0.0.0.0",port=80)
