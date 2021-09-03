
import http.cookiejar, urllib.request
from urllib import request,error
#在做爬虫的时候，免不了要使用代理，如果要添加代理，可以这样做：


urls = 'http://image.baidu.com/search/index?tn=baiduimage&ps=1&ct=201326592&lm=-1&cl=2&nc=1&ie=utf-8&word=%E8%8C%83%E5%86%B0%E5%86%B0'
url = 'http://www.baidu.com'


# cookie = http. cookiejar.CookieJar() 
# handler = urllib .request.HTTPCookieProcessor (cookie) 
# opener = urllib.request.build_opener(handler) 
# response = opener.open("http://www.baidu.com")


filename = 'cookies.txt' 
# cookie = http.cookiejar.MozillaCookieJar(filename)  MozillaCookieJar 格式
cookie = http. cookiejar. LWPCookieJar (filename)
handler = urllib.request.HTTPCookieProcessor(cookie) 
opener = urllib.request.build_opener(handler) 
response = opener.open (url) 
cookie.save(ignore_discard=True , ignore_expires=True)

for item in cookie:
    print(item.name+'='+item.value)


#读取了 Cookies 文件后，怎样从文件中读取并利用呢？
cookie = http.cookiejar. LWPCookieJar() 
cookie.load(filename, ignore_discard=True , ignore_expires=True) 
handler = urllib.request .HTTPCookieProcessor(cookie) 
opener = urllib .request.build_opener(handler) 
try:
   response= opener.open(url) 
   print ('读取了 Cookies 文件',response.read().decode ('utf-8'))
except error.URLError as e: 
    #处理异常-URLError它具有 个属性 reason ，即返回错误的原因
   print(e.reason) 