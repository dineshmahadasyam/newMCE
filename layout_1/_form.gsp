<%@ page import="com.perotsystems.diamond.bom.fms.Agency"%>
<%@ page import="com.perotsystems.diamond.bom.fms.AgencyAgent" %>
<%@ page import="com.dell.diamond.fms.enums.PageNameEnum" %>

<input type="hidden" name="editType" id="editType" value="MASTER" />
<input type="hidden" name="seqAgentId" id="seqAgentId" value="${agentMasterInstance?.seqAgentId }" />
<input type="hidden" name="agencyType" id="agencyType" value="C" />
<input type="hidden" name="agencyId" value="${agentMasterInstance.agencys?.get(0).agencyId}" />
<g:set var="isShowCalendarIcon" value="${PageNameEnum.AGENT_CREATE.equals(currentPage)?true:false}" />

<head>
<script type="text/javascript">
$(document).ready(function() { 

			$('#fms_content_body').removeAttr('style');
			var pageId = ${currentPage?.pageName? '"'+currentPage?.pageName+'"':'""' }		
			if (pageId == 'edit') {
		          // Make all the inputs disabled
		          $('#widgetGeneral  input, #widgetGeneral select, #widgetGeneral .fms_btn_icon').attr('disabled', 'disabled');
		          $('#widgetUserDefined  input, #widgetUserDefined  select, #widgetGeneral .fms_btn_icon').attr('disabled', 'disabled');
		          // Hide the "Save and Reset" buttons by the form titles
		          $('#BtnGeneralSave, #BtnGeneralReset').hide();
		          $('button[id="Btn_agencyId"]').attr('disabled', 'disabled');
		          $('.ui-datepicker-trigger').hide();
				} else if (pageId == 'create') {// Treating this is a create action
					$('#BtnGeneralEdit').hide();
					$('.ui-datepicker-trigger').show();
					$('#widgetGeneral input[id="agencyId"]').attr('disabled', 'disabled');
					$('input[id="effectiveDate"]').removeAttr('disabled');
				}else {
			          // Make all the inputs disabled
			          $('#widgetGeneral  input, #widgetGeneral select, #widgetGeneral .fms_btn_icon').attr('disabled', 'disabled');
			          $('#widgetUserDefined  input, #widgetUserDefined  select, #widgetGeneral .fms_btn_icon').attr('disabled', 'disabled');
			          // Hide the "Save and Reset" buttons by the form titles
			          $('#BtnGeneralSave, #BtnGeneralReset').hide();
			          $('button[id="Btn_agencyId"]').attr('disabled', 'disabled');
			          $('.ui-datepicker-trigger').hide();
				}

	          $( "#BtnGeneralEdit" ).click(function(e) {
	          	  $('#BtnGeneralEdit').hide();
	              $('.ui-datepicker-trigger').show();
	              $('#BtnGeneralSave, #BtnGeneralReset').show();
	              $('#widgetGeneral  input, #widgetGeneral  select, #widgetGeneral .fms_btn_icon').removeAttr('disabled');
	              $('#widgetUserDefined  input, #widgetUserDefined  select, #widgetUserDefined .fms_btn_icon').removeAttr('disabled');
	              if($("#agentType").val() == 'I') {
	            	  $('button[id="Btn_agencyId"]').attr('disabled', 'disabled');
					  $('#widgetGeneral input[id="agencyId"]').attr('disabled', 'disabled');
					  $('input[id="effectiveDate"]').attr('disabled', 'disabled');
					  $('button[id^="_calendar_button_effectiveDate"]').hide();
					  $('select[id="agentType"]').attr('disabled', 'disabled');
		           }else if ($("#agentType").val() == 'C') {
		              $('button[id="Btn_agencyId"]').removeAttr('disabled');
					  $('#widgetGeneral input[id="agencyId"]').removeAttr('disabled');
					  $('input[id="effectiveDate"]').removeAttr('disabled');
					  $('button[id^="_calendar_button_effectiveDate"]').show();
					  $('select[id="agentType"]').attr('disabled', 'disabled');
			       }
	          });
			
			$( ".btnResetddress" ).click(function() { 
				if (pageId == 'edit') {
					$('#BtnGeneralEdit').show();
					$('#BtnGeneralSave').hide();
					$('#BtnGeneralReset').hide();
					$('#widgetGeneral  input, #widgetGeneral select, #widgetGeneral .fms_btn_icon').attr('disabled', 'disabled');
			        $('#widgetUserDefined  input, #widgetUserDefined  select, #widgetGeneral .fms_btn_icon').attr('disabled', 'disabled');
			        $('button[id="Btn_agencyId"]').attr('disabled', 'disabled');
			        $('select[id="agentType"]').attr('disabled', 'disabled');
			        $('.ui-datepicker-trigger').hide();
				}
			 });					

			$('#agentType').change( function() {
				if($("#agentType").val() == 'I') {
					$('button[id="Btn_agencyId"]').attr('disabled', 'disabled');
					$('#widgetGeneral input[id="agencyId"]').attr('disabled', 'disabled');
					$('input[id="effectiveDate"]').attr('disabled', 'disabled');
					$('button[id^="_calendar_button_effectiveDate"]').hide();
					$('input[id="effectiveDate"]').val(getCurrenteDate());
				}else{
					$('#widgetGeneral input[id="agencyId"]').removeAttr('disabled');
					$('button[id="Btn_agencyId"]').removeAttr('disabled');
					$('input[id="effectiveDate"]').removeAttr('disabled');
					$('button[id^="_calendar_button_effectiveDate"]').show();
					$('input[id="effectiveDate"]').val("");
				}
			});

			
});

   </script>
   
<script type="text/javascript">
    function changeAgentIdMessage(){
    	document.getElementById('InfoDeleteModelId').click();
    }

    function getCurrenteDate() {

		var today = new Date();
		var dd = today.getDate();
		var mm = today.getMonth()+1;
		var yyyy = today.getFullYear();
		if(dd<10){dd='0'+dd}
		if(mm<10){mm='0'+mm}
		var curDate = mm+'/'+dd+'/'+yyyy
		return curDate;
	}
</script>

<script type="text/javascript">
	
	$(document).ready(function() {

	     $('.InfoDeleteRow').hide();  
			$('.InfoDeleteRow').click(function(e){ 
	        	$('#InfoDeleteModel').modal('show');
	        });
	     	$('#InfoDeleteModel').modal({
	        	backdrop: 'static',
	           show: false
	       	});
	});

</script>
</head>

<div id="fms_content_body">
	<!-- START - Error Messages: -->
	<g:if test="${flash.message}">
		<div class="message" role="status">${flash.message}</div>
	</g:if>
	<g:if test="${errorMessage}">
		<div class="message" role="status">${errorMessage}</div>
	</g:if>
	<g:if test="${fieldErrors}">
	<ul class="errors" role="alert">
		<g:each in="${fieldErrors}" var="error">
			<li>${error}</li>
		</g:each>
	</ul>
	</g:if>
	<g:hasErrors bean="${agentMasterInstance}">
	    <ul class="errors" role="alert">
			<g:eachError bean="${agentMasterInstance}" var="error">
				<li <g:if test="${error in org.springframework.validation.FieldError}">data-field-id="${error.field}"</g:if>><g:message error="${error}"/></li>
			</g:eachError>
		</ul>
	</g:hasErrors>
	<ul id="errorDisplay" style="display: none;" class="errors" role="alert" style="float:left; margin: -5px 10px 0px 0px; "></ul>
	<!-- END - Error Messages: -->
			
<div class="fms_required_legend fms_required">= required</div>
<g:if test="${agentMasterInstance?.agentType.equals('I')}">
	<input type="hidden" name="agencys.agencyId" value="${agentMasterInstance.agencys?.get(0).agencyId}" />
</g:if>
	<!-- START - WIDGET: General Information -->
	<div id="widgetGeneral" class="fms_widget">
		<fieldset>
			<legend>
				<h2>General Information</h2>
				<button type="button" id="BtnGeneralEdit" class="btn btn-default btn-xs"><span class="glyphicon glyphicon-pencil"></span> Edit</button>
				<button id="BtnGeneralSave"	class="btn btn-primary btn-xs"><span class="fa fa-floppy-o"></span> Save</button>
				<button type="button" id="BtnGeneralReset" class="btn btn-default btn-xs btnResetddress" onclick="this.form.reset();"><span class="glyphicon glyphicon-repeat"></span> Reset</button>
				<button id="InfoDeleteModelId" type="button" class="btn fms_btn_icon btn-sm InfoDeleteRow" title="Click to delete beneficiary form." data-target="#InfoDeleteModel"></button>
			</legend>

			<div class="fms_form_layout_2column">
				<div class="fms_form_column fms_very_long_labels">


                  <label class="control-label fms_required" id="agentId_label" for="agentId">
					<g:message code="agentMaster.agentId.label" default="Agent/Broker ID" />:
				  </label>
                  <div class="fms_form_input">
              		<g:secureTextField maxlength="15" readOnly="true"
										name="agentId" id="agentId"
										tableName="AGENT_MASTER" attributeName="agentId" 
										value="${agentMasterInstance?.agentId}"
										title="The unique Agent or Broker ID " 
										class="form-control"
										aria-labelledby="agentId_label"
										aria-describedby="agentId_error"
										aria-required="false"
										onClick="changeAgentIdMessage()"></g:secureTextField>
					<div class="fms_form_error" id="agentId_error"></div>	                     
                  </div> 

                  <label class="control-label fms_required" id="FirstName_label" for="FirstName">
	                  	<g:message code="agentMaster.firstName.label" default="First Name" />:
	              </label>
                  <div class="fms_form_input">
                     <g:secureTextField name="firstName" value="${agentMasterInstance?.firstName}" maxlength="35" 
                     					tableName="AGENT_MASTER" attributeName="firstName" autofocus="autofocus"
                     					title="The First Name of the Agent/Broker" class="form-control" 
                     					aria-labelledby="firstName_label" aria-describedby="firstName_error" 
                     					aria-required="false">
                     </g:secureTextField>
                     <div class="fms_form_error" id="FirstName_error"></div>
                  </div>   


                  <label class="control-label fms_required" id="LastName_label" for="LastName">
                  	<g:message code="agentMaster.lastName.label" default="Last Name"  /> :
                  </label>
                  <div class="fms_form_input">
                     <g:secureTextField name="lastName" value="${agentMasterInstance?.lastName}" maxlength="60" 
                     					tableName="AGENT_MASTER" attributeName="lastName" 
                     					title="The Last Name of the Agent/Broker" class="form-control" 
                     					aria-labelledby="lastName_label" aria-describedby="lastName_error" 
                     					aria-required="false"></g:secureTextField>
                     <div class="fms_form_error" id="LastName_error"></div>
                  </div>            

                
                  <label class="control-label" id="MiddleName_label" for="MiddleName">
                  	<g:message code="agentMaster.middleInitial.label" default="Middle Initial" /> :
				  </label>
                  <div class="fms_form_input">
                     <g:secureTextField name="middleInitial" maxlength="25"
										value="${agentMasterInstance?.middleInitial}"
										tableName="AGENT_MASTER" 
										attributeName="middleInitial" 
										title="The Middle Name or Middle Initial of the Agent/Broker"
										class="form-control" 
                     					aria-labelledby="middleInitial_label" aria-describedby="middleInitial_error" 
                     					aria-required="false">
                      </g:secureTextField>
                     <div class="fms_form_error" id="MiddleName_error"></div>
                  </div>            

                
                  <label class="control-label" id="ShortName_label" for="ShortName">
                  	<g:message code="agentMaster.shortName.label" default="Short Name" /> :
                  </label>
                  <div class="fms_form_input">
                     <g:secureTextField name="shortName" maxlength="15"
                     					value="${agentMasterInstance?.shortName}" 
                     					tableName="AGENT_MASTER" 
                     					attributeName="shortName" 
                     					title="The Short Name for the Agent/Broker"
                     					class="form-control" 
                     					aria-labelledby="shortName_label" aria-describedby="shortName_error" 
                     					aria-required="false">
                     </g:secureTextField>
                     <div class="fms_form_error" id="ShortName_error"></div>
                  </div>

					<label class="control-label fms_required" id="PinTid_label"
						for="PinTid"> <g:message code="agentMaster.pinTid.label"
							default="Pin Tid" />:
					</label>
					<div class="fms_form_input">
						<g:secureTextField name="pinTid" class="pinTid"
							value="${agentMasterInstance?.pinTid}" tableName="AGENT_MASTER"
							attributeName="pinTid"
							title="The 9 digit Tax ID Number of the Agency"
							class="form-control pinTid" aria-labelledby="PinTid_label"
							aria-describedby="PinTid_error" aria-required="false">
						</g:secureTextField>

						<div class="fms_form_error" id="PinTid_error"></div>
					</div>

					<label for="dateOfBirth" class="control-label fms_required fieldcontain ${hasErrors(bean: agentMasterInstance, field: 'dateOfBirth', 'error')} required" id="dateOfBirth_label">
						<g:message code="agentMaster.dateOfBirth.label" default="Date Of Birth" />:
					</label>
					<div class="fms_form_input">
						<g:securejqDatePickerUIUX tableName="AGENT_MASTER"
							attributeName="dateOfBirth" dateElementId="dateOfBirth"
							dateElementName="dateOfBirth"
							dateElementValue="${formatDate(format:'MM/dd/yyyy',date: agentMasterInstance?.dateOfBirth)}"
							datePickerOptions="changeMonth:true, changeYear:true, yearRange:'${(Calendar.getInstance().get(Calendar.YEAR) - 100) - (agentMasterInstance?.dateOfBirth != null ? agentMasterInstance?.dateOfBirth.get(Calendar.YEAR):Calendar.getInstance().get(Calendar.YEAR))}:+0',	maxDate:-1, numberOfMonths: 1"
							precision="day" default="none"
							ariaAttributes="aria-labelledby='dateOfBirth_label' aria-describedby='dateOfBirth_error' aria-required='false'"
							classAttributes="class='form-control fms_date_mask fms_small_input onDelete hasDatepicker' "
							showIconDefault="${isShowCalendarIcon}" />
						<div class="fms_form_error" id="dateOfBirth_error"></div>
					</div>
				</div>


				<div class="fms_form_column fms_very_long_labels">

				<label class="control-label fms_required" id="agentType_label" for="agentType">
					<g:message code="agentMaster.agentType.label" default="Agent /Broker Type" />:
				</label>
				<div class="fms_form_input">
					<g:if test="${actionType.equals("Create")}">
						<g:getSystemCodes 
									systemCodeType="AGBR_TYPE"
									systemCodeActive = "Y"
									htmlElelmentId="agentType"
									blankValue="Agent Type --"
									defaultValue="${agentMasterInstance?.agentType}" 
									cssClass="form-control"
									aria-labelledby="agentType_label"
									aria-describedby="agentType_error" 
                     				aria-required="false"/>
					</g:if>
					<g:else>
						<g:getSystemCodes 
									systemCodeType="AGBR_TYPE"
									systemCodeActive = "Y"
									htmlElelmentId="agentType"
									blankValue="Agent Type --"
									defaultValue="${agentMasterInstance?.agentType}" 
									disable="true"
									cssClass="form-control"
									aria-labelledby="agentType_label"
									aria-describedby="agentType_error" 
                     				aria-required="false"/>
					</g:else>
					<div class="fms_form_error" id="agentType_error"></div>
				</div>

			    <label class="control-label fms_required" for="agencyId" id="agencyId_label">
					<g:message code="agentMaster.agencys.agencyId.label" default="Agency ID" />
				</label>
				<div class="fms_form_input fms_has_feedback">
					
								
					<g:secureTextField 
						class="form-control"
						name="agencys.agencyId" 
						value="${agentMasterInstance.agencys?.get(0).agencyId}" 
						maxlength="50" 
						tableName="AGENCY" attributeName="agencyId" 
						id="agencyId" 
						title="The ID of the Agency the Agent/broker is affiliated with"
						aria-labelledby="agencyId_label"
						aria-describedby="agencyId_error" 
                     	aria-required="false"></g:secureTextField>
					
					<fmsui:cdoLookup 
						lookupElementId="agencyId"
						lookupElementName="agencyId" 
						lookupElementValue="${agentMasterInstance.agencys?.get(0).agencyId}"
						lookupCDOClassName="com.perotsystems.diamond.dao.cdo.Agency"
						lookupCDOClassAttribute="agencyId"
						htmlElementsToAddToQuery="seqAgencyId"
						htmlElementsToAddToQueryCDOProperty="agencyType" />
						
					<div class="fms_form_error" id="agencyId_error"></div>
				</div>
				
				  <label class="control-label fms_required" id="agencyName_label" for="agencyName">
	                  	<g:message code="agentMaster.agencys.agencyName.label" default="Agency Name" />:
	              </label>
                  <div class="fms_form_input">
                     
					<%--g:if test="${agentMasterInstance?.agentType.equals('C')}" --%>
						<g:secureTextField name="agencys.agencyName" value="${agentMasterInstance.agencys?.get(0).agencyName}" 
						maxlength="60" tableName="AGENCY" attributeName="agencyName" readonly="true" id = "idAgencyName" 
						class="form-control" aria-labelledby="agencyName_label" aria-describedby="agencyName_error" aria-required="false"></g:secureTextField>
					<%--/g:if>
					<g:else>
						<g:secureTextField name="agencys.agencyName" value="${agentMasterInstance.agencys?.get(0).agencyName}" 
						maxlength="60" tableName="AGENCY" attributeName="agencyName" id = "idAgencyName" 
						class="form-control" aria-labelledby="agentId_label" aria-describedby="agentId_error" aria-required="false" 
						></g:secureTextField>
					</g:else--%>                     
                     
                     
                     <div class="fms_form_error" id="agencyName_error"></div>
                  </div>				

                  <label class="control-label fms_required" id="PayType_label" for="PayType">
                  		<g:message code="agentMaster.payType.label" default="Pay Type" />:
                  </label>
                  <div class="fms_form_input">
						<g:secureComboBox class="form-control" name="payType" id="payType"
				                                  tableName="AGENT_MASTER" attributeName="payType"
				                                  value="${agentMasterInstance?.payType}"
				                                  from="${['' : '-- Select the Pay Type --', 'E': 'E - EFT' , 'D': 'D - Direct Deposit']}" optionValue="value" optionKey="key"
						                     	  aria-labelledby="payType_label" 
						                     	  aria-describedby="payType_error" 
						                     	  aria-required="false">
						</g:secureComboBox>
                    <div class="fms_form_error" id="PayType_error"></div>
                  </div>       

                  <label class="control-label fms_required" id="Status_label" for="Status">
                  	<g:message code="agentMaster.status.label" default="Status" />:
                  </label>
                  <div class="fms_form_input">
						<g:secureComboBox class="form-control" name="status" id="status"
				                                  tableName="AGENT_MASTER" attributeName="status"
				                                  value="${agentMasterInstance?.status}"
				                                  from="${['' : '-- Select the Agent Status --', 'A': 'A – Active' , 'T': 'T – Terminated']}" optionValue="value" optionKey="key"
						                     	  aria-labelledby="status_label" 
						                     	  aria-describedby="status_error" 
						                     	  aria-required="false">
						</g:secureComboBox>
                    <div class="fms_form_error" id="Status_error"></div>
                  </div>

					<g:each in="${agentMasterInstance?.agencyAgents}"
						var="agencyAgents" status="i">
						<label class="control-label fms_required" id="effectiveDate_label"
							for="effectiveDate"> <g:message
								code="agentMasterInstance.agencyAgents.effectiveDate.label"
								default="Effective Date" />:
						</label>

						<g:if test="${agentMasterInstance?.agentType.equals('I')}">
							<div class="fms_form_input">
								<g:securejqDatePickerUIUX tableName="AGENCY_AGENT"
									attributeName="effectiveDate" dateElementId="effectiveDate"
									dateElementName="effectiveDate"
									dateElementValue="${formatDate(format:'MM/dd/yyyy',date: agencyAgents?.effectiveDate)}"
									datePickerOptions="changeMonth:true, changeYear:true, yearRange:'${((agencyAgents?.effectiveDate != null ? agencyAgents?.effectiveDate.get(Calendar.YEAR):Calendar.getInstance().get(Calendar.YEAR)) - 100)}:${((agencyAgents?.effectiveDate != null ? agencyAgents?.effectiveDate.get(Calendar.YEAR):Calendar.getInstance().get(Calendar.YEAR)) + 100)}', numberOfMonths: 1"
									precision="day" default="none"
									ariaAttributes="aria-labelledby='effectiveDate_label' aria-describedby='effectiveDate_error' aria-required='false'"
									classAttributes="class='form-control fms_date_mask fms_small_input onDelete hasDatepicker'"
									showIconDefault="${isShowCalendarIcon}" />
								<div class="fms_form_error" id="effectiveDate_error"></div>
							</div>
						</g:if>
						<g:else>
							<div class="fms_form_input">
								<g:securejqDatePickerUIUX tableName="AGENCY_AGENT"
									attributeName="effectiveDate" dateElementId="effectiveDate"
									dateElementName="effectiveDate"
									dateElementValue="${formatDate(format:'MM/dd/yyyy',date: agencyAgents?.effectiveDate)}"
									datePickerOptions="changeMonth:true, changeYear:true, yearRange:'${((agencyAgents?.effectiveDate != null ? agencyAgents?.effectiveDate.get(Calendar.YEAR):Calendar.getInstance().get(Calendar.YEAR)) - 100)}:${((agencyAgents?.effectiveDate != null ? agencyAgents?.effectiveDate.get(Calendar.YEAR):Calendar.getInstance().get(Calendar.YEAR)) + 100)}', numberOfMonths: 1"
									precision="day" default="none"
									ariaAttributes="aria-labelledby='effectiveDate_label' aria-describedby='effectiveDate_error' aria-required='false'"
									classAttributes="class='form-control fms_date_mask fms_small_input onDelete hasDatepicker'"
									showIconDefault="${isShowCalendarIcon}" />
								<div class="fms_form_error" id="effectiveDate_error"></div>
							</div>
						</g:else>
					</g:each>

					<label class="control-label" id="TermDate_label" for="TermDate">
						<g:message code="agentMaster.termDate.label" default="Term Date" />:
					</label>
					<div class="fms_form_input">
						<g:securejqDatePickerUIUX tableName="AGENT_MASTER"
							attributeName="termDate" dateElementId="termDate"
							dateElementName="termDate"
							dateElementValue="${formatDate(format:'MM/dd/yyyy',date: agentMasterInstance?.termDate)}"
							datePickerOptions="changeMonth:true, changeYear:true, yearRange:'${((agentMasterInstance?.termDate != null ? agentMasterInstance?.termDate.get(Calendar.YEAR):Calendar.getInstance().get(Calendar.YEAR)) - 100)}:${((agentMasterInstance?.termDate != null ? agentMasterInstance?.termDate.get(Calendar.YEAR):Calendar.getInstance().get(Calendar.YEAR)) + 100)}', numberOfMonths: 1"
							precision="day" default="none"
							ariaAttributes="aria-labelledby='termDate_label' aria-describedby='termDate_error' aria-required='false'"
							classAttributes="class='form-control fms_date_mask fms_small_input onDelete hasDatepicker' "
							showIconDefault="${isShowCalendarIcon}" />
						<div class="fms_form_error" id="TermDate_error"></div>
					</div>
				</div>
			</div>
		</fieldset>
	</div>

<!-- END - WIDGET: General Information -->


<!-- Start - WIDGET: User Defined Information -->
<div id="widgetUserDefined" class="fms_widget">
	<fieldset>
		<legend>
			<h2>User Defined Information</h2>
		</legend>

		<div class="fms_form_layout_2column">
		<div class="fms_form_column fms_very_long_labels">

                 <label class="control-label" id="userDefined1_label" for="userDefined1">
                 	<g:userDefinedFieldLabel winId="AGNTM" datawindowId ="AGNTM" userDefineTextName="user_defined_1_t" defaultText="User Defined1"/>
                 </label>
                 <div class="fms_form_input">
                    <g:secureTextField name="userDefined1"
									value="${agentMasterInstance?.userDefined1}"  
									maxlength="60" 
									tableName="AGENT_MASTER" 
									attributeName="userDefined1"
									class="form-control"
									aria-labelledby="userDefined1_label" 
						            aria-describedby="userDefined1_error" 
						            aria-required="false">
					</g:secureTextField>
                    <div class="fms_form_error" id="userDefined1_error"></div>
                 </div> 

                 <label class="control-label" id="userDate1_label" for="userDate1">
                 	<g:userDefinedFieldLabel winId="AGNTM" datawindowId ="AGNTM" userDefineTextName="user_date_1_t" defaultText="User Date 1"/>
                 </label>
                 <div class="fms_form_input">
                      <g:securejqDatePickerUIUX 
									tableName="AGENT_MASTER" attributeName="userDate1" 
									dateElementId="userDate1" 
									dateElementName="userDate1" 
									dateElementValue="${formatDate(format:'MM/dd/yyyy',date: agentMasterInstance?.userDate1)}"
									datePickerOptions="changeMonth:true, changeYear:true, yearRange:'${((agentMasterInstance?.userDate1 != null ? agentMasterInstance?.userDate1.get(Calendar.YEAR):Calendar.getInstance().get(Calendar.YEAR)) - 100)}:${((agentMasterInstance?.userDate1 != null ? agentMasterInstance?.userDate1.get(Calendar.YEAR):Calendar.getInstance().get(Calendar.YEAR)) + 100)}', numberOfMonths: 1"
									precision="day" default="none"
									ariaAttributes="aria-labelledby='userDate1_label' aria-describedby='userDate1_error' aria-required='false'" 
									classAttributes ="class='form-control fms_date_mask fms_small_input onDelete hasDatepicker' "
									showIconDefault="${isShowCalendarIcon}"/> 
	
		
                    <div class="fms_form_error" id="userDate1_error"></div>
                 </div>			
                  			                  
                					
		</div>
		<div class="fms_form_column fms_very_long_labels">

                  <label class="control-label" id="userDefined2_label" for="userDefined2">
                  		<g:userDefinedFieldLabel winId="AGNTM" datawindowId ="AGNTM" userDefineTextName="user_defined_2_t" defaultText="User Defined2"/>
                  </label>
                  <div class="fms_form_input">
                     <g:secureTextField name="userDefined2"
						value="${agentMasterInstance?.userDefined2}"  maxlength="60" tableName="AGENT_MASTER" attributeName="userDefined2"
						class="form-control" aria-labelledby="userDefined2_label" aria-describedby="userDefined2_error" aria-required="false">
					</g:secureTextField>
                     <div class="fms_form_error" id="userDefined2_error"></div>
                  </div> 

                  <label class="control-label" id="userDate2_label" for="userDate2">
                  	<g:userDefinedFieldLabel winId="AGNTM" datawindowId ="AGNTM" userDefineTextName="user_date_2_t" defaultText="User Date 2"/>
                  </label>
                  <div class="fms_form_input">
                      <g:securejqDatePickerUIUX 
									tableName="AGENT_MASTER" attributeName="userDate2" 
									dateElementId="userDate2" 
									dateElementName="userDate2" 
									dateElementValue="${formatDate(format:'MM/dd/yyyy',date: agentMasterInstance?.userDate2)}"
									datePickerOptions="changeMonth:true, changeYear:true, yearRange:'${((agentMasterInstance?.userDate2 != null ? agentMasterInstance?.userDate2.get(Calendar.YEAR):Calendar.getInstance().get(Calendar.YEAR)) - 100)}:${((agentMasterInstance?.userDate2 != null ? agentMasterInstance?.userDate2.get(Calendar.YEAR):Calendar.getInstance().get(Calendar.YEAR)) + 100)}', numberOfMonths: 1"
									precision="day" default="none"
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
</div>

<div class="modal fade" id="InfoDeleteModel" tabindex="-1" role="dialog" aria-labelledby="myModalLabel">        
  	<div class="modal-dialog">
       	<div class="modal-content fms_modal_info">
           	<div class="modal-body">
           		<button type="button" class="close" data-dismiss="modal" aria-label="Close"><span aria-hidden="true">&times;</span></button>
           		<h4>Changing Agent ID is not allowed.</h4>
            </div>
            <div class="modal-footer">
            	<button type="button" class="btn btn-default" data-dismiss="modal">Ok</button>
          	</div>
      	</div>
  	</div>
</div>