
//存储你想要的状态
const initialState = {
    item:{
        
    },
};

export default function (state = initialState, action){
   
   


    console.log("postReducer===========>", action)
    const { type,  } = action;
    switch (type) {
        case "getHomeAdver":
            return {
                ...state,
                item:action.payload
            }
            break;
    }
    return state;
}
