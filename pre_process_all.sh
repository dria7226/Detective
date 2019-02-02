#!/bin/bash

#set -x

definitions="NOTHING -D OTHER"

# echo "$definitions"

includes="$(find E:/GMS_Tech -type d | tr '\n' '@'| sed 's/:$//' | sed 's/@/ -I /g')"

#echo $includes

for file in $(find $(dirname $0) -name '*.cpp');
do
	cpp $file -imacros E:/GMS_Tech/cpp_definitions.txt -I $includes ./ -C -D $definitions -P > ${file%.*cpp}
done