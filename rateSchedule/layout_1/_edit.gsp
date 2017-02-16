<%@ page import="com.perotsystems.diamond.bom.AgencyRateScheduleDtl" %>
<!DOCTYPE html>
<html>
	<head>
		<meta name="layout" content="main">
		<meta name="navSelector" content="maint"/>
		<!-- Child menu select -->
		<meta name="navChildSelector" content="searchJobs"/>
		
		<g:set var="entityName" value="${message(code: 'AgencyRateSchedule.label', default: 'Commission – Incentive Schedule')}" />
		<title><g:message code="default.edit.label" args="[entityName]" /></title>
		<g:set var="appContext" bean="grailsApplication"/>
	</head>
	<div id="fms_content"> 
		<div id="fms_content_header">
        	<div class="fms_content_header_note">
        		<a href="/FMSAdminConsole/commissions/searchJobs">Commissions Maintenance</a> / 
          		<a href="/FMSAdminConsole/rateSchedule/list">Rate Schedule</a> / 
          		<g:if test="${request.getParameter('editType') && 'DETAIL'.equals(request.getParameter('editType'))}">
          			Detail Record for Rate ID (${rateSchHdrInstance.rateId})
          		</g:if>
          		<g:else>
          			Master Record for Rate ID (${rateSchHdrInstance.rateId})
          		</g:else>
        	</div> 	
        	<div class="fms_content_title">
				<g:if test="${request.getParameter('editType') && 'DETAIL'.equals(request.getParameter('editType'))}">
	          		<h1>Edit Commission – Incentive Schedule - DETAIL</h1>
	          	</g:if>
	          	<g:else>
	          		<h1>Edit Commission – Incentive Schedule - MASTER</h1>
	          	</g:else>
          	</div>
        </div>	
        <!-- START - Tabs -->
		<div id="fms_content_tabs" class="fms_tab_action">
			<ul>
				<g:if test="${request.getParameter('editType') && 'DETAIL'.equals(request.getParameter('editType'))}">
					<li><g:link class="list" action="edit" params="${[seqRateId: rateSchHdrInstance?.seqRateId, rateId: rateSchHdrInstance?.rateId, description: rateSchHdrInstance?.description, retentionPeriod: rateSchHdrInstance?.retentionPeriod, editType :'MASTER']}">Master Record</g:link></li>
					<li><g:link class="active" action="edit" params="${[seqRateId: rateSchHdrInstance?.seqRateId, rateId: rateSchHdrInstance?.rateId, description: rateSchHdrInstance?.description, retentionPeriod: rateSchHdrInstance?.retentionPeriod, editType :'DETAIL']}">Detail Records</g:link></li>
				</g:if>
				<g:else>
					<li><g:link class="active" action="edit" params="${[seqRateId: rateSchHdrInstance?.seqRateId, rateId: rateSchHdrInstance?.rateId, description: rateSchHdrInstance?.description, retentionPeriod: rateSchHdrInstance?.retentionPeriod, editType :'MASTER']}">Master Record</g:link></li>
					<li><g:link class="list" action="edit" params="${[seqRateId: rateSchHdrInstance?.seqRateId, rateId: rateSchHdrInstance?.rateId, description: rateSchHdrInstance?.description, retentionPeriod: rateSchHdrInstance?.retentionPeriod, editType :'DETAIL']}">Detail Records</g:link></li>
				</g:else>
			</ul>
		</div>
      	<!-- END - Tabs -->
      	<div id="edit-agencyRateSchedule" class="content scaffold-edit" role="main">
			<g:if test="${params.editType?.equals("MASTER")}">
				<g:form action="update" id="agencyRateScheduleForm" name="agencyRateScheduleForm">
					<fieldset class="form">
					      <g:render template="form"/>
					</fieldset>
				</g:form>
			</g:if>
			<g:elseif test="${params.editType?.equals("DETAIL")}">
				<g:form action="update" id="agencyRateSchDetailForm" name="agencyRateSchDetailForm">
					<fieldset class="form">
					      <g:render template="agencyRateSchDetailForm"/>
					</fieldset>
				</g:form>
			</g:elseif>
		</div>
	</div>
</html>
			