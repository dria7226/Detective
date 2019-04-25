import os

total = 0

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

#pre process every file
for subdir, dirs, files in os.walk('E:\Detective_Morrison'):
    for file in files:
        if not file.endswith('.cpp'):
            continue

        #preprocess
        command = "cpp " + os.path.join(subdir, file) + " -imacros E:/GMS_Tech/cpp_definitions.cpp -nostdinc -C -P " + includes + definitions + " > " + os.path.join(subdir, file.replace(".cpp",""))

        output = os.system(command)

        total += 1

print("Total files pre-processed: ", total)
