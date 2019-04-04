import os

verbose = True

#get definitions and includes first
definitions = ["NOTHING","OTHER"]
temp = ""
for definition in definitions:
    temp = temp + " -D " + definition
definitions = temp

includes = ""
for subdir, dirs, files in os.walk('E:\GMS_Tech'):
    if not subdir or subdir.startswith('E:\GMS_Tech\.git'):
        continue
    includes = includes + " -I " + subdir
includes = includes + " -I ./"

definitions_mtime = os.path.getmtime('E:\GMS_Tech\cpp_definitions.txt')

total = 0

for subdir, dirs, files in os.walk('E:\Detective_Morrison'):
    #come up with all dependent files, including .cpp file
    for file in files:
        if not file.endswith('.cpp'):
            continue
        if verbose:
            print(">>>>>>>>>>>>>>><<<<<<<<<<<<<")
            print(file)
            print(">>>>>>>>>>>>>>><<<<<<<<<<<<<")

        needs_update = False

        original_path = os.path.join(subdir, file)

        equivalent_mtime = 0
        equivalent_path = original_path.replace('.cpp','')

        if not os.access(equivalent_path, os.F_OK):
            needs_update = True
            if verbose:
                print("Needs update due to inexistent copy")
        else:
            equivalent_mtime = os.path.getmtime(equivalent_path)

        if equivalent_mtime < definitions_mtime:
            needs_update = True
            if verbose:
                print("Needs update due to definitions file update")

        if not needs_update:
            command = "cpp " + original_path + " -M > dependencies.txt"
            os.system(command)

            dependency_file = open("dependencies.txt", 'r')
            subfiles = dependency_file.readlines()
            dependency_file.close()
            os.remove("dependencies.txt")

            #check original_mtime against file mtime
            for subfile in subfiles:
                if verbose:
                    print(subfile)
                mtime = os.path.getmtime(subfile)
                if equivalent_mtime < mtime:
                    if verbose:
                        print("Needs update due to subfile updates")
                    needs_update = True
                    break

        if needs_update:
            #preprocess
            command = "cpp " + original_path + " -imacros E:/GMS_Tech/cpp_definitions.txt -nostdinc -C -P " + includes + definitions + " > " + equivalent_path

            os.system(command)

            total += 1

print("Total files pre-processed: ", total)
