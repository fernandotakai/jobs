<% import org.codehaus.groovy.grails.orm.hibernate.support.ClosureEventTriggeringInterceptor as Events %>
<%=packageName%>
<html>
    <head>
        <meta http-equiv="Content-Type" content="text/html; charset=UTF-8"/>
        <meta name="layout" content="main" />
        <title>Edit ${className}</title>
		<link rel="stylesheet" href="${createLinkTo(dir:'css',file:'formless.css')}" type="text/css" media="screen, projection">
    </head>
    <body>

        <div class="body">
            <h1>Edit ${className}</h1>
           	<g:if test="\${flash.message}">
            	<div class="info">\${flash.message}</div>
            </g:if>
            <g:hasErrors bean="\${${propertyName}}">
	            <div class="error">
	                <g:renderErrors bean="\${${propertyName}}" as="list" />
	            </div>
            </g:hasErrors>
            <g:form method="post" <%= multiPart ? ' enctype="multipart/form-data"' : '' %>>
                <input type="hidden" name="id" value="\${${propertyName}?.id}" />
                <input type="hidden" name="version" value="\${${propertyName}?.version}" />
                        <%
                            excludedProps = ['version',
                                             'id',
                                               Events.ONLOAD_EVENT,
                                               Events.BEFORE_DELETE_EVENT,
                                               Events.BEFORE_INSERT_EVENT,
                                               Events.BEFORE_UPDATE_EVENT]
                            props = domainClass.properties.findAll { !excludedProps.contains(it.name) }
                            
                            Collections.sort(props, comparator.constructors[0].newInstance([domainClass] as Object[]))
                            props.each { p ->
                                cp = domainClass.constrainedProperties[p.name]
                                display = (cp ? cp.display : true)        
                                if(display) { %>
                                    <label for="${p.name}">${p.naturalName}:</label>
                                    ${renderEditor(p)}<br/>
                        <%  }   } %>
					<g:actionSubmit class="save submitbutton" value="Update" /></span>
                    <g:actionSubmit class="delete submitbutton" onclick="return confirm('Are you sure?');" value="Delete" />
                </div>
            </g:form>
        </div>
    </body>
</html>
