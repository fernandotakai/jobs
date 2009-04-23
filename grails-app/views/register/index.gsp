<head>
	<meta name="layout" content="main" />
	<title>User Registration</title>
	<link rel="stylesheet" href="${createLinkTo(dir:'css',file:'formless.css')}" type="text/css" media="screen, projection">
</head>

<body>

	<div class="body">
		<h2>User Registration</h2>
		<br/>
		<g:if test="${flash.message}">
			<div class="notice">${flash.message}</div>
		</g:if>
		<g:hasErrors bean="${person}">
		<div class="error">
			<g:renderErrors bean="${person}" as="list" />
		</div>
		</g:hasErrors>

		<g:form action="save">

			<label for='username'>Login Name:</label>
			<input type="text" name='username' value="${person?.username?.encodeAsHTML()}"/><br/>

			<label for='userRealName'>Full Name:</label>
			<input type="text" name='userRealName' value="${person?.userRealName?.encodeAsHTML()}"/><br/>

			<label for='passwd'>Password:</label>
			<input type="password" name='passwd' value="${person?.passwd?.encodeAsHTML()}"/><br/>

			<label for='enabled'>Confirm Password:</label>
			<input type="password" name='repasswd' value="${person?.passwd?.encodeAsHTML()}"/><br/>

			<label for='email'>Email:</label>
			<input type="text" name='email' value="${person?.email?.encodeAsHTML()}"/><br/>
			
			<label for='email'>Show Email:</label>
			<g:checkBox name="emailShow" class="boxes" value="${person?.emailShow}" /><br/>

			<label for="type">Type: </label><g:select name="type" from="${['Employee','Company']}" /><br/>

			<br/>

			<label for=''>&nbsp;</label>
			<img src="${createLink(controller:'captcha', action:'index')}" /><br/>
			
			<br/>

			<label for='code'>Captcha: </label>
			<input type="text" name="captcha" size="8"/>
			<br/>
			
			<input class='submitbutton' type="submit" value="Create"></input>

		</g:form>
	</div>
</body>
