<%@taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
<%@taglib prefix="sql" uri="http://java.sun.com/jsp/jstl/sql"%>
<%-- 
    Document   : newjsp
    Created on : Jun 17, 2018, 6:15:06 PM
    Author     : James B Carlton
--%>
<%@page contentType="text/html" pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html>
    <head>
        <meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
        <title><strong>Database Management.</strong></title>
    </head>
    <body><form name ="custForm" action="selectedTable.jsp"> <%-- The is the form start and states what action the form will take when it is submitted. --%>
            <p1>Please Select which table you would like to view bellow (<strong>customer</strong> or <strong>product</strong>). </p1>
            <br />Customer<input type="radio" name="TblSel" value="customer" checked="true" /> <%--This line establishes the radio buttons that will be used to select the table to open first. --%>
            <br />Product <input type="radio" name="TblSel" value="product" />
            <br /><br /><input type="submit" name="btn" value="Submit"/> <%-- This button will submit the form and open the next JSP passing the data to it. --%>
        </form>

    </body>
</html>
