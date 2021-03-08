#build stage
FROM golang:alpine AS builder
RUN apk add --no-cache git
WORKDIR /go/src/app
COPY . .
RUN go get -d -v ./...
RUN go install -v ./...

#final stage
FROM alpine:latest
RUN apk --no-cache add ca-certificates
COPY --from=builder . /app
ENTRYPOINT ./app
LABEL Name=docswithgolang Version=0.0.1
EXPOSE 4000
CMD ["go", "run", "doc.go"]
