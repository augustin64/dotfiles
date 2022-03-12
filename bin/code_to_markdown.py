#!/usr/bin/python3
"""
Converts a code text with multi-line comments to markdown
"""
import sys
import re

def is_string(_text, pos, string):
    """Determines wether a string start at position pos in line"""
    if len(_text) - pos < len(string):
        return False
    for i in range(len(string)):
        if _text[pos + i] != string[i]:
            return False
    return True


def extract_title(raw_text):
    """Returns false if text is not a title and markdown formatted title if it is"""
    if not is_string(raw_text, 0, comment_start):
        return False
    if not is_string(raw_text, len(raw_text)-len(comment_end), comment_end):
        return False
    raw_title = raw_text.split(comment_end)[0].split(comment_start)[1]
    raw_title = " ".join([ i for i in raw_title.split(" ") if i != "" ])
    if bool(re.match("(IX|IV|V?I{0,3})\\ [A-Za-z]", raw_title)):
        return "# " + raw_title
    if (bool(re.match("(IX|IV|V?I{0,3})\\.[A-Z]\\ \\-\\ [A-Za-z]", raw_title))
            or bool(re.match("(IX|IV|V?I{0,3})\\.[0-9]{1,2}", raw_title))):
        return "## "+ raw_title
    if bool(re.match("(IX|IV|V?I{0,3})\\.[A-Z]\\.[0-9]", raw_title)):
        return "### " + raw_title
    return False


lang_configs = {
    "ml": {
        "language": "ocaml",
        "comment_start": "(*",
        "comment_end": "*)",
    },
    "c": {
        "language": "c",
        "comment_start": "/*",
        "comment_end": "*/"
    }
}

if len(sys.argv) < 2:
    print("You need to specify a filename")
    raise NotImplementedError

filename = sys.argv[1]

if len(sys.argv) < 3:
    OUTFILE = ".".join(filename.split(".")[:-1]) + ".md"
else:
    OUTFILE = sys.argv[2]

lang = filename.split(".")[-1]

language = lang_configs[lang]["language"]
comment_start = lang_configs[lang]["comment_start"]
comment_end = lang_configs[lang]["comment_end"]

text = ""

with open(filename, 'r', encoding="utf8") as file:
    file_content = file.read()

file_lines = file_content.split("\n")
is_comment = False
is_codeblock = False
ignore_elem = 0

for line in file_lines:
    title = extract_title(line)
    LINE_CHARS = 0
    if not title :
        for position in range(len(line)):
            if ignore_elem > 0:
                ignore_elem -= 1
            else:
                if not is_comment:
                    if is_string(line, position, comment_start) and position == 0:
                        ignore_elem = len(comment_start) -1
                        is_comment = True
                        if is_codeblock:
                            is_codeblock = False
                            text += "```\n\n"
                    else:
                        if not is_codeblock:
                            is_codeblock = True
                            text += "```" + language + "\n"
                        text += line[position]
                else:
                    if is_string(line, position, comment_end):
                        ignore_elem = len(comment_end) -1
                        is_comment = False
                    else:
                        text += line[position]
                        LINE_CHARS += 1
    else:
        if is_codeblock:
            is_codeblock = False
            text += "```\n\n"
        text += title
    if LINE_CHARS > 0:
        text += "  " # Markdown line-break
    text += "\n"

if is_codeblock:
    text += "```\n"

with open(OUTFILE, "w", encoding="utf8") as file:
    file.write(text)
