## **1\. Project Overview**

This project demonstrates how to operationalize a Machine Learning–powered Flask web application using:

* **GitHub Actions** for Continuous Integration (CI)  
* **Azure App Service** for cloud hosting  
* **Azure CLI** for manual deployment  
* **Shell scripts** for testing the prediction endpoint  
* **Docker/Kubernetes (optional)** for containerization

The application exposes a `/predict` endpoint that returns housing price predictions using a pretrained ML model.

## **2\. Repository Structure**

```
.
├── app.py                     # Flask application
├── requirements.txt           # Python dependencies
├── Makefile                   # Install, lint, test automation
├── make_predict_azure_app.sh  # Sends POST request to Azure app
├── make_prediction.sh         # Local prediction script
├── test_hello.py              # Sample CI test
├── hello.py                   # Sample Python module
├── Dockerfile                 # Optional containerization
├── Housing_price_model/       # ML model artifacts
└── .github/workflows/         # GitHub Actions CI pipeline
```

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

### **3.3 Run Lint \+ Tests**

```
make lint
make test
```

Or run everything:

```
make all
```

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

### **5.2 Deploy using Azure CLI**

Deployment was performed manually using:

```
az webapp up -n udacity-webapp-shivali -g Azuredevops
```

This command:

* Creates the App Service (if needed)  
* Deploys the Flask app  
* Configures logging  
* Outputs the live URL

Your deployed app:

```
https://udacity-webapp-shivali.azurewebsites.net
```

## **6\. GitHub Actions CI Pipeline**

Your CI workflow (`.github/workflows/pythonapp.yml`) performs:

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
{"prediction":[20.3537]}
```

If you open `/predict` in a browser, you will see:

```
405 Method Not Allowed
```

This is expected because browsers send GET requests.

## **8\. Logs & Monitoring**

### **View logs in browser**

```
https://<app-name>.scm.azurewebsites.net/api/logs/docker
```

### **Stream logs via CLI**

```
az webapp log tail -g Azuredevops -n udacity-webapp-shivali
```

## **10\. Expected Results**

### **✔ CI pipeline passes**

* Linting  
* Testing

### **✔ Azure App Service running**

* App loads at root URL

### **✔ Prediction endpoint works**

* Script returns JSON prediction

## **11\. Demo Video URL** 

* https://youtu.be/PYBK-zCTduc

