<!DOCTYPE html><%--
 Copyright (c) 2011, 2012 IBM Corporation and others.

 All rights reserved. This program and the accompanying materials
 are made available under the terms of the Eclipse Public License v1.0
 and Eclipse Distribution License v. 1.0 which accompanies this distribution.

 The Eclipse Public License is available at http://www.eclipse.org/legal/epl-v10.html
 and the Eclipse Distribution License is available at
 http://www.eclipse.org/org/documents/edl-v10.php.

 Contributors:

	Andrii Berezovskyi	- initial implementation of a sample delegated UI client

 This file is generated by org.eclipse.lyo.oslc4j.codegenerator
--%>
<%@page import="org.eclipse.lyo.oslc4j.core.model.ServiceProvider" %>
<%--
Start of user code imports
--%>
<%--
End of user code
--%>
<%@ page contentType="text/html" language="java" pageEncoding="UTF-8" %>
<%
	String creationDialogUri = request.getParameter("creationUri");
	creationDialogUri += "#oslc-core-postMessage-1.0";
%>
<%--
Start of user code getRequestAttributes
--%>
<%--
End of user code
--%>
<html>
<head>
	<title>Creation Dialog client</title>
	<link rel="stylesheet" href="https://maxcdn.bootstrapcdn.com/bootstrap/3.3.6/css/bootstrap.min.css"
	integrity="sha384-1q8mTJOASx8j1Au+a5WDVnPi2lkFfwwEAa8hDDdjZlpLegxhjVME1fgjWPGmkzs7"
	crossorigin="anonymous">
	<script src="https://ajax.googleapis.com/ajax/libs/jquery/2.2.4/jquery.min.js"></script>
	<style>
	#delegatedUI {
		width: 523px;
		height: 480px;
	}
	</style>
</head>
<body>

<div class="container">

  <div class="page-header">
    <h1>Creation Dialog client</h1>
  </div>

	<div class="row">
	  <div class="col-md-6 col-md-offset-3">
      <div class="panel panel-primary">
        <div class="panel-heading">Creation Dialog frame</div>
        <div class="panel-body">
          <iframe src="<%= creationDialogUri %>" id="delegatedUI"></iframe>
        </div>
        <div class="panel-footer">
          <p>URI: <em style="word-wrap:break-word;"><%= creationDialogUri %></em></p>
        </div>
      </div>
	  </div>
	</div>

  <div class="row">
	  <div class="col-md-6 col-md-offset-3">
      <div class="panel panel-success">
        <div class="panel-heading">Creation Dialog results</div>
        <div class="panel-body" id="results">
            <ul></ul>
        </div>
      </div>
	  </div>
	</div>

</div>

<script type="text/javascript">
	$(function () {
		function handleMessage(message) {
			var results = JSON.parse(message);
			var firstResult = {
				label: results["oslc:results"][0]["oslc:label"],
				uri: results["oslc:results"][0]["rdf:resource"]
			};
			handleOslcSelection(firstResult);
		}

		function handleOslcSelection(resource) {
			$("#results ul").append('<li><a href="' + resource.uri + '"><span>' + resource.label + '</span></a></li>');
		}

		window.addEventListener('message', function (e) {
			var HEADER = "oslc-response:";
			if (e.source == document.getElementById("delegatedUI").contentWindow
					&& e.data.indexOf(HEADER) == 0) {
				handleMessage(e.data.slice(HEADER.length));
			}
		}, false);
	});
</script>

</body>
</html>
