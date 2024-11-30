# Use an official Python image as the base
FROM python:3.13

# Set the working directory to /app
WORKDIR /app

# Copy the requirements.txt file to the working directory
COPY requirements.txt ./ 

# Install the dependencies
RUN pip install --no-cache-dir -r requirements.txt

# Copy the application code to the working directory
COPY . .

# Set environment variables (optional)
ENV PORT=8080

# Expose the port the application will run on
EXPOSE 8080

# If using Flask, add this command :
#  ENV FLASK_APP=main.py

# Run the command to start the server (adjust to your app's entry point)
CMD ["python", "src/server/server.py"]