<html>
	<head>
		<meta name="layout" content="main">
		<title>Your Profile</title>  		
	</head>

	<body>
		<p><strong>Name:</strong> ${user.userRealName}</p>
		<p><strong>Email:</strong> ${user.email}</p>
		
		<g:if test="${type == 'employee'}">
			<g:render template="employee_profile" model="[user:user, profile:profile]"  />
		</g:if>
		<g:else>
			<g:render template="company_profile" model="[user:user, profile:profile]"   />
		</g:else>
	</body>
</html>