<%@ page import="com.dell.diamond.fms.enums.PageNameEnum" %>
<!DOCTYPE html>
<html>
	<head>
		<meta name="layout" content="main">
		<g:set var="entityName" value="${message(code: 'agentMaster.label', default: 'AgentMaster')}" />
		<g:set var="appContext" bean="grailsApplication"/>
		<title><g:message code="default.edit.label" args="[entityName]" /></title>
		<g:set var="isShowCalendarIcon" value="${PageNameEnum.AGENT_CONTACT.equals(currentPage)?true:false}" />
		
		<!-- Main menu select -->
		<meta name="navSelector" content="maint"/>
		<!-- Child menu select -->
		
		<meta name="navChildSelector" content="agentMaster"/>
		<script type="text/javascript" src="${resource(dir: 'js', file: 'jquery.validate.js')}"></script>
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
							 'agentContact.0.contactName' : {
								required : true,
								customValidation1 : true
							},
							'agentContact.0.phoneNumber' : {
								required : true,
								phoneValidation: true
							},
							'agentContact.0.emailAddress': {
								email : true
							},
							'agentContact.0.faxNumber' : {
								phoneValidation: true
							},
							'agentContact.0.mobilePhone' : {
								phoneValidation: true
							},
							'agentContact.0.businessPhone' : {
								phoneValidation: true
							}
									
				},
					messages : {
						'agentContact.0.contactName' : {
							required : "Please enter the Name of the Contact",
							customValidation1 : "Please enter letters, numbers, hyphen, space and period only for Name of the Contact"
						},
						'agentContact.0.phoneNumber' : {
							required : "Please enter the Phone Number",
							phoneValidation: "Phone Number must be 10 digits"
						},
						'agentContact.0.emailAddress': {
							email : "Please enter a valid Email Address"
						},
						'agentContact.0.faxNumber' : {
							phoneValidation: "Fax Number must be 10 digits"
						},
						'agentContact.0.mobilePhone' : {
							phoneValidation: "Mobile Phone must be 10 digits"
						},
						'agentContact.0.businessPhone' : {
							phoneValidation: "Business Phone must be 10 digits"
						}
						
					} 
					 
				})
			});

			}); 
				
				function closeForm() {
					var seqAgentId = "${agentMasterInstance.seqAgentId}";
					var agentId = "${agentMasterInstance.agentId}";
					var agentType = "${agentMasterInstance.agentType}";
					
					var appName = "${appContext.metadata['app.name']}";
					window.location.assign("/"+appName+"/agentMaster/edit/?seqAgentId=" + seqAgentId + "&agentId="
					 + agentId + "&agentType=" + agentType + "&editType=CONTACT");
				}

				
		</script>
		
	</head>
	<div id="fms_content">
      <div id="fms_content_header">
        <div class="fms_content_header_note">
	      		<a href="${createLink(uri: '/agentMaster/list')}">Agent Maintenance</a> / 
	      		<g:link class="active" action="edit" params="${[seqAgentId: agentMasterInstance?.seqAgentId, agentId: agentMasterInstance?.agentId, agentType: agentMasterInstance?.agentType, editType :'CONTACT', creationDate:params.creationDate]}">Contacts</g:link>
	      			/Add Contact to Agent/Broker : ${agentMasterInstance?.agentId }
	  		</div>
 		<div class="fms_content_title">
    		<h1>Add Contact</h1>
  		</div>
	</div>
		<%-- START - Tabs --%>
			<div id="fms_content_tabs">
				  <ul>
					<li><g:link class="list" action="edit" params="${[seqAgentId: agentMasterInstance?.seqAgentId, agentId: agentMasterInstance?.agentId, agentType: agentMasterInstance?.agentType, editType :'MASTER', creationDate:params.creationDate]}">Master Record</g:link></li>
					<li><g:link class="list" action="edit" params="${[seqAgentId: agentMasterInstance?.seqAgentId, agentId: agentMasterInstance?.agentId, agentType: agentMasterInstance?.agentType, editType :'ADDRESS', creationDate:params.creationDate]}">Addresses</g:link></li>
					<li><g:link class="active" action="edit" params="${[seqAgentId: agentMasterInstance?.seqAgentId, agentId: agentMasterInstance?.agentId, agentType: agentMasterInstance?.agentType, editType :'CONTACT', creationDate:params.creationDate]}">Contacts</g:link></li>
					<li><g:link class="list" action="edit" params="${[seqAgentId: agentMasterInstance?.seqAgentId, agentId: agentMasterInstance?.agentId, agentType: agentMasterInstance?.agentType, editType :'TXN', creationDate:params.creationDate]}">Transactions</g:link></li>
					<li><g:link class="list" action="edit" params="${[seqAgentId: agentMasterInstance?.seqAgentId, agentId: agentMasterInstance?.agentId, agentType: agentMasterInstance?.agentType, editType :'COMMISSION', creationDate:params.creationDate]}">Broker Commissions</g:link></li>
					<li><g:link class="list" action="edit" params="${[seqAgentId: agentMasterInstance?.seqAgentId, agentId: agentMasterInstance?.agentId, agentType: agentMasterInstance?.agentType, editType :'CONTRACTS', creationDate:params.creationDate]}">Contracts</g:link></li>
				    <li><g:link class="list" action="edit" params="${[seqAgentId: agentMasterInstance?.seqAgentId, agentId: agentMasterInstance?.agentId, agentType: agentMasterInstance?.agentType, editType :'BANKING', creationDate:params.creationDate]}">Banking</g:link></li>
				    <li><g:link class="list" action="edit" params="${[seqAgentId: agentMasterInstance?.seqAgentId, agentId: agentMasterInstance?.agentId, agentType: agentMasterInstance?.agentType, editType :'LICENSE', callingPage: 'AGENT']}">License and Certification</g:link></li>
		          </ul>
			<div id="mobile_tabs_select"></div>
		</div>
		<%-- END - Tabs --%>
		<div id="fms_content_body">
		<div class="right-corner" align="right">AGNTC</div>
		<h2>Add Contact to Agent/Broker</h2>
		<div class="fms_required_legend fms_required">= required</div> 
	 	  	<div class="fms_form_border">
	    		<div class="fms_form_body fms_form_border">
					
		<%-- Error messages start--%>
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
		<ul id="errorDisplay" style="display: none;" class="errors" role="alert" style="float:left; margin: -5px 10px 0px 0px; "></ul>

		<g:form action="saveContact" id="editForm" name="editForm">
		<input type="hidden" name="seqAgentId" value="${agentMasterInstance?.seqAgentId} ">
		  <!-- START - WIDGET: General Information -->
		  
      			<div id="widgetGeneral" class="fms_widget"> 
      			<br></br>      
                  <fieldset class="no_border">
                 	<div class="fms_form_layout_2column">                  
		            	<div class="fms_form_column fms_long_labels">
							<label class="control-label fms_required" id="contactName_label" for="contactName">
								<g:message code="agentContact.contactName.label" default="Name :" />
							</label>
							<div class="fms_form_input">
								<g:textField 
								name="agentContact.0.contactName" 
								value="${agentContact?.contactName}"  
								autofocus="autofocus"
								title="The Contact Name" 
								maxlength="40" 
								Class="form-control"
								aria-labelledby="contactName_label" 
								aria-describedby="contactName_error" 
								aria-required="false"/>
								<div class="fms_form_error" id="contactName_error"></div>
							</div>
		
							<label class="control-label fms_required" id="phoneNumber_label" for="phoneNumber">
								<g:message code="agentContact.phoneNumber.label" default="Phone Number :" />
							</label>
							<div class="fms_form_input">
								<g:textField 
								name="agentContact.0.phoneNumber" 
								value="${agentContact?.phoneNumber}"  
								class="form-control maskPhoneNumber"
								title="The Primary Phone Number" 
								maxlength="40" 
								aria-labelledby="phoneNumber_label" 
								aria-describedby="phoneNumber_error" 
								aria-required="false"/>
								<div class="fms_form_error" id="phoneNumber_error"></div>
							</div>
							
							<label class="control-label" id="emailAddress_label" for="emailAddress">
								<g:message code="agentContact.emailAddress.label" default="Email Address :" />
							</label>
							<div class="fms_form_input">
								<g:textField 
								name="agentContact.0.emailAddress" 
								value="${agentContact?.emailAddress}"  
								title="The Email Address" 
								maxlength="100"
								Class="form-control" 
								aria-labelledby="emailAddress_label" 
								aria-describedby="emailAddress_error" 
								aria-required="false"/>
								<div class="fms_form_error" id="emailAddress_error"></div>
							</div>
							<label class="control-label" id="businessPhone_label" for="businessPhone">
								<g:message code="agentContact.businessPhone.label" default="Business Phone :" />
							</label>
							<div class="fms_form_input">
								<g:textField 
								name="agentContact.0.businessPhone" 
								value="${agentContact?.businessPhone}" 
								class="form-control maskPhoneNumber" 
								title="The Business Phone Number" 
								maxlength="40"
								aria-labelledby="businessPhone_label" 
								aria-describedby="businessPhone_error" 
								aria-required="false" />
							<div class="fms_form_error" id="businessPhone_error"></div>
							</div>
							
						</div>
						<div class="fms_form_column fms_long_labels">
							
							<label class="control-label" id="contactTitle_label" for="contactTitle">
								<g:message code="agentContact.contactTitle.label" default="Title :" />
							</label>
							<div class="fms_form_input">
								<g:getCdoSelectBox 
								cdoClassName="com.perotsystems.diamond.dao.cdo.ContactTitleMaster"
								cdoAttributeWhereValue="S"
								cdoAttributeWhere="titleType"
								cdoAttributeSelect="contactTitle"
								cdoAttributeSelectDesc="description"
								languageId="0"
								htmlElelmentId="agentContact.0.contactTitle"
								defaultValue="${agentContact?.contactTitle}"
								blankValue="Title" 
								className="form-control"
								aria-labelledby="contactTitle_label" 
								aria-describedby="contactTitle_error" 
								aria-required="false"/>
														
								 <div class="fms_form_error" id="contactTitle_error"></div>
							 </div>

							<label class="control-label" id="extension_label" for="extension">
							 <g:message code="agentContact.extension.label" default="Extension :" />
							</label>
							<div class="fms_form_input">
								<g:textField 
								name="agentContact.0.extension" 
								value="${agentContact?.extension}" 
								class="form-control maskExtension"  
								title="The Extension for the Phone Number" 
								maxlength="6"
								aria-labelledby="extension_label" 
								aria-describedby="extension_error" 
								aria-required="false" />
								 <div class="fms_form_error" id="extension_error"></div>
							</div>
													
							<label class="control-label" id="faxNumber_label" for="faxNumber">
								<g:message code="agentContact.faxNumber.label" default="Fax Number :" />
							</label>
							<div class="fms_form_input">
								<g:textField 
								name="agentContact.0.faxNumber"
								value="${agentContact?.faxNumber}"  
								class="form-control maskPhoneNumber"
								title="The Fax Number" 
								maxlength="40"
								aria-labelledby="faxNumber_label" 
								aria-describedby="faxNumber_error" 
								aria-required="false" />
							<div class="fms_form_error" id="faxNumber_error"></div>
							</div>
					
							<label class="control-label" id="mobilePhone_label" for="mobilePhone">
								<g:message code="agentContact.mobilePhone.label" default="Mobile Phone :" />
							</label>
							<div class="fms_form_input">
								<g:textField 
								name="agentContact.0.mobilePhone" 
								value="${agentContact?.mobilePhone}"  
								class="form-control maskPhoneNumber" 
								title="The Mobile Phone Number" 
								maxlength="40" 
								aria-labelledby="mobilePhone_label" 
								aria-describedby="mobilePhone_error" 
								aria-required="false"/>
							<div class="fms_form_error" id="mobilePhone_error"></div>
							</div>
						</div>
					</div>
				</fieldset>
			</div>
			<div class="fms_widget">
	              <fieldset class="no_border">
						<legend><h3>User Defined Information</h3></legend>
					<div class="fms_form_layout_2column">                  
							<div class="fms_form_column fms_long_labels">	
								
								<label class="control-label" for="userDefined1" id="userDefined1_label">
									<g:userDefinedFieldLabel winId="AGNTC" datawindowId ="AGNTC" userDefineTextName="user_defined_1_t" defaultText="User Defined 1 "/>
								</label>
			                    <div class="fms_form_input">
									<g:textField 
									name="agentContact.0.userDefined1" 
									maxlength="60"  
									value="${agentContact?.userDefined1}" 
									Class="form-control"
									aria-labelledby="userDefined1_label" 
									aria-describedby="userDefined1_error" 
									aria-required="false"/>
			                        <div class="fms_form_error" id="userDefined1_error"></div>
								</div>
								
								
							 	<label class="control-label" for="userDefinedDate" id="userDefinedDate_label">
									<g:userDefinedFieldLabel winId="AGNTC" datawindowId ="AGNTC" userDefineTextName="user_date_1_t" defaultText="User Date 1 "/>
								</label>
								<div class="fms_form_input">
									<fmsui:jqDatePickerUIUX 
										dateElementId="agentContact.0.userDate1"
										dateElementName="agentContact.0.userDate1"
										tableName="AGENT_CONTACT" 
										attributeName="userDate1" 
										default="none"
										datePickerOptions="changeMonth: true, changeYear: true, yearRange: '${((agentContact?.userDate1 != null ? agentContact?.userDate1.get(Calendar.YEAR):Calendar.getInstance().get(Calendar.YEAR)) - 100)} : ${((agentContact?.userDate1 != null ? agentContact?.userDate1.get(Calendar.YEAR):Calendar.getInstance().get(Calendar.YEAR)) + 100)}', numberOfMonths: 1"
										dateElementValue="${formatDate(format:'MM/dd/yyyy',date:agentContact?.userDate1)}"
										title="The User Date of the Person"
										ariaAttributes="aria-labelledby='userDefinedDate_label' aria-describedby='userDefinedDate_error' aria-required='false'" 
				                        classAttributes ="class='form-control fms_date_mask fms_small_input onDelete hasDatepicker' "
				                        showIconDefault="${isShowCalendarIcon}" />
									                   
									<div class="fms_form_error" id="userDefinedDate_error"></div>
								</div> 
							</div>
							<div class="fms_form_column fms_long_labels"> 
							 	   
								<label class="control-label" for="userDefined2" id="userDefined2_label">
									<g:userDefinedFieldLabel winId="AGNTC" datawindowId ="AGNTC" userDefineTextName="user_defined_2_t" defaultText="User Defined 2 "/> 
								</label>
								<div class="fms_form_input">
									<g:textField 
									name="agentContact.0.userDefined2" 
									maxlength="60"  
									value="${agentContact?.userDefined2}"
									Class="form-control"
									aria-labelledby="userDefined2_label" 
									aria-describedby="userDefined2_error" 
									aria-required="false" />
									<div class="fms_form_error" id="userDefined2_error"></div>
								</div>
								
								<label class="control-label" for="userDefinedDate" id="userDefinedDate_label">
										<g:userDefinedFieldLabel winId="AGNTC" datawindowId ="AGNTC" userDefineTextName="user_date_2_t" defaultText="User Date 2 "/>
								</label>
								<div class="fms_form_input">
								<fmsui:jqDatePickerUIUX
									dateElementId="agentContact.0.userDate2"
									tableName="AGENT_CONTACT" 
									attributeName="userDate2" 
									dateElementName="agentContact.0.userDate2" 
									datePickerOptions="changeMonth: true, changeYear: true, yearRange: '${((agentContact?.userDate2 != null ? agentContact?.userDate2.get(Calendar.YEAR):Calendar.getInstance().get(Calendar.YEAR)) - 100)} : ${((agentContact?.userDate2 != null ? agentContact?.userDate2.get(Calendar.YEAR):Calendar.getInstance().get(Calendar.YEAR)) + 100)}', numberOfMonths: 1"
									dateElementValue="${formatDate(format:'MM/dd/yyyy',date: agentContact?.userDate2)}"
									title="The User Date of the Person"
									ariaAttributes="aria-labelledby='userDefinedDate_label' aria-describedby='userDefinedDate_error' aria-required='false'" 
			                        classAttributes ="class='form-control fms_date_mask fms_small_input onDelete hasDatepicker' "
			                        showIconDefault="${isShowCalendarIcon}" />
									<div class="fms_form_error" id="userDefinedDate_error"></div>
							</div>
						</div>
					</div>
				</fieldset>
			</div>
		 <div class="fms_form_button">
              	<g:actionSubmit  class="btn btn-primary" action="saveContact" value="${message(code: 'default.button.save.label', default: 'Save')}" />
				<input class="btn btn-default" name="Reset" type="reset">
				<input type="button" class="btn btn-default" value="Cancel" onClick="closeForm()"/>
           </div>
             </div>
           </g:form>
		</div>
	</div>
</div>
</html>
