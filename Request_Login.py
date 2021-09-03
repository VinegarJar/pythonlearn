from urllib.request import HTTPPasswordMgrWithDefaultRealm, HTTPBasicAuthHandler, build_opener 
from urllib.error import URLError   
#输入用户名和密码，验证成功后才能查看页面，
#这里首先实例 HTTPBasicAuthHandler 对象，其参数是 HTTPPasswordMgrWithDefaultRealm 对象，它利用 ad _password （）添加进去用户名和密码，这样就建立了一个处理验证的 Handler

username = 'username' 
password = 'password'
url = 'http: //localhost:sooo/'

p = HTTPPasswordMgrWithDefaultRealm() 
p.add_password(None, url, username , password) 
auth_handler = HTTPBasicAuthHandler(p) 
opener = build_opener(auth_handler)


try:
    result = opener.open(url)
    html = result.read(). decode('utf8')
    print('html=',html) 
except URLError as e:
     print('TIME OUT',e.reason) 

