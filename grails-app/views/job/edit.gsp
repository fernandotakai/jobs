<html>
	<head>
		<meta http-equiv="Content-type" content="text/html; charset=utf-8">
		<title>Editing ${job?.title}</title>
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
		<g:formForDomain attributes="[Title:'title', Description:'description']" action="update" controller="job" model="${job}">
			<div class="buttons">
				<g:hiddenField name="id" value="${job.id}" />
				<br/>
				<span class="button"><g:submitButton name="save" class="submitbutton save" value="Save" /></span>
			</div>
		</g:formForDomain>
	</body>
</html>