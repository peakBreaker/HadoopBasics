## Hadoop MapReduce wordcount

This folder contains a simple MapReduce wordcount example.

### Getting started

#### Requirements

- Maven and Java

This was run on Arch Linux with java-11-openjdk and Apache Maven 3.6.3

#### Running

Run locally:
`$ mvn clean compile exec:java -D"exec.mainClass"="com.test.wordcount.WordCount" -D"exec.args"="$(pwd)/../sample_data/ $(pwd)/wordcount/"`

#### Command to run everything in tmp

Just copy this command to your terminal and run it. Make sure you have git, maven and java though.

```
cd $(mktemp -d) && git clone git@github.com:peakBreaker/HadoopBasics.git && cd HadoopBasics/mapreduce_wc/ && \
    mvn clean compile exec:java -D"exec.mainClass"="com.test.wordcount.WordCount" -D"exec.args"="$(pwd)/../sample_data/ $(pwd)/wordcount/" && \
    echo "WordCount successful! Inspect ouput folder and see job output below:" && \
    cat $(pwd)/wordcount/*
```
