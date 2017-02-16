<%@ page import="com.perotsystems.diamond.bom.fms.Agency" %>
<%@ page import="com.dell.diamond.fms.enums.PageNameEnum" %>

<!DOCTYPE html>
<html>
	<head>
		<meta name="layout" content="main">
		<meta name="navSelector" content="maint"/>
		<meta name="navChildSelector" content="agency"/>		
		<g:set var="entityName" value="${message(code: 'agency.label', default: 'Agency')}" />
		<g:set var="isShowCalendarIcon" value="${PageNameEnum.AGENCY_CREATE.equals(currentPage)?true:false}" />
		<title><g:message code="default.create.label" args="[entityName]" /></title>

		<script>
			function closeForm() {
				window.location.assign('<g:createLinkTo dir="/agency/list"/>')		
			}
		</script>
		
		
</head>
	<body>
		<div id="create-agencyMaster" class="content scaffold-create" role="main">
			<g:form action="save" id="agencyForm" name="agencyForm">
			<div id="fms_content_header">
			  <div class="fms_content_header_note">
			    &nbsp&nbsp<a href="${createLink(uri: '/agency/list')}">Agency Maintenance </a>/ Create for Agency ID ${agencyInstance?.agencyId}
			  </div>
			  <div class="fms_content_title">
			    <h1>&nbspCreate Agency</h1>
			  </div>
			</div>
			<div class="right-corner" align="right">AGNCM&nbsp</div>
				<fieldset class="form">
					<g:render template="form"/>
				</fieldset>
			</g:form>
		</div>
	</body>
</html>
