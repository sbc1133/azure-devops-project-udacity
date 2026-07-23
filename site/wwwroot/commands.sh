#!/usr/bin/env bash
# -----------------------------------------
# Commands Used in Udacity DevOps Project
# -----------------------------------------

# ----- Virtual Environment -----
python3 -m venv ~/.myrepo
source ~/.myrepo/bin/activate

# ----- Install Dependencies -----
make install

# ----- Lint and Test -----
make lint
make test
make all

# ----- Run Application Locally -----
python app.py

# ----- Local Prediction -----
./make_prediction.sh

# ----- Azure Login -----
az login

# ----- Create Deployment ZIP -----
zip -r app.zip . -x "*.git*" "*.ipynb" "Project-Plan.xlsx"

# ----- Azure ZIP Deployment -----
az webapp deploy \
  --resource-group Azuredevops \
  --name udacity-webapp-shivali-2026 \
  --src-path app.zip \
  --type zip

# ----- Set Startup Command -----
az webapp config set \
  --resource-group Azuredevops \
  --name udacity-webapp-shivali-2026 \
  --startup-file "gunicorn --bind=0.0.0.0 --timeout 600 app:app"

# ----- Restart Web App -----
az webapp restart \
  --resource-group Azuredevops \
  --name udacity-webapp-shivali-2026

# ----- Stream Logs -----
az webapp log tail \
  --resource-group Azuredevops \
  --name udacity-webapp-shivali-2026

# ----- Azure Prediction Test -----
./make_predict_azure_app.sh

# ----- Useful Cloud Shell Commands -----
ls
pwd
cat make_predict_azure_app.sh
