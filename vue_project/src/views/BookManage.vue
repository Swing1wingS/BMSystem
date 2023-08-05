<template>
    <div class="app">
        <dialog id="favDialog" style="position: absolute;z-index: 10; width: 40%;" >
            <form method="dialog" id="myform">
            <div style="display: inline-block; width:200px;">
                <label for="b_Id" class="item1">书籍编号:</label>
                <input v-model="formData.b_Id" type="text" id="b_Id" name="b_Id" class="item1">
            </div>
            <div style="display: inline-block; width:200px;">
                <label for="b_Name" class="item1" >书籍名称:</label>
                <input v-model="formData.b_Name" type="text" id="b_Name" name="b_Name"  class="item1">
            </div>
            <div class="upload-container" style="position: absolute;right: 25px;top:40px">
                <div class="upload-icon">
                    📁
                </div>
                <div class="upload-label">
                    <img v-bind:src="previewImage" style="max-width: 100px;" alt="上传图片">
                </div>
                <label for="fileInput" class="custom-button">选择文件</label>
                <input @change="handleFileChange" type="file" id="fileInput" class="file-input">
            </div>
            
            <div style="display: inline-block; width:200px;">
                <label for="b_Author" class="item1">作者:</label>
                <input v-model="formData.b_Author" type="text" id="b_Author" name="b_Author" class="item1">
            </div>
                <div style="display: inline-block; width:200px;">
                <label for="b_Press" class="item1">出版社:</label>
                <input v-model="formData.b_Press" type="text" id="b_Press" name="b_Press"  class="item1">
            </div>
                <div style="display: inline-block; width:200px;">
                <label for="b_Pub_Year" class="item1">出版年份:</label>
                <input v-model="formData.b_Pub_Year" type="text" id="b_Pub_Year" name="b_Pub_Year" class="item1">
            </div> 
                <div style="display: inline-block; width:200px;">
                <label for="b_Total_Collection"  class="item1">总藏书量:</label>
                <input v-model="formData.b_Total_Collection" type="text" id="b_Total_Collection" name="b_Total_Collection" class="item1" >
            </div>
                <div style="display: inline-block; width:200px;">
                <label for="b_Cur_Collection"  class="item1">当前藏书量:</label>
                <input v-model="formData.b_Cur_Collection" type="text" id="b_Cur_Collection" name="b_Cur_Collection"  class="item1">
            </div>
                <div style="display: inline-block; width:230px;">
                <label for="b_Bs_Id"  class="item1">书籍分类编号:</label>
                <input v-model="formData.b_Bs_Id" type="text" id="b_Bs_Id" name="b_Bs_Id"   class="item1">
            </div>
                <div style="display: inline-block; width:200px;">
                <label for="b_Isbn"  class="item1">ISBN:</label>
                <input v-model="formData.b_Isbn" type="text" id="b_Isbn" name="b_Isbn"  class="item1" >
            </div>
                <div style="display: inline-block; width:200px;">
                <label for="b_Price"  class="item">价格:</label>
                <input v-model="formData.b_Price" type="text" id="b_Price" name="b_Price"  class="item1">
            </div>
                <div style="display: inline-block; width:200px;">
                <label for="b_Description"  class="item1">描述:</label>
                <input v-model="formData.b_Description" type="text" id="b_Description" name="b_Description"  class="item1">
            </div>
                <!--button @click="chooseFile">上传图片</button-->
                
                <input type="submit" value="提交" @click="submitForm">
                <button id="cancelbutton" @onclick="cancelForm">取消</button>
              </form>
          </dialog>
          
          <dialog id="favDialog2" style="position: absolute;z-index: 10; width: 40%;" >
            <form v-if="currentPageBook.length>0&&showdig" method="dialog" id="myform2">
                <div style="display: inline-block; width:200px;">
                <label for="b_Id" class="item1">书籍编号:</label>
                <input v-model="currentPageBook[index].b_Id" type="text" id="b_Id2" name="b_Id2" class="item1">
            </div>
            <div style="display: inline-block; width:200px;">
                <label for="b_Name" class="item1" >书籍名称:</label>
                <input v-model="currentPageBook[index].b_Name" type="text" id="b_Name" name="b_Name"  class="item1">
            </div>
            <div class="upload-container" style="position: absolute;right: 25px;top:40px">
                <div class="upload-label">
                    <img v-bind:src=bookimgurl style="max-width: 100px;" alt="上传图片">
                </div>
            </div>

                <div style="display: inline-block; width:200px;">
                <label for="b_Author" class="item1">作者:</label>
                <input v-model="currentPageBook[index].b_Author" type="text" id="b_Author" name="b_Author" class="item1">
            </div>
                <div style="display: inline-block; width:200px;">
                <label for="b_Press" class="item1">出版社:</label>
                <input v-model="currentPageBook[index].b_Press" type="text" id="b_Press" name="b_Press"  class="item1">
            </div>
                <div style="display: inline-block; width:200px;">
                <label for="b_Pub_Year" class="item1">出版年份:</label>
                <input v-model="currentPageBook[index].b_Pub_Year" type="text" id="b_Pub_Year" name="b_Pub_Year" class="item1">
            </div> 
                <div style="display: inline-block; width:200px;">
                <label for="b_Total_Collection"  class="item1">总藏书量:</label>
                <input v-model="currentPageBook[index].b_Total_Collection" type="text" id="b_Total_Collection" name="b_Total_Collection" class="item1" >
            </div>
                <div style="display: inline-block; width:200px;">
                <label for="b_Cur_Collection"  class="item1">当前藏书量:</label>
                <input v-model="currentPageBook[index].b_Cur_Collection" type="text" id="b_Cur_Collection" name="b_Cur_Collection"  class="item1">
            </div>
                <div style="display: inline-block; width:230px;">
                <label for="b_Bs_Id"  class="item1">书籍分类编号:</label>
                <input v-model="currentPageBook[index].b_Bs_Id" type="text" id="b_Bs_Id" name="b_Bs_Id"   class="item1">
            </div>
                <div style="display: inline-block; width:200px;">
                <label for="b_Isbn"  class="item1">ISBN:</label>
                <input v-model="currentPageBook[index].b_Isbn" type="text" id="b_Isbn" name="b_Isbn"  class="item1" >
            </div>
                <div style="display: inline-block; width:200px;">
                <label for="b_Price"  class="item">价格:</label>
                <input v-model="currentPageBook[index].b_Price" type="text" id="b_Price" name="b_Price"  class="item1">
            </div>
                <div style="display: inline-block; width:200px;">
                <label for="b_Description"  class="item1">描述:</label>
                <input v-model="currentPageBook[index].b_Description" type="text" id="b_Description" name="b_Description"  class="item1">
            </div>

                <input type="submit" value="修改" @click="submitForm2">
                <button id="cancelbutton" @onclick="cancelForm2">取消</button>
              </form>
          </dialog>

        <header class="headLine">
            <img alt="" src="../../resource/image/logo0.png" style="height: 80px;position: absolute;top: 10px;left: 15%;">
            <img alt="" src="../../resource/image/line.png" style="height: 80px;position: absolute;top: 10px;left: 35%;">
            <router-link to="/AdmHome" >
                <p  class="textstyle" >首页</p>
            </router-link>
            
            <div @mouseenter="showDropdown=true" @mouseleave="showDropdown = false">
            <span class="textstyle" style="left:80%;z-index: 7;"  >管理员，您好！</span>
            <div class="dropdown" v-if="showDropdown" style="z-index: 6;"  @mouseenter="showDropdown=true" >
              <ul  @mouseenter="showDropdown=true">
                <li @click="logout" >退出登录</li>
              </ul>
            </div>
          </div>
        </header>
        <div class="contain">
        
        <div class="box">
            <div class="leftbox ">
                <div>
                    <p>服务信息</p>
                    <p>图书查询</p>
                    <div class="card">
                    <p id="new_book" @click="openDialog">新增图书</p>
                    </div>
                </div>
            </div>
            

            <div class="container">
                <div class="contain">
                    <form >
                        <div style="display: inline-block;">
                           <label for="bookTitle" class="item">书名：</label>
                         <input type="text" id="bookTitle" v-model="searchForm.bookTitle" placeholder="请输入书名" class="item" style="width: 60%;"> 
                        </div>
                    <div style="display: inline-block;">
                        <label for="author" class="item" >作者：</label>
                        <input type="text" v-model="searchForm.author" id="author" placeholder="请输入作者" class="item " style="width: 60%;" >
                    </div>
                    <div style="display: inline-block;">
                  <label for="bookNumber" class="item">图书编号：</label>
                  <input type="text" id="bookNumber" v-model="searchForm.bookNumber" placeholder="请输入图书编号" class="item " style="width: 50%;">
                  </div>
                  <div style="display: inline-block;">
                  <label for="publisher" class="item">出版社：</label>
                  <input type="text" id="publisher" v-model="searchForm.publisher" placeholder="请输入出版社" style="width: 50%;">
                </div>
                <div style="display: inline-block;" class="itembox">
                  <label for="category" class="item">ISBN：</label>
                  <input type="text" id="category" v-model="searchForm.ISBN" placeholder="请输入类别" class="item" style="width: 60%;">
                </div>
                  <button type="submit" style="position: absolute; right: 20%" @click="searchBooks">查询</button>
                </form>
                </div>
                
              <div class="move">
                <table id="resultsTable">
                  <tr>
                    <th>书名</th>
                    <th>作者</th>
                    <th>图书编号</th>
                    <th>出版社</th>
                    <th>ISBN</th>
                    <th></th>
                    <th></th>
                  </tr>
                  <!-- 查询结果将在这里动态添加 -->
                  <tr v-for="(item,index) in currentPageBook" :key="index">
                    <th>{{item.b_Name}}</th>
                    <th>{{item.b_Author}}</th>
                    <th>{{item.b_Id}}</th>
                    <th>{{item.b_Press}}</th>
                    <th>{{item.b_Isbn}}</th>
                    <th><p @click="openDialog2(index)">查看详情</p></th>
                    <th><p @click="deleteBook(index)">删除</p></th>
                  </tr>
                </table>
                <div  style="position: absolute;left: 50%;bottom: 5%;transform: translate(-50%,0);display: flex; align-items: center;">
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
        pages: 1,  //所有页面
        current: 1, //当前页面
        userarr: [],
        currentPageBook:[],  //当前页的所有图书
        displayarr: [{ value: "2" }],
        item_num: 10, // 所有图书的总数
        page_num: 6,
        index:0,
        previewImage:'',
        showdig:false,
        URL:"",
        bookimgurl:"",
        formData: {
          b_Id: "",
          b_Name: "",
          b_Author: "",
          b_Press: "",
          b_Pub_Year: "",
          b_Total_Collection: "",
          b_Cur_Collection: "",
          b_Bs_Id: "",
          b_Isbn: "",
          b_Price:"",
          b_Description: "",
          image:null
        },
        searchForm: {
          bookTitle: "",
          author: "",
          bookNumber: "",
          publisher: "",
          ISBN: ""
        },
        favDialogVisible: false
      };
    },
    methods: {
        logout() {
      // 在这里执行退出登录的操作
      this.$router.replace('/admLogin')
    },
        handleFileChange(event) {
      const file = event.target.files[0]; // 获取用户选择的文件
      this.image = file; // 更新组件中的image变量

      // 使用 FileReader 来实现预览图片
       const reader = new FileReader();
       reader.onload = (e) => {
         this.previewImage = e.target.result;
       };
       reader.readAsDataURL(file);
    },
        updata_arr() {
            var left = (this.current - 1) * this.page_num;
            var right = left + this.page_num;
            this.displayarr = []; // 先清空数组
            for (; left < right && left < this.userarr.length; left++) {
            this.displayarr.push(this.userarr[left]); // 将新数据赋值给数组
            }
        },
      leftmove() {
        if (this.current > 1) {
          this.current = this.current - 1;
          this.searchBooksFunc(this.URL,this.current);
        }
      },
      rightmove() {
        if (this.current < this.pages) {
          this.current++;
          this.searchBooksFunc(this.URL,this.current);
        }
      },
      chooseFile() {
        // 创建<input>元素
        var fileInput = document.createElement('input');
        fileInput.type = 'file';

        // 添加change事件监听器，当选择文件后执行回调函数
        fileInput.addEventListener('click', () => {
            const input = document.createElement('input');
            input.type = 'file';
            input.accept = 'image/*'; // 可以根据需要修改文件类型限制
            input.onchange = (event) => {
                const selectedFile = event.target.files[0];
                if (selectedFile) {
                    // 在这里可以执行文件上传的逻辑
                    console.log('已选择文件:', selectedFile.name);
                }
            };
            input.click();
        });

    // 触发文件选择对话框
            fileInput.click();
    },

      toArr(temparr) {  //将书籍存储到userarr数组
        this.userarr = temparr;
        this.pages = Math.ceil(this.userarr.length / this.page_num);
        this.current = 1;
        this.updata_arr();
      },
     
      openDialog() {
            const favDialog=document.getElementById("favDialog");
            if (typeof favDialog.showModal === "function") {
            favDialog.showModal();
            console.log("hello?");
        } else {
            this.outputBox = "Sorry, the <dialog> API is not supported by this browser.";
        }
      },
      openDialog2(tempindex) {
            this.index=tempindex;
            this.showdig=true;
            this.bookimgurl="https://web-bmsystem.oss-cn-hangzhou.aliyuncs.com/books/"+this.currentPageBook[this.index].b_Id+".png";
            const favDialog=document.getElementById("favDialog2");
            if (typeof favDialog.showModal === "function") {
            favDialog.showModal();
            console.log("hello?");
            
        } else {
            this.outputBox = "Sorry, the <dialog> API is not supported by this browser.";
        }
      },
      cancelForm() {
        const favDialog = document.getElementById("favDialog");
        favDialog.reset(); // Reset form fields
        favDialog.close(); // Close the dialog
      },
      cancelForm2() {
        this.showdig=false;
        const favDialog = document.getElementById("favDialog");
        favDialog.reset(); // Reset form fields
        favDialog.close(); // Close the dialog
      },
      submitForm() {
        const config = {
            headers: {
                "Content-Type": "application/json"
            }
        };
        this.formData.b_Price=parseFloat(this.formData.b_Price)
        this.formData.b_Total_Collection=parseInt(this.formData.b_Total_Collection)
        this.formData.b_Cur_Collection=parseInt(this.formData.b_Cur_Collection)
        this.formData.b_Pub_Year=parseInt(this.formData.b_Pub_Year)
        // 发送 POST 请求
        axios
          .post("/api/add_book", this.formData,config)
          .then((response) => {
           // this.$refs.form.reset();
            this.favDialogVisible = false;
            console.log("表单数据已成功传输到后端");
            console.log(response.data)
            console.log(response)
          })
          .catch((error) => {
            console.error("请求失败:", error);
          });
      },
      submitForm2() {
        const config = {
            headers: {
                "Content-Type": "application/json"
            }
        };
        this.currentPageBook[this.index].b_Price=parseFloat(this.currentPageBook[this.index].b_Price)
        this.currentPageBook[this.index].b_Total_Collection=parseInt(this.currentPageBook[this.index].b_Total_Collection)
        this.currentPageBook[this.index].b_Cur_Collection=parseInt(this.currentPageBook[this.index].b_Cur_Collection)
        this.currentPageBook[this.index].b_Pub_Year=parseInt(this.currentPageBook[this.index].b_Pub_Year)
        // 发送 POST 请求
        axios
          .patch("/api/modify_book", this.currentPageBook[this.index],config)
          .then((response) => {
           // this.$refs.form.reset();
            this.favDialogVisible = false;
            console.log("表单数据已成功传输到后端");
            console.log(response.data)
            console.log(response)
          })
          .catch((error) => {
            console.error("请求失败:", error);
          });
      },
      deleteBook(tempindex){
        this.index=tempindex;
        const bookIdToDelete = this.currentPageBook[this.index].b_Id;
        axios.delete(`/api/delete_book/${bookIdToDelete}`).then((response)=>{
            console.log("表单数据已成功传输到后端");
            console.log(response.data)
            console.log(response)
            this.searchBooks();
            alert("书籍删除成功！")
        }).catch((error)=>{
            console.error("请求失败:", error);
        })
        this.searchBooks();
      },
      searchBooks(){
        this.current=1;
        this.URL="/api/books?key=";
        if(this.searchForm.bookTitle!=""){
            this.URL=this.URL+"name&value="+this.searchForm.bookTitle;
        }
        else if(this.searchForm.ISBN!=""){
            this.URL=this.URL+"ISBN&value="+this.searchForm.ISBN;
        }
        else if(this.searchForm.author!=""){
            this.URL=this.URL+"author&value="+this.searchForm.author;
        }
        else if(this.searchForm.bookNumber!=""){
            this.URL=this.URL+"id&value="+this.searchForm.bookNumber;
        }
        else if(this.searchForm.publisher!=""){
            this.URL=this.URL+"press&value="+this.searchForm.publisher;
        }
        this.searchBooksFunc(this.URL,this.current);  //发送请求
      },
      searchBooksFunc(Url, page) {
    const that = this; // 保存组件实例的引用

      const nextPageURL = Url + "&page=" + page + "&pageSize=6";
      axios
        .get(nextPageURL)
        .then((response) => {
          const jsdata = response.data;
          // 处理信息
          that.currentPageBook = jsdata.data.bookList;
          that.current = page;
          that.pages = Math.ceil(jsdata.data.amount / 6);
         
        })
        .catch((error) => {
          console.error("请求失败:", error);
        });
    }
},
    mounted() {
      // 加载时请求所有书籍

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
.card {
    width:90%;
  display: inline-block;
  padding: 10px;
  background-color: #fff;
  border-radius: 8px;
  box-shadow: 0px 2px 4px rgba(0, 0, 0, 0.1);
  transition: transform 0.3s ease-in-out, box-shadow 0.3s ease-in-out;
}

.card:hover {
  transform: scale(1.05);
  box-shadow: 0px 4px 8px rgba(0, 0, 0, 0.2);
}

#new_book {
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

#new_book:hover {
  background-color: #2980b9;
}

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
background-color: rgba(119, 108, 83, 0.712);
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

table {
border-collapse: collapse;
width: 100%;
}

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

.upload-container {
    display: inline-block;
    max-width: 140px;
    text-align: center;
    background-color: #ffffff;
    padding: 20px;
    border-radius: 10px;
    box-shadow: 0 2px 4px rgba(0, 0, 0, 0.1);
  }

  .upload-icon {
    font-size: 15px;
    color: #3498db;
    margin-bottom: 5px;
  }

  .upload-label {
    font-size: 15px;
    color: #333333;
  }

  .file-input {
    display: none;
  }

  .custom-button {
    background-color: #3498db;
    color: #ffffff;
    padding: 10px 20px;
    border: none;
    border-radius: 5px;
    cursor: pointer;
    transition: background-color 0.3s ease;
  }

  .custom-button:hover {
    background-color: #2980b9;
  }
</style>

