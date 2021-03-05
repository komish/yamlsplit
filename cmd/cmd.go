package cmd

import (
	"fmt"
	"io"
	"io/ioutil"
	"os"

	yamlv2 "gopkg.in/yaml.v2"
)

// Execute parses a stream from STDIN expecting a series of YAML documents.
// Each document is separated into its own file. File names are enumerated.
func Execute() int {
	dec := yamlv2.NewDecoder(os.Stdin)
	res := getSliceOfDocuments(dec)
	for i, doc := range res {
		d, err := yamlv2.Marshal(doc)
		if err != nil {
			fmt.Printf("Something Broke while marshaling: %s\n", err)
			return 1
		}
		filename := fmt.Sprintf("%d.yaml", i)
		fmt.Printf("Writing %s\n", filename)
		err = ioutil.WriteFile(filename, d, 0644)
		if err != nil {
			fmt.Printf("Something Broke while writing: %s\n", err)
			return 2
		}
	}
	return 0
}

// getSliceOfDocuments parses the input stream and separates YAML documents at
// EOF.
func getSliceOfDocuments(input *yamlv2.Decoder) []interface{} {
	var result []interface{}
	for {
		var value interface{}
		err := input.Decode(&value)
		if err != nil {
			if err == io.EOF {
				break
			} else {
				fmt.Printf("Something Broke: %s\n", err)
			}

		}
		result = append(result, value)
	}
	return result
}
