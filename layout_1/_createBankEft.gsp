<%@ page import="com.dell.diamond.fms.enums.PageNameEnum" %>
<!DOCTYPE html>
<html>
	<head>
		<meta name="layout" content="main">
		<g:set var="entityName" value="${message(code: 'agentMaster.label', default: 'AgentMaster')}" />
		<g:set var="isShowCalendarIcon" value="${PageNameEnum.AGENCY_ADD_BANKING.equals(currentPage)?true:false}" />
		<g:set var="appContext" bean="grailsApplication"/>
		<title><g:message code="default.edit.label" args="[entityName]" /></title>
		
		<!-- Main menu select -->
		<meta name="navSelector" content="maint"/>
		<!-- Child menu select -->
		<meta name="navChildSelector" content="agency"/>
			
		<script type="text/javascript" src="${resource(dir: 'js', file: 'jquery.validate.js')}"></script>
		<script type="text/javascript" src="${resource(dir: 'js', file: 'additional-methods.js')}"></script>	
		<script type="text/javascript" src="${resource(dir: 'js', file: 'jquery.alphanum.js')}"></script>
		
		<script type="text/javascript">

		$(document).ready(function() {
			jQuery.validator.setDefaults({
				ignore: ":hidden",	
				debug: true			 
				});

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
				
			$(function() {		
				$("#editForm").validate({
					onfocusout: false,
					submitHandler: function (form) {
						isInvalidForm = 'false';
						  if ($(form).valid()) 
		                      form.submit(); 
		                  return false; // prevent normal form posting
			        },

			      	//jQuery validate selects the first invalid element or the last focused invalid element
			        //The code below will set focus to first element that fails
			        invalidHandler: function(form, validator) {
			        	isInvalidForm = 'true'; 
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
							'agentEFT.0.effectiveDate' : {
								required : true
							},
							'agentEFT.0.termReason' :  {
								required : function(element){														
									return $.trim($("#agentEFT\\.0\\.termDate").val()).length > 0					
								}
							},
							'agentEFT.0.termDate' :  {
								required : function(element){														
									return $.trim($("#agentEFT\\.0\\.termReason").val()).length > 0 	;						
								},
								greaterThan:[ "#agentEFT\\.0\\.effectiveDate","#agentEFT\\.0\\.termDate","Effective Date","Term Date"]
							},
							'agentEFT.0.accountType' : {
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
						'agentEFT.0.effectiveDate' : {
							required : "Please enter the Effective Date"
						},
					    'agentEFT.0.termReason' :  {
							required : "Term Reason is a mandatory field if Term Date is entered, please enter the Term Reason"
						},
						'agentEFT.0.termDate' :  {
							required : "Term Date is a mandatory field if Term Reason is entered, please enter the Term Date"
						},
						'agentEFT.0.accountType' : {
							required : "Please select an Account Type"
		
						},	
						
					} 
					 
				})
			});

			}); 
			function closeForm() {
				var seqAgencyId = "${params.seqAgencyId}";
				var agencyId = "${params.agencyId}";
				var agencyType = "${params.agencyType}";
				
				var appName = "${appContext.metadata['app.name']}";
	
				window.location.assign("/"+appName+"/agency/edit?seqAgencyId=" + seqAgencyId +
				"?agencyId=" + agencyId + "&agencyType=" + agencyType + "&editType=BANKING&creationDate=");
	
			}

		</script>
	</head>
	<div id="fms_content">
		<div id="fms_content_header">
	    	<div class="fms_content_header_note">
	      		<a href="${createLink(uri: '/agency/list')}">Agency Maintenance</a> / 
	      		<g:link class="list" action="edit" params="${[seqAgencyId: agencyInstance?.seqAgencyId, agencyId: agencyInstance?.agencyId, agencyType: agencyInstance?.agencyType, editType :'BANKING']}">Banking</g:link>
	      			/ Add Agency Banking for Agent Id - ${agencyInstance?.seqAgencyId}
	      	</div>
		  	<div class="fms_content_title">
	          	<h1>Add Agency Banking</h1>
	        </div>
		</div> 
		<%-- START - Tabs --%>
			<div id="fms_content_tabs">
				<ul>
					<li><g:link class="list" action="edit" params="${[seqAgencyId: agencyInstance?.seqAgencyId, agencyId: agencyInstance?.agencyId, agencyType: agencyInstance?.agencyType, editType :'MASTER']}">Master Record</g:link></li>
					<li><g:link class="list" action="edit" params="${[seqAgencyId: agencyInstance?.seqAgencyId, agencyId: agencyInstance?.agencyId, agencyType: agencyInstance?.agencyType, editType :'ADDRESS']}">Addresses</g:link></li>
					<li><g:link class="list" action="edit" params="${[seqAgencyId: agencyInstance?.seqAgencyId, agencyId: agencyInstance?.agencyId, agencyType: agencyInstance?.agencyType, editType :'CONTACT']}">Contacts</g:link></li>
					<li><g:link class="list" action="edit" params="${[seqAgencyId: agencyInstance?.seqAgencyId, agencyId: agencyInstance?.agencyId, agencyType: agencyInstance?.agencyType, editType :'CONTRACTS']}">Contracts</g:link></li>
					<li><g:link class="active" action="edit" params="${[seqAgencyId: agencyInstance?.seqAgencyId, agencyId: agencyInstance?.agencyId, agencyType: agencyInstance?.agencyType, editType :'BANKING']}">Banking</g:link></li>
					<li><g:link class="list" action="edit" params="${[seqAgencyId: agencyInstance?.seqAgencyId, agencyId: agencyInstance?.agencyId, agencyType: agencyInstance?.agencyType, editType :'LICENSE', callingPage: 'AGENCY']}">License and Certification</g:link></li>
				</ul>
			<div id="mobile_tabs_select"></div>
		</div>
		<%-- END - Tabs --%>
		<!-- START - FMS Content Body -->
		<div id="fms_content_body">
			<div class="right-corner" align="right">BRBNK</div>
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
					<g:hasErrors bean="${agentEFT}">
						<ul class="errors" role="alert">
							<g:eachError bean="${agentEFT}" var="error">
							<li <g:if test="${error in org.springframework.validation.FieldError}">data-field-id="${error.field}"</g:if>><g:message error="${error}"/></li>
							</g:eachError>
						</ul>
					</g:hasErrors>
					<ul id="errorDisplay" style="display: none;" class="errors" role="alert" style="float:left; margin: -5px 10px 0px 0px; "></ul>
					<%-- Error messages end--%>
					
					<g:form action="saveAgentEft" id="editForm" name="editForm">
					<ul id="errorDisplay" style="display: none;" class="errors" role="alert" style="float:left; margin: -5px 10px 0px 0px; "></ul>
						<input type="hidden" name="seqAgencyId" value="${agencyInstance?.seqAgencyId} ">						
						<!-- START - WIDGET: General Information -->
		    			<div id="widgetGeneral" class="fms_widget">
		                  	<legend><h2>Add Agency Banking</h2></legend>
	                  		<div class="fms_form_layout_2column">                  
	                    		<div class="fms_form_column fms_very_long_labels">
									<label id="accountNumber_label" class="control-label fms_required" for="accountNumber"> 
										<g:message code="agentMaster.agentEft.accountNumber.label" default="Bank Account No:" />
									</label>
									<div class="fms_form_input">
										<g:secureTextField class="form-control" name="agentEFT.0.accountNumber" value="${agentEFT?.accountNumber}"  title="The Bank Account Number"
											maxlength="25" tableName="AGENT_EFT" attributeName="accountNumber" id="accountNumber"
											aria-labelledby="accountNumber_label" aria-describedby="accountNumber_error" aria-required="false">
										</g:secureTextField>
										<div class="fms_form_error" id="accountNumber_error"></div>
									</div>
									<label id="nameOnAccount_label" class="control-label fms_required" for="nameOnAccount">
										<g:message code="agentMaster.agentEft.nameOnAccount.label" default="Name on Account:" />
									</label>
									<div class="fms_form_input">
										<g:secureTextField class="form-control" name="agentEFT.0.nameOnAccount" value="${agentEFT?.nameOnAccount}" title="The Name on the Account"
								    		maxlength="60" tableName="AGENT_EFT" attributeName="nameOnAccount" id="nameOnAccount"
								    		aria-labelledby="nameOnAccount_label" aria-describedby="nameOnAccount_error" aria-required="false">
								    	</g:secureTextField>
    									<div class="fms_form_error" id="nameOnAccount_error"></div>
									</div>
									<label id="bankName_label" class="control-label fms_required" for="bankName"> 
										<g:message code="agentMaster.agentEft.bankName.label" default="Bank Name:" />
									</label>
									<div class="fms_form_input">
									    <g:secureTextField class="form-control" name="agentEFT.0.bankName" value="${agentEFT?.bankName}" title="The Bank Name"
								    		maxlength="60" tableName="AGENT_EFT" attributeName="bankName" id="bankName"
								    		aria-labelledby="bankName_label" aria-describedby="bankName_error" aria-required="false">
								    	</g:secureTextField>
									    <div class="fms_form_error" id="bankName_error"></div>	
									</div>
									<label id="routingNumber_label" class="control-label fms_required" for="routingNumber">
										<g:message code="agentMaster.agentEft.routingNumber.label" default="ABA Routing No:" />
		 							</label>
		 							<div class="fms_form_input">	
										<g:secureTextField class="form-control" id="routingNumber" name="agentEFT.0.routingNumber"	title="The ABA Routing Number of the Bank"
											value="${agentEFT?.routingNumber}"  maxlength="9" tableName="AGENT_EFT" attributeName="routingNumber"
											aria-labelledby="routingNumber_label" aria-describedby="routingNumber_error" aria-required="false">
									 	</g:secureTextField>
										<div class="fms_form_error" id="routingNumber_error"></div>	
									</div>
									<label id="description_label" class="control-label" for="description">
										<g:message code="agentMaster.agentEft.description.label" default="Account Description:"  />
									</label>
									<div class="fms_form_input">
										<g:secureTextField class="form-control" id="description" name="agentEFT.0.description" title="The Bank Account Description"	
											value="${agentEFT?.description}"  maxlength="60" tableName="AGENT_EFT" attributeName="description"
											aria-labelledby="description_label" aria-describedby="description_error" aria-required="false">
										</g:secureTextField>
										<div class="fms_form_error" id="description_error"></div>			
									</div>	
								</div>
								<div class="fms_form_column fms_long_labels">
									<label id="accountType_label" class="control-label fms_required" for="accountType">
										<g:message code="agentMaster.agentEft.accountType.label" default="Account Type:"  />
									</label>
									<div class="fms_form_input">
										<g:secureComboBox class="form-control" id="accountType" name="agentEFT.0.accountType" title="The Bank Account Type" 
				                                  tableName="AGENT_EFT" attributeName="accountType"
				                                  value="${agentEFT?.accountType}"
				                                  aria-labelledby="accountType_label" aria-describedby="accountType_error" aria-required="false"
				                                  from="${['' : '-- Select the Account Type --', 'C': 'C – Checking' , 'S': 'S – Savings']}" optionValue="value" optionKey="key">
				                    	</g:secureComboBox>
					                    <div class="fms_form_error" id="accountType_error"></div>	
									</div>
									<label id="statusFlag_label" class="control-label fms_required" for="statusFlag">
										<g:message code="agentMaster.agentEft.statusFlag.label" default="Status:"  />
									</label>
									<div class="fms_form_input">
										<g:secureComboBox class="form-control" id="statusFlag" name="agentEFT.0.statusFlag" title="The Account Status" 
				                                  tableName="AGENT_EFT" attributeName="statusFlag"
				                                  value="${agentEFT?.statusFlag}"
				                                  aria-labelledby="statusFlag_label" aria-describedby="statusFlag_error" aria-required="false"
				                                  from="${['' : '-- Select the Status --', 'P': 'P – Primary' , 'S': 'S - Secondary']}" optionValue="value" optionKey="key">
				                    	</g:secureComboBox>
					                    <div class="fms_form_error" id="statusFlag_error"></div>	
									</div>
									<label id="effectiveDate_label" class="control-label fms_required" for="effectiveDate">
										<g:message code="agentMaster.agentEft.effectiveDate.label" default="Effective Date: " /> 
									</label>
									<div class="fms_form_input">
										<fmsui:jqDatePickerUIUX 
											datePickerOptions="changeMonth:true, changeYear:true, yearRange:'-100:+100', numberOfMonths: 1"
	                                  		dateElementValue="${formatDate(format:'MM/dd/yyyy',date: agentEFT?.effectiveDate)}"
	                                  		dateElementId="agentEFT.0.effectiveDate" mandatory="mandatory" 
	                                  		dateElementName="agentEFT.0.effectiveDate" 
	                                        ariaAttributes="aria-labelledby='effectiveDate_label' aria-describedby='effectiveDate_error' aria-required='false'" 
	                                        classAttributes ="class='form-control fms_date_mask fms_small_input onDelete hasDatepicker' "
	                                        showIconDefault="${isShowCalendarIcon}"/>                                 
					                        <div class="fms_form_error" id="effectiveDate_error"></div>
									</div>
									<label id="termDate_label" class="control-label" for="termDate">	
										<g:message code="agentMaster.agentEFT.termDate.label" default="Term Date: " />
									</label>
									<div class="fms_form_input">
										<fmsui:jqDatePickerUIUX 
											datePickerOptions="changeMonth:true, changeYear:true, yearRange:'-100:+100', numberOfMonths: 1"
	                                  		dateElementValue="${formatDate(format:'MM/dd/yyyy',date: agentEFT?.termDate)}"
	                                  		dateElementId="agentEFT.0.termDate" 
	                                  		dateElementName="agentEFT.0.termDate" 
	                                        ariaAttributes="aria-labelledby='termDate_label' aria-describedby='termDate_error' aria-required='false'" 
	                                        classAttributes ="class='form-control fms_date_mask fms_small_input onDelete hasDatepicker' "
	                                        showIconDefault="${isShowCalendarIcon}"/>                                  
					                        <div class="fms_form_error" id="termDate_error"></div>
									</div>
									<label id="termReason_label" class="control-label" for="termReason">
										<g:message code="agentEFT.termReason.label" default="Term Reason:" /> 
									</label>
									<div class="fms_form_input fms_has_feedback">
										<g:textField class="form-control" 
													maxlength="5" 
													title="The Bank Account Term Reason"
													name="agentEFT.0.termReason" 
													tableName="AGENT_EFT" attributeName="termReason" 
													value="${agentEFT?.termReason}"
													aria-labelledby="termReason_label" aria-describedby="termReason_error" aria-required="false"/>
										
										<input type="hidden" id="reasonCodeTypeHidden" value="TM" />
										
										<fmsui:cdoLookup 
											lookupElementId="agentEFT.0.termReason"
											lookupElementName="agentEFT.0.termReason" 
											lookupElementValue="${agentEFT?.termReason}"
											lookupCDOClassName="com.perotsystems.diamond.dao.cdo.ReasonCodeMaster"
											lookupCDOClassAttribute="reasonCode" 
											htmlElementsToAddToQuery="reasonCodeTypeHidden"
											htmlElementsToAddToQueryCDOProperty="reasonCodeType" />
											<div class="fms_form_error" id="termReason_error"></div>	
									</div>
									</div>
							</div>
						</div>
						<div class="fms_form_button">
						 	<g:actionSubmit class="btn btn-primary" action="saveAgencyEft" value="${message(code: 'default.button.create.label', default: 'Create')}" />
						 	<input class="btn btn-default" type="reset">
							<input type="button" class="btn btn-default" name="close" value="${message(code: 'default.button.cancel.label', default: 'Cancel')}" onClick="closeForm()"/>
	      				</div>	
					</g:form>
				</div>
			</div>
		</div>
		<!-- END - FMS Content Body -->
	</div>
</html>
	