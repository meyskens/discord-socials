FROM golang:1.15-alpine as build

RUN apk add --no-cache git

COPY ./ /go/src/github.com/meyskens/socials

WORKDIR /go/src/github.com/meyskens/socials

RUN go build -ldflags "-X main.revision=$(git rev-parse --short HEAD)" ./cmd/socials/

FROM alpine:3.12

RUN apk add --no-cache ca-certificates

RUN mkdir -p /go/src/github.com/meyskens/socials/
WORKDIR /go/src/github.com/meyskens/socials/

COPY --from=build /go/src/github.com/meyskens/socials/socials /usr/local/bin/

CMD [ "/usr/local/bin/socials", "twitter" ]
