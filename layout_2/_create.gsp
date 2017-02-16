<%@ page import="com.perotsystems.diamond.bom.fms.Agency" %>
<!DOCTYPE html>
<html>
	<head>
				<meta name="layout" content="main_2">
		<g:set var="entityName" value="${message(code: 'agency.label', default: 'Agency')}" />
		<title><g:message code="default.create.label" args="[entityName]" /></title>
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
		</style>
		<script>
		function closeForm() {
			window.location.assign('<g:createLinkTo dir="/agency/list"/>')		
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
	    top: 2px;
	    right: 0;
	    margin-right: 40px;
	    font:normal normal 21pt / 1 Tahoma;
	    color: #48802C;
	}
</style>		
	</head>
	<body>
		<a href="#create-agencyMaster" class="skip" tabindex="-1"><g:message code="default.link.skip.label" default="Skip to content&hellip;"/></a>		
		<div id="create-agencyMaster" class="content scaffold-create" role="main">
			<h1 style="color: #48802C"><g:message code="default.create.label" args="[entityName]" /></h1>
			<div class="right-corner" align="center">AGNCM</div>
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
			
			<g:form action="save" id="agencyForm" name="agencyForm">
			<div id="errorDisplay" style="display: none;" class="errors"
				style="float:left; margin: -5px 10px 0px 0px; "></div>
				<fieldset class="form">
					<g:render template="form"/>
				</fieldset>
				<fieldset class="buttons">
					<g:submitButton name="create" class="create" value="${message(code: 'default.button.create.label', default: 'Create')}" />
					<div style="align:right;display:inline" >
						<input type="Reset" class="reset" value="Reset" />
						<input type="button" class="close" value="Close" onClick="closeForm()"/>
					</div>
				</fieldset>
			</g:form>
		</div>
		<div style="display:none">
			<input type="button" onClick="closeAllIFrames()" id="closeIframes" name="closeIframes">
		</div>
	</body>
</html>
