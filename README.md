# wildcard-path-expander
Zsh like wildcard expander. You can use `*` and `**/` in path.

## usage
python main.py _directory_ _pattern_
```
$ python main.py sample 'sample/*.txt'
sample/3.txt
sample/2.txt
sample/1.txt

$ python main.py sample 'sample/**/*.txt'
sample/3.txt
sample/2.txt
sample/1.txt
sample/a/hello.txt
sample/a/b/hello.txt
sample/a/b/c/hello.txt
```

## license
CC0
