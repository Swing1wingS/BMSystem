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
          <router-link to="alter">
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
  <br>
  <el-input v-model="input" placeholder="请输入内容" style="width: 50%; margin-left: 70px;"></el-input>
  <el-button type="primary" plain style="margin-left: 70px; background-color: rgb(255, 255, 255); border-color: 2px solid #577797; color:#577797" @click="Find_Record()">搜索</el-button>
<br><br><br>
<div class="ReturnBox">
    <div class="imgBox">
      <img  style="height: 75%; border-radius: 15px;" src="../../resource/temp2.jpg">
    </div>
    <div class="divider"></div>
    <div class="2">
      <div style="width:100%;height: 50px;"></div>
      <div class="detailLine">
         <div>书名：{{ CurrentData.b_Name }}</div>
      </div>
      <div class="detailLine">
         <div>作者：{{ CurrentData.b_Author }}</div>
      </div>
      <div class="detailLine">
         <div>编号：{{CurrentData.b_Id}}</div>
      </div>
      <div class="detailLine">
         <div>借阅时间：{{ CurrentData.br_Borrow_Date }}</div>
      </div>
      <div class="detailLine">
         <div>到期时间：{{ CurrentData.br_Expect_Return_Date }} </div>
      </div>
      <div class="detailLine">
        <el-button  plain style="background-color: #739bc3; color:#fcfcfc;height:60%"  @click="Return_Book()">确认归还</el-button>
      </div>
      </div>
  
  </div>

</div>




    </body>
</template>
  <script>
  import axios from 'axios';
export default {

  data(){
    return{
       input: '',
       RecordData:'',
       CurrentData:{},
       ReturnData:{
        u_id: "",
        b_id: "",
        time: ""
       }
  }
    },
   
  methods:{
  Find_Record(){
    axios.get('/api/borrow_records', {
            params: {
                u_id: localStorage.getItem("userId"),
                page: 1,
                pageSize: 9999, 
            }
        }).then((result) => {
             console.log(result);
             this.RecordData=result.data.data.bookBorrowRecordList;
             var i=0;
             for(i =0;i<this.RecordData.length;i++){
              if(this.RecordData[i].b_Id){this.CurrentData=this.RecordData[i];break;}
             }
             if(i==this.RecordData.length){
              return this.$message({ 
              type: "error",
              message: "无此相关查询项",
        });
             }
            
        });
  },
  Return_Book(){
  if(this.CurrentData==null){
    return this.$message({ 
          type:"warning",
          message: "请先根据书籍编号查询借阅记录",
        });
  }
  this.ReturnData.u_id=localStorage.getItem("userId");
  this.ReturnData.b_id=this.CurrentData.b_Id;
  this.ReturnData.time=new Date();
  this.$confirm("图书编号:"+this.CurrentData.b_Id, '确认归还该图书么', {
          confirmButtonText: '确定',
          cancelButtonText: '取消',
          type:"info"
        }).then(() => {
   axios.post('/api/return',this.ReturnData).then(response =>{
        if(response.data.msg=="success"){
          return this.$message({ 
          type:"success",
          message: "还书成功",
        });
    }
    else{ 
        return this.$message({ 
          type: "error",
          message: "还书失败",
        });
    }
        })
                 
        });
}

},
  mounted(){
    //发送异步请求，获取数据
    axios.get("")
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
  margin-left: 200px; /* 与 sidenav 的宽度相同 */
  height:100%;
  width:100%;
  position:fixed;
  background-color: #fff;
}
@media screen and (max-height: 450px) {
  .sidenav {padding-top: 15px;}
  .sidenav a {font-size: 18px;}
}
.el-header{
    background-color: #ffffff;
    color: #333;
    text-align: center;
    height: 70px;
    width:100%;
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
.bg-01 { background: #75a7c6 ; }
.bg-02 { background: #81b9db; }
.bg-03 { background: #90d1f2; }
.bg-04 { background: #5c936c; }
.bg-05 { background: #7ec994; }
.bg-06 { background: #a6b05a; }

.LogoBox{
  width:100%;
  height:70px;
  display: flex;
  flex-direction: column;
  justify-content: center;
  align-items: center;
}
.TextBox{
  width:100%;
  height:70px;
  display: flex;
  flex-direction: column;
  justify-content: center;
  text-align: center;
  font-size: 15px;
  color:#fff;
}
.ReturnBox{
  width:80% ;
 
  margin-left: 80px;
  height: 550px;
  align-items: center;
  display: flex;
  border: 1px solid#000000;
  border-radius: 10px;
}
.imgBox{
    width:40%;
    height: 100%;
    justify-content: center;
    align-items: center;
    display: flex;  
}
.imgBox img{
    height: 75%;
    
}
.testBox{
    width:30%;
    background: color;
    height:400px;
    flex-direction: row;
}
.ReturnBox2{
    width:50%;
    height: 100%;
    flex-direction: row;
}
.detailLine{
  font-size: 27px;
    color:#333;
    letter-spacing: 5px;
    margin-left: 10%;
    width:100%;
    height:80px;
}
.divider{
  background-color: #000000;
  width:1px;
  height:85%
}


  </style>