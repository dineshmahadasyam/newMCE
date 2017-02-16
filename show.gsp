
<%@ page import="com.dell.diamond.fms.AgentMasterCommand" %>
<!DOCTYPE html>
<html>
	<head>
		<meta name="layout" content="main_2">
		<g:set var="entityName" value="${message(code: 'agentMaster.label', default: 'Agent')}" />
		<title><g:message code="default.show.label" args="[entityName]" /></title>
				<script>
		function closeForm() {
			window.location.assign('<g:createLinkTo dir="/agentMaster/list"/>')			
		}
		</script>
	</head>
	<body>
		<a href="#show-agentMaster" class="skip" tabindex="-1"><g:message code="default.link.skip.label" default="Skip to content&hellip;"/></a>
	<%-- 	<div class="nav" role="navigation">
			<ul>
				<li><a class="home" href="${createLink(uri: '/')}"><g:message code="default.home.label"/></a></li>
				<li><g:link class="list" action="list"><g:message code="default.list.label" args="[entityName]" /></g:link></li>
				<li><g:link class="create" action="create"><g:message code="default.new.label" args="[entityName]" /></g:link></li>
			</ul>--%>
		</div>
		<div id="show-agentMaster" class="content scaffold-show" role="main">
			<h1 style="color: #48802C"><g:message code="default.show.label" args="[entityName]" /></h1>
			<g:if test="${flash.message}">
			<div class="message" role="status">${flash.message}</div>
			</g:if>
			<ol class="property-list agentMaster">
			
				<g:if test="${agentMasterInstance?.agentId}">
				<li class="fieldcontain">
					<span id="agentId-label" class="property-label"><g:message code="agentMaster.agentId.label" default="Agent Id" /></span>
					
						<span class="property-value" aria-labelledby="agentId-label"><g:fieldValue bean="${agentMasterInstance}" field="agentId"/></span>
					
				</li>
				</g:if>
			
				<g:if test="${agentMasterInstance?.agentType}">
				<li class="fieldcontain">
					<span id="agentType-label" class="property-label"><g:message code="agentMaster.agentType.label" default="Agent Type" /></span>
					
						<span class="property-value" aria-labelledby="agentType-label"><g:fieldValue bean="${agentMasterInstance}" field="agentType"/></span>
					
				</li>
				</g:if>
			
				<g:if test="${agentMasterInstance?.dateOfBirth}">
				<li class="fieldcontain">
					<span id="dateOfBirth-label" class="property-label"><g:message code="agentMaster.dateOfBirth.label" default="Date Of Birth" /></span>
					
						<span class="property-value" aria-labelledby="dateOfBirth-label"><g:formatDate date="${agentMasterInstance?.dateOfBirth}" format="MMM d, ''yy" /></span>
					
				</li>
				</g:if>
			
				<g:if test="${agentMasterInstance?.firstName}">
				<li class="fieldcontain">
					<span id="firstName-label" class="property-label"><g:message code="agentMaster.firstName.label" default="First Name" /></span>
					
						<span class="property-value" aria-labelledby="firstName-label"><g:fieldValue bean="${agentMasterInstance}" field="firstName"/></span>
					
				</li>
				</g:if>
			
			
				<g:if test="${agentMasterInstance?.lastName}">
				<li class="fieldcontain">
					<span id="lastName-label" class="property-label"><g:message code="agentMaster.lastName.label" default="Last Name" /></span>
					
						<span class="property-value" aria-labelledby="lastName-label"><g:fieldValue bean="${agentMasterInstance}" field="lastName"/></span>
					
				</li>
				</g:if>
			
				<g:if test="${agentMasterInstance?.licenseNo}">
				<li class="fieldcontain">
					<span id="licenseNo-label" class="property-label"><g:message code="agentMaster.licenseNo.label" default="License No" /></span>
					
						<span class="property-value" aria-labelledby="licenseNo-label">${agentMasterInstance?.licenseNo}</span>
					
				</li>
				</g:if>
			
				<g:if test="${agentMasterInstance?.middleInitial}">
				<li class="fieldcontain">
					<span id="middleInitial-label" class="property-label"><g:message code="agentMaster.middleInitial.label" default="Middle Initial" /></span>
					
						<span class="property-value" aria-labelledby="middleInitial-label"><g:fieldValue bean="${agentMasterInstance}" field="middleInitial"/></span>
					
				</li>
				</g:if>
			
				<g:if test="${agentMasterInstance?.payType}">
				<li class="fieldcontain">
					<span id="payType-label" class="property-label"><g:message code="agentMaster.payType.label" default="Pay Type" /></span>
					
						<span class="property-value" aria-labelledby="payType-label"><g:fieldValue bean="${agentMasterInstance}" field="payType"/></span>
					
				</li>
				</g:if>
			
				<g:if test="${agentMasterInstance?.pinTid}">
				<li class="fieldcontain">
					<span id="pinTid-label" class="property-label"><g:message code="agentMaster.pinTid.label" default="Pin Tid" /></span>
					
						<span class="property-value" aria-labelledby="pinTid-label"><g:fieldValue bean="${agentMasterInstance}" field="pinTid"/></span>
					
				</li>
				</g:if>
			
				<g:if test="${agentMasterInstance?.securityCode}">
				<li class="fieldcontain">
					<span id="securityCode-label" class="property-label"><g:message code="agentMaster.securityCode.label" default="Security Code" /></span>
					
						<span class="property-value" aria-labelledby="securityCode-label"><g:fieldValue bean="${agentMasterInstance}" field="securityCode"/></span>
					
				</li>
				</g:if>
			
				<g:if test="${agentMasterInstance?.shortName}">
				<li class="fieldcontain">
					<span id="shortName-label" class="property-label"><g:message code="agentMaster.shortName.label" default="Short Name" /></span>
					
						<span class="property-value" aria-labelledby="shortName-label"><g:fieldValue bean="${agentMasterInstance}" field="shortName"/></span>
					
				</li>
				</g:if>
			
				<g:if test="${agentMasterInstance?.status}">
				<li class="fieldcontain">
					<span id="status-label" class="property-label"><g:message code="agentMaster.status.label" default="Status" /></span>
					
						<span class="property-value" aria-labelledby="status-label"><g:fieldValue bean="${agentMasterInstance}" field="status"/></span>
					
				</li>
				</g:if>
			
				<g:if test="${agentMasterInstance?.termDate}">
				<li class="fieldcontain">
					<span id="termDate-label" class="property-label"><g:message code="agentMaster.termDate.label" default="Term Date" /></span>
					
						<span class="property-value" aria-labelledby="termDate-label"><g:formatDate date="${agentMasterInstance?.termDate}" format="MMM d, ''yy " /></span>
					
				</li>
				</g:if>
				
				<g:if test="${agentMasterInstance?.userDefined1}">
				<li class="fieldcontain">
					<span id="userDefined1-label" class="property-label"><g:message code="agentMaster.userDefined1.label" default="User Defined1" /></span>
					
						<span class="property-value" aria-labelledby="userDefined1-label"><g:fieldValue bean="${agentMasterInstance}" field="userDefined1"/></span>
					
				</li>
				</g:if>
			
				<g:if test="${agentMasterInstance?.userDefined2}">
				<li class="fieldcontain">
					<span id="userDefined2-label" class="property-label"><g:message code="agentMaster.userDefined2.label" default="User Defined2" /></span>
					
						<span class="property-value" aria-labelledby="userDefined2-label"><g:fieldValue bean="${agentMasterInstance}" field="userDefined2"/></span>
					
				</li>
				</g:if>
			
				<g:if test="${agentMasterInstance?.userDefinedDate}">
				<li class="fieldcontain">
					<span id="userDefinedDate-label" class="property-label"><g:message code="agentMaster.userDefinedDate.label" default="User Defined Date" /></span>
					
						<span class="property-value" aria-labelledby="userDefinedDate-label"><g:formatDate date="${agentMasterInstance?.userDefinedDate}" format="MMM d, ''yy "/></span>
					
				</li>
				</g:if>
			
			</ol>
			<g:render template="/FMSInterfaces/finTransResult" model="${[finResponse: searchResultCommand.financialTransactionResponse]}"/>
			<g:form>
				<fieldset class="buttons">
					<g:hiddenField name="id" value="${agentMasterInstance?.seqAgentId}" />
					<g:link class="edit" action="edit" params="${[seqAgentId: agentMasterInstance?.seqAgentId ]}"><g:message code="default.button.edit.label" default="Edit" /></g:link>
					<%--<g:actionSubmit class="delete" action="delete" value="${message(code: 'default.button.delete.label', default: 'Delete')}" onclick="return confirm('${message(code: 'default.button.delete.confirm.message', default: 'Are you sure?')}');" /> --%>
					<input type="button" class="close" value="Close" onClick="closeForm()"/>					
				</fieldset>
			</g:form>
		</div>
	</body>
</html>
