import json
from google_auth_oauthlib.flow import InstalledAppFlow

SCOPES = [
    "https://www.googleapis.com/auth/gmail.readonly",
    "https://www.googleapis.com/auth/gmail.send"
]

CLIENT_SECRET_FILE = "credentials.json"
OUTPUT_FILE = "gmail_credentials.json"


def main():

    flow = InstalledAppFlow.from_client_secrets_file(
        CLIENT_SECRET_FILE,
        SCOPES
    )

    credentials = flow.run_local_server(
        port=0,
        access_type="offline",
        prompt="consent"
    )

    data = {
        "type": "authorized_user",
        "client_id": credentials.client_id,
        "client_secret": credentials.client_secret,
        "refresh_token": credentials.refresh_token
    }

    with open(OUTPUT_FILE, "w") as file:
        json.dump(data, file, indent=2)

    print()
    print("======================================")
    print("Gmail OAuth completed successfully.")
    print("======================================")
    print()
    print(f"Generated file: {OUTPUT_FILE}")
    print()
    print("Refresh token generated successfully.")
    print("DO NOT COMMIT THIS FILE TO GIT.")


if __name__ == "__main__":
    main()