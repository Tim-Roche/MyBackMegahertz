#-------------------------------------------------------------------------------
# Name:        module1
# Purpose:
#
# Author:      TimRo
#
# Created:     03/03/2019
# Copyright:   (c) TimRo 2019
# Licence:     <your licence>
#-------------------------------------------------------------------------------

names = ["w_reg", "C0", "mem_cs", "B_sel", "mem_write_en", "IR_load", "status_load", "size", "add_tri_sel", "data_tri_sel","PC_sel"]
opDict = {}

def concatIntoString(l, start, end, unknowns):
    string = ""
    for i in range(start,end):
        toBeAdded = str(l[i])
        if(unknowns or toBeAdded!="?"):
            string += str(toBeAdded)
        else:
            string += "0"

    return(string)

with open("C:\\Users\\TimRo\\Downloads\\data.csv", "r") as file:
    data = file.readline()
    while(data != ""):
        dataList = data.split(",")
        opCode = dataList[0]
        description = dataList[1]
        FS = str(dataList[2])
        controlWord = concatIntoString(dataList,3,len(names)+3, False)
        data = file.readline()
        opDict[opCode] = [description, controlWord, FS, ""]

for word in opDict:
    test = 0b0000001
    shamt = 0
    controlWord = int(opDict[word][1],2)
    toAdd = ""
    for shamt in range(0,len(names)):
        print(bin(test))
        if(controlWord & test != 0):
            if(toAdd != ""):
                toAdd += ", "
            toAdd += names[shamt]
        test = test*2
    if(toAdd == ""):
        toAdd = "None"
    opDict[word][3] = toAdd

outputString = ""
for entree in opDict:
    string = "Name: " + str(entree) + "\n"
    string += "Description: " + opDict[entree][0] + "\n"
    string += "Control Signals: " + opDict[entree][3] + "\n"
    string += "FS = " + opDict[entree][2] + "\n"
    string += "\n"
    outputString += string

with open("C:\\Users\\TimRo\\Downloads\\data.txt", "w") as file:
    file.write(outputString)

print(outputString)




