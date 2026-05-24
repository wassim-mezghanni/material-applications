# Optimized express-app Dockerfile
# Optimizations applied:
#   1. Smaller base image: node:16-alpine instead of node:16
#   2. Non-root user for security
#   3. WORKDIR set before COPY
#   4. Copy package files first for better layer caching
#   5. npm ci instead of npm install (faster, reproducible, uses lockfile)
#   6. npm cache cleaned in same RUN layer
#   7. Only production dependencies installed (--omit=dev)
FROM node:16-alpine

WORKDIR /usr/src/app

# Install only production dependencies using lockfile
COPY package.json package-lock.json ./
RUN npm ci --omit=dev && npm cache clean --force

# Copy application source (after deps for better cache hits)
COPY index.js .

# Run as non-root user (built into node image)
USER node

EXPOSE 8080

CMD ["node", "index.js"]