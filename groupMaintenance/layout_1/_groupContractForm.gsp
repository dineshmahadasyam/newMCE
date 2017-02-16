<%@ page import="com.perotsystems.diamond.bom.GroupContract"%>
<%@ page import="com.dell.diamond.fms.enums.PageNameEnum" %>

<g:set var="appContext" bean="grailsApplication"/>
<meta name="navSelector" content="maint" />
<meta name="navChildSelector" content="groupMaintenance" />
<g:set var="isShowCalendarIcon" value="${PageNameEnum.GROUP_EDIT.equals(currentPage)?true:false}" />
<link rel="stylesheet" href="${resource(dir: 'css', file: 'member_pages.css')}" type="text/css">

<head>
<script type="text/javascript" src="${resource(dir: 'js', file: 'jquery.maskedinput.js')}"></script>
<script type="text/javascript" src="${resource(dir: 'js', file: 'commonfunctions.js')}"></script>
<script type="text/javascript" src="${resource(dir: 'js', file: 'jquery.alphanum.js')}"></script>

<script type="text/javascript">
	//<![CDATA[ 
	$(window).load(function() {
		$('.hideme').find('div').hide();
		$('.clickme').click(function() {
			//CQ 56593 fix started
		   
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
		//CQ 56593 fix fixed

		 //$(".numberOfEmployees").numeric({});
	});//]]>  	
</script>
<script>
$(function(){

    $(".numberOfEmployees").numeric({});
	
})
</script>
<script type="text/javascript">

	$(document).ready(function() {

		// If all rows are deleted show message
        if ($('#DataTable td').length <= 0) {
            $('#BtnSave').attr('disabled', 'disabled');
            $('#BtnUndo').attr('disabled', 'disabled');
          $('#DataTable').append('<tr id="EmptyTable"><td colspan="7">There are no records to display</td></tr>');
        }

        // Click on save button in add form
        // Hide form show table 
        // Remove empty table row (if one)
        // Add clone rows and updates tablesorter
        $("#BtnAddNewSave").click(function(){ 
          $('#DataTable #EmptyTable').remove(); 
          $("#DataTableSection").show(); 
          $("#BtnAddNewSection").hide();
          updateCloneIDs();
          storeSampleRow.clone().appendTo( "#DataTable tbody" );
          storeSampleRowChild.clone().appendTo( "#DataTable tbody" );
          $('#DataTable').trigger('update');             
        });

        

		$('.BtnCollapseRow').hide().removeClass('hidden');	

	      // Edit icon on table row
	         $('.tablesorter').delegate('.BtnEditRow, .BtnCollapseRow', 'click' ,function(e){
	          // e.preventDefault();  
	           var parentTR = $(this).closest('tr');
	           $(parentTR).find('.BtnEditRow, .BtnCollapseRow').toggle();
	           $(parentTR).nextUntil('tr:not(.tablesorter-childRow)').find('td').toggle();
	         });

	     // Save button 
         $('.BtnSave').click(function(e){
           //e.preventDefault();            
           $('#SaveAlertModal').modal('show');
         });
         
         // Save Modal
         $('.BtnSaveModal').click(function(e){
          // e.preventDefault();            
           //this.form.submit(); // JQuery validations will not trigger
           $('#editForm').submit();//resetForm();
         });

       // Undo button
         $('.BtnUndo').click(function(e){
           //e.preventDefault();            
           $('#WarningAlertModal').modal('show');
         });

         $('.BtnUndoModal').click(function(e){
           //e.preventDefault(); 
           this.form.reset();
           resetForm();           
         });
         		      
         function resetForm(){
             $('.BtnCollapseRow').hide();
             $('.BtnEditRow').show();
             $('.tablesorter-childRow td').hide();
             //$('#BtnSave').attr('disabled','disabled');
             //$('#BtnUndo').attr('disabled','disabled');
             //$('.UnsavedChanges').hide();          
           }
         
      // On form change enable the save and reset buttons
        /* $('form :input').on('change input', function(e) {
           $('#BtnSave').removeAttr('disabled');
           $('#BtnUndo').removeAttr('disabled');
         });	*/
         
       //$('#DataTable').removeClass( "hidden" );
	});
</script>

<script>
	$(document).ready( function () {
		claimActionCodeDisabled();
		claimReasonDisabled();
		});
	function cloneRow()
	{

		var divObjSrc = document.getElementById('newContractDiv')
		var divObjDest = document.getElementById('addContractPlaceHolder')
		divObjDest.innerHTML = divObjSrc.innerHTML
		var divObj = document.getElementById('addContractButton')
		divObj.style.display = "none"	
	}

	function addGroupContract() {
		var groupId = "${groupMasterInstance?.groupId}";
		var groupDBId = "${groupMasterInstance?.groupDBId}";
		var appName = "${appContext.metadata['app.name']}";
						
		window.location.assign("/"+ appName+"/groupMaintenance/addGroupContract?groupId="
				+ groupId + "&grouEditType=CONTRACT&groupDBId="+groupDBId);
	}
	function claimActionCodeDisabled()	
	{	
        var ims = document.getElementsByName("addressId");
        for(var i = 0;i < ims.length;i++){
         var contrct = "contract."
         var i_value = i
         var clm_grce_days = ".claimGraceDays"
         var claim_id = contrct.concat(i_value,clm_grce_days)
         var k = document.getElementById(claim_id).value;                
         var clm_actn_code = ".claimActionCode"
         var clm_actn_code_conct = contrct.concat(i_value,clm_actn_code)              
         var clm_resn_code ='.claimReason'
         var clm_resn_code_conct = contrct.concat(i_value,clm_resn_code)                        
          
         var claimGraceDays = document.getElementById(claim_id).value.trim()
               if(claimGraceDays.trim() !=""  && isNaN(claimGraceDays.trim())==false){
                    document.getElementById(clm_actn_code_conct).disabled = false
                       
               }
               else{                                                         
                    document.getElementById(clm_resn_code_conct).value=""           
                    document.getElementById(clm_actn_code_conct).value=""
                    document.getElementById(clm_actn_code_conct).disabled = true
                    document.getElementById(clm_resn_code_conct).disabled = true 
                  }
                  
                  k=""
                  }			
	}

	function claimReasonDisabled()
	{
	    var ims = document.getElementsByName("addressId");
        for(var i = 0;i < ims.length;i++){
        	var contrct = "contract."
            var i_value = i
            var clm_actn_code = ".claimActionCode"
            var clm_actn_code_conct = contrct.concat(i_value,clm_actn_code)              
            var clm_resn_code ='.claimReason'
            var clm_resn_code_conct = contrct.concat(i_value,clm_resn_code)    
                
		var claimActionCode = document.getElementById(clm_actn_code_conct).value.trim()
		if(claimActionCode!=null){			
			if(claimActionCode.trim()=='D' || claimActionCode.trim()=='H'){	
			 document.getElementById(clm_resn_code_conct).disabled = false
		}else{		
			document.getElementById(clm_resn_code_conct).value=""
			document.getElementById(clm_resn_code_conct).disabled = true
			}
			}
        }		
	}
	function gotoSearch() {
		var appName = "${appContext.metadata['app.name']}";
		window.location.assign("/"+appName+"/groupMaintenance/list");
	}

	function isNumberKey(evt) {
		var charCode = (evt.which) ? evt.which : event.keyCode
		if ((charCode > 47 && charCode < 58) || (charCode > 64 && charCode < 91) || (charCode > 96 && charCode < 123))
		      return true;

		         return false;
			}
</script>
</head>

<g:hiddenField name="groupId" value="${groupMasterInstance?.groupId}" />
<g:hiddenField name="groupDBId" value="${groupMasterInstance?.groupDBId}" />

<div id="fms_content_body">
	<div class="right-corner" align="right">GRUPC</div>
	
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

	<div id="addContractButton" style="display: block">
		<input class="btn btn-primary btn-sm" type="button"	value="Add Contract" onClick="addGroupContract()">
		<g:actionSubmit class="btn btn-primary btn-sm"	action="renewSingleGroup" value="Renew Contract" disabled="${disabled}" />
		<br></br>
	</div>
	
<div class="fms_required_legend fms_required">= required</div>
<!-- START - Data Table Section -->	
	<div id="fms_widget">
	<div class="row bottom-margin-sm">
        <div class="col-xs-6">
          <button class="btn btn-sm btn-primary" type="button" onclick='gotoSearch()' title="Click to perform a new search.">New Search</button>
        </div>
        <div class="col-xs-6 text-right">
			<button id="BtnSave" class="btn btn-primary btn-sm BtnSaveModal" type="button" title="Click to save all changes."><span class="fa fa-floppy-o"></span> Save All Changes</button>
			<button id="BtnUndo" class="btn btn-default btn-sm BtnUndoModal" type="button" title="Click to clear all changes."><span class="glyphicon glyphicon-repeat"></span> Undo All Changes</button>
		</div>
	</div>
		<!-- START - FMS Table Wrapper -->
		<div class="fms_table_wrapper">
			<table id="DataTable" class="tablesorter tablesorter-fms tablesorterdf6319efcolumnselector" role="grid" aria-describedby="DataTable_pager_info">
				<thead>
					<tr role="row" class="tablesorter-headerRow">
						<th class="{sorter: false} tablesorter-header sorter-false" data-column="4" data-columnselector="disable" aria-disabled="true">Effective Date</th>
						<th class="{sorter: false} tablesorter-header sorter-false" data-column="4" data-columnselector="disable" aria-disabled="true">Term Date</th>
						<th class="{sorter: false} tablesorter-header sorter-false" data-column="4" data-columnselector="disable" aria-disabled="true">Term Reason</th>
						<th class="{sorter: false} tablesorter-header sorter-false" data-column="4" data-columnselector="disable" aria-disabled="true">OE Start</th>
						<th class="{sorter: false} tablesorter-header sorter-false" data-column="4" data-columnselector="disable" aria-disabled="true">OE End</th>
						<th class="{sorter: false} tablesorter-header sorter-false" data-column="4" data-columnselector="disable" aria-disabled="true">Record Status</th>
						
						<th data-columnselector="disable" class="{sorter: false} tablesorter-header sorter-false tablesorter-headerUnSorted" data-column="6" scope="col" role="columnheader" aria-disabled="true" unselectable="on" aria-sort="none" style="-webkit-user-select: none;"><div class="tablesorter-header-inner">Actions</th>
					</tr>
				</thead>
				<tfoot></tfoot>
			
				<tbody aria-live="polite" aria-relevant="all">
					<g:each in="${groupMasterInstance.contracts}" status="i" var="contract">
						<input type="hidden" name="seq_contract_id_${i}" value="${contract?.seqGroupContract}">
						<input type="hidden" name="contract.${i}.iterationCount" value="${i}">
					
						<tr id="Row2" role="row" class="tablesorter-hasChildRow" style="">
							
							<td><g:formatDate format="yyyy-MM-dd" date="${contract?.effectiveDate}" /></td>
							<td><g:formatDate format="yyyy-MM-dd" date="${contract?.termDate}" /></td>
							<td>${contract?.termReason}</td>
							<td><g:formatDate format="yyyy-MM-dd" date="${contract?.openEnrollStart}" /></td>
							<td><g:formatDate format="yyyy-MM-dd" date="${contract?.openEnrollEnd}" /></td>
							<td>${contract?.recordStatus}</td>
							<td>
								<button class="btn fms_btn_icon btn-sm BtnEditRow" type="button" title="Click to edit or view this row."><span class="glyphicon glyphicon-pencil"></span></button>
                        		<button class="btn fms_btn_icon btn-sm BtnCollapseRow hidden" type="button" title="Click to collapse this row."><span class="glyphicon glyphicon-collapse-up"></span></button>
							</td>
						</tr>

						<tr id="Row2Child" class="tablesorter-childRow" role="row">
							<td colspan="7" id="contract.${groupDBId }.${contract?.seqGroupContract}.toggleFields" class="" style="display:none;">
								
								<!-- START - WIDGET: General Information -->
								<div class="fms_widget">
									<fieldset>
										<legend>
											<h3>General Information</h3>
										</legend>
										<div class="fms_form_layout_2column">
											<div class="fms_form_column fms_long_labels">
											 <label id="effectiveDate" class="control-label fms_required">
													 <g:message	code="groupMaster.effectiveDate.label" default="Effective Date:" />
												</label>
												<div class="fms_form_input">
													<g:securejqDatePickerUIUX tableName="GROUP_CONTRACT" attributeName="effectiveDate"
																dateElementId="contract.${i}.effectiveDate" 
																dateElementName="contract.${i}.effectiveDate"
																datePickerOptions="changeMonth: true, changeYear: true, yearRange: '${((contract?.effectiveDate != null ? contract?.effectiveDate.get(Calendar.YEAR):Calendar.getInstance().get(Calendar.YEAR)) - 100)}:${((contract?.effectiveDate != null ? contract?.effectiveDate.get(Calendar.YEAR):Calendar.getInstance().get(Calendar.YEAR)) + 100)}', numberOfMonths: 1"
																dateElementValue="${formatDate(format:'MM/dd/yyyy',date: contract?.effectiveDate)}"
																ariaAttributes="aria-labelledby='effectiveDate_label' aria-describedby='dateOfDeath_error' aria-required='false'"
																classAttributes ="class='form-control fms_date_mask fms_small_input onDelete hasDatepicker' "
																showIconDefault="${isShowCalendarIcon}"/>	 
															<div class="fms_form_error" id="effectiveDate_r2_error"></div>
												</div>
												
												<label id="termDate" class="control-label"> 
													<g:message code="groupMaster.termDate.label" default="Term Date:" />
												</label>
												<div class="fms_form_input">
													<g:securejqDatePickerUIUX tableName="GROUP_CONTRACT" attributeName="termDate"
																dateElementId="contract.${i}.termDate" 
																dateElementName="contract.${i}.termDate"
																datePickerOptions="changeMonth: true, changeYear: true, yearRange: '${((contract?.termDate != null ? contract?.termDate.get(Calendar.YEAR):Calendar.getInstance().get(Calendar.YEAR)) - 100)}:${((contract?.termDate != null ? contract?.termDate.get(Calendar.YEAR):Calendar.getInstance().get(Calendar.YEAR)) + 100)}', numberOfMonths: 1"
																dateElementValue="${formatDate(format:'MM/dd/yyyy',date: contract?.termDate)}"
																ariaAttributes="aria-labelledby='termDate_label' aria-describedby='termDate_error' aria-required='false'"
																classAttributes ="class='form-control fms_date_mask fms_small_input onDelete hasDatepicker' "
																showIconDefault="${isShowCalendarIcon}"/>	 
														<div class="fms_form_error" id="termDate_r2_error"></div>
												</div>
												
												<label id="openEnrollStart" class="control-label"> 
													<g:message code="groupMaster.openEnrollStart.label" default="Open Enroll Start:" />
												</label>
												<div class="fms_form_input">
													<g:securejqDatePickerUIUX tableName="GROUP_CONTRACT" attributeName="openEnrollStart"
																dateElementId="contract.${i}.openEnrollStart" 
																dateElementName="contract.${i}.openEnrollStart"
																datePickerOptions="changeMonth:true, changeYear:true, yearRange:'${((contract?.openEnrollStart != null ? contract?.openEnrollStart.get(Calendar.YEAR):Calendar.getInstance().get(Calendar.YEAR)) - 100)}:${((contract?.openEnrollStart != null ? contract?.openEnrollStart.get(Calendar.YEAR):Calendar.getInstance().get(Calendar.YEAR)) + 100)}', numberOfMonths: 1"
																dateElementValue="${formatDate(format:'MM/dd/yyyy',date: contract?.openEnrollStart)}"
																ariaAttributes="aria-labelledby='TermDate_r2_label' aria-describedby='TermDate_r2_error' aria-required='false'" 
																classAttributes ="class='form-control fms_date_mask fms_small_input onDelete hasDatepicker' "
																showIconDefault="${isShowCalendarIcon}"/>	
														<div class="fms_form_error" id="openEnrollStart_r2_error"></div>
												</div>
												
												<label id="numberOfEmployees" class="control-label">
													<g:message	code="groupMaster.numberOfEmployees.label" default="No. of Employees:" />
												</label>
												<div class="fms_form_input">
													<g:secureTextField type="number" name="contract.${i}.numberOfEmployees" maxlength="6"
															tableName="GROUP_CONTRACT" attributeName="numberOfEmployees" class="form-control"
															value="${contract?.numberOfEmployees}"></g:secureTextField>
													<div class="fms_form_error" id="numberOfEmployees_r2_error"></div>
												</div>
												
												<label for="contractType" class="control-label"> 
													<g:message code="groupMaster.contractType.label" default="Contract Type: " />
												</label>
												<div class="fms_form_input">
													<g:secureTextField name="contract.${i}.contractType" class="form-control"
																tableName="GROUP_CONTRACT" attributeName="contractType" maxlength="1"
																	value="${contract?.contractType}" onkeypress="return isNumberKey(event)"></g:secureTextField>
													<div class="fms_form_error" id="contractType_r2_error"></div>
												</div>

												<label for="salespersonName" class="control-label"> 
													<g:message	code="groupMaster.salespersonName.label" default="Sales Rep.: " />
												</label>
												<div class="fms_form_input">
													<g:secureTextField name="contract.${i}.salespersonName" class="form-control"
															tableName="GROUP_CONTRACT" attributeName="salespersonName" maxlength="30"
																value="${contract?.salespersonName}" ></g:secureTextField>
													<div class="fms_form_error" id="salespersonName_r2_error"></div>
												</div>
											</div>
											
										<div class="fms_form_column fms_long_labels">

												<label for="termReason" class="control-label"> 
													<g:message code="groupMaster.termReason.label" default="Term Reason:" />
												</label>
												<div class="fms_form_input fms_has_feedback">
													 <input type="hidden" name="TermReasonType" id="TermReasonType" value="TM"/>
													 <g:secureTextField name="contract.${i}.termReason"	tableName="GROUP_CONTRACT" 
													 			attributeName="termReason" class="form-control" maxlength="5"
																value="${contract?.termReason}" ></g:secureTextField>
														<fmsui:cdoLookup lookupElementId="contract.${ i }.termReason"
                                                                           lookupElementName="contract.${i}.termReason" 
                                                                           lookupElementValue="${contract?.termReason}"
                                                                           lookupCDOClassName="com.perotsystems.diamond.dao.cdo.ReasonCodeMaster"
                                                                           lookupCDOClassAttribute="reasonCode"
                                                                           htmlElementsToAddToQuery="TermReasonType"
																 		   htmlElementsToAddToQueryCDOProperty="reasonCodeType" />
															<div class="fms_form_error" id="termReason_r2_error"></div>
												</div>

												<label id="openEnrollEnd" class="control-label"> 
													<g:message code="groupMaster.openEnrollEnd.label" default="Open Enroll End:" />
												</label>
												<div class="fms_form_input">
													<g:securejqDatePickerUIUX tableName="GROUP_CONTRACT" attributeName="openEnrollEnd"
																dateElementId="contract.${i}.openEnrollEnd" 
																dateElementName="contract.${i}.openEnrollEnd"
																datePickerOptions="changeMonth:true, changeYear:true, yearRange:'${((contract?.openEnrollEnd != null ? contract?.openEnrollEnd.get(Calendar.YEAR):Calendar.getInstance().get(Calendar.YEAR)) - 100)}:${((contract?.openEnrollEnd != null ? contract?.openEnrollEnd.get(Calendar.YEAR):Calendar.getInstance().get(Calendar.YEAR)) + 100)}', numberOfMonths: 1"
																dateElementValue="${formatDate(format:'MM/dd/yyyy',date: contract?.openEnrollEnd)}"
																ariaAttributes="aria-labelledby='TermDate_r2_label' aria-describedby='openEnrollEnd_r2_error' aria-required='false'" 
																classAttributes ="class='form-control fms_date_mask fms_small_input onDelete hasDatepicker' "
																showIconDefault="${isShowCalendarIcon}"/>	
														<div class="fms_form_error" id="openEnrollEnd_r2_error"></div>
												</div>

												<label for="waitingPeriod" class="control-label"> 
													<g:message code="groupMaster.waitingPeriod.label" default="Waiting period: " />
												</label>
													<div class="fms_form_input">
														<g:secureTextField name="contract.${i}.waitingPeriod" class="form-control"
																tableName="GROUP_CONTRACT" attributeName="waitingPeriod" value="${contract?.waitingPeriod}" ></g:secureTextField>
															<div class="fms_form_error" id="waitingPeriod_r2_error"></div>
												   </div>
												   
												   
												<label for="recordStatus" class="control-label">
													 <g:message	code="groupMaster.recordStatus.label" default="Record Status: " />
												</label>
													<div class="fms_form_input">
														<g:secureTextField name="contract.${i}.recordStatus" class="form-control"
																tableName="GROUP_CONTRACT" attributeName="recordStatus"	value="${contract?.recordStatus}" ></g:secureTextField>
														<div class="fms_form_error"	id="recordStatus_r2_error"></div>
												   </div>
												   
												<label for="brokerName" class="control-label"> 
													<g:message	code="groupMaster.brokerName.label" default="Broker: " />
												</label>	
													<div class="fms_form_input">
													 <g:secureTextField name="contract.${i}.brokerName"	tableName="GROUP_CONTRACT" 
													 				attributeName="brokerName" class="form-control"	value="${contract?.brokerName}" ></g:secureTextField>
															<div class="fms_form_error" id="brokerName_r2_error"></div>
												   </div> 
											  </div>
											</div>
									</fieldset>
								</div> 
								<%--I widget end --%>
						<div class="fms_widget">
									<fieldset>
										<legend>
											<h2>On Enrolled New Born Processing</h2>
										</legend>
										<div class="fms_form_layout_2column">
											<div class="fms_form_column fms_long_labels">

												<label id="newbornAgeDays" class="control-label"> 
												   <g:message code="groupMaster.newbornAgeDays.label" default="NB Age in Days:" />
												</label>
												<div class="fms_form_input">
													<g:secureTextField name="contract.${i}.newbornAgeDays"  class="form-control amtNumeric"
															tableName="GROUP_CONTRACT" attributeName="newbornAgeDays" maxlength="3"
															value="${contract?.newbornAgeDays}" ></g:secureTextField>
														<div class="fms_form_error" id="newbornAgeDays_r2_error"></div>
												</div>

											<label for="newbornAutoAdd" class="control-label">
												 <g:message	code="groupMaster.newbornAutoAdd.label" default="NewBorn Auto Add:" />
											</label>
												<div class="fms_form_input">
													<g:secureComboBox id="contract.${i}.newbornAutoAdd" name="contract.${i}.newbornAutoAdd" style="width: 250px" 
				                                 				 tableName="GROUP_CONTRACT" attributeName="newbornAutoAdd" class="form-control"
				                                 		 		value="${contract?.newbornAutoAdd}" from="${['' : '-- Select Newborn Auto Add --', 'Y': 'Yes' , 'N': 'No']}" optionValue="value" optionKey="key">
                                      				  </g:secureComboBox>
														<div class="fms_form_error" id="newbornAutoAdd_r2_error"></div>
												</div>
											</div>

											<div class="fms_form_column fms_long_labels">

													<label for="contract.newbornProcRsn" class="control-label">
														<g:message code="groupMaster.newbornProcRsn.label" default="New Born Proc Reason:" />
				                           			</label>
													<div class="fms_form_input fms_has_feedback">
														 <g:secureTextField name="contract.${i}.newbornProcRsn"	tableName="GROUP_CONTRACT" 
														 				attributeName="newbornProcRsn" class="form-control" maxlength="5"
					                           							value="${contract?.newbornProcRsn}"></g:secureTextField>
					                                    <input type="hidden" id="reasonCodeTypeHidden" value="HD" />					                           							
					                           			<fmsui:cdoLookup lookupElementId="contract.${i}.newbornProcRsn"
						                            					lookupElementName="contract.${i}.newbornProcRsn" 
											                            lookupElementValue="${contract?.newbornProcRsn}"
											                            lookupCDOClassName="com.perotsystems.diamond.dao.cdo.ReasonCodeMaster"
											                            lookupCDOClassAttribute="reasonCode"/>				
																<div class="fms_form_error" id="newbornProcRsn_r2_error"></div>
													</div>

													 <label for="contract.newbornOthContRsn" class="control-label"> 
													 	 <g:message code="groupMaster.newbornOthContRsn.label" default="Other Contract Reason:" />
													 </label>
													 <div class="fms_form_input fms_has_feedback">
				                           			      <g:secureTextField name="contract.${i}.newbornOthContRsn" tableName="GROUP_CONTRACT" 
				                           			      					attributeName="newbornOthContRsn" class="form-control" maxlength="5"
												                            value="${contract?.newbornOthContRsn}"></g:secureTextField>	
												            <input type="hidden" id="reasonCodeTypeHidden" value="HD" />												                            
												           <fmsui:cdoLookup lookupElementId="contract.${i}.newbornOthContRsn"
						                            					lookupElementName="contract.${i}.newbornOthContRsn" 
											                            lookupElementValue="${contract?.newbornOthContRsn}"
											                            lookupCDOClassName="com.perotsystems.diamond.dao.cdo.ReasonCodeMaster"
											                            lookupCDOClassAttribute="reasonCode"/>	
														  <div class="fms_form_error" id="newbornOthContRsn_r2_error"></div>
													</div>
												</div>
											</div>
									</fieldset>
								</div> <%--II widget End --%>

								<div class="fms_widget">
									<fieldset>
										<legend>
											<h2>Claim Dependent/Student Age Information</h2>
										</legend>
										<div class="fms_form_layout_2column">
											<div class="fms_form_column fms_long_labels">

												<label for="depConvOption" class="control-label"> 
													<g:message code="premiumMaster.depConvOption.label" default="Depnt Conversion Option:" /></label>
												<div class="fms_form_input">
													<g:secureSystemCodeToken cssClass="form-control" tableName="GROUP_CONTRACT" attributeName="depConvOption" 
															systemCodeType="STDEPCNVOPT" languageId="0"	htmlElelmentId="contract.${ i }.depConvOption"
															blankValue="Depnt Conv Option" 	defaultValue="${contract?.depConvOption}"></g:secureSystemCodeToken>	
														<div class="fms_form_error" id="depConvOption_r2_error"></div>
												</div>

												<label for="stuAgeLimitAction"  class="control-label"> 
													<g:message code="premiumMaster.stuAgeLimitAction.label" default="Stdnt Age Limit Action:" /></label>
												<div class="fms_form_input">
													<g:secureDiamondDataWindowDetail columnName="stu_age_limit_action" cssClass="form-control"
																	tableName="GROUP_CONTRACT" attributeName="stuAgeLimitAction" dwName="dw_grupd_de" languageId="0"
																	htmlElelmentId="contract.${ i }.stuAgeLimitAction"	defaultValue="${contract?.stuAgeLimitAction}"
																	blankValue="Stdnt Age Limit Action" value="${contract?.stuAgeLimitAction}"></g:secureDiamondDataWindowDetail>
														<div class="fms_form_error" id="stuAgeLimitAction_r2_error"></div>
												</div>

												<label for="stuConvAction"  class="control-label"> 
													<g:message	code="premiumMaster.stuConvAction.label" default="Stdnt Conversion Action:" /></label>
												<div class="fms_form_input">
														<g:secureSystemCodeToken tableName="GROUP_CONTRACT" attributeName="stuConvAction" cssClass="form-control"
																systemCodeType="STDEPCNVACT" languageId="0"	htmlElelmentId="contract.${ i }.stuConvAction"
																blankValue="Stdnt Conv Action" 	defaultValue="${contract?.stuConvAction}"></g:secureSystemCodeToken>
														<div class="fms_form_error" id="stuConvAction_r2_error"></div>
												</div>
											</div>

											<div class="fms_form_column fms_long_labels">

													<label for="depConvAction" class="control-label"> 
														 <g:message code="premiumMaster.depConvAction.label" default="Depnt Conversion Action:" /></label>
													<div class="fms_form_input">
														<g:secureSystemCodeToken tableName="GROUP_CONTRACT" attributeName="depConvAction" cssClass="form-control"
																	systemCodeType="STDEPCNVACT" languageId="0" htmlElelmentId="contract.${ i }.depConvAction"
																	blankValue="Depnt Conv Action" 	defaultValue="${contract?.depConvAction}"></g:secureSystemCodeToken>
															<div class="fms_form_error" id="depConvAction_r2_error"></div>
													</div>

													<label for="stuConvOption" class="control-label"> 
														<g:message code="premiumMaster.stuConvOption.label" default="Stdnt Conversion Option:" /></label>
													<div class="fms_form_input">
														<g:secureSystemCodeToken cssClass="form-control" tableName="GROUP_CONTRACT" attributeName="stuConvOption" 
																	systemCodeType="STDEPCNVOPT" languageId="0"	htmlElelmentId="contract.${ i }.stuConvOption"
																	blankValue="Stdnt Conv Option" 	defaultValue="${contract?.stuConvOption}"></g:secureSystemCodeToken>
															<div class="fms_form_error" id="stuConvOption_r2_error"></div>
													</div>
												</div>
											</div>
									</fieldset>
								</div>
								 <%--III widget end  --%>

								<div class="fms_widget">
									<fieldset>
										<legend>
											<h2>User Defined Fields</h2>
										</legend>
										<div class="fms_form_layout_2column">
											<div class="fms_form_column fms_long_labels">

												<label id="userDefined1" class="control-label"> 
													<g:userDefinedFieldLabel winId="GRUPC" datawindowId ="dw_group_contract_de" userDefineTextName="user_defined_1_t" defaultText="User Defined 1"   />
												</label>
												<div class="fms_form_input">
												<g:secureTextField name="contract.${ i }.userDefined1" class="form-control"
															tableName="GROUP_CONTRACT" attributeName="userDefined1"	value="${contract?.userDefined1}" ></g:secureTextField>
														<div class="fms_form_error" id="userDefined1_r2_error"></div>
												</div>

												<label id="userDefined2" class="control-label "> 
													<g:userDefinedFieldLabel winId="GRUPC" datawindowId ="dw_group_contract_de" userDefineTextName="user_defined_2_t" defaultText="User Defined 2"   />
												</label>
												<div class="fms_form_input">
													<g:secureTextField name="contract.${ i }.userDefined2" class="form-control"
															tableName="GROUP_CONTRACT" attributeName="userDefined2"	value="${contract?.userDefined2}" ></g:secureTextField>
														<div class="fms_form_error" id="userDefined2_r2_error"></div>
												</div>

												<label id="userDefined3" class="control-label"> 
													<g:userDefinedFieldLabel winId="GRUPC" datawindowId ="dw_group_contract_de" userDefineTextName="user_defined_3_t" defaultText="User Defined 3"   />
												</label>
												<div class="fms_form_input">
													<g:secureTextField name="contract.${ i }.userDefined3" class="form-control"
																tableName="GROUP_CONTRACT" attributeName="userDefined3"	value="${contract?.userDefined3}" ></g:secureTextField>
														<div class="fms_form_error" id="userDefined3_r2_error"></div>
												</div>

												<label id="userDefined4" class="control-label ">
													<g:userDefinedFieldLabel winId="GRUPC" datawindowId ="dw_group_contract_de" userDefineTextName="user_defined_4_t" defaultText="User Defined 4"   />
												</label>
												<div class="fms_form_input">
												<g:secureTextField name="contract.${ i }.userDefined4" class="form-control"
																tableName="GROUP_CONTRACT" attributeName="userDefined4"	value="${contract?.userDefined4}" ></g:secureTextField>
														<div class="fms_form_error" id="userDefined4_r2_error"></div>
												</div>

												<label id="userDefined5" class="control-label">
													<g:userDefinedFieldLabel winId="GRUPC" datawindowId ="dw_group_contract_de" userDefineTextName="user_defined_5_t" defaultText="User Defined 5"   />
												</label>
												<div class="fms_form_input">
													<g:secureTextField name="contract.${ i }.userDefined5" class="form-control"
																tableName="GROUP_CONTRACT" attributeName="userDefined5"	value="${contract?.userDefined5}" ></g:secureTextField>
														<div class="fms_form_error" id="userDefined5_r2_error"></div>
												</div>

												<label id="userDefined6" class="control-label"> 
													<g:userDefinedFieldLabel winId="GRUPC" datawindowId ="dw_group_contract_de" userDefineTextName="user_defined_6_t" defaultText="User Defined 6"   />
												</label>
												<div class="fms_form_input">
													<g:secureTextField class="form-control" name="contract.${ i }.userDefined6" 
																	tableName="GROUP_CONTRACT" attributeName="userDefined6"	value="${contract?.userDefined6}" ></g:secureTextField>
														<div class="fms_form_error" id="userDefined6_r2_error"></div>
												</div>

												<label id="userDefined7" class="control-label ">
													 <g:userDefinedFieldLabel winId="GRUPC" datawindowId ="dw_group_contract_de" userDefineTextName="user_defined_7_t" defaultText="User Defined 7"   />
												</label>
												<div class="fms_form_input">
													<g:secureTextField name="contract.${ i }.userDefined7" 	class="form-control"
																tableName="GROUP_CONTRACT" attributeName="userDefined7"	value="${contract?.userDefined7}" ></g:secureTextField>
														<div class="fms_form_error" id="userDefined7_r2_error"></div>
												</div>

												<label id="userDefined8" class="control-label"> 
													<g:userDefinedFieldLabel winId="GRUPC" datawindowId ="dw_groupc_user_fields_de" userDefineTextName="user_defined_8_t" defaultText="User Defined 8"   />
												</label>
												<div class="fms_form_input">
												<g:secureTextField name="contract.${ i }.userDefined8"	tableName="GROUP_CONTRACT" 
																attributeName="userDefined8" class="form-control"
																value="${contract?.userDefined8}" ></g:secureTextField>
														<div class="fms_form_error" id="userDefined8_r2_error"></div>
												</div>

												<label id="userDefined10" class="control-label "> 
													<g:userDefinedFieldLabel winId="GRUPC" datawindowId ="dw_groupc_user_fields_de" userDefineTextName="user_defined_10_t" defaultText="User Defined 10"   />
												</label>
												<div class="fms_form_input">
													<g:secureTextField name="contract.${ i }.userDefined10" tableName="GROUP_CONTRACT" 
																attributeName="userDefined10" class="form-control"
																value="${contract?.userDefined10}" ></g:secureTextField>
														<div class="fms_form_error" id="userDefined10_r2_error"></div>
												</div>
											</div>

											<div class="fms_form_column fms_long_labels">
													<label id="userDate1" class="control-label"> 
														<g:userDefinedFieldLabel winId="GRUPC" datawindowId ="dw_group_contract_de" userDefineTextName="user_date_1_t" defaultText="User Date 1"   />
													</label>
													<div class="fms_form_input">
															<g:securejqDatePickerUIUX tableName="GROUP_CONTRACT" attributeName="userDate1"
																dateElementId="contract.${i}.userDate1" 
																dateElementName="contract.${i}.userDate1"
																datePickerOptions="changeMonth:true, changeYear:true, yearRange:'${((contract?.userDate1 != null ? contract?.userDate1.get(Calendar.YEAR):Calendar.getInstance().get(Calendar.YEAR)) - 100)}:${((contract?.userDate1 != null ? contract?.userDate1.get(Calendar.YEAR):Calendar.getInstance().get(Calendar.YEAR)) + 100)}', numberOfMonths: 1"
																dateElementValue="${formatDate(format:'MM/dd/yyyy',date: contract?.userDate1)}"
																ariaAttributes="aria-labelledby='userDate1_r2_label' aria-describedby='userDate1_r2_error' aria-required='false'" 
																classAttributes ="class='form-control fms_date_mask fms_small_input onDelete hasDatepicker' "
																showIconDefault="${isShowCalendarIcon}"/>		
															<div class="fms_form_error" id="userDate1_r2_error"></div>
													</div>

													<label id="userDate2" class="control-label "> 
														<g:userDefinedFieldLabel winId="GRUPC" datawindowId ="dw_group_contract_de" userDefineTextName="user_date_2_t" defaultText="User Date 2"   />
													</label>
													<div class="fms_form_input">
														<g:securejqDatePickerUIUX tableName="GROUP_CONTRACT" attributeName="userDate2"
																dateElementId="contract.${i}.userDate2" 
																dateElementName="contract.${i}.userDate2"
																datePickerOptions="changeMonth:true, changeYear:true, yearRange:'${((contract?.userDate2 != null ? contract?.userDate2.get(Calendar.YEAR):Calendar.getInstance().get(Calendar.YEAR)) - 100)}:${((contract?.userDate2 != null ? contract?.userDate2.get(Calendar.YEAR):Calendar.getInstance().get(Calendar.YEAR)) + 100)}', numberOfMonths: 1"
																dateElementValue="${formatDate(format:'MM/dd/yyyy',date: contract?.userDate2)}"
																ariaAttributes="aria-labelledby='userDate2_r2_label' aria-describedby='userDate2_r2_error' aria-required='false'" 
																classAttributes ="class='form-control fms_date_mask fms_small_input onDelete hasDatepicker' "
																showIconDefault="${isShowCalendarIcon}"/>	
															<div class="fms_form_error" id="userDate2_r2_error"></div>
													</div>

													<label id="userDate3" class="control-label"> 
														<g:userDefinedFieldLabel winId="GRUPC" datawindowId ="dw_group_contract_de" userDefineTextName="user_date_3_t" defaultText="User Date 3"   />
													</label>
													<div class="fms_form_input">
														<g:securejqDatePickerUIUX tableName="GROUP_CONTRACT" attributeName="userDate3"
																dateElementId="contract.${i}.userDate3" 
																dateElementName="contract.${i}.userDate3"
																datePickerOptions="changeMonth:true, changeYear:true, yearRange:'${((contract?.userDate3 != null ? contract?.userDate3.get(Calendar.YEAR):Calendar.getInstance().get(Calendar.YEAR)) - 100)}:${((contract?.userDate3 != null ? contract?.userDate3.get(Calendar.YEAR):Calendar.getInstance().get(Calendar.YEAR)) + 100)}', numberOfMonths: 1"
																dateElementValue="${formatDate(format:'MM/dd/yyyy',date: contract?.userDate3)}"
																ariaAttributes="aria-labelledby='userDate3_r2_label' aria-describedby='userDate3_r2_error' aria-required='false'" 
																classAttributes ="class='form-control fms_date_mask fms_small_input onDelete hasDatepicker' "
																showIconDefault="${isShowCalendarIcon}"/>	
															<div class="fms_form_error" id="userDate3_r2_error"></div>
													</div>

													<label id="userDate4" class="control-label">
														<g:userDefinedFieldLabel winId="GRUPC" datawindowId ="dw_group_contract_de" userDefineTextName="user_date_4_t" defaultText="User Date 4"   />
													</label>
													<div class="fms_form_input">
														<g:securejqDatePickerUIUX tableName="GROUP_CONTRACT" attributeName="userDate4"
																dateElementId="contract.${i}.userDate4" 
																dateElementName="contract.${i}.userDate4"
																datePickerOptions="changeMonth:true, changeYear:true, yearRange:'${((contract?.userDate4 != null ? contract?.userDate4.get(Calendar.YEAR):Calendar.getInstance().get(Calendar.YEAR)) - 100)}:${((contract?.userDate4 != null ? contract?.userDate4.get(Calendar.YEAR):Calendar.getInstance().get(Calendar.YEAR)) + 100)}', numberOfMonths: 1"
																dateElementValue="${formatDate(format:'MM/dd/yyyy',date: contract?.userDate4)}"
																ariaAttributes="aria-labelledby='userDate4_r2_label' aria-describedby='userDate4_r2_error' aria-required='false'" 
																classAttributes ="class='form-control fms_date_mask fms_small_input onDelete hasDatepicker' "
																showIconDefault="${isShowCalendarIcon}"/>	
															<div class="fms_form_error" id="userDate4_r2_error"></div>
													</div>

													<label id="userDate5" class="control-label "> 
													  	<g:userDefinedFieldLabel winId="GRUPC" datawindowId ="dw_group_contract_de" userDefineTextName="user_date_5_t" defaultText="User Date 5"   />
													</label>
													<div class="fms_form_input">
														<g:securejqDatePickerUIUX tableName="GROUP_CONTRACT" attributeName="userDate5"
																dateElementId="contract.${i}.userDate5" 
																dateElementName="contract.${i}.userDate5"
																datePickerOptions="changeMonth:true, changeYear:true, yearRange:'${((contract?.userDate5 != null ? contract?.userDate5.get(Calendar.YEAR):Calendar.getInstance().get(Calendar.YEAR)) - 100)}:${((contract?.userDate5 != null ? contract?.userDate5.get(Calendar.YEAR):Calendar.getInstance().get(Calendar.YEAR)) + 100)}', numberOfMonths: 1"
																dateElementValue="${formatDate(format:'MM/dd/yyyy',date: contract?.userDate5)}"
																ariaAttributes="aria-labelledby='userDate5_r2_label' aria-describedby='userDate5_r2_error' aria-required='false'" 
																classAttributes ="class='form-control fms_date_mask fms_small_input onDelete hasDatepicker' "
																showIconDefault="${isShowCalendarIcon}"/>	
															<div class="fms_form_error" id="userDate5_r2_error"></div>
													</div>

													<label id="userDate6" class="control-label">
														<g:userDefinedFieldLabel winId="GRUPC" datawindowId ="dw_group_contract_de" userDefineTextName="user_date_6_t" defaultText="User Date 6"   />
													</label>
													<div class="fms_form_input">
													  <g:securejqDatePickerUIUX tableName="GROUP_CONTRACT" attributeName="userDate6"
																dateElementId="contract.${i}.userDate6" 
																dateElementName="contract.${i}.userDate6"
																datePickerOptions="changeMonth:true, changeYear:true, yearRange:'${((contract?.userDate6 != null ? contract?.userDate6.get(Calendar.YEAR):Calendar.getInstance().get(Calendar.YEAR)) - 100)}:${((contract?.userDate6 != null ? contract?.userDate6.get(Calendar.YEAR):Calendar.getInstance().get(Calendar.YEAR)) + 100)}', numberOfMonths: 1"
																dateElementValue="${formatDate(format:'MM/dd/yyyy',date: contract?.userDate6)}"
																ariaAttributes="aria-labelledby='userDate6_r2_label' aria-describedby='userDate6_r2_error' aria-required='false'" 
																classAttributes ="class='form-control fms_date_mask fms_small_input onDelete hasDatepicker' "
																showIconDefault="${isShowCalendarIcon}"/>	
															<div class="fms_form_error" id="userDate6_r2_error"></div>
													</div>

													<label id="userDate7" class="control-label"> 
													   <g:userDefinedFieldLabel winId="GRUPC" datawindowId ="dw_group_contract_de" userDefineTextName="user_date_7_t" defaultText="User Date 7"   />
													</label>
													<div class="fms_form_input">
														 <g:securejqDatePickerUIUX tableName="GROUP_CONTRACT" attributeName="userDate7"
																dateElementId="contract.${i}.userDate7" 
																dateElementName="contract.${i}.userDate7"
																datePickerOptions="changeMonth:true, changeYear:true, yearRange:'${((contract?.userDate7 != null ? contract?.userDate7.get(Calendar.YEAR):Calendar.getInstance().get(Calendar.YEAR)) - 100)}:${((contract?.userDate7 != null ? contract?.userDate7.get(Calendar.YEAR):Calendar.getInstance().get(Calendar.YEAR)) + 100)}', numberOfMonths: 1"
																dateElementValue="${formatDate(format:'MM/dd/yyyy',date: contract?.userDate7)}"
																ariaAttributes="aria-labelledby='userDate7_r2_label' aria-describedby='userDate7_r2_error' aria-required='false'" 
																classAttributes ="class='form-control fms_date_mask fms_small_input onDelete hasDatepicker' "
																showIconDefault="${isShowCalendarIcon}"/>		
														<div class="fms_form_error" id="userDate7_r2_error"></div>
													</div>

													<label id="userDefined9" class="control-label "> 
													  <g:userDefinedFieldLabel winId="GRUPC" datawindowId ="dw_groupc_user_fields_de" userDefineTextName="user_defined_9_t" defaultText="User Defined 9"   />
													</label>
													<div class="fms_form_input">
														<g:secureTextField name="contract.${ i }.userDefined9" tableName="GROUP_CONTRACT" attributeName="userDefined9"
																		value="${contract?.userDefined9}" class="form-control"></g:secureTextField>
																<div class="fms_form_error" id="userDefined9_r2_error"></div>
													</div>
												</div>
											</div>
									</fieldset>
								</div>								
								 <%--IV widget End --%>
								
							</td>
						</tr>
					</g:each>
				</tbody>
			</table>
		</div>
	</div>
</div>
			

<!-- END - FMS Content Body -->    
	<div id="addGroupPlaceHolder"></div>
</html>
    