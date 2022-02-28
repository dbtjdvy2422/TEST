<%--
  Created by IntelliJ IDEA.
  User: yuseongpyo
  Date: 2022/02/17
  Time: 2:44 PM
  To change this template use File | Settings | File Templates.
--%>
<%@ page contentType="text/html;charset=UTF-8" language="java" pageEncoding="UTF-8" %>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c" %>
<%@ taglib uri="http://java.sun.com/jsp/jstl/fmt" prefix="fmt" %>

<!DOCTYPE html PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN" "http://www.w3.org/TR/html4/loose.dtd">
<%@ taglib prefix="sec" uri="http://www.springframework.org/security/tags" %>
<html>
<head>
    <title>Title</title>
</head>
<body>

<h1>access denied page</h1>

<h2> <c:out value="${SPRING_SECURITY_403_EXCEPTION.getMessage()}"/> </h2>
<h2> <c:out value="${msg}"/></h2>
</body>
</html>
