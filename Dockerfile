# Use Python image
FROM python:3.10-slim

# Set working directory in the container
WORKDIR /app

# Copy application code to container
COPY app.py /app

# Install dependencies
RUN pip install Flask

# Expose port
EXPOSE 5000

# Run the Flask app
CMD ["python", "app.py"]
 
