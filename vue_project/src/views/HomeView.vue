<template>
<body>
    <div>
        <div class="topnav" id="myTopnav">
            <img src="../../resource/logo.png" style="height: 30px;margin-top: 20px;margin-bottom: 20px;margin-left: 10px;">
            <a style="font-size: 20px;margin-top: 15px ; margin-bottom:30px;margin-left:7px;color:10px; color:white; font-family: Arial, Helvetica, sans-serif;">Library management system</a>
        </div>
        <div style="height: 20px;width: 100%; background-color: #64808c;">
            <img src="../../resource/arrow.png" style="width:10px;float:right;margin-right: 5px;margin-top: 5px;">
            <router-link to="/admLogin">
              <a style="font-size: 14px;float:right;color:white;margin-right: 5px;">管理员登录</a>
            </router-link>
            
        </div>
    </div>
    <div class="Stitle" style="font-size: 80px;font-family:Microsoft YaHei; margin-top: 70px;">图&nbsp;&nbsp;书&nbsp;&nbsp;管&nbsp;&nbsp;理&nbsp;&nbsp;系&nbsp;&nbsp;统</div>
    <div class="Stitle" style="font-size: 20px;font-family:Microsoft YaHei;margin-top: 30px;">L&nbsp;i&nbsp;b&nbsp;r&nbsp;a&nbsp;r&nbsp;y&nbsp;&nbsp;m&nbsp;a&nbsp;n&nbsp;a&nbsp;g&nbsp;e&nbsp;m&nbsp;e&nbsp;n&nbsp;t&nbsp;&nbsp;s&nbsp;y&nbsp;s&nbsp;t&nbsp;e&nbsp;m</div>
   
    <div class="LoginBox" style="margin-top: 50px;">
    <div class="MenuBox">
      <div class="SlideBox">
        <!--注册-->
           <div class="register-box">
                 <h1>register</h1>
                 <input type="text" placeholder="用户名" v-model="registerInfo.name">
                 <el-switch v-model="Rgender" active-text="男" inactive-text="女"></el-switch>
                 <input type="email" placeholder="邮箱" v-model="registerInfo.email" >
                 <input type="phone" placeholder="联系方式" v-model="registerInfo.phone" >
                 <input type="password" placeholder="密码" v-model="registerInfo.password">
                 <input type="password" placeholder="确认密码" v-model="password2">
                 <button @click="OnRegister()">注册</button>
           </div>
           <!-- 登录 -->
           <div class="login-box  hidden">
                <h1>Login</h1>
                <input type="text" placeholder="请输入用户名" v-model="loginInfo.name" >
                <input type="password" placeholder="请输入密码" v-model="loginInfo.password">
                <button @click="Onsubmit()">登录</button>
           </div>
      </div>
      <div class="con-box left"> 
        <h2>欢迎使用<span>图书管理系统</span></h2>
        <img src="../../resource/main_book .png">
        <p>已有账号</p>
        <button id="login" @click="GoLogin">去登陆</button>
      </div>
      <div class="con-box right" > 
        <h2>&nbsp;&nbsp;&nbsp;&nbsp;没有账户？<span>快来注册一个吧！</span></h2>
        <img src="../../resource/main_register.png">
        <p>没有账号？</p>
        <button id="register" @click="GoRegister">去注册</button>
      </div>
   </div>
</div>
  
</body>

</template>
  
<script>
import axios from 'axios'
export default{
    data() {
        return {
        Rgender : true,
        password2:'',
       registerInfo:{
        name:'',
        gender: '',
        phone: '',
        email: '',
        password: '',

       },
       loginInfo:{
        type:0,
        name:'',
        password:'',
       },
       responseDate:{

        
       },
       loginRules: {
        account: [{ required: true, message: "请输入账号", trigger: "blur" }],
        passWord: [{ required: true, message: "请输入密码", trigger: "blur" }],
      },
      registerRules: {
        username: [{ required: true, message: "用户名", trigger: "blur" }],
        email: [{ required: true, message: "邮箱", trigger: "blur" }],
        phone: [{ required: true, message: "联系方式", trigger: "blur" }],
        password: [{ required: true, message: "密码", trigger: "blur" }],
        password2: [{ required: true, message: "密码", trigger: "blur" }],
      },
        }
    },
    methods:{
    GoRegister:function(){
    let slideBox=document.getElementsByClassName('SlideBox')[0];
    let register_box=document.getElementsByClassName('register-box')[0];
    let login_box=document.getElementsByClassName('login-box')[0];
    slideBox.style.transform="translateX(80%)";
    login_box.classList.add('hidden');
    register_box.classList.remove('hidden');
},
  GoLogin:function(){
    let slideBox=document.getElementsByClassName('SlideBox')[0];
    let register_box=document.getElementsByClassName('register-box')[0];
    let login_box=document.getElementsByClassName('login-box')[0];
    slideBox.style.transform="translateX(0%)";
    register_box.classList.add('hidden');
    login_box.classList.remove('hidden');
},
Register(){
},
mounted() {
        
},
Onsubmit(){
    const userAccount = this.loginInfo.name;
    const userPassword = this.loginInfo.password;
    if (!userAccount) {
        return this.$message({
          type: "error",
          message: "账号不能为空！",
        });
      }
      if (!userPassword) {
        return this.$message({
          type: "error",
          message: "密码不能为空！",
        });
    }
        axios.post('/api/login',this.loginInfo).then(response =>{
        if(response.data.msg=="success"){
        localStorage.setItem("username",this.loginInfo.name);
        localStorage.setItem("userId",response.data.data.id)
        this.$router.replace('/message')
    }
    else{
        return this.$message({
          type: "error",
          message: "用户名或密码错误",
        });
    }
        })
    
        },
OnRegister(){
    if(this.Rgender== true){this.registerInfo.gender="男";}
    else{this.registerInfo.gender="女";}
    const userName = this.registerInfo.name;
    const userEmail = this.registerInfo.email;
    const userPhone = this.registerInfo.phone;
    const userPassword = this.registerInfo.password;
    if (!userName) {
        return this.$message({
          type: "error",
          message: "用户名不能为空！",
        });
      }
      if (!userEmail) {
        return this.$message({
          type: "error",
          message: "邮箱不能为空！",
        })
    }
        if (!userPhone) {
        return this.$message({
          type: "error",
          message: "联系方式不能为空！",
        })
      }
      if (!userPassword) {
        return this.$message({
          type: "error",
          message: "密码不能为空！",
        })
      }
      if (this.registerInfo.password!=this.password2) {
        return this.$message({
          type: "error",
          message: "密码输入不相同！",
        })
      }
   
 axios.post('/api/enroll',this.registerInfo).then(response =>{
        if(response.data.msg=="success"){
        return this.$message({
          type:"success",
          message: "注册成功",
        })
    }
    else{ 
        return this.$message({ 
          type: "error",
          message: "注册失败",
        });
    }
        })
    
}
}}


</script>
  
<style scoped>

body{
    background: url("../../resource/background.jpg");
    background-size: cover;
    background-attachment:fixed;      
    background-color:#f6f6f6;  
    opacity: 0.9;
    margin: 0;

}
.con-box{
    width:50%;
    display: flex;
    flex-direction: column;
    justify-content: center;
    align-items: center;
    position: absolute;
    top:50%;
    transform: translateY(-50%);
}
.con-box.left{
    left:-2%;
}
.con-box.right{
    right:2%;
}
.con-box h2{
    color:#3a4b52;
    font-size: 25px;
    font-weight: bold;
    letter-spacing: 3px;
    text-align: center;
    margin-bottom: 4px;
}
.con-box p{
    font-size: 12px;
    letter-spacing: 2px;
    color:#556c75;
    text-align: center;
}
.con-box span{
    color:#acc0c9;
}
.con-box img{
    width:150px;
    opacity: 0.9;
    margin:40px  0;
}

.con-box button{
    margin-top: 3%;
    background-color: #f6f6f6;
    color:#3a4b52;
    border:1px solid #64808c;
    padding:6px 10px;
    border-radius: 5px;
    letter-spacing: 1px;
    outline:none;
    cursor:pointer;
}
.con-box button:hover{
    background-color: #3a4b52;
    color: #ffffff;
}
.MenuBox{
    background-color: #ffffff;
    width:650px;
    height:415px;
    border-radius: 5px;
    box-shadow: 5px 5px 5px rgba(0,0,0,0.1);
    position: relative;
}
/*滑动box*/
.SlideBox{
    position:absolute;
    top:-10%;
    left:5%;
    background-color:#64808c;
    width: 320px;
    height:500px;
    border-radius: 5px;
    box-shadow: 2px 0 10px rgba(0,0,0,0.1);
    display: flex;
    justify-content: center;
    align-items: center;
    z-index: 2;
    transform: translateX(80%);
    /*动画过渡 加速后减速*/
    transition: 0.5s ease-in-out;
}
/*设置按钮样式*/
.SlideBox button{
    width:70%;
    margin-top:35px;
    background-color:#f6f6f6 ;
    outline:none;
    border-radius: 8px;
    padding:13px;
    color:#64808c;
    letter-spacing: 2px;
    border:noen;
    cursor:pointer;
}
.SlideBox button:hover{
    background-color: #3a4b52;
    color:#ffffff;
    transition: background-color 0.5 ease;
}
.register-box,.login-box{
    /*弹性布局 垂直排列*/
    display:flex;
    flex-direction: column;
    align-items: center;
    width: 100%;
}
.hidden{
    display: none;
    transition: 0.5s;
}
h1{
    text-align: center;
    margin-bottom: 25px;
    text-transform: uppercase;/*大写*/
    letter-spacing: 5px;
    color:#232323;
}
input{
    background-color:transparent;
    width:70%;
    color:white;
    border:none;
    /*下边框*/
    border-bottom:  1px solid rgba(255,255,255,0.4);
    padding:10px 0;
    text-indent: 10px;
    margin: 8px 0;
    font-size: 14px;
    letter-spacing:2px;
}
input::placeholder{
    color:#e6e6e6;
}
/*选中状态*/

/*当选中输入，将place设置为不可见*/
input:focus::placeholder{
    opacity: 1;
}
#login{
    margin-top: 3%;
    background-color: #f6f6f6;
    color:#3a4b52;
    border:1px solid #64808c;
    padding:6px 10px;
    border-radius: 5px;
    letter-spacing: 1px;
    outline:none;
    cursor:pointer;
} 
#register{
    margin-top: 3%;
    background-color: #f6f6f6;
    color:#3a4b52;
    border:1px solid #64808c;
    padding:6px 10px;
    border-radius: 5px;
    letter-spacing: 1px;
    outline:none;
    cursor:pointer;
} 

.topnav a {
  float: left;
  display: block;
  color: #f2f2f2;
  text-align: center;
  padding: 14px 16px;
  text-decoration: none;
  font-size: 17px;
}
.topnav {
  overflow: hidden;
  background-color: #64808c;
  height:60px;
  display: flex;
}
.LoginBox{
    width: 100%;
    margin:auto;
    display: flex; 
	align-items: center;
	justify-content: center;
}
.LoginButton{
    height:50px;
    width:200px;
    background-color: #7da0af8b;
    color:white;
    justify-content: center;
    border-color: #a7a7a7;
}
.Stitle{
    width: 100%;
    color: #ffffff;
    text-align: center;
}
@media screen and (max-width: 600px) {
  .topnav a:not(:first-child) {display: none;}
  .topnav a.icon {
    float: right;
    display: block;
  }
}


  </style>
  