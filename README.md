# 0.8b File Integrity Check
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
$ ruby integrity_check.rb <text_file> <logstash_ip>
````
Paths file
````
/Directory/subDirectory/
/Directory2/subDirectory/
...
/DirectoryN/subDirectoryN/
````
