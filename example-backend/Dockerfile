# Stage 1: Build a fully static Go binary
FROM golang:1.16-alpine AS build-stage

WORKDIR /usr/src/app

COPY go.mod go.sum ./
RUN go mod download

COPY . .

# Build a fully static binary (no CGO, no external libs needed)
RUN CGO_ENABLED=0 GOOS=linux go build -ldflags="-s -w" -o server .

# Stage 2: Minimal scratch image — just the binary
FROM scratch

WORKDIR /usr/src/app

COPY --from=build-stage /usr/src/app/server .

EXPOSE 8080

ENV REQUEST_ORIGIN=http://localhost:5001

CMD ["./server"]
