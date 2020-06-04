from flask import Flask, request
import tensorflow as tf
import json
import numpy as np
from keras.models import model_from_json
try:
        from models/docproduct import predictor

except expression as identifier:
        print("Download all models and place them in api/models/")


pretrained_path = '/models/biobert_v1.0_pubmed_pmc/'
ffn_weight_file = None
bert_ffn_weight_file = '/models/bertffn_crossentropy/bertffn'
embedding_file1 = '/models/Float16EmbeddingsExpanded5-27-19.pkl'

doc = predictor.RetreiveQADoc(pretrained_path=pretrained_path,
ffn_weight_file=None,
bert_ffn_weight_file=bert_ffn_weight_file,
embedding_file=embedding_file1)


app = Flask(__name__)

@app.route("/doc", methods=['GET', 'POST'])
def hello() :
        args1 = ""
        for i in request.args.get('args') :
                args1 = args1+i
        args1 = doc.predict(args1)
        print(args1)
        return '''{}'''.format(args1[0])
        
# This is to test the connection
@app.route('/ping', methods=['GET','POST'])
def ping(): 
        return {'status':200}
        
        
if __name__ == "__main__" :
        app.run(port=8080)
