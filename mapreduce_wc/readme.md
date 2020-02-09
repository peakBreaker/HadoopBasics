## Hadoop MapReduce wordcount

This folder contains a simple MapReduce wordcount example.

### Getting started

#### Requirements

- Maven and Java

This was run on Arch Linux with java-11-openjdk and Apache Maven 3.6.3

#### Running

Run locally:
`$ mvn exec:java -D"exec.mainClass"="com.peakbreaker.WordCount" -D"exec.args"="$(pwd)/../sampledata/ $(pwd)/wordcount/"`
