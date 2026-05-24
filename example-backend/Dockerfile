FROM golang:1.16-alpine

WORKDIR /usr/src/app

# Copy the go.mod and go.sum files first to cache dependencies
COPY go.mod go.sum ./
RUN go mod download

# Copy the rest of the source code
COPY . .

# Build the Go application
RUN go build -o server

# Create a system user
RUN adduser -D appuser

# Set non-root user
USER appuser

# Expose port 8080
EXPOSE 8080

# Set environment variable for CORS allowed origin
ENV REQUEST_ORIGIN=http://localhost:5001

# Run the backend server
CMD ["./server"]
