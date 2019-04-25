import os

verbose = False

#get definitions and includes first
pre_process_definitions = open("pre_process_definitions.txt", 'r')
temp = ""
for definition in pre_process_definitions.read().splitlines():
    temp = temp + " -D " + definition
pre_process_definitions.close()
definitions = temp

includes = ""
for subdir, dirs, files in os.walk('E:\GMS_Tech'):
    if not subdir or subdir.startswith('E:\GMS_Tech\.git'):
        continue
    includes = includes + " -I " + subdir
includes = includes + " -I ./"

def get_subfiles(path, file):
    command = "cpp " + os.path.join(path,file) + includes + " -M > dependencies.txt"
    os.system(command)

    dependency_file = open("dependencies.txt", 'r')

    subfiles = []

    for part in dependency_file.readlines():
        part = part.replace(file.replace('.cpp','.o: '), '').replace('\\\n','').replace('\n','').replace('/','\\')
        for subfile in part.split():
            subfiles.append(subfile)

    dependency_file.close()
    os.remove("dependencies.txt")
    return subfiles

definitions_mtime = 0
for subfile in get_subfiles("E:\GMS_Tech","cpp_definitions.cpp"):
    definitions_mtime = max(definitions_mtime, os.path.getmtime(subfile))
definitions_mtime = max(definitions_mtime, os.path.getmtime("pre_process_definitions.txt"))

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
            print("Needs update due to inexistent copy")
        else:
            equivalent_mtime = os.path.getmtime(equivalent_path)

        if equivalent_mtime < definitions_mtime:
            needs_update = True
            print("Needs update due to definitions file update")

        if not needs_update:
            #check original_mtime against file mtime
            for subfile in get_subfiles(subdir, file):
                mtime = os.path.getmtime(subfile)
                if equivalent_mtime < mtime:
                    if verbose:
                        print("Needs update due to updated " + subfile)
                    else:
                        print("Needs update due to updated subfile.")
                    needs_update = True
                    break

        if needs_update:
            #preprocess
            print("Updating " + file)
            command = "cpp " + original_path + " -imacros E:/GMS_Tech/cpp_definitions.cpp -nostdinc -C -P " + includes + definitions + " > " + equivalent_path

            os.system(command)

            total += 1

print("Total files pre-processed: ", total)
