# GTM Buddy Assignment

This repository contains the implementation of a text classification and entity extraction pipeline, along with a containerized inference service using FastAPI, Docker, and various NLP techniques.

## Overview

The project involves three main tasks:

### Task 1: Data Preparation & Multi-Label Text Classification
- A synthetic dataset of call snippets is created to simulate conversations from various industries.
- The dataset is labeled with multiple categories such as industries, pain points, technical inquiries, and decision-makers.
- Preprocessing steps include:
  - Removing special characters and stopwords.
  - Tokenization and lowercasing.
- Features are extracted using **TF-IDF vectorization** to represent text numerically.
- A **Logistic Regression model** wrapped in a `MultiOutputClassifier` is used for multi-label classification.
- The model is evaluated using metrics such as accuracy, precision, recall, and F1 score to ensure robust performance.

### Task 2: Entity/Keyword Extraction with Domain Knowledge Base
- This task focuses on identifying domain-specific entities or keywords from text snippets.
- A `domain_knowledge.json` file contains predefined categories (e.g., competitors, features, pricing, security, pain points, decision-maker roles) and their associated keywords.
- Two techniques are used for extraction:
  1. **Regular Expressions (Regex):** Matches predefined patterns for keywords.
  2. **spaCy Named Entity Recognition (NER):** Identifies entities in text using a pre-trained model.
- The extracted entities are categorized and returned in a structured format for further analysis.

### Task 3: Containerized Inference Service
- A **FastAPI web application** is developed to serve the trained model and entity extraction pipeline.
- The API offers endpoints for text classification, entity extraction, and text summarization.
- **Dockerization** is implemented to containerize the application for seamless deployment.
- Steps include:
  - Writing a `Dockerfile` to define the environment and dependencies.
  - Building and running the containerized service locally or on a cloud platform.

## Requirements

1. Python 3.7+
2. Necessary libraries (use `requirements.txt` for exact versions):
    - pandas
    - numpy
    - scikit-learn
    - nltk
    - fastapi
    - uvicorn
    - spacy
    - pyngrok
    - joblib
    - pydantic
    - nest_asyncio
    - tensorflow

## Setup Instructions

### 1. Clone the repository:
```bash
git clone https://github.com/kishore0313/GTM_Buddy_de_Assignment.git
cd GTM_Buddy_de_Assignment
```

### 2. Install dependencies:
```bash
pip install -r requirements.txt
```

### 3. Download the necessary spaCy model:
```bash
python -m spacy download en_core_web_sm
```

### 4. Run the FastAPI app locally:
```bash
uvicorn app:app --reload
```
The app will be accessible at `http://localhost:8000`.

### 5. Dockerization:

To containerize the FastAPI service with Docker:

1. **Build the Docker image:**
    ```bash
    docker build -t gtm-buddy-service .
    ```

2. **Run the Docker container:**
    ```bash
    docker run -d -p 8000:8000 gtm-buddy-service
    ```

3. You can now access the FastAPI service at `http://localhost:8000`.

4. **Expose the app with ngrok (optional):**
    If you're using Google Colab or want to expose your local server, you can use ngrok:
    ```bash
    public_url = ngrok.connect(8000)
    print(f"Public URL: {public_url}")
    ```

### 6. Test the API:
You can send a POST request to the `/predict` endpoint to test the service. Here’s an example using `curl`:

```bash
curl -X POST "http://localhost:8000/predict" -H "Content-Type: application/json" -d '{"text": "We\'re looking at solutions in the healthcare sector. Scalability issues are our main challenge."}'
```

### 7. Sample Output:
```json
{
    "text": "We're looking at solutions in the healthcare sector. Scalability issues are our main challenge.",
    "labels": ["Industry Specific", "Technical Inquiry", "Pain Points"],
    "entities": [
        {"CATEGORY": "INDUSTRIES", "ITEM": "healthcare"},
        {"CATEGORY": "TECHNICAL_CONCERNS", "ITEM": "scalability issues"}
    ],
    "summary": "We're looking at solutions in the healthcare sector."
}
```

## Project Files

- `calls_dataset.csv`: The generated dataset of call snippets.
- `domain_knowledge.json`: JSON file containing domain-specific keywords.
- `app.py`: FastAPI application for inference service.
- `Dockerfile`: Instructions to build a Docker image for the FastAPI app.
- `requirements.txt`: Python dependencies for the project.

## Conclusion

This project demonstrates the use of machine learning, NLP, and modern web services to classify text, extract entities, and summarize content. The model is easily deployable as a containerized web service.

