<template>
    <div class="mini-layour">
      <header class="headLine">
        <img alt="" src="../../resource/image/logo0.png" style="height: 80px;position: absolute;top: 10px;left: 15%;">
        <img alt="" src="../../resource/image/line.png" style="height: 80px;position: absolute;top: 10px;left: 35%;">
        <router-link to="/AdmHome">
                <p class="textstyle" >首页</p>
            </router-link>
            <span class="textstyle" style="left:80%;z-index: 7;"  >管理员，您好！</span>
            <!--
            <div @mouseenter="showDropdown=true" @mouseleave="showDropdown = false">
            <div class="dropdown" v-if="showDropdown" style="z-index: 6;"  @mouseenter="showDropdown=true" >
              <ul  @mouseenter="showDropdown=true">
                <li @click="logout" >退出登录</li>
              </ul>
            </div>
          </div>-->
      </header>
      <div class="contain">
        <div class="box">
          <div class="leftbox ">
            <div>
              <p>服务信息</p>
              <p>查看/修改账号信息</p>
            </div>
          </div>
          <div class="container">
            <h1>账号信息</h1>
            <div class="divider-line">
              <span></span>
            </div>
            <form @submit="change_info">
              <div class="form-group">
                <label for="a_id">账号:</label>
                <input type="text" id="a_id" name="username" v-model="a_Id" :disabled="isDisAbled">
              </div>
              <div class="form-group">
                <label for="a_name">姓名:</label>
                <input type="tel" id="a_name" name="phone" v-model="a_Name" :disabled="isDisAbled">
              </div>
              <!--
              <div class="form-group">
                <label for="a_email">邮箱:</label>
                <input type="email" id="a_email" name="email" v-model="a_Email" :disabled="isDisAbled">
              </div>
              -->
              <div class="form-group">
                <label for="a_password">密码:</label>
                <input type="password" id="a_password" name="password" v-model="a_Password" :disabled="isDisAbled">
              </div>
              <div v-show="!status">
                <button style="margin-left: 60%;" @click.prevent="statusChange">修改</button>
              </div>
              <div v-show="status">
                <button type="submit" style="margin-left: 60%;">保存修改</button>
                <button type="button" @click.prevent="cancelChanges">取消</button>
              </div>
            </form>
          </div>
        </div>
      </div>
    </div>
  </template>
  
  <script>
  import axios from 'axios'
  export default {
    data() {
      return {
        showDropdown: false,
        status: false,
        isDisAbled: true,
        a_Id: '',  // 绑定账号输入框的值
        a_Name: '',      // 绑定姓名输入框的值
        a_Email: '',     // 绑定邮箱输入框的值
        a_Password: '',  // 绑定密码输入框的值
        temp_data: {},   // 用来保存临时数据
      };
    },
    methods: {
      logout() {
      // 在这里执行退出登录的操作
      this.$router.replace('/admLogin')
    },
      change_info(){
        const jsdata={
          a_Id:this.a_Id,
          a_Name:this.a_Name,
          a_Password:this.a_Password
        }
        console.log("进入修改")
      axios.patch('/api/modify_admin', jsdata)
        .then((response) => {
          console.log('Post request successful:', response.data);
          console.log(response.data.code)
        })
        .catch((error) => {
          console.error('Post request failed:', error);
          
        });
      },
      cancelChanges() {
        // 将临时数据赋值回输入框的值
        this.a_Id = this.temp_data.a_Id;
        this.a_Name = this.temp_data.a_Name;
        this.a_Password = this.temp_data.a_Password;
        this.status = !this.status;
        this.isDisAbled = !this.isDisAbled;
      },
      statusChange() {
        // 在修改按钮点击时，保存当前输入框的值到临时数据
        this.temp_data.a_Id = this.a_Id;
        this.temp_data.a_Name = this.a_Name;
        this.temp_data.a_Password = this.a_Password;
        
        // 切换状态
        this.status = !this.status;
        this.isDisAbled = !this.isDisAbled;
      },
      updata_temp_data() {
        this.temp_data.a_Id = this.a_Id;
        this.temp_data.a_Name = this.a_Name;
        this.temp_data.a_Password = this.a_Password;
      },
     
    },
    mounted() {
      this.a_Id=localStorage.getItem("Adm_id");
        var url = "/api/admin_info?a_id=" + this.a_Id;
        var xmlRequest = new XMLHttpRequest();
        xmlRequest.onreadystatechange = () => {
          if (xmlRequest.status == 200 && xmlRequest.readyState == 4) {
            var jsdata = JSON.parse(xmlRequest.responseText);
            this.a_Id = jsdata.data.a_Id;
            this.a_Name = jsdata.data.a_Name;
            this.a_Password = jsdata.data.a_Password;
            this.updata_temp_data();
          }
        };
        xmlRequest.open("GET", url);
        xmlRequest.send();
    }
  };
  </script>
  
  <style scoped>
  body {
  font-family: Arial, sans-serif;
  background-color: #e7e1e1;
  margin: 0;
  padding: 0;
}
.dropdown {
  position: absolute;
 height: 40px;
  width: 130px;
  top: 50px;
  left: 80%;
  z-index:6;
}

.dropdown ul {
  height: 70px;
  list-style: none;
  padding: 0;
  background-color:rgb(119,108,83);
}

.dropdown li {
margin-left: 10px;
font-size: 16px;
color: rgb(237,216,166);
}

.dropdown li:hover {
  color: rgb(182, 152, 83);
}
.mini-layour{ 
  position: relative;
  display: block;
  width: 100%;
  margin: 0 auto;
  height:100%;
}
.headLine{
display: block;
position: absolute;
line-height: 100px;
position: fixed;
height: 100px;
background-color: rgb(119,108,83);
left:0;
top: 0;
width: 100%;
margin-bottom: 10px;
}

.container {
position:absolute;
left: 17%;
top: 20px;
height: 86%;
min-width: 45%;
width: 50%;
margin-top: 0px;
background-color: #fff;
border-left:2px #000 ;
border-right: 2px #000;
max-width: 400px;
background-color: rgb(255, 255, 255);
box-shadow: rgba(0, 0, 0, 0.1) 0px 0px 10px;
padding: 10px;
border-radius: 8px;
}
.contain{
display: flex;
flex-wrap: wrap;

}
.leftbox{
position: absolute;
top:20px;
padding: 30px;
right: 8%;
width: 20%;
margin-left: 10px;
background-color: #ffffff;
float: right;
box-sizing: border-box;
border: 2px solid #efe3af;
}
.box{
float: left;
position: absolute;
left:0;
top:100px;
width: 100%;
min-height: 87vh;
border-radius: 4px;
box-sizing: border-box;
background: #fffafa;
border: 1px solid #e2e2e2;
}
h1 {
text-align: center;
font-weight: lighter;
margin-bottom: 20px;
}

.form-group {
display: flex;
align-items: center;
width: 60%;
margin-bottom: 20px;
margin-left: 30px;
margin-top: 20px;
padding: 15px;
}
.divider-line{
border: 1px #d3d3d3 solid;
box-shadow: 0 0 3px #dfdfdf inset;
border-radius: 10px;
background: #eee;
}

.textstyle{
  position: absolute;
top:0px;
margin-bottom: 10px;
left:38%;
font-size: 20px;
color: rgb(237,216,166);
}
.itembox{
  display: inline-block;
  padding:0px;
  
  }
  .item1{
  display: inline;
  
  margin-left: 5px; /* 设置元素之间的间距 */
  margin-bottom: 8px;
  width: auto;
  min-width: 80px;
  margin: 10px;
  }
  .item{
    display: inline;
  
    margin-left: 5px; /* 设置元素之间的间距 */
    margin-bottom: 8px;
   
  }
label {
display: block;
font-weight:lighter;
margin-bottom: 5px;
margin-right: 5px;
padding-left: 5px;
}

input {
width: auto;
padding: 10px;
border: 1px solid #ccc;
border-radius: 4px;
margin-left: 15px;
}

button {
    padding: 10px 20px;
    background-color:  rgba(119, 108, 83, 0.712);
    color: #fff;
    border: none;
    border-radius: 4px;
    cursor: pointer;
    margin-right: 10px;
    }

    button:hover {
    background-color: #7e755a;
    }

button[type="button"] {
background-color: #ccc;
color: #000;
}

button[type="button"]:hover {
background-color: #b3b3b3;
}
form {
margin-bottom: 20px;
}

table {
border-collapse: collapse;
width: 100%;
}

th, td {
border: 1px solid #ddd;
padding: 8px;
text-align: left;
}

th {
background-color: #f2f2f2;
}

tr:hover {
background-color: #f2f2f2;
}
  </style>
  