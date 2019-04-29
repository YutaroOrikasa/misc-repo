You can combine multiple shell script files to single executable shell script.

## sample1: making executable of ../helloworld
```
$ ./make-executable-archive.sh ../helloworld helloworld.sh hw
$ ./hw
hello world
```

## sample2: making executable of this project (executable-archive)
```
$ ./make-executable-archive.sh ./ make-executable-archive.sh ea
$ ./ea
Usage: /var/folders/nc/kbqw70zn6cz2k70fnfxsd13m0000gq/T/tmp.nESHwZDw/make-executable-archive.sh dir_to_archive script output
dir_to_archive: The directory you want to archive.
script: A path of script in dir_to_archive. It will be executed after expanding archive.
output: The filename of generated archive.
```
