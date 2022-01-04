<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ page import="java.sql.*, my.util.*, my.dao.*, my.model.*, java.util.*" %>
<%@ page import="java.io.File"%>
<%@ page import="java.util.Enumeration"%>
<%@ page import="com.oreilly.servlet.MultipartRequest" %>
<%@page import="com.oreilly.servlet.multipart.DefaultFileRenamePolicy"%>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>Insert title here</title>
</head>
<body>
<%
       String uploadPath="C:\\termproject\\uploadImages";
       int maxSize =1024 *1024 *10; 
       
       String pName = "";
       int price =0;
       String pImage1 = "";   
       String pImage2 = "";  
       String pImage3 = "";  
       String pImage4 = "";  
       String pImage5 = "";  
       String pImage6 = "";  
       String pImage7 = "";  
       String pImage8 = ""; 
       String pImage9 = "";
       int pCategory = 0;
       MultipartRequest multi =null;
        
       try{
           multi =new MultipartRequest(request,uploadPath,maxSize,"utf-8",new DefaultFileRenamePolicy());  
           pName = multi.getParameter("product_name");
           price = Integer.parseInt(multi.getParameter("product_price")); 
           pImage1 = multi.getFilesystemName("detail_image1"); 
           pImage2 = multi.getFilesystemName("detail_image2");
           pImage3 = multi.getFilesystemName("detail_image3");
           pImage4 = multi.getFilesystemName("detail_image4");
           pImage5 = multi.getFilesystemName("detail_image5");
           pImage6 = multi.getFilesystemName("detail_image6");
           pImage7 = multi.getFilesystemName("detail_image7");
           pImage8 = multi.getFilesystemName("detail_image8");
           pImage9 = multi.getFilesystemName("detail_image9");
           pCategory = Integer.parseInt(multi.getParameter("category"));
           Connection conn = ConnectionProvider.getConnection();
           ProductDao dao = new ProductDao();
           Product product = new Product(0, pName, price, new java.util.Date(), pImage1, pImage2, pImage3, pImage4, pImage5, pImage6, pImage7, pImage8, pImage9, pCategory);
           dao.insert(conn, product);
       } catch(Exception e){}
%>

</body>
<script type="text/javascript">
   alert("상품 정보를 업로드하였습니다.");
   document.location.href="productList.jsp";
</script>
</html>