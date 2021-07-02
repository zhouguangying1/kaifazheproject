from hashlib  import md5
class   md56(object):
    def  __init__(self):
        pass

    def  md56 (self,str):
        md5_val = md5(str.encode("utf8")).hexdigest()
        
        return  md5_val

