<g:link action="edit" controller="profile" >edit your profile</g:link><g:if test="${profile.hasResume}">
	 | <g:link action="download" controller="profile" id="${user.id}"> download your resume</g:link>
</g:if>
<br /><br />
	<!-- <h4>Jobs you have applied</h4>
	<g:each var="job" in="${user.jobsApplied()}">
		<g:link action="show" controller="job" id="${job.id}">${job.title}</g:link><br/>
	</g:each>
	<br/><br/> -->