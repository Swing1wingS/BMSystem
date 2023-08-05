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
        <div class="detailBox">
            
            <div style="margin: 20px;"></div>
                    <div class="detailBox2">
            <div style="width:100%;height: 50px;"></div>
            <div class="detailLine">
              <el-input  placeholder="用户名" prefix-icon="el-icon-s-custom" v-model="editForm.u_Name"></el-input>
            </div>
            <div class="detailLine">
                <el-input  placeholder="邮箱" prefix-icon="el-icon-message" v-model="editForm.u_Email"></el-input>
            </div>
            <div class="detailLine">
                <el-input  placeholder="联系方式" prefix-icon="el-icon-phone" v-model="editForm.u_Phone"></el-input>
            </div>
            <div class="detailLine" style="justify-content: left;">
                <div>性别：  </div>
                <el-switch  v-model="GenderValue" active-text="男" inactive-text="女" style="justify-content: left;"></el-switch>
            </div>
            <div class="detailLine">
                <el-input  placeholder="密码" prefix-icon="el-icon-lock" v-model="editForm.u_Password"  type="password"></el-input>
            </div>
            <div class="detailLine">
                <el-input  placeholder="确认密码" prefix-icon="el-icon-connection" v-model="Password2" type="password"></el-input>
            </div>
            <div class="detailLine">
                <el-button  plain style="background-color: #739bc3; color:#fcfcfc;height:60%;float:right" @click="edit()">修改信息</el-button>
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
       GenderValue:true,
       Password2:'',
      // 查询到的用户信息对象
      editForm: {
        u_Id: '',
        u_Name: '',
        u_Gender: '',
        u_Phone: '',
        u_Email: '',
        u_Password: ''
      }, 
        }
    },
    methods: {
      
      edit(){
    if(this.GenderValue== true){this.editForm.u_Gender="男";}
    else{this.editForm.u_Gender="女";}
        
        this.$confirm('确定要修改个人信息么', '提示', {
          confirmButtonText: '确定',
          cancelButtonText: '取消',
          type:"info"
        }).then(() => { 
      axios.patch('/api//modify_user',this.editForm).then(res=>{
      if(res.data.code==1){
        this.$message({
            type: 'success',
            message: '已成功修改'
          });   
      }
      else{
        this.$message({
            type: 'error',
            message: '修改失败'
          });   
      }
      
        }).catch(() => {
          this.$message({
            type: 'info',
            message: '已取消修改'
          });          
        });
       
    })
}
    },
    mounted() {
     
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
  
  .detailBox {
    width: 80%;
    margin-left: 80px;
    height: 550px;
    box-shadow: 0 12px 12px 12px rgba(0, 0, 0, 0.1);
    border-radius:  30px ;
    flex-direction: row;
  }
  .detailLine{
    font-size: 25px;
    color:#333;
    letter-spacing: 5px;
    margin-left: 10%;
    width:100%;
    height:65px;
    display: flex;
    align-content: center;
    justify-content: center;
    
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