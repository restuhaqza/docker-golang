FROM golang:1.14 as build
WORKDIR /app/hello-world
COPY . .
RUN CGO_ENABLED=0 GOOS=linux go build -a -installsuffix cgo -o main ./src/main.go

FROM alpine:latest  
RUN apk --no-cache add ca-certificates
WORKDIR /root/
COPY --from=build /app/hello-world/main .
COPY --from=build /app/hello-world/src/static ./static
EXPOSE 8080
CMD ["./main"] 