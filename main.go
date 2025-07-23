package main

import (
	"fmt"
	"log"
	"os"
	"strconv"
)

func init() {
	log.SetFlags(0)
}

func main() {
	if len(os.Args) != 2 {
		log.Fatal("invalid input")
	}
	temp := os.Args[1]
	time, err := strconv.ParseFloat(temp, 64)

	if err != nil {
		log.Fatal(err)
	}
	ipart := uint64(time)
	decpartS := fmt.Sprintf("%.6f", time-float64(ipart))
	decpart, err := strconv.ParseFloat(decpartS, 64)

	if err != nil {
		log.Fatal(err)
	}
	fmt.Printf("%vh %vm\n", ipart, decpart*60)
}
