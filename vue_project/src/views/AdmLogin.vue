<template>
  <body style="{backgroundImage:'url('+require('../../resource/image/background.jpg')+')'}">
    <div class="container" >
      <div class="wrap">
        <div class="logo">
          <img src="../../resource/image/libirary.png" alt="厦门大学logo">
        </div>
  
        <div class="form">
          <h1>图书馆管理员登录系统</h1>
          <div >
            <form class="xxx">
  
              <div class="inputbox">
                <span class="inputplace">
                  <img alt="user" src="../../resource/image/user.png" class="icon"> 
                  <input v-model="username" type="text" placeholder="用户名" id="username">
                </span>
              </div>
              <div class="inputbox">
                <span class="inputplace">  
                  <img alt="password" src="../../resource/image/password.png" class="icon">               
                  <input v-model="password" type="password" placeholder="密码" id="password">                   
                </span>
              </div>
              <button type="button" @click="login">登录</button>
            </form>
            <div class="">
              <router-link to="/home">
              <a  style="position: absolute;left: 10%;color: #ffffff;">以用户登录</a>
            </router-link>
              <router-link to="">
                <p  style="position:absolute;right: 10%; color:#ffffff"> 忘记密码</p>
              </router-link>
              
            </div>
          </div>
          
        </div>
      </div>
    </div>
  </body>
  </template>
  
  
  <script>
/*import router from '@/router';*/

  export default {
    data() {
        return {
            username: "",
            password: "",
        };
    },
    methods: {
        login() {
            const requestData = {
                type: 1,
                name: this.username,
                password: this.password,
            };
            var vm = this;
            fetch("/api/login", {
                method: "POST",
                headers: {
                    "Content-Type": "application/json",
                },
                body: JSON.stringify(requestData),
            })
                .then((response) => response.json())
                .then((data) => {
                if (data.code === 1) {
                    localStorage.setItem("Adm_id",data.data.id);
                    vm.$router.replace('/AdmHome');
                }
                else {
                    // Login failed
                    alert("用户名或密码错误，Login failed. ");
                }
            })
                .catch((error) => {
                // Handle any error that occurred during the request
                console.error("Error occurred during login:", error);
                alert("An error occurred during login. Please try again later.");
            });
        },
    },
    /*components: { router }*/
};
  </script>
  
  
  

<style scoped>
       * {
            margin: 0;
            padding: 0;
            box-sizing: border-box;
        }

        body {
            zoom: 1.0; /* 禁止页面缩放 */
            background-image:url("../../resource/image//background.jpg") !important;
            background-size: cover;
            background-repeat: no-repeat;
            font-family: Arial, sans-serif;
        }

        .container {
          background-image:url("../../resource/image//background.jpg") !important;
            width: 100%;
            height: 100%;
            position: absolute;
            margin: 0 auto;  
        }

      .wrap {
            background: rgb(0, 0, 0,0.5);
            box-shadow: none;
            zoom:1;
            padding: 0 20px 10px;
            width: 28%;
            position:fixed;
            top: 50%;
            left: 50%;
            transform: translate(-50%,-50%);
            min-height: 460px;
            max-height: 460px;
            border-radius: 10px;
        }
        
      

        .logo {
            text-align: center;
            margin-top: 20px;
            margin-bottom: 10px;
        }

        .logo img {
            width: 50px;
            height: auto;
            color: white;
        }

        .form {
            background-color: rgb(0,0,0,0);
            border-radius: 10px;
            padding: 10px;
            padding-bottom: 20px;
        }

        .form h1 {
            text-align: center;
            color: #ffffff;
            font-size: 20px;
            margin-bottom: 10px;
        }

        .form p {
            text-align: center;
            color: #999999;
            font-size: 14px;
            margin-bottom: 20px;
        }

        .form input {
            display: block;
            width: 80%;
            margin: 0 auto;
            border: none;
            border-bottom: 1px solid #cccccc;
            padding: 15px;
            margin: 20px;
            font-size: 16px;
        }

        .form input:focus {
            outline: none;
            border-bottom-color: #0099ff;
        }

        .form button {
            display: block;
            width: 85%;
            margin: 60px auto;
            border: none;
            border-radius: 5px;
            background-color: #226ea1;
            color: white;
            padding: 10px;
            font-size: 18px;
        }

        .form button:hover {
            cursor: pointer;
        }
        .inputbox {
            background-color: #ffffff;
            margin: 20px;
            border-radius: 5px;
        }

        .inputplace{
            line-height: 1
        }
        .inputplace img {
            display: inline; /* 图片以行内元素方式显示 */
            vertical-align: middle; /* 用于垂直居中图片和文字 */
            width: 10%;
            height: auto;
            margin-left: 5%;
            opacity:0.4;
        }
        .inputplace input{
            display: inline; /* 段落以行内元素方式显示 */
             margin: 0; /* 可以去除默认的段落外边距 */
             vertical-align: middle; /* 用于垂直居中图片和文字 */
        }
  </style>


