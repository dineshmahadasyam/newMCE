<%@ page import="com.perotsystems.diamond.bom.AgencyRateScheduleDtl" %>
<!DOCTYPE html>
<html>
	<head>
		<meta name="layout" content="main_2">
		<g:set var="entityName" value="${message(code: 'AgencyRateSchedule.label', default: 'Commission – Incentive Schedule')}" />
		<title><g:message code="default.edit.label" args="[entityName]" /></title>
		<style>
		TD
		{
			line-height: 1.4em;
			padding: 0em 0em;
			text-align: left;
			vertical-align: middle;
		}
		.fieldcontain {
			margin-top: 0.1em;
		}
		.fieldcontain LABEL, .fieldcontain .property-label
		{
			width: 25%;
			font-size: 0.8em;
			font-weight:bold;
		}
		
		#report changed {color:blue;}
        #report { border-collapse:collapse;}
        #report div {background:#C7DDEE}
        #report h4 { margin:0px; padding:0px;}
        #report img { float:right;}
        #report ul { margin:10px 0 10px 40px; padding:0px;}
        #report td { none repeat-x scroll center left; color:#000; padding:2px 15px; }
        #report tr.hideme { background:#C7DDEE none repeat-x scroll center left; color:#000; padding:7px 15px; }
        #report td.clickme td { background:#fffff repeat-x scroll center left; cursor:pointer; }
        #report div.arrow { background:transparent url(arrows.png) no-repeat scroll 0px -16px; width:16px; height:16px; display:block;}
        #report div.up { background-position:0px 0px;}
        
.showme Label{
	width:240px;
	text-align:left;
	padding-bottom:5px;
	padding-top:10px;
}
.showme Input{
	width:200px;
	text-align:left;
}
#editFields span{
	color:#0066CC;
}

 
		</style>
		<script>
		function closeForm() {
			window.location.assign('<g:createLinkTo dir="/rateSchedule/list"/>')			
		}
		</script>
<script type="text/javascript" src="${resource(dir: 'js', file: 'jquery-1.3.2.js')}"></script>
<script type="text/javascript" src="${resource(dir: 'js', file: 'jquery-ui-1.7.2.js')}"></script>

<link rel="stylesheet" href="${resource(dir: 'css', file: 'jquery.window.css')}" type="text/css">
<script type="text/javascript" src="${resource(dir: 'js', file: 'jquery.window.js')}"></script>



<script>

	var grpInnerWindow 
	var innerWindowClosed = true;
	function closeAllIFrames() {
		if(grpInnerWindow) {
			grpInnerWindow.close()
		}
	}


</script>
<style>
	div.right-corner {
	    position: absolute;
	    top: 0px;
	    right: 0;
	    margin-right: 40px;
	    font:normal normal 21pt / 1 Tahoma;
	    color: #48802C;
	}
</style>
	</head>
	<body>
		<a href="#edit-agencyRateSchedule" class="skip" tabindex="-1"><g:message code="default.link.skip.label" default="Skip to content&hellip;"/></a>
		<div class="nav" role="navigation">
			<ul>
				<li><g:link class="list" action="edit" params="${[seqRateId: rateSchHdrInstance?.seqRateId, rateId: rateSchHdrInstance?.rateId, description: rateSchHdrInstance?.description, retentionPeriod: rateSchHdrInstance?.retentionPeriod, editType :'MASTER']}">Master Record</g:link></li>
				<li><g:link class="list" action="edit" params="${[seqRateId: rateSchHdrInstance?.seqRateId, rateId: rateSchHdrInstance?.rateId, description: rateSchHdrInstance?.description, retentionPeriod: rateSchHdrInstance?.retentionPeriod, editType :'DETAIL']}">Detail Records</g:link></li>
				
			</ul>
		</div>
		<div id="edit-agencyRateSchedule" class="content scaffold-edit" role="main">
			<g:if test="${params.editType?.equals("MASTER") || params.editType?.equals("DETAIL") }">
				<h1 style="color: #48802C"><g:message code="default.edit.label" args="[entityName]" /> - ${ params.editType}</h1>
			</g:if>
			<div class="right-corner" align="center">
				<g:if test="${("MASTER".equals(request.getParameter('editType')))}">COMMR</g:if>
				<g:if test="${("DETAIL".equals(request.getParameter('editType')))}">COMMR</g:if>
			</div>
			<g:if test="${flash.message}">
				<div class="message" role="status">${flash.message}</div>
			</g:if>
			<g:if test="${fieldErrors}">
				<ul class="errors" role="alert">
					<g:each in="${fieldErrors}" var="error">
						<li>
							${error}
						</li>
					</g:each>
				</ul>
			</g:if>
			<g:if test="${params.editType?.equals("MASTER")}">
				<g:form action="update" id="agencyRateScheduleForm" name="agencyRateScheduleForm">
				<div id="errorDisplay" style="display: none;" class="errors"
					style="float:left; margin: -5px 10px 0px 0px; "></div>
						<fieldset class="form">
							<g:render template="form" />
						</fieldset>
						<fieldset class="buttons">
							<g:actionSubmit class="save" action="update" value="${message(code: 'default.button.update.label', default: 'Update')}" />
							<g:if test="${isEditable}">
							<g:actionSubmit class="delete" action="delete" value="${message(code: 'default.button.delete.label', default: 'Delete')}" onclick="return confirm('${message(code: 'default.button.delete.confirm.message', default: 'Are you sure?')}');" />
							</g:if>
							<div style="align:right;display:inline" >
								<input type="Reset" class="reset" value="Reset" />
								<input type="button" class="close" value="Close" onClick="closeForm()"/>
							</div>
						</fieldset>
				</g:form>
			</g:if>
			<g:elseif test="${params.editType?.equals("DETAIL")}">
					<g:form action="update" id="agencyRateSchDetailForm" name="agencyRateSchDetailForm">
						<div id="errorDisplay" style="display: none;" class="errors"
							style="float:left; margin: -5px 10px 0px 0px; "></div>
							<fieldset class="form">
									<g:render template="agencyRateSchDetailForm"/>
							</fieldset>
							<fieldset class="buttons">
							<g:if test="${isEditable}">
									<div style="align:left;display:inline">
										<g:actionSubmit class="save" action="update" value="${message(code: 'default.button.update.label', default: 'Update')}" />
									</div> 
							</g:if>
									<div style="align:right;display:inline" >
									<g:if test="${isEditable}">
										<input type="Reset" class="reset" value="Reset" onclick="document.forms['agencyRateScheduleForm'].reset();"/>
									</g:if>
										<input type="button" class="close" value="Close" name="close" onClick="closeForm()"/>
									</div>
							</fieldset>
					</g:form>	
			</g:elseif>
			
		</div>
	</body>
</html>