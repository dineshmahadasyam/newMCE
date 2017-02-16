<%@ page import="com.dell.diamond.fms.AgentMasterCommand"%>
<%@ page import="com.dell.diamond.fms.enums.PageNameEnum" %>

<g:set var="appContext" bean="grailsApplication"/>

<g:set var="isShowCalendarIcon" value="${PageNameEnum.AGENCY_EDIT.equals(currentPage)?true:false}" />

<meta name="navSelector" content="maint"/>
<meta name="navChildSelector" content="agency"/>

<script type="text/javascript" src="${resource(dir: 'js', file: 'commonfunctions.js')}"></script>
<script type="text/javascript" src="${resource(dir: 'js', file: 'jquery.alphanum.js')}"></script>
<script type="text/javascript" src="${resource(dir: 'js', file: 'jquery.validate.js')}"></script>

<script type="text/javascript">

	function createBankEft() {		
		window.location.assign('<g:createLinkTo dir="/agency/createBankEft"/>?seqAgencyId=${agencyInstance?.seqAgencyId }&agencyId=${agencyInstance?.agencyId }&agencyType=${agencyInstance?.agencyType}');
	}


	function deleteEFTdetails(seqId)
	{
		
		document.getElementById('seqAgentEFTId').value = seqId
		document.getElementById('BtnInfoAlertId5').click();
	}
	function gotoSearch() {
		var appName = "${appContext.metadata['app.name']}";
		window.location.assign("/"+appName+"/agency/list");
	}
	
</script>
<script type="text/javascript">

	$(document).ready(function() {

		// If all rows are deleted show message
        if ($('#DataTable td').length <= 0) {
            $('#BtnSaveModal').attr('disabled', 'disabled');
            $('#BtnUndo').attr('disabled', 'disabled');
          $('#DataTable').append('<tr id="EmptyTable"><td colspan="4">There are no records to display</td></tr>');
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

        
		
		$('.BtnDeleteRow').hide();  
		
	 	$('.InfoDeleteRow').hide();  
		$('.InfoDeleteRow').click(function(e){ 
	    	$('#InfoDeleteModel').modal('show');
	    });
	 	$('#InfoDeleteModel').modal({
	    	backdrop: 'static',
	       show: false
	   	});
	 	
	 	$('.BtnDeleteRow');
	      $('.BtnDeleteRow').click(function(e){
	          $('#DeleteAlertModal').modal('show');
	      });
	      $('#DeleteAlertModal').modal( {
		      backdrop: 'static',
		       show: false 
		  });
	      $("#BtnDeleteRowYes").click(function(e){	  		         
	               var appName = "${appContext.metadata['app.name']}";
	               var myFm = document.getElementById("editForm") ; 			
	               myFm.action = "/"+appName+"/agency/deleteEFTdetails";     	
	               myFm.submit();
	           
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
                 
         // Save Modal
         $('#BtnSaveModal').click(function(e){
          // e.preventDefault();            
           //this.form.submit(); // JQuery validations will not trigger
           $('#editForm').submit();//resetForm();
         });

         // Undo button
        
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

<input type="hidden" name="editType" value="BANKING" />
<input type="hidden" name="seqAgencyId" value="${agencyInstance?.seqAgencyId }" />
<input type="hidden" name="seqAgentEFTId" id="seqAgentEFTId" value="" />

<!-- START - FMS Content Body -->
	<div id="fms_content_body">
		
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
		<div id="${agencyInstance?.seqAgencyId}">
			<div id="createBankDiv" style="padding-bottom:10px;">
				<h2>Banking  
					<button 
						type="button" 
						class="btn btn-primary btn-sm" 
						title="Click to add a new banking." 
						onClick="createBankEft()">
							<i class="fa fa-plus"></i> 
						Add Banking
					</button>
				</h2>
			</div>
			<div class="fms_required_legend fms_required">= required</div>      
			<!-- START - Data Table Section -->	
			<div id="DataTableSection">
				<div id="SearchResults" class="fms_widget">
           			<!-- START - FMS Widget -->
					<div class="fms_widget">
						<div class="row bottom-margin-sm">
							<div class="col-xs-6">
								<button class="btn btn-sm btn-primary" type="button" onclick='gotoSearch()' title="Click to perform a new search.">New Search</button>
							</div>
							<div class="col-xs-6 text-right">
								<button id="BtnSaveModal" class="btn btn-primary btn-sm BtnSave" type="button" title="Click to save all changes."><span class="fa fa-floppy-o"></span> Save All Changes</button>
								<button id="BtnUndo" class="btn btn-default btn-sm BtnUndoModal" type="button" title="Click to clear all changes."><span class="glyphicon glyphicon-repeat"></span> Undo All Changes</button>
							</div>
						</div>
						<!-- START - FMS Table Wrapper -->
           				<div class="fms_table_wrapper">	
							<table id="DataTable" class="tablesorter tablesorter-fms tablesorterdf6319efcolumnselector" role="grid" aria-describedby="DataTable_pager_info">
		                  		<thead>
		                    		<tr role="row" class="tablesorter-headerRow">
				                      	<th class="{sorter: false} tablesorter-header sorter-false" data-column="0" data-columnselector="disable" aria-disabled="true">Name on Account</th>
										<th class="{sorter: false} tablesorter-header sorter-false" data-column="1" data-columnselector="disable" aria-disabled="true">Bank Name</th>
										<th class="{sorter: false} tablesorter-header sorter-false" data-column="2" data-columnselector="disable" aria-disabled="true">Account Type</th>
		                      			
		                      			<th data-columnselector="disable" class="{sorter: false} tablesorter-header sorter-false tablesorter-headerUnSorted" data-column="3" scope="col" role="columnheader" aria-disabled="true" unselectable="on" aria-sort="none" style="-webkit-user-select: none;"><div class="tablesorter-header-inner">Actions</div></th>
		                    		</tr>
		                  		</thead>
								<tfoot></tfoot>
								<tbody aria-live="polite" aria-relevant="all"> 
				   					<g:each in="${agencyInstance?.agentEFTs}" var="agentEFT" status="i">
				   						<input type="hidden" name="seq_agent_eft_id_${i}" value="${agentEFT?.seqAgentEFTId }">
										<input type="hidden" name="agentEFT.${i}.iterationCount" value="${i}">
										<input type="hidden" name="agentEFT.${i}.seqAgentEFTId" value="${agentEFT?.seqAgentEFTId }">
										<tr id="Row2" role="row" class="tablesorter-hasChildRow" style="">
											<td>${agentEFT?.nameOnAccount}</td>
											<td>${agentEFT?.bankName}</td>
											<td>${agentEFT?.accountType}</td>
											<td>				
												<button class="btn fms_btn_icon btn-sm BtnEditRow" type="button" title="Click to edit or view this row."><span class="glyphicon glyphicon-pencil"></span></button>
	                      						<button class="btn fms_btn_icon btn-sm BtnCollapseRow hidden" type="button" title="Click to collapse this row."><span class="glyphicon glyphicon-collapse-up"></span></button>
	                      						
	                      						<button id="BtnAddressDelete2" type="button" class="btn fms_btn_icon btn-sm"  title="Click to delete Banking." data-target="#DeleteAlertModal" onclick="deleteEFTdetails(${agentEFT?.seqAgentEFTId})"><i class="fa fa-trash"></i></button>
												<button id="BtnInfoAlertId5" type="button" class="btn fms_btn_icon btn-sm BtnDeleteRow" data-target="#InfoAlertModal"></button>
											</td>
										</tr>
										<tr id="Row2Child" class="tablesorter-childRow" role="row">
											<td colspan="4" id="agentEFT.${i}.toggleFields" class="" style="display:none;">
												<!-- START - WIDGET: General Information -->
												<div class="fms_widget">        
													<div class="fms_form_layout_2column">                  
														<div class="fms_form_column fms_long_labels">
															<label id="accountNumber_label" class="control-label fms_required" for="accountNumber"> 
																<g:message code="agentMaster.agentEft.accountNumber.label" default="Bank Account No:" />
															</label>
															<div class="fms_form_input">
																<g:if test="${accountInfoEdit.equals(true)}">									
																	<g:secureTextField class="form-control" name="agentEFT.${i}.accountNumber" value="${agentEFT?.accountNumber}"  title="The Bank Account Number"
																		maxlength="25" tableName="AGENT_EFT" attributeName="accountNumber" id="accountNumber"
																		aria-labelledby="accountNumber_label" aria-describedby="accountNumber_error" aria-required="false">
																	</g:secureTextField>
																</g:if>	
																<g:else>
																	<g:secureTextField class="form-control" name="agentEFT.${i}.accountNumber" value="${agentEFT?.accountNumber}"  title="The Bank Account Number" disabled="${!elementsEnabled?"true":"false"}"
																		maxlength="25" tableName="AGENT_EFT" attributeName="accountNumber" id="accountNumber"
																		aria-labelledby="accountNumber_label" aria-describedby="accountNumber_error" aria-required="false">
																	</g:secureTextField>
																</g:else>
																<div class="fms_form_error" id="accountNumber_error"></div>
															</div>
															<label id="nameOnAccount_label" class="control-label fms_required" for="nameOnAccount">
																<g:message code="agentMaster.agentEft.nameOnAccount.label" default="Name on Account:" />
															</label>
															<div class="fms_form_input">
																<g:secureTextField class="form-control" name="agentEFT.${i}.nameOnAccount" value="${agentEFT?.nameOnAccount}" title="The Name on the Account"
								    								maxlength="60" tableName="AGENT_EFT" attributeName="nameOnAccount" id="nameOnAccount"
								    								aria-labelledby="nameOnAccount_label" aria-describedby="nameOnAccount_error" aria-required="false">
								    							</g:secureTextField>
						    									<div class="fms_form_error" id="nameOnAccount_error"></div>
															</div>
															<label id="bankName_label" class="control-label fms_required" for="bankName"> 
																<g:message code="agentMaster.agentEft.bankName.label" default="Bank Name:" />
															</label>
															<div class="fms_form_input">
															    <g:secureTextField class="form-control" name="agentEFT.${i}.bankName" value="${agentEFT?.bankName}" title="The Bank Name"
								    								maxlength="60" tableName="AGENT_EFT" attributeName="bankName" id="bankName"
								    								aria-labelledby="bankName_label" aria-describedby="bankName_error" aria-required="false">
								    							</g:secureTextField>
															    <div class="fms_form_error" id="bankName_error"></div>	
															</div>
															<label id="routingNumber_label" class="control-label fms_required" for="routingNumber">
																<g:message code="agentMaster.agentEft.routingNumber.label" default="ABA Routing No:" /> 
								 							</label>
								 							<div class="fms_form_input">	
											                    <g:if test="${accountInfoEdit.equals(true)}">
																 	<g:secureTextField class="form-control" id="routingNumber" name="agentEFT.${i}.routingNumber"	title="The ABA Routing Number of the Bank"
																		value="${agentEFT?.routingNumber}"  maxlength="9" tableName="AGENT_EFT" attributeName="routingNumber"
																		aria-labelledby="routingNumber_label" aria-describedby="routingNumber_error" aria-required="false">
																	</g:secureTextField>
																</g:if>
																<g:else>
																 	<g:secureTextField class="form-control" id="routingNumber" name="agentEFT.${i}.routingNumber" title="The ABA Routing Number of the Bank" disabled="${!elementsEnabled?"true":"false"}"
																		value="${agentEFT?.routingNumber}"  maxlength="9" tableName="AGENT_EFT" attributeName="routingNumber"
																		aria-labelledby="routingNumber_label" aria-describedby="routingNumber_error" aria-required="false">
																	</g:secureTextField>
																</g:else>
																<div class="fms_form_error" id="routingNumber_error"></div>	
															</div>
															<label id="description_label" class="control-label" for="description">
																<g:message code="agentMaster.agentEft.description.label" default="Account Description:"  /> 
															</label>
															<div class="fms_form_input">
																<g:secureTextField class="form-control" id="description" name="agentEFT.${i}.description" title="The Bank Account Description"	
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
																<g:secureComboBox class="form-control" id="accountType" name="agentEFT.${i}.accountType" title="The Bank Account Type" 
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
																<g:secureComboBox class="form-control" id="statusFlag" name="agentEFT.${i}.statusFlag" title="The Account Status" 
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
																<g:securejqDatePickerUIUX
																	tableName="AGENT_EFT" attributeName="effectiveDate" 
																	dateElementId="agentEFT.${i}.effectiveDate" 
																	dateElementName="agentEFT.${i}.effectiveDate" mandatory="mandatory"
																	datePickerOptions="changeMonth: true, changeYear: true, yearRange: '${((agentEFT?.effectiveDate != null ? agentEFT?.effectiveDate.get(Calendar.YEAR):Calendar.getInstance().get(Calendar.YEAR)) - 100)} : ${((agentEFT?.effectiveDate != null ? agentEFT?.effectiveDate.get(Calendar.YEAR):Calendar.getInstance().get(Calendar.YEAR)) + 100)}', numberOfMonths: 1"
																	dateElementValue="${formatDate(format:'MM/dd/yyyy',date: agentEFT?.effectiveDate)}" 
																	ariaAttributes="aria-labelledby='effectiveDate_label' aria-describedby='effectiveDate_error' aria-required='false'" 
											                        classAttributes ="class='form-control fms_date_mask fms_small_input onDelete hasDatepicker' "
																	showIconDefault="${isShowCalendarIcon}"/>                                   
											                        <div class="fms_form_error" id="effectiveDate_error"></div>
															</div>
															<label id="termDate_label" class="control-label" for="termDate">	
																<g:message code="agentMaster.agentEFT.termDate.label" default="Term Date: " /> 
															</label>
															<div class="fms_form_input">
																<g:securejqDatePickerUIUX
																	tableName="AGENT_EFT" attributeName="termDate" 
																	dateElementId="agentEFT.${i}.termDate" 
																	dateElementName="agentEFT.${i}.termDate" 
																	datePickerOptions="changeMonth: true, changeYear: true, yearRange: '${((agentEFT?.termDate != null ? agentEFT?.termDate.get(Calendar.YEAR):Calendar.getInstance().get(Calendar.YEAR)) - 100)} : ${((agentEFT?.termDate != null ? agentEFT?.termDate.get(Calendar.YEAR):Calendar.getInstance().get(Calendar.YEAR)) + 100)}', numberOfMonths: 1"
																	dateElementValue="${formatDate(format:'MM/dd/yyyy',date: agentEFT?.termDate)}" 
																	ariaAttributes="aria-labelledby='termDate_label' aria-describedby='termDate_error' aria-required='false'" 
											                        classAttributes ="class='form-control fms_date_mask fms_small_input onDelete hasDatepicker' "
																	showIconDefault="${isShowCalendarIcon}"/>                                   
											                        <div class="fms_form_error" id="termDate_error"></div>
															</div>
															<label id="termReason_label" class="control-label" for="termReason">
																<g:message code="agentEFT.termReason.label" default="Term Reason: " />
															</label>
															<div class="fms_form_input fms_has_feedback">
																<g:secureTextField class="form-control" 
																				maxlength="5" 
																				title="The Bank Account Term Reason"
																				name="agentEFT.${i}.termReason" 
																				tableName="AGENT_EFT" attributeName="termReason" 
																				value="${agentEFT?.termReason}"
																				aria-labelledby="termReason_label" aria-describedby="termReason_error" aria-required="false">
																</g:secureTextField>
																<input type="hidden" id="reasonCodeTypeHidden" value="TM" />
																
																<fmsui:cdoLookup 
																	lookupElementId="agentEFT.${i}.termReason"
																	lookupElementName="agentEFT.${i}.termReason" 
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
											</td>
										</tr>
									</g:each>
								</tbody>
							</table>
						</div>
					</div>
					<!-- END - FMS Widget -->
				</div>
			</div>
			<!-- END - Data Table Section -->	
		</div>
	   
	    <!-- START - Delete Notice Modal -->
			<div class="modal fade" id="DeleteAlertModal" tabindex="-1" role="dialog" aria-labelledby="myModalLabel">        
				<div class="modal-dialog">
					<div class="modal-content fms_modal_error">
						<div class="modal-body">
							<button type="button" class="close" data-dismiss="modal" aria-label="Close"><span aria-hidden="true">&times;</span></button>
							<h4>Are you sure you want to delete this record?</h4>            
						</div>
						<div class="modal-footer">
							<button type="button" class="btn btn-default" data-dismiss="modal">Cancel</button>
							<button id="BtnDeleteRowYes" type="button" class="btn btn-primary" data-dismiss="modal">Yes, Delete</button>
						</div>
					</div>
				</div>
			</div>
		<!-- END - Delete Notice Modal -->
	</div>
<!-- END - FMS Content Body -->
