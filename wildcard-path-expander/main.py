from sys import argv
import re
from os import walk
import os.path


def _list_get(a_list, index, default=None):
    return a_list[index] if len(a_list) > index else default


directory = _list_get(argv, 1, "tmp.d")
path = _list_get(argv, 2, "tmp.d/*.txt")


# simple wildcard pattern '*'
# _regex_wild = re.compile(r"(\*|[^*]+)")

# '*' and '**/'
_regex_wild = re.compile(r"(\*\*/|\*|[^*]+)")

_wildcard_regex_table = {
    "*": r"[^/]*",
    "**/": r"(.*/)*"
}


def _wildcard_to_regex_for_each(str_list):
    result_list = []
    for part in str_list:
        regex = _wildcard_regex_table.get(part)
        if not regex:
            regex = re.escape(part)
        result_list.append(regex)
    result_list.append("$")
    return result_list


def wildcard_to_regex(wildcard_pattern):
    decomposed = _regex_wild.findall(wildcard_pattern)
    decomposed_regex = _wildcard_to_regex_for_each(decomposed)
    return ''.join(decomposed_regex)


def _list_dir_recursive(path):
    result_list = []
    for root, _, files in walk(directory):
        for a_file in files:
            result_list.append(os.path.join(root, a_file))
    return result_list


def filter_files(pattern, file_list):
    regex_pattern_str = wildcard_to_regex(pattern)
    regex_pattern = re.compile(regex_pattern_str)

    results = []
    for a_file in file_list:
        m = regex_pattern.match(a_file)
        if m:
            results.append(m.group())

    return results


for f in filter_files(path, _list_dir_recursive(directory)):
    print(f)
