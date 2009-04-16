<head>
	<meta name="layout" content="main" />
	<title>Edit Requestmap</title>
	<link rel="stylesheet" href="${createLinkTo(dir:'css',file:'formless.css')}" type="text/css" media="screen, projection">
</head>

<body>

	<div class="body">
		<h2>Edit Requestmap</h2>
		<g:if test="${flash.message}">
			<div class="info">${flash.message}</div>
		</g:if>
		<g:hasErrors bean="${requestmap}">
		<div class="error">
			<g:renderErrors bean="${requestmap}" as="list" />
		</div>
		</g:hasErrors>

		<g:form>
			<input type="hidden" name="id" value="${requestmap.id}" />
			<input type="hidden" name="version" value="${requestmap.version}" />

			<label for="url">URL Pattern:</label>
			<input type="text" id="url" name="url" value="${requestmap.url?.encodeAsHTML()}"/><br/>
			
			<label for="configAttribute">Roles (comma-delimited):</label>
			<input type="text" name='configAttribute'  value="${requestmap.configAttribute}"/><br/>
			
			<br/><br/>

			<g:actionSubmit class="save submit" value="Update" /> 
			<g:actionSubmit class="delete submit" onclick="return confirm('Are you sure?');" value="Delete" />

		</g:form>

	</div>
</body>
