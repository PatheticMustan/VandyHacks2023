from flask import Flask, request, jsonify, flash
from image import process_prescription
import os


app = Flask(__name__)
UPLOAD_FOLDER = 'uploads'
app.config['UPLOAD_FOLDER'] = UPLOAD_FOLDER

@app.route('/')
def index():
    return "server works"


@app.route('/upload', methods = ['GET', 'POST'])
def upload_file():
    if request.method == 'POST':
        if 'file' not in request.files:
            flash('No file part')
            return Flask.redirect(request.url)
        file = request.files['file']
        if file.filename == '':
            flash('No selected file')
            return Flask.redirect(request.url)
        if file:
            filename = file.filename
            file.save(os.path.join(app.config['UPLOAD_FOLDER'], filename))
            data = process_prescription(os.path.join(app.config['UPLOAD_FOLDER'], filename))

            return jsonify(data)
        
if __name__ == '__main__':
    app.run(debug=True)