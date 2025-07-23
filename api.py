# api.py
from flask import Flask, jsonify

app = Flask(__name__)

@app.route('/backups', methods=['GET'])
def list_backups():
	return jsonify(["backup1.sql", "backup2.sql"])

if __name__ == '__main__':
	app.run()
