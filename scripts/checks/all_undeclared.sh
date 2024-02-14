#!/bin/bash

PROJECT_DIR="$1"

cd "$TABTREE_LIB"

clj -M:all-undeclared --tabtree $PROJECT_DIR/source/main.tree --ignore-keys "$2"

cd - 1>/dev/null
