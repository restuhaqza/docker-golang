package main

import (
	"fmt"
	"log"
	"net/http"
)

func helloServer(w http.ResponseWriter, r *http.Request) {
	fmt.Fprintf(w, "Hello, Kongkow IT Pekanbaru")
}

func main() {
	addr := ":8080"
	http.HandleFunc("/hello", helloServer)
	fs := http.FileServer(http.Dir("./static"))
	log.Println("listen on", addr)
	log.Fatal(http.ListenAndServe(addr, fs))
}
