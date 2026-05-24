FROM ubuntu:20.04

ENV DEBIAN_FRONTEND=noninteractive

WORKDIR /usr/src/app

# Copy project files
COPY . .

# Set environment variable for backend URL (read at build time)
ENV REACT_APP_BACKEND_URL=http://localhost:8000/api

# Install dependencies, build app, clean up source code/caches, and set up user in one step
RUN apt-get update && apt-get install -y curl && \
    curl -sL https://deb.nodesource.com/setup_16.x | bash - && \
    apt-get install -y nodejs && \
    npm install && \
    npm run build && \
    npm install -g serve && \
    useradd -m appuser && \
    chown -R appuser:appuser /usr/src/app && \
    rm -rf src public node_modules package-lock.json && \
    apt-get purge -y curl && \
    apt-get autoremove -y && \
    rm -rf /var/lib/apt/lists/* && \
    npm cache clean --force

USER appuser

EXPOSE 5001

CMD ["serve", "-s", "-l", "5001", "build"]
