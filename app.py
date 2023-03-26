from flask import Flask, request, jsonify

app = Flask(__name__)

online_users = {}

@app.route('/notify', methods=['POST'])
def notify():
    data = request.json
    username = data['username']
    status = data['status']
    online_users[username] = status
    print(f"{username} is now {'online' if status else 'offline'}")
    return 'OK'

@app.route('/online', methods=['GET'])
def get_online_users():
    online_usernames = [username for username, status in online_users.items() if status]
    return jsonify({'online_users': online_usernames})

if __name__ == '__main__':
    app.run(debug=True)