
from urllib import request,error
import socket 
import urllib.request 
import urllib .error


#这里捕获了 HTTP Error 异常，输出了 reason code headers 属性 
url = 'https://cuiqingcai.com/index.htm'
try:
   response= request.urlopen(url) 
   #print ('处理HTTP请求错误',response.read().decode ('utf-8'))
except error.HTTPError as e: 
    #处理异常-URLError它具有 个属性 reason ，即返回错误的原因 seq='\n'
   print(e.reason, e.code, e.headers) 
except error.URLError as e: 
   print(e .reason) 
else: 
   print('Request Successfully')   


 #有时候,reason 属性返回的不一定是字符串，也可能是一个对象 再看下面的实例：  
try: 
   response = urllib.request.urlopen (url,timeout=0.01)
except  urllib.error.URLError as e: 
    print('e.reason=',type(e.reason)) 
    if isinstance(e.reason, socket.timeout):
       print('TIME OUT')