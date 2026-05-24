# Stage 1: Build the React application
FROM node:16-alpine AS build-stage
WORKDIR /usr/src/app
COPY . .
ENV REACT_APP_BACKEND_URL=http://localhost:8000/api
RUN npm install && npm run build

# Stage 2: Serve the production assets
FROM node:16-alpine
WORKDIR /usr/src/app
RUN npm install -g serve
COPY --from=build-stage /usr/src/app/build ./build
USER node
EXPOSE 5001
CMD ["serve", "-s", "-l", "5001", "build"]
