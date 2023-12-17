FROM docker.io/golang:1.21-alpine AS builder
WORKDIR /app/src
RUN apk update && apk add --no-cache git
COPY go.mod go.sum ./
RUN go mod download
COPY . .
RUN go build -ldflags="-w -s" -o ../tsnsrv

FROM docker.io/alpine:latest
COPY --from=builder /app/tsnsrv /app/tsnsrv
ENTRYPOINT ["/app/tsnsrv"]