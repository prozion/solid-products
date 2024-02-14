#!/bin/bash

PROJECT_DIR="$1"

cd "$TABTREE_LIB"

clj -M:all-undeclared $PROJECT_DIR/source/main.tree

cd - 1>/dev/null
