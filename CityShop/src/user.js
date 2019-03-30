import StoreTypes from "./types";

const initialState = {
    
};

export default function (state = initialState, action){
   
   // console.log("获取首页广告数据action=======：", action)
    const { type, ..._data } = action;
    switch (type) {
        case StoreTypes.GET_HOMEADVER:
            return {
                ...state,
                ..._data
            }
            break;
    }
    return state;
}


// 定义一个请求方法
// export  const  getHomeAdver = ()=> dispatch=>{
//     console.log("getHomeAdver");

//     fetch("https://portal-web.cjwsc.com/home/hotRecommend.action")
//     .then((response)=>response.json())
//     .then((posts)=>{
//         dispatch({
//             type:"getHomeAdver",
//            payload:posts
//         })

//     }).catch((error)=>{
//         console.log('错误信息'+error);
//     })

// }
