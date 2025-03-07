# Use an official Python runtime as the base image
FROM python:3.13.1-slim

# Set the working directory inside the container
WORKDIR /app

# Copy the requirements.txt file into the container
COPY ./src/requirements.txt /app

# Install dependencies
RUN pip install --no-cache-dir -r requirements.txt

# Copy the rest of the application code into the container
COPY ./src /app

# Create a non-root user
RUN groupadd -r appuser && useradd -r -m -g appuser appuser

# Change ownership of /app to the non-root user
RUN chown -R appuser:appuser /app

# Switch to the non-root user
USER appuser

# Make port 8000 available to the world outside this container
EXPOSE 8000

# Command to run the FastAPI app using Uvicorn server
CMD ["uvicorn", "main:app", "--host", "0.0.0.0", "--port", "8000"]