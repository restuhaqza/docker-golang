# Step 1
#Golang Base Image v1.14
FROM golang:1.14 as build

#Setting Working Directory
WORKDIR /app/hello-world

#Copy Source Code
COPY . .

#Compiled Golang Apps
RUN CGO_ENABLED=0 GOOS=linux go build -a -installsuffix cgo -o main ./src/main.go


# Step 2 = production
# Base Image Alpine
FROM alpine:latest  

RUN apk --no-cache add ca-certificates

#Setting Working 
WORKDIR /root/

# Menyalin file production ready
COPY --from=build /app/hello-world/main .
COPY --from=build /app/hello-world/src/static ./static

# Buka port 8080
EXPOSE 8080

# Init Process 
CMD ["/root/main"] 