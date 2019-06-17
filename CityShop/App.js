/**
 * Sample React Native App
 * https://github.com/facebook/react-native
 * @flow
 */

import React, { Component } from 'react';
import {
  Platform,
  StyleSheet,
  Text,
  View
} from 'react-native';

import AppStart from './AppStart';
import Chat from './chat';
import { Provider } from 'react-redux';
// import { createStore, applyMiddleware } from 'redux';
// import reducer from './src/user';
// import thunk from 'redux-thunk';
// 基本创建store 的函数 const store = createStore(()=>[],{}, applyMiddleware());
//const store = createStore(reducer, applyMiddleware(thunk));

import {store} from './redux/store'
// import FetchHttpClient, { json } from 'fetch-http-client';

//import 'pile/dist/styles/pile.min.css';
// import Pile

// import Button from 'pile/dist/components/button';

export default class App extends Component {
  render() {
    return (
      <Provider store={store}>
         <AppStart/>
     </Provider>
    );
  }
}


