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
		
		<script type="text/javascript" src="${resource(dir: 'js', file: 'jquery.validate.js')}"></script>
		<script type="text/javascript" src="${resource(dir: 'js', file: 'additional-methods.js')}"></script>	
		<script type="text/javascript" src="${resource(dir: 'js', file: 'jquery.maskedinput.js')}"></script>
		<script type="text/javascript" src="${resource(dir: 'js', file: 'jquery.alphanum.js')}"></script>
		
		<script type="text/javascript">

		$(document).ready(function() {

			$.validator.addMethod("customValidation1", function(value, element) {
				return this.optional(element) || /^[a-zA-Z0-9-. ]+$/i.test(value);
			}, "Please enter letters, numbers, hyphen, period and space only");


			jQuery.validator.addMethod("numberValidation", function(value, element) {
				return this.optional(element) || /^[0-9]+$/.test(value);				
			}, "Please enter only numbers 0 through 9");
			
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
							 'agentEFT.0.accountNumber' : {
								required : true,
								numberValidation : true
							},
							'agentEFT.0.nameOnAccount' : {
								required : true,
								customValidation1 : true
							},
							'agentEFT.0.bankName' : {
								required : true,
								customValidation1 : true
							},
							'agentEFT.0.routingNumber' : {
								required : true,
								numberValidation:true
							},
							'agentEFT.0.description' : {
								customValidation1 : true
							},
							'agentEFT.0.statusFlag' : {
								required : true
							},
							'agentEFT.0.effectiveDate_day' : {
								required : true
							},
							'agentEFT.0.effectiveDate_month' : {
								required : true
							},
							'agentEFT.0.effectiveDate_year' : {
								required : true
							},
							'agentEFT.0.termReason' :  {
								required : function(element){														
									return $.trim($("#agentEFT\\.0\\.termDate_year").val()).length > 0 ||
									$.trim($("#agentEFT\\.0\\.termDate_month").val()).length > 0 ||
									$.trim($("#agentEFT\\.0\\.termDate_day").val()).length > 0;						
								}
							},
							'agentEFT.0.termDate_year' :  {
								required : function(element){														
									return $.trim($("#agentEFT\\.0\\.termReason").val()).length > 0 	;						
								},
								greaterThan:[ "#agentEFT\\.0\\.effectiveDate","#agentEFT\\.0\\.termDate","Effective Date","Term Date"]
							},
							'agentEFT.0.termDate_month' :  {
								required : function(element){														
									return $.trim($("#agentEFT\\.0\\.termReason").val()).length > 0 	;						
								}
							},
							'agentEFT.0.termDate_day' :  {
								required : function(element){														
									return $.trim($("#agentEFT\\.0\\.termReason").val()).length > 0 	;						
								}
							},'agentEFT.0.accountType' : {
								required : true
								
							},	
									
				},
					messages : {
						'agentEFT.0.accountNumber' : {
							required : "Please enter the Account Number",
							numberValidation : "Please enter numbers only for Bank Account No."
						},
						'agentEFT.0.nameOnAccount' : {
							required : "Please enter the Name on Account",
							customValidation1 : "Please enter letters, numbers, hyphen, space and period only for Name on Account"
						},
						'agentEFT.0.bankName' : {
							required : "Please enter the Bank Name",
							customValidation1 : "Please enter letters, numbers, hyphen, spaces and period only for Bank Name"
						},
						'agentEFT.0.routingNumber' : {
							required : "Please enter the ABA Routing No.",
							numberValidation : "Please enter numbers only for ABA Routing No."
						},
						'agentEFT.0.description' : {
							customValidation1 : "Please enter letters, numbers, hyphen, spaces and period only for Account Description."
						},
						'agentEFT.0.statusFlag' : {
							required : "Please select a Status",
						},
						'agentEFT.0.effectiveDate_day' : {
							required : "Please enter the Effective Date"
						},
						'agentEFT.0.effectiveDate_month' : {
							required : "Please enter the Effective Month"
						},
						'agentEFT.0.effectiveDate_year' : {
							required : "Please enter the Effective Year"
						},
					    'agentEFT.0.termReason' :  {
							required : "Term Reason is a mandatory field if Term Date is entered, please enter the Term Reason"
						},
						'agentEFT.0.termDate_year' :  {
							required : "Term Date is a mandatory field if Term Reason is entered, please enter the Term Year"
						},
						'agentEFT.0.termDate_month' :  {
							required : "Term Date is a mandatory field if Term Reason is entered, please enter the Term Month"
						},
						'agentEFT.0.termDate_day' :  {
							required : "Term Date is a mandatory field if Term Reason is entered, please enter the Term Date"
						},'agentEFT.0.accountType' : {
							required : "Please select an Account Type"
		
						},	
						
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

	<div id="show-agencyBanking" class="content scaffold-show" role="main">
		<h1 style="color: #48802C">Create Agency Banking</h1>
		<div class="right-corner" align="center">BRBNK</div>
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
		<g:hasErrors bean="${agentEFT}">
			<ul class="errors" role="alert">
				<g:eachError bean="${agentEFT}" var="error">
				<li <g:if test="${error in org.springframework.validation.FieldError}">data-field-id="${error.field}"</g:if>><g:message error="${error}"/></li>
				</g:eachError>
			</ul>
			</g:hasErrors>
		<div id="errorDisplay" style="display: none;" class="errors"
			style="float:left; margin: -5px 10px 0px 0px; "></div>

		<g:form action="saveAgentEft" id="editForm" name="editForm">
		<input type="hidden" name="seqAgencyId" value="${agencyInstance?.seqAgencyId} ">
		<table>
			<tr>
				<td>
					<table class="report" border="0" style="table-layout: fixed;" id="report">
						<tr>
							<td class="tdnoWrap">
								<div class="fieldcontain ${hasErrors(bean: agentEFT, field: 'accountNumber', 'error')} ">
									<label for="accountNumber" style="padding-right:30px;"> 
										<g:message code="agentMaster.agentEft.accountNumber.label" default="Bank Account No" />
										<span class="required-indicator">*</span> :
									</label>									
									<g:secureTextField name="agentEFT.0.accountNumber" value="${agentEFT?.accountNumber}"  title="The Bank Account Number"
									maxlength="25" tableName="AGENT_EFT" attributeName="accountNumber" id="accountNumber"></g:secureTextField>
								</div>
							</td>
							<td class="tdnoWrap">
								<div class="fieldcontain ${hasErrors(bean: agentEFT, field: 'nameOnAccount', 'error')} ">
									<label for="nameOnAccount" style="padding-right:40px;"> 
										<g:message code="agentMaster.agentEft.nameOnAccount.label" default="Name on Account" />
											<span class="required-indicator">*</span> :
									</label>
								    <g:secureTextField name="agentEFT.0.nameOnAccount" value="${agentEFT?.nameOnAccount}" title="The Name on the Account"
								    maxlength="60" tableName="AGENT_EFT" attributeName="nameOnAccount" id="nameOnAccount"></g:secureTextField>
										  
								</div>
							</td>							
							<td class="tdnoWrap">
								<div class="fieldcontain ${hasErrors(bean: agentEFT, field: 'bankName', 'error')} ">
									<label for="bankName" style="padding-right:15px;"> 
										<g:message code="agentMaster.agentEft.bankName.label" default="Bank Name" />
											<span class="required-indicator">*</span> :
									</label>
								    <g:secureTextField name="agentEFT.0.bankName" value="${agentEFT?.bankName}" title="The Bank Name"
								    maxlength="60" tableName="AGENT_EFT" attributeName="bankName" id="bankName"></g:secureTextField>
										  
								</div>
							</td>
						</tr>
						<tr>
							<td class="tdnoWrap">
								<div class="fieldcontain ${hasErrors(bean: agentEFT, field: 'routingNumber', 'error')} ">
									<label for="routingNumber" style="padding-right:30px;"> 
										<g:message code="agentMaster.agentEft.routingNumber.label" default="ABA Routing No" />
										<span class="required-indicator">*</span> :
				                     </label>	
									 <g:secureTextField name="agentEFT.0.routingNumber"	title="The ABA Routing Number of the Bank"
										value="${agentEFT?.routingNumber}"  maxlength="9" tableName="AGENT_EFT" attributeName="routingNumber"></g:secureTextField>
								</div>
							</td>
							<td class="tdnoWrap">
								<div class="fieldcontain ${hasErrors(bean: agentEFT, field: 'description', 'error')} ">
									<label for="description" style="padding-right:40px;"> 
										<g:message code="agentMaster.agentEft.description.label" default="Account Description"  /> :
									</label>
									<g:secureTextField name="agentEFT.0.description" title="The Bank Account Description"	
										value="${agentEFT?.description}"  maxlength="60" tableName="AGENT_EFT" attributeName="description"></g:secureTextField>
								</div>
							</td>
							
							<td class="tdnoWrap">
								<div class="fieldcontain ${hasErrors(bean: agentEFT, field: 'accountType', 'error')} ">
									<label for="accountType" style="padding-right:15px;"> 
										<g:message code="agentMaster.agentEft.accountType.label" default="Account Type"  />
									    <span class="required-indicator">*</span> :
									</label>
									<g:secureComboBox id="accountType" name="agentEFT.0.accountType" title="The Bank Account Type" 
				                                  tableName="AGENT_EFT" attributeName="accountType"
				                                  value="${agentEFT?.accountType}"
				                                  from="${['' : '-- Select the Account Type --', 'C': 'C – Checking' , 'S': 'S – Savings']}" optionValue="value" optionKey="key">
				                    </g:secureComboBox>		
								</div>
							</td>
						</tr>					
						<tr>
						<td class="tdnoWrap">
								<div class="fieldcontain ${hasErrors(bean: agentEFT, field: 'statusFlag', 'error')} ">
									<label for="statusFlag" style="padding-right:30px;"> 
										<g:message code="agentMaster.agentEft.statusFlag.label" default="Status"  />
										<span class="required-indicator">*</span> :
									</label>
									<g:secureComboBox id="statusFlag" name="agentEFT.0.statusFlag" title="The Account Status" 
				                                  tableName="AGENT_EFT" attributeName="statusFlag"
				                                  value="${agentEFT?.statusFlag}"
				                                  from="${['' : '-- Select the Status --', 'P': 'P – Primary' , 'S': 'S - Secondary']}" optionValue="value" optionKey="key">
				                    </g:secureComboBox>		
								</div>
							</td>
							<td class="tdnoWrap" style="white-space: nowrap">
								<div class="fieldcontain ${hasErrors(bean: agentEFT, field: 'effectiveDate', 'error')} ">
									<label for="effectiveDate" style="padding-right:40px;"> 
										<g:message code="agentMaster.agentEft.effectiveDate.label" default="Effective Date " /> 
										<span class="required-indicator">*</span> :
										</label>
										<g:datePicker name="agentEFT.0.effectiveDate" precision="day" noSelection="['':'']" title="The Bank Account Effective Date"
											title ="The Effective date of the Address"
											value="${agentEFT?.effectiveDate}" default="none" />		
								</div>
							</td>						
							<td class="tdnoWrap" style="white-space: nowrap">
								<div class="fieldcontain ${hasErrors(bean: agentEFT, field: 'termDate', 'error')} ">
									<label for="termDate" style="padding-right:15px;"> 
										<g:message code="agentMaster.agentEFT.termDate.label" default="Term Date " /> :
									</label>
									<g:datePicker name="agentEFT.0.termDate" precision="day" noSelection="['':'']" title="The Bank Account Term Date"
											title ="The Termination date of the Address"
											value="${agentEFT?.termDate}" default="none" />
								</div>
							</td>		
						</tr>
						<tr>
						<td class="tdnoWrap" style="white-space: nowrap">
								<div class="fieldcontain ${hasErrors(bean: agentEFT, field: 'termReason', 'error')} ">
									<label for="termReason" style="padding-right:30px;"> 
										<g:message code="agentEFT.termReason.label" default="Term Reason " /> :
									</label>
									<g:textField maxlength="5" title="The Termination Reason of the Address" title="The Bank Account Term Reason" maxlength="5"
										name="agentEFT.0.termReason" 
										value="${agentEFT?.termReason}"/>
									<input type="hidden" id="reasonCodeTypeHidden" value="TM" />
									<img width="25" height="25" style="float:none;vertical-align:bottom" class="magnifying"
										src="${resource(dir: 'images', file: 'Search-icon.png')}"
										onclick="lookup('agentEFT.0.termReason', 'com.perotsystems.diamond.dao.cdo.ReasonCodeMaster','reasonCode','reasonCodeTypeHidden','reasonCodeType')">
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
				<g:actionSubmit class="create" action="saveAgencyEft" 
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
