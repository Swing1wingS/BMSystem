<template>

    <div  id="app">
        <header class="headLine" >
            <img alt="xx" src="../../resource/image/logo0.png" style="height: 80px;position: absolute;top: 10px;left: 15%;">
            <img alt="xx" src="../../resource/image/line.png" style="height: 80px;position: absolute;top: 10px;left: 35%;">
              <div>
                <p class="textstyle" >首页</p>
              </div>
            <div @mouseenter="showDropdown=true" @mouseleave="showDropdown = false">
            <span class="textstyle" style="left:80%;z-index: 7;"  >管理员，您好！</span>
            <div class="dropdown" v-if="showDropdown" style="z-index: 6;"  @mouseenter="showDropdown=true" >
              <ul  @mouseenter="showDropdown=true">
                <li @click="logout" >退出登录</li>
              </ul>
            </div>
          </div>
        </header>
        
        <div style="height:auto;width: 100%;align-items: center; margin: 0px; padding: 0px;"  >
          <img alt="xxx" src="../../resource/image/1.jpg" height="auto" width="100%" >
        </div>
        <div class="bigframe">
          <div class="ulstyle">
              <div class="listyle" id="jump1" @click="$router.push('/bookmanage') ">  
                <img src="../../resource/image/book.png" alt=""  class="imagestyle" >
                <span style="margin-left: 5px; position: relative;display: flex;float:left" class="textstyle2">图书管理</span>
              </div>
                
              <div class="listyle" id="jump2" @click="$router.push('/userinfo')">
                <img src="../../resource/image/user2.png" alt="xxx"  class="imagestyle" >
                <span style="margin-left: 5px;float:right" class="textstyle2">用户管理</span>
                </div>

              <div class="listyle" id="jump3" @click="$router.push('/adminfo')">
                <img src="../../resource/image/set.png" alt="xxx" class="imagestyle">
                <span style="margin-left: 5px;float:right" class="textstyle2" >账号信息</span>
              </div>
          </div>
        </div>
        <div></div>
        
    </div>
</template>

<script>

export default {
  data() {
    return {
      showDropdown: false
    };
  },
  methods: {
    logout() {
      // 在这里执行退出登录的操作
      this.$router.replace('/admLogin')
    }
  }
};
</script>


<style scoped>
body {
  font-family: Arial, sans-serif;
  background-color: #f5f5f5 !important;
  margin: 0px !important;
  padding: 0px !important;
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
  margin: 0px;
  margin: 0px;
  height:auto;
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
background-color: #4CAF50;
color: #fff;
border: none;
border-radius: 4px;
cursor: pointer;
margin-right: 10px;
}

button:hover {
background-color: #95b097;
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


  .bigframe{
    position: absolute;
    left: 0px;
    width: 100%;
    min-height: 200px;
    height: auto;
  }
  .ulstyle{
    position: relative;
    display: block;
    width: 100%;
    height: 200px;
    background-color: #f5f5f5;
    border: 1px solid #f9fab6;
    padding-bottom: 30px;
    padding-top: 20px;
  }
  .listyle{
    display: inline-flex;
    align-items: center;
    min-height: 180px;
    position: relative;
    border:1px solid #f5f5f5;
    position: relative;
    width: 300px;
    margin-left:130px;
  }
  .listyle:hover{
    display: inline-flex;
    align-items: center;
    min-height: 180px;
    position: relative;
    border:1px solid #c6d57b;
    position: relative;
    width: 300px;
    margin-left:130px;
  }
  .imagestyle{
    position: relative;
    left: 35%;
    transform: translateX(-60%);
    width: 20%;
  }
  .textstyle2{
    position: relative;
    left: 40%;
    transform: translateX(-40%);
    font-size:large;
  }
  .divstyle{
    position: relative;
  float: left;
  width: 25%;
  height: 140px;
  box-sizing: border-box;
  background: #fff;
  cursor: pointer;
  }
</style>