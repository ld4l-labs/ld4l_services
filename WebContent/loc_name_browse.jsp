<%@ page language="java" contentType="text/html; charset=UTF-8" %>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
<%@ taglib prefix="sparql" uri="http://slis.uiowa.edu/SPARQL"%>
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
<h2>LoC Name: ${param.name} URI: ${param.uri}</h2>

<sparql:setEndpoint var="ld4l" sparqlURL="http://services.ld4l.org/fuseki/loc_names/sparql">
    <sparql:prefix prefix="foaf" baseURI="http://xmlns.com/foaf/0.1/"/>
    <sparql:prefix prefix="bibo" baseURI="http://purl.org/ontology/bibo/"/>
    <sparql:prefix prefix="rdf"  baseURI="http://www.w3.org/1999/02/22-rdf-syntax-ns#"/>
    <sparql:prefix prefix="rdfs" baseURI="http://www.w3.org/2000/01/rdf-schema#"/>
    <sparql:prefix prefix="schema" baseURI="http://schema.org/"/>
    <sparql:prefix prefix="mads" baseURI="http://www.loc.gov/mads/rdf/v1#"/>
</sparql:setEndpoint>

<sparql:construct var="graph" endpoint="${ld4l}">
	CONSTRUCT { ?s ?p ?o . ?o ?q ?r } WHERE {
	  ?s ?p ?o .
	  OPTIONAL {
	    ?o ?q ?r
	    FILTER (isBlank(?o))
	  }
	}
	<sparql:parameter var="s" value="${param.uri}" type="IRI" />
</sparql:construct>

<sparql:query var="result" graph="${graph}" resultType="${mode}">
    SELECT ?s ?p ?o WHERE {
      ?s ?p ?o .
    } ORDER BY ?s ?p
</sparql:query>

        <table border=1>
        <thead><tr><td>Subject</td><td>Predicate</td><td>Object</td></tr></thead>
        <tbody>
        <c:forEach items="${result.rows}" var="row" varStatus="rowCounter">
            <tr><td>${row.s}</td><td>${row.p}</td><td>${row.o}</td></tr>
        </c:forEach>
        </tbody>
        </table>

<jsp:include page="/footer.jsp" flush="true" />
</div>
</div>
</body>
</html>

