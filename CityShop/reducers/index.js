
import {combineReducers}  from 'redux';
import postReducer from './postReducer'; 

export default combineReducers({
    // a:aReducer,
    // b:bReducer,
    // c:cReducer,
    post:postReducer,
})
