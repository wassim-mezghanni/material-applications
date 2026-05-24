FROM node:16-alpine

WORKDIR /usr/src/app

# Copy project files with node user ownership
COPY --chown=node:node . .

# Set environment variable for backend URL
ENV REACT_APP_BACKEND_URL=http://localhost:8000/api

# Install dependencies, build project, install serve, and clean up source/caches
RUN npm install && \
    npm run build && \
    npm install -g serve && \
    rm -rf src public node_modules package-lock.json && \
    npm cache clean --force

USER node

EXPOSE 5001

CMD ["serve", "-s", "-l", "5001", "build"]
