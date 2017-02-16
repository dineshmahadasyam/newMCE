<%@ page import="com.dell.diamond.fms.enums.PageNameEnum" %>
<%@ page import="com.perotsystems.diamond.bom.GroupEx" %>
<%@ page import="com.perotsystems.diamond.bom.Group" %>
<%@ page import="com.perotsystems.diamond.bom.Address" %>
<%@ page import="com.perotsystems.diamond.bom.GroupAddress" %>
    
<g:set var="appContext" bean="grailsApplication"/>

<g:set var="isShowCalendarIcon" value="${PageNameEnum.GROUP_EDIT.equals(currentPage)?true:false}" />

<script type="text/javascript" src="${resource(dir: 'js', file: 'jquery.validate.js')}"></script>

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
	
	
	});//]]>  	
</script>
	
<script>
	function cloneRow()
	{
	
		var divObjSrc = document.getElementById('newGroupAddress')
		var divObjDest = document.getElementById('addGroupPlaceHolder')
		divObjDest.innerHTML = divObjSrc.innerHTML
		var divObj = document.getElementById('addAddressDiv')
		divObj.style.display = "none"	
	}
	
	function addGroupAddress() {
		var groupId = "${groupMasterInstance?.groupId}";
		var groupDBId = "${groupMasterInstance?.groupDBId}";
		var appName = "${appContext.metadata['app.name']}";
		
		window.location.assign("/"+appName+"/groupMaintenance/addAddress?groupId="
				+ groupId + "&grouEditType=ADDRESS&groupDBId="+groupDBId);
	}
	$(function($){
	   $(".maskZip").mask("?99999-9999");
	})
	
	function gotoSearch() {
		var appName = "${appContext.metadata['app.name']}";
		window.location.assign("/"+appName+"/groupMaintenance/list");
	}
</script>

<script type="text/javascript">

	$(document).ready(function() {

		// If all rows are deleted show message
        if ($('#DataTable td').length <= 0) {
            $('#BtnSave').attr('disabled', 'disabled');
            $('#BtnUndo').attr('disabled', 'disabled');
          $('#DataTable').append('<tr id="EmptyTable"><td colspan="13">There are no records to display</td></tr>');
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

<g:hiddenField name="groupId" value="${groupMasterInstance?.groupId}" />
<g:hiddenField name="groupDBId" value="${groupMasterInstance?.groupDBId}" />

	<!-- START - FMS Content Body -->
	<div id="fms_content_body">
		<div class="right-corner" align="right">GRUPA</div>
		
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
		
		<div id="addAddressDiv" style="display:block">
			<h2>Addresses  
				<button 
					type="button" 
					class="btn btn-primary btn-sm" 
					title="Click to add a new address." 
					onClick="addGroupAddress()">
						<i class="fa fa-plus"></i> 
					New Address
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
							<button id="BtnSave" class="btn btn-primary btn-sm BtnSaveModal" type="button" title="Click to save all changes."><span class="fa fa-floppy-o"></span> Save All Changes</button>
							<button id="BtnUndo" class="btn btn-default btn-sm BtnUndoModal" type="button" title="Click to clear all changes."><span class="glyphicon glyphicon-repeat"></span> Undo All Changes</button>
						</div>
					</div>
					
					<!-- START - FMS Table Wrapper -->
		           	<div class="fms_table_wrapper">	
						<table id="DataTable" class="tablesorter tablesorter-fms tablesorterdf6319efcolumnselector" role="grid" aria-describedby="DataTable_pager_info">
	                  		<thead>
	                    		<tr role="row" class="tablesorter-headerRow">
			                      	<th class="{sorter: false} tablesorter-header sorter-false" data-column="0" data-columnselector="disable" aria-disabled="true">Effective Date</th>
									<th class="{sorter: false} tablesorter-header sorter-false" data-column="1" data-columnselector="disable" aria-disabled="true">Term Date</th>
									<th class="{sorter: false} tablesorter-header sorter-false" data-column="2" data-columnselector="disable" aria-disabled="true">Term Reason</th>
									<th class="{sorter: false} tablesorter-header sorter-false" data-column="3" data-columnselector="disable" aria-disabled="true">Address Type</th>
									<th class="{sorter: false} tablesorter-header sorter-false" data-column="4" data-columnselector="disable" aria-disabled="true">Primary</th>
									<th class="{sorter: false} tablesorter-header sorter-false" data-column="5" data-columnselector="disable" aria-disabled="true">Billing</th>
									<th class="{sorter: false} tablesorter-header sorter-false" data-column="6" data-columnselector="disable" aria-disabled="true">Inactive</th>
									<th class="{sorter: false} tablesorter-header sorter-false" data-column="7" data-columnselector="disable" aria-disabled="true">User Defined 1</th>
									<th class="{sorter: false} tablesorter-header sorter-false" data-column="8" data-columnselector="disable" aria-disabled="true">User Defined 2</th>
									<th class="{sorter: false} tablesorter-header sorter-false" data-column="9" data-columnselector="disable" aria-disabled="true">User Defined 3</th>
									<th class="{sorter: false} tablesorter-header sorter-false" data-column="10" data-columnselector="disable" aria-disabled="true">User Defined 4</th>
									<th class="{sorter: false} tablesorter-header sorter-false" data-column="11" data-columnselector="disable" aria-disabled="true">User Defined 5</th>			
	                      			
	                      			<th data-columnselector="disable" class="{sorter: false} tablesorter-header sorter-false tablesorter-headerUnSorted" data-column="6" scope="col" role="columnheader" aria-disabled="true" unselectable="on" aria-sort="none" style="-webkit-user-select: none;"><div class="tablesorter-header-inner">Actions</div></th>
	                    		</tr>
	                  		</thead>
	                  	
							<tfoot></tfoot>
							<tbody aria-live="polite" aria-relevant="all"> 
						   		<g:each in="${groupMasterInstance.addresses}" status="i" var="address">  
									<input type="hidden" name="seq_address_id_${i}" value="${address.groupAddressDBId }">
									<input type="hidden" name="address.${i}.iterationCount" value="${i}">
							
									<tr id="Row2" role="row" class="tablesorter-hasChildRow" style="">
											
										<td><g:formatDate format="yyyy-MM-dd" date="${address.effectiveDate}" /></td>
										<td><g:formatDate format="yyyy-MM-dd" date="${address.termDate}" /></td>
										<td>${address.termReason}</td>
										<td>${address.addressType}</td>
										<td><input type="checkbox" name="isPrimary" ${ address.isPrimaryAddress ? 'checked'	: ''}></td>
										<td><input type="checkbox" name="isPrimary" ${ address.isBillingAddress ? 'checked' : ''}></td>
										<td><input type="checkbox" name="isPrimary" ${ address.isInactive ? 'checked' : ''}></td>
										<td>${address.userDefined1}</td>
										<td>${address.userDefined2}</td>
										<td>${address.userDefined3}</td>
										<td>${address.userDefined4}</td>
										<td>${address.userDefined5}</td>
										<td>				
											<button class="btn fms_btn_icon btn-sm BtnEditRow" type="button" title="Click to edit or view this row."><span class="glyphicon glyphicon-pencil"></span></button>
                      						<button class="btn fms_btn_icon btn-sm BtnCollapseRow hidden" type="button" title="Click to collapse this row."><span class="glyphicon glyphicon-collapse-up"></span></button>
										</td>
									</tr>
									
									<tr id="Row2Child" class="tablesorter-childRow" role="row">
										<td colspan="13" id="address.${i}.toggleFields" class="" style="display:none;">
											<!-- START - WIDGET: General Information -->
											<div class="fms_widget">        
												<fieldset>
													<legend><h3>General Information</h3></legend>
													<div class="fms_form_layout_2column">                  
														<div class="fms_form_column fms_very_long_labels">
														
															<label id="addressType_label" class="control-label fms_required" for="addressType"> 
																<g:message code="groupMaster.addressType.label" default="Address Type:" />
															</label>
															<div class="fms_form_input">
																<g:secureSystemCodeToken
																	cssClass="form-control"
																	tableName="GROUP_ADDRESS" attributeName="addressType"
																	systemCodeType="ADDRESSTYPE" languageId="0"
																	htmlElelmentId="address.${i}.addressType"
																	blankValue="Address Type" 
																	defaultValue="${address?.addressType}" 
																	value="${address?.addressType}" >
																</g:secureSystemCodeToken>
																<div class="fms_form_error" id="addressType_error"></div>	
															</div>
															
															<label id="effectiveDate_label" class="control-label fms_required" for="effectiveDate"> 
																<g:message code="groupMaster.effectiveDate.label" default="Effective Date:" />
															</label>
															<div class="fms_form_input">
																<g:securejqDatePickerUIUX 
																	tableName="GROUP_ADDRESS" attributeName="effectiveDate"
																	dateElementId="address.${ i }.effectiveDate" 
																	dateElementName="address.${ i }.effectiveDate" 
																	datePickerOptions="changeMonth:true, changeYear:true, yearRange:'${((address?.effectiveDate != null ? address?.effectiveDate.get(Calendar.YEAR):Calendar.getInstance().get(Calendar.YEAR)) - 100)}:${((address?.effectiveDate != null ? address?.effectiveDate.get(Calendar.YEAR):Calendar.getInstance().get(Calendar.YEAR)) + 100)}', numberOfMonths: 1"
																	dateElementValue="${formatDate(format:'MM/dd/yyyy',date: address?.effectiveDate)}"
																	ariaAttributes="aria-labelledby='effectiveDate_label' aria-describedby='effectiveDate_error' aria-required='false'" 
																	classAttributes ="class='form-control fms_date_mask fms_small_input onDelete hasDatepicker' "
																	showIconDefault="${isShowCalendarIcon}"/> 
																<div class="fms_form_error" id="effectiveDate_error"></div>						
															</div>
														</div>	
														
														<div class="fms_form_column fms_very_long_labels">
															<label id="termReason_label" class="control-label" for="termReason"> 
																<g:message code="groupMaster.termReason.label" default="Term Reason:" />
															</label>
															<div class="fms_form_input fms_has_feedback">
																<input type="hidden" name="TermReasonType" id="TermReasonType" value="TM"/>													
															
																<g:secureTextField maxlength="5" class="form-control"
																	name="address.${i}.termReason" 
																	tableName="GROUP_ADDRESS" attributeName="termReason" 
																	value="${address?.termReason}">
																</g:secureTextField>
																
																<fmsui:cdoLookup 
																	lookupElementId="address.${ i }.termReason"
																	lookupElementName="address.${ i }.termReason" 
																	lookupElementValue="${address?.termReason}"
																	lookupCDOClassName="com.perotsystems.diamond.dao.cdo.ReasonCodeMaster"
																	lookupCDOClassAttribute="reasonCode" 
																	htmlElementsToAddToQuery="TermReasonType"
																	htmlElementsToAddToQueryCDOProperty="reasonCodeType" />
																<div class="fms_form_error" id="termReason_error"></div>	
															</div>
															
															<label id="termDate_label" class="control-label" for="termDate"> 
																<g:message code="groupMaster.termDate.label" default="Term Date:" />
															</label>	
															<div class="fms_form_input">
																<g:securejqDatePickerUIUX 
																	tableName="GROUP_ADDRESS" attributeName="termDate" 
																	dateElementId="address.${ i }.termDate" 
																	dateElementName="address.${ i }.termDate" 
																	default="none"
																	datePickerOptions="changeMonth:true, changeYear:true, yearRange:'${((address?.termDate != null ? address?.termDate.get(Calendar.YEAR):Calendar.getInstance().get(Calendar.YEAR)) - 100)}:${((address?.termDate != null ? address?.termDate.get(Calendar.YEAR):Calendar.getInstance().get(Calendar.YEAR)) + 100)}', numberOfMonths: 1"
																	dateElementValue="${formatDate(format:'MM/dd/yyyy',date: address?.termDate)}"
																	ariaAttributes="aria-labelledby='termDate_label' aria-describedby='termDate_error' aria-required='false'" 
																	classAttributes ="class='form-control fms_date_mask fms_small_input onDelete hasDatepicker' "
																	showIconDefault="${isShowCalendarIcon}"/> 
														 		<div class="fms_form_error" id="termDate_error"></div>						
															</div>
														</div>
													</div>
													
													<hr  class="fms_hr_dark" />
													
													<div class="fms_form_layout_2column">                  
														<div class="fms_form_column fms_very_long_labels">	
																			
															<label id="isPrimaryAddress_label" class="control-label" for="isPrimaryAddress"> 
																<g:message code="groupMaster.isPrimaryAddress.label" default="Primary Address:" />
															</label>
															<div class="fms_form_input">
																<g:secureComboBox 
																	name="address.${i}.isPrimaryAddress" 
																	class="form-control fms_width_auto"
																	tableName="GROUP_ADDRESS" attributeName="primAddress" 
																	value="${address?.isPrimaryAddress}"
																	from="${['' : '', 'true': 'Yes' , 'false': 'No']}" 
																	optionValue="value" optionKey="key">
																</g:secureComboBox>	
																<div class="fms_form_error" id="isPrimaryAddress_error"></div>						
															</div>
															
															<label id="isBillingAddress_label" class="control-label" for="isBillingAddress"> 
																<g:message code="groupMaster.isBillingAddress.label" default="Billing Address:" />
															</label>			
															<div class="fms_form_input">	
																<g:secureComboBox 
																	class="form-control fms_width_auto"
																	name="address.${i}.isBillingAddress" 
																	tableName="GROUP_ADDRESS" attributeName="billAddress" 
																	value="${address?.isBillingAddress}"
																	from="${['' : '', 'true': 'Yes' , 'false': 'No']}" 
																	optionValue="value" optionKey="key"></g:secureComboBox>										
																<div class="fms_form_error" id="isBillingAddress_error"></div>
															</div>
															
															<label id="isInactive_label" class="control-label" for="isInactive"> 
																<g:message code="groupMaster.isInactive.label" default="Inactive:" />
															</label>											
															<div class="fms_form_input">
																<g:secureComboBox 
																	class="form-control fms_width_auto"
																	name="address.${i}.isInactive"
																	tableName="GROUP_ADDRESS" attributeName="inactive" 
																	value="${address?.isInactive}"
																	from="${['' : '', 'true': 'Yes' , 'false': 'No']}" 
																	optionValue="value" optionKey="key">
																</g:secureComboBox>											
																<div class="fms_form_error" id="isInactive_error"></div>		
															</div>
															
															<label id="address1_label" class="control-label fms_required" for="address1"> 
																<g:message code="groupMaster.address1.label" default="Address1:" />
															</label>											
															<div class="fms_form_input">
																<g:secureTextField 
																	class="form-control"
																	maxlength="60"
																	name="address.${i}.address1"
																	tableName="GROUP_ADDRESS" attributeName="addressLine1" 
																	value="${address?.address1}">
																</g:secureTextField> 
																<div class="fms_form_error" id="address1_error"></div>
															</div>
															
															<label id="address2_label" class="control-label" for="address2"> 
																<g:message code="groupMaster.address2.label" default="Address2:" />
															</label>
															<div class="fms_form_input">
																<g:secureTextField 
																	class="form-control"
																	maxlength="60"
																	name="address.${i}.address2"
																	tableName="GROUP_ADDRESS" attributeName="addressLine2" 
																	value="${address?.address2}">
																</g:secureTextField>
																<div class="fms_form_error" id="address2_error"></div>
															</div>
														</div>
														
														<div class="fms_form_column fms_very_long_labels">
															
															<label id="city_label" class="control-label fms_required" for="city"> 
																<g:message code="groupMaster.city.label" default="City:" />
															</label>
															<div class="fms_form_input">
																<g:secureTextField 
																	maxlength="30"
																	name="address.${i}.city"
																	tableName="GROUP_ADDRESS" attributeName="city" 
																	value="${address?.city}" 
																	class="form-control fms-alphanumeric">
																</g:secureTextField>
																<div class="fms_form_error" id="city_error"></div>
															</div>
															
															<label id="groupState_label" class="control-label fms_required" for="groupState">
																<g:message code="groupMaster.groupState.label" default="State:" />
															</label>
															<div class="fms_form_input">
														        <g:secureComboBox
														        	class="form-control"
																	name="address.${i}.state" 
																	optionKey="stateCode"
																	tableName="GROUP_ADDRESS" attributeName="state" 
																	optionValue="stateName" 
																	id="state.name" 
																	from="${states}"
																	noSelection="['':'-- Select a State --']"
																	value="${address?.state}">
																</g:secureComboBox>
																<div class="fms_form_error" id="groupState_error"></div>
															</div>
															
															<label id="zipCode_label" class="control-label fms_required" for="zipCode"> 
																<g:message code="groupMaster.zipCode.label" default="Zip Code:" />
															</label>
															<div class="fms_form_input">
														     	<g:secureTextField 
														     		maxlength="10"
																	name="address.${i}.zip"
																	tableName="GROUP_ADDRESS" 
																	attributeName="zipCode" class="maskZip form-control"
																	value="${address?.zip}"> 
																</g:secureTextField>
																<div class="fms_form_error" id="zipCode_error"></div>
															</div>
															
															<label id="county_label" class="control-label" for="country"> 
																<g:message code="groupMaster.country.label" default="Country:" />
															</label>										
															<div class="fms_form_input">
																<g:secureTextField 
																	class="form-control" 
																	maxlength="30"
																	name="address.${i}.country"
																	tableName="GROUP_ADDRESS" attributeName="country" 
																	value="${address?.country}">
																</g:secureTextField>
																<div class="fms_form_error" id="county_error"></div>
															</div>
															
															<label id="county_label" class="control-label" for="county"> 
																<g:message code="groupMaster.county.label" default="County:" />
															</label>
															<div class="fms_form_input">
																<g:secureTextField
																	class="form-control" 
																	maxlength="30"
																	name="address.${i}.county"
																	tableName="GROUP_ADDRESS" attributeName="county" 
																	value="${address?.county}">
																</g:secureTextField>
																<div class="fms_form_error" id="county_error"></div>
															</div>	
															
														</div>
													</div>
												</fieldset>
											</div>
													
											<div class="fms_widget">        
												<fieldset>
													<legend><h3>user Defined Fields</h3></legend>
													<div class="fms_form_layout_2column">                  
														<div class="fms_form_column fms_very_long_labels">
										
															<label id="userDef1_label" class="control-label" for="userDef1"> 
																<g:userDefinedFieldLabel winId="GRUPA" datawindowId ="dw_grupa_de" userDefineTextName="USER_DEF_1_t" defaultText="User Defined 1" />
															</label>										
															<div class="fms_form_input">
																<g:secureTextField 
																	class="form-control"
																	maxlength="30"
																	name="address.${i}.userDefined1" 
																	tableName="GROUP_ADDRESS" 
																	attributeName="userDef1" 
																	value="${address?.userDefined1}">
																</g:secureTextField>
																<div class="fms_form_error" id="userDef1_error"></div>
															</div>
																					
															<label id="userDef2_label" class="control-label" for="userDef2"> 
																<g:userDefinedFieldLabel winId="GRUPA" datawindowId ="dw_grupa_de" userDefineTextName="USER_DEF_2_t" defaultText="User Defined 2"   />
															</label>											
															<div class="fms_form_input">
																<g:secureTextField 
																	class="form-control"
																	maxlength="30"
																	name="address.${i}.userDefined2"
																	tableName="GROUP_ADDRESS" attributeName="userDef2" 
																	value="${address?.userDefined2}">
																</g:secureTextField>
																<div class="fms_form_error" id="userDef2_error"></div>
															</div>						
																					
															<label id="userDef3_label" class="control-label" for="userDef3"> 
																<g:userDefinedFieldLabel winId="GRUPA" datawindowId ="dw_grupa_de" userDefineTextName="USER_DEF_3_t" defaultText="User Defined 3"   />
															</label>
															<div class="fms_form_input">
																<g:secureTextField 
																	class="form-control"
																	maxlength="30"
																	name="address.${i}.userDefined3"
																	tableName="GROUP_ADDRESS" attributeName="userDef3" 
																	value="${address?.userDefined3}">
																</g:secureTextField>
																<div class="fms_form_error" id="userDate3_error"></div>
															</div>		
																	
															<label id="userDef4_label" class="control-label" for="userDef4"> 
																<g:userDefinedFieldLabel winId="GRUPA" datawindowId ="dw_grupa_de" userDefineTextName="USER_DEF_4_t" defaultText="User Defined 4"   />
															</label>											
															<div class="fms_form_input">
																<g:secureTextField 
																	class="form-control"
																	maxlength="30"
																	name="address.${i}.userDefined4"
																	tableName="GROUP_ADDRESS" attributeName="userDef4" 
																	value="${address?.userDefined4}">
																</g:secureTextField>
																<div class="fms_form_error" id="userDef4_error"></div>
															</div>		
															
															<label id="userDef5_label" class="control-label" for="userDef5"> 
																<g:userDefinedFieldLabel winId="GRUPA" datawindowId ="dw_grupa_de" userDefineTextName="USER_DEF_5_t" defaultText="User Defined 5"   />
															</label>
															<div class="fms_form_input">
																<g:secureTextField 
																	class="form-control"
																	maxlength="30"
																	name="address.${i}.userDefined5"
																	tableName="GROUP_ADDRESS" attributeName="userDef5" 
																	value="${address?.userDefined5}">
																</g:secureTextField>
																<div class="fms_form_error" id="userDef5_error"></div>
															</div>		
														</div>

														<div class="fms_form_column fms_very_long_labels">			
															<label id="userDate1_label" class="control-label" for="userDate1"> 
																<g:userDefinedFieldLabel winId="GRUPA" datawindowId ="dw_grupa_de" userDefineTextName="user_date_1_t" defaultText="User Date 1" />
															</label>
															<div class="fms_form_input">
																<g:securejqDatePickerUIUX 
																	tableName="GROUP_ADDRESS" attributeName="userDate1" 
																	dateElementId="address.${ i }.userDate1" 
																	dateElementName="address.${ i }.userDate1" 
																	datePickerOptions="changeMonth:true, changeYear:true, yearRange:'${((address?.userDate1 != null ? address?.userDate1.get(Calendar.YEAR):Calendar.getInstance().get(Calendar.YEAR)) - 100)}:${((address?.userDate1 != null ? address?.userDate1.get(Calendar.YEAR):Calendar.getInstance().get(Calendar.YEAR)) + 100)}', numberOfMonths: 1"
																	dateElementValue="${formatDate(format:'MM/dd/yyyy',date: address?.userDate1)}"
																	ariaAttributes="aria-labelledby='userDate1_label' aria-describedby='userDate1_error' aria-required='false'" 
																	classAttributes ="class='form-control fms_date_mask fms_small_input onDelete hasDatepicker' "
																	showIconDefault="${isShowCalendarIcon}"/> 
																<div class="fms_form_error" id="userDate1_error"></div>
															</div>						
																					
															<label id="userDate2_label" class="control-label" for="userDate2"> 
																<g:userDefinedFieldLabel winId="GRUPA" datawindowId ="dw_grupa_de" userDefineTextName="user_date_2_t" defaultText="User Date 2"   />										
															</label>										
															<div class="fms_form_input">
																<g:securejqDatePickerUIUX 
																	tableName="GROUP_ADDRESS" attributeName="userDate2" 
																	dateElementId="address.${ i }.userDate2" 
																	dateElementName="address.${ i }.userDate2" 
																	datePickerOptions="changeMonth:true, changeYear:true, yearRange:'${((address?.userDate2 != null ? address?.userDate2.get(Calendar.YEAR):Calendar.getInstance().get(Calendar.YEAR)) - 100)}:${((address?.userDate2 != null ? address?.userDate2.get(Calendar.YEAR):Calendar.getInstance().get(Calendar.YEAR)) + 100)}', numberOfMonths: 1"
																	dateElementValue="${formatDate(format:'MM/dd/yyyy',date: address?.userDate2)}"
																	ariaAttributes="aria-labelledby='userDate2_label' aria-describedby='userDate2_error' aria-required='false'" 
																	classAttributes ="class='form-control fms_date_mask fms_small_input onDelete hasDatepicker' "
																	showIconDefault="${isShowCalendarIcon}"/> 
																<div class="fms_form_error" id="userDate2_error"></div>
															</div>						
																	
															<label id="userDate3_label" class="control-label" for="userDate3"> 
																<g:userDefinedFieldLabel winId="GRUPA" datawindowId ="dw_grupa_de" userDefineTextName="user_date_3_t" defaultText="User Date 3"   />
															</label>
															<div class="fms_form_input">
																<g:securejqDatePickerUIUX 
																	tableName="GROUP_ADDRESS" attributeName="userDate3" 
																	dateElementId="address.${ i }.userDate3" 
																	dateElementName="address.${ i }.userDate3" 
																	datePickerOptions="changeMonth:true, changeYear:true, yearRange:'${((address?.userDate3 != null ? address?.userDate3.get(Calendar.YEAR):Calendar.getInstance().get(Calendar.YEAR)) - 100)}:${((address?.userDate3 != null ? address?.userDate3.get(Calendar.YEAR):Calendar.getInstance().get(Calendar.YEAR)) + 100)}', numberOfMonths: 1" 
																	dateElementValue="${formatDate(format:'MM/dd/yyyy',date: address?.userDate3)}"
																	ariaAttributes="aria-labelledby='userDate3_label' aria-describedby='userDate3_error' aria-required='false'" 
																	classAttributes ="class='form-control fms_date_mask fms_small_input onDelete hasDatepicker' "
																	showIconDefault="${isShowCalendarIcon}"/> 
																<div class="fms_form_error" id="userDate3_error"></div>
															</div>		
															
															<label id="userDate4_label" class="control-label" for="userDate4"> 
																<g:userDefinedFieldLabel winId="GRUPA" datawindowId ="dw_grupa_de" userDefineTextName="user_date_4_t" defaultText="User Date 4"   />
															</label>
															<div class="fms_form_input">
																<g:securejqDatePickerUIUX 
																	tableName="GROUP_ADDRESS" attributeName="userDate4" 
																	dateElementId="address.${ i }.userDate4" 
																	dateElementName="address.${ i }.userDate4" 
																	datePickerOptions="changeMonth:true, changeYear:true, yearRange:'${((address?.userDate4 != null ? address?.userDate4.get(Calendar.YEAR):Calendar.getInstance().get(Calendar.YEAR)) - 100)}:${((address?.userDate4 != null ? address?.userDate4.get(Calendar.YEAR):Calendar.getInstance().get(Calendar.YEAR)) + 100)}', numberOfMonths: 1"
																	dateElementValue="${formatDate(format:'MM/dd/yyyy',date: address?.userDate4)}"
																	ariaAttributes="aria-labelledby='userDate4_label' aria-describedby='userDate4_error' aria-required='false'" 
																	classAttributes ="class='form-control fms_date_mask fms_small_input onDelete hasDatepicker' "
																	showIconDefault="${isShowCalendarIcon}"/> 
																<div class="fms_form_error" id="userDate4_error"></div>
															</div>		
																
															<label id="userDate5_label" class="control-label" for="userDate5"> 
																<g:userDefinedFieldLabel winId="GRUPA" datawindowId ="dw_grupa_de" userDefineTextName="user_date_5_t" defaultText="User Date 5"   />
															</label>
															<div class="fms_form_input">
																<g:securejqDatePickerUIUX 
																	tableName="GROUP_ADDRESS" attributeName="userDate5" 
																	dateElementId="address.${ i }.userDate5" 
																	dateElementName="address.${ i }.userDate5" 
																	datePickerOptions="changeMonth:true, changeYear:true, yearRange:'${((address?.userDate5 != null ? address?.userDate5.get(Calendar.YEAR):Calendar.getInstance().get(Calendar.YEAR)) - 100)}:${((address?.userDate5 != null ? address?.userDate5.get(Calendar.YEAR):Calendar.getInstance().get(Calendar.YEAR)) + 100)}', numberOfMonths: 1"
																	dateElementValue="${formatDate(format:'MM/dd/yyyy',date: address?.userDate5)}"
																	ariaAttributes="aria-labelledby='userDate5_label' aria-describedby='userDate5_error' aria-required='false'" 
																	classAttributes ="class='form-control fms_date_mask fms_small_input onDelete hasDatepicker' "
																	showIconDefault="${isShowCalendarIcon}"/> 
																<div class="fms_form_error" id="userDate5_error"></div>
															</div>
														</div>
													</div>
												</fieldset>
											</div>
										</td>
									</tr>
							 	</g:each>  
							</tbody>
						</table>
					</div>
				</div>
			</div>
		</div>
	<div id="addGroupPlaceHolder"></div>
</div>