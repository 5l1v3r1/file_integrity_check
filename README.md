# 0.8b Directory Integrity Check for Logstash
TODO:

Delete dependences.
Improve Logstash loggin.

Dependencies:

````    
Ruby 2.0.0

Diffy -> sudo gem install diffy
Parallel -> sudo gem install parallel
`````

Usage:

````
$ ruby check.rb <text_file> <logstash_ip>
````
Paths file
````
/Directory/subDirectory/
/Directory2/subDirectory/
...
/DirectoryN/subDirectoryN/
````
