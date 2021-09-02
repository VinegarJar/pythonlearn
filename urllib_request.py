import urllib.request

response = urllib.request.urlopen("https://www.python.org")


# response = urllib.request.urlopen("http://httpbin.org/get",timeout=1 设置请求超时)
# print(response.read())
# print(response.read().decode('utf-8'))
# print(type(response))
print(response.status) 
print(response.getheaders()) 
print(response.getheader('Server'))