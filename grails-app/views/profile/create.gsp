<html>
	<head>
		<meta http-equiv="Content-type" content="text/html; charset=utf-8">
		<meta name="layout" content="main">
		<title>Create your profile</title>
		<link rel="stylesheet" href="${createLinkTo(dir:'css',file:'formless.css')}" type="text/css" media="screen, projection">
	</head>
	
	<body>
		<h2>Create your profile</h2>
		<g:if test="${flash.message}">
			<div class="notice">${flash.message}</div>
		</g:if>
		<g:hasErrors bean="${profile}">
		<div class="error">
			<g:renderErrors bean="${profile}" as="list" />
		</div>
		</g:hasErrors>
		<g:form name="save" action="save" enctype="multipart/form-data">
			<g:if test="${type == 'employee'}">
				<g:render template="employee_form" bean="profile" var="profile" />
			</g:if>
			<g:else>
				<g:render template="company_form" bean="profile" var="profile" />
			</g:else>
			
			<br/><br/>

			<g:hiddenField name="type" value="${type}" />

			<g:submitButton name="save" value="Save" class="submitbutton" />
			
		</g:form>
	</body>
</html>