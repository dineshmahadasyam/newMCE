<%@ page import="com.perotsystems.diamond.bom.PremiumMaster"%>

<meta name="layout" content="main">    
<g:set var="appContext" bean="grailsApplication"/>

<script type="text/javascript" src="${resource(dir: 'js', file: 'jquery.validate.js')}"></script>

<script>

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
           }
         
      // On form change enable the save and reset buttons
        /* $('form :input').on('change input', function(e) {
           $('#BtnSave').removeAttr('disabled');
           $('#BtnUndo').removeAttr('disabled');
         });	*/
         
       //$('#DataTable').removeClass( "hidden" );
	});

var addRowClicked = false
function cloneRow() {
	var divObjSrc = document.getElementById('newMemberEligibility')
	var divObjDest = document.getElementById('addGroupPlaceHolder')
	divObjDest.innerHTML = divObjSrc.innerHTML
	var divObj = document.getElementById('addRateDiv')
	divObj.style.display = "none"
	var selectObj = document.getElementById("memberIdSelectList")
	selectObj.disabled = true;
	var divObjSrc = document.getElementById('releaseSelect')
	divObjSrc.style.display = "block"
	addRowClicked = true
}
var previousDivObj
function releaseMemberSelection() {

	var result = confirm(
			"Navigating to a new Member would result in the loss of data of the newly added member, Please confirm ",
			"Yes - Change Member ", "No - Stay on this page")
	if (result) {
		addRowClicked = false;
		var selectObj = document.getElementById("memberIdSelectList")
		selectObj.disabled = false;
		var divObjSrc = document.getElementById('releaseSelect')
		divObjSrc.style.display = "none"
		var divObjDest = document.getElementById('addGroupPlaceHolder')
		divObjDest.innerHTML = "&nbsp;"
		var divObj = document.getElementById('addRateDiv')
		divObj.style.display = "block"
		var resetButton = document.getElementById("resetButton")
		resetButton.click()
	}
}
function showRate(selectedObj) {
	var hiddenObj = document.getElementById("editMemberDBID")
	if (!addRowClicked) {
		
		var selectedValue = selectedObj.options[selectedObj.selectedIndex].value
		var rateDivObj = document.getElementById(selectedValue)
		var addRateDivObj = document.getElementById("addRateDiv")
		hiddenObj.value = selectedValue
		if (rateDivObj != null) {
			if (previousDivObj != null) {
				previousDivObj.style.display = "none"
			}
			rateDivObj.style.display = "block"
			addRateDivObj.style.display = "block"
			previousDivObj = rateDivObj
		} else {
			addRateDivObj.style.display = "block"
		}
	} else {
		var result = confirm(
				"Navigating to a new Member would result in the loss of data of the newly added member, Please confirm ",
				"Yes - Change Member ", "No - Stay on this page")
		if (result) {
			addRowClicked = false;
			showRate(selectedObj)
		} else {

		}
	}
}

function addGroupRate(){

	var selectObj = document.getElementById("memberIdSelectList")
	var seqPremId = selectObj.options[selectObj.selectedIndex].value
	var seqGroupId = document.getElementById("seqGroupId").value
	
	var groupId = "${groupMasterInstance?.groupId}";
	var groupDBId = "${groupMasterInstance?.groupDBId}";
	var appName = "${appContext.metadata['app.name']}";

	window.location.assign("/"+appName+"/groupMaintenance/addGroupCommRate?groupId="
		+ groupId + '&seqPremId='+seqPremId+'&seqGroupId='+seqGroupId + "&grouEditType=COMMRATES&groupDBId="+groupDBId);
}

function gotoSearch() {
	var appName = "${appContext.metadata['app.name']}";
	window.location.assign("/"+appName+"/groupMaintenance/list");
}
</script>	

<g:hiddenField name="groupDBId" value="${groupMasterInstance?.groupDBId}" />
<g:hiddenField name="groupId" value="${groupMasterInstance?.groupId}" />
<input type="hidden" name="editType" value="COMMRATES" />
<input type="hidden" name="seqGroupId" id ="seqGroupId" value="" />
<input type="hidden" id="editMemberDBID" name="editMemberDBID" value="0" />
<input type="hidden" id="seqPremId" name="seqPremId" value="" />
<input type="hidden" id="isFirst" value="true">

	<!-- START - FMS Content Body -->
	<div id="fms_content_body">
		<div class="right-corner" align="right">COMMG</div>
		
		<!-- Error messages start-->
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
		<!-- Error messages end-->

		<!-- START - Data Table Section -->	
		<div id="DataTableSection">	
			<!-- START plan/rider select section -->
			<div class="fms_widget form-inline">
				<label class="control-label" id="GroupRate_label" for="memberIdSelectList">Select a Plan/Rider</label>
				<select id="memberIdSelectList" name="memberIdlist"
					onChange="showRate(this)"
					size="1" class="form-control fms_form_input fms-select-multi" 
					aria-labelledby="GroupRate_label" aria-required="false">
		
						<g:each in="${premiumMasterMap?.keySet() }" status="idCount" var="seqPremId">
						
							<% PremiumMaster premMaster = premiumMasterMap.get(seqPremId) %>
							<% seqGroupId =  premMaster.getSeqGroupId()%>
							 
							 <option value="${seqPremId }" ${"0".equals(""+ idCount)?'selected':'' }>
								<g:if test="${"0".equals(""+ idCount) }">
									<script type="text/javascript">
										document.getElementById("seqPremId").value = ${ premMaster.seqPremId};   
										document.getElementById("seqGroupId").value = ${ premMaster.seqGroupId};
									</script>
								</g:if>
								<g:if test="${premMaster.seqPremId }">
									${'P'.equals(premMaster.recordType) ? 'Plan' : 'Rider'}
								</g:if>
								-
								<g:if test="${premMaster.seqPremId }">
									${premMaster.planRiderCode }
								</g:if>
								-
								<g:if test="${premMaster.seqPremId }">
									${premMaster.lineOfBusiness}
								</g:if>
							</option>
						</g:each>
				</select>	
			</div>	
			<!-- END plan/rider select section -->
	
			<div id="addRateDiv" style="display:block">
				<h2>Group Rates  
					<button 
						type="button" 
						class="btn btn-primary btn-sm" 
						title="Click to add a new rate" 
						onClick="addGroupRate()">
							<i class="fa fa-plus"></i> 
						New Group Rate
					</button>
				</h2>
			</div>
		
			<div id="SearchResults" class="fms_widget">
	            	
	            <!-- START - FMS Widget -->
				<div class="fms_widget">
				
					<div class="row bottom-margin-sm">
						<div class="col-xs-6">
							<button class="btn btn-sm btn-primary" type="button" onclick='gotoSearch()' 
								title="Click to perform a new search.">New Search</button>
						</div>
						<div class="col-xs-6 text-right">
							<button id="BtnSave" class="btn btn-primary btn-sm BtnSaveModal" type="button" title="Click to save all changes."><span class="fa fa-floppy-o"></span> Save All Changes</button>
							<button id="BtnUndo" class="btn btn-default btn-sm BtnUndoModal" type="button" title="Click to clear all changes."><span class="glyphicon glyphicon-repeat"></span> Undo All Changes</button>
						</div>					
					</div>
					
					<%-- START - FMS Table Wrapper --%>					
		           	<div class="fms_table_wrapper">	
		           		
		           	<%-- Start Plan/Rider loop --%>	
					<g:each in="${agencyGrpCommRatesMap.keySet() }" status="idCount" var="seqPremId">
					
						<div id="${seqPremId}" style="display: none">
						<table id="DataTable" class="tablesorter tablesorter-fms tablesorterdf6319efcolumnselector" role="grid" 
							aria-describedby="DataTable_pager_info">
	                  		<thead>
	                    		<tr role="row" class="tablesorter-headerRow">
			                      	<th class="{sorter: false} tablesorter-header sorter-false" data-column="0" data-columnselector="disable" 
			                      		aria-disabled="true">Effective Date</th>
									<th class="{sorter: false} tablesorter-header sorter-false" data-column="1" data-columnselector="disable" 
										aria-disabled="true">Term Date</th>
									<th class="{sorter: false} tablesorter-header sorter-false" data-column="2" data-columnselector="disable" 
										aria-disabled="true">Rate Schedule</th>
									<th class="{sorter: false} tablesorter-header sorter-false" data-column="3" data-columnselector="disable" 
										aria-disabled="true">Calc Type</th>
									<th class="{sorter: false} tablesorter-header sorter-false" data-column="4" data-columnselector="disable" 
										aria-disabled="true">Amount Type</th>
									<th class="{sorter: false} tablesorter-header sorter-false" data-column="5" data-columnselector="disable" 
										aria-disabled="true">Override Amount</th>
									
	                      			<th data-columnselector="disable" class="{sorter: false} tablesorter-header sorter-false tablesorter-headerUnSorted" 
	                      				data-column="6" scope="col" role="columnheader" aria-disabled="true" unselectable="on" aria-sort="none" 
	                      				style="-webkit-user-select: none;"><div class="tablesorter-header-inner">Actions</div></th>
	                    		</tr>
	                  		</thead>
	                  	
							<tfoot></tfoot>
							<tbody aria-live="polite" aria-relevant="all"> 
									
								<%-- Start rates loop --%>
						   		<g:each in="${agencyGrpCommRatesMap.get(seqPremId)}" status="i" var="agencyGrpCommsRate">  
						   		
									<input type="hidden" name="seq_prem_id_${i}"
										value="${agencyGrpCommsRate.seqGrpCommsnId }">
				
									<input type="hidden"
										name="agencyGrpCommsRate.${i}.iterationCount"
										value="${i}">
									
									<input type="hidden"
										name="agencyGrpCommsRate.${i}.seqPremId"
										value="${agencyGrpCommsRate.seqPremId }">
										
									<input type="hidden"
										name="agencyGrpCommsRate.${i}.seqGrpCommsnId"
										value="${agencyGrpCommsRate.seqGrpCommsnId }">
							
									<tr id="Row2" role="row" class="tablesorter-hasChildRow" style="">
																											
										<td><g:formatDate format="yyyy-MM-dd" date="${agencyGrpCommsRate?.effectiveDate}" /></td>
										<td><g:formatDate format="yyyy-MM-dd" date="${agencyGrpCommsRate?.termDate}" /></td>										 
										<td>${rateIdsMap?.get(agencyGrpCommsRate?.seqRateId).rateId}</td>
										<td>${agencyGrpCommsRate?.calcType}</td>
										<td>${agencyGrpCommsRate?.overrideAmtType}</td>
										<td>${agencyGrpCommsRate?.overrideAmt}</td>										
										
										<td>				
											<button class="btn fms_btn_icon btn-sm BtnEditRow" type="button" 
												title="Click to edit or view this row."><span class="glyphicon glyphicon-pencil"></span></button>
                      						<button class="btn fms_btn_icon btn-sm BtnCollapseRow hidden" type="button" 
                      							title="Click to collapse this row."><span class="glyphicon glyphicon-collapse-up"></span></button>
										</td>
									</tr>
									
									<tr id="Row2Child" class="tablesorter-childRow" role="row">
										<td colspan="7" id="agencyGrpCommsRate.${i}.toggleFields" class="" style="display:none;">
											<%-- START - WIDGET: General Information --%>
											<div id="widgetGeneral" class="fms_widget">        
												<fieldset>
													<legend><h3>General Information</h3></legend>
													<div class="fms_form_layout_2column">                  
														<div class="fms_form_column fms_very_long_labels">
																														
															<label id="effectiveDate_label" class="control-label" for="effectiveDate"> 
																<g:message code="groupMaster.effectiveDate.label" default="Effective Date:" />
															</label>
															<div class="fms_form_input">																																														
																<g:securejqDatePickerUIUX 
																	disabled="true"
																	tableName="AGENCY_GROUP_COMMS_RATES" attributeName="effectiveDate"
																	dateElementId="agencyGrpCommsRate.${ i }.effectiveDate" 
																	dateElementName="agencyGrpCommsRate.${ i }.effectiveDate" 
																	datePickerOptions="changeMonth:true, changeYear:true, yearRange: 'c-100:c+100', maxDate:'+10y'"
																	dateElementValue="${formatDate(format:'MM/dd/yyyy',date: agencyGrpCommsRate?.effectiveDate)}"
																	ariaAttributes="aria-labelledby='effectiveDate_label' aria-describedby='effectiveDate_error' aria-required='false'" 
																	classAttributes ="class='form-control fms_date_mask fms_small_input onDelete hasDatepicker' "
																	showIconDefault="false"/> 
																<div class="fms_form_error" id="effectiveDate_error"></div>						
															</div>
															
															<label id="overrideAmt_label" class="control-label" for="overrideAmtType"> 
																<g:message code="agencyGroupCommsRate.overrideAmtType.label" default="Amount Type:" />
															</label>
															<div class="fms_form_input">
																<g:secureComboBox 
																	name="agencyGroupCommsRate.${i}.overrideAmtType" 
																	class="form-control fms_width_auto"
																	tableName="AGENCY_GROUP_COMMS_RATES" attributeName="overrideAmtType" 
																	value="${agencyGrpCommsRate?.overrideAmtType}"																	         
																	from="${['' : '', 'A': 'A - Amount' , 'P': 'P - Percent']}" 
																	optionValue="value" optionKey="key" class="form-control" 																	
																	disabled="disabled">
																</g:secureComboBox>	
																<input type="hidden" name="agencyGrpCommsRate.${i}.overrideAmtType" 
																	value="${agencyGrpCommsRate?.overrideAmtType }"></input>
																<div class="fms_form_error" id="overrideAmt_error"></div>						
															</div>
															
															<label id="seqRateId_label" class="control-label" for="seqRateId"> 
																<g:message code="agencyGroupCommsRate.seqRateId.label" default="Rate ID:" />
															</label>
															<div class="fms_form_input">
																<g:secureTextField maxlength="15" readonly="${agencyGrpCommsRate.seqGrpCommsnId? "readonly":""}" 
																	name="agencyGrpCommsRate.${i}.seqRateId" 
																	tableName="AGENCY_GROUP_COMMS_RATES" attributeName="seqRateId" class="form-control" 
																	value="${rateIdsMap?.get(agencyGrpCommsRate?.seqRateId).rateId}" ></g:secureTextField>
																<div class="fms_form_error" id="seqRateId_error"></div>	
															</div>
														</div>	
														<div class="fms_form_column fms_very_long_labels">	
														
															<label id="termDate_label" class="control-label" for="termDate"> 
																<g:message code="groupMaster.termDate.label" default="Term Date:" />
															</label>
															<div class="fms_form_input">
																<g:securejqDatePickerUIUX 
																	tableName="AGENCY_GROUP_COMMS_RATES" attributeName="termDate"
																	dateElementId="agencyGrpCommsRate.${i}.termDate" 
																	dateElementName="agencyGrpCommsRate.${i}.termDate" 
																	datePickerOptions="changeMonth:true, changeYear:true, yearRange: 'c-100:c+100'"
																	dateElementValue="${formatDate(format:'MM/dd/yyyy',date: agencyGrpCommsRate?.termDate)}"
																	ariaAttributes="aria-labelledby='termDate_label' aria-describedby='termDate_error' aria-required='false'" 
																	classAttributes ="class='form-control fms_date_mask fms_small_input onDelete hasDatepicker' "
																	showIconDefault="true"/>
																<input type="hidden" name="agencyGrpCommsRate.${i}.termDate" value="${agencyGrpCommsRate?.termDate}"></input>	 
																<div class="fms_form_error" id="termDate_error"></div>						
															</div>
															
															<label id="overrideAmt" class="control-label" for="overrideAmt"> 
																<g:message code="agencyGroupCommsRate.overrideAmt.label" default="Override Amt:" />
															</label>																
															<div class="fms_form_input fms_feedback_input">
																<g:if test="${agencyGrpCommsRate?.seqGrpCommsnId}">
																	<g:if test="${(agencyGrpCommsRate?.overrideAmtType?.equalsIgnoreCase("A"))}">
																		<g:textField name="currSymbol" id="currSymbol" value="\$"  maxlength="1" 
																			readonly="readonly" class="fms_currSymbol" style="border: 0 !important;"/>
																		<g:textField name="agencyGrpCommsRate.${i}.overrideAmt" 
																			value="${agencyGrpCommsRate?.overrideAmt}" class="form-control" 
																			maxlength="30" title="The Override Amount" disabled="disabled"/>
																	</g:if>
																	<g:elseif test="${(agencyGrpCommsRate?.overrideAmtType?.equalsIgnoreCase("P"))}">
																		<g:textField name="currSymbol" id="currSymbol" value="%"  maxlength="1" 
																			readonly="readonly" class="fms_currSymbol" style="border: 0 !important;"/>
																		<g:textField name="agencyGrpCommsRate.${i}.overrideAmt" 
																			value="${agencyGrpCommsRate?.overrideAmt}" class="form-control" 
																			maxlength="30" title="The Override Amount" disabled="disabled"/>
																	</g:elseif>
																	<g:if test="${(agencyGrpCommsRate?.overrideAmtType == null) 
																		|| (agencyGrpCommsRate?.overrideAmtType.trim().length() == 0)}">
																		<g:textField name="agencyGrpCommsRate.${i}.overrideAmt" 
																			value="${agencyGrpCommsRate?.overrideAmt}" class="form-control" 
																			maxlength="30" title="The Override Amount" disabled="disabled"/>
																	</g:if>
																</g:if>
																<g:else>
																	<g:textField name="agencyGrpCommsRate.${i}.overrideAmt" 
																			value="${agencyGrpCommsRate?.overrideAmt}" class="form-control" 
																			maxlength="30" title="The Override Amount"/>
																</g:else>
																<div class="fms_form_error" id="overrideAmt_error"></div>
															</div>
															
															<label id="calcType_label" class="control-label" for="calcType"> 
																<g:message code="agencyGroupCommsRate.calcType.label" default="Calc Type:" />
															</label>
															<div class="fms_form_input">
																
																<g:secureComboBox 
																class="form-control" 
																name="${i}.calcType" 
																disabled="disabled" 
																tableName="AGENCY_GROUP_COMMS_RATES" 
																attributeName="calcType" value="${agencyGrpCommsRate?.calcType}" disabled="disabled"
																from="${['' : '', 'I': 'I - Incentive' , 'C': 'C - Commission']}" 
																optionValue="value" 
																optionKey="key"
																aria-labelledby="calcType_label" 
																aria-describedby="calcType_error" 
																aria-required="false">
																</g:secureComboBox>
																<div class="fms_form_error" id="calcType_error"></div>						
															</div>															
															
														</div>														
													</div>																										
												</fieldset>
											</div>											
											<%-- END - WIDGET: General Information  --%>
										</td>
									</tr>
							 	</g:each>  
							 	<!-- End inner loop -->		 	
							</tbody>
						</table>
					</div>
					</g:each>
					<%-- End outer loop --%>
					</div>
				</div>
			</div>
		</div>
	<div id="addGroupPlaceHolder"></div>
</div>

<script>
	var memberSelectObject = document.getElementById('memberIdSelectList')
	showRate(memberSelectObject)
</script>