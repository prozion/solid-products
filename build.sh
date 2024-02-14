#!/bin/bash

ROOT=$( cd -- "$( dirname "${BASH_SOURCE[0]}" )" &> /dev/null && pwd )
VALIDATOR_PATH=$HOME/app/shacl_validator

TARGET_TTL="$ROOT/target/solid_products.ttl"
SHAPES_TTL="$ROOT/shapes/products.shacl.ttl"

# echo ""
# echo "* Check undeclared objects and predicates"
# $ROOT/scripts/checks/all_undeclared.sh $ROOT

echo ""
echo "* Generate RDF graph (Turtle format) from Tabtree source files"
$ROOT/scripts/generators/compile_turtle.sh $TABTREE_LIB "$ROOT/source/main.tree" $TARGET_TTL

echo ""
echo "* Generate SHACL shapes RDF"
$ROOT/scripts/generators/compile_turtle.sh $TABTREE_LIB "$ROOT/shapes/products.shacl.tree" $SHAPES_TTL

echo ""
echo "* Validate Turtle code with shapes"
java -jar $VALIDATOR_PATH/validator.jar -contentToValidate $TARGET_TTL -externalShapes $SHAPES_TTL
# java -jar validator.jar -contentToValidate $TARGET_TTL -externalShapes $SHAPES_TTL

echo ""
echo "* Some SPARQL..."
echo "** Graph statistics:"
arq --data $TARGET_TTL --query $ROOT/sparql/kgr_stat.rq
