<template>
    <body>
      <!--左侧导航栏-->
      <div class="sidenav">
        <div class="LogoBox">
          <img src="../../resource/logo.png" style="height: 35px;">
        </div>
        <div class="TextBox">
          <div>Library management system</div>
        </div>
        <div class='card-holder' style="margin-top: 70px;">
          <div class='card-wrapper'>
            <router-link to='/message'>
              <div class='card bg-01'>
                <span class='card-content'>图书基本信息 #1</span>
              </div>
            </router-link>
          </div>
          <div class='card-wrapper'>
            <router-link to="/return">
              <div class='card bg-02'>
                <span class='card-content'>归还图书 #2</span>
              </div>
            </router-link>
          </div>
          <div class='card-wrapper'>
            <router-link to='/record'>
              <div class='card bg-03'>
                <span class='card-content'>借阅管理 #3</span>
              </div>
            </router-link>
          </div>
          <div class='card-wrapper'>
            <router-link to="/info">
              <div class='card bg-04'>
                <span class='card-content'>用户中心 #4</span>
              </div>
            </router-link>
          </div>
          <div class='card-wrapper'>
            <router-link to="/alter">
              <div class='card bg-05'>
                <span class='card-content'>修改信息 #5</span>
              </div>
            </router-link>
          </div>
          <div class='card-wrapper'>
            <a href='#'>
              <div class='card bg-06'>
                <span class='card-content'>了解更多</span>
              </div>
            </a>
          </div>
        </div>
      </div>
      <!--主体部分-->
      <div class="main">
        <div class="el-header"></div>
        <el-divider style=" border-top: 1px dashed #e8eaec;"></el-divider>
        <br><br><br>
        <div class="buttonBox">
          <div class="selectButton" style="background-color: #556c75;">
            <div>个人信息</div>
            </div>
       
        </div>
        <div class="DetailBoxRow">
        <div class="detailBox1">
            
            <div style="margin: 20px;"></div>
                    <div class="detailBox2">
            <div style="width:100%;height: 50px;"></div>
            <div class="detailLine">
              <img src="../../resource/MineId.png">
                <div style="margin-top: 20px;margin-bottom: 20px; margin-left: 40px;">用户ID：{{ InfoData.u_Id }}</div>
            </div>
            <div class="detailLine">
              <img src="../../resource/MineName.png">
                <div style="margin-top: 20px;margin-bottom: 20px; margin-left: 40px;">用户名称：{{ InfoData.u_Name }}</div>
            </div>
            <div class="detailLine">
              <img src="../../resource/MineGender.png">
                <div style="margin-top: 20px;margin-bottom: 20px; margin-left: 40px;">性别：{{InfoData.u_Gender}}</div>
            </div>
            <div class="detailLine">
              <img src="../../resource/MineContact.png">
                <div style="margin-top: 20px;margin-bottom: 20px; margin-left: 40px;">联系方式：{{InfoData.u_Phone}} </div>
            </div>
            <div class="detailLine">
              <img src="../../resource/MineMail.png">
                <div style="margin-top: 20px;margin-bottom: 20px; margin-left: 40px;">邮箱地址：{{ InfoData.u_Email }} </div>
            </div>
            <br>
            <br>
            <div class="detailLine">
                <el-button  plain style="background-color: #39737e; color:#fcfcfc;height: 80%;margin: right 75px;" @click="JumpEdit()">修改信息</el-button>
            </div>
            </div>
        </div>
      </div>
    </div>
      <div>
      </div>
    </body>

    
  </template>
  <script>
  import axios from 'axios';

  export default {
  
    data() {
        return {
       InfoData:"",
      // 查询到的用户信息对象
      editForm: {}, 
        }
    },
    methods: {
      JumpEdit() {
      this.$router.replace("/alter");
 },
    },
    mounted() {
      axios.get('/api/user_info', {
            params: {
                u_id: localStorage.getItem("userId"),
            }
        }).then((result) => {
           this.InfoData=result.data.data
        })
    }
  };
  </script>
  <style scoped>
  .sidenav {
    height: 100%;
    width: 200px;
    position: fixed;
    z-index: 1;
    top: 0;
    left: 0;
    background-color: #556c75;
    overflow-x: hidden;
    padding-top: 20px;
  }
  
  .main {
    margin-left: 200px;
    /* 与 sidenav 的宽度相同 */
    height: 100%;
    width: 100%;
    position: fixed;
    background-color: #fff;
  }
  
  @media screen and (max-height: 450px) {
    .sidenav {
      padding-top: 15px;
    }
  
    .sidenav a {
      font-size: 18px;
    }
  }
  
  .el-header {
    background-color: #ffffff;
    color: #333;
    text-align: center;
    height: 70px;
    width: 100%;
  }
  
  a:link,
  a:hover,
  a:visited,
  a:active {
    color: #fff;
    text-decoration: none;
  }
  
  .card-holder {
    position: fixed;
    width: 0px;
    overflow: visible;
  }
  
  .card-wrapper {
    display: inline-block;
    clear: both;
  }
  
  .card {
    position: relative;
    left: 32px;
    padding: 16px 32px 16px 64px;
    margin: 16px;
    background: #fff;
    transition: all 0.3s ease-in-out 0.1s;
  }
  
  .card:hover {
    position: relative;
    left: 100%;
    margin-left: -32px;
    transition: all 0.3s ease-in-out;
  }
  
  .card-content {
    display: inline-block;
    color: #fff;
    font-family: 'Droid Sans', sans-serif;
    font-size: 16px;
    font-weight: bold;
    white-space: nowrap;
  }
  
  .bg-01 {
    background: #75a7c6;
  }
  
  .bg-02 {
    background: #81b9db;
  }
  
  .bg-03 {
    background: #90d1f2;
  }
  
  .bg-04 {
    background: #5c936c;
  }
  
  .bg-05 {
    background: #7ec994;
  }
  
  .bg-06 {
    background: #a6b05a;
  }
  
  .LogoBox {
    width: 100%;
    height: 70px;
    display: flex;
    flex-direction: column;
    justify-content: center;
    align-items: center;
  }
  
  .TextBox {
    width: 100%;
    height: 70px;
    display: flex;
    flex-direction: column;
    justify-content: center;
    text-align: center;
    font-size: 15px;
    color: #fff;
  }
  
  .buttonBox {
    width: 80%;
    margin-left: 80px;
    height: 50px;
    align-items: center;
    display: flex;
    justify-content: center;
  }
  .DetailBoxRow {
    width: 80%;
    margin-left: 80px;
    height: 550px;
    align-items: center;
    display: flex;
    justify-content: center;
  }
  .selectButton {
    width: 20%;
    height: 100%;
    border-radius: 20px 20px 0 0  ;
    text-align: center;
    color: white;
    letter-spacing: 5px;
    align-items: center;
    display: flex;
    justify-content: center;
    font-size: 20px;
  }
  
  .detailBox1{
    width: 64%;
    margin-left:18%;
    margin-right: 18%;
    height: 550px;
    border: 1px solid#000000;
    border-radius:  30px ;
    justify-content: center;
    align-content: center;
    background-color: #fff;
  }
  .detailLine{
    font-size: 25px;
    color:#333;
    letter-spacing: 5px;
    margin-left: 10%;
    width:100%;
    height:80px;
    display: flex;
    align-content: center;
    
}
.detailLine img{
  height:30px; 
  margin-top: 25px;
  margin-bottom: 25px;
}
.detailBox2{
    width:80%;
    height: 90%;
    flex-direction: row;
}
  
</style>