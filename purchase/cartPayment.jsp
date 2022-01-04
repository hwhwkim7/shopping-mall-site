<%@page import="java.text.SimpleDateFormat"%>
<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ page import = "java.sql.*, my.util.*, my.dao.*, my.model.*, java.util.*, java.text.*" %>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>Insert title here</title>
</head>
<body>

<%
	request.setCharacterEncoding("utf-8");
	String mId = (String)session.getAttribute("MID");
	String cardCompany = request.getParameter("cardCompany");
	String cardNumber = request.getParameter("cardNumber");
	String validDate = request.getParameter("validDate");
	SimpleDateFormat sdf = new SimpleDateFormat("MM/yyyy");	
	java.util.Date vd = sdf.parse(validDate);				
	int finaltotal = Integer.parseInt(request.getParameter("finaltotal"));	
	java.util.Date payDate = new java.util.Date();			
	
	Payment pmt = new Payment(mId, cardCompany, cardNumber, vd, finaltotal, payDate);		
    int pId = 0;
    int amount = 0;
    int price = 0;
    int size = 0;
    
	Connection conn = ConnectionProvider.getConnection();

     try {
        SaleDao sdao = new SaleDao();
        ProductDao pdao = new ProductDao();
        Integer pCount = (Integer)session.getAttribute("pCount");      
        int count = pCount.intValue();
        for (int i = 1; i <= count; i++) {
           Cart cart = (Cart)session.getAttribute("p"+i);   
           if(cart != null) {
	           pId = cart.getpId();
	           amount = cart.getAmount();
	           price = pdao.selectById(conn, pId).getPrice();
	           Sale sale = new Sale(mId, pId, amount, size, price*amount, new java.util.Date());
	           sdao.insert(conn, sale);  
	           pdao.incPcount(conn, pId);  
           }
        }
		PaymentDao dao = new PaymentDao();
		dao.insert(conn, pmt);
	}catch (SQLException e) {}
     int count = ((Integer)session.getAttribute("pCount")).intValue();
 	for (int i = 1; i <= count; i++) {
 		session.removeAttribute("p"+i);
 	}
 	session.removeAttribute("pCount");
%>

<script type="text/javascript">
   alert("구매가 완료되었습니다.");
   document.location.href="/termproject/h/main/main_member.jsp";
</script>

</body>
</html>