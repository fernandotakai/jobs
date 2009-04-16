<html>
	<head>
		<meta name="layout" content="main" />
		<title>Applying to ${job.title}</title>
		<link rel="stylesheet" href="${createLinkTo(dir:'css',file:'formless.css')}" type="text/css" media="screen, projection">
	</head>

	<body>
		<g:form name="apply" action="apply">
			<g:hiddenField name="id" value="${job.id}" />
			<label for="more">More to say about you? </label><textarea name="more" rows="8" cols="40"></textarea><br/>
			<g:submitButton class="submitbutton" name="apply" value="Apply" /><br/>
		</g:form>
	</body>
</html>