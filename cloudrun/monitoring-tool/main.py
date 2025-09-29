import requests
import os

url = "https://hkarol-devops.com/api/health"
slack_webhook_url = os.getenv("SLACK_WEBHOOK_URL")


response = requests.get(url, timeout=10)
print(f"Site URL response code: {response.status_code}")

if response.status_code not in [200, 403]:
    payload = {
        "text": f"Site is unreachable! {url} response status is: {response.status_code} please check the site!"
    }
    headers = {"Content-Type": "application/json"}
    slack_resp = requests.post(slack_webhook_url, json=payload, headers=headers)
    print(f"Slack response status code: {slack_resp.status_code}, response body: {slack_resp.text}")
else:
    print("Site is reachable, no action needed.")