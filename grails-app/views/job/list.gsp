<html>
	<head>
		<meta http-equiv="Content-type" content="text/html; charset=utf-8">
		<title>Jobs</title>
		<meta name="layout" content="main" />
	</head>

	<body>
		<g:if test="${flash.message}">
			<div class="notice">${flash.message}</div>
		</g:if>
		<h3>Latest Jobs</h3>
		<ul>
		<g:each var="job" in="${jobs}">
			<li><g:link action="show" controller="job" id="${job.id}">${job.title}</g:link>&nbsp;-&nbsp;<g:timeSince since="${job.dateCreated}" /></li>
		</g:each>
		</ul>
	</body>
</html>