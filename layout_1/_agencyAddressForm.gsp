<%@ page import="com.perotsystems.diamond.dao.cdo.Agency"%>
<meta name="layout" content="main">
<meta name="navSelector" content="maint"/>
<meta name="navChildSelector" content="agency"/>
<g:set var="appContext" bean="grailsApplication"/>
<g:set var="isShowCalendarIcon" value="true"/>
<link rel="stylesheet" href="${resource(dir: 'css', file: 'member_pages.css')}" type="text/css">
<script type="text/javascript" src="${resource(dir: 'js', file: 'jquery.maskedinput.js')}"></script>
<script type="text/javascript" src="${resource(dir: 'js', file: 'commonfunctions.js')}"></script>
<script type="text/javascript" src="${resource(dir: 'js', file: 'jquery.alphanum.js')}"></script>
<script type="text/javascript">


	function addAddress() {		
		window.location.assign('<g:createLinkTo dir="/agency/addAgencyAddress"/>?seqAgencyId=${agencyInstance?.seqAgencyId}');
	}

	function gotoSearch() {
		var appName = "${appContext.metadata['app.name']}";
		window.location.assign("/"+appName+"/agency/list");
	}	
</script>

<script type="text/javascript">

	$(document).ready(function() {
		var serializedForm = $('#editForm').serialize();
		
		// If all rows are deleted show message
        if ($('#DataTable td').length <= 0) {
            $('#BtnSaveModal').attr('disabled', 'disabled');
            $('#BtnUndoModal').attr('disabled', 'disabled');
          $('#DataTable').append('<tr id="EmptyTable"><td colspan="10">There are no records to display</td></tr>');
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
           var formFields = decodeURIComponent(serializedForm).split('&'); //split up the serialized form into variable pairs

		    //put it into an associative array
		    var splitFields = new Array();
		    for(i in formFields){
		        vals= formFields[i].split('=');
		        splitFields[vals[0]] = vals[1];
		    }
		    $('#editForm').find('input[type=hidden]').each(function(){   // reset the value of hidden field. 
		        this.value = splitFields[this.name];           
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


<input type="hidden" name="editType" value="ADDRESS" />
<input type="hidden" name="seqAgencyId" value="${agencyInstance?.seqAgencyId }" />

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
			<div id="addAddressDiv">
				<h2>Address 
					<button 
						type="button" 
						class="btn btn-primary btn-sm" 
						title="Click to add a new address." 
						onClick="addAddress()">
							<i class="fa fa-plus"></i> 
						Add Address
					</button>
				</h2>

			</div>
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
					<button id="BtnSaveModal" class="btn btn-primary btn-sm BtnSaveModal" type="button" title="Click to save all changes."><span class="fa fa-floppy-o"></span> Save All Changes</button>
					<button id="BtnUndoModal" class="btn btn-default btn-sm BtnUndoModal" type="button" title="Click to clear all changes."><span class="glyphicon glyphicon-repeat"></span> Undo All Changes</button>
				</div>
       		</div>
       		
			<!-- START - FMS Table Wrapper -->
           	<div class="fms_table_wrapper">	
				<table id="DataTable" class="tablesorter tablesorter-fms tablesorterdf6319efcolumnselector" role="grid" aria-describedby="DataTable_pager_info">
                 	<thead>
                   		<tr role="row" class="tablesorter-headerRow">
	                      	<th class="{sorter: false} tablesorter-header sorter-false" data-column="0" data-columnselector="disable" aria-disabled="true">Effective Date</th>
							<th class="{sorter: false} tablesorter-header sorter-false" data-column="1" data-columnselector="disable" aria-disabled="true">Term Date</th>
							<th class="{sorter: false} tablesorter-header sorter-false" data-column="2" data-columnselector="disable" aria-disabled="true">Address Type</th>
							<th class="{sorter: false} tablesorter-header sorter-false" data-column="3" data-columnselector="disable" aria-disabled="true">Address Line 1</th>
							<th class="{sorter: false} tablesorter-header sorter-false" data-column="4" data-columnselector="disable" aria-disabled="true">City</th>
							<th class="{sorter: false} tablesorter-header sorter-false" data-column="5" data-columnselector="disable" aria-disabled="true">County</th>
							<th class="{sorter: false} tablesorter-header sorter-false" data-column="6" data-columnselector="disable" aria-disabled="true">State</th>
							<th class="{sorter: false} tablesorter-header sorter-false" data-column="7" data-columnselector="disable" aria-disabled="true">Zip Code</th>
							<th class="{sorter: false} tablesorter-header sorter-false" data-column="8" data-columnselector="disable" aria-disabled="true">Country</th>
							<th class="{sorter: false} tablesorter-header sorter-false" data-column="9" data-columnselector="disable" aria-disabled="true">Action</th>
                   		</tr>
                 	</thead>
                 		
                 	<tfoot></tfoot>
                 		
					<tbody aria-live="polite" aria-relevant="all">

							
							<g:each in="${agencyInstance?.agentAddresses }" var="agencyAddress" status="i">
							<input type="hidden" name="seq_address_id_${i}" value="${agencyAddress?.seqAgentAddress }">
							<input type="hidden" name="agencyAddress.${i}.iterationCount" value="${i}">
							<tr>
									<td><g:formatDate format="yyyy-MM-dd" date="${agencyAddress.effectiveDate}" /></td>
									<td><g:formatDate format="yyyy-MM-dd" date="${agencyAddress.termDate}" /></td>
									<td>${agencyAddress?.addressType}</td>
									<td>${agencyAddress?.addressLine1}</td>
									<td>${agencyAddress?.city}</td>
									<td>${agencyAddress?.county}</td>
									<td>${agencyAddress?.state}</td>
									<td><g:if test="${agencyAddress?.zipCode?.length() > 5}">
										${agencyAddress?.zipCode?.with {length()? getAt(0..4):''}}-${agencyAddress?.zipCode?.with {length()? getAt(5..length()-1):''}}
									</g:if> <g:elseif test="${agencyAddress?.zipCode?.length() == 5}">
										${agencyAddress?.zipCode?.with {length()? getAt(0..4):''}}
									</g:elseif> <g:else></g:else></td>
									<td>${agencyAddress?.country}</td>
									<td>				
										<button class="btn fms_btn_icon btn-sm BtnEditRow" type="button" title="Click to edit or view this row."><span class="glyphicon glyphicon-pencil"></span></button>
                     					<button class="btn fms_btn_icon btn-sm BtnCollapseRow hidden" type="button" title="Click to collapse this row."><span class="glyphicon glyphicon-collapse-up"></span></button>
									</td>
									
								</tr>
							
							
								<tr id="Row2Child" class="tablesorter-childRow" role="row">
												<td colspan="10" style="display:none;">
		
								<!-- START - WIDGET: Address Information -->
								<div class="fms_widget">        
									<fieldset>
										<legend><h3>Address Information</h3></legend>
										<div class="fms_form_layout_2column">                  
											<div class="fms_form_column fms_very_long_labels">
							
									            <label class="control-label fms_required" id="addressLine1_label" for="addressLine1">
									            	<g:message code="agencyAddress.addressLine1.label" default="Address Line 1 :" />
									            </label>
									            <div class="fms_form_input">
									               <g:secureTextField name="agencyAddress.${i}.addressLine1" 
									               					  title="The first Address line" maxlength="60"
									               					  value="${agencyAddress?.addressLine1}" tableName="AGENT_ADDRESS" 
									               					  attributeName="addressLine1"
									               					  class="form-control"
									               					  aria-labelledby="addressLine1_label"
									               					  aria-describedby="addressLine1_error"
									               					  aria-required="false">
									               	</g:secureTextField>
									               <div class="fms_form_error" id="addressLine1_error"></div>
									            </div>  
							
									            <label class="control-label fms_required" id="city_label" for="city">
									            	<g:message code="agencyAddress.city.label" default="City :" />
									            </label>
									            <div class="fms_form_input">
												   <g:secureTextField name="agencyAddress.${i}.city" 
												   					  value="${agencyAddress?.city}" title="The City" maxlength="30"
												   					  tableName="AGENT_ADDRESS" attributeName="city"
												   					  class="form-control"
									               					  aria-labelledby="city_label"
									               					  aria-describedby="city_error"
									               					  aria-required="false">
												   	</g:secureTextField>
									               <div class="fms_form_error" id="city_error"></div>
									            </div>  
							
									            <label class="control-label" id="county_label" for="county">
									            	<g:message code="agencyAddress.county.label" default="County :" />
									            </label>
									            <div class="fms_form_input">
												   <g:secureTextField name="agencyAddress.${i}.county" maxlength="30" 
																	value="${agencyAddress?.county}" tableName="AGENT_ADDRESS" title="The County"
																	attributeName="county" class="form-control" aria-labelledby="county_label"
									               					aria-describedby="county_error" aria-required="false">
												   </g:secureTextField>
									               <div class="fms_form_error" id="county_error"></div>
									            </div>  
							
									            <label class="control-label fms_required" id="zipCode_label" for="zipCode">
									            	<g:message code="agencyAddress.zipCode.label" default="Zip Code :" />
									            </label>
									            <div class="fms_form_input">
									               <g:secureTextField name="agencyAddress.${i}.zipCode"  title="5 or 9 digit Zip Code. Enter numbers only" 
																	value="${agencyAddress?.zipCode}" tableName="AGENT_ADDRESS" placeholder="00000-0000"
																	attributeName="zipCode" class="form-control maskZip" aria-labelledby="zipCode_label"
									               					aria-describedby="zipCode_error" aria-required="false">
									               	</g:secureTextField>
									               <div class="fms_form_error" id="zipCode_error"></div>
									            </div>  
							
									            <label class="control-label fms_required" id="effectiveDate_label" for="effectiveDate">
									            	<g:message code="agencyAddress.effectiveDate.label" default="Effective Date :" />
									            </label>
									            <div class="fms_form_input">
							
													<g:securejqDatePickerUIUX 
															tableName="AGENT_ADDRESS" attributeName="effectiveDate" 
															dateElementId="agencyAddress.${i}.effectiveDate" 
															dateElementName="agencyAddress.${i}.effectiveDate" 
															dateElementValue="${formatDate(format:'MM/dd/yyyy',date: agencyAddress?.effectiveDate)}"
															datePickerOptions="changeMonth:true, changeYear:true, yearRange:'${((agencyAddress?.effectiveDate != null ? agencyAddress?.effectiveDate.get(Calendar.YEAR):Calendar.getInstance().get(Calendar.YEAR)) - 100)}:${((agencyAddress?.effectiveDate != null ? agencyAddress?.effectiveDate.get(Calendar.YEAR):Calendar.getInstance().get(Calendar.YEAR)) + 100)}', numberOfMonths: 1" 
															precision="day" default="none"
															ariaAttributes="aria-labelledby='effectiveDate_label' aria-describedby='effectiveDate_error' aria-required='false'" 
															classAttributes ="class='form-control fms_date_mask fms_small_input onDelete hasDatepicker' "
															showIconDefault="${isShowCalendarIcon}"/>
									               <div class="fms_form_error" id="effectiveDate_error"></div>
									            </div>  
							
									            <label class="control-label" id="termReason_label" for="termReason">
									            	<g:message code="agencyAddress.termReason.label" default="Term Reason :" />
									            </label>
									            <div class="fms_form_input fms_has_feedback">
							
												<input type="hidden" id="reasonCodeTypeHidden" name ="reasonCodeTypeHidden" value="TM" />		            
							                     <g:secureTextField class="form-control" id="agencyAddress.${i}.termReason"
																name="agencyAddress.${i}.termReason" maxlength="50"
																tableName="AGENT_ADDRESS" attributeName="termReason"
																value="${agencyAddress?.termReason}"
																title="The Termination Reason of the Address">
												</g:secureTextField>
							
												<fmsui:cdoLookup lookupElementId="agencyAddress.${i}.termReason"
													   lookupElementName="agencyAddress.${i}.termReason" 
													   lookupElementValue="${agencyAddress?.termReason}"
													   lookupCDOClassName="com.perotsystems.diamond.dao.cdo.ReasonCodeMaster"
													   lookupCDOClassAttribute="reasonCode"
													   htmlElementsToAddToQuery="reasonCodeTypeHidden"
													   htmlElementsToAddToQueryCDOProperty="reasonCodeType"/>
									               <div class="fms_form_error" id="termReason_error"></div>
									            </div>  
											</div>
											<div class="fms_form_column fms_very_long_labels">
							
									            <label class="control-label" id="addressLine2_label" for="addressLine2">
									            	<g:message code="agencyAddress.addressLine2.label" default="Address Line 2 :" />
									            </label>
									            <div class="fms_form_input">
									               <g:secureTextField name="agencyAddress.${i}.addressLine2"
									               					  title="The 2nd Address line" maxlength="60"
									               					  value="${agencyAddress?.addressLine2}" tableName="AGENT_ADDRESS"
									               					  attributeName="addressLine2"
									               					  class="form-control"
									               					  aria-labelledby="addressLine2_label"
									               					  aria-describedby="addressLine2_error"
									               					  aria-required="false">
									               	</g:secureTextField>
									               <div class="fms_form_error" id="addressLine2_error"></div>
									            </div>   											
							
									            <label class="control-label fms_required" id="state_label" for="state">
									            	<g:message code="agencyAddress.state.label" default="State :" />
									            </label>
									            <div class="fms_form_input">
												   <g:secureComboBox class="form-control" name="agencyAddress.${i}.state"  optionKey="stateCode"
														tableName="AGENT_ADDRESS" attributeName="state" 
														optionValue="stateName" id="agencyAddress.${i}.state" from="${states}"
														noSelection="['':'-- Select a State --']"
														value="${agencyAddress?.state}"
														aria-labelledby="state_label" 
													    aria-describedby="state_error" 
													    aria-required="false">
												   </g:secureComboBox>
									               <div class="fms_form_error" id="state_error"></div>
									            </div>   											
							
									            <label class="control-label" id="country_label" for="country">
									            	<g:message code="agencyAddress.country.label" default="Country :" />
									            </label>
									            <div class="fms_form_input">
													<g:secureTextField name="agencyAddress.${i}.country" maxlength="30" 
															value="${agencyAddress?.country}" tableName="AGENT_ADDRESS" title="The Country"
															attributeName="country" class="form-control" aria-labelledby="country_label" 
													    	aria-describedby="country_error" aria-required="false">
													</g:secureTextField>
									               <div class="fms_form_error" id="country_error"></div>
									            </div>   											
							
									            <label class="control-label fms_required" id="addressType_label" for="addressType">
									            	<g:message code="agencyAddress.addressType.label" default="Address Type :" />
									            </label>
									            <div class="fms_form_input">
													<g:secureSystemCodeToken cssClass="form-control" 
																tableName="AGENT_ADDRESS" attributeName="addressType"
																systemCodeType="AGENTAGENCYADDR" languageId="0"
																htmlElelmentId="agencyAddress.${i}.addressType"
																blankValue="Address Type" 
																defaultValue="${agencyAddress?.addressType}" 
																value="${agencyAddress?.addressType}"
																aria-labelledby="addressType_label"
																aria-describedby="addressType_error" aria-required="false">
													</g:secureSystemCodeToken>
									               <div class="fms_form_error" id="addressType_error"></div>
									            </div>   											
							
									            <label class="control-label" id="termDate_label" for="termDate">
									            	<g:message code="agencyAddress.termDate.label" default="Term Date :" />
									            </label>
									            <div class="fms_form_input">
													<g:securejqDatePickerUIUX 
															tableName="AGENT_ADDRESS" attributeName="termDate" 
															dateElementId="agencyAddress.${i}.termDate" 
															dateElementName="agencyAddress.${i}.termDate" 
															dateElementValue="${formatDate(format:'MM/dd/yyyy',date: agencyAddress?.termDate)}"
															datePickerOptions="changeMonth:true, changeYear:true, yearRange:'${((agencyAddress?.termDate != null ? agencyAddress?.termDate.get(Calendar.YEAR):Calendar.getInstance().get(Calendar.YEAR)) - 100)}:${((agencyAddress?.termDate != null ? agencyAddress?.termDate.get(Calendar.YEAR):Calendar.getInstance().get(Calendar.YEAR)) + 100)}', numberOfMonths: 1" 
															precision="day" default="none"
															ariaAttributes="aria-labelledby='effectiveDate_label' aria-describedby='effectiveDate_error' aria-required='false'" 
															classAttributes ="class='form-control fms_date_mask fms_small_input onDelete hasDatepicker' "
															showIconDefault="${isShowCalendarIcon}"/>
															
									               <div class="fms_form_error" id="termDate_error"></div>
									            </div>   											
							
											</div>																
										</div>
									</fieldset>
								</div>
								<!-- END - WIDGET: Address Information -->


								<!-- START - WIDGET: User Defined Information -->
								<div class="fms_widget">        
									<fieldset>
										<legend><h3>User Defined Information</h3></legend>
										<div class="fms_form_layout_2column">                  
											<div class="fms_form_column fms_very_long_labels">
									
							                 <label class="control-label" id="userDefined1_label" for="userDefined1">
							                 	<g:userDefinedFieldLabel winId="AGNCA" datawindowId ="AGNCA" userDefineTextName="user_defined_1_t" defaultText="User Defined 1 "/>
							                 </label>
							                 <div class="fms_form_input">
							                    <g:secureTextField name="agencyAddress.${i}.userDefined1"
																value="${agencyAddress?.userDefined1}"  
																maxlength="60" 
																tableName="AGENT_ADDRESS" 
																attributeName="userDefined1"
																class="form-control"
																aria-labelledby="status_label" 
													            aria-describedby="status_error" 
													            aria-required="false">
												</g:secureTextField>
							                    <div class="fms_form_error" id="userDefined1_error"></div>
							                 </div>   
							
							                 <label class="control-label" id="userDate1_label" for="userDate1">
							                 	<g:userDefinedFieldLabel winId="AGNCA" datawindowId ="AGNCA" userDefineTextName="user_date_1_t" defaultText="User Date 1 "/>
							                 </label>
							                 <div class="fms_form_input">
							                      <g:securejqDatePickerUIUX 
																tableName="AGENT_ADDRESS" attributeName="userDate1" 
																dateElementId="agencyAddress.${i}.userDate1" 
																dateElementName="agencyAddress.${i}.userDate1" 
																dateElementValue="${formatDate(format:'MM/dd/yyyy',date: agencyAddress?.userDate1)}"
																datePickerOptions="changeMonth:true, changeYear:true, yearRange:'${((agencyAddress?.userDate1 != null ? agencyAddress?.userDate1.get(Calendar.YEAR):Calendar.getInstance().get(Calendar.YEAR)) - 100)}:${((agencyAddress?.userDate1 != null ? agencyAddress?.userDate1.get(Calendar.YEAR):Calendar.getInstance().get(Calendar.YEAR)) + 100)}', numberOfMonths: 1"
																precision="day" default="none"
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
							                     <g:secureTextField name="agencyAddress.${i}.userDefined2"
													value="${agencyAddress?.userDefined2}"  maxlength="60" tableName="AGENT_ADDRESS" attributeName="userDefined2"
													class="form-control" aria-labelledby="status_label" aria-describedby="status_error" aria-required="false">
												</g:secureTextField>
							                     <div class="fms_form_error" id="userDefined2_error"></div>
							                  </div> 
							
							                  <label class="control-label" id="userDate2_label" for="userDate2">
							                  	<g:userDefinedFieldLabel winId="AGNCA" datawindowId ="AGNCA" userDefineTextName="user_date_2_t" defaultText="User Date 2 "/>
							                  </label>
							                  <div class="fms_form_input">
							                      <g:securejqDatePickerUIUX 
																tableName="AGENT_ADDRESS" attributeName="userDate2" 
																dateElementId="agencyAddress.${i}.userDate2" 
																dateElementName="agencyAddress.${i}.userDate2" 
																dateElementValue="${formatDate(format:'MM/dd/yyyy',date: agencyAddress?.userDate2)}"
																datePickerOptions="changeMonth:true, changeYear:true, yearRange:'${((agencyAddress?.userDate2 != null ? agencyAddress?.userDate2.get(Calendar.YEAR):Calendar.getInstance().get(Calendar.YEAR)) - 100)}:${((agencyAddress?.userDate2 != null ? agencyAddress?.userDate2.get(Calendar.YEAR):Calendar.getInstance().get(Calendar.YEAR)) + 100)}', numberOfMonths: 1"
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
	
							   </td>
							</tr>
						</g:each>
					</tbody>
				</table>
			</div>
		</div>
	</div>
</div>		    	
</div>