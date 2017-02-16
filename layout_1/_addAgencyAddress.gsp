<%@ page import="com.dell.diamond.fms.enums.PageNameEnum" %>
<!DOCTYPE html>
<html>
	<head>
		<meta name="layout" content="main">
		<meta name="navSelector" content="maint"/>
		<meta name="navChildSelector" content="agency"/>
		<g:set var="entityName" value="${message(code: 'agentMaster.label', default: 'AgentMaster')}" />
		<g:set var="appContext" bean="grailsApplication"/>
		<title><g:message code="default.edit.label" args="[entityName]" /></title>
		<g:set var="isShowCalendarIcon" value="${PageNameEnum.AGENCY_ADD_ADDRESS.equals(currentPage)?true:false}" />
		<script type="text/javascript" src="${resource(dir: 'js', file: 'additional-methods.js')}"></script>
		<script type="text/javascript" src="${resource(dir: 'js', file: 'jquery.validate.js')}"></script>	
		<script type="text/javascript" src="${resource(dir: 'js', file: 'jquery.maskedinput.js')}"></script>
		<script type="text/javascript" src="${resource(dir: 'js', file: 'jquery.alphanum.js')}"></script>
		
		<script type="text/javascript">

		$(document).ready(function() {

			$(".maskZip").mask("?99999-9999");
			
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
							'agencyAddress.0.effectiveDate' : {
								required : true
							},
							'agencyAddress.0.termReason' :  {
								required : function(element){														
									return $.trim($("#agencyAddress\\.0\\.termDate_year").val()).length > 0 ||
									$.trim($("#agencyAddress\\.0\\.termDate_month").val()).length > 0 ||
									$.trim($("#agencyAddress\\.0\\.termDate_day").val()).length > 0;						
								}
							},
							'agencyAddress.0.termDate' :  {
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
						'agencyAddress.0.effectiveDate' : {
							required : "Please enter the Effective Date"
						},
						'agencyAddress.0.termReason' :  {
							required : "Term Reason is a mandatory field if Term Date is entered, please enter the Term Reason"
						},
						'agencyAddress.0.termDate' :  {
							required : "Term Date is a mandatory field if Term Reason is entered, please enter the Term Date"
						}		
						
					} 
					 
				})
			});

			}); 
				

		</script>
		
	<script type="text/javascript">


	function closeForm() {
		var seqAgencyId = "${agencyInstance.seqAgencyId}";
		var agencyId = "${agencyInstance.agencyId}";
		var agencyType = "${agencyInstance.agencyType}";
		
		var appName = "${appContext.metadata['app.name']}";
		window.location.assign("/"+appName+"/agency/edit/?seqAgencyId=" + seqAgencyId + "&agencyId="
		 + agencyId + "&agencyType=" + agencyType + "&editType=ADDRESS");
	}
	
	</script>
		
	</head>


	<!-- START - FMS Content -->
	<div id="fms_content">
		<div id="fms_content_header">
		  <div class="fms_content_header_note">
		    <a href="${createLink(uri: '/agency/list')}">Agency</a> / Add Address to Agency : ${agencyInstance?.agencyId }
		  </div>
		  <div class="fms_content_title">
		    <h1>Add Address to Agency</h1>
		  </div>
		</div> 
		<%-- START - Tabs --%>
		<div id="fms_content_tabs">
			<ul>
				<li><g:link class="list" action="edit" params="${[seqAgencyId: agencyInstance?.seqAgencyId, agencyId: agencyInstance?.agencyId, agencyType: agentMasterInstance?.agentType, editType :'MASTER', creationDate:params.creationDate]}">Master Record</g:link></li>
				<li><g:link class="active" action="edit" params="${[seqAgencyId: agencyInstance?.seqAgencyId, agencyId: agencyInstance?.agencyId, agencyType: agentMasterInstance?.agentType, editType :'ADDRESS', creationDate:params.creationDate]}">Addresses</g:link></li>
				<li><g:link class="list" action="edit" params="${[seqAgencyId: agencyInstance?.seqAgencyId, agencyId: agencyInstance?.agencyId, agencyType: agentMasterInstance?.agentType, editType :'CONTACT', creationDate:params.creationDate]}">Contacts</g:link></li>
				<li><g:link class="list" action="edit" params="${[seqAgencyId: agencyInstance?.seqAgencyId, agencyId: agencyInstance?.agencyId, agencyType: agentMasterInstance?.agentType, editType :'CONTRACTS', creationDate:params.creationDate]}">Contracts</g:link></li>
			    <li><g:link class="list" action="edit" params="${[seqAgencyId: agencyInstance?.seqAgencyId, agencyId: agencyInstance?.agencyId, agencyType: agentMasterInstance?.agentType, editType :'BANKING', creationDate:params.creationDate]}">Banking</g:link></li>
			    <li><g:link class="list" action="edit" params="${[seqAgencyId: agencyInstance?.seqAgencyId, agencyId: agencyInstance?.agencyId, agencyType: agentMasterInstance?.agentType, editType :'LICENSE', , callingPage: 'AGENCY']}">License and Certification</g:link></li>
			</ul>
			<div id="mobile_tabs_select"></div>
		</div>
		<%-- END - Tabs --%>
	
		<!-- START - FMS Content Body -->
		<div id="fms_content_body">
		<div class="right-corner" align="right">AGNCA</div>
		
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
		<%-- Error messages End--%>		
		
		<div class="fms_required_legend fms_required">= required</div> 
 	  	<div class="fms_form_border">
		<div class="fms_form_body fms_form_border">

		<g:form action="saveAddress" id="editForm" name="editForm">
		<input type="hidden" name="seqAgencyId" value="${agencyInstance?.seqAgencyId} ">
	
					<!-- START - WIDGET: General Information -->
	    			<div id="widgetGeneral" class="fms_widget">
			 			<fieldset class="no_border">
	                  		<legend><h3>General Information</h3></legend>
	                  		<div class="fms_form_layout_2column">                  
	                    		<div class="fms_form_column fms_very_long_labels">
	                    		
		            <label class="control-label fms_required" id="addressLine1_label" for="addressLine1">
		            	<g:message code="agentAddress.addressLine1.label" default="Address Line 1 :" />
		            </label>
		            <div class="fms_form_input">
		               	<g:textField name="agencyAddress.0.addressLine1" 
		               				 value="${agentAddress?.addressLine1}"  autofocus="autofocus"
		               				 title="The first Address line" maxlength="60" 
		               				 class="form-control"/>
		               <div class="fms_form_error" id="addressLine1_error"></div>
		            </div>  

		            <label class="control-label fms_required" id="city_label" for="city">
		            	<g:message code="agentAddress.city.label" default="City :" />
		            </label>
		            <div class="fms_form_input">
					   	<g:textField name="agencyAddress.0.city" value="${agentAddress?.city}"
					   				 title="The City" maxlength="30"
					   				 class="form-control"/>
		               <div class="fms_form_error" id="city_error"></div>
		            </div>  

		            <label class="control-label" id="county_label" for="county">
		            	<g:message code="agentAddress.county.label" default="County :" />
		            </label>
		            <div class="fms_form_input">
					   <g:textField name="agencyAddress.0.county" title="The County" maxlength="30" value="${agentAddress?.county}"
					   class="form-control" aria-labelledby="county_label" aria-describedby="county_error" aria-required="false" />
		               <div class="fms_form_error" id="county_error"></div>
		            </div>  

		            <label class="control-label fms_required" id="zipCode_label" for="zipCode">
		            	<g:message code="agentAddress.zipCode.label" default="Zip Code :" />
		            </label>
		            <div class="fms_form_input">
		               	<g:textField name="agencyAddress.0.zipCode" value="${agentAddress?.zipCode}" class="maskZip" placeholder="00000-0000"
									 title="5 or 9 digit Zip Code. Enter numbers only" class="form-control maskZip" 
									 aria-labelledby="zipCode_label" aria-describedby="zipCode_error" aria-required="false" />
		               <div class="fms_form_error" id="zipCode_error"></div>
		            </div>  

		            <label class="control-label fms_required" id="effectiveDate_label" for="effectiveDate">
		            	<g:message code="agentAddress.effectiveDate.label" default="Effective Date :" />
		            </label>
		            <div class="fms_form_input">
						<fmsui:jqDatePickerUIUX
                 				datePickerOptions="changeMonth:true, changeYear:true, yearRange:'-100:+100', numberOfMonths: 1"
								dateElementId="agencyAddress.0.effectiveDate"
								dateElementName="agencyAddress.0.effectiveDate" 
								dateElementValue="${formatDate(format:'MM/dd/yyyy',date: agentAddress?.effectiveDate)}"
								ariaAttributes="aria-labelledby='effectiveDate_label' aria-describedby='effectiveDate_error' aria-required='false'" 
		                        classAttributes ="class='form-control fms_date_mask fms_small_input onDelete hasDatepicker' "
		                        showIconDefault="${isShowCalendarIcon}"/>
		               <div class="fms_form_error" id="effectiveDate_error"></div>
		            </div>  

		            <label class="control-label" id="termReason_label" for="termReason">
		            	<g:message code="agentAddress.termReason.label" default="Term Reason :" />
		            </label>
		            <div class="fms_form_input fms_has_feedback">
					<input type="hidden" id="reasonCodeTypeHidden" value="TM" />		            
                    <g:secureTextField class="form-control" id="agencyAddress.0.termReason"
									name="agencyAddress.0.termReason" maxlength="5"
									tableName="AGENT_ADDRESS" attributeName="termReason"
									value="${agentAddress?.termReason}"
									title="The Termination Reason of the Address">
					</g:secureTextField>
					<fmsui:cdoLookup lookupElementId="agencyAddress.0.termReason"
						   lookupElementName="agencyAddress.0.termReason" 
						   lookupElementValue="${agentAddress?.termReason}"
						   lookupCDOClassName="com.perotsystems.diamond.dao.cdo.ReasonCodeMaster"
						   lookupCDOClassAttribute="reasonCode"
						   htmlElementsToAddToQuery="reasonCodeTypeHidden"
						   htmlElementsToAddToQueryCDOProperty="reasonCodeType"/>
		               <div class="fms_form_error" id="termReason_error"></div>
		            </div>  
			                    		
           		</div>
           
           		<div class="fms_form_column fms_very_long_labels">
	
	
	
			        <label class="control-label" id="addressLine2_label" for="addressLine2">
		            	<g:message code="agentAddress.addressLine2.label" default="Address Line 2 :" />
		            </label>
		            <div class="fms_form_input">
		               	<g:textField name="agencyAddress.0.addressLine2" value="${agentAddress?.addressLine2}" title="The 2nd Address line" 
		               				 maxlength="60" class="form-control" aria-labelledby="addressLine2_label" aria-describedby="addressLine2_error" aria-required="false"/>
		               <div class="fms_form_error" id="addressLine2_error"></div>
		            </div>   											

		            <label class="control-label fms_required" id="state_label" for="state">
		            	<g:message code="agentAddress.state.label" default="State :" />
		            </label>
		            <div class="fms_form_input">
					   <g:secureComboBox class="form-control" name="agencyAddress.0.state"  optionKey="stateCode"
							tableName="AGENT_ADDRESS" attributeName="state" 
							optionValue="stateName" id="agentAddress.${i}.state" from="${states}"
							noSelection="['':'-- Select a State --']"
							value="${agentAddress?.state}"
							aria-labelledby="state_label" 
						    aria-describedby="state_error" 
						    aria-required="false">
					   </g:secureComboBox>
		               <div class="fms_form_error" id="state_error"></div>
		            </div>   											

		            <label class="control-label" id="country_label" for="country">
		            	<g:message code="agentAddress.country.label" default="Country :" />
		            </label>
		            <div class="fms_form_input">
						<g:textField name="agencyAddress.0.country" title="The Country" maxlength="30" value="${agentAddress?.country}" 
						 class="form-control" aria-labelledby="country_label" aria-describedby="country_error" aria-required="false"/>
		               <div class="fms_form_error" id="country_error"></div>
		            </div>   											

		            <label class="control-label fms_required" id="addressType_label" for="addressType">
		            	<g:message code="agentAddress.addressType.label" default="Address Type :" />
		            </label>
		            <div class="fms_form_input">
						<g:getSystemCodeToken cssClass="form-control" 
									systemCodeType="AGENTAGENCYADDR" languageId="0"
									htmlElelmentId="agencyAddress.0.addressType"
									blankValue="Address Type" 
									defaultValue="${agentAddress?.addressType}" 
									aria-labelledby="addressType_label"
									aria-describedby="addressType_error" aria-required="false" />

		               <div class="fms_form_error" id="addressType_error"></div>
		            </div>   											

		            <label class="control-label" id="termDate_label" for="termDate">
		            	<g:message code="agentAddress.termDate.label" default="Term Date :" />
		            </label>
		            <div class="fms_form_input">
						<fmsui:jqDatePickerUIUX
                 				datePickerOptions="changeMonth:true, changeYear:true, yearRange:'-100:+100', numberOfMonths: 1"
								dateElementId="agencyAddress.0.termDate"
								dateElementName="agencyAddress.0.termDate" 
								dateElementValue="${formatDate(format:'MM/dd/yyyy',date:agentAddress?.termDate)}" 
								ariaAttributes="aria-labelledby='termDate_label' aria-describedby='termDate_error' aria-required='false'" 
		                        classAttributes ="class='form-control fms_date_mask fms_small_input onDelete hasDatepicker' "
		                        showIconDefault="${isShowCalendarIcon}"/>
		               <div class="fms_form_error" id="termDate_error"></div>
		            </div>							
			                    		
               </div>
           </div>
       </fieldset>
	</div>
			<!-- END - WIDGET: General Information -->
			
			<!-- START - WIDGET: User Defined Information -->
   			<div id="widgetGeneral" class="fms_widget">
	 			<fieldset class="no_border">
                 		<legend><h3>User Defined Information</h3></legend>
                 		<div class="fms_form_layout_2column">                  
                   		<div class="fms_form_column fms_very_long_labels">
			                    		
			                 <label class="control-label" id="userDefined1_label" for="userDefined1">
			                 	<g:userDefinedFieldLabel winId="AGNCA" datawindowId ="AGNCA" userDefineTextName="user_defined_1_t" defaultText="User Defined 1 "/>
			                 </label>
			                 <div class="fms_form_input">
								<g:textField name="agencyAddress.0.userDefined1" maxlength="60"  value="${agentAddress?.userDefined1}" 
									class="form-control" aria-labelledby="status_label" aria-describedby="status_error" aria-required="false"/>
			                    <div class="fms_form_error" id="userDefined1_error"></div>
			                 </div>   
			
			                 <label class="control-label" id="userDate1_label" for="userDate1">
			                 	<g:userDefinedFieldLabel winId="AGNCA" datawindowId ="AGNCA" userDefineTextName="user_date_1_t" defaultText="User Date 1 "/>
			                 </label>
			                 <div class="fms_form_input">

								<fmsui:jqDatePickerUIUX
		                 				datePickerOptions="changeMonth:true, changeYear:true, yearRange:'-100:+100', numberOfMonths: 1"
										dateElementId="agencyAddress.0.userDate1"
										dateElementName="agencyAddress.0.userDate1" 
										dateElementValue="${formatDate(format:'MM/dd/yyyy',date:agentAddress?.userDate1)}"
										ariaAttributes="aria-labelledby='userDate1_label' aria-describedby='userDate1_error' aria-required='false'" 
				                        classAttributes ="class='form-control fms_date_mask fms_small_input onDelete hasDatepicker' "
				                        showIconDefault="${isShowCalendarIcon}"/>

					
			                    <div class="fms_form_error" id="userDate1_error"></div>
			                 </div>			                    		
           		
           		</div>
           
           		<div class="fms_form_column fms_very_long_labels">

                  <label class="control-label" id="userDefined2_label" for="userDefined2">
                  		<g:userDefinedFieldLabel winId="AGNCA" datawindowId ="AGNCA" userDefineTextName="user_defined_2_t" defaultText="User Defined 2 "/>
                  </label>
                  <div class="fms_form_input">
					<g:textField name="agencyAddress.0.userDefined2" maxlength="60"  value="${agentAddress?.userDefined2}" 
							class="form-control" aria-labelledby="status_label" aria-describedby="status_error" aria-required="false"/>
                     <div class="fms_form_error" id="userDefined2_error"></div>
                  </div> 

                  <label class="control-label" id="userDate2_label" for="userDate2">
                  	<g:userDefinedFieldLabel winId="AGNCA" datawindowId ="AGNCA" userDefineTextName="user_date_2_t" defaultText="User Date 2 "/>
                  </label>
                  <div class="fms_form_input">
					<fmsui:jqDatePickerUIUX
                				datePickerOptions="changeMonth:true, changeYear:true, yearRange:'-100:+100', numberOfMonths: 1"
							dateElementId="agencyAddress.0.userDate2"
							dateElementName="agencyAddress.0.userDate2" 
							dateElementValue="${formatDate(format:'MM/dd/yyyy',date:agentAddress?.userDate2)}"
							ariaAttributes="aria-labelledby='userDate2_label' aria-describedby='userDate2_error' aria-required='false'" 
	                        classAttributes ="class='form-control fms_date_mask fms_small_input onDelete hasDatepicker' "
	                        showIconDefault="${isShowCalendarIcon}"/>
									
                     <div class="fms_form_error" id="userDate2_error"></div>
                  </div>  
			                    		
               </div>
           </div>
       </fieldset>
	</div>
   <!-- END - WIDGET: User Defined Information -->
							
							<div class="fms_form_button">
								<g:actionSubmit class="btn btn-primary" action="saveAddress"
									value="${message(code: 'default.button.save.label', default: 'Save')}" />
								<input type="Reset" class="btn btn-default" value="Reset" />
								<input type="button" class="btn btn-default" value="Cancel" onClick="closeForm()"/>
			      			</div>
		      			
						</g:form>
					</div>
				</div>
			</div>
		</div>
	</div>	

</html>
