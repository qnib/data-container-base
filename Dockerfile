FROM golang AS copy

WORKDIR /go/src/copy/
COPY ./copy.go ./
ENV CGO_ENABLED=0 \
    GOOS=linux \
    GOARCH=amd64
RUN go get -d \
 && go build -a -tags netgo -ldflags '-w -extldflags "-static"' *.go
FROM golang AS void
RUN echo '\n\
 package main\n\
 func main() {}\n'\
 >> /tmp/void.go \
 && go build -o /void /tmp/void.go

FROM scratch

COPY --from=void /void /void
COPY --from=copy /go/src/copy/copy /copy
ENTRYPOINT [""]
CMD ["/void"]
