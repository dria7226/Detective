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

for subdir, dirs, files in os.walk('E:\Detective_Morrison\'):
    if subdir.endswith('Deprecated'):
        continue

    for file in files:
        #do only .blends
        if not file.endswith('.blend'):
            continue

        #compare "last modified" dates
        needs_update = False

        original_path = os.path.join(subdir, file)

        if not os.access(equivalent_path, os.F_OK):
            needs_update = True
        else:
            original_mtime = os.path.getmtime(original_path)
            equivalent_mtime = os.path.getmtime(equivalent_path)
            if original_mtime > equivalent_mtime:
                needs_update = True

        if needs_update:
            #open file in blender
            bpy.ops.wm.open_mainfile(filepath=original_path)

            model_within_bounds = True

            do_export(equivalent_path)

            if not model_within_bounds:
                os.remove(equivalent_path)
                print("Model ",file," is out of bounds (coordinate value should be less than ", COMPRESSED_NORMAL_POSITION,"). Model removed. Please correct and re-run script.")

            total += 1
