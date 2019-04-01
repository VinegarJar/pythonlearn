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
  View,
  TouchableOpacity
} from 'react-native';

import { connect } from "react-redux";
import { getHomeAdver } from './reducers/postAction';
import PropTypes from "prop-types"
import {CachedImage} from "react-native-img-cache";
const instructions = Platform.select({
  ios: 'Press Cmd+R to reload,\n' +
    'Cmd+D or shake for dev menu',
  android: 'Double tap R on your keyboard to reload,\n' +
    'Shake or press menu button for dev menu',
});




class App extends Component {



  //发送网络请求
  componentDidMount() {
    // this.requestNetwork();
    //   this.props.getHomeAdver({}).then((res) => {
    //   console.log("获取经营范围数据===============", res);

    //  }).catch((error) => {

    //  });
    this.props.getHomeAdver();

    // this.props.getHomeAdver().then((res) => {
    //   console.log("获取经营范围数据===============", res);

    //  }).catch((error) => {

    //  });

  }


  render() {
    return (
      <View style={styles.container}>
        <TouchableOpacity
          activeOpacity={1}
          onPress={() => this.backToTop()}>

          <Text style={styles.welcome}>
            Welcome to React Native!
        </Text>
        </TouchableOpacity>
        <Text style={styles.instructions}>
          To get started, edit App.js
        </Text>
        <Text style={styles.instructions}>
          {instructions}
        </Text>
        <CachedImage 
         style={{width:100,height:100}}
        source={{ uri: "https://timgsa.baidu.com/timg?image&quality=80&size=b9999_10000&sec=1554109606585&di=e7d16141b734c59b60236165cb81504e&imgtype=0&src=http%3A%2F%2Fhbimg.b0.upaiyun.com%2Fae301becc97016fde8f4178239c258263b44f5e08d1e-L7CDKh_fw658" }} mutable />
      </View>
    );
  }

  backToTop(){
  
    console.log("this.props.post=======>",this.props.post)
    
}


}

const styles = StyleSheet.create({
  container: {
    flex: 1,
    justifyContent: 'center',
    alignItems: 'center',
    backgroundColor: '#F5FCFF',
  },
  welcome: {
    fontSize: 20,
    textAlign: 'center',
    margin: 10,
  },
  instructions: {
    textAlign: 'center',
    color: '#333333',
    marginBottom: 5,
  },
});

//方式一
PropTypes.props = {
  getHomeAdver:PropTypes.func.isRequired,
  post:PropTypes.object.isRequired,
}

const mapStatetoProps = (state, props) => ({
  post: state.post,
});
export default connect(mapStatetoProps,{ getHomeAdver})(App);


//方式二
// const mapStatetoProps = (state, props) => ({
//   post: state.post,
// });

// const mapDispatchToProps = dispatch => ({
//   getHomeAdver: () => dispatch(getHomeAdver()),
// });

// export default connect(mapStatetoProps, mapDispatchToProps)(App);