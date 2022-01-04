<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>Insert title here</title>
</head>
<body>

<%
	int pId = Integer.parseInt(request.getParameter("pId"));
	int size = Integer.parseInt(request.getParameter("size"));
	int amount = Integer.parseInt(request.getParameter("amount"));
%>

<script>
	if(confirm("카트에 담으시겠습니까?")==true) {
		document.location.href="/termproject/h/purchase/cart.jsp?pId=<%=pId%>&amount=<%=amount%>&size=<%=size%>";
	} else {
		document.location.href="/termproject/h/product/itemdetail.jsp?pId=<%=pId%>";
	}
	
</script>
</body>
</html>