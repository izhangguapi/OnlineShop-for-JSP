<%@page import="com.JavaBean.DBHelper" %>
<%@page import="com.JavaBean.Users" %>
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
    <title>个人信息</title>
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
          <h6 class="mb-0">个人信息</h6>
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
    <div class="page-content-wrapper">
      <div class="container">
        <!-- Profile Wrapper-->
        <div class="profile-wrapper-area py-3">
          <!-- User Information-->
          <div class="card user-info-card">
            <div class="card-body p-4 d-flex align-items-center">
              <div class="user-profile mr-3"><img src="img/bg-img/9.jpg" alt="">
                <div class="change-user-thumb">	
                </div>
              </div>
              <div class="user-info">
                <p class="mb-0 text-white">用户ID</p>
                <h5 class="mb-0"><%=uid%></h5>
              </div>
            </div>
          </div>
          <!-- 用户信息 -->
          <div class="card user-data-card">
            <div class="card-body">
              <form action="doprofile" method="POST">
                <div class="form-group">
                  <div class="title mb-2"><i class="lni lni-user"></i><span>昵称</span></div>
                  <input class="form-control" name="nickname" type="text" disabled="disabled" value="<%=currentProfile.getNickname()%>">
                </div>
                <div class="form-group">
                  <div class="title mb-2"><i class="lni lni-user"></i><span>真实姓名</span></div>
                  <input class="form-control" name="name" type="text" disabled="disabled" value="<%=currentProfile.getName()%>">
                </div>
                <div class="form-group">
                  <div class="title mb-2"><i class="lni lni-phone"></i><span>电话</span></div>
                  <input class="form-control" name="telephone" type="text" disabled="disabled" value="<%=currentProfile.getTelephone()%>">
                </div>
                <div class="form-group">
                  <div class="title mb-2"><i class="lni lni-envelope"></i><span>邮箱</span></div>
                  <input class="form-control" name="mail" type="email" disabled="disabled" value="<%=currentProfile.getMail()%>">
                </div>
                <div class="form-group">
                  <div class="title mb-2"><i class="lni lni-map-marker"></i><span>地址</span></div>
                  <input class="form-control" name="address" type="text" disabled="disabled" value="<%=currentProfile.getAddress()%>">
                </div>
                
                 
				<div class="form-group">
				<div class="single-settings d-flex align-items-center justify-content-between">
                <div class="title"><i class="lni lni-night"></i><span>夜间模式</span></div>
                <div class="data-content">
                  <div class="toggle-button-cover">
                    <div class="button r">
                      <input class="checkbox" id="darkSwitch" type="checkbox">
                      <div class="knobs"></div>
                      <div class="layer"></div>
                    </div>
                  </div>
                </div>
              </div>
			</div>

              
              
                <button id="save" style="display:none;" class="btn btn-success w-100" type="submit">保存修改</button>
              </form>
              <button id="edito" style="display:block;" class="btn btn-info w-100">修改</button>
            </div>
          </div>
        </div>
      </div>
    </div>
	<script>
		var a = document.getElementsByTagName("input");
		document.getElementById("edito").onclick = function() {
			//document.getElementById("save").style.display = "block";
			document.getElementById("save").removeAttribute("style");
			document.getElementById("edito").style.display = "none";
			for (var i=0;i<5;i++){ 
				a[i].removeAttribute("disabled");
			}
		}
	</script>
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