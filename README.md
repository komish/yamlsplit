# YAMLSplit

A quick hack to split monolithic YAML documents into microdocuments (ha!). Your
microdocuments are written with enumerated file names.

## Usage

```shell
cat my-single-file-with-many-documents.yaml | yamlsplit
Writing 0.yaml
Writing 1.yaml
Writing 2.yaml
Writing 3.yaml
Writing 4.yaml
```