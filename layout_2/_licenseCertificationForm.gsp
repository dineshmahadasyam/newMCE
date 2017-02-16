<%@ page import="com.perotsystems.diamond.dao.cdo.Agency"%>
<g:set var="appContext" bean="grailsApplication"/>

<link rel="stylesheet" href="${resource(dir: 'css', file: 'member_pages.css')}" type="text/css">

<style type="text/css">
	.deleteButton {
		-moz-box-shadow:inset -1px 1px 7px 0px #ffffff;
		-webkit-box-shadow:inset -1px 1px 7px 0px #ffffff;
		box-shadow:inset -1px 1px 7px 0px #ffffff;
		background-color:#ededed;
		-moz-border-radius:15px;
		-webkit-border-radius:15px;
		border-radius:10px;
		border:1px solid #999999;
		display:inline-block;
		color:#404040;
		font-family:arial;
		font-size:16px;
		font-weight:normal;
		padding:5px 24px;
		text-decoration:none;
		text-shadow:1px 0px 13px #ffffff;
	}.deleteButton:hover {
		background-color:#dfdfdf;
	}.deleteButton:active {
		position:relative;
		top:1px;
	}
</style>

<script type="text/javascript" src="${resource(dir: 'js', file: 'jquery.maskedinput.js')}"></script>
<script type="text/javascript" src="${resource(dir: 'js', file: 'commonfunctions.js')}"></script>
<script type="text/javascript" src="${resource(dir: 'js', file: 'jquery.alphanum.js')}"></script>
<script type="text/javascript" src="${resource(dir: 'js', file: 'jquery.validate.js')}"></script>
<script type="text/javascript" src="${resource(dir: 'js', file: 'jquery.dirtyform.js')}"></script>


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

	function deleteCertificate(seqId, row) {
		
		if (seqId) {
			
			if(userflag) {
				var result = confirm("You will lose unsaved data, Are you sure you want to proceed with deleting this certificate?");
				if (result == true) {	
					document.getElementById('deleteCertificateId').value = seqId
					var appName = "${appContext.metadata['app.name']}";
					var myFm = document.getElementById("editForm");
					myFm.action = "/"+appName+"/agency/deleteCertificate"; 
					myFm.submit();
				}
			}
			else {
				if (confirm("Are you sure you want to delete this Certificate?") == true)  {
					document.getElementById('deleteCertificateId').value = seqId
					var appName = "${appContext.metadata['app.name']}";
					var myFm = document.getElementById("editForm");
					myFm.action = "/"+appName+"/agency/deleteCertificate"; 
					myFm.submit();
			     } 
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
			var result = confirm("You will lose unsaved data, Are you sure you want to proceed with adding a new row?");
		}

		if (!userflag || result == true) {	
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

	function resetForm() {
		document.forms['editForm'].reset();
		//After the form has been reset check the status field and set the status date field appropriately
		if($("#agencyLicense\\.agencyLicenceDtls\\.0\\.status").val() == 'AC') {
			//If status is Active(AC) then Current Status date is not required and needs to be disabled 
			$('#agencyLicense\\.agencyLicenceDtls\\.0\\.currentStatusDate_day').attr('disabled', 'disabled');
			$('#agencyLicense\\.agencyLicenceDtls\\.0\\.currentStatusDate_month').attr('disabled', 'disabled');
			$('#agencyLicense\\.agencyLicenceDtls\\.0\\.currentStatusDate_year').attr('disabled', 'disabled');
			$('#agencyLicense\\.agencyLicenceDtls\\.0\\.currentStatusDate_day').val('');
			$('#agencyLicense\\.agencyLicenceDtls\\.0\\.currentStatusDate_month').val('');
			$('#agencyLicense\\.agencyLicenceDtls\\.0\\.currentStatusDate_year').val('');
			$('#reqdCurrentStatusDate').hide()
		}
		else if ($("#agencyLicense\\.agencyLicenceDtls\\.0\\.status").val() == '') {
			//If Status is empty then Current Status date is enabled but not marked required
			$('#agencyLicense\\.agencyLicenceDtls\\.0\\.currentStatusDate_day').removeAttr('disabled');
			$('#agencyLicense\\.agencyLicenceDtls\\.0\\.currentStatusDate_month').removeAttr('disabled');
			$('#agencyLicense\\.agencyLicenceDtls\\.0\\.currentStatusDate_year').removeAttr('disabled');
			$('#reqdCurrentStatusDate').hide()
		}
		else {
			//If status is not equal to Active(AC) and not empty then Current Status date is required and needs to be enabled 
			$('#agencyLicense\\.agencyLicenceDtls\\.0\\.currentStatusDate_day').removeAttr('disabled');
			$('#agencyLicense\\.agencyLicenceDtls\\.0\\.currentStatusDate_month').removeAttr('disabled');
			$('#agencyLicense\\.agencyLicenceDtls\\.0\\.currentStatusDate_year').removeAttr('disabled');
			$('#reqdCurrentStatusDate').show()
		}

	}


</script>

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
	Agency License and Certification Record for Agency Id (${agencyInstance?.agencyId}) and License No (${agencyLicenseHdrInstance?.licenseNumber})
	<br/>
</g:if>
<g:elseif test="${params.callingPage == 'AGENT'}">
	<div id="${agentMasterInstance?.seqAgentId}">
	Agent/Broker License and Certification Record for Agent Id (${agentMasterInstance?.agentId}) and License No (${agencyLicenseHdrInstance?.licenseNumber}) 
	<br/>
</g:elseif>
		<br/>
		<table border="1" id="report">
			<tr class="head">
				<th>&nbsp;&nbsp;Select</th>
				<g:if test="${params.callingPage == 'AGENCY'}">
					<th>Agency ID</th>
					<th>Agency Name</th>
				</g:if>
				<g:elseif test="${params.callingPage == 'AGENT'}">
					<th>Agent/Broker ID</th>
					<th>Agent Name</th>
				</g:elseif>
				<th>Tax ID</th>
				<th>License No</th>
			</tr>
				<g:each in="${agencyLicenseHdrInstance}" var="agencyLicense" status="i">
					<input type="hidden" name="seq_license_id_${i}" value="${agencyLicenseHdrInstance?.seqLicenseId}">
					<input type="hidden" name="agencyLicense.${i}.iterationCount" value="${i}">
					<input type="hidden" name="agencyLicense.agencyLicenceDtls.${i}.iterationCount" value="${i}">
					<tr class="${(i % 2) == 0 ? 'even' : 'odd'}">
						<td>
							<input type="radio" name="licenseId"  class="selectradio" value="${agencyLicense?.seqLicenseId}">
						</td>
						<g:if test="${params.callingPage == 'AGENCY'}">
							<td class="clickme">
								${agencyInstance?.agencyId}
							</td>
							<td class="clickme">
								${agencyInstance?.agencyName}
							</td>
							<td class="clickme">
								${agencyInstance?.tin}
							</td>
						</g:if>
						<g:elseif test="${params.callingPage == 'AGENT'}">
							<td class="clickme">
								${agentMasterInstance?.agentId}
							</td>
							<td class="clickme">
								<g:if test="${agentMasterInstance?.middleInitial}">
									${agentMasterInstance?.firstName} ${' '} ${agentMasterInstance?.middleInitial} ${' '} ${agentMasterInstance?.lastName}
								</g:if>
								<g:else>
									${agentMasterInstance?.firstName} ${' '} ${agentMasterInstance?.lastName}
								</g:else>
							</td>
							<td class="clickme">
								<g:if test="${agentMasterInstance?.pinTid?.length() == 9}" >${agentMasterInstance?.pinTid.with{length()? getAt(0..1):''}}-${agentMasterInstance?.pinTid.with {length()? getAt(2..length()-1):''}}</g:if>
								<g:else>${agentMasterInstance?.pinTid}</g:else>
							</td>
						</g:elseif>
						<td class="clickme">
							${agencyLicense?.licenseNumber}
						</td>
					</tr>
					<tr class="hideme" id="rowToClone2">
					<td colspan="13">
						<div class="divContent" id="${agencyLicenseHdrInstance?.seqLicenseId}">
							<table class="report1" border="0" style="table-layout: fixed;">
								<g:if test="${params.callingPage == 'AGENCY'}">
									<tr>
										<td class="tdnoWrap" style="white-space: nowrap">
											<div class="fieldcontain ${hasErrors(bean: agencyInstance, field: 'agencyId', 'error')} ">
												<label for="agencyId"> 
													<g:message code="agency.agencyId.label" default="Agency ID :" />
												</label>
												<g:secureTextField name="agencyIdReadonly" id="agencyIdReadonly" readonly="true" style="background:#CCC;" 
													 value="${agencyInstance?.agencyId}" tableName="AGENCY" attributeName="agencyId"></g:secureTextField>
											</div>
										</td>
										<td class="tdnoWrap" style="white-space: nowrap">
											<div class="fieldcontain ${hasErrors(bean: agencyInstance, field: 'agencyName', 'error')} ">
												<label for="agencyName"> 
													<g:message code="agency.agencyName.label" default="Name :" />
												</label>
												<g:secureTextField name="agencyNameReadonly" id="agencyNameReadonly" readonly="true" style="background:#CCC;" 
													 value="${agencyInstance?.agencyName}" tableName="AGENCY" attributeName="agencyName"></g:secureTextField>
											</div>
										</td>
									</tr>
									<tr>
										<td class="tdnoWrap" style="white-space: nowrap">
											<div class="fieldcontain ${hasErrors(bean: agencyInstance, field: 'tin', 'error')} ">
												<label for="tin"> 
													<g:message code="agency.tin.label" default="Tax ID :" />
												</label>
												<g:secureTextField name="tinReadonly" id="tinReadonly" readonly="true" style="background:#CCC;" 
													 value="${agencyInstance?.tin}" tableName="AGENCY" attributeName="tin"></g:secureTextField>
											</div>
										</td>							
										<td class="tdnoWrap" style="white-space: nowrap">
											<div class="fieldcontain ${hasErrors(bean: agencyLicenseHdr, field: 'licenseNumber', 'error')} ">
												<label for="licenseNumber"> 
													<g:message code="agencyLicenseHdr.licenseNumber.label" default="License No :" />
													<span class="required-indicator">*</span> 
												</label>
												<g:secureTextField name="agencyLicense.${i}.licenseNumber" readonly="true" style="background:#CCC;"  
												  value="${agencyLicense?.licenseNumber}" tableName="AGENCY_LICENSE_HDR" attributeName="licenseNumber"
												  title="The License No." maxlength="11" ></g:secureTextField>
											</div>
										</td>
									</tr>
								</g:if>
								<g:elseif test="${params.callingPage == 'AGENT'}">
									<tr>
										<td class="tdnoWrap" style="white-space: nowrap">
											<div class="fieldcontain ${hasErrors(bean: agentMasterInstance, field: 'agentId', 'error')} ">
												<label for="agencyId"> 
													<g:message code="agent.agencyId.label" default="Agent/Broker ID :" />
												</label>
												<g:secureTextField name="agentIdReadonly" id="agentIdReadonly" readonly="true" style="background:#CCC;" 
													 value="${agentMasterInstance?.agentId}" tableName="AGENT_MASTER" attributeName="agentId"></g:secureTextField>
											</div>
										</td>
										<td class="tdnoWrap" style="white-space: nowrap">
											<div class="fieldcontain ${hasErrors(bean: agentMasterInstance, field: 'agentName', 'error')} ">
												<label for="agentName"> 
													<g:message code="agent.agentName.label" default="Name :" />
												</label>
												<g:if test="${agentMasterInstance?.middleInitial}">
													<g:secureTextField name="agentNameReadonlyFirstName" id="agentNameReadonlyFirstName" readonly="true" style="background:#CCC;"  
														 value="${agentMasterInstance?.firstName}" tableName="AGENT_MASTER" attributeName="firstName" >
													</g:secureTextField>
													${' '}
													<g:secureTextField name="agentNameReadonlyMiddleInitial" id="agentNameReadonlyMiddleInitial" readonly="true" style="background:#CCC;"  
														 value="${agentMasterInstance?.middleInitial}" tableName="AGENT_MASTER" attributeName="middleInitial" >
													</g:secureTextField>
													${' '}
													<g:secureTextField name="agentNameReadonlyLastName" id="agentNameReadonlyLastName" readonly="true" style="background:#CCC;"  
														 value="${agentMasterInstance?.lastName}" tableName="AGENT_MASTER" attributeName="lastName" >
													</g:secureTextField>
												</g:if>
												<g:else>
													<g:secureTextField name="agentNameReadonlyFirstName" id="agentNameReadonlyFirstName" readonly="true" style="background:#CCC;"  
														 value="${agentMasterInstance?.firstName}" tableName="AGENT_MASTER" attributeName="firstName" >
													</g:secureTextField>
													${' '}
													<g:secureTextField name="agentNameReadonlyLastName" id="agentNameReadonlyLastName" readonly="true" style="background:#CCC;"  
														 value="${agentMasterInstance?.lastName}" tableName="AGENT_MASTER" attributeName="lastName" >
													</g:secureTextField>
												</g:else>
											</div>
										</td>
									</tr>
									<tr>
										<td class="tdnoWrap" style="white-space: nowrap">
											<div class="fieldcontain ${hasErrors(bean: agentMasterInstance, field: 'pinTid', 'error')} ">
												<label for="pinTid"> 
													<g:message code="agent.pinTid.label" default="Tax ID :" />
												</label>
												<g:secureTextField name="pinTidReadonly" id="pinTidReadonly" readonly="true" style="background:#CCC;" class="maskTaxID" 
											 		value="${agentMasterInstance?.pinTid}" tableName="AGENT_MASTER" attributeName="pinTid"></g:secureTextField>
											</div>
										</td>							
										<td class="tdnoWrap" style="white-space: nowrap">
											<div class="fieldcontain ${hasErrors(bean: agencyLicenseHdr, field: 'licenseNumber', 'error')} ">
												<label for="licenseNumber"> 
													<g:message code="agencyLicenseHdr.licenseNumber.label" default="License No :" />
													<span class="required-indicator">*</span> 
												</label>
												<g:secureTextField name="agencyLicense.${i}.licenseNumber" readonly="true" style="background:#CCC;"  
												 	value="${agencyLicense?.licenseNumber}" tableName="AGENCY_LICENSE_HDR" attributeName="licenseNumber" 
												 	title="The License No." maxlength="11" ></g:secureTextField>
											</div>
										</td>
									</tr>
								</g:elseif>
								<tr>
									<td class="tdnoWrap" style="white-space: nowrap">
										<div class="fieldcontain ${hasErrors(bean: agencyLicenseHdr, field: 'licenseLoa', 'error')} ">
											<label for="licenseLoa"> 
												<g:message code="agencyLicense.licenseLoa.label" default="LOA :" />
													<span class="required-indicator">*</span>
											</label>
											<g:secureSystemCodes
												autofocus = "autofocus"
												systemCodeType="COMMIS_LOA" 
												languageId="0"
												tableName="AGENCY_LICENSE_HDR" attributeName="licenseLoa" 
												htmlElelmentId="agencyLicense.${i}.licenseLoa"
												blankValue="Line Of Authority" 
												defaultValue="${agencyLicense?.licenseLoa}" 
												value="${agencyLicense?.licenseLoa}"
												width="200px">
											</g:secureSystemCodes>
										</div>
									</td>
									<td class="tdnoWrap" style="white-space: nowrap">
											<div class="fieldcontain ${hasErrors(bean: agencyLicenseHdr, field: 'state', 'error')} ">
												<label for="state"> 
													<g:message code="agencyLicense.state.label" default="State :" />
													<span class="required-indicator">*</span> 
												</label>
												<g:secureComboBox name="agencyLicense.${i}.state"  optionKey="stateCode"
														tableName="AGENCY_LICENSE_HDR" attributeName="state" 
														optionValue="stateName" id="agencyLicense.${i}.state" from="${states}"
														noSelection="['':'-- State in which License is Valid --']"
														style="width: 200px"
														value="${agencyLicense?.state}">
												</g:secureComboBox>
											</div>
									</td>
								</tr>
								<tr>
									<td class="tdnoWrap" style="white-space: nowrap">
											<div class="fieldcontain ${hasErrors(bean: agencyLicenseDtl, field: 'effectiveDate', 'error')} ">
												<label for="effectiveDate"> 
													<g:message code="agencyLicense.effectiveDate.label" default="Effective Date :" />
													<span class="required-indicator">*</span> 
												</label>
												<g:secureGrailsDatePicker
													name="agencyLicense.agencyLicenceDtls.${i}.effectiveDate" 
													title ="The Effective Date of the License"
													tableName="AGENCY_LICENSE_DTL" attributeName="effectiveDate" precision="day" noSelection="['':'']"
													value="${agencyLicense?.agencyLicenceDtls?.effectiveDate[0]}" default="none">
												</g:secureGrailsDatePicker>
											</div>
									</td>
									<td class="tdnoWrap" style="white-space: nowrap;">
												<div class="fieldcontain ${hasErrors(bean: agencyLicenseDtl, field: 'expirationDate', 'error')} ">
													<label for="expirationDate"> 
														<g:message code="agencyLicense.effectiveDate.label" default="Expiration Date :" />
														<span class="required-indicator">*</span> 
													</label>
													<g:secureGrailsDatePicker
														name="agencyLicense.agencyLicenceDtls.${i}.expirationDate" 
														title ="The Expiration Date of the License"
														tableName="AGENCY_LICENSE_DTL" attributeName="expirationDate" precision="day" noSelection="['':'']"
														value="${agencyLicense?.agencyLicenceDtls?.expirationDate[0]}" default="none">
													</g:secureGrailsDatePicker>
												</div>
									</td>
								</tr>
								<tr>
									<td class="tdnoWrap" style="white-space: nowrap" >
										<div class="fieldcontain ${hasErrors(bean: agencyLicenseDtl, field: 'status', 'error')} ">
											<label for="status"> 
												<g:message code="agencyLicense.status.label" default="Status :" />
													<span class="required-indicator">*</span>
											</label>
											<g:secureSystemCodes
												systemCodeType="LICENSE_STATUS" 
												systemCodeActive = "Y"
												tableName="AGENCY_LICENSE_DTL" 
												attributeName="status" 
												htmlElelmentId="agencyLicense.agencyLicenceDtls.${i}.status"
												blankValue="Status" 
												defaultValue="${agencyLicense?.agencyLicenceDtls?.status[0]}" 
												value="${agencyLicense?.agencyLicenceDtls?.status[0]}"
												width="200px">
											</g:secureSystemCodes>
										</div>
									</td>
									<td class="tdnoWrap" style="white-space: nowrap;">
												<div class="fieldcontain ${hasErrors(bean: agencyLicenseDtl, field: 'currentStatusDate', 'error')} ">
													<label for="currentStatusDate"> 
														<g:message code="agencyLicense.currentStatusDate.label" default="Current Status Date :" />
														<span class="required-indicator" id="reqdCurrentStatusDate">*</span>
													</label>
													<span>&nbsp;</span>
													<g:secureGrailsDatePicker
														name="agencyLicense.agencyLicenceDtls.${i}.currentStatusDate" 
														title ="The date the License acquired the Status i.e. the Date the License status changed"
														tableName="AGENCY_LICENSE_DTL" attributeName="currentStatusDate" precision="day" noSelection="['':'']"
														value="${agencyLicense?.agencyLicenceDtls?.currentStatusDate[0]}" default="none">
													</g:secureGrailsDatePicker>
												</div>
									</td>
								</tr>
								<tr><td>&nbsp;</td></tr>	
								<tr><td colspan="2"><h4>Certifications</h4><hr></td></tr>	
								<tr><td>&nbsp;</td></tr>
								<tr><td>
									<button type="button" class= "load" name="btnAddRow" onclick="addNewRow()" >Add Row</button>
								</td></tr>
								<tr><td>&nbsp;</td></tr>
								<tr>
									<td colspan="2">
										<table border="1" id="certificateTable" >
											<tr class="head">
												<th>&nbsp;&nbsp;Course</th>
												<th>Description</th>
												<th>Completion Date <span id="reqdCompletionDate" class="required-indicator">*</span></th>
												<th>Expiration Date</th>
												<th>&nbsp;&nbsp;</th>
											</tr>
											<tbody>
												<g:each in="${agencyLicenseHdrInstance?.agencyLicenseCertificates}" var="agencyLicenseCertificate" status="j">
													<input type="hidden" name="seq_certificate_Id_${j}" value="${agencyLicenseCertificate?.seqCertificateId}">
													<input type="hidden" name="agencyLicenseCertificate.${j}.iterationCount" value="${j}">
													<tr class="${(j % 2) == 0 ? 'even' : 'odd'}">
														<td>
															<g:secureTextField class="courseGroup" name="agencyLicenseCertificate.${j}.course" maxlength="20" 
															title = "The Name of the Course that was taken to achieve the license" 
															value="${agencyLicenseCertificate?.course}" tableName="AGENCY_LICENSE_CERTIFICATE" attributeName="course"></g:secureTextField>
														</td>
														<td>
															<g:secureTextField class="descriptionGroup" name="agencyLicenseCertificate.${j}.description" maxlength="60" 
															title = "The description of the Course that was taken to achieve the license" 
															value="${agencyLicenseCertificate?.description}" tableName="AGENCY_LICENSE_CERTIFICATE" attributeName="description"></g:secureTextField>
														</td>
														<td>
															<g:secureGrailsDatePicker
																name="agencyLicenseCertificate.${j}.completionDate" 
																tableName="AGENCY_LICENSE_CERTIFICATE" attributeName="completionDate" precision="day" noSelection="['':'']"
																value="${agencyLicenseCertificate?.completionDate}" default="none"></g:secureGrailsDatePicker>
														</td>
														<td>
															<g:secureGrailsDatePicker
																name="agencyLicenseCertificate.${j}.expirationDate" 
																tableName="AGENCY_LICENSE_CERTIFICATE" attributeName="expirationDate" precision="day" noSelection="['':'']"
																value="${agencyLicenseCertificate?.expirationDate}" default="none"></g:secureGrailsDatePicker>
														
														</td>
														<td>
															<button type="button" class= "deleteButton" name="btnDelete" onclick="deleteCertificate('${agencyLicenseCertificate?.seqCertificateId}', this);" >Delete</button>
														</td>
													</tr>
												</g:each>
											</tbody>
										</table>
									</td>
								</tr>
							</table>
				      	 </div>
					   </td>
					</tr>
				</g:each>
			</table>
		</div>