<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>
<%@ page
	import="java.util.*,javax.servlet.http.*,dbutil.*,entity.*,model.*,java.io.*,java.sql.*,javax.servlet.*,org.apache.poi.ss.usermodel.*"%>


<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>通过excel文件批量添加</title>
</head>
<body>

	<form action="${pageContext.request.contextPath }/uploadServlet"
		method="post" enctype="multipart/form-data">
		<input type="file" name="excelFile"
			accept=".xls, .xlsx"/>
		<input type="submit" value="上传">
	</form>
</body>
</html>