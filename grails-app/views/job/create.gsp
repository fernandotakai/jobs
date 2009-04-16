<html>
	<head>
		<meta http-equiv="Content-type" content="text/html; charset=utf-8">
		<title>Create new Job</title>
		<meta name="layout" content="main" />
		<link rel="stylesheet" href="${createLinkTo(dir:'css',file:'formless.css')}" type="text/css" media="screen, projection">
	</head>
	
	<body>
		<g:if test="${flash.message}">
			<div class="info">${flash.message}</div>
		</g:if>
		
		<g:hasErrors bean="${job}">
		<div class="error">
			<g:renderErrors bean="${job}" as="list" />
		</div>
		</g:hasErrors>
		<g:form name="save" action="save">
			<label for="title">Title</label><g:textField name="title" value="${job.title?.encodeAsHTML() }" /><br/>
			<label for="description">Description</label><textarea name="description" rows="15" cols="40">${job.description?.encodeAsHTML()}</textarea><br/>
			
			<g:submitButton name="save" class="submitbutton" value="Save" />
		</g:form>
	</body>
</html>