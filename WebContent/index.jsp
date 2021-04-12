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
    <title>首页</title>
    <link rel="icon" href="img/core-img/favicon.ico">
    <link rel="stylesheet" href="style.css">
  </head>
  <body>
    <div class="preloader" id="preloader">
      <div class="spinner-grow text-secondary" role="status">
        <div class="sr-only">加载中...</div>
      </div>
    </div>
	<!-- 顶部搜索start -->
    <div class="header-area" id="headerArea">
      <div class="container h-100 d-flex align-items-center justify-content-between">
        <!-- Logo -->
        <div class="logo-wrapper"><a href="index.jsp"><img src="img/core-img/logo-small.png" alt=""></a></div>
        <!-- 搜索框 -->
        <div class="top-search-form">
          <form action="search.jsp" method="POST">
            <input class="form-control" name="name" type="text" placeholder="输入商品名称">
            <button type="submit"><i class="fa fa-search"></i></button>
          </form>
        </div>
        <!-- 导航栏 -->
        <div class="suha-navbar-toggler d-flex flex-wrap" id="suhaNavbarToggler"><span></span><span></span><span></span></div>
      </div>
    </div>
	<!-- 顶部搜索start -->
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
      		out.print("<script>alert('您还未登陆')</script>");
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
      <!-- 推荐商品 -->
      <div class="hero-slides owl-carousel">
        <div class="single-hero-slide" style="background-image: url('img/bg-img/1.jpg')">
          <div class="slide-content h-100 d-flex align-items-center">
            <div class="container">
              <h4 class="text-white mb-0" data-animation="fadeInUp" data-delay="100ms" data-wow-duration="1000ms">智能无线音箱</h4>
              <p class="text-white" data-animation="fadeInUp" data-delay="400ms" data-wow-duration="1000ms">第三代，真·无线</p><a class="btn btn-primary btn-sm" href="#" data-animation="fadeInUp" data-delay="800ms" data-wow-duration="1000ms">立即购买</a>
            </div>
          </div>
        </div>        
        <div class="single-hero-slide" style="background-image: url('img/bg-img/2.jpg')">
          <div class="slide-content h-100 d-flex align-items-center">
            <div class="container">
              <h4 class="text-white mb-0" data-animation="fadeInUp" data-delay="100ms" data-wow-duration="1000ms">烛光灯</h4>
              <p class="text-white" data-animation="fadeInUp" data-delay="400ms" data-wow-duration="1000ms">现在仅需22元</p><a class="btn btn-success btn-sm" href="#" data-animation="fadeInUp" data-delay="500ms" data-wow-duration="1000ms">立即购买</a>
            </div>
          </div>
        </div>
        <div class="single-hero-slide" style="background-image: url('img/bg-img/3.jpg')">
          <div class="slide-content h-100 d-flex align-items-center">
            <div class="container">
              <h4 class="text-white mb-0" data-animation="fadeInUp" data-delay="100ms" data-wow-duration="1000ms">年度最佳销售椅子</h4>
              <p class="text-white" data-animation="fadeInUp" data-delay="400ms" data-wow-duration="1000ms">三年保固</p><a class="btn btn-danger btn-sm" href="#" data-animation="fadeInUp" data-delay="800ms" data-wow-duration="1000ms">立即购买</a>
            </div>
          </div>
        </div>
      </div>
      
<%
//定义当前页显示数量
int pageSize = 4;
//获取类型的id
String type = request.getParameter("typeid") ;
if (type == null) {
	type = "3";
}
int typeid = Integer.parseInt(type); 
//查询出改类型id下的商品总数
DBHelper.getCount(typeid);
//获取页码
int totalpages = DBHelper.getTotalpages(pageSize);
String currentPage = request.getParameter("pageIndex");
if (currentPage == null) {
	currentPage = "1";
}
int pageIndex = Integer.parseInt(currentPage); 
if (pageIndex < 1) { 
	pageIndex = 1;
} else if (pageIndex > totalpages) {
	pageIndex = totalpages;                      
}
//根据类型id查询商品
String sql = "SELECT * FROM commodities t1 inner join commoditiestype t2 on t1.typeid=t2.typeid WHERE t1.typeid="+type+" AND state=TRUE Limit "+(pageIndex-1)*pageSize+","+pageSize;
List<Commodities> ls = DBHelper.Commodities(sql);
Commodities currentCommodity;
%>
      <!-- 商品类别 -->
      <div class="product-catagories-wrapper pt-3">
        <div class="container">
          <div class="section-heading">
            <h6 class="ml-1">商品类别</h6>
          </div>
          <div class="product-catagory-wrap">
            <div class="row">
              <div class="col-4">
                <div class="card mb-3 catagory-card">
                  <div class="card-body"><a href="index.jsp?typeid=<%=typeid=2%>"><i class="lni lni-island"></i><span>旅游</span></a></div>
                </div>
              </div>
  
              <div class="col-4">
                <div class="card mb-3 catagory-card">
                  <div class="card-body"><a href="index.jsp?typeid=<%=typeid=1%>"><i class="lni lni-tshirt"></i><span>服装</span></a></div>
                </div>
              </div>

              <div class="col-4">
                <div class="card mb-3 catagory-card">
                  <div class="card-body"><a href="index.jsp?typeid=<%=typeid=3%>"><i class="lni lni-tag"></i><span>其他</span></a></div>
                </div>
              </div>
            </div>
          </div>
        </div>
      </div>
      
      <!-- 商品展示 -->
      <div class="top-products-area clearfix">
        <div class="container">
          <div class="row">
            <!-- 商品 -->
            <%
				for (int i = 0; i < ls.size(); i++) {
					currentCommodity = ls.get(i) ;
					if(currentCommodity.getState()){
						
					
			%>
            <div class="col-6 col-sm-4 col-lg-3">
              <div class="card top-product-card mb-3">
                <div class="card-body">
                <a class="product-thumbnail d-block" href="detailed.jsp?src=<%=currentCommodity.getPicture()%>&name=<%=currentCommodity.getName()%>&cid=<%=currentCommodity.getCommodityid()%>&p=<%=currentCommodity.getPrice()%>">
                <img class="mb-2" src="<%=currentCommodity.getPicture()%>" alt="">
                </a>
                <a class="product-title d-block">
                <%=currentCommodity.getName()%>
                </a>
                  <p class="sale-price">￥<%=currentCommodity.getPrice()%></p>
                  <div class="product-rating">
                  <i class="lni lni-star-filled"></i>
                  <i class="lni lni-star-filled"></i>
                  <i class="lni lni-star-filled"></i>
                  <i class="lni lni-star-filled"></i>
                  <i class="lni lni-star-filled"></i>
                  </div>
                  <a href="addcart?uid=<%=uid%>&cid=<%=currentCommodity.getCommodityid()%>&typeid=<%=typeid%>&pageIndex=<%=pageIndex%>" class="btn btn-success btn-sm add2cart-notify">
                  <i class="lni lni-plus">
                  </i>
                  </a>
                </div>
              </div>
            </div>
            <%
					}
				}
			%>
          </div>
        </div>
      </div>
      <div class="text-center">
      	<%
      		//分页显示按钮
			if (pageIndex > 1) { 
		%>
		<a href="index.jsp?typeid=<%=typeid%>&pageIndex=1"><button type="button" class="btn btn-info">首页</button></a>
		<a href="index.jsp?typeid=<%=typeid%>&pageIndex=<%=pageIndex-1%>"><button type="button" class="btn btn-info">上一页</button></a>
		<%
			}
			if (pageIndex < totalpages) { 
		%>
		<a href="index.jsp?typeid=<%=typeid%>&pageIndex=<%=pageIndex+1%>"><button type="button" class="btn btn-info">下一页</button></a>
		<a href="index.jsp?typeid=<%=typeid%>&pageIndex=<%=totalpages%>"><button type="button" class="btn btn-info">末页</button></a>
		<%
			}
		%>
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