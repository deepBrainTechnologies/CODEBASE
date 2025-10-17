from pypdf import PdfReader

#____________________________________________________________
#
#                 class MetaPDF   (structure)
#____________________________________________________________
class MetaPDF:
  def __init__(self, title, abstract,pages):
    self.title="";
    self.abstract="";
    self.pages=0;

#____________________________________________________________
#
#         def getPDFmetadata(filename)
#____________________________________________________________
def getPDFmetadata(filename):
  reader = PdfReader(filename)

  meta = reader.metadata;
  metadata = MetaPDF("","",0);

  if (hasattr(meta,"title")):
    print(f" TITLE: {meta.title}")
    metadata.title=meta.title
  else:
    print(f" TITLE:  no title present")
    metadata.title= "no title present"

  if (hasattr(meta,"abstract")):
    print(f"ABSTRACT: {meta.abstract}")
    metadata.abstract = meta.abstract
  else:
    print("ABSTRACT: No abstract present")    ##; is deprecated
    metadata.abstract = " no abstract present"
  #endif

  
  return(metadata)  #could also return meta structure
#enddef function