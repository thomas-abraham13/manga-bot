#!/bin/bash

source .env

# Run the script to generate the manga PDF
# node index.js
i=1065
node -e 'require("./index").sendManga("'${i}'")'

# Check what OS you're on
os=$(uname -s)

# Check if the operating system is Windows
if [ "$os" == "MINGW64_NT-10.0-22631" ]; then
    echo "Operating System: $os (Windows)"
    # Directory containing PDF files
    PDF_DIR="C:\Users\thoma\Desktop\Projects\manga-bot\one-piece/"
# Check if the operating system is macOS
elif [ "$os" == "Darwin" ]; then
    echo "Operating System: $os (macOS)"
    PDF_DIR="/Users/thomasabraham/Projects/manga-bot/one-piece/"
else
    echo "OS Not Recognised"
    PDF_DIR=""
fi

# Check if the directory exists
if [ ! -d "$PDF_DIR" ]; then
  echo "Error: Directory $PDF_DIR not found."
  exit 1
fi

# Loop through all PDF files in the directory
for file in "$PDF_DIR"*.pdf; do
  # Check if the file exists
  if [ -f "$file" ]; then
    # Upload the PDF file to Slack
    curl -F file=@"$file" -F channels="$CHANNEL_ID" -F token="$SLACK_TOKEN" https://slack.com/api/files.upload
    # Delete the file after its been sent and clear the console
    # rm $file
    # clear
    echo "Script Completed ✔️"
  else
    echo "Error: File $file not found."
  fi
done
