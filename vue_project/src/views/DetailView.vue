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
          <router-link to="/nfo">
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
  <div class="detailBox">
    <div class="container">
      <div class="imgBox1">
        <div class="imgBox2">
          <img src="../../resource/temp1.jpg" style="width:100%">
        </div>
        <div class="content">
             <h3 style="color:#fcfcfc">书籍详情</h3>
             <p>{{ CurrentDetail.b_Description }}</p>

        </div>
    </div>
  </div>
     
    <div class="divider"></div>
    <div class="detailBox2">
      <div style="width:100%;height: 50px;"></div>
      <div class="DetailLine">
         <div>书名：{{CurrentDetail.b_Name}}</div>
      </div>
      <div class="DetailLine">
         <div>作者：{{CurrentDetail.b_Author}}</div>
      </div>
      <div class="DetailLine">
         <div>编号：{{ CurrentDetail.b_Id }}</div>
      </div>
      <div class="DetailLine">
         <div>ISBN：{{CurrentDetail.b_Isbn}} </div>
      </div>
      <div class="DetailLine">
         <div>出版日期：{{ CurrentDetail.b_Pub_Year }} </div>
      </div>
      <div class="DetailLine">
         <div>总存量：{{CurrentDetail.b_Total_Collection}} ———— 现存量:{{ CurrentDetail.b_Cur_Collection }}</div>
      </div>
      <div class="DetailLine">
         <div>价格：{{ CurrentDetail.b_Price }} </div>
      </div>
      <div class="DetailLine">
        <el-button  plain style="background-color:rgb(88, 142, 152); color:#fcfcfc;height:100%" @click="Borrowing()" >确认借阅</el-button>
      </div>
      </div>
  
  </div>

</div>
    </body>
</template>
  <script>
import axios from "axios";
export default {

  data(){
return{
CurrentDetail:{
  
},
borrowDate:{
  u_id: "",
  b_id: "",
  time: ""

},

}
  },
async created(){
   axios.get('/api/books', {
            params: {
                key: "id",
                value: this.$route.query.id,
                page: 1,
                pageSize: 1, 
            }
        }).then((result) => {
            this.CurrentDetail=result.data.data.bookList[0];
            console.log(this.CurrentDetail);
 })
},
  methods:{
Borrowing(){
  this.borrowDate.b_id=this.CurrentDetail.b_Id;
  this.borrowDate.time=new Date();
  this.borrowDate.u_id=localStorage.getItem("userId")
  this.$confirm('从'+this.borrowDate.time.getFullYear()+"年"+(this.borrowDate.time.getMonth()+1)+"月"+this.borrowDate.time.getDate()+"日,"+"开始借阅，七天后归还", '确认借阅该图书么', {
          confirmButtonText: '确定',
          cancelButtonText: '取消',
          type:"info"
        }).then(() => {
   axios.post('/api/borrow',this.borrowDate).then(response =>{
        if(response.data.msg=="success"){
          axios.get('/api/books', {
            params: {
                key: "id",
                value: this.$route.query.id,
                page: 1,
                pageSize: 1, 
            }
        }).then((result) => {
            this.CurrentDetail=result.data.data.bookList[0];
            console.log(this.CurrentDetail);
 })
        return this.$message({
          type:"success",
          message: "借阅成功",
        })
    }
    else{ 
        return this.$message({ 
          type: "error",
          message: "借阅失败",
        });
    }
        })
                 
        });
      },
  },
mounted(){

},
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
  padding: 0px 10px;
  height:100%;
  width:100%;
  position:fixed;
  overflow-y: scroll;
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
.detailBox{
  width:80% ;
  margin-left: 80px;
  height: 500px;
  align-items: center;
  display: flex;
  border: 1px solid#000000;
  border-radius: 10px;
}
.container{
  width: 45%;
  display: flex;
  flex-wrap: wrap;
  justify-content: center;
}
.imgBox1{
  position: relative;
  width:300px;
  height: 400px;
  background: #000000;
  box-shadow: 0 30px 30px rgba(0,0,0,.5);

}
.imgBox1 .imgBox2{
  position:absolute;
  top:0;
  left: 0;
  width:100%;
  height:100%;
}
.imgBox1 .imgBox2 img{
  position: absolute;
  top: 0;
  left: 0;
  width:100%;
  height:100%;
  object-fit: cover;
  transition: 0.5s;
}
.imgBox1:hover .imgBox2 img{
 opacity: 0;
}
.content{
  position:absolute;
  bottom: 20px;
  left: 10%;
  width: 80%;
  height: 60px;
  background-color: #556c75;
  color:#ffffff;

  transition:0.5s;
  overflow: hidden;
  padding:15px;
  box-sizing:border-box;
}
.imgBox1:hover .content{
  height:100%;
  width:100%;
  bottom:0;
  left: 0;
}
.imgBox1 .content h3{
  margin: 0;
  padding:0;
  font-size: 20px;
  color:#ffffff;
}
.imgBox1 .content p{
  margin: 10px 0 0;
  padding:0;
  opacity: 0;
  line-height: 1.2em;
  transition:0.5s;
  font-size: 20px;
  text-align: justify;
  color:#ffffff;
}
.imgBox1:hover .content p{
 opacity: 1;
 transition-delay: 0.5s;
}


.detailBox2{
    width:50%;
    height: 100%;
    flex-direction: row;
}
.DetailLine{
  font-size: 22px;
    color:#333;
    letter-spacing: 5px;
    margin-left: 10%;
    width:100%;
    height:55px;
}
.divider{
  background-color: #000000;
  width:1px;
  height:85%
}
.section{
  display: flex;
  justify-content: center;
  align-content: center;
  flex-wrap: wrap;
  transform-style: preserve-3d;
}
  </style>