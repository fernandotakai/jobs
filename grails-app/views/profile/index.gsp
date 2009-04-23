<html>
	<head>
		<meta name="layout" content="main">
		<title>Your Profile</title>  		
	</head>

	<body>
		<g:if test="${flash.message}">
			<div class="notice">${flash.message}</div>
		</g:if>
		
		<p><strong>Name:</strong> ${user.userRealName}</p>
		<p><strong>Email:</strong> ${user.email}</p>
		<p><strong>Phone:</strong> ${user.profile.phone}</p>
		<g:if test="${user.emailShow}">
			<p>You are showing your email on your public profile</p>
		</g:if>
		<g:else>
			<p>You are <strong>not</strong> showing your email on your public profile</p>
		</g:else>
		
		<g:if test="${type == 'employee'}">
			<g:render template="employee_profile" model="[user:user, profile:profile]"  />
		</g:if>
		<g:else>
			<g:render template="company_profile" model="[user:user, profile:profile]"   />
		</g:else>
	</body>
</html>