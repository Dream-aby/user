<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>
<!DOCTYPE HTML PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN">
<html>
<head>
<title>上传数据</title>
</head>
<body>
	<h1 id="msg"></h1>
	<script type="text/javascript">
		let msg = "${msg}";
		let msgDom = document.getElementById("msg");
		msgDom.innerHTML = msg;
	</script>
	<form action="allShow.jsp">
		<input type="submit" value="显示所有用户">
	</form>
</body>
</html>
