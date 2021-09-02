from urllib import request, parse
   
#这里我们通过 个参数构造了一个请求，其中 url 即请求 URL, headers 中指定了 User-AgentHost ，参数 data urlencode （）和 bytes （）方法转成字节流 另外，指定了请求方式为 POST   
url = 'http://httpbin.org/post'

headers = {
    'User-Agent':'Mozilla/4.0 (compatible; MSIE S. S; Windows NT)', 
     'Host':'httpbin.org'
}

dict = {
    'name':'Germey'
}

data= bytes(parse.urlencode(dict), encoding='utf8') 
req = request.Request(url=url, data=data, method='POST') 
req.add_header('User-Agent', 'Mozilla/4.0 (compatible; MSIE S. S; Windows NT)')
response = request.urlopen(req) 
print(response. read(). decode('utf8'))