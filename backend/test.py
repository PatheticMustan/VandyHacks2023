import requests

url = 'http://35.222.254.60:5000/upload'

with open('backend/Prescriptions/3c.jpg', 'rb') as f:
    r = requests.post(url, files = {'file': f})

print(r.content.decode())