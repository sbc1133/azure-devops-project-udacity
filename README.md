

## **1\. Project Overview**

This project demonstrates how to operationalize a Machine Learning–powered Flask web application using:

* **GitHub Actions** for Continuous Integration (CI)  
* **Azure App Service** for cloud hosting  
* **Azure CLI** for manual deployment  
* **Shell scripts** for testing the prediction endpoint

The application exposes a `/predict` endpoint that returns housing price predictions using a pretrained ML model.

---

## **2\. Repository Structure**

```
├── app.py                     # Flask application
├── requirements.txt           # Python dependencies
├── Makefile                   # Install, lint, test automation
├── make_predict_azure_app.sh  # Sends POST request to Azure app
├── make_prediction.sh         # Local prediction script
├── test_hello.py              # Sample CI test
├── hello.py                   # Sample Python module
├── Housing_price_model/       # ML model artifacts
├── Project-Plan.xlsx          # Original + Final project plan spreadsheet
└── .github/workflows/         # GitHub Actions CI pipeline
```

---

## **3\. Getting Started**

### **3.1 Create and Activate Virtual Environment**

```
python3 -m venv ~/.myrepo
source ~/.myrepo/bin/activate
```

### **3.2 Install Dependencies**

```
make install
```

### **3.3 Run Lint and Tests**

```
make lint
make test
```

Or run everything:

```
make all
```

---

## **4\. Running the Application Locally**

Start the Flask app:

```
python app.py
```

The app runs at:

```
http://127.0.0.1:5000
```

Test prediction locally:

```
./make_prediction.sh
```

## **5\. Deploying to Azure App Service (Manual Deployment)**

### **5.1 Login to Azure**

```
az login
```

### **5.3 Create a Clean Deployment ZIP**

```
zip -r app.zip . -x "*.git*" "*.ipynb" "Project-Plan.xlsx"
```

### **5.2 Deploy using Azure CLI**

Deployment was performed manually using:

```
az webapp deploy \
  --resource-group Azuredevops \
  --name udacity-webapp-shivali-2026 \
  --src-path app.zip \
  --type zip

az webapp config set \
  --resource-group Azuredevops \
  --name udacity-webapp-shivali-2026 \
  --startup-file "gunicorn --bind=0.0.0.0 --timeout 600 app:app"

az webapp restart \
  --resource-group Azuredevops \
  --name udacity-webapp-shivali-2026
```

deployed app:

```
https://udacity-webapp-shivali-2026.azurewebsites.net
```

## **6\. GitHub Actions CI Pipeline**

 CI workflow (`.github/workflows/pythonapp.yml`) performs:

* Checkout code  
* Set up Python  
* Install dependencies  
* Run lint  
* Run tests

## **7\. Testing the Azure Prediction Endpoint**

The `/predict` endpoint accepts **POST only**.

To test:

```
./make_predict_azure_app.sh
```

Example output:

```
Port: 443
{"prediction":[2.431574790057212]}

```

If you open `/predict` in a browser, you will see:

```
405 Method Not Allowed
```

This is expected because browsers send GET requests.

## **8\. Logs & Monitoring**

### **View logs in browser**

```
https://udacity-webapp-shivali-2026.scm.azurewebsites.net/api/logs/docker
```

### **Stream logs via CLI**

```
az webapp log tail \
  --resource-group Azuredevops \
  --name udacity-webapp-shivali-2026
```

## **9\. Expected Results**

###  **CI pipeline passes**

* Linting  
* Testing

###  **Azure App Service running**

* App loads at root URL

###  **Prediction endpoint works**

* Script returns JSON prediction

## **10\. Demo Video URL**
[https://youtu.be/3MaE6gymfBA](https://youtu.be/3MaE6gymfBA)

## **11\. Project Plan Spreadsheet**

This project includes a detailed project planning spreadsheet required by the Udacity rubric.  
 The spreadsheet contains:

* Quarterly and yearly plan  
* Week-by-week deliverables  
* Task difficulty and time estimates  
* Original plan vs. final plan

The spreadsheet is included in the repository:

**Project-Plan.xlsx**

## 12. Screenshots

### 1. Project cloned in Azure Cloud Shell
![Cloud Shell](screenshots/cloudshell.png)

### 2. make all passing
![Make All](screenshots/makeall.png)

### 3. GitHub Actions CI passing
![CI Pipeline](screenshots/ci.png)

### 4. Azure App Service running
![App Service](screenshots/appservice.png)

### 5. Successful prediction
![Prediction](screenshots/prediction.png)

