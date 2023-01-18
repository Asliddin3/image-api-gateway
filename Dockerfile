FROM golang:1.19-alpine3.15
RUN mkdir api
COPY . /api-gateway
WORKDIR /api-gateway
RUN apk update && apk add curl \
                          git \
                          protobuf \
                          bash \
                          make \
                          openssh-client && \
     rm -rf /var/cache/apk/*
RUN make tidy
RUN go mod tidy
RUN go build -o main cmd/main.go
CMD ./main