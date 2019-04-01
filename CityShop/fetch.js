import { DeviceEventEmitter } from "react-native";
import MessageManager, { MessageType, Message } from "./Events/MessageManager";
export async function get(url) {
    const uri = encodeURI(url)
    return fetch(uri, {
        method: 'GET',
        headers: {
            Accept: 'application/json',
            'Content-Type': 'application/json',

        }
    }).then(filterStatus).then(filterJSON)
}

export async function post(url, body) {
    const uri = encodeURI(url)
    return fetch(uri, {
        method: 'POST',
        headers: {
            Accept: 'application/json',
            'Content-Type': 'application/json',
        },
        body: JSON.stringify(body)
    }).then(filterStatus).then(filterJSON)
}

function filterStatus(response) {
    if (response.status >= 200 && response.status < 300) {
        return response;
    }
    const errortext = codeMessage[response.status] || response.statusText;
    const error = new Error(errortext);
    error.name = response.status;
    error.response = response;
    throw error;
}

function filterJSON(res) {
    console.log("appinfo.che", res);
    console.log("appinfo.che", res._bodyText);
    return res.json()
}


export function urlEncode(param, key, encode) {
    if (param == null) return '';
    var paramStr = '';
    var t = typeof (param);
    if (t == 'string' || t == 'number' || t == 'boolean') {
        paramStr += '&' + key + '=' + ((encode == null || encode) ? encodeURIComponent(param) : param);
    } else {
        for (var i in param) {
            var k = key == null ? i : key + (param instanceof Array ? '[' + i + ']' : '.' + i);
            paramStr += urlEncode(param[i], k, encode);
        }
    }
    return paramStr;
};



export function call(options) {
    options.isLoading && DeviceEventEmitter.emit('HTR_Loading', true);
    return get(options.url)
        .then((msg) => {
            options.isLoading && DeviceEventEmitter.emit('HTR_Loading', false);
            return msg;
        }).catch(e => {
            options.isLoading && DeviceEventEmitter.emit('HTR_Loading', false);
            return null;
        })

}

/**
 * Requests a URL, returning a promise.
 *
 * @param  {string} url       The URL we want to request
 * @param  {object} [options] The options we want to pass to "fetch"
 * @return {object}           An object containing either "data" or "err"
 */
export function request(url, options) {
    console.log("fetch.request", url);
    const defaultOptions = {
        credentials: 'include',
    };
    const newOptions = { ...defaultOptions, ...options };
    if (newOptions.method === 'POST' || newOptions.method === 'PUT') {
        newOptions.headers = {
            'Content-Type': 'application/x-www-form-urlencoded;charset=utf-8',
            ...newOptions.headers,
        };
        newOptions.mode = "cros";
        var formData = new FormData();

        for (var name in newOptions.body) {
            if (typeof newOptions.body[name] == "object") {
                for (var o in newOptions.body[name]) {
                    formData.append(name + "[" + encodeURI(o) + "]", newOptions.body[name][o]);
                }
            } else {
                formData.append(name, newOptions.body[name]);
            }

        }
        newOptions.body = formData;

        console.log("请求数据", newOptions.body)

    }

    return new Promise((res, rej) => {
        fetch(url, { newOptions, method: newOptions.method, body: newOptions.body })
            .then(filterStatus)
            .then((response) => {
                console.log("fetch1", response)
                if (newOptions.method === 'DELETE' || response.status === 204) {
                    return response.text();
                }
                const data = response.json();
                return data;
            }).then((data) => {
                console.log("fetch2", data)
                if (data.status_code == 200) {
                    MessageManager.fireEvent(new Message("请求成功", MessageType.Success, null, null, url));
                }
                if (data.status == 203) {
                    DeviceEventEmitter.emit('NativeNotice', { data: JSON.stringify({ event: "loginOut" }), event: "loginOut" });
                }
                res(data)
            }).catch((error) => {
                MessageManager.fireEvent(new Message(error.message, MessageType.ErrorShould, null, null, { url, error }))
                rej(error);
            })
    })
}



const codeMessage = {
    200: '服务器成功返回请求的数据',
    201: '新建或修改数据成功。',
    202: '一个请求已经进入后台排队（异步任务）',
    203: 'token已失效',
    204: '删除数据成功。',
    400: '发出的请求有错误，服务器没有进行新建或修改数据,的操作。',
    401: '用户没有权限（令牌、用户名、密码错误）。',
    403: '用户得到授权，但是访问是被禁止的。',
    404: '发出的请求针对的是不存在的记录，服务器没有进行操作',
    406: '请求的格式不可得。',
    410: '请求的资源被永久删除，且不会再得到的。',
    422: '当创建一个对象时，发生一个验证错误。',
    500: '服务器发生错误，请检查服务器',
    502: '网关错误',
    503: '服务不可用，服务器暂时过载或维护',
    504: '网关超时',
};