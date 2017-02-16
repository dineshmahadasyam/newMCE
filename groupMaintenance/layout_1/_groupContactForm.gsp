<head>
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

			$(function($){
			   $(".maskPhone").mask("?999-999-9999");
			})
	
			$(function($){
			   $(".maskExtension").mask("?999999");
			})
			
			$(function($){
			   $(".maskFax").mask("?999-999-9999");
			})
	});//]]>  	
	</script>
	
	<script>
	$(document).ready( function () {
		//Commenting the below code as it was causing script error. This does need to be called on the Group Contact Page 
		//claimActionCodeDisabled();
		//claimReasonDisabled();
		});
	function cloneRow()
	{

		var divObjSrc = document.getElementById('newContractDiv')
		var divObjDest = document.getElementById('addContractPlaceHolder')
		divObjDest.innerHTML = divObjSrc.innerHTML
		var divObj = document.getElementById('addContractButton')
		divObj.style.display = "none"	
	}

	function addGroupContact() {
		var groupId = "${groupMasterInstance?.groupId}";
		var groupDBId = "${groupMasterInstance?.groupDBId}";
		var appName = "${appContext.metadata['app.name']}";
						
		window.location.assign("/"+ appName+"/groupMaintenance/addGroupContact?groupId="
				+ groupId + "&grouEditType=CONTACT&groupDBId="+groupDBId);
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
		
	</script> 
	 
<script type="text/javascript">
	function deleteButton(seqId){
	    document.getElementById('contactSeqId').value = seqId;
	    return true;
	}
	
	function gotoSearch() {
		var appName = "${appContext.metadata['app.name']}";
		window.location.assign("/"+appName+"/groupMaintenance/list");
	}
	
</script>


<script>
		function editAddress(address){
			//var address = document.getElementById(address);
			//alert(address);
			$(document.getElementById('address.'+address+'.toggleFields')).css('display','table-cell');
			$(document.getElementById('address.'+address+'.toggleSaveButton')).css('display','table-cell');
			$(document.getElementById('address.'+address+'.toggleResetButton')).css('display','table-cell');
			$(document.getElementById('address.'+address+'.toggleEditButton')).css('display','none');
		}
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
		               myFm.action = "/"+appName+"/groupMaintenance/delete";    	
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
<%@ page import="com.perotsystems.diamond.dao.cdo.GroupContactPerson" %>
	<g:hiddenField name="groupId" value="${groupMasterInstance?.groupId}" />
	<g:hiddenField name="groupDBId" value="${groupMasterInstance?.groupDBId}" />
	
	<div id="fms_content_body">
	<div class="right-corner" align="right">GRUPCONT</div>
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
		
	<h2>Contact Info
	 <button name="addContactButton" type="button" class="btn btn-primary btn-sm" title="Click to add a new contact info." onClick="addGroupContact()"><i class="fa fa-plus"></i> New Contact</button></h2>
	 <div class="fms_required_legend fms_required">= required</div>      
		<div id="DataTableSection">

			<div id="SearchResults" class="fms_widget">
	            	
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
				<table id="DataTable" class="tablesorter tablesorter-fms tablesorteree7b702bcolumnselector" role="grid" aria-describedby="DataTable_pager_info">
				<thead>
					<tr role="row" class="tablesorter-headerRow">
							<th class="{sorter: false} tablesorter-header sorter-false" data-column="1" data-columnselector="disable" aria-disabled="true">Contact Name</th>
							<th class="{sorter: false} tablesorter-header sorter-false" data-column="2" data-columnselector="disable" aria-disabled="true">Title</th>
							<th class="{sorter: false} tablesorter-header sorter-false" data-column="3" data-columnselector="disable" aria-disabled="true">Phone Number</th>
							<th class="{sorter: false} tablesorter-header sorter-false" data-column="4" data-columnselector="disable" aria-disabled="true">Phone Extension</th>
							<th class="{sorter: false} tablesorter-header sorter-false" data-column="5" data-columnselector="disable" aria-disabled="true">Email Id</th>
							<th class="{sorter: false} tablesorter-header sorter-false" data-column="6" data-columnselector="disable" aria-disabled="true">Fax Number</th>
							<th class="{sorter: false} tablesorter-header sorter-false" data-column="6" data-columnselector="disable" aria-disabled="true">Actions</th>
					<tr>
					</thead>
						<tbody aria-live="polite" aria-relevant="all"> 
							<g:hiddenField name="contactSeqId" id="contactSeqId" value="" />
								<g:each in="${groupMasterInstance.contacts}" status="i" var="contact">
									<input type="hidden" name="seq_contact_id_${i}" value="${contact?.seqGroupContact }">
										<input type="hidden" name="contact.${i}.iterationCount" value="${i}">
										<tr id="Row2" role="row" class="tablesorter-hasChildRow" style="">
										<tr >
									
										<td class="clickme" >
												${contact?.contactName}
										</td>
										<td class="clickme">
											${contact?.contactTitle}
										</td>
										<td class="clickme">
											${contact?.phoneNumber}
										</td>
										<td class="clickme">
											${contact?.extension}
										</td>
										<td class="clickme">
											${contact?.emailId}
										</td>
										<td class="clickme">
											${contact?.faxNumber}
										</td>
										<td>		
											<button class="btn fms_btn_icon btn-sm BtnEditRow" type="button" title="Click to edit or view this row."><span class="glyphicon glyphicon-pencil"></span></button>
                       						<button class="btn fms_btn_icon btn-sm BtnCollapseRow hidden" type="button" title="Click to collapse this row."><span class="glyphicon glyphicon-collapse-up"></span></button>
											<button id="BtnAddressDelete2" type="button" class="btn fms_btn_icon btn-sm BtnDeleteRow"  title="Click to delete contact." data-target="#DeleteAlertModal"onclick="deleteButton(${contact?.seqGroupContact})"><i class="fa fa-trash"></i></button>
										</td>
									</tr>
									<tr id="Row2Child" class="tablesorter-childRow" role="row">
											<td colspan="7" id="contact.${i}.${contact?.seqGroupContact}.toggleFields" class="" style="display:none;">
												 <div class="fms_widget">

													<fieldset class="no_border">

														<div class="fms_form_layout_2column">                  
															<div class="fms_form_column fms_long_labels">
				
																<label class="control-label fms_required" id="contactName_label" for="contactName">
																	<g:message code="groupMaster.contactName.label" default="Contact Name :" />
																</label>
																<div class="fms_form_input">
																	<g:secureTextField
																	 name="contact.${i}.contactName" 
																	 maxlength="40" Class="form-control"
																	 tableName="GROUP_CONTACT_PERSON" 
																	 attributeName="contactName"
																	 value="${contact?.contactName}" ></g:secureTextField>
																	<div class="fms_form_error" id="contactName_error"></div>
																</div>
																
																<label class="control-label" id="contactTitle_label" for="contactTitle">
																	<g:message code="groupMaster.contactTitle.label" default="Title :" />
																</label>
																<div class="fms_form_input fms_has_feedback">
																	<g:secureTextField 
																		name="contact.${i}.contactTitle" 
																		Class="form-control"
																		tableName="GROUP_CONTACT_PERSON" 
																		attributeName="contactTitle"
																		value="${contact?.contactTitle}" >
																	</g:secureTextField>
																	<fmsui:cdoLookup 
																		lookupElementId="contact.${i}.contactTitle"
                                                                          	lookupElementName="contact.${i}.contactTitle" 
                                                                         	lookupElementValue="${contact?.contactTitle}"
                                                                          	lookupCDOClassName="com.perotsystems.diamond.dao.cdo.ContactTitleMaster"
                                                                          	lookupCDOClassAttribute="contactTitle"/>
																							
																	 <div class="fms_form_error" id="contactTitle_error"></div>
																 </div> 
                  
                  

																 <label class="control-label" id="emailId_label" for="emailId">
																  <g:message code="groupMaster.emailId.label" default="Email Id :" />
																 </label>
																<div class="fms_form_input">
																	<g:secureTextField 
																		name="contact.${i}.emailId"  
																		maxlength="80" 
																		Class="form-control"
																		tableName="GROUP_CONTACT_PERSON" 
																		attributeName="emailId"
																		value="${contact?.emailId}" >
																	</g:secureTextField>
																	 <div class="fms_form_error" id="emailId_error"></div>
																</div>
															</div>
																             
															<div class="fms_form_column fms_long_labels">
                

																	<label class="control-label fms_required" id="phoneNumber_label" for="phoneNumber">
																	  <g:message code="groupMaster.phoneNumber.label" default="Phone Number :" />
																	</label>
																	<div class="fms_form_input">
																		<g:secureTextField 
																			name="contact.${i}.phoneNumber" 
																			maxlength="40"
																			Class="maskPhone form-control"
																			tableName="GROUP_CONTACT_PERSON" 
																			attributeName="phoneNumber"
																			value="${contact?.phoneNumber}">
																		</g:secureTextField>
																		 <div class="fms_form_error" id="phoneNumber_error"></div>
																	</div>

																	<label class="control-label" id="extension_label" for="extension">
																	  <g:message code="groupMaster.contactName.label" default="Phone Extension :" />
																	</label>
																	<div class="fms_form_input">
																		<g:secureTextField 
																			name="contact.${i}.extension" 
																			maxlength="6" 
																			Class="maskExtension form-control"
																			tableName="GROUP_CONTACT_PERSON" 
																			attributeName="extension"
																			value="${contact?.extension}">
																		</g:secureTextField>
																		 <div class="fms_form_error" id="extension_error"></div>
																	</div>

																	<label class="control-label" id="faxNumber_label" for="faxNumber">
																		<g:message code="groupMaster.faxNumber.label" default="Fax Number :" />
																	</label>
																	  <div class="fms_form_input">
																	  	<g:secureTextField 
																		  	name="contact.${i}.faxNumber" 
																		  	maxlength="20" 
																		  	Class="maskFax form-control"
																			tableName="GROUP_CONTACT_PERSON" 
																			attributeName="faxNumber"
																			value="${contact?.faxNumber}">
																		</g:secureTextField>
																		 <div class="fms_form_error" id="faxNumber_error"></div>
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
<div id="addContractPlaceHolder"></div>
							
							
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
</html>
