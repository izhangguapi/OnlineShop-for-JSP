package com.JavaBean;

public class Sidebar {
	private static void sidebar() {

//		<!-- 左侧导航栏start -->
//	    <div class="suha-sidenav-wrapper" id="sidenavWrapper">
//	      <!-- 头像昵称 -->
//		<%
//			String nickname = "";
//			String uid = "";
//			Cookie[] cookies = request.getCookies();
//			if(cookies == null){
//				out.print("<script>alert('您还未登陆');</script>");
//			}else{
//				for(int i = 0 ;i < cookies.length ;i++){
//					if(cookies[i].getName().equals("nickname")){
//						nickname = cookies[i].getValue();
//					}else if(cookies[i].getName().equals("uid")){
//						uid = cookies[i].getValue();
//					}
//				}	
//			}
//		%> 
//	      <div class="sidenav-profile">
//	        <div class="user-profile"><img src="img/bg-img/9.jpg" alt=""></div>
//	        <div class="user-info">
//	          <h6 class="user-name mb-0"><%=nickname %></h6>
//	        </div>
//	      </div>
//	      <!-- 右边导航栏 -->
//	      <%
//	      	if(uid.equals("")){
//	      		
//	      %>
//	      <ul class="sidenav-nav">
//	        <li><a href="login.jsp"><i class="lni lni-pointer-up"></i>登录</a></li>
//	      </ul>
//	      <%
//	      	}else if (nickname.equals("")){
//	      		
//	      %>
//	      		<ul class="sidenav-nav">
//	            <li><a href="profile.jsp"><i class="lni lni-pointer-up"></i>修改个人资料</a></li>
//	          </ul>
//	       <%
//	      	}else{
//	      %>
//	      <ul class="sidenav-nav">
//	      <li><a href="profile.jsp"><i class="lni lni-pointer-up"></i>修改个人资料</a></li>
//	        <li><a href="pages.jsp"><i class="lni lni-empty-file"></i>我的订单</a></li>
//	        <%
//	        	//是管理员才能显示商品管理
//	        	if(nickname.equals("管理员")){
//	        %>
//	        <li><a href="wishlist-grid.jsp"><i class="lni lni-grid-alt"></i>商品管理</a></li>
//	        <%
//	        	}
//	        %>
//	        <li><a href="cart.jsp"><i class="lni lni-cart-full"></i>购物车</a></li>
//	        <li><a href="signout"><i class="lni lni-power-switch"></i>退出登录</a></li>
//	      </ul>
//	      <%
//	      	}
//	      %>
//	      <!-- 返回按钮 -->
//	      <div class="go-home-btn" id="goHomeBtn"><i class="lni lni-arrow-left"></i></div>
//	    </div>
//	    <!-- 左侧导航栏end -->
		
	}

}
