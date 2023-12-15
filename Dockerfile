FROM docker.io/golang:1.21-alpine
WORKDIR /app
WORKDIR /app/src
RUN apk update && apk add --no-cache git
COPY go.mod go.sum ./
RUN go mod download
COPY . .
RUN go build -o ../
RUN apk del git
ENTRYPOINT ["/app/tsnsrv"]