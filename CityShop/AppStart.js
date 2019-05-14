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
import { CachedImage } from "react-native-img-cache";
import { GiftedChat } from "react-native-gifted-chat";
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
    // 请求网络数据this.props.getHomeAdver();

    // this.props.getHomeAdver().then((res) => {
    //   console.log("获取经营范围数据===============", res);

    //  }).catch((error) => {

    //  });

  }


  state = {
    messages: [],

  };

  componentWillMount() {
    this.setState({
      messages: [
        {
          _id: 1,
          text: "Hello developer",
          createdAt: new Date(),
          user: {
            _id: 2,
            name: "React Native",
            avatar: "https://placeimg.com/140/140/any"
          }
        }
      ]
    });
  }



  /* <TouchableOpacity
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
source={{ uri: 
"https://timgsa.baidu.com/timg?image&quality=80&size=b9999_10000&sec=1554109606585&di=e7d16141b734c59b60236165cb81504e&imgtype=0&src=http%3A%2F%2Fhbimg.b0.upaiyun.com%2Fae301becc97016fde8f4178239c258263b44f5e08d1e-L7CDKh_fw658" }} mutable />
*/

  onSend(messages = []) {
    this.setState(previousState => ({
      messages: GiftedChat.append(previousState.messages, messages)
    }));
  }


  render() {
    return (

      <GiftedChat messages={this.state.messages}
        onSend={messages => this.onSend(messages)}
        user={{_id: 1  }} placeholder = {"请输入您的问题！"}
        maxInputLength = {10} 
      />

    );
  }

  backToTop() {

    console.log("this.props.post=======>", this.props.post)

  }

  inputToolbar  = () =>{
     return(
         <View style={{ backgroundColor:"orange",height:100,width:320}}>

         </View>

     );
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
  getHomeAdver: PropTypes.func.isRequired,
  post: PropTypes.object.isRequired,
}

const mapStatetoProps = (state, props) => ({
  post: state.post,
});
export default connect(mapStatetoProps, { getHomeAdver })(App);


//方式二
// const mapStatetoProps = (state, props) => ({
//   post: state.post,
// });

// const mapDispatchToProps = dispatch => ({
//   getHomeAdver: () => dispatch(getHomeAdver()),
// });

// export default connect(mapStatetoProps, mapDispatchToProps)(App);