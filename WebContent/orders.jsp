<%@page import="com.JavaBean.OrderProduct"%>
<%@page import="com.JavaBean.Orders"%>
<%@page import="com.JavaBean.DBHelper" %>
<%@page import="java.util.List"%>
<%@page import="java.util.regex.Pattern"%>
<%@page import="java.util.regex.Matcher"%>
<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html>
  <head>
    <meta charset="utf-8">
    <meta name="viewport" content="width=device-width, initial-scale=1, shrink-to-fit=no">
    <meta name="description" content="">
    <meta http-equiv="X-UA-Compatible" content="IE=edge">
    <title>订单</title>
    <link rel="icon" href="img/core-img/favicon.ico">
    <link rel="stylesheet" href="style.css">
  </head>
  <body>
    <div class="preloader" id="preloader">
      <div class="spinner-grow text-secondary" role="status">
        <div class="sr-only">加载中...</div>
      </div>
    </div>
    <div class="header-area" id="headerArea">
      <div class="container h-100 d-flex align-items-center justify-content-between">
        <div class="back-button"><a href="index.jsp"><i class="lni lni-home"></i></a></div>
        <div class="top-search-form">

          <form action="" method="POST">
            <input class="form-control" name="orderid"  type="search" placeholder="请输入订单号">
            <button type="submit"><i class="fa fa-search"></i></button>
          </form>
        </div>
        <div class="suha-navbar-toggler d-flex justify-content-between flex-wrap" id="suhaNavbarToggler"><span></span><span></span><span></span></div>
      </div>
    </div>
    <div class="sidenav-black-overlay"></div>

<!-- 左侧导航栏start -->
    <div class="suha-sidenav-wrapper" id="sidenavWrapper">
      <!-- 头像昵称 -->
	<%
		String nickname = "";
		String uid = "";
		Cookie[] cookies = request.getCookies();
		if(cookies == null){
			out.print("<script>alert('您还未登陆');window.location='login.jsp'</script>");
		}else{
			for(int i = 0 ;i < cookies.length ;i++){
				if(cookies[i].getName().equals("nickname")){
					nickname = cookies[i].getValue();
				}else if(cookies[i].getName().equals("uid")){
					uid = cookies[i].getValue();
				}
			}	
		}
	%> 
      <div class="sidenav-profile">
        <div class="user-profile"><img src="img/bg-img/9.jpg" alt=""></div>
        <div class="user-info">
          <h6 class="user-name mb-0"><%=nickname %></h6>
        </div>
      </div>
      <!-- 右边导航栏 -->
      <%
      	if(uid.equals("")){
      		out.print("<script>alert('您还未登陆');window.location='login.jsp'</script>");
      %>
      <ul class="sidenav-nav">
        <li><a href="login.jsp"><i class="lni lni-pointer-up"></i>登录</a></li>
      </ul>
      <%
      	}else if (nickname.equals("")){
      		
      %>
      		<ul class="sidenav-nav">
            <li><a href="profile.jsp"><i class="lni lni-pointer-up"></i>修改个人资料</a></li>
          </ul>
       <%
      	}else if(uid != null && nickname != null){
      %>
      <ul class="sidenav-nav">
      <li><a href="profile.jsp"><i class="lni lni-pointer-up"></i>修改个人资料</a></li>
        <li><a href="orders.jsp"><i class="lni lni-empty-file"></i>我的订单</a></li>
        <%
        	//是管理员才能显示商品管理
        	if(nickname.equals("管理员")){
        %>
        <li><a href="management.jsp"><i class="lni lni-grid-alt"></i>商品管理</a></li>
        <%
        	}
        %>
        <li><a href="cart.jsp"><i class="lni lni-cart-full"></i>购物车</a></li>
        <li><a href="signout"><i class="lni lni-power-switch"></i>退出登录</a></li>
      </ul>
      <%
      	}else{
      		out.print("<script>alert('您还未登陆');window.location='login.jsp'</script>");
      	}
      %>
      <!-- 返回按钮 -->
      <div class="go-home-btn" id="goHomeBtn"><i class="lni lni-arrow-left"></i></div>
    </div>
    <!-- 左侧导航栏end -->

    <div class="page-content-wrapper">
      <div class="container">
        <div class="my-order-wrapper py-3">
          <%
          String sql = "";
          try{
        	  String orderid = request.getParameter("orderid");
        	  Pattern pattern = Pattern.compile("[0-9]{18}"); 
        	  Matcher isNum = pattern.matcher(orderid);
              if(!isNum.matches()){
            	  sql = "SELECT * FROM orders WHERE userid="+uid+"";
            	  //out.print("<script>alert('订单号输入错误')</script>");
              }else{
            	  sql = "SELECT * FROM orders WHERE orderid='"+orderid+"'";
              }
          }catch (Exception e) {
        	  sql = "SELECT * FROM orders WHERE userid="+uid+"";
          }
          request.removeAttribute("orderid");
          List<Orders> ls = DBHelper.Orders(sql);
          Orders currentOrder;
          for (int i = 0; i < ls.size(); i++) {
          	currentOrder = ls.get(i) ;
          	%>
          	<div class="single-order-status">
            <div class="card bg-warning mb-3">
            <form action="" method="post">
              <div class="card-body d-flex align-items-center">
                <div class="order-status">时间：<span class="order-date"><%=currentOrder.getTime() %></span></div>
              </div>
              <div class="card-body d-flex align-items-center">
                <div class="order-status">订单号：<span class="order-date"><%=currentOrder.getOrderid() %></span></div>
              </div>
              <div class="card-body d-flex align-items-center">
                <div class="order-status">总金额：<span class="order-date">￥<%=currentOrder.getPrice()%></span></div>
              </div>
              <div class="card-body d-flex align-items-center">
              <%
              	if(currentOrder.getState()){
              %>
              	<a class="btn btn-info btn-sm">已完成</a>&nbsp;&nbsp;&nbsp;&nbsp;
              <%
          		}else{
              %>
              	
              	<a class="btn btn-danger btn-sm" href="checkout.jsp?oid=<%=currentOrder.getOrderid()%>&p=<%=currentOrder.getPrice()%>">未支付</a>&nbsp;&nbsp;&nbsp;&nbsp;
              <%
          		}
              %>
                <a class="btn btn-danger btn-sm" href="deleteorder?oid=<%=currentOrder.getOrderid()%>&uid=<%=uid%>">删除订单</a>
              </div>
              </form>
            </div>
            <div class="row">
               <%
               sql = "SELECT * FROM orderProduct t1 inner join commodities t2 on t1.commodityid=t2.commodityid WHERE orderid="+currentOrder.getOrderid()+"";
               List<OrderProduct> OCls = DBHelper.OrderCommodities(sql);
               OrderProduct currentOrderCommodities;
               for (int j = 0; j < OCls.size(); j++) {
            	   currentOrderCommodities = OCls.get(j);
          
            	   %>
            	   <div class="col-6 col-sm-4 col-lg-3">
                   <div class="card top-product-card mb-3">
                     <div class="card-body"><a class="product-thumbnail d-block" href="single-product.html"><img class="mb-2" src="<%=currentOrderCommodities.getPicture()%>" alt=""></a><a class="product-title d-block" href="single-product.html"><%=currentOrderCommodities.getName()%></a>
                       <p class="sale-price">￥<%=currentOrderCommodities.getPrice()%></p>
                       <div class="product-rating"></div><a class="btn btn-success btn-sm add2cart-notify" href="#"><i>X<%=currentOrderCommodities.getNumber()%></i></a>
                     </div>
                   </div>
                 </div>
            	   <%
               }
               %>
              
            </div>
          </div>
          	
          	<%
          }
          %>
          
          
          
          
          
        </div>
      </div>
    </div>

    <!-- 引入JS -->
    <script src="js/jquery.min.js"></script>
    <script src="js/popper.min.js"></script>
    <script src="js/bootstrap.min.js"></script>
    <script src="js/waypoints.min.js"></script>
    <script src="js/jquery.easing.min.js"></script>
    <script src="js/owl.carousel.min.js"></script>
    <script src="js/jquery.animatedheadline.min.js"></script>
    <script src="js/jquery.counterup.min.js"></script>
    <script src="js/wow.min.js"></script>
    <script src="js/jarallax.min.js"></script>
    <script src="js/jarallax-video.min.js"></script>
    <script src="js/default/jquery.passwordstrength.js"></script>
    <script src="js/default/dark-mode-switch.js"></script>
    <script src="js/default/active.js"></script>
  </body>
</html>