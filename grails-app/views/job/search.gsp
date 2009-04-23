<%@ page import="org.springframework.util.ClassUtils" %>
<%@ page import="org.codehaus.groovy.grails.plugins.searchable.SearchableUtils" %>
<%@ page import="org.codehaus.groovy.grails.plugins.searchable.lucene.LuceneUtils" %>
<%@ page import="org.codehaus.groovy.grails.plugins.searchable.util.StringQueryUtils" %>
<html>
  <head>
    <meta http-equiv="content-type" content="text/html; charset=UTF-8">
    <title><g:if test="${params.q && params.q?.trim() != ''}">${params.q} - </g:if>Search</title>
    <script type="text/javascript">
        var focusQueryInput = function() {
            document.getElementById("q").focus();
        }
    </script>
	<meta name="layout" content="main">
  </head>
  <body onload="focusQueryInput();">
  <div id="header">
    <g:form url='[controller: "job", action: "search"]' id="searchableForm" name="searchableForm" method="get">
        <g:textField name="q" value="${params.q}" size="50"/> <input type="submit" value="Search" />
    </g:form>
  </div>
  <div id="main">
    <g:set var="haveQuery" value="${params.q?.trim()}" />
    <g:set var="haveResults" value="${searchResult?.results}" />
    <div class="title">
      <span>
        <g:if test="${haveQuery && haveResults}">
          Showing <strong>${searchResult.offset + 1}</strong> - <strong>${searchResult.results.size() + searchResult.offset}</strong> of <strong>${searchResult.total}</strong>
          results for <strong>${params.q}</strong>
        </g:if>
        <g:else>
        &nbsp;
        </g:else>
      </span>
    </div>

    <g:if test="${haveQuery && !haveResults && !parseException}">
      <p>Nothing matched your query - <strong>${params.q}</strong></p>
    </g:if>

    <g:if test="${searchResult?.suggestedQuery}">
      <p>Did you mean <g:link controller="searchable" action="index" params="[q: searchResult.suggestedQuery]">${StringQueryUtils.highlightTermDiffs(params.q.trim(), searchResult.suggestedQuery)}</g:link>?</p>
    </g:if>

    <g:if test="${parseException}">
    </g:if>
	<br/>
    <g:if test="${haveResults}">
      <div class="results">
        <g:each var="result" in="${searchResult.results}" status="i">
          <div class="result">
			<g:if test="${searchResult?.highlights[i]?.title}">
				<g:link action="show" controller="job" id="${result.id}">&nbsp;-&nbsp;${searchResult?.highlights[i]?.title}</g:link><br/>
			</g:if>
			<g:else>
				<g:link action="show" controller="job" id="${result.id}">&nbsp;-&nbsp;${result.title}</g:link><br/>
			</g:else>			
			<g:if test="${searchResult?.highlights[i]?.description}">
				<p>${searchResult?.highlights[i]?.description}</p>
			</g:if>
			<g:else>
				<p>${result.description.size() > 200 ? result.description[0..200] + "..." : result.description}</p>
			</g:else>
          </div>
        </g:each>
      </div>

	<br/><br/>

      <div>
        <div class="paging">
          <g:if test="${haveResults}">
              Page:
              <g:set var="totalPages" value="${Math.ceil(searchResult.total / searchResult.max)}" />
              <g:if test="${totalPages == 1}"><span class="currentStep">1</span></g:if>
              <g:else><g:paginate controller="searchable" action="index" params="[q: params.q]" total="${searchResult.total}" prev="&lt; previous" next="next &gt;"/></g:else>
          </g:if>
        </div>
      </div>
    </g:if>
  </div>
  </body>
</html>
