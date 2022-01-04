<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ page import = "java.sql.*, my.util.*, my.dao.*, my.model.*, java.util.*" %>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<!DOCTYPE html PUBLIC "-//W3C//DTD XHTML 1.0 Transitional//EN" "http://www.w3.org/TR/xhtml1/DTD/xhtml1-transitional.dtd">
<html xmlns="http://www.w3.org/1999/xhtml">
<head>
<meta http-equiv="Content-Type" content="text/html; charset=utf-8" />
<title>인기상품</title>
<link href="layout.css" rel="stylesheet" type="text/css" />
<link href="../SpryAssets/SpryMenuBarHorizontal.css" rel="stylesheet" type="text/css" />
<style type="text/css">
a:link {
   text-decoration: none;
   color: #000;
}
a:visited {
   text-decoration: none;
   color: #000;
}
a:hover {
   text-decoration: none;
   color: #000;
}
a:active {
   text-decoration: none;
   color: #000;
}
body,td,th {
   color: #000;
}
</style>
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
  <div id="main">
    <div class="listname"><strong>
      <h2>Best seller</h2>
    </strong></div>

    
<%    


	String pageNumberStr = request.getParameter("page");		
	int pageNumber = 1;										
	if (pageNumberStr != null) {	
		pageNumber = Integer.parseInt(pageNumberStr);			
	}
	ProductListView viewData = null;
	Connection conn = ConnectionProvider.getConnection();
 	List<Product> products = null;

	String orderby = request.getParameter("orderby");	
 try {
	 orderby = "pCount";
 	ProductDao dao = new ProductDao();
 	viewData = dao.getProductList(pageNumber, conn, 0, orderby);
 	products = viewData.getProductList();


 }catch (SQLException e) {
	 
 }finally {
		JdbcUtil.close(conn);		
	}
     if (products != null) {
%>     
    
    <c:forEach var="product" items="<%= products %>">
    <form action="itemdetail.jsp" name="frm">
    <div class="product">
      <div class="productpic"><a href="itemdetail_member.jsp?pId=${product.pId}"><img src="/termproject/h/uploadImages/${ product.pImage1 }" width="230" height="300" /></div>
    <span class="price"><p>${ product.pName }</p><p>${ product.price }원</p></a></span></div>
    </form>
    </c:forEach>
  </div>

 <%         } %>
<c:forEach var="i" begin="1" end="<%= viewData.getPageTotalCount() %>">			
	<input type="button" value="${ i }" onclick="location.href='bestProduct_member.jsp?page=${i}'">  
</c:forEach>
 <div id="top_btn"><a href="#"> <input class="top" type="image" value="" src="/termproject/h/login/image/top.png"/></a></div>
  <div id="footer">
    <div class="footer"><img src="image/footer.png" width="436" height="137" /></div>
  </div>
</div>
<script type="text/javascript">
var MenuBar1 = new Spry.Widget.MenuBar("MenuBar1", {imgDown:"../SpryAssets/SpryMenuBarDownHover.gif", imgRight:"../SpryAssets/SpryMenuBarRightHover.gif"});

function detailView1(frm){
   var amount = frm.amount.value.trim();
   var id = frm.pid.value.trim(); 
   window.open("itemdetail.html.jsp?pId="+id,"","width=300, height=400");
}
</script>
</body>
</html>