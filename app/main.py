from flask import Flask
from flask import jsonify
import requests

app = Flask(__name__)

@app.route('/')
def hello():
    return 'Hi there!'

@app.route('/json')
def get_json():
    response = requests.get('https://jsonplaceholder.typicode.com/todos')
    return jsonify(response.json())

@app.route('/json/user/<int:user_id>')
def get_json_by_user(user_id):
    response = requests.get(f'https://jsonplaceholder.typicode.com/users/{user_id}')
    return jsonify(response.json())

if __name__ == '__main__':
    app.run(host='0.0.0.0')