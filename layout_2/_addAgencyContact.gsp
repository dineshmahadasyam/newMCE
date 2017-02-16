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
		
		<script type="text/javascript" src="${resource(dir: 'js', file: 'jquery.alphanum.js')}"></script>
		
		<script type="text/javascript">

		$(document).ready(function() {
			
			$(".maskPhoneNumber").mask("?999-999-9999");
				
			$(".maskExtension").mask("?999999");
			
			$.validator.addMethod("customValidation1", function(value, element) {
				return this.optional(element) || /^[a-zA-Z0-9-. ]+$/i.test(value);
			}, "Please enter letters, numbers, hyphen, period and space only");

			$.validator.addMethod("phoneValidation", function(value, element) {
				return this.optional(element) || /\d{3}-\d{3}-\d{4}$/.test(value) || /\d{10}$/.test(value)
			}, "Phone Number must be 10 digits");

						
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
							 'agencyContact.0.contactName' : {
								required : true,
								customValidation1 : true
							},
							'agencyContact.0.phoneNumber' : {
								required : true,
								phoneValidation: true
							},
							'agencyContact.0.emailAddress': {
								email : true
							},
							'agencyContact.0.faxNumber' : {
								phoneValidation: true
							},
							'agencyContact.0.mobilePhone' : {
								phoneValidation: true
							},
							'agencyContact.0.businessPhone' : {
								phoneValidation: true
							}
									
				},
					messages : {
						'agencyContact.0.contactName' : {
							required : "Please enter the Name of the Contact",
							customValidation1 : "Please enter letters, numbers, hyphen, space and period only for Name of the Contact"
						},
						'agencyContact.0.phoneNumber' : {
							required : "Please enter the Phone Number",
							phoneValidation: "Phone Number must be 10 digits"
						},
						'agencyContact.0.emailAddress': {
							email : "Please enter a valid Email Address"
						},
						'agencyContact.0.faxNumber' : {
							phoneValidation: "Fax Number must be 10 digits"
						},
						'agencyContact.0.mobilePhone' : {
							phoneValidation: "Mobile Phone must be 10 digits"
						},
						'agencyContact.0.businessPhone' : {
							phoneValidation: "Business Phone must be 10 digits"
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
		<h1 style="color: #48802C">Add Contact to Agency : ${agencyInstance?.agencyId }</h1>
		<div class="right-corner" align="center">AGNCC</div>
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

		<g:form action="saveContact" id="editForm" name="editForm">
		<input type="hidden" name="seqAgencyId" value="${agencyInstance?.seqAgencyId} ">
	
		<table>
			<tr>
				<td>
					<table class="report" border="0" style="table-layout: fixed;" id="report">
						<tr>
							<td class="tdnoWrap">
								<div class="fieldcontain ${hasErrors(bean: agentContact, field: 'contactName', 'error')} ">
									<label for="contactName"> 
										<g:message code="agencyContact.contactName.label" default="Name :" />
											<span class="required-indicator">*</span>
									</label>
									<g:textField name="agencyContact.0.contactName" value="${agentContact?.contactName}"  autofocus="autofocus"
										  title="The Contact Name" maxlength="40" />
								</div>
							</td>
							<td class="tdnoWrap">
								<div class="fieldcontain ${hasErrors(bean: agentContact, field: 'contactTitle', 'error')} ">
									<label for="contactTitle"> 
										<g:message code="agencyContact.contactTitle.label" default="Title :" />
									</label>
									<g:getCdoSelectBox cdoClassName="com.perotsystems.diamond.dao.cdo.ContactTitleMaster"
														cdoAttributeWhereValue="S"
														cdoAttributeWhere="titleType"
														cdoAttributeSelect="contactTitle"
														cdoAttributeSelectDesc="description"
														languageId="0"
														htmlElelmentId="agencyContact.0.contactTitle"
														defaultValue="${agentContact?.contactTitle}"
														blankValue="Title" 
														width="150px"/>
								</div>
							</td>
						</tr>
						<tr>
							<td class="tdnoWrap">
								<div class="fieldcontain ${hasErrors(bean: agentContact, field: 'phoneNumber', 'error')} ">
									<label for="phoneNumber"> 
										<g:message code="agencyContact.phoneNumber.label" default="Phone Number :" />
											<span class="required-indicator">*</span>
									</label>
									<g:textField name="agencyContact.0.phoneNumber" value="${agentContact?.phoneNumber}"  class="maskPhoneNumber"
										  title="The Primary Phone Number" maxlength="40" />
								</div>
							</td>
							<td class="tdnoWrap">
								<div class="fieldcontain ${hasErrors(bean: agentContact, field: 'extension', 'error')} ">
									<label for="extension"> 
										<g:message code="agencyContact.extension.label" default="Extension :" />
									</label>
									<g:textField name="agencyContact.0.extension" value="${agentContact?.extension}" class="maskExtension"  
										  title="The Extension for the Phone Number" maxlength="6" />
								</div>
							</td>
						</tr>
						<tr>
							<td class="tdnoWrap">
								<div class="fieldcontain ${hasErrors(bean: agentContact, field: 'emailAddress', 'error')} ">
									<label for="emailAddress"> 
										<g:message code="agencyContact.emailAddress.label" default="Email Address :" />
									</label>
									<g:textField name="agencyContact.0.emailAddress" value="${agentContact?.emailAddress}"  
										  title="The Email Address" maxlength="100" />
								</div>
							</td>
							<td class="tdnoWrap">
								<div class="fieldcontain ${hasErrors(bean: agentContact, field: 'faxNumber', 'error')} ">
									<label for="faxNumber"> 
										<g:message code="agencyContact.faxNumber.label" default="Fax Number :" />
									</label>
									<g:textField name="agencyContact.0.faxNumber" value="${agentContact?.faxNumber}"  class="maskPhoneNumber"
										  title="The Fax Number" maxlength="40" />
								</div>
							</td>
						</tr>
						<tr>
							<td class="tdnoWrap">
								<div class="fieldcontain ${hasErrors(bean: agentContact, field: 'businessPhone', 'error')} ">
									<label for="businessPhone"> 
										<g:message code="agencyContact.businessPhone.label" default="Business Phone :" />
									</label>
									<g:textField name="agencyContact.0.businessPhone" value="${agentContact?.businessPhone}" class="maskPhoneNumber" 
										  title="The Business Phone Number" maxlength="40" />
								</div>
							</td>
							<td class="tdnoWrap">
								<div class="fieldcontain ${hasErrors(bean: agentContact, field: 'mobilePhone', 'error')} ">
									<label for="mobilePhone"> 
										<g:message code="agencyContact.mobilePhone.label" default="Mobile Phone :" />
									</label>
									<g:textField name="agencyContact.0.mobilePhone" value="${agentContact?.mobilePhone}"  class="maskPhoneNumber" 
										  title="The Mobile Phone Number" maxlength="40" />
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
									class="fieldcontain ${hasErrors(bean: agentContact, field: 'userDefined1', 'error')} ">
									<label for="userDefined1">
										<g:userDefinedFieldLabel winId="AGNCC" datawindowId ="AGNCC" userDefineTextName="user_defined_1_t" defaultText="User Defined 1 "/>
									</label>
									<g:textField name="agencyContact.0.userDefined1" maxlength="60"  value="${agentContact?.userDefined1}" />
								</div>
							</td>
							<td class="tdnoWrap">
								<div
									class="fieldcontain ${hasErrors(bean: agentContact, field: 'userDefined2', 'error')} ">
									<label for="userDefined2">
										<g:userDefinedFieldLabel winId="AGNCC" datawindowId ="AGNCC" userDefineTextName="user_defined_2_t" defaultText="User Defined 2 "/> 
									</label>
									<g:textField name="agencyContact.0.userDefined2" maxlength="60"  value="${agentContact?.userDefined2}" />
								</div>
							</td>
						</tr>
						<tr>
							<td class="tdnoWrap">
								<div
									class="fieldcontain ${hasErrors(bean: agentContact, field: 'userDefinedDate1', 'error')} ">
									<label for="userDefinedDate"> 
										<g:userDefinedFieldLabel winId="AGNCC" datawindowId ="AGNCC" userDefineTextName="user_date_1_t" defaultText="User Date 1 "/>
									</label>
									<g:datePicker name="agencyContact.0.userDate1" precision="day" noSelection="['':'']"
												value="${agentContact?.userDate1}" default="none" />
								</div>
							</td>
							<td class="tdnoWrap">
								<div
									class="fieldcontain ${hasErrors(bean: agentContact, field: 'userDefinedDate2', 'error')} ">
									<label for="userDefinedDate"> 
										<g:userDefinedFieldLabel winId="AGNCC" datawindowId ="AGNCC" userDefineTextName="user_date_2_t" defaultText="User Date 2 "/>
									</label>
									<g:datePicker name="agencyContact.0.userDate2" precision="day" noSelection="['':'']"
												value="${agentContact?.userDate2}" default="none" />
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
				<g:actionSubmit class="save" action="saveContact"
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
