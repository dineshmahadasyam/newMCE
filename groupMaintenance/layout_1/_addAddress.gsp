<%@ page import="com.dell.diamond.fms.enums.PageNameEnum" %>
<%@ page import="com.perotsystems.diamond.bom.GroupEx"%>
<!DOCTYPE html>
<html>
	<head>
	
		<meta name="layout" content="main">
					
		<g:set var="entityName" value="${message(code: 'groupMaster.label', default: 'GroupMaster')}" />
			
		<g:set var="isShowCalendarIcon" value="${PageNameEnum.GROUP_ADD_ADDRESS.equals(currentPage)?true:false}" />
		
		<g:set var="appContext" bean="grailsApplication"/>
			
		<title><g:message code="default.edit.label" args="[entityName]" /></title>
	
		<!-- Main menu select -->
		<meta name="navSelector" content="maint"/>
		<!-- Child menu select -->
		<meta name="navChildSelector" content="groupMaintenance"/>
		
		<link rel="stylesheet" href="${resource(dir: 'css', file: 'jquery.window.css')}" type="text/css">
	
		
		<script type="text/javascript" src="${resource(dir: 'js', file: 'jquery.window.js')}"></script>
		<script type="text/javascript" src="${resource(dir: 'js', file: 'jquery.validate.js')}"></script>
		<script type="text/javascript" src="${resource(dir: 'js', file: 'jquery.maskedinput.js')}"></script>
		<script type="text/javascript" src="${resource(dir: 'js', file: 'additional-methods.js')}"></script>
	
		<script>
			$(function($){
				   $(".maskZip").mask("?99999-9999");
				})
		</script>
		
		<script type="text/javascript">
			$(document).ready(function(){
				
				jQuery.validator.addMethod("zipcode", function(value, element) {
					value = value.replace(/\s+/g, ""); 
					return this.optional(element) || /\d{5}-\d{4}$|^\d{5}$/.test(value) || /\d{5}-____$/.test(value) || /\d{9}$/.test(value)
				}, "Zip Code must be 5 or 9 digits.");

				jQuery.validator.setDefaults({
					ignore: ":hidden",
					debug: true			 
					});
				
			$(function() {		
					$("#editForm").validate({
						onfocusout: false,
						submitHandler: function (form) {
							  if ($(form).valid()) 
			                      form.submit(); 
			                  return false; // prevent normal form posting
				        },
						errorLabelContainer: "#errorDisplay", 
						 wrapper: "li",		
										
						rules : {
							'address.0.effectiveDate' : {
								required : true
							},
							'address.0.addressType' : {
								required : true
							}
							,'address.0.address1' : {
								required : true
							}
							,'address.0.city' : {
								required : true	
							},
							'address.0.state' : {
								required : true		
							},
							'address.0.zip' : {
								required : true,
								zipcode : true	
							},
							'address.0.homePhone' : {
								digits : true	
							},'address.0.mobilePhone': {
								digits : true	
							}
							,'address.0.beeperNumber': {
								digits : true	
							}
							,'address.0.alternatePhone': {
								digits : true	
							}
							,'address.0.faxNumber': {
								digits : true	
							}
							,'address.0.telephoneNumber': {
								digits : true	
							}
							,'address.0.telephoneNumberEx': {
								digits : true	
							},'address.0.socialSecurityNumber': {
								digits : true	
							}
							,'address.0.businessPhone': {
								digits : true	
							},
							'address.0.termReason' :  {
								required : function(element){														
									return $.trim($("#address\\.0\\.termDate").val()).length > 0;						
								}
							},
							'address.0.termDate' :  {
								required : function(element){														
									return $.trim($("#address\\.0\\.termReason").val()).length > 0 	;						
								},
								greaterThan:[ "#address\\.0\\.effectiveDate","#address\\.0\\.termDate","Effective Date","Term Date"]
							}	
							
						},
						messages : {
							'address.0.effectiveDate' : {
								required : "Please enter the Effective Date."
							},
							'address.0.addressType': {
								required : "Please Select a Address Type"						
							}
							,'address.0.address1' : {
								required : "Please enter the Address 1"						
							}
							,'address.0.city' : {
								required : "Please enter the City"					
							}
							,'address.0.state' : {
								required : "Please select a value for State"					
							}
							,'address.0.zip' : {
								required : "Please enter the Zip Code"	,
								zipcode : "Zip Code must be 5 or 9 digits" 
							},
							'address.0.homePhone' : {
								digits : "Please enter only numbers for Home Phone"
							},'address.0.mobilePhone': {
								digits : "Please enter only numbers for Mobile Phone"	
							}
							,'address.0.beeperNumber': {
								digits : "Please enter only numbers for Beeper Number"	
							}
							,'address.0.alternatePhone': {
								digits : "Please enter only numbers for Alternate Phone"	
							}
							,'address.0.faxNumber': {
								digits : "Please enter only numbers for Fax Number"	
							}
							,'address.0.telephoneNumber': {
								digits : "Please enter only numbers for Telephone Number"	
							}
							,'address.0.telephoneNumberEx': {
								digits : "Please enter only numbers for Telephone Ext"
							},'address.0.socialSecurityNumber': {
								digits : "Please enter only numbers for Social Security Number"	
							}
							,'address.0.businessPhone': {
								digits : "Please enter only numbers for Business Phone"	
							},
							'address.0.termReason' :  {
								required : "Term Reason is a mandatory field if Term Date is entered, please input the value for Term Reason"
							},
							'address.0.termDate' :  {
								required : "Term Date is a mandatory field if Term reason is entered, please input the value for Term Date"
							}	
						
						} 
						
					})
				});
			
			
			
			//add extra validations for effective and term date
			//New validation method to compare date fields.
			
			jQuery.validator.addMethod("greaterThan",
			function(value, element, params) {
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
							&& $(startDay).val().length > 0 && startDate < endDate) ;
			
			}, jQuery.format("{3} Must be greater than {2}") );
			
			
			
			}); 
			
		</script>
	
		<g:javascript>
			function closeForm() {
				var groupDBId = "${params.groupDBId}";
				var groupId = "${groupMasterInstance.groupId}";
				var appName = "${appContext.metadata['app.name']}";
				window.location.assign("/"+appName+"/groupMaintenance/edit/" + groupId +
				"?groupId=" + groupId + "&groupDBId=" + groupDBId + "&groupEditType=ADDRESS");
			}
			
				
		</g:javascript>
	
	
		<script type="text/javascript">
			var grpInnerWindow 
			var innerWindowClosed = true;
			function closeAllIFrames() {
				if(grpInnerWindow) {
					grpInnerWindow.close()
				}
			}
		</script>
		<script type="text/javascript">
			function displayCountryChangeMessage(){
				alert ("Only USA is allowed at this time. You many not change this value.");
			}
		</script>
	</head>
	
	<!-- START - FMS Content -->
	<div id="fms_content">
		<div id="fms_content_header">
	    	<div class="fms_content_header_note">
	      		<a href="${createLink(uri: '/groupMaintenance/list')}">Group Maintenance</a> / 
	      		<g:link class="list" action="edit" params="${[groupId: request.getParameter('groupId'), groupDBId : request.getParameter("groupDBId"), groupEditType :'ADDRESS']}">Group Addresses</g:link>
	      			/ Add Address to Group with GroupId - ${groupMasterInstance?.groupId}
	  		</div>
		  	<div class="fms_content_title">
	          	<h1>Add New Address</h1>
	        </div>
		</div> 
		 <%-- START - Tabs --%>
			<div id="fms_content_tabs">
				<ul>
					<li><g:link class="list" action="edit" params="${[groupId: request.getParameter('groupId'), groupDBId : request.getParameter("groupDBId"), groupEditType :'MASTER']}">Master Records</g:link></li>
				 	<li><g:link class="list" action="edit" params="${[groupId: request.getParameter('groupId'), groupDBId : request.getParameter("groupDBId"), groupEditType :'CONTRACT']}">Contracts</g:link></li>
					<li><g:link class="list" action="edit" params="${[groupId: request.getParameter('groupId'), groupDBId : request.getParameter("groupDBId"), groupEditType :'DETAIL']}">Detail Records</g:link></li>
					<li><g:link class="active" action="edit" params="${[groupId: request.getParameter('groupId'), groupDBId : request.getParameter("groupDBId"), groupEditType :'ADDRESS']}">Addresses</g:link></li>
					<li><g:link class="list" action="edit" params="${[groupId: request.getParameter('groupId'), groupDBId : request.getParameter("groupDBId"), groupEditType :'CONTACT']}">Contacts</g:link></li>
					<li><g:link class="list" action="edit" params="${[groupId: request.getParameter('groupId'), groupDBId : request.getParameter("groupDBId"), groupEditType :'COMMRATES']}">Group Rates</g:link></li>
				</ul>
			<div id="mobile_tabs_select"></div>
		</div>
		<%-- END - Tabs --%>
		
		<!-- START - FMS Content Body -->
		<div id="fms_content_body">
			<div class="right-corner" align="right">GRUPA</div>
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
								<li>${error}</li>
							</g:each>
						</ul>
					</g:if>
					<ul id="errorDisplay" style="display: none;" class="errors" role="alert" style="float:left; margin: -5px 10px 0px 0px; "></ul>
					<%-- Error messages end--%>
					
					<div id="show-memberMaster" class="content scaffold-show" role="main">
					&nbsp;
					
					<g:form action="saveAddress" id="editForm" name="editForm">
						<g:hiddenField name="id" value="${groupMasterInstance?.groupId}" />
						<g:hiddenField name="groupId" value="${groupMasterInstance?.groupId}" />
						<g:hiddenField name="groupDBId" value="${groupMasterInstance?.groupDBId}" />
						
						<!-- START - WIDGET: General Information -->
		    			<div id="widgetGeneral" class="fms_widget">
				 			<fieldset class="no_border">
								<h2>General Information</h2>
		                  		<legend><h2>Add Address</h2></legend>
		                  		<div class="fms_form_layout_2column">                  
		                    		<div class="fms_form_column fms_very_long_labels">
		
		               					<label id="addressType_label" for="addressType" class="control-label fms_required" >
											<g:message code="groupMaster.addressType.label" default="Address Type:" />
										</label>
										<div class="fms_form_input">
		                                   <g:getSystemCodeToken
												cssClass="form-control"
												systemCodeType="ADDRESSTYPE" languageId="0"
												htmlElelmentId="address.0.addressType"
												blankValue="Address Type" 
												defaultValue="${address?.addressType}" />
		                                   	<div class="fms_form_error" id="addressType_error"></div>
		                              	</div>
		                              	
		               					<label id="effectiveDate_label" for="effectiveDate" class="control-label fms_required" >
											<g:message code="groupMaster.effectiveDate.label" default="Effective Date:" />
										</label>
										<div class="fms_form_input">
											<fmsui:jqDatePickerUIUX 
												datePickerOptions="changeMonth:true, changeYear:true, yearRange:'-100:+100', numberOfMonths: 1"
		                                  		dateElementValue="${formatDate(format:'MM/dd/yyyy',date: address?.effectiveDate)}"
		                                  		dateElementId="address.0.effectiveDate" 
		                                  		dateElementName="address.0.effectiveDate" 
		                                        ariaAttributes="aria-labelledby='effectiveDate_label' aria-describedby='effectiveDate_error' aria-required='false'" 
		                                        classAttributes ="class='form-control fms_date_mask fms_small_input onDelete hasDatepicker' "
		                                        showIconDefault="${isShowCalendarIcon}"/> 
											<div class="fms_form_error" id="effectiveDate_error"></div>
		                              	</div>
		                            </div>		
		                            	
		                            <div class="fms_form_column fms_very_long_labels">
		                            	
		                              	<label id="termReason_label" for="termReason" class="control-label" >
											<g:message code="groupMaster.termReason.label" default="Term Reason:" />
										</label>
										<div class="fms_form_input fms_has_feedback">
											<input type="hidden" name="TermReasonType" id="TermReasonType" value="TM"/>
											
		                                  	<g:textField 
		                                  		class="form-control"
		                                  		maxlength="5"
		                                  		name="address.0.termReason"
												value="${address?.termReason}" />
											<fmsui:cdoLookup 
												lookupElementId="address.0.termReason"
												lookupElementName="address.0.termReason" 
												lookupElementValue="${address?.termReason}"
												lookupCDOClassName="com.perotsystems.diamond.dao.cdo.ReasonCodeMaster"
												lookupCDOClassAttribute="reasonCode"
												htmlElementsToAddToQuery="TermReasonType"
												htmlElementsToAddToQueryCDOProperty="reasonCodeType" />
		                                   	<div class="fms_form_error" id="termReason_error"></div>
		                              	</div>
		                              	
		               					<label id="termDate_label" for="termDate" class="control-label" >
											<g:message code="groupMaster.termDate.label" default="Term Date:" />
										</label>
										<div class="fms_form_input">
											<fmsui:jqDatePickerUIUX 
												datePickerOptions="changeMonth:true, changeYear:true, yearRange:'-100:+100', numberOfMonths: 1"
		                                  		dateElementValue="${formatDate(format:'MM/dd/yyyy',date: address?.termDate)}"
		                                  		dateElementId="address.0.termDate" 
		                                  		dateElementName="address.0.termDate" 
		                                        ariaAttributes="aria-labelledby='termDate_label' aria-describedby='termDate_error' aria-required='false'" 
		                                        classAttributes ="class='form-control fms_date_mask fms_small_input onDelete hasDatepicker' "
		                                        showIconDefault="${isShowCalendarIcon}"/> 
		                                   	<div class="fms_form_error" id="termDate_error"></div>
		                              	</div>
									</div>
								</div>
								
								<hr />
								
								<div class="fms_form_layout_2column">                  
									<div class="fms_form_column fms_very_long_labels">
									
		               					<label id="isPrimaryAddress_label" for="isPrimaryAddress" class="control-label" >
											<g:message code="groupMaster.isPrimaryAddress.label" default="Primary Address:" />
										</label>
										<div class="fms_form_input">
		                                   <select name="address.0.isPrimaryAddress" class="form-control fms_width_auto">
												<option value=""></option>
												<option value="true"
													${ address?.isPrimaryAddress ? 'selected' : '' }>Yes</option>
												<option value="false"
													${!address?.isPrimaryAddress ? 'selected' : '' }>No</option>
											</select>	
		                                   	<div class="fms_form_error" id="isPrimaryAddress_error"></div>
		                              	</div>
		                              	
		                              	<label id="isBillingAddress_label" for="isBillingAddress" class="control-label" >
											<g:message code="groupMaster.isBillingAddress.label" default="Billing Address:" />
										</label>
										<div class="fms_form_input">
		                                  	<select name="address.0.isBillingAddress" class="form-control fms_width_auto">
												<option value=""></option>
												<option value="true"
													${ address?.isBillingAddress ? 'selected' : '' }>Yes</option>
												<option value="false"
													${!address?.isBillingAddress ? 'selected' : '' }>No</option>
											</select>	
		                                   	<div class="fms_form_error" id="isBillingAddress_error"></div>
		                              	</div>
		                              	
		               					<label id="isInactive_label" for="isInactive" class="control-label" >
											<g:message code="groupMaster.isInactive.label" default="Inactive:" />
										</label>
										<div class="fms_form_input">
		                                   <select name="address.0.isInactive" class="form-control fms_width_auto">
												<option value=""></option>
												<option value="true"
													${ address?.isInactive ? 'selected' : '' }>Yes</option>
												<option value="false"
													${!address?.isInactive ? 'selected' : '' }>No</option>
											</select>		
		                                   	<div class="fms_form_error" id="isInactive_error"></div>
		                              	</div>
		                              	
		                              	
		               					<label id="address1_label" for="address1" class="control-label fms_required" >
											<g:message code="groupMaster.address1.label" default="Address1:" />
										</label>
										<div class="fms_form_input">
		                                  	<g:textField 
		                                  		name="address.0.address1"
		                                  		maxlength="60"
												value="${address?.address1}"
												class="form-control" />
		                                   	<div class="fms_form_error" id="address1_error"></div>
		                              	</div>
		                              	
		                              	<label id="addressType_label" for="addressType" class="control-label" >
											<g:message code="groupMaster.address2.label" default="Address2:" />
										</label>
										<div class="fms_form_input">
		                                  	<g:textField 
		                                  		name="address.0.address2"
		                                  		maxlength="60"
												value="${address?.address2}"
												class="form-control" />
		                                   	<div class="fms_form_error" id="addressType_error"></div>
		                              	</div>
		                          	</div>	
		                          		                              	
		                            <div class="fms_form_column fms_very_long_labels">
		                            	
		               					<label id="city_label" for="city" class="control-label fms_required" >
											<g:message code="groupMaster.city.label" default="City:" />
										</label>
										<div class="fms_form_input">
		                                  	<g:textField 
		                                  		name="address.0.city"
		                                  		maxlength="30"
												value="${address?.city}"
												class="form-control fms-alphanumeric valid" />
		                                   	<div class="fms_form_error" id="city_error"></div>
		                              	</div>
		                              	
		               					<label id="groupState_label" for="groupState" class="control-label fms_required" >
											<g:message code="groupMaster.groupState.label" default="State:" />
										</label>
										<div class="fms_form_input">
		                                   	<g:select
		                                   		class="form-control"
									        	name="address.0.state" 
									        	optionKey="stateCode" 
									        	optionValue="stateName" 
									        	value="${address?.state}" 
									        	from="${states}" 
									        	noSelection="['':'-- Select a State --']">
									        </g:select>
									        <div class="fms_form_error" id="groupState_error"></div>
		                              	</div>
		                              	
		               					<label id="zipCode_label" for="zipCode" class="control-label fms_required" >
											<g:message code="groupMaster.zipCode.label" default="Zip Code:" />
										</label>
										<div class="fms_form_input">
		                                  	<g:textField 
		                                  		name="address.0.zip"
		                                  		maxlength="10"
												value="${address?.address2}"
												class="form-control maskZip" />
		                                   	<div class="fms_form_error" id="zipCode_error"></div>
		                              	</div>
		                              	
		               					<label id="country_label" for="country" class="control-label" >
											<g:message code="groupMaster.country.label" default="Country:" />
										</label>
										<div class="fms_form_input">
		                                  	<g:select 
		                                  		class="form-control"
		                                  		maxlength="30"
		                                  		name="address.0.country" 
		                                  		optionKey="countryCode" 
		                                  		optionValue="country" 
		                                  		value="${address?.country}" 
		                                  		from="${countries}" 
		                                  		noSelection="['USA':'USA']" >
		                                  	</g:select>
		                                   	<div class="fms_form_error" id="country_error"></div>
		                              	</div>
		                              	
		               					<label id="county_label" for="county" class="control-label" >
											<g:message code="groupMaster.county.label" default="County:" />
										</label>
										<div class="fms_form_input">
		                                   <g:textField 
		                                  		name="address.0.county"
		                                  		maxlength="30"
												value="${address?.county}"
												class="form-control" />
		                                   	<div class="fms_form_error" id="county_error"></div>
		                              	</div>
		                           	</div>
		                       	</div>
		                  	</fieldset>
		               	</div>	
						<!-- END - WIDGET: General Information -->
		              	
		              	<!-- START - WIDGET: User Defined Fields -->	
		               	<div class="fms_widget">        
		                	<fieldset class="no_border">
		                      	<legend><h3>User Defined Fields</h3></legend>
		                       	<div class="fms_form_layout_2column">                  
		                        	<div class="fms_form_column fms_very_long_labels">
		                        		
		                        		<label id="userDef1_label" for="userDef1" class="control-label" >
											<g:userDefinedFieldLabel winId="GRUPA" datawindowId ="dw_grupa_de" userDefineTextName="USER_DEF_1_t" defaultText="User Defined 1"   />
										</label>
										<div class="fms_form_input">
		                                  	<g:textField 
		                                  		name="address.0.userDefined1"
		                                  		maxlength="30"
												value="${address?.userDefined1}"
												class="form-control" />
		                                   	<div class="fms_form_error" id="userDef1_error"></div>
		                              	</div>
		                              	
		                              	<label id="userDef2_label" for="userDef2" class="control-label" >
											<g:userDefinedFieldLabel winId="GRUPA" datawindowId ="dw_grupa_de" userDefineTextName="USER_DEF_2_t" defaultText="User Defined 2"   />
										</label>
										<div class="fms_form_input">
		                                  	<g:textField 
		                                  		name="address.0.userDefined2"
		                                  		maxlength="30"
												value="${address?.userDefined2}"
												class="form-control" />
		                                   	<div class="fms_form_error" id="userDef2_error"></div>
		                              	</div>
		                              	
		                              	<label id="userDef3_label" for="userDef3" class="control-label" >
											<g:userDefinedFieldLabel winId="GRUPA" datawindowId ="dw_grupa_de" userDefineTextName="USER_DEF_3_t" defaultText="User Defined 3"   />
										</label>
										<div class="fms_form_input">
		                                  	<g:textField 
		                                  		name="address.0.userDefined3"
		                                  		maxlength="30"
												value="${address?.userDefined3}"
												class="form-control" />
		                                   	<div class="fms_form_error" id="userDef3_error"></div>
		                              	</div>
		                              	
		                              	<label id="userDef4_label" for="userDef4" class="control-label" >
											<g:userDefinedFieldLabel winId="GRUPA" datawindowId ="dw_grupa_de" userDefineTextName="USER_DEF_4_t" defaultText="User Defined 4"   />
										</label>
										<div class="fms_form_input">
		                                  	<g:textField 
		                                  		name="address.0.userDefined4"
		                                  		maxlength="30"
												value="${address?.userDefined4}"
												class="form-control" />
		                                   	<div class="fms_form_error" id="userDef4_error"></div>
		                              	</div>
		                              	
		                              	<label id="userDef5_label" for="userDef5" class="control-label" >
											<g:userDefinedFieldLabel winId="GRUPA" datawindowId ="dw_grupa_de" userDefineTextName="USER_DEF_5_t" defaultText="User Defined 5"   />
										</label>
										<div class="fms_form_input">
		                                  	<g:textField 
		                                  		name="address.0.userDefined5"
		                                  		maxlength="30"
												value="${address?.userDefined5}"
												class="form-control" />
		                                   	<div class="fms_form_error" id="userDef5_error"></div>
		                              	</div>
		                          	</div>
		                          	
		                          	<div class="fms_form_column fms_very_long_labels">
		                           		<label id="userDate1_label" for="userDate1" class="control-label" >
											<g:userDefinedFieldLabel winId="GRUPA" datawindowId ="dw_grupa_de" userDefineTextName="user_date_1_t" defaultText="User Date 1" />	
										</label>
										<div class="fms_form_input">
											<fmsui:jqDatePickerUIUX 
												datePickerOptions="changeMonth:true, changeYear:true, yearRange:'-100:+100', numberOfMonths: 1"
		                                  		dateElementValue="${formatDate(format:'MM/dd/yyyy',date: address?.userDate1)}"
		                                  		dateElementId="address.0.userDate1" 
		                                  		dateElementName="address.0.userDate1" 
		                                        ariaAttributes="aria-labelledby='userDate1_label' aria-describedby='userDate1_error' aria-required='false'" 
		                                        classAttributes ="class='form-control fms_date_mask fms_small_input onDelete hasDatepicker' "
		                                        showIconDefault="${isShowCalendarIcon}"/> 
		                                   	<div class="fms_form_error" id="userDate1_error"></div>
		                              	</div>
		                        	
		                        		<label id="userDate2_label" for="userDate2" class="control-label" >
											<g:userDefinedFieldLabel winId="GRUPA" datawindowId ="dw_grupa_de" userDefineTextName="user_date_2_t" defaultText="User Date 2" />	
										</label>
										<div class="fms_form_input">
											<fmsui:jqDatePickerUIUX 
												datePickerOptions="changeMonth:true, changeYear:true, yearRange:'-100:+100', numberOfMonths: 1"
		                                  		dateElementValue="${formatDate(format:'MM/dd/yyyy',date: address?.userDate2)}"
		                                  		dateElementId="address.0.userDate2" 
		                                  		dateElementName="address.0.userDate2" 
		                                        ariaAttributes="aria-labelledby='userDate2_label' aria-describedby='userDate2_error' aria-required='false'" 
		                                        classAttributes ="class='form-control fms_date_mask fms_small_input onDelete hasDatepicker' "
		                                        showIconDefault="${isShowCalendarIcon}"/> 
		                                   	<div class="fms_form_error" id="userDate2_error"></div>
		                              	</div>
		                        	
		                        		<label id="userDate3_label" for="userDate3" class="control-label" >
											<g:userDefinedFieldLabel winId="GRUPA" datawindowId ="dw_grupa_de" userDefineTextName="user_date_3_t" defaultText="User Date 3" />	
										</label>
										<div class="fms_form_input">
											<fmsui:jqDatePickerUIUX 
												datePickerOptions="changeMonth:true, changeYear:true, yearRange:'-100:+100', numberOfMonths: 1"
		                                  		dateElementValue="${formatDate(format:'MM/dd/yyyy',date: address?.userDate3)}"
		                                  		dateElementId="address.0.userDate3" 
		                                  		dateElementName="address.0.userDate3" 
		                                        ariaAttributes="aria-labelledby='userDate3_label' aria-describedby='userDate3_error' aria-required='false'" 
		                                        classAttributes ="class='form-control fms_date_mask fms_small_input onDelete hasDatepicker' "
		                                        showIconDefault="${isShowCalendarIcon}"/> 
		                                   	<div class="fms_form_error" id="userDate3_error"></div>
		                              	</div>
		                        		
		                        		<label id="userDate4_label" for="userDate4" class="control-label" >
											<g:userDefinedFieldLabel winId="GRUPA" datawindowId ="dw_grupa_de" userDefineTextName="user_date_4_t" defaultText="User Date 4" />	
										</label>
										<div class="fms_form_input">
											<fmsui:jqDatePickerUIUX 
												datePickerOptions="changeMonth:true, changeYear:true, yearRange:'-100:+100', numberOfMonths: 1"
		                                  		dateElementValue="${formatDate(format:'MM/dd/yyyy',date: address?.userDate4)}"
		                                  		dateElementId="address.0.userDate4" 
		                                  		dateElementName="address.0.userDate4" 
		                                        ariaAttributes="aria-labelledby='userDate4' aria-describedby='userDate4_error' aria-required='false'" 
		                                        classAttributes ="class='form-control fms_date_mask fms_small_input onDelete hasDatepicker' "
		                                        showIconDefault="${isShowCalendarIcon}"/> 
		                                   	<div class="fms_form_error" id="userDate4_error"></div>
		                              	</div>
		                        		
		                        		<label id="userDate5_label" for="userDate5" class="control-label" >
											<g:userDefinedFieldLabel winId="GRUPA" datawindowId ="dw_grupa_de" userDefineTextName="user_date_5_t" defaultText="User Date 5" />	
										</label>
										<div class="fms_form_input">
											<fmsui:jqDatePickerUIUX 
												datePickerOptions="changeMonth:true, changeYear:true, yearRange:'-100:+100', numberOfMonths: 1"
		                                  		dateElementValue="${formatDate(format:'MM/dd/yyyy',date: address?.userDate5)}"
		                                  		dateElementId="address.0.userDate5" 
		                                  		dateElementName="address.0.userDate5" 
		                                        ariaAttributes="aria-labelledby='userDate5_label' aria-describedby='userDate5_error' aria-required='false'" 
		                                        classAttributes ="class='form-control fms_date_mask fms_small_input onDelete hasDatepicker' "
		                                        showIconDefault="${isShowCalendarIcon}"/> 
		                                   	<div class="fms_form_error" id="userDate5_error"></div>
		                              	</div>
		                        	</div>
		                        </div>
		                  	</fieldset>
		               	</div>
				 		<!-- END - WIDGET: User Defined Fields -->	
				 		<div class="fms_form_button">
						 	<g:actionSubmit class="btn btn-primary" action="saveAddress" value="${message(code: 'default.button.save.label', default: 'Save')}" />
						 	<input class="btn btn-default" type="reset">
							<input type="button" class="btn btn-default" name="close" value="${message(code: 'default.button.cancel.label', default: 'Cancel')}" onClick="closeForm()"/>
		      			</div>		
				 	</g:form>
				 </div>		
			</div>
		</div>
		<!-- END - FMS Content Body -->
	</div>
	<!-- END - FMS Content -->
</html>