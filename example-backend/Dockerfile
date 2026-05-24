FROM golang:1.16-alpine

WORKDIR /usr/src/app

# Copy dependency files first
COPY go.mod go.sum ./
RUN go mod download

# Copy source code
COPY . .

# Build application, create non-root user, and clean Go build/mod caches
RUN go build -o server && \
    adduser -D appuser && \
    go clean -cache -modcache

USER appuser

EXPOSE 8080

ENV REQUEST_ORIGIN=http://localhost:5001

CMD ["./server"]
