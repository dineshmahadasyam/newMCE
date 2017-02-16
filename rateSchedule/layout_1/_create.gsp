<%@ page import="com.perotsystems.diamond.bom.fms.Agency" %>
<!DOCTYPE html>
<html>
	<head>
		<meta name="layout" content="main">
		<meta name="navSelector" content="maint"/>
		<!-- Child menu select -->
		<meta name="navChildSelector" content="searchJobs"/>
		
		<g:set var="entityName" value="${message(code: 'agency.label', default: 'Commission – Incentive Schedule')}" />
		<title><g:message code="default.create.label" args="[entityName]" /></title>
		<g:set var="appContext" bean="grailsApplication"/>
	</head>
	<div id="fms_content">
		<div id="create-agencyRateSchedule" class="content scaffold-create" role="main">
			<g:form action="save" id="agencyRateScheduleForm" name="agencyRateScheduleForm">
				<fieldset class="form">
					<div id="fms_content_header">
				        <div class="fms_content_header_note">
					        <a href="/FMSAdminConsole/commissions/searchJobs">Commissions Maintenance</a> / 
	        						<a href="/FMSAdminConsole/rateSchedule/list">Rate Schedule</a> / 
	         					Create a Rate Schedule for Rate ID - ${params.rateId}
				        </div>
				        <div class="fms_content_title">
	          				<h1>Create Commission – Incentive Schedule</h1>
	          			</div> 
				    </div>
			      	<g:form method="post" >
						<fieldset class="form">
							<g:render template="form"/>
						</fieldset>
				  	</g:form>
				</fieldset>
			</g:form>
		</div>
	</div>
</html>