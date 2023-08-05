
<template>
    <div class="mini-layour">
        <dialog id="favDialog" style="position: absolute;width: 40%;">
            <form method="dialog" id="form1" @submit="submitForm1">
                <div style="display: inline-block; width:200px;">
                <label for="u_name" class="item1">用户名:</label>
                <input v-model="formData.name" type="text" id="u_name" name="u_name" class="item1" required>
            </div>
            <div style="display: inline-block; width:200px;">
                <label for="u_gender" class="item1" >性别:</label>
                <input v-model="formData.gender" type="text" id="u_gender" name="u_gender"  class="item1" required>
            </div>
                <div style="display: inline-block; width:200px;">
                <label for="u_phone" class="item1">电话:</label>
                <input v-model="formData.phone" type="text" id="u_phone" name="u_phone" class="item1" required>
            </div>
                <div style="display: inline-block; width:200px;">
                <label for="u_email" class="item1">邮箱:</label>
                <input v-model="formData.email" type="text" id="u_email" name="u_email"  class="item1" required>
            </div>
                <div style="display: inline-block; width:200px;">
                <label for="u_password" class="item1">密码:</label>
                <input v-model="formData.password" type="text" id="u_password" name="u_password" class="item1" required>
            </div> 
                <input type="submit" value="提交" >
                <button id="xxx" @click="cancelForm">取消</button>
              </form>
          </dialog>

          <dialog id="favDialog2" style="position: absolute;width: 40%;">
            <form v-if="currentPageUser!=null&&currentPageUser.length>0&&showdig" method="dialog" id="form2" @submit="submitForm2">
                <div style="display: inline-block; width:200px;">
                <label for="u_name" class="item1">用户名:</label>
                <input v-model="currentPageUser[index].u_Name" type="text" id="u_name" name="u_name" class="item1" required>
            </div>
            <div style="display: inline-block; width:200px;">
                <label for="u_gender" class="item1" >性别:</label>
                <input v-model="currentPageUser[index].u_Gender" type="text" id="u_gender" name="u_gender"  class="item1" required>
            </div>
                <div style="display: inline-block; width:200px;">
                <label for="u_phone" class="item1">电话:</label>
                <input v-model="currentPageUser[index].u_Phone" type="text" id="u_phone" name="u_phone" class="item1" required>
            </div>
                <div style="display: inline-block; width:200px;">
                <label for="u_email" class="item1">邮箱:</label>
                <input v-model="currentPageUser[index].u_Email" type="text" id="u_email" name="u_email"  class="item1" required>
            </div>
                <div style="display: inline-block; width:200px;">
                <label for="u_password" class="item1">密码:</label>
                <input v-model="currentPageUser[index].u_Password" type="text" id="u_password" name="u_password" class="item1" required>
            </div> 
                <input type="submit" value="提交" >
                <button id="xxx" @click="cancelForm2">取消</button>
              </form>
          </dialog>

        <header class="headLine">
            <img alt="" src="../../resource/image/logo0.png" style="height: 80px;position: absolute;top: 10px;left: 15%;">
            <img alt="" src="../../resource/image/line.png" style="height: 80px;position: absolute;top: 10px;left: 35%;">
            <router-link to="/AdmHome">
                <p class="textstyle" >首页</p>
            </router-link>
            <span class="textstyle" style="left:80%;z-index: 7;"  >管理员，您好！</span>
            <!--
            <div  @mouseleave="showDropdown = false">
            
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
                    <p>用户管理</p>
                    <div class="card">
                      <p id="new_user" @click="showDialog">新增用户</p>
                  </div>
                </div>
            </div>
            
            

            <div class="container">
                <div class="form-container">
                    <form @submit="searchUsers1" id="submit_form">
                      <div style="display: inline-block;">
                        <label for="author" class="item">id：</label>
                        <input type="text" v-model="searchForm.u_id" id="u_id0" placeholder="请输入性别" class="item " style="width: 60%;">
                    </div>
                        <div style="display: inline-block;">
                           <label for="bookTitle" class="item">姓名：</label>
                         <input type="text" v-model="searchForm.u_name" id="u_name0" placeholder="请输入姓名" class="item" style="width: 60%;"> 
                        </div>
                    <div style="display: inline-block;">
                  <label for="bookNumber" class="item">电话：</label>
                  <input type="text" v-model="searchForm.u_phone" id="u_phone0" placeholder="请输入电话" class="item " style="width: 50%;">
                  </div>
                  <div style="display: inline-block;">
                  <label for="publisher" class="item">邮箱：</label>
                  <input type="text" v-model="searchForm.u_email" id="u_email0" placeholder="邮箱" style="width: 50%;"> 
                </div>
                  <div  class="form-actions" style="position: relative;width: 100%;">
                    <button type="submit" style="display: block;position: absolute;right:0%">查询</button>
                  </div>
                </form>
                </div>
                
                <div class="userQuery">
                <table id="resultsTable">
                  <tr>
                    <th>id</th>
                    <th>姓名</th>
                    <th>电话</th>
                    <th>性别</th>
                    <th>邮箱</th>
                    <th></th>
                    <th></th>
                  </tr>
                  <!-- 查询结果将在这里动态添加 -->
                  <tr v-for="(item,index) in currentPageUser" :key="index">
                    <th>{{item.u_Id}}</th>
                    <th>{{item.u_Name}}</th>
                    <th>{{item.u_Phone}}</th>
                    <th>{{item.u_Gender}}</th>
                    <th>{{item.u_Email}}</th>
                    <th><p @click="showDialog2(index)">修改</p> </th>
                    <th><p @click="deleteUser(index)">删除</p></th>
                  </tr>
                </table>
                  <div class="pagination" style="position: absolute;left: 50%;bottom: 5%;transform: translate(-50%,0);display: flex; align-items: center;">
                    <img src="../../resource/image/leftPage.png" id="leftmove" @click="leftmove" style="max-width: 20px;margin-right: 3px;">
                    <span>第{{current}}页/共{{pages}}页 </span>
                    <img src="../../resource/image/rightPage.png" id="rightmove" @click="rightmove" style="max-width: 20px;margin-left: 3px;">
                </div>
              </div>
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
      pages: 1,
      current: 1,
      userarr: [],
      currentPageUser: [],
      displayarr: [],
      index:0,
      showdig:false,
      searchkind:0,
      item_num: 10,
      page_num: 6,
      URL:"/api/users?",
      searchForm: {
        u_id:"",
        u_name: "",
        u_gender: "",
        u_phone: "",
        u_email: "",
      },
      formData: {
        name:'',
        gender: '',
        phone: '',
        email: '',
        password: '',
      },
    };
  },
  methods: {
    logout() {
      // 在这里执行退出登录的操作
      this.$router.replace('/admLogin')
    },
    showDialog() {
      
      const favDialog = document.getElementById("favDialog");
      if (typeof favDialog.showModal === "function") {
        favDialog.showModal();
        console.log("hello?");
      } else {
        this.outputBox = "Sorry, the <dialog> API is not supported by this browser.";
      }
    },
    showDialog2(tempindex) {
      this.index=tempindex
      this.showdig=true;
      const favDialog = document.getElementById("favDialog2");
      if (typeof favDialog.showModal === "function") {
        favDialog.showModal();
        console.log("hello?");
      } else {
        this.outputBox = "Sorry, the <dialog> API is not supported by this browser.";
      }
    },
    cancelForm() {
      const form = document.getElementById("form1");
      form.reset(); // Reset form fields
      const favDialog = document.getElementById("favDialog");
      favDialog.close(); // Close the dialog
    },
    cancelForm2() {
      const form = document.getElementById("form2");
      form.reset(); // Reset form fields
      const favDialog = document.getElementById("favDialog2");
      favDialog.close(); // Close the dialog
      this.showdig=false;
    },
    submitForm1() {
      console.log("进入提交选项")
      axios.post('/api/add_user', this.formData)
        .then((response) => {
          console.log('Post request successful:', response.data);
          console.log(response.data.code)
        })
        .catch((error) => {
          console.error('Post request failed:', error);
          
        });
          //点击提交后的按钮
          const form = document.getElementById("form1");
          form.reset();
          const favDialog = document.getElementById("favDialog");
          favDialog.close();
    },
    submitForm2() {
      console.log("进入提交选项")
      axios.patch('/api/modify_user', this.currentPageUser[this.index])
        .then((response) => {
          console.log('Post request successful:', response.data);
          console.log(response.data.code)
        })
        .catch((error) => {
          console.error('Post request failed:', error);
          
        });
          //点击提交后的按钮
          const form = document.getElementById("form1");
          form.reset();
          const favDialog = document.getElementById("favDialog");
          favDialog.close();
    },
    deleteUser(tempindex){
        this.index=tempindex;
        const userIdToDelete = this.currentPageUser[this.index].u_Id;
        axios.delete(`/api/delete_book/${userIdToDelete}`).then((response)=>{
            console.log("表单数据已成功传输到后端");
            console.log(response.data)
            console.log(response)
            this.searchUsers1();
            alert("用户删除成功！")
        }).catch((error)=>{
            console.error("请求失败:", error);
        })
        this.searchUsers1();
      },
    leftmove() {
      if (this.current > 1) {
        this.current = this.current - 1;
        this.searchUsersFunc(this.URL,this.current);
      }
    },
    rightmove() {
      if (this.current < this.pages) {
        this.current++;
        this.searchUsersFunc(this.URL,this.current);
      }
    },
    toArr(temparr) {
      this.userarr = temparr;
      this.pages = Math.ceil(this.userarr.length / this.page_num);
      this.current = 1;
      this.updateDisplayArr();
    },
    updateDisplayArr() {
      const left = (this.current - 1) * this.page_num;
      const right = Math.min(left + this.page_num, this.userarr.length);
      this.displayarr = this.userarr.slice(left, right);
    },
    postRequest(page) {
      console.log(page)
      // Your postRequest logic here
      // For example, you can use Axios or any other library to make the request
      // and then update the data accordingly.
    },
    searchUsersFunc(Url, page) {
      const that = this; 
      var nextPageURL=Url;
      if(this.searchkind==0){
        nextPageURL = Url + "page=" + page + "&pageSize=6";
      }
      if(this.searchkind==1){
        nextPageURL=Url;
      }
      axios
        .get(nextPageURL)
        .then((response) => {
          const jsdata = response.data;
          console.log(response.data)
          if(that.searchkind==0){
            that.currentPageUser = []; // 先清空数组
          // 处理信息
          that.currentPageUser = jsdata.data.userList;
          that.current = page;
          that.pages = Math.ceil(jsdata.data.amount / 6);
          }
          else{
            that.currentPageUser = []; // 先清空数组
            that.currentPageUser.push(jsdata.data) ;
            that.current = 1;
            that.pages = 1;
          }
          
          
        })
        .catch((error) => {
          console.error("请求失败:", error);
        });
    },
    searchUsers1(){
        this.current=1;
        if(this.searchForm.u_id!=""){
            this.URL="/api/user_info?";
            this.URL=this.URL+"u_id="+this.searchForm.u_id;
            this.searchkind=1;
        }
        this.searchUsersFunc(this.URL,this.current);  //发送请求
    }
  },
    mounted() {
      this.current=1;
      this.searchUsersFunc(this.URL,this.current);
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
    .card {
    width:90%;
  display: inline-block;
  padding: 10px;
  background-color:  rgb(255, 255, 255);
  border-radius: 8px;
  box-shadow: 0px 2px 4px rgba(0, 0, 0, 0.1);
  transition: transform 0.3s ease-in-out, box-shadow 0.3s ease-in-out;
}

.card:hover {
  transform: scale(1.05);
  box-shadow: 0px 4px 8px rgba(0, 0, 0, 0.2);
}

#new_user {
  display: block;
  width: 100%;
  text-align: center;
  background-color: rgb(119,108,83);
  color: #fff;
  border-radius: 8px;
  padding: 12px 0;
  cursor: pointer;
  transition: background-color 0.3s ease-in-out;
}

#new_user:hover {
  background-color:rgb(143, 123, 75);
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

    /* 表格样式 */
  #resultsTable {
    width: 100%;
    border-collapse: collapse;
    font-family: Arial, sans-serif;
  }

  #resultsTable th{
    border: 1px solid #dddddd;
    padding: 8px;
    text-align: left;
    font-family: '仿宋', serif; /* 设置表头和表格内容的字体 */
    font-size: 18px;
  }
   #resultsTable td {
    border: 1px solid #dddddd;
    padding: 8px;
    text-align: left;
    font-family: '仿宋', serif; /* 设置表头和表格内容的字体 */
    font-size: 14px;
  }

  #resultsTable th {
    background-color: #fbfbfb;
  }

  /* 鼠标悬停时的样式 */
  #resultsTable tr:hover {
    background-color: #f5f5f5;
  }

  /* 修改和删除按钮的样式 */
  #resultsTable p {
    cursor: pointer;
    color: #007bff;
    margin: 0;
    text-decoration: underline;
  }
    .form-container {
        display: flex;
        justify-content: space-between;
        align-items: center;
        margin-bottom: 20px;
    }

    .form-actions {
        display: flex;
        align-items: center;
    }

    .form-actions button {
        margin-left: 10px;
    }

    .pagination {
        display: flex;
        justify-content: center;
        align-items: center;
        margin-top: 10px;
    }

    .pagination button {
        margin: 0 5px;
    }
</style>