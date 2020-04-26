from flask import Flask, request
from docproduct import predictor
import tensorflow as tf
import json
import numpy as np
from keras.models import model_from_json


pretrained_path = '/home/arshu/Desktop/miniproject/BioBertFolder/biobert_v1.0_pubmed_pmc/'
ffn_weight_file = None
bert_ffn_weight_file = '/home/arshu/Desktop/miniproject/newFolder/models/bertffn_crossentropy/bertffn'
embedding_file1 = '/home/arshu/Desktop/miniproject/newFolder/Float16EmbeddingsExpanded5-27-19.pkl'

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
        
        
@app.route('/arshu', methods=['GET','POST'])
def denil():
        
        return {'status':200}
        
        
if __name__ == "__main__" :
        app.run(port=8080)
