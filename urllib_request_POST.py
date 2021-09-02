import urllib.request
import urllib.parse

# data 是post请求
data = bytes(urllib.parse.urlencode({'word':'hello'}),encoding='utf8')

response = urllib.request.urlopen("http://httpbin.org/post",data=data)

print(response.read().decode('utf-8'))
print(type(response))
# print(response.status) 
# print(response.getheaders()) 
# print(response.getheader('Server'))