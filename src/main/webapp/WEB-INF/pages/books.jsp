<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c" %>
<%@ taglib uri="http://www.springframework.org/tags" prefix="spring" %>
<%@ taglib uri="http://www.springframework.org/tags/form" prefix="form" %>
<%@ taglib prefix="from" uri="http://www.springframework.org/tags/form" %>
<%@ page session="false" %>
<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<%@page pageEncoding="utf-8" %>
<html>
<head>
    <!-- Bootstrap CSS -->
    <link rel="stylesheet" href="https://maxcdn.bootstrapcdn.com/bootstrap/4.0.0-alpha.4/css/bootstrap.min.css" integrity="2hfp1SzUoho7/TsGGGDaFdsuuDL0LX2hnUp6VkX3CUQ2K4K+xjboZdsXyp4oUHZj" crossorigin="anonymous">
    <title>My Books</title>
</head>

<div class="container">
    <%--<c:if test="${!randomBook.title == null}">--%>
    <c:if test="${booksSize != 0 && empty book.title}">
        <table class="table table-striped">
        <thead>
        <tr>
        <c:url var="addAction" value="/books/search"/>
        <form:form cssClass="form-inline bg-infog" action="${addAction}" commandName="book">
            <td>
                <input  class="form-control" type="text" name="searchTitle" id="searchTitle"
                                      placeholder="Пример поиска: ${randomBook.title}"/>
            </td>
            <td>
                <input class="btn" type="submit" value="<spring:message text="Поиск"/>"/>
            </td>
            <td align="right" style="width: 33%">
                <h3>Всего книг в базе: ${booksSize}</h3>
            </td>
        </form:form>
        </tr>


</table>

         <c:if test="${!empty listBooks}">
         <table class="table table-bordered table-hover">
        <thead>
        <tr>
            <th class="bg-info text-center" width="40">ID</th>
            <th class="bg-info">Название</th>
            <th class="bg-info">Описание</th>
            <th class="bg-info">Автор</th>
            <th class="bg-info">ISBN</th>
            <th class="bg-info">Год издания</th>
            <th class="bg-info">Состояние</th>
            <th class="bg-info">Действия</th>
        </tr>
        </thead>
        <tbody>
        <c:forEach items="${listBooks}" var="book">
            <tr>
                <td>${book.id}</td>
                <td><a href="/bookdata/${book.id}">${book.title}</a></td>
                <td class="size">${book.shortDescription}</td>
                <td>${book.author}</td>
                <td>${book.isbn}</td>
                <td>${book.printYear == 0 ? "" : book.printYear}</td>
                <td>${book.readAlready ? "Прочитано" : "Не прочитано"}</td>
                <td>
                    <a href="<c:url value='/edit/${book.id}'/>">Изменить</a>
                    <a href="<c:url value='/remove/${book.id}'/>">Удалить</a>
                    <a href="<c:url value='/makeread/${book.id}'/>">${!book.readAlready ? "Прочитано" : ""}</a>
                </td>



            </tr>
        </c:forEach>
        </tbody>
    </table>
        </c:if>
        <div align="right"><h4>
    <c:url value="${currentsort}" var="prev">
        <c:param name="page" value="${page-1}"/>
    </c:url>
    <c:if test="${page > 1}">
        <a href="<c:out value="${prev}" />">Назад</a>
    </c:if>

    <c:forEach begin="1" end="${maxPages}" step="1" varStatus="i">
        <c:choose>
            <c:when test="${page == i.index}">
                <span>${i.index}</span>
            </c:when>
            <c:otherwise>
                <c:url value="${currentsort}" var="url">
                    <c:param name="page" value="${i.index}"/>
                </c:url>
                <a href='<c:out value="${url}" />'>${i.index}</a>
            </c:otherwise>
        </c:choose>
    </c:forEach>
    <c:url value="${currentsort}" var="next">
        <c:param name="page" value="${page + 1}"/>
    </c:url>
    <c:if test="${page + 1 <= maxPages}">
        <a href='<c:out value="${next}" />'>Вперед</a>
    </c:if>
    </div></h4>
    </c:if>
    <%--</c:if>--%>
    <h2>
        <c:if test="${!empty book.title}">
            Редактировать книгу
        </c:if>
        <c:if test="${empty book.title}">
            Добавить книгу
        </c:if>
    </h2>


    <table class="table">
        <td>
            <c:url var="addAction" value="/books/add"/>

            <form:form  action="${addAction}" commandName="book">
                <table class="table">
                    <c:if test="${!empty book.title}">
                        <tr hidden="hidden">
                            <td >
                                <form:label  path="id">
                                    <spring:message text="ID"/>
                                </form:label>
                            </td>
                            <td>
                                <form:hidden path="id"/>
                            </td>
                        </tr>

                    </c:if>


                    <tr>
                        <td style="width: 15%">
                            <form:label path="title">
                                <spring:message text="Название"/>
                            </form:label>
                        </td>
                        <td>
                            <form:input path="title" class="form-control" />
                        </td>
                    </tr>


                    <tr>
                        <td>
                            <form:label path="description">
                                <spring:message text="Описание"/>
                            </form:label>
                        </td>
                        <td>
                            <form:textarea path="description" class="form-control" rows="6" />
                        </td>
                    </tr>


                    <tr>
                        <td>
                            <form:label path="author">
                                <spring:message text="Автор"/>
                            </form:label>
                        </td>


                        <c:if test="${!empty book.title}">
                            <td>
                                <form:input path="author" readonly="true" disabled="true" class="form-control" />
                                <form:hidden path="author"/>
                            </td>
                        </c:if>
                        <c:if test="${empty book.title}">
                            <td>
                                <form:input path="author" class="form-control" />
                            </td>
                        </c:if>
                    </tr>


                    <tr>
                        <td>
                            <form:label path="isbn">
                                <spring:message text="ISBN"/>
                            </form:label>
                        </td>
                        <td>
                            <form:input path="isbn" class="form-control" type="number"/>
                        </td>
                    </tr>


                    <tr>
                        <td>
                            <form:label path="printYear">
                                <spring:message text="Год издания"/>
                            </form:label>
                        </td>
                        <td>
                            <form:input path="printYear" class="form-control" type="number"/>
                        </td>
                    </tr>


                    <tr>
                        <td colspan="2" align="center">
                            <c:if test="${!empty book.title}">
                                <input class="btn" type="submit"
                                       value="<spring:message text="Изменить данные"/>"/>
                            </c:if>
                            <c:if test="${empty book.title}">
                                <input class="btn" type="submit"
                                       value="<spring:message text="Добавить книгу"/>"/>
                            </c:if>
                        </td>
                    </tr>
                </table>
            </form:form>
        </td>
    </table>

</div>
</html>
