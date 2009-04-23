<html>
	<head>
		<title>Profile for ${profile?.user?.userRealName}</title>
		<meta name="layout" content="main" />
	</head>

	<body>
		<br/><br/>
		<p><strong>Name:</strong> ${profile.user.userRealName}</p>
		<g:if test="${profile.user.emailShow}">
			<p><strong>Email:</strong> ${profile.user.email}</p>
		</g:if>
		
		<g:if test="${profile.user.type == 'employee'}">
			<g:render template="show_employee_profile" model="[user:profile.user, profile:profile]"  />
		</g:if>
		<g:else>
			<g:render template="show_company_profile" model="[user:profile.user, profile:profile]"   />
		</g:else>
	</body>
</html>