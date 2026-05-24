FROM ubuntu:20.04

# Avoid prompts from apt during package installation
ENV DEBIAN_FRONTEND=noninteractive

WORKDIR /usr/src/app

# Install curl, then use it to install Node.js 16.x and clean up
RUN apt-get update && apt-get install -y curl && \
    curl -sL https://deb.nodesource.com/setup_16.x | bash - && \
    apt-get install -y nodejs && \
    rm -rf /var/lib/apt/lists/*

# Copy project files
COPY . .

# Set environment variable for backend URL (read at build time)
ENV REACT_APP_BACKEND_URL=http://localhost:8000/api

# Install dependencies, build the static files, and install global serve package
RUN npm install && \
    npm run build && \
    npm install -g serve

# Create a non-root user and change ownership of workdir
RUN useradd -m appuser && chown -R appuser:appuser /usr/src/app

# Set user to appuser
USER appuser

# Expose port 5001
EXPOSE 5001

# Start the application
CMD ["serve", "-s", "-l", "5001", "build"]
