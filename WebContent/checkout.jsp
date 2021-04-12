<%@page import="com.JavaBean.Users" %>
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
    <!-- The above 4 meta tags *must* come first in the head; any other head content must come *after* these tags-->
    <!-- Title-->
    <title>确认订单</title>
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
          <h6 class="mb-0">确认订单</h6>
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
        <!-- Checkout Wrapper-->
        <div class="checkout-wrapper-area py-3">
          <!-- Billing Address-->
          <div class="billing-information-card mb-3">
            <div class="card billing-information-title-card bg-danger">
              <div class="card-body">
                <h6 class="text-center mb-0 text-white">收货信息</h6>
              </div>
            </div>
            
	          <%
	          	String sql = "SELECT * FROM users WHERE userid='"+uid+"'";
				List<Users> ls = DBHelper.Profile(sql);
				Users currentProfile = new Users();
				try{
					currentProfile = ls.get(0);
				}catch (Exception e) {
					out.print("<script>alert('您还未登录');window.location='login.jsp'</script>");
				}finally {
					
				}
				//out.println("<script>alert('"+currentProfile.getNickname()+"');</script>");
	          %>
            <div class="card user-data-card">
              <div class="card-body">
              <div class="single-profile-data d-flex align-items-center justify-content-between">
                  <div class="title d-flex align-items-center"><i class="lni lni-envelope"></i><span>订单号</span></div>
                  	<%
		            String oid = "";
		            try{
		            	oid = request.getParameter("oid");
		            }catch (Exception e) {
		    			out.print("<script>alert('订单编号获取失败');window.location='index.jsp'</script>");
		    		}
		            %>
                  <div class="data-content"><%=oid%></div>
                </div>                                   
                <div class="single-profile-data d-flex align-items-center justify-content-between">
                  <div class="title d-flex align-items-center"><i class="lni lni-user"></i><span>姓名</span></div>
                  <div class="data-content"><%=currentProfile.getName()%></div>
                </div>
                
                <div class="single-profile-data d-flex align-items-center justify-content-between">
                  <div class="title d-flex align-items-center"><i class="lni lni-phone"></i><span>电话</span></div>
                  <div class="data-content"><%=currentProfile.getTelephone()%></div>
                </div>
                <div class="single-profile-data d-flex align-items-center justify-content-between">
                  <div class="title d-flex align-items-center"><i class="lni lni-map-marker"></i><span>收货地址</span></div>
                  <div class="data-content"><%=currentProfile.getAddress()%></div>
                </div>
                <a class="btn btn-danger w-100" href="profile.jsp">修改收货信息</a>
              </div>
            </div>
          </div>
          <!-- Shipping Method Choose-->
          <div class="shipping-method-choose mb-3">
            <div class="card shipping-method-choose-title-card bg-success">
              <div class="card-body">
                <h6 class="text-center mb-0 text-white">付款方式</h6>
              </div>
            </div>
            <div class="card shipping-method-choose-card">
              <div class="card-body">
                <div class="shipping-method-choose">
                  <ul>
                    <li>
                      <input id="Alipay" type="radio" name="selector" checked>
                      <label for="Alipay">支付宝</label>
                      <div class="check"></div>
                    </li>
                    <li>
                      <input id="WeChatPay" type="radio" name="selector">
                      <label for="WeChatPay">微信</label>
                      <div class="check"></div>
                    </li>
                    <li>
                      <input id="courier" type="radio" name="selector">
                      <label for="courier">货到付款</label>
                      <div class="check"></div>
                    </li>
                  </ul>
                </div>
              </div>
            </div>
          </div>

          <div class="card cart-amount-area">
            <div class="card-body d-flex align-items-center justify-content-between">
            <%
            Double p = 0.0;
            try{
            	p = Double.parseDouble(request.getParameter("p"));
            }catch (Exception e) {
    			out.print("<script>alert('价格获取失败');window.location='index.jsp'</script>");
    		}
            %>
              <h5 class="total-price mb-0">￥<span class="counter"><%=p %></span></h5><a class="btn btn-warning" href="okpay?oid=<%=oid%>" >付款</a>
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