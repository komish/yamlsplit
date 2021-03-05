package main

import (
	"fmt"
	"os"
	"path"

	"github.com/komish/yamlsplit/cmd"
	"github.com/komish/yamlsplit/version"
)

var infoText = fmt.Sprintf(`%s %s (commit: %s)

Summary:
  Split multi-document YAML manifests into multiple manifests.

Usage:
  cat multi-document-manifest.yml | %s`,
	path.Base(os.Args[0]),
	version.Version,
	version.CommitHash,
	path.Base(os.Args[0]))

func main() {
	if len(os.Args) != 1 {
		fmt.Println(infoText)
		os.Exit(9)
	}

	os.Exit(cmd.Execute())
}
