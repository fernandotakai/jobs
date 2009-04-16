<head>
	<meta name="layout" content="main" />
	<title>Create Requestmap</title>
	<link rel="stylesheet" href="${createLinkTo(dir:'css',file:'formless.css')}" type="text/css" media="screen, projection">
</head>

<body>

	<div class="body">
		<h2>Create Requestmap</h2>
		<g:if test="${flash.message}">
		<div class="message">${flash.message}</div>
		</g:if>
		<g:hasErrors bean="${requestmap}">
		<div class="errors">
			<g:renderErrors bean="${requestmap}" as="list" />
		</div>
		</g:hasErrors>
		<g:form action="save">

			<label for="url">URL Pattern:</label>
			<input type="text" id="url" name="url" value="${requestmap.url?.encodeAsHTML()}"/><br/>

			<label for="configAttribute">Role (comma-delimited):</label><input type="text" id="configAttribute" name="configAttribute" value="${requestmap.configAttribute?.encodeAsHTML()}"/><br/>

			<input class="submitbutton" type="submit" value="Create" />
			
		</g:form>

	</div>
</body>
