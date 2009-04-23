<html>
	<head>
		<meta http-equiv="Content-type" content="text/html; charset=utf-8">
		<meta name="layout" content="main">
		<title>Edit your profile</title>
		<link rel="stylesheet" href="${createLinkTo(dir:'css',file:'formless.css')}" type="text/css" media="screen, projection">
	</head>
	
	<body>
		<h2>Edit your profile</h2>
		<g:if test="${flash.message}">
			<div class="notice">${flash.message}</div>
		</g:if>
		<g:hasErrors bean="${profile}">
		<div class="error">
			<g:renderErrors bean="${profile}" as="list" />
		</div>
		</g:hasErrors>
		<g:form name="update" action="update" enctype="multipart/form-data">
			<label for="userRealName">Name: </label>
			<g:textField name="user.userRealName" value="${user.userRealName?.encodeAsHTML()}" /><br/>
			
			<label for="email">Email: </label> 
			<g:textField name="user.email" value="${user.email?.encodeAsHTML()}" /><br/>
			
			<label for='email'>Show Email:</label> 
			<g:checkBox class="boxes" name="user.emailShow" value="${user?.emailShow}" /><br/>
			
			<g:if test="${profile.user.type == 'employee'}">
				<g:render template="employee_form" bean="${profile}" var="profile" />
			</g:if>
			<g:else>
				<g:render template="company_form" bean="${profile}" var="profile" />
			</g:else>
			
			<br/><br/>

			<g:hiddenField name="type" value="${profile.user.type}" />

			<g:submitButton name="save" value="Save" class="submitbutton" />
			
		</g:form>
	</body>
</html>