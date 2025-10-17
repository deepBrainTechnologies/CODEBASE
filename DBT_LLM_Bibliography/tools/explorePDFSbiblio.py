import os;
import pythonGetPDFmetadata as skimPDFS;



folderpath = "D:\\DEEPBRAINTECHNOLOGIES\\NEUROSCIENCEWORK\\Bibiliography\\";
listDIR = os.listdir(folderpath);
nFiles = len(listDIR);
filesList = [""]*(nFiles+1);    #filesList = list();
print("_____  processing " + str(nFiles) + " files ________")

ix=1
for item in listDIR:
  if (len(item)>4):
    filesList[ix] = item
    print(item)
    print(filesList[ix])
    ix=ix+1
  #ifend
#forend


filepath = "D:\\DEEPBRAINTECHNOLOGIES\\NEUROSCIENCEWORK\\Bibiliography\\retinalHDEA.pdf";


for idx in range(1,(ix-1)):
  if (filesList[idx].endswith('.pdf')):
    filepath = folderpath + filesList[idx]
    print("PDF filename: " + filepath)
    metadata = skimPDFS.getPDFmetadata(filepath)
#endfor



