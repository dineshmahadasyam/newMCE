
<!DOCTYPE html>

<html>
	<head>
		<meta name="layout" content="main_2">
		<g:set var="entityName" value="${message(code: 'agentMaster.label', default: 'AgentMaster')}" />
		<g:set var="appContext" bean="grailsApplication"/>
		<title><g:message code="default.edit.label" args="[entityName]" /></title>
			
		<link rel="stylesheet" href="${resource(dir: 'css', file: 'jquery.window.css')}" type="text/css">
		<link rel="stylesheet" href="${resource(dir: 'css', file: 'member_pages.css')}" type="text/css">
		
		<script type="text/javascript" src="${resource(dir: 'js', file: 'jquery-1.3.2.js')}"></script>
		<script type="text/javascript" src="${resource(dir: 'js', file: 'jquery-ui-1.7.2.js')}"></script>
		<script type="text/javascript" src="${resource(dir: 'js', file: 'jquery.window.js')}"></script>
		
		<script type="text/javascript" src="http://ajax.aspnetcdn.com/ajax/jquery.validate/1.11.1/jquery.validate.js"></script>
		<script type="text/javascript" src="${resource(dir: 'js', file: 'additional-methods.js')}"></script>	
		<script type="text/javascript" src="${resource(dir: 'js', file: 'jquery.maskedinput.js')}"></script>
		<script type="text/javascript" src="${resource(dir: 'js', file: 'jquery.alphanum.js')}"></script>
		
		<script type="text/javascript">
				
				var grpInnerWindow
				var innerWindowClosed = true;
			
				function closeAllIFrames() {
					if (grpInnerWindow) {
						grpInnerWindow.close()
					}
				}
				
				function lookup(idName, cdoClassName, cdoClassAttributeName, assocFieldIds, assocFieldCdoName, updateFields, updateFieldsCdoName) 
				{
					var htmlElementValue
					var assocHTMLElementsValue = ""
					htmlElementValue = document.getElementById(idName).value
					if (assocFieldIds) {
						if (assocFieldIds.indexOf('|') == -1) {
							if (document.getElementById(assocFieldIds)
									&& document.getElementById(assocFieldIds).value != "undefined") {
								assocHTMLElementsValue = document
										.getElementById(assocFieldIds).value
							}
						} else {
							var nameArray = assocFieldIds.split("|")
							for ( var i = 0; i < nameArray.length; i++) {
								if (document.getElementById(nameArray[i])
										&& document.getElementById(nameArray[i]).value != "undefined") {
									//		alert (document.getElementById(nameArray[i]).value)
									assocHTMLElementsValue += document
											.getElementById(nameArray[i]).value
											+ "|"
								}
							}
						}
					}
					//alert("assocHTMLElementsValue = "+assocHTMLElementsValue )
					var appName = "${appContext.metadata['app.name']}";
					
					var urlValue = "/"+appName+"/lookUp/lookUp?htmlElementIdName="
							+ idName
							+ "&htmlElementValue="
							+ htmlElementValue
							+ "&cdoClassName="
							+ cdoClassName
							+ "&cdoClassAttributeName="
							+ cdoClassAttributeName
							+ (assocFieldIds ? "&assocFields=" + assocFieldIds : "")
							+ (assocFieldCdoName ? "&assocFieldCdoName="
									+ assocFieldCdoName : "")
							+ (assocHTMLElementsValue ? "&assocFieldValue="
									+ assocHTMLElementsValue : "")
							+ (updateFieldsCdoName ? "&updateFieldsCdoName="
									+ updateFieldsCdoName : "")
							+ (updateFields ? "&updateFields=" + updateFields : "")
							+ "&offset=0"
					if (!innerWindowClosed) {
						grpInnerWindow.setUrl(urlValue)
					} else {
						innerWindowClosed = false;
						grpInnerWindow = $.window({
							showModal : true,
							title : "Lookup",
							bookmarkable : false,
							minimizable : false,
							maximizable : false,
							width : 900,
							height : 350,
							scrollable : false,
							url : urlValue,
							onClose : function(wnd) { // a callback function while user click close button
								innerWindowClosed = true;
							}
						});
					}
				}

				function isNumberKey(evt) {
					var charCode = (evt.which) ? evt.which : event.keyCode;
				    if (charCode == 46 && evt.srcElement.value.split('.').length>1) {
				    	alert("Please enter numbers and decimal only for Rate Amount");
				        return false;
				    }
				    if (charCode != 46 && charCode > 31 && (charCode < 48 || charCode > 57)){
				    	alert("Please enter numbers and decimal only for Rate Amount");
				    	return false;
				        }
				        
				    return true;
				}

				
				
				function closeForm() {
					window.location.assign('<g:createLinkTo dir="/agency/list"/>')			
				}

				function populateDescription() {
					 var groupId = document.getElementById("groupId").value;

					 if(groupId != null && groupId != ""){
						 var descr = jQuery.ajax({
								url : '<g:createLinkTo dir="/agency/ajaxPopulateDescription"/>',
												
								type : "GET",
								data : {groupId:groupId},
								success : function(result) {

									var index = result.indexOf("-")
									
									if(index != null && index > 0){
										var seqDBId = result.substr(0 , index).trim()
										
										var desc = result.substr(index+1 , result.length)
										if(seqDBId != null && seqDBId != ""){
											document.getElementById("agentGroupContract.0.seqGroupId").value = seqDBId
											}
										else{
											document.getElementById("agentGroupContract.0.seqGroupId").value = null
											}

										if(desc != null){
											document.getElementById("description").value = desc
											}
										else{
											document.getElementById("description").value = ""
											}
									}
									else{
										document.getElementById("agentGroupContract.0.seqGroupId").value = null
										document.getElementById("description").value = ""
										}
								}
							});
					}
					 else{
						 document.getElementById("description").value=""
						 }
				}

				function upperMe() { 
					document.getElementById("groupId").value = document.getElementById("groupId").value.toUpperCase(); 
				}

				function lookupplanId(idName, cdoClassName, cdoClassAttributeName, setToIdName, setToIdName1) {

					var groupId = document.getElementById(idName).value
					if(groupId == null || groupId == "") {
						alert ("Please enter Group Id");
						return false;
					}

					var isValidGroupId= "";
					 var descr = jQuery.ajax({
							url : '<g:createLinkTo dir="/agency/ajaxValidateGroupId"/>',
							async: false,				
							type : "POST",
							data : {groupId:groupId},
							success : function(result) {
								isValidGroupId = result
							}
						});
					
					if(isValidGroupId == null || isValidGroupId != "true"){
						alert ("Please enter a valid Group Id");
						return false;
					}
					var htmlElementValue 
					var assocHTMLElementsValue
					if(idName.indexOf('|') == -1){			
						htmlElementValue = document.getElementById(idName).value
						assocHTMLElementsValue = htmlElementValue
					} else {
						var nameArray = idName.split("|")
						for (var i =0;i<nameArray.length;i++) {
							if(i == 0) {
								htmlElementValue = document.getElementById(nameArray[i]).value					
							}
							assocHTMLElementsValue += document.getElementById(nameArray[i]).value+"|"
						}
					}
					//alert("htmlElementValue = "+htmlElementValue )
					var appName = "${appContext.metadata['app.name']}";
					var urlValue = "/"+appName+"/lookUp/lookUpPlanId?htmlElementIdName=" + idName
							+ "&htmlElementValue=" + htmlElementValue 
							+ "&cdoClassName="+ cdoClassName 
							+ "&cdoClassAttributeName="+ cdoClassAttributeName 
							+ "&assocHTMLElementsValue="+ assocHTMLElementsValue 
							+ "&setToIdName=" + setToIdName
							+ "&setToIdName1=" + setToIdName1
							+ "&offset=0"
					//alert (urlValue )
					if (!innerWindowClosed) {
						grpInnerWindow.setUrl(urlValue)
					} else {
						innerWindowClosed = false;
						grpInnerWindow = $.window({
							showModal : true,
							title : "Lookup",
							bookmarkable : false,
							minimizable : false,
							maximizable : false,
							width : 900,
							height : 350,
							url : urlValue, 
						 onClose: function(wnd) { // a callback function while user click close button
							 innerWindowClosed = true;
						  }
						});
					}
				}

				$(function($){
					   
				   $("#groupId").alphanum({
						allow 		: '-_',
						allowSpace  : false
					});
				})

				jQuery.validator.setDefaults({
					ignore: [],
					  debug: true,
					  success: "valid"
					});

				$(document).ready(function(){

					$(".amtNumeric").numeric({});
					
					$(function() {	
					$( "#editForm" ).validate({
						onfocusout: false,
						submitHandler: function (form) {
							  if ($(form).valid()) 
					              form.submit(); 
					          return false; // prevent normal form posting
					    },
					  	
					    	invalidHandler: function(form, validator) {
					        var errors = validator.numberOfInvalids();
					        if (errors) {      
					        	$(".message").hide();              
					            validator.errorList[0].element.focus();
					        }
					    },
					    
						errorLabelContainer: "#errorDisplay", 
						 wrapper: "li",	

						rules : {
							 	'groupId' : {
									required : true
							 	},
					 			'0.planRiderCode' : {
					 				required : true
						 		},
						 		'agentGroupContract.0.seqGroupId' : {
						 			required : true
								 }
						},
					    messages : {
						 	'groupId' : {
								required : "Please enter Group ID"
						 	},
						 	'0.planRiderCode' : {
						 		required : "Please enter Plan/Rider Code"
						 	},
						 	'agentGroupContract.0.seqGroupId' : {
						 		required : "Please enter valid Group ID"
						 	}
						}
					})
					});

					});
				
		</script>
		
		<style type="text/css">
		
			#report {
				border-collapse: collapse;
			}
			
			#report h4 {
				margin: 0px;
				padding: 0px;
			}
			
			#report img {
				float: right;
			}
			
			#report ul {
				margin: 10px 0 10px 40px;
				padding: 0px;
			}
			
			#report td {none repeat-x scroll center left;
				color: #000;
				padding: 2px 15px;
			}
			
			#report tr.hideme {
				background: #C7DDEE none repeat-x scroll center left;
				color: #000;
				padding: 7px 15px;
			}
			
			#report td.clickme td {
				background: #fffff repeat-x scroll center left;
				cursor: pointer;
			}
			
			#report div.arrow {
				background: transparent url(arrows.png) no-repeat scroll 0px -16px;
				width: 16px;
				height: 16px;
				display: block;
			}
			
			#report div.up {
				background-position: 0px 0px;
			}
			
			#tdFormElement td {
				align: left
			}
			
			#tdnoWrap td {
				white-space: nowrap
			}
			
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

	<div id="show-agency" class="content scaffold-show" role="main">
		<h1 style="color: #48802C">Add Contract to Agent : ${agentMasterInstance?.agentId }</h1>
		<div class="right-corner" align="center">COMMC</div>
		<g:if test="${flash.message}">
			<div class="message" role="status">
				${flash.message}
			</div>
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
		<div id="errorDisplay" style="display: none;" class="errors"
			style="float:left; margin: -5px 10px 0px 0px; "></div>

		<g:form action="saveContract" id="editForm" name="editForm">
		<input type="hidden" name="agentGroupContract.0.seqAgencyId" value="${agentMasterInstance?.seqAgencyId} ">
		<input type="hidden" name="seqAgentId" value="${agentMasterInstance?.seqAgentId} ">
		<table>
			<tr>
				<td>
					<table class="report" border="0" style="table-layout: fixed;" id="report">
						<tr>
							<td class="tdnoWrap">
								<div class="fieldcontain ${hasErrors(bean: agentGroupContract, field: 'groupId', 'error')} ">
									<label for="groupId"> 
										<g:message code="agentGroupContract.groupId.label" default="Group ID :" />
											<span class="required-indicator">*</span>
									</label>
									
									<input type="hidden" id="agentGroupContract.0.seqGroupId" name="agentGroupContract.0.seqGroupId" value="${agentGroupContract?.seqGroupId}"/>														
									<g:textField name="groupId" id="groupId" value="${params.groupId }" title="The Group ID" onblur = "upperMe();populateDescription()"/>
									<img width="25" height="25" style="float:none;vertical-align:bottom" class="magnifying"
										src="${resource(dir: 'images', file: 'Search-icon.png')}"
										onclick="lookup('groupId', 'com.perotsystems.diamond.dao.cdo.GroupMaster','groupId',null, null, 'agentGroupContract.0.seqGroupId', 'seqGroupId' )">
										
								</div>
							</td>
							<td>
								<div class="fieldcontain">
									<label for="description"> 
										<g:message code="description.label" default="Description :" />
									</label>
									<g:textField name="description" id="description" value="${params.description }" readonly="readonly" style="margin-right: 5px;"/>
								</div>
							</td>
						</tr>
						<tr>
							<td class="tdnoWrap">
								<div class="fieldcontain ${hasErrors(bean: agentGroupContract, field: 'planRiderCode', 'error')} ">
									<label for="planRiderCode"> 
										<g:message code="agentGroupContract.planRiderCode.label" default="Plan/Rider Code :" />
										<span class="required-indicator">*</span>
									</label>
									<input type="hidden" id="agentGroupContract.0.seqPremId" name="agentGroupContract.0.seqPremId" value="${agentGroupContract?.seqPremId}"/>
									<g:textField name="0.planRiderCode" id="0.planRiderCode" value="${params.planRiderCode }" readonly="readonly"/>
									
									<img class="magnifying" width="25" height="25" src="${resource(dir: 'images', file: 'Search-icon.png')}"  style="float:none;vertical-align:bottom"
											onclick="lookupplanId('groupId', 'com.perotsystems.diamond.dao.cdo.PremiumMaster','seqGroupId', '0.planRiderCode','agentGroupContract.0.seqPremId')">
								</div>
							</td>
							<td class="tdnoWrap">
								<div class="fieldcontain ${hasErrors(bean: agentGroupContract, field: 'overrideAmount', 'error')} ">
									<label for="overrideAmount"> 
										<g:message code="agentGroupContract.overrideAmount.label" default="Override Amt :" /> 
									</label>
									<g:textField name="agentGroupContract.0.overrideAmount" value="${agentGroupContract?.overrideAmount}" class="amtNumeric" onkeypress="return isNumberKey(event)"
										maxlength="30" />
								</div>
							</td>
						</tr>
						
						<tr><td>&nbsp;</td></tr>
						<tr>
							<td class="tdnoWrap"></td>
						</tr>
					</table>
				</td>
			</tr>
		</table>
			<fieldset class="buttons">
				<g:actionSubmit class="save" action="saveContract"
					value="${message(code: 'default.button.create.label', default: 'Create')}" />
				<input type="Reset" class="reset" value="Reset" />
				<input type="button" class="close" value="Close" onClick="closeForm()"/>
			</fieldset>
		</g:form>
	</div>
	<div style="display: none">
		<input type="button" onClick="closeAllIFrames()" id="closeIframes">
	</div>
</body>
</html>
