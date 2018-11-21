#!/bin/sh
# Pre-commit hook for git which removes trailing whitespace, converts tabs to spaces, and enforces a max line length.
# The script does not process files that are partially staged. Reason: The `git add` in the last line would fully
# stage a file which is not what the user wants.

if git rev-parse --verify HEAD >/dev/null 2>&#!/usr/bin/env python3

from __future__ import with_statement
import os
import re
import shutil
import subprocess
import sys
import tempfile


git_binary_path = "/usr/bin/git"


def system(*args, **kwargs):
    kwargs.setdefault('stdout', subprocess.PIPE)
    proc = subprocess.Popen(args, **kwargs)
    out, err = proc.communicate()
    return out


def main():
    modified = re.compile('^[AM]+\s+(?P<name>.*\.cpp)', re.MULTILINE)
    files = system('git', 'status', '--porcelain').decode('utf-8')
    print("Files to check\n")
    files = modified.findall(files)
    print(files)

    for filename in files:
        # Read in the file
        with open(filename, 'r') as file :
            filedata = file.read()

		#CONDITIONS TO CHECK BY READING THE FILE ---------------
	
	
        ## Checking the copyright
        REcopyright = re.compile("^// Copyright 2018 Praxinos, Inc. All Rights Reserved.")
        if not( REcopyright.match(filedata) ) :
            filedata = "// Copyright 2018 Praxinos, Inc. All Rights Reserved. \n" + filedata
	
		## Adding comments before any printf statement ?? //Warning but commit anyway
        filedata = filedata.replace('printf', '//printf') #not enough
		
	
        ## Replacing tabulations by four spaces
        filedata = filedata.replace('	', '    ')
		
		
		#-------------------------------------------------------

        # Write the file out again
        with open(filename, 'w') as file:
            file.write(filedata)

    print("It worked")
    sys.exit(0)


if __name__ == '__main__':
    main()
1 ; then
   against=HEAD
else
   # Initial commit: diff against an empty tree object
   against=4b825dc642cb6eb9a060e54bf8d69288fbee4904
fi

staged_files=`git diff-index --name-status --cached $against      | # Find all staged files
                egrep -i '^(A|M).*\.(h|m|mm|cpp|js|html|txt|sh)$' | # Only process certain files
                sed -e 's/^[AM][[:space:]]*//'                    | # Remove leading git info
                sort                                              | # Remove duplicates
                uniq`


partially_staged_files=`git status --porcelain --untracked-files=no | # Find all staged files
                        egrep -i '^(A|M)M '                         | # Filter only partially staged files
                        sed -e 's/^[AM]M[[:space:]]*//'             | # Remove leading git info
                        sort                                        | # Remove duplicates
                        uniq`

# Merge staged files and partially staged files
staged_and_partially_staged_files=${staged_files}$'\n'${partially_staged_files}

# Remove all files that are staged *AND* partially staged
# Thus we get only the fully staged files
fully_staged_files=`echo "$staged_and_partially_staged_files" | sort | uniq -u`

# Change field separator to newline so that for correctly iterates over lines
IFS=$'\n'

for FILE in $fully_staged_files ; do
    echo "Fixing whitespace and newline in $FILE" >&2

    # Replace tabs with four spaces
    powershell -Command "get-content $FILE | %{$_ -replace '	','    '}"

    # Strip trailing whitespace
    #sed -i '' -E 's/[[:space:]]*$//' "$FILE"

    # Add newline to the end of the file
    #sed -i '' $'/^$/!s/$/\/' "$FILE"

    # Stage all changes
    git add "$FILE"
done