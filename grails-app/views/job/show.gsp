<html>
	<head>
		<meta name="layout" content="main">
		<title>${job.title} - Jobs</title>  		
	</head>

	<body>
		<p><strong>Title: </strong>${job.title.encodeAsHTML()}</p>
		<p><strong>Description: </strong>${job.description.encodeAsHTML()}</p>
		<br/>
		<p><strong>From: </strong>${job.company.userRealName.encodeAsHTML()}</p>
		<p><strong>Created on: </strong><g:formatDate format="yyyy-MM-dd HH:mm" date="${job.dateCreated}"/></p>
		<g:if test="${isOwner}">
			<g:form>
				<g:hiddenField name="id" value="${job.id}" />
				<g:actionSubmit class="delete" onclick="return confirm('Are you sure?');" value="Delete" />
			</g:form>
		</g:if>
		<g:ifAnyGranted role="ROLE_EMPLOYEE">
			<g:if test="${!alreadyApplied}">
				<g:link action="apply" controller="job" id="${job.id}">Apply to this Job</g:link>
			</g:if>
			<g:else>
				<p>You have already applied to this job.</p>
				<g:form name="cancel" action="cancel">
					<g:actionSubmit class="cancel" onclick="return confirm('Are you sure?');" value="Cancel" />
				</g:form>
			</g:else>
		</g:ifAnyGranted>
		<br/>
	</body>	
</html>