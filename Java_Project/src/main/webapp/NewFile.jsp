<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>Insert title here</title>
</head>
<body>
<form action="add" method="post">
Name: <input type="text" name="name"/>
Age: <input type="text" name="age"/><br>
<input type="submit"/>
<%
String message=(String) request.getAttribute("message");
if(message!=null){%>
	<h3><%= message %></h3>	
<% }
%>
</form>
</body>
</html>