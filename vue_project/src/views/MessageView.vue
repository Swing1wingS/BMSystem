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
      <div class="SearchBox" style="margin-left: 100px; height: 40px;">
        <select name="搜索方式" id="selectWay" class="selectWays">
          <option value="0">全部</option>
          <option value="1">编号</option>
          <option value="2">书名</option>
          <option value="3">作者</option>
          <option value="4">出版商</option>
          <option value="5">ISBN</option>
        </select>
        <el-input v-model="input" placeholder="请输入内容" style="width:50%"></el-input>
        <el-button type="primary" plain
          style="margin-left: 70px; background-color: rgb(255, 255, 255); border-color: 2px solid #577797; color:#577797;height:40px"
          @click="Search()">搜索</el-button>


      </div>
      <br><br><br>

      <div class="BoxRow">
        <div v-for="(items, index) of this.rowList.first " :key="currentDate[index].b_Id" :span="3" class="box1"
          @click="toDetail(index)">
          <div class="box">
            <img :src="imgPathList[index]">
            <el-divider></el-divider>
            <div style="color:black;font-size: 20px;">《{{ currentDate[index].b_Name }}》</div>
          </div>
          <div class="mask">
            <div style="font-size: 20px; color:aliceblue">现有存量：{{ currentDate[index].b_Cur_Collection }}</div>
          </div>
        </div>
      </div>

      <br>

      <div class="BoxRow" v-if="this.rowList.second > 0">
        <div v-for="(items, index) of this.rowList.second " :key="currentDate[index + 3].b_Id" :span="3" class="box1"
          @click="toDetail(index + 3)">
          <div class="box">
            <img :src="imgPathList[index + 3]">
            <el-divider></el-divider>
            <div style="color:black;font-size: 20px;">《{{ currentDate[index + 3].b_Name }}》</div>
          </div>
          <div class="mask">
            <div style="font-size: 20px; color:aliceblue">现有存量：{{ currentDate[index + 3].b_Cur_Collection }}</div>
          </div>
        </div>
      </div>
      <br>

      <div class="BoxRow" v-if="this.rowList.third > 0">
        <div v-for="(items, index) of this.rowList.third " :key="currentDate[index + 6].b_Id" :span="3" class="box1"
          @click="toDetail(index + 6)">
          <div class="box">
            <img :src="imgPathList[index + 6]">
            <el-divider></el-divider>
            <div style="color:black;font-size: 20px;">《{{ currentDate[index + 6].b_Name }}》</div>
          </div>
          <div class="mask">
            <div style="font-size: 20px; color:aliceblue">现有存量：{{ currentDate[index + 6].b_Cur_Collection }}</div>
          </div>
        </div>
      </div>
      <br><br>
      <el-pagination background layout="prev, pager, next" :total=this.pageNum
        @current-change="handleCurrentChange"></el-pagination>
    </div>
  </body>
</template>
<script>
import axios from 'axios';
import MessageDate from '@/Test_data/Message';
export default {

  data() {
    return {
      MessageDate,
      currentDate: [],
      imgPath: 'https://web-bmsystem.oss-cn-hangzhou.aliyuncs.com/books/',
      imgPathList: [],
      input: '',
      search_way: '',
      pageNum: 1,  // 共几页=所有数据/每页现实数量
      currentPage: 1,// 默认当前显示第一页
      InquireData: {
        key: 'all',
        value: '123',
        page: 1,
        pageSize: 9,
      },
      rowList: {
        first: 0,
        second: 0,
        third: 0,
      },
    }
  },
  async created() {
    axios.get('/api/books', {
      params: {
        key: this.InquireData.key,
        value: this.InquireData.value,
        page: this.InquireData.page,
        pageSize: this.InquireData.pageSize,
      }
    }).then((result) => {
      console.log(result);
      this.currentDate = result.data.data.bookList;
      this.pageNum = result.data.data.amount;
      this.imgPathList = [];
      for (var i = 0; i < this.currentDate.length; i++)
        this.imgPathList.push(this.imgPath + this.currentDate[i].b_Id + '.png');

      if (this.currentDate.length <= 3) {
        this.rowList.first = this.currentDate.length;
        this.rowList.second = this.rowList.third = 0;
      }
      else if (this.currentDate.length <= 6) {
        this.rowList.first = 3;
        this.rowList.second = this.currentDate.length - 3;
        this.rowList.third = 0;
      }
      else {
        this.rowList.first = 3;
        this.rowList.second = 3;
        this.rowList.third = this.currentDate.length - 6;
      }
    })
  },
  methods: {
    toDetail(index) {
      var path = '/detail?id=' + this.currentDate[index].b_Id;
      this.$router.replace(path);
    },
    handleCurrentChange(val) {

      console.log(`当前页: ${val}`);
      this.InquireData.page = val;

      axios.get('/api/books', {
        params: {
          key: this.InquireData.key,
          value: this.InquireData.value,
          page: this.InquireData.page,
          pageSize: this.InquireData.pageSize,
        }
      }).then((result) => {
        console.log(result);
        this.currentDate = result.data.data.bookList;
        this.pageNum = result.data.data.amount;
        this.imgPathList = [];
        for (var i = 0; i < this.currentDate.length; i++)
          this.imgPathList.push(this.imgPath + this.currentDate[i].b_Id + '.png');

        if (this.currentDate.length <= 3) {
          this.rowList.first = this.currentDate.length;
          this.rowList.second = this.rowList.third = 0;
        }
        else if (this.currentDate.length <= 6) {
          this.rowList.first = 3;
          this.rowList.second = this.currentDate.length - 3;
          this.rowList.third = 0;
        }
        else {
          this.rowList.first = 3;
          this.rowList.second = 3;
          this.rowList.third = this.currentDate.length - 6;
        }
      });
    },
    GetSearchway() {
      var value = document.getElementById("selectWay").value;
      if (value == "0") this.search_way = 'all';
      else if (value == "1") this.search_way = 'id';
      else if (value == "2") this.search_way = 'name';
      else if (value == "3") this.search_way = 'author';
      else if (value == "4") this.search_way = 'press';
      else if (value == "5") this.search_way = 'ISBN';
    },
    Search() {
      this.GetSearchway();
      var search_content = this.input;
      axios.get('/api/books', {
        params: {
          key: this.search_way,
          value: search_content.toString(),
          page: this.InquireData.page,
          pageSize: this.InquireData.pageSize,
        }
      }).then((result) => {
        if (result.data.code == 0) {
          return this.$message({
            type: "error",
            message: "无此相关查询项",
          });
        }
        this.currentDate = result.data.data.bookList;
        this.pageNum = result.data.data.amount;
        this.imgPathList = [];
        for (var i = 0; i < this.currentDate.length; i++)
          this.imgPathList.push(this.imgPath + this.currentDate[i].b_Id + '.png');

        if (this.currentDate.length <= 3) {
          this.rowList.first = this.currentDate.length;
          this.rowList.second = this.rowList.third = 0;
        }
        else if (this.currentDate.length <= 6) {
          this.rowList.first = 3;
          this.rowList.second = this.currentDate.length - 3;
          this.rowList.third = 0;
        }
        else {
          this.rowList.first = 3;
          this.rowList.second = 3;
          this.rowList.third = this.currentDate.length - 6;
        }
      })
    }

  },
  mounted() {
    //发送异步请求，获取数据

  }
};
</script>
<style>
.TestBox {
  background-color: #000;
  height: 200px;
  width: 25%;
}

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
  padding: 0px 10px;
  height: 100%;
  width: 100%;
  position: fixed;
  overflow-y: scroll;
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
  float: right;
  clear: both;
}

.card {
  position: relative;
  /* left: 32px; */
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

#itemBox ul {
  display: flex;
  flex-wrap: wrap;
}

#itemBox li {
  padding: 3px;
  list-style: none;
  margin-right: 15px;
  border: 1px solid #eee;
}

#itemBox img {
  width: 200px;
  height: 150px;
}

.SearchBox {
  width: 80%;
  height: 50px;
  align-content: center;
  display: flex;
  justify-content: space-around;
}

/*卡片样式*/
.box1 {
  width: 300px;
  height: 300px;
  /* background-color: salmon; */
  border-radius: 18px;
  justify-content: center;
  align-items: center;
}

.box {
  width: 300px;
  height: 300px;
  box-sizing: border-box;
  font-size: 28px;
  border-radius: 18px;
  color: #fff;
  padding: 38px 0 38px 0;
  position: absolute;
  perspective: 1000px;
  transition: 0.5s ease-in-out;
  text-align: center;
  justify-content: center;
  box-shadow: 0 4px 8px 0 rgba(0, 0, 0, 0.2), 0 6px 20px 0 rgba(0, 0, 0, 0.19);
}

.box img {
  width: 120px;
}

.mask {
  width: 300px;
  height: 300px;
  background-color: #3b4b52;
  border-radius: 18px;
  text-align: center;
  line-height: 320px;
  font-family: '微软雅黑';
  font-weight: bold;
  position: absolute;
  backface-visibility: hidden;
  perspective: 1000px;
  transform: rotateY(-180deg);
  transition: 0.5s ease-in-out;
  display: flex;
  flex-direction: column;

}

.maskText {
  width: 280px;
  height: 300px;
  font-family: '微软雅黑';
  flex-direction: row;
  align-content: center;

}

.box1:hover .box {
  transform: rotateY(-180deg);
}

.box1:hover .mask {
  transform: rotateY(-360deg);
}

.BoxRow {
  width: 80%;
  margin-right: 80px;
  height: 400px;
  align-items: center;
  display: flex;
  justify-content: space-around;
}
</style>