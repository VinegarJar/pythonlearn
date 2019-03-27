import StoreTypes from "./types";
const  {GET_HOMEADVER } = StoreTypes;


export async function getHomeAdver(params) {
    // let data = await ZeroAppServer.getHomeAdver(params);
    // console.log("获取首页广告数据：", data)
    // return {
    //     type:GET_HOMEADVER,
    //     data:data
    // }

    let data = await {
        "link":"http://zt.cjwsc.com/zt/all_page/shuangdan20171221/index.html",
        "pic":"http://static.cjwsc.com//image/76/78/b4/7678b4ebf83bf5a8922db318078c891b.jpg",
         "titel":"首页广告数据", 
    };


    return {
        type:GET_HOMEADVER,
        data:data,
    }
}
