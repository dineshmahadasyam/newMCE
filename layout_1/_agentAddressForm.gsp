<%@ page import="com.dell.diamond.fms.AgentMasterCommand"%>
<g:set var="appContext" bean="grailsApplication"/>


<script type="text/javascript" src="${resource(dir: 'js', file: 'jquery.maskedinput.js')}"></script>
<script type="text/javascript" src="${resource(dir: 'js', file: 'commonfunctions.js')}"></script>
<script type="text/javascript" src="${resource(dir: 'js', file: 'jquery.alphanum.js')}"></script>
<script type="text/javascript">

	//<![CDATA[ 
	$(window).load(function() {
		
		$('.hideme').find('div').hide();
		
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

	function addAddress() {		
		window.location.assign('<g:createLinkTo dir="/agentMaster/addAgentAddress"/>?seqAgentId=${agentMasterInstance?.seqAgentId }&agentId=${agentMasterInstance?.agentId }&agentType=${agentMasterInstance?.agentType}');
	}

	function gotoSearch() {
		var appName = "${appContext.metadata['app.name']}";
		window.location.assign("/"+appName+"/agentMaster/list");
	}
	
</script>

<script type="text/javascript">

	$(document).ready(function() {

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
           var parentTR = $(this).closest('tr');
           $(parentTR).find('.BtnEditRow, .BtnCollapseRow').toggle();
           $(parentTR).nextUntil('tr:not(.tablesorter-childRow)').find('td').toggle();
         });

      // Save button 
                 
         // Save Modal
         $('#BtnSaveModal').click(function(e){
           $('#editForm').submit();//resetForm();
         });

         // Undo button
        
         $('.BtnUndoModal').click(function(e){
           this.form.reset();
           resetForm();           
         });
         		      
         function resetForm(){
             $('.BtnCollapseRow').hide();
             $('.BtnEditRow').show();
             $('.tablesorter-childRow td').hide();
          
           }
        
	});
</script>

<input type="hidden" name="editType" value="ADDRESS" />
<input type="hidden" name="seqAgentId" value="${agentMasterInstance?.seqAgentId}" />
<input type="hidden" name="agentId" value="${agentMasterInstance?.agentId}" />
<input type="hidden" name="agentType" value="${agentMasterInstance?.agentType}" />

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
		
		<div id="${agentMasterInstance?.seqAgentId}">
			<div id="addAddressDiv" style="padding-bottom:10px;">
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

							
							<g:each in="${agentMasterInstance?.agentAddresses }" var="agentAddress" status="i">
							<input type="hidden" name="seq_address_id_${i}" value="${agentAddress?.seqAgentAddress }">
							<input type="hidden" name="agentAddress.${i}.iterationCount" value="${i}">
							<tr>
									<td><g:formatDate format="yyyy-MM-dd" date="${agentAddress.effectiveDate}" /></td>
									<td><g:formatDate format="yyyy-MM-dd" date="${agentAddress.termDate}" /></td>
									<td>${agentAddress?.addressType}</td>
									<td>${agentAddress?.addressLine1}</td>
									<td>${agentAddress?.city}</td>
									<td>${agentAddress?.county}</td>
									<td>${agentAddress?.state}</td>
									<td><g:if test="${agentAddress?.zipCode?.length() > 5}">
										${agentAddress?.zipCode?.with {length()? getAt(0..4):''}}-${agentAddress?.zipCode?.with {length()? getAt(5..length()-1):''}}
									</g:if> <g:elseif test="${agentAddress?.zipCode?.length() == 5}">
										${agentAddress?.zipCode?.with {length()? getAt(0..4):''}}
									</g:elseif> <g:else></g:else></td>
									<td>${agentAddress?.country}</td>
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
									            	<g:message code="agentAddress.addressLine1.label" default="Address Line 1 :" />
									            </label>
									            <div class="fms_form_input">
									               <g:secureTextField name="agentAddress.${i}.addressLine1" 
									               					  title="The first Address line" maxlength="60"
									               					  value="${agentAddress?.addressLine1}" tableName="AGENT_ADDRESS" 
									               					  attributeName="addressLine1"
									               					  class="form-control"
									               					  aria-labelledby="addressLine1_label"
									               					  aria-describedby="addressLine1_error"
									               					  aria-required="false">
									               	</g:secureTextField>
									               <div class="fms_form_error" id="addressLine1_error"></div>
									            </div>  
							
									            <label class="control-label fms_required" id="city_label" for="city">
									            	<g:message code="agentAddress.city.label" default="City :" />
									            </label>
									            <div class="fms_form_input">
												   <g:secureTextField name="agentAddress.${i}.city" 
												   					  value="${agentAddress?.city}" title="The City" maxlength="30"
												   					  tableName="AGENT_ADDRESS" attributeName="city"
												   					  class="form-control"
									               					  aria-labelledby="city_label"
									               					  aria-describedby="city_error"
									               					  aria-required="false">
												   	</g:secureTextField>
									               <div class="fms_form_error" id="city_error"></div>
									            </div>  
							
									            <label class="control-label" id="county_label" for="county">
									            	<g:message code="agentAddress.county.label" default="County :" />
									            </label>
									            <div class="fms_form_input">
												   <g:secureTextField name="agentAddress.${i}.county" maxlength="30" 
																	value="${agentAddress?.county}" tableName="AGENT_ADDRESS" title="The County"
																	attributeName="county" class="form-control" aria-labelledby="county_label"
									               					aria-describedby="county_error" aria-required="false">
												   </g:secureTextField>
									               <div class="fms_form_error" id="county_error"></div>
									            </div>  
							
									            <label class="control-label fms_required" id="zipCode_label" for="zipCode">
									            	<g:message code="agentAddress.zipCode.label" default="Zip Code :" />
									            </label>
									            <div class="fms_form_input">
									               <g:secureTextField name="agentAddress.${i}.zipCode"  title="5 or 9 digit Zip Code. Enter numbers only" 
																	value="${agentAddress?.zipCode}" tableName="AGENT_ADDRESS" class="maskZip" placeholder="00000-0000"
																	attributeName="zipCode" class="form-control maskZip" aria-labelledby="zipCode_label"
									               					aria-describedby="zipCode_error" aria-required="false">
									               	</g:secureTextField>
									               <div class="fms_form_error" id="zipCode_error"></div>
									            </div>  
							
									            <label class="control-label fms_required" id="effectiveDate_label" for="effectiveDate">
									            	<g:message code="agentAddress.effectiveDate.label" default="Effective Date :" />
									            </label>
									            <div class="fms_form_input">
							
													<g:securejqDatePickerUIUX 
															tableName="AGENT_ADDRESS" attributeName="effectiveDate" 
															dateElementId="agentAddress.${i}.effectiveDate" 
															dateElementName="agentAddress.${i}.effectiveDate" 
															dateElementValue="${formatDate(format:'MM/dd/yyyy',date: agentAddress?.effectiveDate)}"
															datePickerOptions="changeMonth:true, changeYear:true, yearRange:'${((agentAddress?.effectiveDate != null ? agentAddress?.effectiveDate.get(Calendar.YEAR):Calendar.getInstance().get(Calendar.YEAR)) - 100)}:${((agentAddress?.effectiveDate != null ? agentAddress?.effectiveDate.get(Calendar.YEAR):Calendar.getInstance().get(Calendar.YEAR)) + 100)}', numberOfMonths: 1" 
															precision="day" default="none"
															ariaAttributes="aria-labelledby='effectiveDate_label' aria-describedby='effectiveDate_error' aria-required='false'" 
															classAttributes ="class='form-control fms_date_mask fms_small_input onDelete hasDatepicker' "
															showIconDefault="${isShowCalendarIcon}"/>
									               <div class="fms_form_error" id="effectiveDate_error"></div>
									            </div>  
							
									            <label class="control-label" id="termReason_label" for="termReason">
									            	<g:message code="agentAddress.termReason.label" default="Term Reason :" />
									            </label>
									            <div class="fms_form_input fms_has_feedback">
							
												<input type="hidden" id="reasonCodeTypeHidden" name ="reasonCodeTypeHidden" value="TM" />		            
							                     <g:secureTextField class="form-control" id="agentAddress.${i}.termReason"
																name="agentAddress.${i}.termReason" maxlength="50"
																tableName="AGENT_ADDRESS" attributeName="termReason"
																value="${agentAddress?.termReason}"
																title="The ID of the Agency the Agent/broker is affiliated with">
												</g:secureTextField>
							
												<fmsui:cdoLookup lookupElementId="agentAddress.${i}.termReason"
													   lookupElementName="agentAddress.${i}.termReason" 
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
									               <g:secureTextField name="agentAddress.${i}.addressLine2"
									               					  title="The 2nd Address line" maxlength="60"
									               					  value="${agentAddress?.addressLine2}" tableName="AGENT_ADDRESS"
									               					  attributeName="addressLine2"
									               					  class="form-control"
									               					  aria-labelledby="addressLine2_label"
									               					  aria-describedby="addressLine2_error"
									               					  aria-required="false">
									               	</g:secureTextField>
									               <div class="fms_form_error" id="addressLine2_error"></div>
									            </div>   											
							
									            <label class="control-label fms_required" id="state_label" for="state">
									            	<g:message code="agentAddress.state.label" default="State :" />
									            </label>
									            <div class="fms_form_input">
												   <g:secureComboBox class="form-control" name="agentAddress.${i}.state"  optionKey="stateCode"
														tableName="AGENT_ADDRESS" attributeName="state" 
														optionValue="stateName" id="agentAddress.${i}.state" from="${states}"
														noSelection="['':'-- Select the State --']"
														value="${agentAddress?.state}"
														aria-labelledby="state_label" 
													    aria-describedby="state_error" 
													    aria-required="false">
												   </g:secureComboBox>
									               <div class="fms_form_error" id="state_error"></div>
									            </div>   											
							
									            <label class="control-label" id="country_label" for="country_n1">
									            	<g:message code="agentAddress.country.label" default="Country :" />
									            </label>
									            <div class="fms_form_input">
													<g:secureTextField name="agentAddress.${i}.country" maxlength="30" 
															value="${agentAddress?.country}" tableName="AGENT_ADDRESS" title="The Country"
															attributeName="country" class="form-control" aria-labelledby="country_label" 
													    	aria-describedby="country_error" aria-required="false">
													</g:secureTextField>
									               <div class="fms_form_error" id="country_error"></div>
									            </div>   											
							
									            <label class="control-label fms_required" id="addressType_label" for="addressType">
									            	<g:message code="agentAddress.addressType.label" default="Address Type :" />
									            </label>
									            <div class="fms_form_input">
													<g:secureSystemCodeToken cssClass="form-control" 
																tableName="AGENT_ADDRESS" attributeName="addressType"
																systemCodeType="AGENTAGENCYADDR" languageId="0"
																htmlElelmentId="agentAddress.${i}.addressType"
																blankValue="Address Type" 
																defaultValue="${agentAddress?.addressType}" 
																value="${agentAddress?.addressType}"
																aria-labelledby="addressType_label"
																aria-describedby="addressType_error" aria-required="false">
													</g:secureSystemCodeToken>
									               <div class="fms_form_error" id="addressType_error"></div>
									            </div>   											
							
									            <label class="control-label" id="termDate_label" for="termDate">
									            	<g:message code="agentAddress.termDate.label" default="Term Date :" />
									            </label>
									            <div class="fms_form_input">
													<g:securejqDatePickerUIUX 
															tableName="AGENT_ADDRESS" attributeName="termDate" 
															dateElementId="agentAddress.${i}.termDate" 
															dateElementName="agentAddress.${i}.termDate" 
															dateElementValue="${formatDate(format:'MM/dd/yyyy',date: agentAddress?.termDate)}"
															datePickerOptions="changeMonth:true, changeYear:true, yearRange:'${((agentAddress?.termDate != null ? agentAddress?.termDate.get(Calendar.YEAR):Calendar.getInstance().get(Calendar.YEAR)) - 100)}:${((agentAddress?.termDate != null ? agentAddress?.termDate.get(Calendar.YEAR):Calendar.getInstance().get(Calendar.YEAR)) + 100)}', numberOfMonths: 1" 
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
							                 	<g:userDefinedFieldLabel winId="AGNTM" datawindowId ="AGNTM" userDefineTextName="user_defined_1_t" defaultText="User Defined1"/>
							                 </label>
							                 <div class="fms_form_input">
							                    <g:secureTextField name="userDefined1"
																value="${agentMasterInstance?.userDefined1}"  
																maxlength="60" 
																tableName="AGENT_MASTER" 
																attributeName="userDefined1"
																class="form-control"
																aria-labelledby="status_label" 
													            aria-describedby="status_error" 
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
													class="form-control" aria-labelledby="status_label" aria-describedby="status_error" aria-required="false">
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