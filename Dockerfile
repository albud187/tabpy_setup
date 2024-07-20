# FROM python:3.10

# RUN apt update
# RUN apt install -y python3-pip

# COPY requirements.txt requirements.txt

# RUN python3 -m pip install --upgrade pip
# RUN pip install tabpy
# RUN apt-get install openssl

# ENTRYPOINT ["/bin/bash"]

# Use official Python image from the Docker Hub
FROM python:3.10

# Update and install necessary packages
RUN apt-get update && apt-get install -y python3-pip openssl

# Copy requirements.txt and install Python dependencies
COPY requirements.txt requirements.txt
RUN python3 -m pip install --upgrade pip
RUN pip install -r requirements.txt

# Install TabPy
RUN pip install tabpy

# Copy the configuration and certificate files
COPY config /config

# Set the working directory
WORKDIR /home/alfab/experiments/tabpy_admin

# Expose the port TabPy will run on
EXPOSE 9004

# Entry point to start TabPy
ENTRYPOINT ["/bin/bash"]
