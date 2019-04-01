import { stringify } from 'qs';
import { request, post } from '../tools/fetch';
import { apiConfig } from "../redux/config/apiConfig";
import CryptoJS from "crypto-js";


// 用户信息
export const User = {
    _url: apiConfig.current.uUrl,
    login: async function (params) {
        return await request(User._url + '/api/user/login', {
            method: "POST",
            body: Object.assign({ identity_no: 1003 }, params),
        });
    },
    getUserBase: async function (params) {
        return await request(User._url + `/api/identity/base/get_base_info?${stringify(params)}`);
    },


    checkJoin: async function (params) {
        return await request(apiConfig.current.registerUrl + `/api/identity/check_join?${stringify(params)}`);
    }, 

}

//扫描查询VIN码 
//var _params = { app: 1, sys: 0, token: CryptoJS.MD5("4e@9b0a8c1b732@b").toString(),
//version: appVersion, version_d: wgtVersion };
//'sign': _this.$md5(_this.$md5(base + "8hhj76q.mkjsfs44|z%"))
//mUrl: "https://m" + -test.ecpei + ".cn/",
//'sign': CryptoJS.MD5(baseMd5).toString()
export const QueryVINCode = {

     getVINCode: async function (base){
        let url = apiConfig.current.mUrl + 'intelligent/';
        base  = "data:image/jpg;base64,"+base;
        var baseMd5 = CryptoJS.MD5(base + "8hhj76q.mkjsfs44|z%").toString(CryptoJS.enc.Hex);
        var datas = {
            's': base,
            'sign':CryptoJS.MD5(baseMd5).toString(CryptoJS.enc.Hex),
        }
        return await request(url, {
            method: "POST",
            body: { ...datas}
        });
        // return post(url,datas);
    }



}

//图片上传
export const ImageUploadPort = {
    getPicUrl: async function(base,uid,token){
        let url=apiConfig.current.sUrl +'/upload';
        base  = "data:image/jpg;base64,"+base;
        var datas={
            'base64img':base,
            'uid':uid||'',
            'token':token||''
        }
        return await request(url, {
            method: "POST",
            body: { ...datas}
        });
    }
}



//品牌信息
export const Brand = {
    _url: apiConfig.current.gUrl,
    all: async function () {
        return await request(Brand._url + '/api/users/brand/hot');
    },
}


// 热门车系
export const HotCar = {
    _url: apiConfig.current.vinUrl,
    hotCarBrand: async function () {
        return await request(HotCar._url + '/api/series/hot');
    },
}

// 消息中心
export const MessageCenter = {
    _url: apiConfig.current.msgUrl,
    //物流消息
    getCenterMessagelogisticsAndSys: async (params) => {
        params = {...params,app_type:1}
        return await request(MessageCenter._url + `/api/push/system/get?${stringify(params)}`, {
            method: "GET"
        });
    },
    //获取互动消息 的所有公司
    getInterchangeMessage:async (params)=>{
        return await request(MessageCenter._url+`/api/push/message/user?${stringify(params)}`,{
            method:"GET"
        })
    },
    //获取某个公司的聊天消息
    getCompanyMessages:async (params)=>{
        return await request(MessageCenter._url+`/api/push/message/list?${stringify(params)}`,{
            method:"GET"
        })
    },
    //聊天中心得到商品消息
    getGoodsEdit: (uid,token,id)=>{
        //gUrl
        return request(apiConfig.current.gUrl+`/api/v1_0_1/users/goods/goodsinfo?${stringify({uid,token,id})}`)
    },
    //聊天中心检查第一次聊天
    checkFirstChat:(uid,token,to_user,to_name)=>{
        return request(MessageCenter._url+`/api/user/get_info?${stringify({uid,token,to_user,to_name})}`)
    },
    //聊天中心得到自己的标识
    getMyFlag:(uid,token)=>{
        return request(apiConfig.current.uUrl+`/api/user/get_info?${stringify({uid,token})}`)
    },
    uploadChatImage:(uid,token,image)=>{
        return request(apiConfig.current.sUrl+`/upload`,{
            method:"POST",
            body:{
                "base64img":"data:image/png;base64,"+image,
                uid,
                token
            }
        })
    },
    //发送离线信息
    //MessageCenter.sendLifeMessage(this._user.uid,this._user.token,this._last_msg.to_user,this._last_msg.to_name)
    sendLifeMessage:(uid,token,content,to_user,to_name)=>{
        return  request(MessageCenter._url + "/api/push/message/add",{
            method:"POST",
            body:{
                uid,
                token,
                to_user,
                to_name,
                content
            }
        })
    }
};

//商户中心---我的销售
export const MySale = {
    _url: apiConfig.current.oUrl,
    getMySaleData: async function (params) {
        let url = MySale._url + `/api/company/order/total?${stringify(params)}`;
        return await request(url, {
            method: "GET"
        })
    }
};
//商户中心-我的采购
export const MyPurchase = {
    _url: apiConfig.current.oUrl,
    getMyPurchaseData: async function (params) {
        let url = MyPurchase._url + `/api/buyer/goods/total?${stringify(params)}`;
        return await request(url, {
            method: "GET"
        })
    }
};
//商户名片
export const UserBuinessCard = {
    // _url: `https://g-api-test-1-0-1.ecpei.cn`,
    _url: apiConfig.beta.gUrl,
    getUserBuinessCard: async function (params) {
        let url = UserBuinessCard._url + `/api/users/favorites/shop_info?${stringify(params)}`;
        return await request(url, {
            method: "GET",
        });
    }
};

//商户公司信息
export const UserCompany = {
    _url: apiConfig.beta.uUrl,
    getUserCompany: async function (params) {
        let url = UserCompany._url + `/api/identity/base/get_company?${stringify(params)}`;
        return await request(url,{
            method:"GET",
        });
    }
};
//购物车
export const Carts = {
    _url: apiConfig.current.oUrl,
    getShopCart: async (params) => {
        let url = Carts._url + `/api/shopping/car/get?${stringify(params)}`;
        return await request(url, {
            method: "GET"
        });
    },
    deleteGoods: (params,uid,token) => {
        let url = Carts._url + `/api/shopping/car/del`;
        return request(url, {
            method: "POST",
            body: { ...params,uid,token}
        });
    },
    changeGoodsCount: async (goods_id,goods_num,filed_desc,uid,token)=>{

        let url = Carts._url + `/api/shopping/car/add_goods`;
        return await request(url,{
            method:"POST",
            body:{
                goods_id,goods_num,filed_desc,uid,token
            }
        })
    }
};

//商户入驻状态检测
export const CheckJoin = {
    _url:apiConfig.beta.uUrl,
    checkJoinCompany: async function (params) {
        let url = CheckJoin._url + `/api/identity/check_join?identity_no=1003&&${stringify(params)}`;
        return await request(url,{
            method:"GET"
        })
    }
};

