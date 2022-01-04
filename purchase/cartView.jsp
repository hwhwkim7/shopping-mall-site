<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ page import = "java.sql.*, my.util.*, my.dao.*, my.model.*, java.util.*,java.text.*" %>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<!DOCTYPE html PUBLIC "-//W3C//DTD XHTML 1.0 Transitional//EN" "http://www.w3.org/TR/xhtml1/DTD/xhtml1-transitional.dtd">
<html xmlns="http://www.w3.org/1999/xhtml">
<head>
<meta http-equiv="Content-Type" content="text/html; charset=utf-8" />
<title>카트</title>
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
  <div id="main">
  <div class="main_title">CART</div>
  <div class="mainContent"><table width="1000" height="58" border="0" align="center" cellpadding="10" class="listTable" id="carttable">
        <tr>
          <th width="20"></th>
          <th width="40" align="center">이미지</th>
          <th width="150" align="center">상품정보</th>
          <th width="65" align="center">판매가</th>
          <th width="39" align="center">수량</th>
          <th width="39" align="center">사이즈</th>          
          <th width="55" align="center">배송비</th>
          <th width="107" align="center">합계</th>
        </tr>
        
<%

Integer pCount=(Integer)session.getAttribute("pCount");	

if(pCount==null)
{
	pCount = new Integer(0);	
}    

Product product = null;
Cart cart = null;

int amount1 = 0;
int price = 0;
int totalPrice = 0;
int finaltotal = 0;
int size = 0;
Connection conn = ConnectionProvider.getConnection();
try {
	ProductDao dao = new ProductDao();
	for(int i=1; i<= pCount.intValue(); i++) {
     	cart = (Cart)session.getAttribute("p" + i);
     	amount1 = cart.getAmount();			
     	product = dao.selectById(conn, cart.getpId());
     	price = product.getPrice();
     	totalPrice = price*amount1;
     	finaltotal += totalPrice;
     	size = cart.getSize();

%>

		
        <c:set var="p" value="<%= product %>"/>
        <form>
        	<tr>
        		<td align="center"></td>
        		<td align="center">
        			<img src="/termproject/h/uploadImages/${ p.pImage1 }" width="60" height="100">
        		</td>
        		<td align="center">
        			${p.pName}
        		</td>
        		<td align="center">
        			${p.price}
        		</td>
        		<td align="center">
        			<%=amount1 %>
        		</td>
        		<td align="center">
        			<%=size %>
        		</td>
        		<td align="center">
        			2500
        		</td>
        		<td align="center">
        			<%=totalPrice+2500 %>
        		</td>
        	</tr>
     <% } %>
        
      </table>
      </form>

    <div class="button2"><input type="image" name="sendbtn" src="image/empty.png" width="100" height="30" onclick="cartDelete(form)"/></div>
    <div class="total"><table width="1000" align="center" cellpadding="3" cellspacing="0" id="totalTable">
  <tr>
    <td width="224" height="50" align="center">총 상품금액</td>
    <td width="374" height="50" align="center">총 배송비</td>
    <td width="322" height="50" align="center">결제예정금액</td>
  </tr>
  <tr>
    <td width="224" height="50" align="center"><%= finaltotal %></td>
    <td width="374" height="50" align="center">2500</td>
    <td width="322" height="50" align="center"><%=finaltotal +2500%></td>	
  </tr>

</table>
 <div class="purchase_btn"><button type="button" class="btn_image" id="img_btn" onclick="cartAllOrder1(form)" align="right"><img src="../image/allOrder.png" width="100" height="31"></button></div>
    
      </div>
  </div>
<% 
} catch (SQLException e) {
} finally {
	JdbcUtil.close(conn);	
} %>
 <div id="top_btn"><a href="#"> <input class="top" type="image" value="" src="/termproject/h/login/image/top.png"/></a></div>
  <div id="footer">
    <div class="footer"><img src="image/footer.png" width="436" height="137" /></div>
  </div>
</div>
<script type="text/javascript">
var MenuBar1 = new Spry.Widget.MenuBar("MenuBar1", {imgDown:"../SpryAssets/SpryMenuBarDownHover.gif", imgRight:"../SpryAssets/SpryMenuBarRightHover.gif"});
var MenuBar2 = new Spry.Widget.MenuBar("MenuBar2", {imgRight:"../SpryAssets/SpryMenuBarRightHover.gif"});

function cartDelete(form){
	if(confirm("카트를 모두 비우시겠습니까?")==true) {
		document.location.href="/termproject/h/purchase/cartDelete1.jsp";
	} else {
		history.back(-1);
	}
}

function cartAllOrder1(form){
	document.location.href="/termproject/h/purchase/purchase.jsp";
}
</script>
</body>
</html>
