<%@page import="com.JavaBean.Commodities" %>
<%@page import="com.JavaBean.DBHelper" %>
<%@page import="java.util.List"%>
<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html>
  <head>
    <meta charset="utf-8">
    <meta name="viewport" content="width=device-width, initial-scale=1, shrink-to-fit=no">
    <meta name="description" content="">
    <meta http-equiv="X-UA-Compatible" content="IE=edge">
    <title>商品管理</title>
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

        <div class="page-heading">
          <h6 class="mb-0">商品管理</h6>
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
        <li><a href="wishlist-grid.jsp"><i class="lni lni-grid-alt"></i>商品管理</a></li>
        <%
        	}else{
        		out.print("<script>alert('您不是管理员');window.location='login.jsp'</script>");
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

        <div class="cart-wrapper-area py-3">
          <div class="cart-table card mb-3">
            <div class="table-responsive card-body">
            <form action="" method="POST">
              <table class="table mb-0">
                <tbody>
                <%
                String sql = "SELECT * FROM commodities t1 inner join commoditiestype t2 on t1.typeid=t2.typeid";
                List<Commodities> ls = DBHelper.Commodities(sql);
                Commodities currentCommodity;
				double p = 0;
				%>
                <%
				for (int i = 0; i < ls.size(); i++) {
					currentCommodity = ls.get(i) ;
					p+=currentCommodity.getPrice()*currentCommodity.getNumber();
					//int a = currentCommodity.getCommodityid();
				%>

	            	<tr  style="text-align: center;">

	                    <td><img src="<%=currentCommodity.getPicture()%>" alt=""></td>
	                    <td><a><%=currentCommodity.getName()%><span>￥<%=currentCommodity.getPrice()%></span></a></td>
	                    <td>
	                      <div class="quantity">
	                      <%
	                      	if(currentCommodity.getState()){
	                      		%>
	                      			<a class="btn btn-danger btn-sm" href="upordown?state=1&cid=<%=currentCommodity.getCommodityid() %>">下架</a>
	                      		<%
	                      	}else{
	                      		%>
	                      			<a class="btn btn-info btn-sm" href="upordown?state=0&cid=<%=currentCommodity.getCommodityid() %>">上架</a>
	                      		<%
	                      	}
	                      		
	                      %>
	                     
	                      </div>
	                    </td>
	                  </tr>
	                  
	            <%
				}
				%>
                  
                  
                </tbody>
              </table>
              </form>
            </div>
          </div>

        </div>
      </div>
    </div>



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