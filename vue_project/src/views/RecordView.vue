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
        <div class="selectButton" style="background-color: #556c75;">借阅中</div>
      </div>
      <div class="detailBox">
        <el-table :data="RecordData" style="width: 80% height:90%" >
          <el-table-column fixed prop="b_Id" label="图书编号" width="150">
          </el-table-column>
          <el-table-column prop="b_Name" label="图书名称" width="120">
          </el-table-column>
          <el-table-column prop="b_Author" label="作者" width="120">
          </el-table-column>
          <el-table-column prop="b_Press" label="出版社" width="120">
          </el-table-column>
          <el-table-column prop="b_Pub_Year" label="发布时间" width="120">
          </el-table-column>
          <el-table-column prop="b_Price" label="价格" width="120">
          </el-table-column>
          <el-table-column prop="br_Borrow_Date" label="借阅时间" width="300">
          </el-table-column>
          <el-table-column prop="br_Expect_Return_Date" label="归还时间" width="300">
          </el-table-column>
          <el-table-column fixed="right" label="操作" width="120">
            <template slot-scope="scope">
              <el-button @click.native.prevent="ContinueBorrow(scope.$index)" type="text" size="middle">
                续借
              </el-button>
            </template>
          </el-table-column>
        </el-table>

      </div>
    </div>

  </body>
</template>
<script>
import axios from 'axios';
export default {

  data() {
    return {
      input: '',
      RecordData:'',
      C_BorrowD:{
        u_id: "",
        b_id: "",
        time: ""

      },
    }
  },
async created(){
 axios.get('/api/borrow_records', {
            params: {
                u_id: localStorage.getItem("userId"),
                page: 1,
                pageSize: 9999, 
            }
        }).then((result) => {
             console.log(result);
             this.RecordData=result.data.data.bookBorrowRecordList;
             for(var i=0;i<this.RecordData.length;i++){
              if(this.RecordData[i].br_Return_Date!=null){
                this.RecordData.splice(i, 1);
                console.log(i);
              }
             }
             console.log(this.RecordData.length);
        });
},
  methods: {
ContinueBorrow(index){
  this.C_BorrowD.b_id=this.RecordData[index].b_Id;
  this.C_BorrowD.time=new Date();
  this.C_BorrowD.u_id=localStorage.getItem("userId")
  this.$confirm('从'+this.C_BorrowD.time.getFullYear()+"年"+(this.C_BorrowD.time.getMonth()+1)+"月"+this.C_BorrowD.time.getDate()+"日,"+"开始续借，七天后归还", '确认续借该图书么', {
          confirmButtonText: '确定',
          cancelButtonText: '取消',
          type:"info"
        }).then(() => {
   axios.post('/api/renew',this.C_BorrowD).then(response =>{
        console.log(response);
        if(response.data.msg=="success"){
        return this.$message({
          type:"success",
          message: "续借成功",
        })
    }
    else{ 
        return this.$message({ 
          type: "error",
          message: response.data.msg,
        });
    }
        })
                 
        });
},

  },
  mounted() {
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
  border-radius: 20px 0 0 0;
  text-align: center;
  color: white;
  letter-spacing: 5px;
}

.detailBox {
  width: 80%;
  margin-left: 80px;
  height: 550px;
  align-items: center;
  display: flex;
  border: 1px solid#000000;
  border-radius: 0 0 10px 10px;
}

.imgBox {
  width: 40%;
  height: 100%;
  justify-content: center;
  align-items: center;
  display: flex;
}

.imgBox img {
  height: 75%;

}

.testBox {
  width: 30%;
  background: color;
  height: 400px;
  flex-direction: row;
}

.detailBox2 {
  width: 50%;
  height: 100%;
  flex-direction: row;
}

.detailLine {
  font-size: 27px;
  color: #333;
  letter-spacing: 5px;
  margin-left: 10%;
  width: 100%;
  height: 80px;
}
</style>