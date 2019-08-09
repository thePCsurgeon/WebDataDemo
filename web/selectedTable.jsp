<%@taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
<%@taglib prefix="sql" uri="http://java.sun.com/jsp/jstl/sql"%>
<%-- 
    Document   : selectedTable
    Created on : Jun 18, 2018, 8:09:17 PM
    Author     : James B Carlton
--%>
<sql:query var="result" dataSource="jdbc/myDatasource">
    SELECT *  FROM <%= request.getParameter("TblSel")%> <%-- this SQL Query pulls up the entire table  of results from the table that is currently selected. --%>
</sql:query>
<c:set var ="target" scope="session" value="<%= request.getParameter("TblSel")%>"/> <%-- this sets a varriable that will be used later to perform the selected action on the table selected. --%>
<c:set var = "action" scope = "request" value = "<%= request.getParameter("action")%>" /> <%-- this variable is used to specifiy the action that will be excecuted.--%>
    
<c:choose> <%-- this choose staement is like a switch statement in java. It will switch to the applicable action based on the users submission.--%> 
        <c:when test="${action == 'update'}"> 
            <sql:update var="updated" dataSource="jdbc/myDatasource">
                UPDATE <%= request.getParameter("TblSel")%>
                SET ${result.columnNames[0]} = "<%= request.getParameter("item1")%>", ${result.columnNames[1]} ="<%= request.getParameter("item2")%>", ${result.columnNames[2]} ="<%= request.getParameter("item3")%>", ${result.columnNames[3]} ="<%= request.getParameter("item4")%>"
                WHERE ${result.columnNames[0]} = "<%= request.getParameter("item1")%>"
            </sql:update>
        </c:when>
                <c:when test="${action == 'insert' }">
                    <sql:update var="inserted" dataSource="jdbc/myDatasource">
                        INSERT INTO <%= request.getParameter("TblSel")%> (${result.columnNames[0]},${result.columnNames[1]},${result.columnNames[2]},${result.columnNames[3]})
                        VALUES ("<%= request.getParameter("item1")%>", "<%= request.getParameter("item2")%>", "<%= request.getParameter("item3")%>", "<%= request.getParameter("item4")%>")
                    </sql:update>
        </c:when>
        <c:when test="${action == 'delete' }">
            <sql:update var="deleted" dataSource="jdbc/myDatasource">
                DELETE FROM <%= request.getParameter("TblSel")%>
                WHERE ${result.columnNames[0]} = "<%= request.getParameter("item1")%>"
            </sql:update>
        </c:when>
    </c:choose>

<%@page contentType="text/html" pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html>
    <head>
        <meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
        <title><strong>Table view and modify</strong></title>
    </head>
    <body> <p>Current Table: <c:out value = "${target}"/> </p>
        <table border="1"> <%-- Displayes all the current results for the table selected --%>
            <!-- column headers -->
            <tr>
            <c:forEach var="columnName" items="${result.columnNames}">
                <th><c:out value="${columnName}"/></th>
            </c:forEach>
        </tr>
        <!-- column data -->
        <c:forEach var="row" items="${result.rowsByIndex}"> 
            <tr>
            <c:forEach var="column" items="${row}">
                <td><c:out value="${column}"/></td>
            </c:forEach>
            </tr>
        </c:forEach>
        </table>

            <form name="testSelf" action="selectedTable.jsp"><%-- this form will allow the user to Refresh the page to view changes as well as submnit
                                                                any new changes. They can use this for to change which table is being viewed as well.--%>
                
                 <c:set var = "table" scope = "request" value = "<%= request.getParameter("TblSel")%>" />
                 
                 <p>Selected Table(use the refresh action after changing the selected table)</p>
                        <c:choose> <%-- used to select the table that the user wants to veiw and or edit. --%>
                            <c:when test="${table == 'customer' }">
                        Customer<input type="radio" name="TblSel" value="customer" checked='true'/> 
            <br />Product <input type="radio" name="TblSel" value="product" />
                            </c:when>
                            <c:when test="${table == 'product' }">
                        <br />Customer<input type="radio" name="TblSel" value="customer" /> 
            <br />Product <input type="radio" name="TblSel" value="product" checked='true'  />
                            </c:when>
                        </c:choose>
            <br /> <br />Please use the drop down to select and action. If updating/inserting all fields must be entered including the 
            fields that aren't changing. If deleting a record it will delete based on the ID number for the Record. If Changing which table is viewed then after selecting the new table select the refresh action and submit.
            <br /><br /><select name="action" size="1"> <%-- this provides a drop down menu for the user to select what action the will take --%>
                <option>refresh</option>
                <option>update</option>
                <option>insert</option>
                <option>delete</option>
                
            </select>
            <br /><%-- These fields bellow allow the user to enter data based on the desired action.--%>
            <br /><strong>${result.columnNames[0]}</strong><input type="text" name="item1" value="" size="10" />
            <br /><strong>${result.columnNames[1]}</strong><input type="text" name="item2" value="" size="10" />
            <br /><strong>${result.columnNames[2]}</strong><input type="text" name="item3" value="" size="10" />
            <br /><strong>${result.columnNames[3]}</strong><input type="text" name="item4" value="" size="10" />

            <br /><input type="submit" value="submit" name="btn" />
            </form>
    </body>
</html>
