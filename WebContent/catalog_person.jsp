<%@ page language="java" contentType="text/html; charset=UTF-8" %>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
<%@ taglib prefix="util" uri="http://icts.uiowa.edu/tagUtil"%>

<!DOCTYPE html PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN" "http://www.w3.org/TR/html4/loose.dtd">
<html>
<head>
<meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
<title>LD4L Catalog Services</title>
<style type="text/css" media="all">    @import "/ld4l_services/resources/style.css";</style>
</head>
<body>
<div id="content"><jsp:include page="/header.jsp" flush="true" />
<jsp:include page="/menu.jsp" flush="true">
    <jsp:param name="caller" value="research" />
</jsp:include>
<div id="centerCol">
<h2>Catalog Search by Person</h2>

<script type="text/javascript">
	function OnSubmitForm() {
		if (document.queryForm.mode[0].checked == true) {
			document.queryForm.action = "catalog_person_lookup.jsp";
		} else if (document.queryForm.mode[1].checked == true) {
			document.queryForm.action = "catalog_person_browse.jsp";
		}
		return true;
	}
</script>

<form name="queryForm" method='GET' onsubmit="return OnSubmitForm();">
    <table border="0">
        <tr>
            <td>
                <fieldset><legend>Result Format?</legend>
                    <input type="radio" name="mode" value="triple" >Return a list of triples&nbsp;&nbsp;&nbsp;
                    <input type="radio" name="mode" value="literal" checked>Display as HTML table
               </fieldset>
            </td>
            <td>
                <fieldset><legend>Catalog</legend>
                    <select name="catalog">
                        <option value="http://services.ld4l.org/fuseki/combined/sparql">Combined</option>
                        <option value="http://services.ld4l.org/fuseki/cornell/sparql">Cornell</option>
                        <option value="http://services.ld4l.org/fuseki/harvard/sparql">Harvard</option>
					    <option value="http://services.ld4l.org/fuseki/stanford/sparql">Stanford</option>
                    </select>
                </fieldset>
            </td>
        </tr>
        <tr>
            <td >
                <fieldset><legend>Given Name of Person?</legend>
                <input name="givenname" size=25>
                </fieldset>
            </td>
            <td>
                <fieldset><legend>Family Name of Person?</legend>
               <input name="familyname" size=25> <input type=submit name=submitButton value=Search>
                 </fieldset>
            </td>
        </tr>
    </table>
</form>

<h2>Search Logic</h2>
The SPARQL query wrapped by this interface currently comes as follows:
<dl>
<dt>Only givenname is specified or only surname is specified
<dd>the query only specifies rdfs:label
<dt>Both givenname and familyname specified
<dd>the query specifies two conjunctive alternatives
<ul>
    <li> rdfs:label = "givenName familyname"
    <li> rdfs:label = "familyname, givenName"
 
</ul>
</dl>

<h2>Service Request Syntax</h2>
To make a programmatic request to this service, use the following syntax:<br>
<code><a href="/catalog_person_lookup.jsp?givenname=GivenName&familyname=familyName"><util:applicationRoot/>/catalog_person_lookup.jsp?givenname=<i>GivenName</i>&familyname=<i>FamilyName</i></a></code><br>
Where GivenName and Surname are properly escaped to handle things like contained spaces.

<jsp:include page="/footer.jsp" flush="true" />
</div>
</div>
</body>
</html>

