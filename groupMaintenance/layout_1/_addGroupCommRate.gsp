<!DOCTYPE html>
<html>
	<head>	
		<meta name="layout" content="main">
					
		<g:set var="entityName" value="${message(code: 'groupMaster.label', default: 'GroupMaster')}" />
		<g:set var="appContext" bean="grailsApplication"/>
			
		<title><g:message code="default.edit.label" args="[entityName]" /></title>
	
		<%-- Main menu select --%>
		<meta name="navSelector" content="maint"/>
		<%-- Child menu select --%>
		<meta name="navChildSelector" content="groupMaintenance"/>
		
		<script type="text/javascript" src="${resource(dir: 'js', file: 'jquery.validate.js')}"></script>
		<script type="text/javascript" src="${resource(dir: 'js', file: 'jquery.maskedinput.js')}"></script>
		<script type="text/javascript" src="${resource(dir: 'js', file: 'jquery.alphanum.js')}"></script>

	<g:javascript>
		function closeForm() {

			var groupDBId = "${params.groupDBId}";
			var groupId = "${groupMasterInstance.groupId}";
			var appName = "${appContext.metadata['app.name']}";
			window.location.assign("/"+appName+"/groupMaintenance/edit/" + groupId +
				"?groupId=" + groupId + "&groupDBId=" + groupDBId + "&groupEditType=COMMRATES");
		}
	</g:javascript>
		<%--Start --%>	
		<script type="text/javascript">
			
		jQuery.validator.setDefaults({
			ignore: ":hidden",
			debug: true			 
		});							

		$(function($){			
			$("#rateId").alphanum({
				 allow 		: '-_',
				 allowSpace  : false
			 });			
		 }) 
		
		$(document).ready(function(){

			getCurrencySymbol();
			populateCalcType();

			$(".amtNumeric").numeric({});
			
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
						'rateId' : {
							required : true
					 	},
						'agencyGroupCommsRate.0.overrideAmtType' :  {
							required : function(element){														
								return $.trim($("#agencyGroupCommsRate\\.0\\.overrideAmt").val()).length > 0 	;						
							},
						},
					 	'agencyGroupCommsRate.0.effectiveDate' : {
							required : true
						},
						'agencyGroupCommsRate.0.termDate' :  {
							required :{
								depends: function(element){														
								return $.trim($("#agencyGroupCommsRate\\.0\\.effectiveDate").val()).length > 0 	;	
								}					
							},
						},
						/*,
						'agencyGroupCommsRate.0.termDate' :  {
							greaterThan:[ "#agencyGroupCommsRate\\.0\\.effectiveDate","#agencyGroupCommsRate\\.0\\.termDate","Effective Date","Term Date"]
						} */						
					},
					messages : {
						'rateId' : {
							required : "Please enter Rate ID"
					 	},
					 	'agencyGroupCommsRate.0.effectiveDate' : {
					 		required : "Please enter Effective Date"
					 	},
						'agencyGroupCommsRate.0.overrideAmtType' :  {
							required : "Amt Type is required when override Amt is entered"
						},
						'agencyGroupCommsRate.0.termDate' :  {	
							required : "Term Date is required when Effective Date is entered"
						},										
					} 
					
				})
			});

			/* Function does not work
		jQuery.validator.addMethod("greaterThan",
		function(value, element, params) {

			var startYear = params[0]+ "_year";
			var startMonth = params[0]+ "_month";
			var startDay = params[0]+ "_day";
		
			var endYear = params[1]+ "_year";
			var endMonth = params[1]+ "_month";
			var endDay = params[1]+ "_day";
		
			var startDate= new  Date($(startYear).val(),$(startMonth).val(), $(startDay).val());
			var endDate = new Date($(endYear).val(),$(endMonth).val(), $(endDay).val());
		
			return this.optional(element) ||( $(startYear).val().length > 0 && $(startMonth).val().length > 0
						&& $(startDay).val().length > 0 && startDate < endDate) ;
		
		}, jQuery.format("{3} Must be greater than {2}") );	*/
		
		}); 
	
		<%--End --%>
		
		
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
	</head>
	
	<%-- START - FMS Content --%>
	<div id="fms_content">
		<div id="fms_content_header">
	    	<div class="fms_content_header_note">
	      		<a href="${createLink(uri: '/groupMaintenance/list')}">Group Maintenance</a> / 
	      		<g:link class="list" action="edit" params="${[groupId: request.getParameter('groupId'), groupDBId : request.getParameter("groupDBId"), groupEditType :'COMMRATES']}">Group Rates</g:link>
	      			/ Add Group Rate to Group with GroupId - ${groupMasterInstance?.groupId}
	  		</div>
		  	<div class="fms_content_title">
	          	<h1>Add New Group Rate</h1>
	        </div>
		</div> 
		 <%-- START - Tabs --%>
			<div id="fms_content_tabs">
				<ul>
					<li><g:link class="list" action="edit" params="${[groupId: request.getParameter('groupId'), groupDBId : request.getParameter("groupDBId"), groupEditType :'MASTER']}">Master Records</g:link></li>
				 	<li><g:link class="list" action="edit" params="${[groupId: request.getParameter('groupId'), groupDBId : request.getParameter("groupDBId"), groupEditType :'CONTRACT']}">Contracts</g:link></li>
					<li><g:link class="list" action="edit" params="${[groupId: request.getParameter('groupId'), groupDBId : request.getParameter("groupDBId"), groupEditType :'DETAIL']}">Detail Records</g:link></li>
					<li><g:link class="list" action="edit" params="${[groupId: request.getParameter('groupId'), groupDBId : request.getParameter("groupDBId"), groupEditType :'ADDRESS']}">Addresses</g:link></li>
					<li><g:link class="list" action="edit" params="${[groupId: request.getParameter('groupId'), groupDBId : request.getParameter("groupDBId"), groupEditType :'CONTACT']}">Contacts</g:link></li>
					<li><g:link class="active" action="edit" params="${[groupId: request.getParameter('groupId'), groupDBId : request.getParameter("groupDBId"), groupEditType :'COMMRATES']}">Group Rates</g:link></li>
				</ul>
			<div id="mobile_tabs_select"></div>
		</div>
		<%-- END - Tabs --%>
		
		<%-- START - FMS Content Body --%>
		<div id="fms_content_body">
			<div class="right-corner" align="right">COMMG</div>
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
					<%-- Error messages end--%>
					
					<div id="show-agency" class="content scaffold-show" role="main">
					&nbsp;
					
					<g:hiddenField name="groupDBId" value="${groupMasterInstance?.groupDBId}"/>
					<g:hiddenField name="groupId" value="${groupMasterInstance?.groupId}"/>		
					
					<g:form action="saveGroupRate" id="editForm" name="editForm">
						<ul id="errorDisplay" style="display: none;" class="errors" role="alert" style="float:left; margin: -5px 10px 0px 0px; "></ul>

						<input type="hidden" name="agencyGroupCommsRate.0.seqPremId" value="${premMasterInstance?.seqPremId} ">
						<input type="hidden" name="agencyGroupCommsRate.0.seqGroupId" value="${premMasterInstance?.seqGroupId} ">
						<input type="hidden" name="seqPremId" value="${premMasterInstance?.seqPremId} ">
						<g:hiddenField name="groupDBId" value="${groupMasterInstance?.groupDBId}" />
						<g:hiddenField name="groupId" value="${groupMasterInstance?.groupId}" />		
								              	
		              	<%-- START - WIDGET: General Information --%>
		    			<div id="widgetGeneral" class="fms_widget">
				 			<fieldset class="no_border">
								<h2>General Information</h2>
		                  		<legend><h2>Add Group Rate</h2></legend>
		                  		<div class="fms_form_layout_2column">                  
		                    		<div class="fms_form_column fms_very_long_labels">
												
										<label id="effectiveDate_label" for="effectiveDate" class="control-label fms_required" >
											<g:message code="groupMaster.effectiveDate.label" default="Effective Date:" />
										</label>
										<div class="fms_form_input">
											<fmsui:jqDatePickerUIUX 
												datePickerOptions="changeMonth:true, changeYear:true, yearRange:'-100:+100', numberOfMonths: 1"
		                                  		dateElementValue="${formatDate(format:'MM/dd/yyyy',date: agencyGroupCommsRate?.effectiveDate)}"
		                                  		dateElementId="agencyGroupCommsRate.0.effectiveDate" 
		                                  		dateElementName="agencyGroupCommsRate.0.effectiveDate" 
		                                        ariaAttributes="aria-labelledby='effectiveDate_label' aria-describedby='effectiveDate_error' aria-required='false'" 
		                                        classAttributes ="class='form-control fms_date_mask fms_small_input onDelete hasDatepicker' "
		                                        showIconDefault="true"/> 
											<div class="fms_form_error" id="effectiveDate_error"></div>
		                              	</div>								
								
										<label id="overrideAmt_label" for="overrideAmt" class="control-label">
											<g:message code="agencyGroupCommsRate.overrideAmtType.label" default="Amount Type:" />
										</label>
										<div class="fms_form_input">
		                                	<g:secureComboBox	name="agencyGroupCommsRate.0.overrideAmtType" 
		                                		onchange="getCurrencySymbol();"
												tableName="AGENCY_GROUP_COMMS_RATES" attributeName="overrideAmtType" 
												value="${agencyGroupCommsRate?.overrideAmtType}"
												from="${['A': 'A - Amount' , 'P': 'P - Percent']}" 
												optionValue="value" optionKey="key" class="form-control" 
												noSelection="['':'-- Select an Amout Type --']">
											</g:secureComboBox>
		                                	<div class="fms_form_error" id="overrideAmt_error"></div>
										</div>
										
										<label id="overrideAmount_label" for="overrideAmount" class="control-label fms_required" >
											<g:message code="agencyGroupCommsRate.seqRateId.label" default="Rate ID:" />
										</label>
										<div class="fms_form_input fms_has_feedback">
										  
											<input type="hidden" name="agencyGroupContract.0.seqRateId"	
												id="agencyGroupCommsRate.0.seqRateId" 
												value="${agencyGroupCommsRate?.seqRateId}"/>											
		                                  	<g:textField 
		                                  		class="form-control" maxlength="15" name="rateId" 
		                                  		id="rateId" value="${params.rateId}"
		                                  		onchange= "upperMe()" 
												onblur="populateCalcType()"/>
											<fmsui:cdoLookup 
												lookupElementId="rateId"
												lookupElementName="rateId" 
												lookupElementValue="${agencyGroupCommsRate?.seqRateId}"
												lookupCDOClassName="com.perotsystems.diamond.dao.cdo.AgencyRateScheduleHdr"
												lookupCDOClassAttribute="rateId"
												htmlElementsToUpdate="agencyGroupCommsRate.0.seqRateId"
												htmlElementsToUpdateCDOProperty="seqRateId"												
												htmlElementsToAddToQuery=""
												htmlElementsToAddToQueryCDOProperty=""/>
		                                   	<div class="fms_form_error" id="overrideAmount_error"></div>
		                              	</div>		                              																																                              	
		                            </div>		
		                            	
		                            <div class="fms_form_column fms_very_long_labels">		                            			                        
		                            	
		                            	<label id="termDate_label" for="termDate" class="control-label" >
											<g:message code="groupMaster.termDate.label" default="Term Date:" />
										</label>
										<div class="fms_form_input">
											<fmsui:jqDatePickerUIUX 
												datePickerOptions="changeMonth:true, changeYear:true, yearRange:'-100:+100', numberOfMonths: 1"
		                                  		dateElementValue="${formatDate(format:'MM/dd/yyyy',date: agencyGroupCommsRate?.termDate)}"
		                                  		dateElementId="agencyGroupCommsRate.0.termDate" 
		                                  		dateElementName="agencyGroupCommsRate.0.termDate" 
		                                        ariaAttributes="aria-labelledby='termDate_label' aria-describedby='termDate_error' aria-required='false'" 
		                                        classAttributes ="class='form-control fms_date_mask fms_small_input onDelete hasDatepicker' "
		                                        showIconDefault="true"/> 
		                                   	<div class="fms_form_error" id="termDate_error"></div>
		                              	</div>		                              	
		                            											
										<label for="overrideAmt" class="control-label"> 
											<g:message   code="agencyGroupCommsRate.overrideAmt.label" default="Override Amt:" />
										</label>
										<div class="fms_form_input fms_feedback_input">
											<g:textField name="currSymbol" id="currSymbol" value=""  maxlength="1" readonly="readonly" 
											              class="fms_currSymbol" style="border: 0 !important;"/>
											<g:textField name="agencyGroupCommsRate.0.overrideAmt" value="${agencyGroupCommsRate?.overrideAmt}" 
											              class="form-control amtNumeric" maxlength="30" title="The Override Amount"/>               
											                                                                   
											<div class="fms_form_error" id="overrideAmt_error"></div>
										</div>
																														
		                            	<label for="calcType" class="control-label"> 
											<g:message code="calcType" default="Calc Type:" />  
										</label>
		                            	<div class="fms_form_input">
		                            		<input type="hidden" id="agencyGroupCommsRate.0.calcType" name="agencyGroupCommsRate.0.calcType" 
		                            			value="${agencyGrpCommsRate?.calcType}"	maxlength="1"/>
		                            			
											<g:secureComboBox name="calcType" class="form-control" disabled="disabled"
												tableName="AGENCY_GROUP_COMMS_RATES" attributeName="calcType" value="${agencyGrpCommsRate?.calcType}" 
												from="${['' : '', 'I': 'I - Incentive' , 'C': 'C - Commission']}" optionValue="value" optionKey="key">
											</g:secureComboBox>		                            			                            		
		                                	<div class="fms_form_error" id="calcType_error"></div>
										</div>		                            			                            	
									</div>
								</div>																
		                  	</fieldset>
		               	</div>	
						<!-- END - WIDGET: General Information -->
				 		<div class="fms_form_button">
						 	<g:actionSubmit class="btn btn-primary" action="saveGroupRate" value="${message(code: 'default.button.save.label', 
								default: 'Save')}" />
						 	<input class="btn btn-default" type="reset">
							<input type="button" class="btn btn-default" name="close" value="${message(code: 'default.button.cancel.label', 
								default: 'Cancel')}" onClick="closeForm()"/>
		      			</div>		
				 	</g:form>
				 </div>		
			</div>
		</div>
		<!-- END - FMS Content Body -->
	</div>
	<!-- END - FMS Content -->
</html>