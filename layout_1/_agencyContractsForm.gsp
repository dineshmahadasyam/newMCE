<%@ page import="com.perotsystems.diamond.dao.cdo.Agency"%>
<%@ page import="com.perotsystems.diamond.dao.cdo.GroupMaster"%>
<!DOCTYPE html>
<html>
<head>
<meta name="layout" content="main">

<title><g:message code="default.list.label" args="[entityName]" /></title>
<g:set var="appContext" bean="grailsApplication"/>
<meta name="navSelector" content="maint"/> 
<meta name="navChildSelector" content="agency"/>

<link rel="stylesheet" href="${resource(dir: 'css', file: 'member_pages.css')}" type="text/css">

<script type="text/javascript" src="${resource(dir: 'js', file: 'jquery.maskedinput.js')}"></script>
<script type="text/javascript" src="${resource(dir: 'js', file: 'commonfunctions.js')}"></script>
<script type="text/javascript" src="${resource(dir: 'js', file: 'jquery.alphanum.js')}"></script>
<script type="text/javascript" src="${resource(dir: 'js', file: 'jquery.validate.js')}"></script>
<script type="text/javascript" src="${resource(dir: 'js', file: 'additional-methods.js')}"></script>	

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

		 $(".amtNumeric").numeric({});

	});//]]>

	function addContract() {		
		var seqAgencyId = "${agencyInstance?.seqAgencyId}";
		var appName = "${appContext.metadata['app.name']}";
		
		window.location.assign("/"+ appName+"/agency/addAgencyContract?seqAgencyId=" + seqAgencyId);
		
	}

	function populateDescription(id) {
		 var groupId = document.getElementById(id+".groupId").value;

		
		 if(groupId != null && groupId != ""){
			 var descr = jQuery.ajax({
					url : '<g:createLinkTo dir="/agency/ajaxPopulateDescription"/>',
									
					type : "GET",
					data : {groupId:groupId},
					success : function(result) {
						var index = result.indexOf("-")
						
						if(index != null && index > 0){
							var seqDBId = result.substr(0 , index).trim()
							var desc = result.substr(index+1 , result.length)
							if(seqDBId != null && seqDBId != ""){
								document.getElementById("agencyContract."+ id + ".seqGroupId").value = seqDBId
								}
							else{
								document.getElementById("agencyContract."+ id + ".seqGroupId").value = null
								}

							if(desc != null){
								document.getElementById(id + ".description").value = desc
								}
							else{
								document.getElementById(id + ".description").value = ""
								}
						}
						else{
							document.getElementById("agencyContract."+ id + ".seqGroupId").value = null
							document.getElementById(id + ".description").value = ""
							}
					}
				});
		}
		 else{
			 document.getElementById(id +".description").value=""
			 document.getElementById("agencyContract."+ id + ".seqGroupId").value = null
			 }
	}
	
	function lookupplanId(idName, cdoClassName, cdoClassAttributeName, setToIdName, setToIdName1) {
		var groupId = document.getElementById(idName).value
		if(groupId == null || groupId == "") {
			//alert ("Please enter Group Id");
			document.getElementById('GroupIdAlertInfo').click();
			return false;
		}
		
		var htmlElementValue 
		var assocHTMLElementsValue
		if(idName.indexOf('|') == -1){			
			htmlElementValue = document.getElementById(idName).value
			assocHTMLElementsValue = htmlElementValue
		} else {
			var nameArray = idName.split("|")
			for (var i =0;i<nameArray.length;i++) {
				if(i == 0) {
					htmlElementValue = document.getElementById(nameArray[i]).value					
				}
				assocHTMLElementsValue += document.getElementById(nameArray[i]).value+"|"
			}
		}
		//alert("htmlElementValue = "+htmlElementValue )
		var appName = "${appContext.metadata['app.name']}";
		$('#LookupModal').modal('show');
		var urlValue = "/"+appName+"/lookUp/lookUpPlanId?htmlElementIdName=" + idName
						+ "&htmlElementValue=" + htmlElementValue 
						+ "&cdoClassName="+ cdoClassName 
						+ "&cdoClassAttributeName="+ cdoClassAttributeName 
						+ "&assocHTMLElementsValue="+ assocHTMLElementsValue 
						+ "&setToIdName=" + setToIdName
						+ "&setToIdName1=" + setToIdName1
						+ "&offset=0"
		document.getElementById('LookupSrc').setAttribute('src', urlValue);
		//alert (urlValue )
		
	}

	function upperMe(id) { 
		document.getElementById(id+ ".groupId").value = document.getElementById(id+".groupId").value.toUpperCase(); 
	}
	
	function deleteContract(seqId)
	{
		document.getElementById('seqAgencyGroupContractId').value = seqId
		return true;	    	
	}

	function isNumberKey(evt) {
		var charCode = (evt.which) ? evt.which : event.keyCode;
	    if (charCode == 46 && evt.srcElement.value.split('.').length>1) {
	    	//alert("Please enter numbers and decimal only for Rate Amount");
	    	document.getElementById('overrideAmtAlertInfo').click();
	        return false;
	    }
	    if (charCode != 46 && charCode > 31 && (charCode < 48 || charCode > 57)){
	    	//alert("Please enter numbers and decimal only for Rate Amount");
	    	document.getElementById('overrideAmtAlertInfo').click();
	    	return false;
	        }
	        
	    return true;
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
            $('#BtnSave').attr('disabled', 'disabled');
            $('#BtnUndo').attr('disabled', 'disabled');
          $('#DataTable').append('<tr id="EmptyTable"><td colspan="3">There are no records to display</td></tr>');
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
	           //$('#SaveAlertModal').modal('show');
	        	 $('#editForm').submit();   
	         });
	         
	         // Save Modal
	         $('#BtnSaveModal').click(function(e){
	          // e.preventDefault();            
	           //this.form.submit(); // JQuery validations will not trigger
	           $('#editForm').submit();//resetForm();
	         });

	         // Undo button
	         $('.BtnUndo').click(function(e){
	           //e.preventDefault();            
	          // $('#WarningAlertModal').modal('show');
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
	         });

	         $('.BtnUndoModal').click(function(e){
	           //e.preventDefault(); 
	          // this.form.reset();
	           //resetForm();           
	         });

	         	$('.groupIdAlert').hide();  
				$('.groupIdAlert').click(function(e){ 
			    	$('#SearchAlertModal').modal('show');
			    });
			 	$('#SearchAlertModal').modal({
			    	backdrop: 'static',
			       show: false
			   	});

			 	$('.groupIdAlertInfo').hide();  
				$('.groupIdAlertInfo').click(function(e){ 
			    	$('#SearchAlertModalInfo').modal('show');
			    });
			 	$('#SearchAlertModalInfo').modal({
			    	backdrop: 'static',
			       show: false
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
			               myFm.action = "/"+appName+"/agency/deleteContract";     	
			               myFm.submit();
			           
			  		});	      

			      $('.overrideAmtAlertInfo').hide();  
					$('.overrideAmtAlertInfo').click(function(e){ 
				    	$('#OverrideAmtAlertModal').modal('show');
				    });
				 	$('#OverrideAmtAlertModal').modal({
				    	backdrop: 'static',
				       show: false
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
<input type="hidden" name="editType" value="CONTRACTS" />
<input type="hidden" name="seqAgencyId" value="${agencyInstance?.seqAgencyId }" />
<input type="hidden" name="seqAgencyGroupContractId" id="seqAgencyGroupContractId" value="" />

<!-- START - FMS Content Body -->
<div id="fms_content_body">
	<div class="right-corner" align="right">COMMC</div>

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

	<div test="${agencyInstance?.seqAgencyId}">
		<div id="contractsDiv" style="display: block" class="left-corner" align="left">			
			<h2>Contracts  <button name="addContractButton" type="button" class="btn btn-primary btn-sm" title="Click to add a new address." onClick="addContract()"><i class="fa fa-plus"></i> New Contract</button></h2>
				
		</div>

		<div class="fms_required_legend fms_required">= required</div>

		<!-- START - Data Table Section -->
		<div id="fms_widget">
			<div class="row bottom-margin-sm">
				<div class="col-xs-6">
					<button class="btn btn-sm btn-primary" type="button"
						onclick='gotoSearch()' title="Click to perform a new search.">New
						Search</button>
				</div>
				<div class="col-xs-6 text-right">
					<button id="BtnSave" class="btn btn-primary btn-sm BtnSave"
						type="button" title="Click to save all changes.">
						<span class="fa fa-floppy-o"></span> Save All Changes
					</button>
					<button id="BtnUndo" class="btn btn-default btn-sm BtnUndo"
						type="button" title="Click to clear all changes.">
						<span class="glyphicon glyphicon-repeat"></span> Undo All Changes
					</button>
				</div>
			</div>

			<!-- START - FMS Table Wrapper -->
			<div class="fms_table_wrapper">
				<table id="DataTable"
					class="tablesorter tablesorter-fms tablesorterdf6319efcolumnselector"
					role="grid" aria-describedby="DataTable_pager_info">
					<thead>
						<tr role="row" class="tablesorter-headerRow">
							<th class="{sorter: false} tablesorter-header sorter-false"
								data-column="4" data-columnselector="disable"
								aria-disabled="true">Group Id</th>
							<th class="{sorter: false} tablesorter-header sorter-false"
								data-column="4" data-columnselector="disable"
								aria-disabled="true">Plan/Rider Code</th>

							<th data-columnselector="disable"
								class="{sorter: false} tablesorter-header sorter-false tablesorter-headerUnSorted"
								data-column="6" scope="col" role="columnheader"
								aria-disabled="true" unselectable="on" aria-sort="none"
								style="-webkit-user-select: none;"><div
									class="tablesorter-header-inner">Actions</th>
						</tr>
					</thead>
					<tfoot></tfoot>

					<tbody aria-live="polite" aria-relevant="all">
						<g:each in="${agencyInstance?.agencyGroupContracts }"
							var="agencyContract" status="i">
							<input type="hidden" name="seq_contract_id_${i}"
								value="${agencyContract?.seqAgencyGroupContractId }">
							<input type="hidden" name="agencyContract.${i}.iterationCount"
								value="${i}">
							<input type="hidden"
								name="agencyContract.${i}.seqAgencyGroupContractId"
								value="${agencyContract?.seqAgencyGroupContractId }">

							<tr class="${(i % 2) == 0 ? 'even' : 'odd'}">

								<td>
									${groupMasterMap?.get(agencyContract.seqGroupId).getGroupId()}
								</td>
								<td>
									${premMasterMap?.get(agencyContract.seqPremId)}
								</td>
								<td>
									<button class="btn fms_btn_icon btn-sm BtnEditRow"
										type="button" title="Click to edit or view this row.">
										<span class="glyphicon glyphicon-pencil"></span>
									</button>
									<button class="btn fms_btn_icon btn-sm BtnCollapseRow hidden"
										type="button" title="Click to collapse this row.">
										<span class="glyphicon glyphicon-collapse-up"></span>
									</button>
								</td>
							</tr>

							<tr id="Row2Child" class="tablesorter-childRow" role="row">
								<td colspan="3" id="${agencyContract?.seqAgencyGroupContractId}"
									class="" style="display: none;">

									<div class="fms_widget">
										<fieldset>
											<legend>
												<h3>General Information</h3>
											</legend>

											<div class="fms_form_layout_2column">
												<div class="fms_form_column fms_long_labels">

													<label id="groupId_r2_label" for="groupId"	class="control-label fms_required" > 
													<g:message code="agentContract.groupId.label" default="Group Id :" />
													</label>
													<div class="fms_form_input">
														<input type="hidden" id="agencyContract.${i}.seqGroupId"
															name="agencyContract.${i}.seqGroupId"
															value="${agencyContract.seqGroupId}" />

														<g:secureTextField name="${i}.groupId" maxlength="30"
															id="${i}.groupId" class="form-control"
															value="${groupMasterMap?.get(agencyContract.seqGroupId).getGroupId()}"
															tableName="AGENCY_GROUP_CONTRACT"
															attributeName="seqGroupId" title="The Group ID"
															onblur="populateDescription(${i})"
															onchange="upperMe(${i});populateDescription(${i})"
															aria-labelledby="groupId_r2_label"  
															aria-describedby="groupId_r2_error" aria-required="false">
														</g:secureTextField>
														<fmsui:cdoLookup lookupElementId="${i}.groupId"
															lookupElementName="${i}.groupId"
															lookupElementValue="${groupMasterMap?.get(agencyContract.seqGroupId).getGroupId()}"
															lookupCDOClassName="com.perotsystems.diamond.dao.cdo.GroupMaster"
															lookupCDOClassAttribute="groupId"
															htmlElementsToUpdate="agencyContract.${i}.seqGroupId"
															htmlElementsToUpdateCDOProperty="seqGroupId" />
														<div class="fms_form_error" id="groupId_error"></div>
													</div>

													<label id="planRiderCode_r2_label" for="planRiderCode" class="control-label fms_required" > 
														<g:message	code="premiumMaster.planRiderCode.label" default="Plan/Rider Code :" />
													</label>
													<div class="fms_form_input fms_has_feedback">
														<input type="hidden" id="agencyContract.${i}.seqPremId"	name="agencyContract.${i}.seqPremId" value="${agencyContract.seqPremId}" />

														<g:secureTextField name="${i}.planRiderCode"
															class="form-control"
															value="${premMasterMap?.get(agencyContract.seqPremId)}"
															maxlength="30" readonly="readonly"
															tableName="AGENCY_GROUP_CONTRACT"
															attributeName="seqPremId" aria-labelledby="planRiderCode_r2_label"  
															aria-describedby="planRiderCode_r2_error" aria-required="false">
														</g:secureTextField>
														<button type="button" id="0.planRiderCode"
															class="btn fms_btn_icon btn-sm fms_form_control_feedback"
															title="Click to do full search."
															onclick="lookupplanId('${i}.groupId', 'com.perotsystems.diamond.dao.cdo.PremiumMaster','seqGroupId', '${i}.planRiderCode','agencyContract.${i}.seqPremId')">
															<i class="glyphicon glyphicon-search"></i>
														</button>

														<button id="GroupIdAlertInfo" type="button"
															class="btn fms_btn_icon btn-sm groupIdAlertInfo"
															title="Click to reset plan form."
															data-target="#SearchAlertModalInfo">
															<span class="glyphicon glyphicon-repeat"></span>
														</button>
														<button id="GroupIdAlert" type="button"
															class="btn fms_btn_icon btn-sm groupIdAlert"
															title="Click to reset plan form."
															data-target="#SearchAlertModal">
															<span class="glyphicon glyphicon-repeat"></span>
														</button>
														<div class="fms_form_error" id="planRiderCode_error"></div>
													</div>

												</div>

												<div class="fms_form_column fms_long_labels">
													<label id="description_r2_label" for="description" class="control-label" > 
													<g:message code="description.label" default="Description :" />
													</label>
													<div class="fms_form_input">
														<g:textField name="${i}.description" class="form-control"
															id="${i}.description"
															value="${groupMasterMap?.get(agencyContract.seqGroupId).getGroupName1()}"
															readonly="readonly" aria-labelledby="description_r2_label"  
															aria-describedby="description_r2_error" aria-required="false"/>
														<div class="fms_form_error" id="description_error"></div>
													</div>

													<label id="overrideAmount_r2_label" for="overrideAmount" class="control-label" > 
														<g:message	code="agencyContract.overrideAmount.label"	default="Override Amt :" />
													</label>
													<div class="fms_form_input">
														<g:secureTextField
															name="agencyContract.${i}.overrideAmount"
															value="${agencyContract.overrideAmount}" maxlength="30"
															onkeypress="return isNumberKey(event)"
															tableName="AGENCY_GROUP_CONTRACT"
															attributeName="overrideAmount" class="form-control"
															attributeName="seqPremId" aria-labelledby="overrideAmount_r2_label"  
															aria-describedby="overrideAmount_r2_error" aria-required="false"></g:secureTextField>
														<button id="overrideAmtAlertInfo" type="button"
															class="btn fms_btn_icon btn-sm overrideAmtAlertInfo"
															title="Click to reset plan form."
															data-target="#OverrideAmtAlertModal">
															<span class="glyphicon glyphicon-repeat"></span>
														</button>
														<div class="fms_form_error" id="overrideAmount_error"></div>
													</div>

												</div>
											</div>
											
											<div class="fms_form_button">

														<button id="BtnAddressDelete2" type="button"
															class="btn btn-primary BtnDeleteRow"
															title="Click to delete agency details."
															data-target="#DeleteAlertModal"
															onclick="return deleteContract(${agencyContract?.seqAgencyGroupContractId});">
															<i class="fa fa-trash"></i> Delete
														</button>
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


<!-- END - FMS Content Body -->    
	<div id="addGroupPlaceHolder"></div>
					
<!-- START - Reset Notice Modal -->
      <div class="modal fade" id="WarningAlertModal" tabindex="-1" role="dialog" aria-labelledby="myModalLabel">        
        <div class="modal-dialog">
          <div class="modal-content fms_modal_warning">
            <div class="modal-body">
              <button type="button" class="close" data-dismiss="modal" aria-label="Close"><span aria-hidden="true">&times;</span></button>
              <h4>Are you sure you want to reset this form?</h4>
              <p>You'll lose any changes you made by doing so.</p>
            </div>
            <div class="modal-footer">
              <button type="button" class="btn btn-default" data-dismiss="modal">Cancel</button>
              <button type="button" class="btn btn-primary BtnUndoModal" data-dismiss="modal">Yes, Reset</button>
            </div>
          </div>
        </div>
      </div>
    <!-- END - Reset Notice Modal -->
	
	<!-- START - Save Notice Modal -->
      <div class="modal fade" id="SaveAlertModal" tabindex="-1" role="dialog" aria-labelledby="myModalLabel">        
        <div class="modal-dialog">
          <div class="modal-content fms_modal_success">
            <div class="modal-body">
              <button type="button" class="close" data-dismiss="modal" aria-label="Close"><span aria-hidden="true">&times;</span></button>
              <h4>Do you want to save all changes?</h4>              
            </div>
            <div class="modal-footer">
              <button type="button" class="btn btn-default" data-dismiss="modal">Cancel</button>
              <button id="BtnSaveModal" type="button" class="btn btn-primary" data-dismiss="modal">Yes, Save</button>
            </div>
          </div>
        </div>
      </div>
    <!-- END - Save Notice Modal -->
    
    <!-- START - Search Group ID Modal -->
<div class="modal fade" id="SearchAlertModalInfo" tabindex="-1" role="dialog" aria-labelledby="myModalLabel">
<!-- <div class="modal fade" id="InfoAlert" tabindex="-1" role="dialog" aria-labelledby="myModalLabel"> -->        
	  	 <div class="modal-dialog">
          <div class="modal-content fms_modal_error-sm">
            <div class="modal-body">
              <button type="button" class="close" data-dismiss="modal" aria-label="Close"><span aria-hidden="true">&times;</span></button>
              <h5>Please enter Group Id.</h5>            
            </div>

	           <div class="modal-footer text-center">
              <button type="button" class="btn btn-default" data-dismiss="modal">Ok</button>     
            </div>
          </div>
        </div>
      </div>

<!-- START - Search Valid Group ID Modal -->
<div class="modal fade" id="SearchAlertModal" tabindex="-1" role="dialog" aria-labelledby="myModalLabel">
<!-- <div class="modal fade" id="InfoAlert" tabindex="-1" role="dialog" aria-labelledby="myModalLabel"> -->        
	  	 <div class="modal-dialog">
          <div class="modal-content fms_modal_error-sm">
            <div class="modal-body">
              <button type="button" class="close" data-dismiss="modal" aria-label="Close"><span aria-hidden="true">&times;</span></button>
              <h5>Please enter a valid Group Id.</h5>            
            </div>

	           <div class="modal-footer text-center">
              <button type="button" class="btn btn-default" data-dismiss="modal">Ok</button>     
            </div>
          </div>
        </div>
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
					<button id="BtnDeleteRowYes" type="button" class="btn btn-primary" data-dismiss="modal" >Yes, Delete</button>
				</div>
			</div>
		</div>
	</div>
	<!-- END - Delete Notice Modal -->		
	
	<!-- START - Override amount validation -->
	<div class="modal fade" id="OverrideAmtAlertModal" tabindex="-1" role="dialog" aria-labelledby="myModalLabel">
	  	 <div class="modal-dialog">
          <div class="modal-content fms_modal_error-sm">
            <div class="modal-body">
              <button type="button" class="close" data-dismiss="modal" aria-label="Close"><span aria-hidden="true">&times;</span></button>
              <h5>Please enter numbers and decimal only for Rate Amount.</h5>            
            </div>

	           <div class="modal-footer text-center">
              <button type="button" class="btn btn-default" data-dismiss="modal">Ok</button>     
            </div>
          </div>
        </div>
      </div>
			
 </html>