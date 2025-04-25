FROM python:3.12-slim

RUN apt-get update && apt-get install -y \
    pkg-config \
    default-libmysqlclient-dev \
    build-essential \
    && rm -rf /var/lib/apt/lists/*

# Create app directory and set it as working directory
WORKDIR /apps/

# Copy application files
COPY app/ /apps/

# Install dependencies
RUN pip install --no-cache-dir --upgrade pip && pip install --no-cache-dir -r /apps/requirements.txt

# Set environment variables to ensure app binds to all interfaces
ENV APP_HOST=0.0.0.0
ENV APP_PORT=5050
ENV FLASK_APP=app.py
ENV PYTHONUNBUFFERED=1

# Expose the port
EXPOSE 5050

# Removed ENTRYPOINT to simplify the command
CMD ["python", "app.py"]
    