package main

import (
  "os"
  "fmt"
  "github.com/otiai10/copy"
)

func main() {
  if len(os.Args) < 3 {
    fmt.Println("copy <src> <dst>")
    return
  }
  src := os.Args[1]
  dst := os.Args[2]
  fmt.Printf("%s %s\n", src, dst)
  err := copy.Copy(src, dst)
  if err != nil {
    fmt.Printf("%v\n", err.Error())
  }
}
