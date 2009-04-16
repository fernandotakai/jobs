<html>
	<head>
		<meta name='layout' content='main' />
		<title>Login</title>
		<link rel="stylesheet" href="${createLinkTo(dir:'css',file:'formless.css')}" type="text/css" media="screen, projection">
	</head>

	<body>
		<div id='login'>
			<div class='inner'>
				<g:if test='${flash.message}'>
					<div class='error'>${flash.message}</div>
				</g:if>
				<form action='${postUrl}' method='POST' id='loginForm' class='cssform'>
					<label for='j_username'>Username</label>
					<input type='text' class='text_' name='j_username' id='j_username' value='${request.remoteUser}' /><br/>
			
					<label for='j_password'>Password</label>
					<input type='password' class='text_' name='j_password' id='j_password' /><br/>
			
					<label for='remember_me'>Remember me</label>
					<input type='checkbox' class='boxes' name='_spring_security_remember_me' id='remember_me'
					<g:if test='${hasCookie}'>checked='checked'</g:if> /><br/>

					<input type='submit' class="submitbutton" value='Login' /><br/>
				</form>
			</div>
		</div>
	<script type='text/javascript'>
	<!--
	(function(){
		document.forms['loginForm'].elements['j_username'].focus();
	})();
	// -->
	</script>
	</body>
</html>
