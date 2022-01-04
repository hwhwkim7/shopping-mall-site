<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>카트 전체 삭제</title>
</head>
<body>

<%
	int count = ((Integer)session.getAttribute("pCount")).intValue();
	for (int i = 1; i <= count; i++) {
		session.removeAttribute("p"+i);
	}
	session.removeAttribute("pCount");		
	response.sendRedirect("/termproject/h/main/main_member.jsp");
%>

</body>
</html>