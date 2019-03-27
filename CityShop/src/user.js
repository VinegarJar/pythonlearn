import StoreTypes from "./types";

const initialState = {
    
};

export default function (state = initialState, action){
   
    console.log("获取首页广告数据action=======：", action)
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
