<%@ page import="com.dell.diamond.fms.AgentMasterCommand"%>
<%@ page import="com.dell.diamond.fms.enums.PageNameEnum" %>
<g:set var="appContext" bean="grailsApplication"/>
<meta name="layout" content="main">

<g:set var="isShowCalendarIcon" value="${PageNameEnum.AGENT_EDIT.equals(currentPage)?true:false}" />

<script type="text/javascript" src="${resource(dir: 'js', file: 'jquery.maskedinput.js')}"></script>
<script type="text/javascript" src="${resource(dir: 'js', file: 'commonfunctions.js')}"></script>
<script type="text/javascript" src="${resource(dir: 'js', file: 'jquery.alphanum.js')}"></script>
<script type="text/javascript" src="${resource(dir: 'js', file: 'jquery.validate.js')}"></script>
<script type="text/javascript">

	function addContact() {		
		window.location.assign('<g:createLinkTo dir="/agentMaster/addAgentContact"/>?seqAgentId=${agentMasterInstance?.seqAgentId}&agentId=${agentMasterInstance?.agentId}&agentType=${agentMasterInstance?.agentType}');
	}
	function gotoSearch() {
		var appName = "${appContext.metadata['app.name']}";
		window.location.assign("/"+appName+"/agentMaster/list");
	}

	function deleteContact(seqId)
	{
		document.getElementById('seqContactId').value = seqId
		
	    	var appName = "${appContext.metadata['app.name']}";
            var myFm = document.getElementById("editForm") ; 			
            myFm.action = "/"+appName+"/agentMaster/deleteContact";    	
            myFm.submit();
	}
	
</script>

<script type="text/javascript">
	
	$(document).ready(function() {

		// If all rows are deleted show message
        if ($('#DataTable td').length <= 0) {
            $('#BtnSave').attr('disabled', 'disabled');
            $('#BtnUndo').attr('disabled', 'disabled');
          $('#DataTable').append('<tr id="EmptyTable"><td colspan="6">There are no records to display</td></tr>');
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
		               myFm.action = "/"+appName+"/agentMaster/deleteContact";    	
		               myFm.submit();
		           
		  		});
		  		
			 
	         $('.tablesorter').delegate('.btnSaveAddress', 'click' ,function(){
	             $('#editForm').submit();
	           });
	          
	           $( ".btnResetddress" ).click(function() {             
	             $('.BtnDeleteRow').show();
	             $('.tablesorter-childRow').find('td').hide();
	              $('#NewAddress').prop('disabled', function(i, v) { return !v; });
	        
	           });
	
		});
		
$(document).ready(function() {

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

</head>
<input type="hidden" name="editType" value="CONTACT" />
<input type="hidden" name="seqAgentId" value="${agentMasterInstance?.seqAgentId }" />
<input type="hidden" name="agentId" value="${agentMasterInstance?.agentId}" />
<input type="hidden" name="agentType" value="${agentMasterInstance?.agentType}" />
<input type="hidden" name="seqContactId" id="seqContactId" value="" />
<div id="${agentMasterInstance?.seqAgentId}">
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
		
		<div id="addAddressDiv" style="display:block">
			<h2>Agent/Broker Contact 
				<button 
					type="button" 
					name="addContactButton"
					class="btn btn-primary btn-sm" 
					title="Click to add a new address." 
					onClick="addContact()">
						<i class="fa fa-plus"></i> 
					Add Contact
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
							<button class="btn btn-sm btn-primary" type="button" onClick="gotoSearch()" title="Click to perform a new search.">New Search</button>
						</div>
						<div class="col-xs-6 text-right">
							<button id="BtnSave" class="btn btn-primary btn-sm BtnSaveModal" type="button" title="Click to save all changes."><span class="fa fa-floppy-o"></span> Save All Changes</button>
							<button id="BtnUndo" class="btn btn-default btn-sm BtnUndoModal" type="button" title="Click to clear all changes."><span class="glyphicon glyphicon-repeat"></span> Undo All Changes</button>
						 </div>
				     </div>
					<!-- START - FMS Table Wrapper -->
					<div class="fms_table_wrapper">
						<table id="DataTable" class="tablesorter tablesorter-fms tablesorteree7b702bcolumnselector" role="grid" aria-describedby="DataTable_pager_info">
						<thead>
							<tr role="row" class="tablesorter-headerRow">
									<th class="{sorter: false} tablesorter-header sorter-false" data-column="1" data-columnselector="disable" aria-disabled="true">Contact Name</th>
									<th class="{sorter: false} tablesorter-header sorter-false" data-column="2" data-columnselector="disable" aria-disabled="true">Contact Title</th>
									<th class="{sorter: false} tablesorter-header sorter-false" data-column="3" data-columnselector="disable" aria-disabled="true">Phone Number</th>
									<th class="{sorter: false} tablesorter-header sorter-false" data-column="4" data-columnselector="disable" aria-disabled="true">Extension</th>
									<th class="{sorter: false} tablesorter-header sorter-false" data-column="5" data-columnselector="disable" aria-disabled="true">Email</th>
									<th class="{sorter: false} tablesorter-header sorter-false" data-column="6" data-columnselector="disable" aria-disabled="true">Actions</th>
							<tr>
						</thead>
						
							<tbody aria-live="polite" aria-relevant="all"> 
							<g:each in="${agentMasterInstance?.agentContacts }" var="agentContact" status="i">
								<input type="hidden" name="seq_contact_id_${i}" value="${agentContact?.seqAgentContact }">
								<input type="hidden" name="agentContact.${i}.iterationCount" value="${i}">
									<tr id="Row2" role="row" class="tablesorter-hasChildRow" style="">
										<td>
											${agentContact?.contactName}
										</td>
										<td>
											${agentContact?.contactTitle}
										</td>
										<td>
											<g:if test="${agentContact?.phoneNumber?.length() == 10}">${agentContact?.phoneNumber.with {length()? getAt(0..2):''}}-${agentContact?.phoneNumber.with {length()? getAt(3..5):''}}-${agentContact?.phoneNumber.with {length()? getAt(6..length()-1):''}}</g:if>
											<g:else>${agentContact?.phoneNumber}</g:else>
										</td>
										<td>
											${agentContact?.extension}
										</td>
										<td>
											${agentContact?.emailAddress}
										</td>
											<td>		
											<button class="btn fms_btn_icon btn-sm BtnEditRow" type="button" title="Click to edit or view this row."><span class="glyphicon glyphicon-pencil"></span></button>
					                  		<button class="btn fms_btn_icon btn-sm BtnCollapseRow hidden" type="button" title="Click to collapse this row."><span class="glyphicon glyphicon-collapse-up"></span></button>
											<button id="BtnDeleteRow" type="button" class="btn fms_btn_icon btn-sm BtnDeleteRow" data-target="#DeleteAlertModal"  title="Click to delete contact." action="deleteContact" value="Delete" ><i class="fa fa-trash"></i></button>
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
										              <button id="BtnDeleteRowYes" onclick="return deleteContact(${agentContact?.seqAgentContact});" type="button" class="btn btn-primary" data-dismiss="modal">Yes, Delete</button>
										            </div>
										          </div>
										        </div>
										      </div>
										    <!-- END - Delete Notice Modal -->
											</td>
									</tr>
										<tr id="Row2Child" class="tablesorter-childRow" role="row">
										<td colspan="6"  id="${agentContact?.seqAgentContact}.toggleFields" class="" style="display:none;">
										<div id="${agentContact?.seqAgentContact}">
										<div class="fms_widget">
											<fieldset class="no_border">
												<div class="fms_form_layout_2column">                  
													<div class="fms_form_column fms_long_labels">	
														<label class="control-label fms_required" id="contactName_label" for="contactName">
															<g:message code="agentContact.contactName.label" default="Name :" />
														</label>
														<div class="fms_form_input">
															<g:secureTextField 
															name="agentContact.${i}.contactName" 
															title="The Contact Name" 
															maxlength="40" 
															value="${agentContact?.contactName}" 
															tableName="AGENT_CONTACT" 
															attributeName="contactName"
															Class="form-control"
															aria-labelledby="contactName_label" 
															aria-describedby="contactName_error" 
															aria-required="false">
															</g:secureTextField>
															<div class="fms_form_error" id="contactName_error"></div>
														</div>
								
														<label class="control-label fms_required" id="phoneNumber_label" for="phoneNumber">
															<g:message code="agentContact.phoneNumber.label" default="Phone Number :" />
														</label>
														<div class="fms_form_input">
															<g:secureTextField 
															name="agentContact.${i}.phoneNumber" 
															value="${agentContact?.phoneNumber}"  
															class="form-control maskPhoneNumber"
										 					tableName="AGENT_CONTACT" 
										 					attributeName="phoneNumber" 
										 					title="The Primary Phone Number" 
										 					maxlength="40" 
										 					aria-labelledby="phoneNumber_label" 
															aria-describedby="phoneNumber_error" 
															aria-required="false"/>
															<div class="fms_form_error" id="phoneNumber_error"></div>
														</div>
														
														<label class="control-label" id="emailAddress_label" for="emailAddress">
															<g:message code="agentContact.emailAddress.label" default="Email Address :" />
														</label>
														<div class="fms_form_input">
															<g:secureTextField 
															name="agentContact.${i}.emailAddress" 
															value="${agentContact?.emailAddress}"  
															tableName="AGENT_CONTACT" 
															attributeName="emailAddress" 
															title="The Email Address" 
															maxlength="100" 
															Class="form-control"
															aria-labelledby="emailAddress_label" 
															aria-describedby="emailAddress_error" 
															aria-required="false"/>
															<div class="fms_form_error" id="emailAddress_error"></div>
														</div>
														
														<label class="control-label" id="businessPhone_label" for="businessPhone">
															<g:message code="agentContact.businessPhone.label" default="Business Phone :" />
														</label>
														<div class="fms_form_input">
															<g:secureTextField 
															name="agentContact.${i}.businessPhone" 
															value="${agentContact?.businessPhone}" 
															class="form-control maskPhoneNumber" 
															tableName="AGENT_CONTACT" 
															attributeName="businessPhone" 
															title="The Business Phone Number"
															maxlength="40"
															aria-labelledby="businessPhone_label" 
															aria-describedby="businessPhone_error" 
															aria-required="false"/>
														<div class="fms_form_error" id="businessPhone_error"></div>
														</div>
													</div>
								
													<div class="fms_form_column fms_long_labels">
													
														<label class="control-label" id="contactTitle_label" for="contactTitle">
															<g:message code="agentContact.contactTitle.label" default="Title :" />
														</label>
														<div class="fms_form_input">
															<g:secureCdoSelectBox 
																cdoClassName="com.perotsystems.diamond.dao.cdo.ContactTitleMaster"
																tableName="AGENT_CONTACT" 
																attributeName="contactTitle"
																cdoAttributeWhereValue="S"
																cdoAttributeWhere="titleType"
																cdoAttributeSelect="contactTitle"
																cdoAttributeSelectDesc="description"
																languageId="0"
																htmlElelmentId="agentContact.${i}.contactTitle"
																defaultValue="${agentContact?.contactTitle}"
																value="${agentContact?.contactTitle}"
																blankValue="Title" 
																className="form-control"
																aria-labelledby="contactTitle_label" 
																aria-describedby="contactTitle_error" 
																aria-required="false">
															</g:secureCdoSelectBox>
																					
															 <div class="fms_form_error" id="contactTitle_error"></div>
														 </div> 
														 
														<label class="control-label" id="extension_label" for="extension">
														 <g:message code="agentContact.extension.label" default="Extension :" />
														</label>
														<div class="fms_form_input">
															<g:secureTextField 
																name="agentContact.${i}.extension" 
																value="${agentContact?.extension}" 
																class="form-control maskExtension"  
											  					tableName="AGENT_CONTACT" 
											  					attributeName="extension" 
											  					title="The Extension for the Phone Number" 
											  					maxlength="6" 
											  					aria-labelledby="extension_label" 
																aria-describedby="extension_error" 
																aria-required="false"/>
															 <div class="fms_form_error" id="extension_error"></div>
														</div>
																				
														<label class="control-label" id="faxNumber_label" for="faxNumber">
															<g:message code="agentContact.faxNumber.label" default="Fax Number :" />
														</label>
														<div class="fms_form_input">
															<g:secureTextField 
																name="agentContact.${i}.faxNumber" 
																value="${agentContact?.faxNumber}"  
																class="form-control maskPhoneNumber"
																tableName="AGENT_CONTACT" 
																attributeName="faxNumber" 
																title="The Fax Number" 
																maxlength="40" 
																aria-labelledby="faxNumber_label" 
																aria-describedby="faxNumber_error" 
																aria-required="false"/>
														<div class="fms_form_error" id="faxNumber_error"></div>
														</div>
								
														<label class="control-label" id="mobilePhone_label" for="mobilePhone">
															<g:message code="agentContact.mobilePhone.label" default="Mobile Phone :" />
														</label>
														<div class="fms_form_input">
															<g:secureTextField 
																name="agentContact.${i}.mobilePhone" 
																value="${agentContact?.mobilePhone}"  
																class="form-control maskPhoneNumber" 
																tableName="AGENT_CONTACT" 
																attributeName="mobilePhone" 
																title="The Mobile Phone Number" 
																maxlength="40" 
																aria-labelledby="mobilePhone_label" 
																aria-describedby="mobilePhone_error" 
																aria-required="false"/>
														<div class="fms_form_error" id="mobilePhone_error"></div>
														</div>
													</div>
													</div>
												</div>
											</fieldset>
										</div>
										<div class="fms_widget">
								            <fieldset>
												<legend><h3>User Defined Information</h3></legend>
												<div class="fms_form_layout_2column">                  
														<div class="fms_form_column fms_long_labels">	
															
															<label class="control-label" for="userDefined1" id="userDefined1_label">
																<g:userDefinedFieldLabel winId="AGNTC" datawindowId ="AGNTC" userDefineTextName="user_defined_1_t" defaultText="User Defined 1 "/>
															</label>
										                    <div class="fms_form_input">
																<g:secureTextField 
																	name="agentContact.${i}.userDefined1" 
																	tableName="AGENT_CONTACT" 
																	attributeName="userDefined1"
																	maxlength="60"  
																	value="${agentContact?.userDefined1}" 
																	Class="form-control"
																	aria-labelledby="userDefined1_label" 
																	aria-describedby="userDefined1_error" 
																	aria-required="false"/>
										                        <div class="fms_form_error" id="userDefined1_error"></div>
															</div>
															
															<label class="control-label" for="userDefinedDate" id="userDefinedDate_label">
																<g:userDefinedFieldLabel winId="AGNTC" datawindowId ="AGNTC" userDefineTextName="user_date_1_t" defaultText="User Date 1 "/>
																</label>
																<div class="fms_form_input">
																<g:securejqDatePickerUIUX
																	tableName="AGENT_CONTACT" attributeName="userDate1" 
																	dateElementId="agentContact.${i}.userDate1" 
																	dateElementName="agentContact.${i}.userDate1" 
																	datePickerOptions="changeMonth: true, changeYear: true, yearRange: '${((agentContact?.userDate1 != null ? agentContact?.userDate1.get(Calendar.YEAR):Calendar.getInstance().get(Calendar.YEAR)) - 100)} : ${((agentContact?.userDate1 != null ? agentContact?.userDate1.get(Calendar.YEAR):Calendar.getInstance().get(Calendar.YEAR)) + 100)}', numberOfMonths: 1"
																	dateElementValue="${formatDate(format:'MM/dd/yyyy',date: agentContact?.userDate1)}" 
																	ariaAttributes="aria-labelledby='userDefinedDate_label' aria-describedby='userDefinedDate_error' aria-required='false'" 
											                        classAttributes ="class='form-control fms_date_mask fms_small_input onDelete hasDatepicker' "
																	showIconDefault="${isShowCalendarIcon}"/> 
																<div class="fms_form_error" id="userDefinedDate_error"></div>
															</div>  
														</div>
															<div class="fms_form_column fms_long_labels"> 
															 	
																 <label class="control-label" for="userDefined2" id="userDefined2_label">
																	<g:userDefinedFieldLabel winId="AGNTC" datawindowId ="AGNTC" userDefineTextName="user_defined_2_t" defaultText="User Defined 2 "/> 
																</label>
																<div class="fms_form_input">
																	<g:secureTextField 
																		name="agentContact.${i}.userDefined2" 
																		tableName="AGENT_CONTACT" 
																		attributeName="userDefined2"
																		maxlength="60"  
																		value="${agentContact?.userDefined2}"
																		Class="form-control" 
																		aria-labelledby="userDefined2_label" 
																		aria-describedby="userDefined2_error" 
																		aria-required="false"/>
																	<div class="fms_form_error" id="userDefined2_error"></div>
																</div>
									
																<label class="control-label" for="userDefinedDate" id="userDefinedDate_label">
																		<g:userDefinedFieldLabel winId="AGNTC" datawindowId ="AGNTC" userDefineTextName="user_date_2_t" defaultText="User Date 2 "/>
																</label>
																<div class="fms_form_input">
																 <g:securejqDatePickerUIUX 
																		tableName="AGENT_CONTACT"  attributeName="userDate2" 
																		dateElementId="agentContact.${i}.userDate2" 
																		dateElementName="agentContact.${i}.userDate2" 
																		dateElementValue="${formatDate(format:'MM/dd/yyyy',date: agentContact?.userDate2)}"
																		datePickerOptions="changeMonth: true, changeYear: true, yearRange: '${((agentContact?.userDate2 != null ? agentContact?.userDate2.get(Calendar.YEAR):Calendar.getInstance().get(Calendar.YEAR)) - 100)} : ${((agentContact?.userDate2 != null ? agentContact?.userDate2.get(Calendar.YEAR):Calendar.getInstance().get(Calendar.YEAR)) + 100)}', numberOfMonths: 1"
																		precision="day" default="none"
																		ariaAttributes="aria-labelledby='userDefinedDate_label' aria-describedby='userDefinedDate_error' aria-required='false'" 
																		classAttributes ="class='form-control fms_date_mask fms_small_input onDelete hasDatepicker' "
																		showIconDefault="${isShowCalendarIcon}"/> 
																
																	<div class="fms_form_error" id="userDefinedDate_error"></div>
															</div>
														</div>
													</div>
												</fieldset>
											</div>
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
	</div>
</div>
</html>

							
									
								
						
					
					
