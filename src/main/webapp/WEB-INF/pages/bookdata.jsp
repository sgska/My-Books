<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c" %>
<%@ taglib uri="http://www.springframework.org/tags" prefix="spring" %>
<%@ taglib uri="http://www.springframework.org/tags/form" prefix="form" %>
<%@ page session="false" %>
<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<html>
<head>

    <!-- Bootstrap CSS -->
    <link rel="stylesheet" href="https://maxcdn.bootstrapcdn.com/bootstrap/4.0.0-alpha.4/css/bootstrap.min.css" integrity="2hfp1SzUoho7/TsGGGDaFdsuuDL0LX2hnUp6VkX3CUQ2K4K+xjboZdsXyp4oUHZj" crossorigin="anonymous">

    <title>Информация о книге ${book.title} </title>
</head>

<body>
<div class="container">
<h1>Название: ${book.title}</h1>
<br>
<table class="table table-bordered">
    <tr>
        <td class="bg-info">ID</td>
        <td>${book.id}</td>
    </tr>
    <tr>
        <td class="bg-info">Описание</td>
        <td>${book.description}</td>
    </tr>
    <tr>
        <td class="bg-info">Автор</td>
        <td>${book.author}</td>
    </tr>
    <tr>
        <td class="bg-info">ISBN</td>
        <td>${book.isbn}</td>
    </tr>
    <tr>
        <td class="bg-info" width="120">Год издания</td>
        <td>${book.printYear}</td>
    </tr>
    <tr>
        <td class="bg-info text-center">Состояние</td>
        <td>${book.readAlready ? "Прочтена" : "Не прочтена"}</td>
    </tr>

    <tr>
        <td colspan="2" align="center">
            <a href="/books"> <button class="btn">Назад</button></a>
        </td>
    </tr>

</h3>
</table>

</div>
</body>
</html>