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

		$(document).ready(function() {

			$(".maskZip").mask("99999?-9999");
			
			$.validator.addMethod("zipcodeUS", function(value, element) {
				return this.optional(element) || /\d{5}-\d{4}$|^\d{5}$/.test(value) || /\d{5}-____$/.test(value)
			}, "Zip Code must be 5 or 9 digits");

			$.validator.addMethod("customValidation1", function(value, element) {
				return this.optional(element) || /^[a-zA-Z0-9-. ]+$/i.test(value);
			}, "Please enter letters, numbers, hyphen, period and space only");

			$.validator.addMethod("customValidation2", function(value, element) {
				return this.optional(element) || /^[a-zA-Z. ]+$/i.test(value);
			}, "Please enter letters, period and space only");

			$.validator.addMethod("customValidation3", function(value, element) {
				return this.optional(element) || /^[a-zA-Z- ]+$/i.test(value);
			}, "Please enter letters and hyphen only");

			$.validator.addMethod("customValidation4", function(value, element) {
				return this.optional(element) || /^[a-zA-Z]+$/i.test(value);
			}, "Please enter letters only");

			$.validator.addMethod("zipcodeUS", function(value, element) {
				return this.optional(element) || /\d{5}-\d{4}$|^\d{5}$/.test(value) || /\d{5}-____$/.test(value)
			}, "Zip Code must be 5 or 9 digits");

			
			//Add extra validations for effective and term date.
			//New validation method to compare date fields.
			$.validator.addMethod("greaterThan", function(value, element, params) {
				//params[0]-start date field id
				//params[1]-end date field id
				//params[2]-start date field Name in error message
				//params[3]-end date field Name in error message
				//params[4]-form or tab name used to identify the date field id

				var startYear = params[0]+ "_year";
				var startMonth = params[0]+ "_month";
				var startDay = params[0]+ "_day";

				var endYear = params[1]+ "_year";
				var endMonth = params[1]+ "_month";
				var endDay = params[1]+ "_day";

				var startDate= new  Date($(startYear).val(),$(startMonth).val(), $(startDay).val());
				var endDate = new Date($(endYear).val(),$(endMonth).val(), $(endDay).val()) ;

				return this.optional(element) ||( $(startYear).val().length > 0 && $(startMonth).val().length > 0
							&& $(startDay).val().length > 0 && startDate.getTime() <= endDate.getTime()) ;

			}, $.format("{3} must be greater than {2}") );
				
			jQuery.validator.setDefaults({
				  debug: true,
					ignore: []
				});

			$(function() {		
				$("#editForm").validate({
					onfocusout: false,
					submitHandler: function (form) {
						  if ($(form).valid()) 
		                      form.submit(); 
		                  return false; // prevent normal form posting
			        },

			      	//jQuery validate selects the first invalid element or the last focused invalid element
			        //The code below will set focus to first element that fails
			        invalidHandler: function(form, validator) {
			            var errors = validator.numberOfInvalids();
			            if (errors) {       
			            	//Hide any previous message from the server when the client validation is occuring
			            	$(".message").hide();              
			                validator.errorList[0].element.focus();
			            }
			        },
			        
					errorLabelContainer: "#errorDisplay", 
					 wrapper: "li",		
					rules : {
							 'agencyAddress.0.addressLine1' : {
								required : true,
								customValidation1 : true
							},
							'agencyAddress.0.addressLine2' : {
								customValidation1 : true
							},
							'agencyAddress.0.city' : {
								required : true,
								customValidation2 : true
							},
							'agencyAddress.0.state' : {
								required : true
							},
							'agencyAddress.0.county' : {
								customValidation3 : true
							},
							'agencyAddress.0.country' : {
								customValidation4 : true
							},
							'agencyAddress.0.zipCode' : {
								required : true,
								zipcodeUS : true
							},
							'agencyAddress.0.addressType' : {
								required : true
							},
							'agencyAddress.0.effectiveDate_day' : {
								required : true
							},
							'agencyAddress.0.effectiveDate_month' : {
								required : true
							},
							'agencyAddress.0.effectiveDate_year' : {
								required : true
							},
							'agencyAddress.0.termReason' :  {
								required : function(element){														
									return $.trim($("#agencyAddress\\.0\\.termDate_year").val()).length > 0 ||
									$.trim($("#agencyAddress\\.0\\.termDate_month").val()).length > 0 ||
									$.trim($("#agencyAddress\\.0\\.termDate_day").val()).length > 0;						
								}
							},
							'agencyAddress.0.termDate_year' :  {
								required : function(element){														
									return $.trim($("#agencyAddress\\.0\\.termReason").val()).length > 0 	;						
								},
								greaterThan:[ "#agencyAddress\\.0\\.effectiveDate","#agencyAddress\\.0\\.termDate","Effective Date","Term Date"]
							},
							'agencyAddress.0.termDate_month' :  {
								required : function(element){														
									return $.trim($("#agencyAddress\\.0\\.termReason").val()).length > 0 	;						
								}
							},
							'agencyAddress.0.termDate_day' :  {
								required : function(element){														
									return $.trim($("#agencyAddress\\.0\\.termReason").val()).length > 0 	;						
								}
							}	
									
				},
					messages : {
						'agencyAddress.0.addressLine1' : {
							required : "Please enter the Address Line 1",
							customValidation1 : "Please enter letters, numbers, hyphen, space and period only for Address Line 1"
						},
						'agencyAddress.0.addressLine2' : {
							customValidation1 : "Please enter letters, numbers, hyphen, space and period only for Address Line 2"
						},
						'agencyAddress.0.city' : {
							required : "Please enter the City",
							customValidation2 : "Please enter letters, period and space only for City"
						},
						'agencyAddress.0.state' : {
							required : "Please select a State"
						},
						'agencyAddress.0.county' : {
							customValidation3 : "Please enter letters, space and hyphen only for County"
						},
						'agencyAddress.0.country' : {
							customValidation4 : "Please enter letters only for Country"
						},
						'agencyAddress.0.zipCode' : {
							required : "Please enter the Zip Code",
							zipcodeUS : "Zip Code must be 5 or 9 digits"
						},
						'agencyAddress.0.addressType' : {
							required : "Please select an Address Type"
						},
						'agencyAddress.0.effectiveDate_day' : {
							required : "Please enter the Effective Date"
						},
						'agencyAddress.0.effectiveDate_month' : {
							required : "Please enter the Effective Month"
						},
						'agencyAddress.0.effectiveDate_year' : {
							required : "Please enter the Effective Year"
						},
						'agencyAddress.0.termReason' :  {
							required : "Term Reason is a mandatory field if Term Date is entered, please enter the Term Reason"
						},
						'agencyAddress.0.termDate_year' :  {
							required : "Term Date is a mandatory field if Term Reason is entered, please enter the Term Year"
						},
						'agencyAddress.0.termDate_month' :  {
							required : "Term Date is a mandatory field if Term Reason is entered, please enter the Term Month"
						},
						'agencyAddress.0.termDate_day' :  {
							required : "Term Date is a mandatory field if Term Reason is entered, please enter the Term Date"
						}		
						
					} 
					 
				})
			});

			}); 
				
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
					window.location.assign('<g:createLinkTo dir="/agency/list"/>')			
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
		<h1 style="color: #48802C">Add Address to Agency : ${agencyInstance?.agencyId }</h1>
		<div class="right-corner" align="center">AGNCA</div>
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

		<g:form action="saveAddress" id="editForm" name="editForm">
		<input type="hidden" name="seqAgencyId" value="${agencyInstance?.seqAgencyId} ">
	
		<table>
			<tr>
				<td>
					<table class="report" border="0" style="table-layout: fixed;" id="report">
						<tr>
							<td class="tdnoWrap">
								<div class="fieldcontain ${hasErrors(bean: agentAddress, field: 'addressLine1', 'error')} ">
									<label for="addressLine1"> 
										<g:message code="agentAddress.addressLine1.label" default="Address Line 1 :" />
											<span class="required-indicator">*</span>
									</label>
									<g:textField name="agencyAddress.0.addressLine1" value="${agentAddress?.addressLine1}"  autofocus="autofocus"
										  title="The first Address line" maxlength="60" />
								</div>
							</td>
							<td class="tdnoWrap">
								<div class="fieldcontain ${hasErrors(bean: agentAddress, field: 'addressLine2', 'error')} ">
									<label for="addressLine2"> 
										<g:message code="agentAddress.addressLine2.label" default="Address Line 2 :" />
									</label>
									<g:textField name="agencyAddress.0.addressLine2" value="${agentAddress?.addressLine2}"  
									title="The 2nd Address line" maxlength="60" />
								</div>
							</td>
						</tr>
						<tr>
							<td class="tdnoWrap">
								<div class="fieldcontain ${hasErrors(bean: agentAddress, field: 'city', 'error')} ">
									<label for="lastName"> 
										<g:message code="agentAddress.city.label" default="City :" /> 
										<span class="required-indicator">*</span>
									</label>
									<g:textField name="agencyAddress.0.city" value="${agentAddress?.city}"   
										title="The City" maxlength="30" />
								</div>
							</td>
							<td class="tdnoWrap">
								<div class="fieldcontain ${hasErrors(bean: agentAddress, field: 'state', 'error')} ">
									<label for="state"> 
										<g:message code="agentAddress.state.label" default="State :" /> 
										<span class="required-indicator">*</span>
									</label>
									<g:select name="agencyAddress.0.state" optionKey="stateCode" optionValue="stateName"
									 id="agencyAddress.0.state" from="${states}" noSelection="['':'-- Select a State --']"
									  value="${agentAddress?.state}"></g:select>
								</div>
							</td>
						</tr>
						<tr>
							<td class="tdnoWrap">
								<div class="fieldcontain ${hasErrors(bean: agentAddress, field: 'county', 'error')} ">
									<label for="county"> 
										<g:message code="agentAddress.county.label" default="County :" />
									</label>
									<g:textField name="agencyAddress.0.county" title="The County" maxlength="30" value="${agentAddress?.county}" />
								</div>
							</td>
							<td class="tdnoWrap">
								<div class="fieldcontain ${hasErrors(bean: agentAddress, field: 'country', 'error')} ">
									<label for="county"> 
										<g:message code="agentAddress.country.label" default="Country :" />
									</label>
									<g:textField name="agencyAddress.0.country" title="The Country" maxlength="30" value="${agentAddress?.country}" />
								</div>
							</td>
						</tr>
						<tr>
							<td class="tdnoWrap">
								<div class="fieldcontain ${hasErrors(bean: agentAddress, field: 'zipCode', 'error')} ">
									<label for="zipCode"> 
										<g:message code="agentAddress.zipCode.label" default="Zip Code :" />
											<span class="required-indicator">*</span>
									</label>
									<g:textField name="agencyAddress.0.zipCode" value="${agentAddress?.zipCode}" class="maskZip"  
									title="5 or 9 digit Zip Code. Enter numbers only" />
								</div>
							</td>
							<td class="tdnoWrap">
								<div class="fieldcontain ${hasErrors(bean: agentAddress, field: 'addressType', 'error')} ">
									<label for="addressType"> 
										<g:message code="agentAddress.addressType.label" default="Address Type :" /> 
										<span class="required-indicator">*</span>
									</label>
									<g:getSystemCodeToken
											systemCodeType="AGENTAGENCYADDR" languageId="0"
											htmlElelmentId="agencyAddress.0.addressType"
											blankValue="Address Type"
											defaultValue="${agentAddress?.addressType}" width="135px" />
								</div>
							</td>
						</tr>
						<tr>
							<td class="tdnoWrap" style="white-space: nowrap">
								<div class="fieldcontain ${hasErrors(bean: agentAddress, field: 'effectiveDate', 'error')} ">
									<label for="effectiveDate"> 
										<g:message code="agentAddress.effectiveDate.label" default="Effective Date :" />
											<span class="required-indicator">*</span>
										</label>
										<g:datePicker name="agencyAddress.0.effectiveDate" precision="day" noSelection="['':'']" 
											title ="The Effective date of the Address"
											value="${agentAddress?.effectiveDate}" default="none" />		
								</div>
							</td>						
							<td class="tdnoWrap" style="white-space: nowrap">
								<div class="fieldcontain ${hasErrors(bean: agentAddress, field: 'termDate', 'error')} ">
									<label for="termDate"> 
										<g:message code="agentAddress.termDate.label" default="Term Date :" />
									</label>
									<g:datePicker name="agencyAddress.0.termDate" precision="day" noSelection="['':'']" 
											title ="The Termination date of the Address"
											value="${agentAddress?.termDate}" default="none" />
								</div>
							</td>		
						</tr>
						<tr>
							<td class="tdnoWrap" style="white-space: nowrap">
								<div class="fieldcontain ${hasErrors(bean: agentAddress, field: 'termReason', 'error')} ">
									<label for="termReason"> 
										<g:message code="agentAddress.termReason.label" default="Term Reason :" />
									</label>
									<g:textField maxlength="5" title="The Termination Reason of the Address"
										name="agencyAddress.0.termReason" 
										value="${agentAddress?.termReason}"/>
									<input type="hidden" id="reasonCodeTypeHidden" value="TM" />
									<img width="25" height="25" style="float:none;vertical-align:bottom" class="magnifying"
										src="${resource(dir: 'images', file: 'Search-icon.png')}"
										onclick="lookup('agencyAddress.0.termReason', 'com.perotsystems.diamond.dao.cdo.ReasonCodeMaster','reasonCode','reasonCodeTypeHidden','reasonCodeType')">
								</div>
							</td>				
						</tr>
						<tr><td>&nbsp;</td></tr>
						<tr>
							<td class="tdnoWrap" colspan="2">User Defined Information :
								<hr>
							</td>
						</tr>
						<tr>
							<td class="tdnoWrap">
								<div
									class="fieldcontain ${hasErrors(bean: agentAddress, field: 'userDefined1', 'error')} ">
									<label for="userDefined1">
										<g:userDefinedFieldLabel winId="AGNCA" datawindowId ="AGNCA" userDefineTextName="user_defined_1_t" defaultText="User Defined 1 "/>
									</label>
									<g:textField name="agencyAddress.0.userDefined1" maxlength="60"  value="${agentAddress?.userDefined1}" />
								</div>
							</td>
							<td class="tdnoWrap">
								<div
									class="fieldcontain ${hasErrors(bean: agentAddress, field: 'userDefined2', 'error')} ">
									<label for="userDefined2">
										<g:userDefinedFieldLabel winId="AGNCA" datawindowId ="AGNCA" userDefineTextName="user_defined_2_t" defaultText="User Defined 2 "/> 
									</label>
									<g:textField name="agencyAddress.0.userDefined2" maxlength="60"  value="${agentAddress?.userDefined2}" />
								</div>
							</td>
						</tr>
						<tr>
							<td class="tdnoWrap">
								<div
									class="fieldcontain ${hasErrors(bean: agentAddress, field: 'userDefinedDate1', 'error')} ">
									<label for="userDefinedDate"> 
										<g:userDefinedFieldLabel winId="AGNCA" datawindowId ="AGNCA" userDefineTextName="user_date_1_t" defaultText="User Date 1 "/>
									</label>
									<g:datePicker name="agencyAddress.0.userDate1" precision="day" noSelection="['':'']"
												value="${agentAddress?.userDate1}" default="none" />
								</div>
							</td>
							<td class="tdnoWrap">
								<div
									class="fieldcontain ${hasErrors(bean: agentAddress, field: 'userDefinedDate2', 'error')} ">
									<label for="userDefinedDate"> 
										<g:userDefinedFieldLabel winId="AGNCA" datawindowId ="AGNCA" userDefineTextName="user_date_2_t" defaultText="User Date 2 "/>
									</label>
									<g:datePicker name="agencyAddress.0.userDate2" precision="day" noSelection="['':'']"
												value="${agentAddress?.userDate2}" default="none" />
								</div>
							</td>
						</tr>
						<tr>
							<td class="tdnoWrap"></td>
						</tr>
					</table>
				</td>
			</tr>
		</table>
			<fieldset class="buttons">
				<g:actionSubmit class="save" action="saveAddress"
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
