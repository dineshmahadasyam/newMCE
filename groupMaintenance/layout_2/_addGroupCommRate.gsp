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
		<script type="text/javascript" src="${resource(dir: 'js', file: 'jquery.alphanum.js')}"></script>
		
		<script type="text/javascript" src="${resource(dir: 'js', file: 'commonfunctions.js')}"></script>
		<script type="text/javascript" src="${resource(dir: 'js', file: 'jquery.validate.js')}"></script>
		
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

				function closeForm() {
					window.location.assign('<g:createLinkTo dir="/groupMaintenance/list"/>')			
				}

			$(function($){
					
					$("#rateId").alphanum({
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
							 	'rateId' : {
									required : true
							 	},
						 		'agencyGroupCommsRate.0.effectiveDate_day' : {
									required : true
								},
								'agencyGroupCommsRate.0.effectiveDate_month' : {
									required : true
								},
								'agencyGroupCommsRate.0.effectiveDate_year' : {
									required : true
								},
								'agencyGroupCommsRate.0.overrideAmtType' :  {
									required : function(element){														
										return $.trim($("#agencyGroupCommsRate\\.0\\.overrideAmt").val()).length > 0 	;						
									},
								},
						},
					    messages : {
						 	'rateId' : {
								required : "Please enter Rate ID"
						 	},
						 	'agencyGroupCommsRate.0.effectiveDate' : {
						 		required : "Please enter Effective Date"
						 	},
							'agencyGroupCommsRate.0.effectiveDate_day' : {
								required : "Please enter the Effective Date"
							},
							'agencyGroupCommsRate.0.effectiveDate_month' : {
								required : "Please enter the Effective Month"
							},
							'agencyGroupCommsRate.0.effectiveDate_year' : {
								required : "Please enter the Effective Year"
							},
							'agencyGroupCommsRate.0.overrideAmtType' :  {
								required : "Amt Type is required when override Amt is entered"
							},
						 	
						}
					})
					});

					});
				function upperMe() { 
					document.getElementById("rateId").value = document.getElementById("rateId").value.toUpperCase(); 
				}

				function getCurrencySymbol() {
					var overrideAmtTypeId = document.getElementById('agencyGroupCommsRate.0.overrideAmtType').value;
					
					
					if(overrideAmtTypeId != null){
						if(overrideAmtTypeId == "A"){
							document.getElementById('currSymbol').value = "$"
							}
						else if(overrideAmtTypeId == "P"){
							document.getElementById('currSymbol').value = "%"
						}
						else if(overrideAmtTypeId == ""){
							document.getElementById('currSymbol').value = ""
						}
					}
					
			   }
				   

				$(document).ready(function() {
					getCurrencySymbol();
				}); 

				function populateCalcType(){
					
					 var rateId = document.getElementById("rateId").value;
					 if(rateId != null && rateId.trim() != ""){
						 var rateId = jQuery.ajax({
							url : '<g:createLinkTo dir="/groupMaintenance/ajaxPopulateCalcType"/>',				
							type : "POST",
							data : {rateId:rateId},
							success : function(result) {
								if(result != null && result == 'I'){
									document.getElementById("agencyGroupCommsRate.0.calcType").value="I"
										document.getElementById("calcType").value="I"
								}
								else if(result != null && result == 'C'){
									document.getElementById("agencyGroupCommsRate.0.calcType").value="C"
										document.getElementById("calcType").value="C"
								}
								else{
									document.getElementById("agencyGroupCommsRate.0.calcType").value=""
										document.getElementById("calcType").value=""
								}
								
							}
						});

					 }
					 else{
						 document.getElementById("agencyGroupCommsRate.0.calcType").value=""
							 document.getElementById("calcType").value=""
						 }
				}
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
		<h1 style="color: #48802C">Create Group Rate</h1>
		<div class="right-corner" align="center">COMMG</div>
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
		
		<g:hiddenField name="groupDBId" value="${groupMasterInstance?.groupDBId}" />
		<g:hiddenField name="groupId" value="${groupMasterInstance?.groupId}" />
		
		<g:form action="saveGroupRate" id="editForm" name="editForm">
		<input type="hidden" name="agencyGroupCommsRate.0.seqPremId" value="${premMasterInstance?.seqPremId} ">
		<input type="hidden" name="agencyGroupCommsRate.0.seqGroupId" value="${premMasterInstance?.seqGroupId} ">
		<input type="hidden" name="seqPremId" value="${premMasterInstance?.seqPremId} ">
		<g:hiddenField name="groupDBId" value="${groupMasterInstance?.groupDBId}" />
		<g:hiddenField name="groupId" value="${groupMasterInstance?.groupId}" />
		
		
		
		
		
		<table>
			<tr>
				<td>
					<table class="report" border="0" style="table-layout: fixed;" id="report">
						<tr>
							<td class="tdnoWrap">
								<div class="fieldcontain ${hasErrors(bean: agencyGroupCommsRate, field: 'effectiveDate', 'error')} ">
									<label for="effectiveDate"> 
										<g:message code="agencyGroupCommsRate.effectiveDate.label" default="Effective Date :" />
											<span class="required-indicator">*</span>
									</label>
																							
									<g:datePicker name="agencyGroupCommsRate.0.effectiveDate" precision="day" noSelection="['':'']"
												value="${agencyGroupCommsRate?.effectiveDate}" default="none" />
								</div>
							</td>
							<td class="tdnoWrap">
								<div class="fieldcontain ${hasErrors(bean: agencyGroupCommsRate, field: 'termDate', 'error')} ">
									<label for="termDate"> 
										<g:message code="agencyGroupCommsRate.termDate.label" default="Term Date :" />
									</label>
																							
									<g:datePicker name="agencyGroupCommsRate.0.termDate" precision="day" noSelection="['':'']"
												value="${agencyGroupCommsRate?.termDate}" default="none" />
										
									
								</div>
							</td>
						</tr>
						
						<tr>
							<td class="tdnoWrap">
								<div class="fieldcontain ${hasErrors(bean: agencyGroupCommsRate, field: 'overrideAmtType', 'error')} ">
									<label for="overrideAmt"> 
										<g:message code="agencyGroupCommsRate.overrideAmtType.label" default="Amount Type :" /> 
									</label>
									<g:secureComboBox	name="agencyGroupCommsRate.0.overrideAmtType" onchange="getCurrencySymbol();"
										tableName="AGENCY_GROUP_COMMS_RATES" attributeName="overrideAmtType" value="${agencyGroupCommsRate?.overrideAmtType}"
										from="${['' : '', 'A': 'A - Amount' , 'P': 'P - Percent']}" optionValue="value" optionKey="key">
							</g:secureComboBox>
								</div>
							</td>
							<td class="tdnoWrap">
								<div class="fieldcontain ${hasErrors(bean: agencyGroupCommsRate, field: 'overrideAmt', 'error')} ">
									<label for="overrideAmt"> 
										<g:message code="agencyGroupCommsRate.overrideAmt.label" default="Override Amt :" /> 
									</label>
									<g:textField name="currSymbol" id="currSymbol" value=""	maxlength="1" readonly="readonly" style="width:15px;border: none;background:none"/>
									<g:textField name="agencyGroupCommsRate.0.overrideAmt" value="${agencyGroupCommsRate?.overrideAmt}" class="amtNumeric" 
										maxlength="30" title="The Override Amount"/>
										
								</div>
							</td>
						</tr>
						<tr>
							<td class="tdnoWrap">
								<div class="fieldcontain ${hasErrors(bean: agencyGroupCommsRate, field: 'seqRateId', 'error')} ">
									<label for="overrideAmount"> 
										<g:message code="agencyGroupCommsRate.seqRateId.label" default="Rate ID :" /> 
										<span class="required-indicator">*</span>
									</label>
									<input type="hidden" id="agencyGroupCommsRate.0.seqRateId" name="agencyGroupContract.0.seqRateId" value="${agencyGroupCommsRate?.seqRateId}"/>
									<g:textField name="rateId" id="rateId" value="${params.rateId }" maxlength="15" onchange= "upperMe()" onblur="populateCalcType()"/>
									<img width="25" height="25"
										style="float: none; vertical-align: bottom"
										class="magnifying" src="${resource(dir: 'images', file: 'Search-icon.png')}"
										onclick="lookup('rateId', 'com.perotsystems.diamond.dao.cdo.AgencyRateScheduleHdr','rateId',null, null, 'agencyGroupCommsRate.0.seqRateId', 'seqRateId' )">
										
								</div>
							</td>
							<td class="tdnoWrap">
								<div class="fieldcontain ${hasErrors(bean: agencyGroupCommsRate, field: 'calcType', 'error')} ">
									<label for="calcType"> 
										<g:message code="calcType" default="Calc Type :" /> 
									</label>
									<input type="hidden" id="agencyGroupCommsRate.0.calcType" name="agencyGroupCommsRate.0.calcType" value="${agencyGrpCommsRate?.calcType}"	maxlength="1"/>
									<g:secureComboBox name="calcType" style="width: 150px" style="width:120px" disabled="disabled"
											tableName="AGENCY_GROUP_COMMS_RATES" attributeName="calcType" value="${agencyGrpCommsRate?.calcType}" 
											from="${['' : '', 'I': 'I - Incentive' , 'C': 'C - Commission']}" optionValue="value" optionKey="key"></g:secureComboBox>
										
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
				<g:actionSubmit class="create" action="saveGroupRate"
					value="${message(code: 'default.button.create.label', default: 'Create')}" />
				<input type="Reset" class="reset" value="Reset" />
				<input type="button" class="close" value="Close" name="Close" onClick="closeForm()"/>
			</fieldset>
		</g:form>
	</div>
	<div style="display: none">
		<input type="button" onClick="closeAllIFrames()" id="closeIframes">
	</div>
</body>
</html>
