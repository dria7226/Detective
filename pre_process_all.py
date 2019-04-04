import os

total = 0

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

#pre process every file
for subdir, dirs, files in os.walk('E:\Detective_Morrison'):
    for file in files:
        if not file.endswith('.cpp'):
            continue

        #preprocess
        command = "cpp " + os.path.join(subdir, file) + " -imacros E:/GMS_Tech/cpp_definitions.txt -nostdinc -C -P " + includes + definitions + " > " + os.path.join(subdir, file.replace(".cpp",""))

        output = os.system(command)

        total += 1

print("Total files pre-processed: ", total)
