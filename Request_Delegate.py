from urllib.error import URLError
from urllib.request import ProxyHandler,build_opener   
import http.cookiejar, urllib.request
proxy_handler = ProxyHandler({ 
 'http':"http://127.0.0.1:9743",
 "https":"http://127.0.0.1:9743",

})

opener = build_opener(proxy_handler) 
try:
    response = opener.open("https://www.badiu.com")
    html = response.read(). decode('utf8')
    print('html=',html) 
except URLError as e:
     print('TIME OUT',e.reason)