# 0.5b File Integrity Check
TODO:

Delete dependences.
Send change alerts to Logstash.

Dependencies:

````    
Ruby 2.0.0

Diffy -> sudo gem install diffy
Parallel -> sudo gem install parallel
`````

Usage:

````
$ ruby integrity_check.rb <text_file>
````
Paths file
````
/Directory/subDirectory/
/Directory2/subDirectory/
...
/DirectoryN/subDirectoryN/
````
