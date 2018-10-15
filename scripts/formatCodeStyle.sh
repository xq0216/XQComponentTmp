#!/bin/sh
clang_format=$SRCROOT/bin/clang-format
run_clangformat() {
    local filename="${1}"
    cd $SRCROOT
    if [ ! -f "$filename" ]; then
    return
    fi
    FILE_ALIAS='file'

    if [[ "${filename##*.}" == "m" || "${filename##*.}" == "h" || "${filename##*.}" == "mm" || "${filename##*.}" == "hpp" || "${filename##*.}" == "cpp" || "${filename##*.}" == "cc" ]]; then
    echo "$SRCROOT/$filename"
    echo "存在"
    $clang_format -i -style=$FILE_ALIAS "$SRCROOT/$filename"
    fi
}


#git ls-files -om --exclude-from=.gitignore | grep "G7_AI/" | while read filename; do run_clangformat "${filename}"; done
git diff --name-only | grep "XQComponentTmp/" | while read filename; do run_clangformat "${filename}"; done
