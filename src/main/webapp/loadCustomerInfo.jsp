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
    <%--2.导入bootstarp.css
	3.导入jquery.js
	4.导入bootstrap.js--%>
 <%--导入bootstarp.css--%>
 <link rel="stylesheet" type="text/css" href="css/bootstrap.min.css">
 <script type="text/javascript" src="js/jquery-1.11.3.min.js"></script>
 <script type="text/javascript" src="js/bootstrap.min.js"></script>
<script type="text/javascript">
    //页面载入事件
    $(function(){

        loadCustomerById(1)


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


    function loadCustomerById(page){
        var url = "/ssm_maven_0811_war/api/cust/findCustInfoByPage";
        //获取输入框的值
        var nameVal =  $("#name").val();
        var params = {"indexPage":page,"name":nameVal};




        $.post(
            url,
            params,
            function(data){
              var dataList =   data.beanList;
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
                //使用js封装分页数据	

                var pagehtml ="";

                pagehtml += "<a onclick='loadCustomerById(1)' class='btn btn-default btn-sm active' >首页</a>&nbsp;";
                if(data.indexPage > 1){

                    pagehtml += "<a onclick='loadCustomerById("+(data.indexPage - 1)+")' class='btn btn-default btn-sm active'> 上一页 </a>&nbsp;";
                }else{
                    pagehtml +="<span class='btn btn-default btn-sm disabled'>上一页</span>&nbsp;";

                }


                if(data.totalPage < 4){
                    for (var i = 1; i <= data.totalPage; i++) {
                        pagehtml +="<a  onclick='loadCustomerById("+i+")' class='btn btn-default btn-sm active'>"+i+"</a>&nbsp;";
                    }

                }else if(data.indexPage + 4 <= data.totalPage){

                    for ( var i = data.indexPage; i < data.indexPage + 4; i++) {
                        pagehtml += "<a  onclick='loadCustomerById("+i+")' class='btn btn-default btn-sm active'> "+i+" </a>&nbsp;";
                    }
                }else{
                    for ( var i = data.totalPage - 3; i <= data.totalPage; i++) {
                        pagehtml += "<a onclick='loadCustomerById("+i+")' class='btn btn-default btn-sm active'> "+i+" </a>&nbsp;";
                    }
                }


                if(data.indexPage < data.totalPage){

                    pagehtml += "<a onclick='loadCustomerById("+(data.indexPage + 1)+")' class='btn btn-default btn-sm active'> 下一页 </a>&nbsp;";
                }else{
                    pagehtml +="<span class='btn btn-default btn-sm disabled'>下一页</span>&nbsp;";
                }


                pagehtml += "<a onclick='loadCustomerById("+(data.totalPage)+")' class='btn btn-default btn-sm active'>尾页</a>&nbsp;";
                pagehtml += "<font class='page-header' size='4.5px'>当前第&nbsp;"+data.indexPage+"&nbsp;页/共&nbsp;"+data.totalPage+"&nbsp;页</font>";
                pagehtml +="</ul>";
                $("#myIndexPage").html(pagehtml);




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
