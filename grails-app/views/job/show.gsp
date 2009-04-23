<html>
	<head>
		<meta name="layout" content="main">
		<title>${job.title} - Jobs</title>  		
		<link rel="stylesheet" href="${createLinkTo(dir:'css',file:'buttons.css')}" type="text/css" media="screen, projection">
		<g:javascript library="jquery" />
	</head>

	<body>
		<p><strong>Title: </strong>${job.title.encodeAsHTML()}</p>
		<p><strong>Description: </strong>${job.description.encodeAsHTML()}</p>
		<p><strong>From: </strong><g:link action="show" controller="profile" id="${job?.company?.id}">${job.company.userRealName.encodeAsHTML()}		</g:link></p>
		<p><strong>Created on: </strong><g:formatDate format="yyyy-MM-dd HH:mm" date="${job.dateCreated}"/></p>
		<g:if test="${isOwner}">
			<g:form>
				<div class="buttons">
					<g:hiddenField name="id" value="${job.id}" />
					<br/>
	                <span class="button"><g:actionSubmit class="submitbutton edit" value="Edit" /></span>
	                <span class="button"><g:actionSubmit class="submitbutton delete" onclick="return confirm('Are you sure?');" value="Delete" /></span>
				</div>
			</g:form>
		</g:if>
		<g:ifAnyGranted role="ROLE_EMPLOYEE">
			<g:if test="${!alreadyApplied}">
				<g:link action="apply" controller="job" id="${job.id}">Apply to this Job</g:link>
				<br/>
			</g:if>
			<g:else>
				<g:form name="cancel" action="cancel">
					<g:hiddenField name="id" value="${job.id}" />
					
					<div class="buttons">
						<div id="message">
							<p>You have already applied to this job. <g:remoteLink action="cancel" id="${job.id}" update="message">Cancel</g:remoteLink></p>
						</div>
					</div>
				</g:form>
			</g:else>
		</g:ifAnyGranted>
		<br/>
	</body>	
</html>