<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ page import = "java.sql.*, my.util.*, my.dao.*, my.model.*, java.util.*" %>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<!DOCTYPE html PUBLIC "-//W3C//DTD XHTML 1.0 Transitional//EN" "http://www.w3.org/TR/xhtml1/DTD/xhtml1-transitional.dtd">
<html xmlns="http://www.w3.org/1999/xhtml">
<head>
<meta http-equiv="Content-Type" content="text/html; charset=utf-8" />
<title>결제</title>
<link href="layout.css" rel="stylesheet" type="text/css" />
<link href="../SpryAssets/SpryMenuBarHorizontal.css" rel="stylesheet" type="text/css" />
<script src="../SpryAssets/SpryMenuBar.js" type="text/javascript"></script>
</head>

<body>
<div id="wrap">
  <div id="page_header">
    <div class="logo"><a href="/termproject/h/main/main_member.jsp"><img src="image/logo.jpg" width="200" height="50" /></a></div>
    <div class="login"><%
   		 String mId = (String)session.getAttribute("MID");
    
    	if (mId.equals("admin")){
    %>
    		<a href="../admin/productList.jsp">
    <%		
    	} else{
    %>
  	  <a href="../mypage/mypage.jsp">
  	 <%} %> 
  	  <%= mId %>님</a> &nbsp;&nbsp;&nbsp;
    					<a href="/termproject/h/login/logout.jsp">로그아웃</a>&nbsp;&nbsp;&nbsp;
    					<a href="../purchase/cartView.jsp"><img src="image/cart1.jpg" width="20" height="20" align="right" /></a></div>
     <form action="/termproject/h/product/itemList_member.jsp" method="get">
     <div class="search">
     <select name="target">               
         <option value="pName">상품명</option>
         <option value="pId">상품번호</option>
      </select>
      <div class="search_txt">
        <label for="search"></label>
        <input type="text" name="keyword" id="keyword" align="right" />
      </div>
      <div class="search_img"><input type="image" name="search" src="image/search.jpg" width="20" height="20"/></div>
    </div>
    </form>

  </div>
  <div class="menu_bar">
    <ul id="MenuBar1" class="MenuBarHorizontal">
   	  <li><a href="/termproject/h/product/itemList_member.jsp">ALL products</a></li>
      <li><a href="/termproject/h/product/bestProduct_member.jsp">Best seller</a></li>
      <li><a href="/termproject/h/product/newProduct_member.jsp">New arrivals</a></li>
      <li><a href="/termproject/h/product/shoes_member.jsp">Shoes</a></li>
      <li><a href="/termproject/h/product/bag_member.jsp">Bag</a></li>
    </ul>
  </div>
  <div id="head_image"><img src="image/archivepke8_02.png" width="1200" height="240" /></div>
  
   <%
   

   		request.setCharacterEncoding("utf-8");        		  		
  		int price = 0;
  		int totalPrice = 0;
  		int finaltotal = 0;
  		Connection conn = ConnectionProvider.getConnection();
  	  try {
  		  
  	  	ProductDao pdao = new ProductDao();
  	  	Product product = new Product();
  	  	
  	  	Integer pCount = (Integer)session.getAttribute("pCount");			//session 내에 들어가있는 pCount 가져오기, 저장할 때 Integer객체로 저장했으니까 저렇게 적는 거
  	  	int count = pCount.intValue();
  	  	for (int i = 1; i <= count; i++) {
  	  		Cart cart = (Cart)session.getAttribute("p"+i);		//cart 에 있는 애 하나 꺼내서 product정보와 amount정보 알아내기
  	  		if(cart != null) {
  	      		int pId = cart.getpId();
  	      		int amount = cart.getAmount();
  	      		price = pdao.selectById(conn, pId).getPrice();
  	     	    totalPrice = price*amount;
  	      	  	finaltotal += totalPrice;
  	  		}
  	  	}

        %>
  
  <div id="main">
  <div class="main_title">ORDER</div>
  <div class="mainContent">
    <div class="order_title"></div>
<form action="cartPayment.jsp" method="post">
<table width="1000" height="58" border="0" align="center" cellpadding="10" class="listTable" id="ordertable">        			<tr><th>고객아이디</th>
        				<td><%=session.getAttribute("MID")%></td>
        			</tr>
        			<tr><th>카드사</th>
        				<td><input type="text" name="cardCompany" value="VISA"></td>
        			</tr>
        			<tr><th>카드번호</th>
        				<td><input type="text" name="cardNumber" value="0000-1111-2222-3333"></td>
        			</tr>
        			<tr><th>유효기간</th>
        				<td><input type="text" name="validDate" value="11/2021"></td>
        			</tr>
        			<tr><th>지불금액</th>
        				<td><%= finaltotal+2500 %></td>
        				<input type="hidden" name="finaltotal" value=<%= finaltotal+2500 %>>
        			</tr>
</form>        
        			
        			<tr><td colspan="2" height="50"><input type="image" name="sendbtn" src="image/purchase.png" width="250" height="59" align="right"/></td></tr>	
        		</table>

    
      </div>
  </div>
  <%
  	  		} catch (SQLException e) {
	} 
  %>
   <div id="top_btn"><a href="#"> <input class="top" type="image" value="" src="/termproject/h/login/image/top.png"/></a></div>
  <div id="footer">
    <div class="footer"><img src="image/footer.png" width="436" height="137" /></div>
  </div>
</div>
<script type="text/javascript">
var MenuBar1 = new Spry.Widget.MenuBar("MenuBar1", {imgDown:"../SpryAssets/SpryMenuBarDownHover.gif", imgRight:"../SpryAssets/SpryMenuBarRightHover.gif"});
var MenuBar2 = new Spry.Widget.MenuBar("MenuBar2", {imgRight:"../SpryAssets/SpryMenuBarRightHover.gif"});

</script>
</body>
</html>
