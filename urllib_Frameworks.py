
from typing_extensions import ParamSpec
from urllib import parse
from urllib.parse import urlparse, urlunparse,urlsplit,urlunsplit,urljoin,urlencode,parse_qs,parse_qsl,quote,unquote


#1urlparse 这里该方法可以实现 RL 的识别和分段，这里先用一个实例来看一下： 
url = 'https://www.baidu.com/index.htm;user?id=S#comment'
response= urlparse(url, scheme='https') 
print ('以实现 RL 的识别和分段',type(response),response)

#2 urlunparse()
result = urlparse ('http://www.baidu.com/index.html#comment', allow_fragments=False) 
#可以发现 URL 不包含 params query 时， fragment 便会被解析为 path 的一部分
#ParseResult(scheme='http', netloc='www.baidu.com', path='/index.html#comment', params='', query='', fragment='')
print(result)
print(result.scheme,'\n', result[0],'\n', result.netloc,'\n', result[1])

#编码urlunparse
data =['http','www.baidu com','index.html', 'user', 'a=6', 'comment'] 
print("编码urlunparse",urlunparse(data))

#3 urlsplit() 这个方法和 urlparse （） 方法非常相似， 只不过它不再单独解析 pa rams
results = urlsplit('https://www.baidu.com/index.htm;user?id=5#comment')
print("urlsplit解析",result)
print(result .scheme , result[0])

#4 urlunsplit()
#urlunparse （）类似，它也是将链接各个部分组合成完整链接的方法，传人的参数也是一个可迭代对象，例如列表 元组等，唯 的区别是长度必须为5
datas =['http','www.baiducom','index.html','a=6', 'comment'] 
print("urlunsplit解析",urlunsplit(datas))

#5 urljoin()
#有了 urlunparse （）和 urlu isplit （）方法，我们可以完成链接的合井，不过前提必须要有特定长度的对象，链接的每一部分都要清晰分开
#此外，生成链接还有另 个方法，那就是 urljoin （）方法 我们可以提供一个 base_url （基础链
#作为第 个参数，将新的链接作为第二个参数，该方法会分析 base_url scheme netloc path
#个内容并对新链接缺失的部分进行补充，最后返回结果
#通过 urljoin （）方法，我们可以轻松实现链接的解析、拼合与生成
urls = 'https://www.baidu.com';
url_about = 'https://www.baidu.com/about.html';
url_html = 'https://cuiqingcai.com/FAQ.html';
print(urljoin(urls,'FAQ.html')) 
print(urljoin(urls, url_html)) 
print(urljoin (url_about, url_html)) 
print(urljoin(url_html,'https://cuiqingcai.com/FAQ.html?question=2')) 
print(urljoin('http://www.baiducom?wd=abc', 'https://cuiqingcai com/index.php'))
print(urljoin (urls,'?category=2#comment')) 
print(urljoin ('www.baidu.com','?category=2#comment')) 
print(urljoin('www.baidu.com#comment','?category=2'))

#6. urlencode() 
#这里我们再介绍一个常用的方法一－urlencode()，它在构造 GET 请求参数的时候非常有用，
#例如下：
params = {
    "name":"germey",
    "age":22
}
base_url = 'https://www.baidu.com?'
request_url = base_url+urlencode(params)
print("get请求参数序列化",request_url) 

#7.parse_qs()
#有了序列化，必然就有反序列化 如果我们有一串 GET 请求参数，利用 parse_qs()方法， 就可以将它转回字典，示例如下：
query= 'name=germey&age=22'
print("get请求参数反序列化",parse_qs(query))

#8. parse_qsl() 另外，还有 parse_qs （）方法，它用于将参数转化为元组组成的列表，示例如下
print("将参数转化为元组组成的列表",parse_qsl(query))

#9. quote()
#该方法可以将内容转化为 URL 编码的格式 URL 中带有中文参数时，有时可能会导致乱码的问题，此时用这个方法可以将巾文字符转化为 RL 编码，示例如下：
keyword ='壁纸'
keyword_url ='https://www.baidu.com/s?wd='+ quote(keyword) 
print("将中文字符转化为URL编码",keyword_url)

#10. unquote() 有了 quote （）方法，当然还有 unquote （）方法，它可以进行 URL 解码，示例如下：
print("将中文字符进行URL解码",unquote(keyword_url))