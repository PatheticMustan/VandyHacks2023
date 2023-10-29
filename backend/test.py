import requests

url = 'http://127.0.0.1:5000/upload'

with open('backend/Prescriptions/3c.jpg', 'rb') as f:
    r = requests.post(url, files = {'file': f})

print(r.content.decode())