<%--
  Created by IntelliJ IDEA.
  User: Administrator
  Date: 2022-5-10
  Time: 9:43
  To change this template use File | Settings | File Templates.
--%>
<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<html>
<head>
    <title>Title</title>
    <meta name="viewport" content="width=device-width, initial-scale=1">
    <!--  JQUERY -->
    <script type="text/javascript" src="jquery/jquery-1.11.1-min.js"></script>

    <!--  BOOTSTRAP -->
    <link rel="stylesheet" type="text/css" href="jquery/bootstrap_3.3.0/css/bootstrap.min.css">
    <script type="text/javascript" src="jquery/bootstrap_3.3.0/js/bootstrap.min.js"></script>

    <!--  PAGINATION plugin -->
    <link rel="stylesheet" type="text/css" href="jquery/bs_pagination-master/css/jquery.bs_pagination.min.css">
    <script type="text/javascript" src="jquery/bs_pagination-master/js/jquery.bs_pagination.min.js"></script>
    <script type="text/javascript" src="jquery/bs_pagination-master/localization/en.js"></script>

<script type="text/javascript">
    //页面载入事件
    $(function(){

        loadCustomerById(1,3)

        loadCustomerById($("#myIndexPage").bs_pagination('getOption','currentPage'),
            $("#myIndexPage").bs_pagination('getOption','rowsPerPage'));


    });

    //毫秒转日期
    function turnTime(ms){
        var oDate = new Date(ms),
            oYear = oDate.getFullYear(),
            oMonth = oDate.getMonth()+1,
            oDay = oDate.getDate(),
            oHour = oDate.getHours(),
            oMin = oDate.getMinutes(),
            oSen = oDate.getSeconds(),
            oTime = oYear +'-'+ getzf(oMonth) +'-'+ getzf(oDay) +' '+ getzf(oHour) +':'+ getzf(oMin) +':'+getzf(oSen);//最后拼接时间
        return oTime;
    }
    //给时间补上零
    function getzf(num){
        if(parseInt(num) < 10){
            num = '0'+num;
        }
        return num;
    }


    function loadCustomerById(page,pageSize){
        var url = "/ssm_maven_0811_war/api/cust/findCustInfoByPage2";
        //获取输入框的值
        var nameVal =  $("#name").val();
        alert(nameVal);
        var params = {"indexPage":page,"name":nameVal};




        $.post(
            url,
            params,
            function(data){
              var dataList =   data.list;
              //js对象转jQuery对象
               var $data =  $(dataList);
                //获取存放数据的tbody标签对象
               var $body =  $("#myTbody");
//每次追加之前清空数据
                $body.empty();


                $data.each(function(index,dom){
                    $body.append(" <tr>\n" +
                        "                <td>"+(index+1)+"</td>\n" +
                        "                <td>"+dom.custName+"</td>\n" +
                        "                <td>"+dom.custSource+"</td>\n" +
                        "                <td>"+dom.custLevel+"</td>\n" +
                        "                <td>"+dom.custMobile+"</td>\n" +
                        "                <td>"+turnTime(dom.custBirthday)+"</td>\n" +
                        "                <td>"+dom.custAddress+"</td>\n" +
                        "                <td><a href='#' class='btn btn-info btn-sm'>编辑</a>&nbsp;<a href='#' class='btn btn-danger btn-sm'>删除</a></td>\n" +
                        "            </tr>");
              })
              

                $("#myIndexPage").bs_pagination({
                    currentPage:page,//当前页 相当于pageNo
                    rowsPerPage:5, // 每页显示的条数，相当于pageSize
                    totalRows:data.total,//总条数 相当于totalRows
                    totalPages: data.pages, //总页数 必填参数  要自己算
                    visiblePageLinks:3, // 最多显示几个卡片数

                    showGoToPage: true, //是否显示跳转到|->|
                    showRowsPerPage: true,//是否显示每页显示条数
                    showRowsInfo: false, //是否显示记录信息
                    showRowsDefaultInfo: true,
                    //每次返回切换页号后的pageNo和pageSize
                    onChangePage : function(event,pageObj){ //用户切换页号的时候可以执行的js代码
                        // pageList(data.currentPage , data.rowsPerPage);
                        loadCustomerById(pageObj.currentPage,pageObj.rowsPerPage);
                    }

                  /*  onLoad:function(event,pageObj){

                        loadCustomerById(pageObj.currentPage,pageObj.rowsPerPage);
                    }
*/

                });


            },
            "json"
        );
    }

</script>

</head>
<body>
<div class="container-fluid">

        <form class="form-inline" role="form">
            <div class="form-group">
                <label class="sr-only" for="name">名称</label>
                <input type="text" class="form-control" id="name" placeholder="请输入名称">
            </div>
            &nbsp;
            <button type="button" onclick="loadCustomerById(1)" class="btn btn-default">搜索</button>

        <table class="table table-bordered table-striped table-hover">
            <tr>
                <th>编号</th>
                <th>客户名称</th>
                <th>来源</th>
                <th>等级</th>
                <th>联系方式</th>
                <th>生日</th>
                <th>通信地址</th>
                <th>操作</th>
            </tr>
            <tbody id="myTbody">


            </tbody>


        </table>
    </form>
    <div id="myIndexPage" align="center"></div>
</div>
</body>
</html>
