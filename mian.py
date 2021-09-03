
from urllib.parse import urlparse, urlunparse


#这里该方法可以实现 RL 的识别和分段，这里先用一个实例来看一下： 
url = 'https://www.baidu.com/index.htm;user?id=S#comment'
response= urlparse(url, scheme='https') 
print ('以实现 RL 的识别和分段',type(response),response)

result = urlparse ('http://www.baidu.com/index.html#comment', allow_fragments=False) 
#可以发现 URL 不包含 params query 时， fragment 便会被解析为 path 的一部分
#ParseResult(scheme='http', netloc='www.baidu.com', path='/index.html#comment', params='', query='', fragment='')
print(result)
print(result.scheme,'\n', result[0],'\n', result.netloc,'\n', result[1])

#编码urlunparse
data =['http','www.baidu com','index.html', 'user', 'a=6', 'comment'] 
print("编码urlunparse",urlunparse(data))