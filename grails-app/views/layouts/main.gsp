<html>
    <head>
        <title><g:layoutTitle default="Grails" /></title>
        <link rel="shortcut icon" href="${createLinkTo(dir:'images',file:'favicon.ico')}" type="image/x-icon" />
		<link rel="stylesheet" href="${createLinkTo(dir:'css/blueprint',file:'screen.css')}" type="text/css" media="screen, projection">
		<link rel="stylesheet" href="${createLinkTo(dir:'css/blueprint',file:'print.css')}" type="text/css" media="print">    
		<!--[if IE]><link rel="stylesheet" href="${createLinkTo(dir:'css/blueprint',file:'ie.css')}" type="text/css" media="screen, projection"><![endif]-->
		<style type="text/css" media="screen">
			a {
				text-decoration: none;
			}
		</style>
        <g:layoutHead />
        <g:javascript library="application" />			
    </head>
    <body>
		<div class="container">
			<h1>Jobs</h1>
			<div id="links" style="float: left">
				<a href="${createLinkTo(url:'/')}">home</a> &nbsp;
				<g:ifAnyGranted role="ROLE_COMPANY">
					<g:link action="create" controller="job" >new job</g:link>
				</g:ifAnyGranted>
				<g:link action="search" controller="job">search</g:link>
			</div>
			<div id="links_user" style="float: right;">
				<g:isNotLoggedIn>
					<g:link action="auth" controller="login" >login</g:link>
					<g:link action="index" controller="register" >register</g:link>
				</g:isNotLoggedIn>
				<g:isLoggedIn>
					<p>Hi, <strong><g:loggedInUsername /></strong>
					<g:link controller="profile" >profile</g:link>
					<g:link controller="logout" >logout</g:link></p>
				</g:isLoggedIn>
			</div>
			<br/><br/>
			<div class="span-6">
				&nbsp;
			</div>
			<div class="span-12">
		    	<g:layoutBody />
			</div>
			<div class="span-6 last">
				&nbsp;
			</div>
			<hr />
			<div>Creative Commons 2009</div>
		</div>
    </body>	
</html>