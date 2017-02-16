<%@ page import="com.perotsystems.diamond.dao.cdo.Agency"%>
<%@ page import="com.dell.diamond.fms.enums.PageNameEnum"%>
<g:set var="appContext" bean="grailsApplication" />

<g:set var="isShowCalendarIcon" value="${ ((PageNameEnum.AGENT_EDIT.equals(currentPage)) || (PageNameEnum.AGENCY_EDIT.equals(currentPage)))?true:false}" />
<g:set var="isShowCalendarIcon" value="true" />

<script type="text/javascript" src="${resource(dir: 'js', file: 'jquery.validate.js')}"></script>
<script type="text/javascript" src="${resource(dir: 'js', file: 'commonfunctions.js')}"></script>
<script type="text/javascript" src="${resource(dir: 'js', file: 'jquery.alphanum.js')}"></script>
<script type="text/javascript" src="${resource(dir: 'js', file: 'jquery.dirtyform.js')}"></script>
<script type="text/javascript" src="${resource(dir: 'js', file: 'additional-methods.js')}"></script>



<script type="text/javascript">

	//<![CDATA[ 
	$(window).load(function() {

		//Show the license record checked and expanded when the page loads
		$('.hideme').find('div').show();
		$('.selectradio').attr('checked', 'checked');

		
		$('.clickme').click(function() {

			if($(this).parent().next('.hideme').find('div').is(":visible")){
				$(this).parent().children().children().get(0).checked = false;
			}else{
				$(this).parent().children().children().get(0).checked = true;
			}

			$(this).parent().next('.hideme').find('div').slideToggle(500);
			return false;
		});

		$(".selectradio").click(function(){
			if($(this).parent().parent().next('.hideme').find('div').is(":visible")){
				$(this).parent().children().get(0).checked = false;
			}else{
				$(this).parent().children().get(0).checked = true;
			}
			$(this).parent().parent().next('.hideme').find('div').slideToggle(500);
		});
		

	});//]]>

</script>

<script type="text/javascript">

	var userflag=false;
	
	$(function(){
	  $("form")	   
	    .dirty_form({changedClass: "forever_changes"})
	    .dirty(function(event, data){
	      var label = $(event.target).parents("li").find("label");
	      userflag=true;	     
	    })
	});	

	function deleteCertificate1(seqId, row) {
		
		if (seqId) {
				document.getElementById('deleteCertificateId').value = seqId
				var appName = "${appContext.metadata['app.name']}";
				var myFm = document.getElementById("editForm");
				myFm.action = "/"+appName+"/agency/deleteCertificate"; 
				myFm.submit();
				}
			}
	function deleteCertificate(seqId, row) {
			if (seqId) {
				if(userflag) {
								document.getElementById('BtnInfoAlertId').click();
							 }
				else {
						document.getElementById('BtnInfoAlertId1').click();
				     } 
			   }
			else {
				//Keep count of number of certificate rows(empty) that is not already added to the DB 
				var appName = "${appContext.metadata['app.name']}";
				var certificateCountUI = $("#certificateCountUI").val()
				var updatedCertificateCountUI = jQuery.ajax({
					url : "/"+appName+"/agency/ajaxUpdateCertificateCountUI?certificateCountUI="+certificateCountUI,
					type : "POST",
					success : function(result) {
						//alert (result)
						if (result !== "null") {
							$("#certificateCountUI").val(result);
						}
					}
				});
				$(row).closest('tr').remove();
				
				//Re-validate the form to update the errors after deleting the row
				$("#editForm").valid();
			}
	}
	
	function addNewRow(){
		
		//userflag = true - when something changed on the form
		//userflag = false - when no changes 
		if(userflag) {
			document.getElementById('btnAdd').click();
			//var result = confirm("You will lose unsaved data, Are you sure you want to proceed with adding a new row?");
		}

		else {	
			document.getElementById('addCertificateRow').value = true;
			var appName = "${appContext.metadata['app.name']}";
			var myFm = document.getElementById("editForm");
			var callingPage = "${params.callingPage}";
			 
			if 	(callingPage == "AGENCY"){
				myFm.action = "/"+appName+"/agency/edit"; 
			}
			else if (callingPage == "AGENT"){
				myFm.action = "/"+appName+"/agentMaster/edit"; 
			}
			myFm.submit();
		}
		
	}
	
	function addNewRow1(){
		document.getElementById('addCertificateRow').value = true;
		var appName = "${appContext.metadata['app.name']}";
		var myFm = document.getElementById("editForm");
		var callingPage = "${params.callingPage}";
		 
		if 	(callingPage == "AGENCY"){
			myFm.action = "/"+appName+"/agency/edit"; 
		}
		else if (callingPage == "AGENT"){
			myFm.action = "/"+appName+"/agentMaster/edit"; 
		}
		myFm.submit();
	}
	
</script>

<script>
	function gotoSearch() {
		var appName = "${appContext.metadata['app.name']}";
		window.location.assign("/"+appName+"/agentMaster/list");
	}

	function onPageLoad(){
		
		if($("#agencyLicense\\.agencyLicenceDtls\\.0\\.status").val() == 'AC') {
			//If status is Active(AC) then Current Status date is not required and needs to be disabled 
			
			STATUSDATE = false;
			$('input[id="agencyLicense.agencyLicenceDtls.0.currentStatusDate"]').attr('disabled', 'disabled');
			$('button[id="_calendar_button_agencyLicense.agencyLicenceDtls.0.currentStatusDate"]').hide();
			$('#reqdCurrentStatusDate').hide()
		}
		else {
			
			STATUSDATE = true;
			$('input[id="agencyLicense.agencyLicenceDtls.0.currentStatusDate"]').removeAttr('disabled', 'disabled');
			$('#reqdCurrentStatusDate').show();
			//$('.ui-datepicker-trigger').show()
			$('button[id="_calendar_button_agencyLicense.agencyLicenceDtls.0.currentStatusDate"]').show();
		}
	}
	
	window.onload = onPageLoad;
</script>

<script type="text/javascript">
	
	$(document).ready(function() {

	      $('.BtnDeleteRow').click(function(e){
              $('#DeleteAlertModal').modal('show');
          });
	      $('#DeleteAlertModal').modal( {
		      backdrop: 'static',
		       show: false 
		  });

	      $('.BtnDeleteRow1').click(function(e){
              $('#DeleteAlertModal1').modal('show');
          });
	      $('#DeleteAlertModal1').modal( {
		      backdrop: 'static',
		       show: false 
		  });

	});

</script>

<script type="text/javascript">
	
	$(document).ready(function() {

	      $('.BtnAddRow').click(function(e){
              $('#AddRowModal').modal('show');
          });
	      $('#AddRowModal').modal( {
		      backdrop: 'static',
		       show: false 
		  });
	});

</script>

<!-- START - FMS Content Body -->
<div id="fms_content_body">

	<p>
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
	<%-- Error messages end--%>
	</p>

	<input type="hidden" name="editType" value="LICENSE" /> 
	<input type="hidden" name="editSubType" value="UPDATE" /> 
	<input type="hidden" name="seqLicenseId" id="seqLicenseId" value="${agencyLicenseHdrInstance?.seqLicenseId}" /> 
	<input type="hidden" name="deleteCertificateId" id="deleteCertificateId" value="" /> 
	<input type="hidden" name="addCertificateRow" id="addCertificateRow" value="" /> 
	<input type="hidden" name="certificateCountUI" id="certificateCountUI" value="${certificateCountUI}" /> 
	<input type="hidden" name="licenseNumber" id="licenseNumber" value="${agencyLicenseHdrInstance?.licenseNumber}" />

	<g:if test="${params.callingPage == 'AGENCY'}">
		<input type="hidden" name="seqAgencyId" value="${agencyInstance?.seqAgencyId }" />
		<input type="hidden" name="callingPage" value="AGENCY" />
	</g:if>
	<g:elseif test="${params.callingPage == 'AGENT'}">
		<input type="hidden" name="seqAgentId" value="${agentMasterInstance?.seqAgentId}" />
		<input type="hidden" name="callingPage" value="AGENT" />
	</g:elseif>

	<g:if test="${params.callingPage == 'AGENCY'}">
		<div id="${agencyInstance?.seqAgencyId}">
			<h2> Agency License and Certification Record for Agency Id (${agencyInstance?.agencyId}) and License No (${agencyLicenseHdrInstance?.licenseNumber}) </h2>
			<br />
	</g:if>
	<g:elseif test="${params.callingPage == 'AGENT'}">
		<div id="${agentMasterInstance?.seqAgentId}">
			<h2> Agent/Broker License and Certification Record for Agent Id (${agentMasterInstance?.agentId}) and License No (${agencyLicenseHdrInstance?.licenseNumber}) </h2>
			<br />
	</g:elseif>

	<div class="fms_required_legend fms_required">= required</div>

	<div id="AddNewDataSection" class="fms_form_border" >
		<div class="fms_widget_border fms_widget_bgnd-color">

				<div class="fms_table_wrapper">
					<table id="DataTable"
						class="tablesorter tablesorter-fms tablesorterdf6319efcolumnselector"
						role="grid" aria-describedby="DataTable_pager_info">

						<tbody aria-live="polite" aria-relevant="all">
							<g:each in="${agencyLicenseHdrInstance}" var="agencyLicense" status="i">
								<input type="hidden" name="seq_license_id_${i}" value="${agencyLicenseHdrInstance?.seqLicenseId}">
								<input type="hidden" name="agencyLicense.${i}.iterationCount" value="${i}">
								<input type="hidden" name="agencyLicense.agencyLicenceDtls.${i}.iterationCount" value="${i}">
						
					

				<fieldset class="no_border">
					<div class="divContent" id="${agencyLicenseHdrInstance?.seqLicenseId}">
						<div class="fms_form_layout_2column">
							<div class="fms_form_column fms_very_long_labels">

								<g:if test="${params.callingPage == 'AGENCY'}">

									<label id="agencyIdReadonly_label" class="control-label" for="agencyIdReadonly"> 
										<g:message code="agency.agencyId.label" default="Agency ID :" />
									</label>
									<div class="fms_form_input">
										<g:secureTextField class="form-control"
											name="agencyIdReadonly" id="agencyIdReadonly" 
											disabled="disabled" value="${agencyInstance?.agencyId}" 
											tableName="AGENCY" attributeName="agencyId"
											ariaAttributes="aria-labelledby='agencyIdReadonly_label' aria-describedby='agencyIdReadonly_error' aria-required='false'">
										</g:secureTextField>
										<div class="fms_form_error" id="agencyIdReadonly_error"></div>
									</div>
									
									<label id="tin_label" class="control-label" for="tinReadonly">
										<g:message code="agency.tin.label" default="Tax ID :" />
									</label>
									<div class="fms_form_input">
										<g:secureTextField class="form-control" name="tinReadonly"
											id="tinReadonly" disabled="disabled"
											value="${agencyInstance?.tin}" tableName="AGENCY"
											attributeName="tin"
											aria-labelledby="tinReadonly_label" 
											aria-describedby="tinReadonly_error" 
											aria-required="false"></g:secureTextField>
										<div class="fms_form_error" id="tin_error"></div>
									</div>

									<label class="control-label fms_required" id="licenseLoa_label" for="licenseLoa"> 
										<g:message code="agencyLicense.licenseLoa.label" default="LOA :" />
									</label>
									<div class="fms_form_input">
										<g:secureSystemCodes 
											autofocus="autofocus"
											cssClass="form-control" 
											systemCodeType="COMMIS_LOA"
											languageId="0" tableName="AGENCY_LICENSE_HDR"
											attributeName="licenseLoa" htmlElelmentId="agencyLicense.${i}.licenseLoa"
											blankValue="Line Of Authority"
											defaultValue="${agencyLicense?.licenseLoa}"
											value="${agencyLicense?.licenseLoa}"
											aria-labelledby="licenseLoa_label" 
											aria-describedby="licenseLoa_error" 
											aria-required="false">
										</g:secureSystemCodes>
										<div class="fms_form_error" id="licenseLoa_error"></div>
									</div>
									
									<label id="effectiveDate_label" class="control-label fms_required" for="effectiveDate">
										<g:message code="agencyLicense.effectiveDate.label" default="Effective Date :" />
									</label>
									<div class="fms_form_input">
										<g:securejqDatePickerUIUX 
											tableName="AGENCY_LICENSE_DTL"
											attributeName="effectiveDate"
											dateElementId="agencyLicense.agencyLicenceDtls.${i}.effectiveDate"
											dateElementName="agencyLicense.agencyLicenceDtls.${i}.effectiveDate"
											datePickerOptions="changeMonth: true, changeYear: true, yearRange: '${((agencyLicense?.agencyLicenceDtls?.effectiveDate[0] != null ? agencyLicense?.agencyLicenceDtls?.effectiveDate[0].get(Calendar.YEAR):Calendar.getInstance().get(Calendar.YEAR)) - 100)} : ${((agencyLicense?.agencyLicenceDtls?.effectiveDate[0] != null ? agencyLicense?.agencyLicenceDtls?.effectiveDate[0].get(Calendar.YEAR):Calendar.getInstance().get(Calendar.YEAR)) + 100)}', numberOfMonths: 1"
											dateElementValue="${formatDate(format:'MM/dd/yyyy',date: agencyLicense?.agencyLicenceDtls?.effectiveDate[0])}"
											ariaAttributes="aria-labelledby='effectiveDate_label' aria-describedby='effectiveDate_error' aria-required='false'"
											classAttributes="class='form-control fms_date_mask fms_small_input onDelete hasDatepicker' "
											showIconDefault="${isShowCalendarIcon}" />
										<div class="fms_form_error" id="effectiveDate_error"></div>
									</div>

									<label id="status_label" class="control-label fms_required" for="status"> 
										<g:message code="agencyLicense.status.label" default="Status :" />
									</label>
									<div class="fms_form_input">
										<g:secureSystemCodes 
											cssClass="form-control"
											systemCodeType="LICENSE_STATUS" 
											systemCodeActive="Y" tableName="AGENCY_LICENSE_DTL" 
											attributeName="status"
											htmlElelmentId="agencyLicense.agencyLicenceDtls.${i}.status"
											blankValue="Status"
											defaultValue="${agencyLicense?.agencyLicenceDtls?.status[0]}"
											value="${agencyLicense?.agencyLicenceDtls?.status[0]}"
											aria-labelledby="status_label" 
											aria-describedby="status_error" 
											aria-required="false">
										</g:secureSystemCodes>
										<div class="fms_form_error" id="status_error"></div>
									</div>
							</div>
							
							<div class="fms_form_column fms_very_long_labels">

									<label id="agencyName_label" class="control-label" for="agencyNameReadonly"> 
										<g:message code="agency.agencyName.label" default="Name :" />
									</label>
									<div class="fms_form_input">
										<g:secureTextField class="form-control"
											name="agencyNameReadonly" id="agencyNameReadonly"
											disabled="disabled" value="${agencyInstance?.agencyName}"
											tableName="AGENCY" attributeName="agencyName"
											aria-labelledby="agencyNameReadonly_label" 
											aria-describedby="agencyNameReadonly_error" 
											aria-required="false"></g:secureTextField>
										<div class="fms_form_error" id="agencyName_error"></div>
									</div>

									<label id="licenseNumber_label" class="control-label fms_required" for="licenseNumber">
										<g:message code="agencyLicenseHdr.licenseNumber.label" default="License No :" />
									</label>
									<div class="fms_form_input">
										<g:secureTextField class="form-control"
											name="agencyLicense.${i}.licenseNumber" disabled="disabled"
											value="${agencyLicense?.licenseNumber}"
											tableName="AGENCY_LICENSE_HDR" 
											attributeName="licenseNumber" title="The License No." 
											maxlength="11"
											aria-labelledby="licenseNumber_label" 
											aria-describedby="licenseNumber_error" 
											aria-required="false">
										</g:secureTextField>
										<div class="fms_form_error" id="licenseNumber_error"></div>
									</div>

									<label id="state_label" class="control-label fms_required" for="state"> 
										<g:message code="agencyLicense.state.label" default="State :" />
									</label>
									<div class="fms_form_input">
										<g:secureComboBox 
											class="form-control"
											name="agencyLicense.${i}.state" optionKey="stateCode"
											tableName="AGENCY_LICENSE_HDR" attributeName="state"
											optionValue="stateName" id="agencyLicense.${i}.state"
											from="${states}"
											noSelection="['':'-- State in which License is Valid --']"
											value="${agencyLicense?.state}"
											aria-labelledby="state_label" 
											aria-describedby="state_error" 
											aria-required="false">
										</g:secureComboBox>
										<div class="fms_form_error" id="state_error"></div>
									</div>

							</g:if>

							<g:elseif test="${params.callingPage == 'AGENT'}">
							
									<label id="agencyId_label" class="control-label" for="agentIdReadonly"> 
										<g:message code="agent.agencyId.label" default="Agent/Broker ID :" />
									</label>
									<div class="fms_form_input">
										<g:secureTextField 
											class="form-control" name="agentIdReadonly"
											id="agentIdReadonly" disabled="disabled"
											value="${agentMasterInstance?.agentId}"
											tableName="AGENT_MASTER" attributeName="agentId"
											aria-labelledby="agentIdReadonly_label" 
											aria-describedby="agentIdReadonly_error" 
											aria-required="false">
										</g:secureTextField>
										<div class="fms_form_error" id="agencyId_error"></div>
									</div>

									<label id="pinTid_label" class="control-label" for="pinTidReadonly"> 
										<g:message code="agent.pinTid.label" default="Tax ID :" />
									</label>
									<div class="fms_form_input">
										<g:secureTextField 
											class="form-control" name="pinTidReadonly"
											id="pinTidReadonly" disabled="disabled"
											value="${agentMasterInstance?.pinTid}"
											tableName="AGENT_MASTER" attributeName="pinTid"
											aria-labelledby="pinTidReadonly_label" 
											aria-describedby="pinTidReadonly_error" 
											aria-required="false">
										</g:secureTextField>
										<div class="fms_form_error" id="pinTid_error"></div>
									</div>

									<label class="control-label fms_required" id="licenseLoa_label" for="licenseLoa"> 
										<g:message code="agencyLicense.licenseLoa.label" default="LOA :" />
									</label>
									<div class="fms_form_input">
										<g:secureSystemCodes 
											autofocus="autofocus"
											cssClass="form-control" systemCodeType="COMMIS_LOA"
											languageId="0" tableName="AGENCY_LICENSE_HDR"
											attributeName="licenseLoa" htmlElelmentId="agencyLicense.${i}.licenseLoa"
											blankValue="Line Of Authority"
											defaultValue="${agencyLicense?.licenseLoa}"
											value="${agencyLicense?.licenseLoa}"
											aria-labelledby="licenseLoa_label" 
											aria-describedby="licenseLoa_error" 
											aria-required="false">
										</g:secureSystemCodes>
										<div class="fms_form_error" id="licenseLoa_error"></div>
									</div>
									
									<label id="effectiveDate_label"
										class="control-label fms_required" for="effectiveDate">
										<g:message code="agencyLicense.effectiveDate.label"
											default="Effective Date :" />
									</label>
									<div class="fms_form_input">
									
									<g:securejqDatePickerUIUX
											tableName="AGENCY_LICENSE_DTL" attributeName="effectiveDate" 
											dateElementId="agencyLicense.agencyLicenceDtls.${i}.effectiveDate" 
											dateElementName="agencyLicense.agencyLicenceDtls.${i}.effectiveDate" mandatory="mandatory"
											dateElementValue="${formatDate(format:'MM/dd/yyyy',date: agencyLicense?.agencyLicenceDtls?.effectiveDate[0])}" 
											datePickerOptions="changeMonth:true, changeYear:true, yearRange:'${((agencyAddress?.effectiveDate != null ? agencyAddress?.effectiveDate.get(Calendar.YEAR):Calendar.getInstance().get(Calendar.YEAR)) - 100)}:${((agencyAddress?.effectiveDate != null ? agencyAddress?.effectiveDate.get(Calendar.YEAR):Calendar.getInstance().get(Calendar.YEAR)) + 100)}', numberOfMonths: 1"
											ariaAttributes="aria-labelledby='effectiveDate_label' aria-describedby='effectiveDate_error' aria-required='false'" 
					                        classAttributes ="class='form-control fms_date_mask fms_small_input onDelete hasDatepicker' "
											showIconDefault="${isShowCalendarIcon}"/> 
									
									
										<div class="fms_form_error" id="effectiveDate_error"></div>
									</div>

									<label id="status_label" class="control-label fms_required" for="status"> 
										<g:message code="agencyLicense.status.label" default="Status :" />
									</label>
									<div class="fms_form_input">
										<g:secureSystemCodes 
											cssClass="form-control"
											systemCodeType="LICENSE_STATUS" systemCodeActive="Y"
											tableName="AGENCY_LICENSE_DTL" attributeName="status"
											htmlElelmentId="agencyLicense.agencyLicenceDtls.${i}.status"
											blankValue="Status"
											defaultValue="${agencyLicense?.agencyLicenceDtls?.status[0]}"
											value="${agencyLicense?.agencyLicenceDtls?.status[0]}"
											aria-labelledby="status_label" 
											aria-describedby="status_error" 
											aria-required="false">
										</g:secureSystemCodes>
										<div class="fms_form_error" id="status_error"></div>
									</div>
							</div>
							
							<div class="fms_form_column fms_very_long_labels">

									<label id="agentName_label" class="control-label" for="agentName"> 
										<g:message code="agent.agentName.label" default="Name :" />
									</label>
									<div class="fms_form_input">
									
										<g:if test="${agentMasterInstance?.middleInitial}">
											<g:secureTextField class="form-control"
												name="agentNameReadonlyFirstName"
												id="agentNameReadonlyFirstName" disabled="disabled"
												value="${agentMasterInstance?.firstName}"
												tableName="AGENT_MASTER" attributeName="firstName">
											</g:secureTextField>
											${' '}
											<g:secureTextField class="form-control"
												name="agentNameReadonlyMiddleInitial"
												id="agentNameReadonlyMiddleInitial" disabled="disabled"
												value="${agentMasterInstance?.middleInitial}"
												tableName="AGENT_MASTER" attributeName="middleInitial">
											</g:secureTextField>
											${' '}
											<g:secureTextField class="form-control"
												name="agentNameReadonlyLastName"
												id="agentNameReadonlyLastName" disabled="disabled"
												value="${agentMasterInstance?.lastName}"
												tableName="AGENT_MASTER" attributeName="lastName">
											</g:secureTextField>
										</g:if>
										
										<g:else>
										
											<g:secureTextField class="form-control"
												name="agentNameReadonlyFirstName"
												id="agentNameReadonlyFirstName" disabled="disabled"
												value="${agentMasterInstance?.firstName}"
												tableName="AGENT_MASTER" attributeName="firstName">
											</g:secureTextField>
											${' '}
											<g:secureTextField class="form-control"
												name="agentNameReadonlyLastName"
												id="agentNameReadonlyLastName" disabled="disabled"
												value="${agentMasterInstance?.lastName}"
												tableName="AGENT_MASTER" attributeName="lastName">
											</g:secureTextField>
										</g:else>
										
										<div class="fms_form_error" id="agentName_error"></div>
									</div>
									
									<label id="licenseNumber_label" class="control-label fms_required" for="licenseNumber">
										<g:message code="agencyLicenseHdr.licenseNumber.label" default="License No :" />
									</label>
									<div class="fms_form_input">
										<g:secureTextField class="form-control"
											name="agencyLicense.${i}.licenseNumber" disabled="disabled"
											value="${agencyLicense?.licenseNumber}"
											tableName="AGENCY_LICENSE_HDR" attributeName="licenseNumber"
											title="The License No." maxlength="11"
											aria-labelledby="licenseNumber_label" 
											aria-describedby="licenseNumber_error" 
											aria-required="false">
										</g:secureTextField>
										<div class="fms_form_error" id="licenseNumber_error"></div>
									</div>

									<label id="state_label" class="control-label fms_required" for="state"> 
										<g:message code="agencyLicense.state.label" default="State :" />
									</label>
									<div class="fms_form_input">
										<g:secureComboBox class="form-control"
											name="agencyLicense.${i}.state" optionKey="stateCode"
											tableName="AGENCY_LICENSE_HDR" attributeName="state"
											optionValue="stateName" id="agencyLicense.${i}.state"
											from="${states}"
											noSelection="['':'-- State in which License is Valid --']"
											value="${agencyLicense?.state}"
											aria-labelledby="state_label" 
											aria-describedby="state_error" 
											aria-required="false">
										</g:secureComboBox>
										<div class="fms_form_error" id="state_error"></div>
									</div>

							</g:elseif>
							
									<label id="expirationDate_label" class="control-label fms_required" for="agencyLicense.agencyLicenceDtls.${i}.expirationDate">
										<g:message code="agencyLicense.effectiveDate.label" default="Expiration Date :" />
									</label>
									<div class="fms_form_input">
										<g:securejqDatePickerUIUX 
											tableName="AGENCY_LICENSE_DTL"
											attributeName="expirationDate"
											dateElementId="agencyLicense.agencyLicenceDtls.${i}.expirationDate"
											dateElementName="agencyLicense.agencyLicenceDtls.${i}.expirationDate"
											datePickerOptions="changeMonth:true, changeYear:true, yearRange:'${((agencyAddress?.effectiveDate != null ? agencyAddress?.effectiveDate.get(Calendar.YEAR):Calendar.getInstance().get(Calendar.YEAR)) - 100)}:${((agencyAddress?.effectiveDate != null ? agencyAddress?.effectiveDate.get(Calendar.YEAR):Calendar.getInstance().get(Calendar.YEAR)) + 100)}', numberOfMonths: 1"
											dateElementValue="${formatDate(format:'MM/dd/yyyy',date: agencyLicense?.agencyLicenceDtls?.expirationDate[0])}"
											ariaAttributes="aria-labelledby='expirationDate_label' aria-describedby='expirationDate_error' aria-required='false'"
											classAttributes="class='form-control fms_date_mask fms_small_input onDelete hasDatepicker' "
											showIconDefault="${isShowCalendarIcon}" />
										<div class="fms_form_error" id="expirationDate_error"></div>
									</div>

									<label id="currentStatusDate_label" class="control-label " for="agencyLicense.agencyLicenceDtls.${i}.currentStatusDate">
										<span class="fms_required" id="reqdCurrentStatusDate"></span>
										<g:message code="agencyLicense.currentStatusDate.label"	default="Current Status Date :" />
									</label>
									<div class="fms_form_input">
										<g:securejqDatePickerUIUX 
											tableName="AGENCY_LICENSE_DTL"
											attributeName="currentStatusDate"
											dateElementId="agencyLicense.agencyLicenceDtls.${i}.currentStatusDate"
											dateElementName="agencyLicense.agencyLicenceDtls.${i}.currentStatusDate"
											datePickerOptions="changeMonth: true, changeYear: true, yearRange: '${((agencyLicense?.agencyLicenceDtls?.currentStatusDate[0] != null ? agencyLicense?.agencyLicenceDtls?.currentStatusDate[0].get(Calendar.YEAR):Calendar.getInstance().get(Calendar.YEAR)) - 100)} : ${((agencyLicense?.agencyLicenceDtls?.currentStatusDate[0] != null ? agencyLicense?.agencyLicenceDtls?.currentStatusDate[0].get(Calendar.YEAR):Calendar.getInstance().get(Calendar.YEAR)) + 100)}', numberOfMonths: 1"
											dateElementValue="${formatDate(format:'MM/dd/yyyy',date: agencyLicense?.agencyLicenceDtls?.currentStatusDate[0])}"
											ariaAttributes="aria-labelledby='currentStatusDate_label' aria-describedby='currentStatusDate_error' aria-required='false'"
											classAttributes="class='form-control fms_date_mask fms_small_input onDelete hasDatepicker' "
											showIconDefault="${STATUSDATE}" />
										<div class="fms_form_error" id="currentStatusDate_error"></div>
									</div>
							</div>
						</div></div>
				</fieldset>
			<!-- START - WIDGET: Certificate-->
							<div id="AddNewDataSection" class="fms_widget" >
								<fieldset class="no_border">
									<legend>
										<h3>Certifications</h3>
									</legend>
									
									<button type="button" class="btn btn-primary" name="btnAddRow" onclick="addNewRow()">Add Row</button>
									
									<div class="fms_table_wrapper">
										<table id="certificateTable" class="tablesorter tablesorter-fms tablesorterdf6319efcolumnselector" role="grid" aria-describedby="DataTable_pager_info">
											<thead>
												<tr role="row" class="tablesorter-headerRow">
													<th class="{sorter: false} tablesorter-header sorter-false"
														data-column="0" data-columnselector="disable"
														aria-disabled="true">Course</th>
													<th class="{sorter: false} tablesorter-header sorter-false"
														data-column="1" data-columnselector="disable"
														aria-disabled="true">Description</th>
													<th	class="{sorter: false} tablesorter-header sorter-false"
														data-column="2" data-columnselector="disable"
														aria-disabled="true">Completion Date <span id="reqdCompletionDate" class="required-indicator">*</span> </th>
													<th
														class="{sorter: false} tablesorter-header sorter-false "
														data-column="3" data-columnselector="disable"
														aria-disabled="true">Expiration Date</th>
													<th class="{sorter: false} tablesorter-header sorter-false"
														data-column="7" data-columnselector="disable"
														aria-disabled="true">Actions</th>
												</tr>
											</thead>
											<tbody>
												<g:each in="${agencyLicenseHdrInstance?.agencyLicenseCertificates}" var="agencyLicenseCertificate" status="j">
													<input type="hidden" name="seq_certificate_Id_${j}" value="${agencyLicenseCertificate?.seqCertificateId}">
													<input type="hidden" name="agencyLicenseCertificate.${j}.iterationCount" value="${j}">
													<tr class="${(j % 2) == 0 ? 'even' : 'odd'}">
														<td><g:secureTextField class="form-control courseGroup"
																name="agencyLicenseCertificate.${j}.course"
																maxlength="20"
																title="The Name of the Course that was taken to achieve the license"
																value="${agencyLicenseCertificate?.course}"
																tableName="AGENCY_LICENSE_CERTIFICATE"
																attributeName="course">
															</g:secureTextField>
														</td>
														<td><g:secureTextField class="form-control descriptionGroup"
																name="agencyLicenseCertificate.${j}.description"
																maxlength="60"
																title="The description of the Course that was taken to achieve the license"
																value="${agencyLicenseCertificate?.description}"
																tableName="AGENCY_LICENSE_CERTIFICATE"
																attributeName="description">
															</g:secureTextField>
														</td>
														<td> <g:securejqDatePickerUIUX
																dateElementName="agencyLicenseCertificate.${j}.completionDate"
																attributeName="completionDate" 
																datePickerOptions="changeMonth: true, changeYear: true, yearRange: '${((agencyLicenseCertificate?.completionDate != null ? agencyLicenseCertificate?.completionDate.get(Calendar.YEAR):Calendar.getInstance().get(Calendar.YEAR)) - 100)} : ${((agencyLicenseCertificate?.completionDate != null ? agencyLicenseCertificate?.completionDate.get(Calendar.YEAR):Calendar.getInstance().get(Calendar.YEAR)) + 100)}', numberOfMonths: 1"
																dateElementId="agencyLicenseCertificate.${j}.completionDate"
																tableName="AGENCY_LICENSE_CERTIFICATE"
																dateElementValue="${formatDate(format:'MM/dd/yyyy',date: agencyLicenseCertificate?.completionDate)}"
																ariaAttributes="aria-labelledby='completionDate_label' aria-describedby='completionDate_error' aria-required='false'"
																classAttributes="class='form-control fms_date_mask fms_small_input onDelete hasDatepicker' "
																showIconDefault="${isShowCalendarIcon}">
															</g:securejqDatePickerUIUX>
														</td>
														<td><g:securejqDatePickerUIUX
																attributeName="expirationDate" 
																dateElementId="agencyLicenseCertificate.${j}.expirationDate"
																dateElementName="agencyLicenseCertificate.${j}.expirationDate"
																datePickerOptions="changeMonth: true, changeYear: true, yearRange: '${((agencyLicenseCertificate?.expirationDate != null ? agencyLicenseCertificate?.expirationDate.get(Calendar.YEAR):Calendar.getInstance().get(Calendar.YEAR)) - 100)} : ${((agencyLicenseCertificate?.expirationDate != null ? agencyLicenseCertificate?.expirationDate.get(Calendar.YEAR):Calendar.getInstance().get(Calendar.YEAR)) + 100)}', numberOfMonths: 1"
																tableName="AGENCY_LICENSE_CERTIFICATE"
																dateElementValue= "${formatDate(format:'MM/dd/yyyy',date: agencyLicenseCertificate?.expirationDate)}"
																ariaAttributes="aria-labelledby='expirationDate_label' aria-describedby='expirationDate_error' aria-required='false'"
																classAttributes="class='form-control fms_date_mask fms_small_input onDelete hasDatepicker' "
																showIconDefault="${isShowCalendarIcon}">
															</g:securejqDatePickerUIUX>
														</td>
														<td>
														
															<button type="button" class= "btn fms_btn_icon btn-sm" name="btnDelete" title="Click to delete row." onclick="deleteCertificate('${agencyLicenseCertificate?.seqCertificateId}', this);" ><i class="fa fa-trash"></i></button>
															<button id="BtnInfoAlertId" type="button" class="btn fms_btn_icon btn-sm BtnDeleteRow" data-target="#DeleteAlertModal"></button>
															<button id="BtnInfoAlertId1" type="button" class="btn fms_btn_icon btn-sm BtnDeleteRow1" data-target="#DeleteAlertModal1"></button>
															
															<!-- START - Delete Notice Modal -->
																	<div class="modal fade" id="DeleteAlertModal" tabindex="-1" role="dialog" aria-labelledby="myModalLabel">        
																		<div class="modal-dialog">
																			<div class="modal-content fms_modal_error">
																				<div class="modal-body">
																					<button type="button" class="close" data-dismiss="modal" aria-label="Close"><span aria-hidden="true">&times;</span></button>
																					<h4>You will lose unsaved data, Are you sure you want to proceed with deleting this certificate?</h4>            
																				</div>
																				<div class="modal-footer">
																					<button type="button" class="btn btn-default" data-dismiss="modal">Cancel</button>
																					<button id="BtnDeleteRowYes" type="button" class="btn btn-primary" onclick="deleteCertificate1('${agencyLicenseCertificate?.seqCertificateId}', this);" data-dismiss="modal">Yes, Delete</button>
																				</div>
																			</div>
																		</div>
																	</div>
																	<!-- END - Delete Notice Modal -->
	
																	<!-- START - Delete Notice Modal -->
																	<div class="modal fade" id="DeleteAlertModal1" tabindex="-1" role="dialog" aria-labelledby="myModalLabel">        
																		<div class="modal-dialog">
																			<div class="modal-content fms_modal_error">
																				<div class="modal-body">
																					<button type="button" class="close" data-dismiss="modal" aria-label="Close"><span aria-hidden="true">&times;</span></button>
																					<h4>Are you sure you want to delete this Certificate?</h4>            
																				</div>
																				<div class="modal-footer">
																					<button type="button" class="btn btn-default" data-dismiss="modal">Cancel</button>
																					<button id="BtnDeleteRowYes1" type="button" class="btn btn-primary" onclick="deleteCertificate1('${agencyLicenseCertificate?.seqCertificateId}', this);" data-dismiss="modal">Yes, Delete</button>
																				</div>
																			</div>
																		</div>
																	</div>
																	<!-- END - Delete Notice Modal -->
																	
																</td>
															</tr>
														</g:each>
													</tbody>
												</table>
											</div>
											<br></br>
									
											<div class="fms_form_button">
												<g:actionSubmit class="btn btn-primary" action="update" value="${message(code: 'default.button.save.label', default: 'Save')}" />
												<input type="Reset" class="btn btn-default" value="Reset" onClick="resetForm()" /> 
												<input type="button" class="btn btn-default" value="Close" name="close" onClick="closeForm()" />
												
												<input id="btnAdd" type="hidden" class="btn btn-default BtnAddRow" value="${message(code: 'default.button.delete.label', default: 'Delete1')}" data-target="#AddRowModal" />
															
											</div>
										</fieldset>
									</div>
								</g:each>
							</tbody>
						</table>
					</div>
				</div>
			</div>
		</div>

<!-- START - Add Row Notice Modal -->
<div class="modal fade" id="AddRowModal" tabindex="-1" role="dialog" aria-labelledby="myModalLabel">        
	<div class="modal-dialog">
		<div class="modal-content fms_modal_error">
			<div class="modal-body">
				<button type="button" class="close" data-dismiss="modal" aria-label="Close"><span aria-hidden="true">&times;</span></button>
				<h4>You will lose unsaved data, Are you sure you want to proceed with adding a new row?</h4>            
			</div>
			<div class="modal-footer">
				<button type="button" class="btn btn-default" data-dismiss="modal">Cancel</button>
				<button id="BtnDeleteRowYes" type="button" class="btn btn-primary" onClick="addNewRow1()" data-dismiss="modal">Yes, Add Row</button>
			</div>
		</div>
	</div>
</div>
<!-- END - Add Row Notice Modal -->

