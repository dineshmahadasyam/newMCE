<%@ page import="com.perotsystems.diamond.bom.PremiumMaster"%>
<%@ page import="com.dell.diamond.fms.enums.PageNameEnum" %>

<g:set var="appContext" bean="grailsApplication"/>
<g:set var="isShowCalendarIcon" value="${PageNameEnum.GROUP_EDIT.equals(currentPage)?true:false}" />
<script type="text/javascript" src="${resource(dir: 'js', file: 'jquery.alphanum.js')}"></script>
<script type="text/javascript" src="${resource(dir: 'js', file: 'jquery.validate.js')}"></script>
<script src="${resource(dir: '/js/layout_1_scripts', file: 'jquery.maskMoney.js')}" ></script>
<script>
	function upperMe(count) { 
		document.getElementById("detail."+count+".planRiderCode").value = document.getElementById("detail."+count+".planRiderCode").value.toUpperCase(); 
	} 

	function cloneRow()
	{
		var divObjSrc = document.getElementById('newDetailDiv')
		var divObjDest = document.getElementById('addDetailPlaceHolder')
		divObjDest.innerHTML = divObjSrc.innerHTML
		var divObj = document.getElementById('addDetailButton')
		divObj.style.display = "none"	
	}

	function addPremiumMaster() {
		var groupId = "${groupMasterInstance?.groupId}";
		var groupDBId = "${groupMasterInstance?.groupDBId}";
		var appName = "${appContext.metadata['app.name']}";
		
		window.location.assign("/"+appName+"/groupMaintenance/addPremiumMaster?groupId="
				+ groupId + "&grouEditType=DETAIL&groupDBId="+groupDBId);
	}
	
	function findPlanRider(count) {
		var recordTypeObj = document.getElementById("detail."+count+".recordType");
		recordType = recordTypeObj.value;
		//alert ("recordType " + recordType )
		var planCdoClass;
		var planCdoColumnName;
		
		if(recordType == 'P') {
			planCdoClass = 'com.perotsystems.diamond.dao.cdo.PlanMaster';
			planCdoColumnName =  'planCode';
		} else {
			planCdoClass = 'com.perotsystems.diamond.dao.cdo.RiderMaster';
			planCdoColumnName =  'riderCode';				
		}		
		//alert (" planCdoClass" +planCdoClass +" planCdoColumnName = "+planCdoColumnName)
		lookup("detail."+count+".planRiderCode", planCdoClass ,planCdoColumnName, null, null, null, null);
	}

	function populateProductType(count) {
		 var planCode = document.getElementById("detail."+count+".planRiderCode").value;
		 var recordTypeObj = document.getElementById("detail."+count+".recordType");
		 recordType = recordTypeObj.value;
		 
		 if(recordType == 'P') {
		
			 var productType = jQuery.ajax({
				url : '<g:createLinkTo dir="/groupMaintenance/ajaxPopulateProductType"/>',				
				type : "POST",
				data : {planRiderCode:planCode},
				success : function(result) {
					document.getElementById("productType" + count).value=result
					var index = result.indexOf("-")
					var prodType = result.substr(0 , index).trim()
					if(prodType != null && (prodType == 'SPLSL' || prodType == 'LIFE' || prodType == 'BETL' || prodType == 'SPLDL' || prodType == 'SPLEL')){
						document.getElementById("detail."+count+".giaAmount").disabled="";
					}
					else{
						document.getElementById("detail."+count+".giaAmount").disabled="disabled";
						}
				}
			});
		}
	}

	function populateCompanyCode(count) {
		 var glRefCode = document.getElementById("detail."+count+".glRefCode").value;
		 if(glRefCode) {		
			 var companyCode = jQuery.ajax({
				url : '<g:createLinkTo dir="/groupMaintenance/ajaxPopulateCompanyCode"/>',				
				type : "POST",
				data : {glRefCode:glRefCode},
				success : function(result) {
					document.getElementById("detail."+count+".companyCode").value=result
					if(result != null){
						document.getElementById("detail."+count+".companyCode").disabled="";
					}
					else{
						document.getElementById("detail."+count+".companyCode").disabled="disabled";
						}
				}
			});
		}
	}

	function enableGIAAmount(count){
		var productType = document.getElementById("productType"+count).value;
		if(productType != null){
			var index = productType.indexOf("-")
			productType = productType.substr(0 , index).trim()
			}
		if(productType != null && (productType == 'SPLSL' || productType == 'LIFE' || productType == 'BETL' || productType == 'SPLDL' || productType == 'SPLEL')){
			document.getElementById("detail."+count+".giaAmount").disabled="";
		}
		else{
			document.getElementById("detail."+count+".giaAmount").disabled="disabled";
			}
		}

	function toggleDIV(countt){
		 var recordType = document.getElementById("detail."+countt+".recordType").value;
			 	 
		 if(recordType != null && recordType.length > 0){
			 if(recordType == 'P') {			 
				$('#riderCodeDiv' + countt).hide();
				$('#planCodeDiv' + countt).show();				 
			} else {
				$('#riderCodeDiv' + countt).show();
				$('#planCodeDiv' + countt).hide();				
			}
		 } else {
				$('#riderCodeDiv' + countt).show();
				$('#planCodeDiv' + countt).hide();				
		}
	}
	function isMultiPlanEnabled(count) {
		 var lob = document.getElementById("detail."+count+".lineOfBusiness").value;
		 
		 if(lob != null) {
		 
				var multiplan = jQuery.ajax({
				url : '<g:createLinkTo dir="/groupMaintenance/ajaxGetMultiplanValue"/>',				
				type : "POST",
				data : {lob:lob},
				success : function(result) {
					if(result != null && (result == "" || result == "N")){
						document.getElementById("detail."+count+".multiPlanEnroll").value="N"
						document.getElementById("detail."+count+".multiPlanEnroll").setAttribute("readonly", true);
						}
					else if(result != null && result == "Y"){
						document.getElementById("detail."+count+".multiPlanEnroll").removeAttribute("readonly");
						}
				}
			});
		}
		 else{
			 document.getElementById("detail."+count+".multiPlanEnroll").value="N"
			 document.getElementById("detail."+count+".multiPlanEnroll").setAttribute("readonly", true);
			 }
	}
	function gotoSearch() {
		var appName = "${appContext.metadata['app.name']}";
		window.location.assign("/"+appName+"/groupMaintenance/list");
	}
	</script> 
	<head>
<script>
function editpremiumMaster(address){
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
          $('#DataTable').append('<tr id="EmptyTable"><td colspan="8">There are no records to display</td></tr>');
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
        

		var prmastersSize = ${groupMasterInstance?.premiumMasters?.size()};	
		for (var i = 0; i < prmastersSize; i++) { 			
			toggleDIV(i);
		}
		
		$('.BtnCollapseRow').hide().removeClass('hidden');	

	      // Edit icon on table row
	         $('.tablesorter').delegate('.BtnEditRow, .BtnCollapseRow', 'click' ,function(e){
	          // e.preventDefault();  
	           var parentTR = $(this).closest('tr');
	           $(parentTR).find('.BtnEditRow, .BtnCollapseRow').toggle();
	           $(parentTR).nextUntil('tr:not(.tablesorter-childRow)').find('td').toggle();
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
	         $( "#EffectiveDate, #TermDate, #EffectiveDate2, #TermDate2" ).datepicker({
	               numberOfMonths: 1,
	               showOn: "button",
	               buttonText: "<i class='fa fa-calendar'></i>",
	             });
	         
	             $(".fms_mask_money").maskMoney({prefix:'', allowNegative: true, thousands:',', decimal:'.', affixesStay: false});
	             $(".fms_mask_money").css('text-align', 'right');
		});

</script>
</head>

<g:hiddenField name="groupId" value="${groupMasterInstance?.groupId}" />
<g:hiddenField name="groupDBId" value="${groupMasterInstance?.groupDBId}" />
<!-- START - FMS Content Body -->
	<div id="fms_content_body">
	<div class="right-corner" align="right">GRUPD</div>
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
			
			<g:checkURIAuthorization uri="/groupMaintenance/premiumMasterForm">
			<h2>Detail Records  
				<button 
					type="button" 
					class="btn btn-primary btn-sm" 
					title="Click to add a new detail." 
					onClick="addPremiumMaster()">
						<i class="fa fa-plus"></i> 
					New Detail
				</button>
			</h2>
			</g:checkURIAuthorization>
			
		</div>
		<!-- START - Data Table Section -->	
		<div class="fms_required_legend fms_required">= required</div>
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
                 		<th class="{sorter: false} tablesorter-header sorter-false" data-column="1" data-columnselector="disable" aria-disabled="true">Type</th>
		            	<th class="{sorter: false} tablesorter-header sorter-false" data-column="1" data-columnselector="disable" aria-disabled="true">Plan/Rider Code</th>
		           		<th class="{sorter: false} tablesorter-header sorter-false" data-column="1" data-columnselector="disable" aria-disabled="true">Effective Date</th>
		            	<th class="{sorter: false} tablesorter-header sorter-false" data-column="1" data-columnselector="disable" aria-disabled="true">End Date</th>
		            	<th class="{sorter: false} tablesorter-header sorter-false" data-column="1" data-columnselector="disable" aria-disabled="true">Benefit Package</th>
		            	<th class="{sorter: false} tablesorter-header sorter-false" data-column="1" data-columnselector="disable" aria-disabled="true">Line of Business</th>
		            	<th class="{sorter: false} tablesorter-header sorter-false" data-column="1" data-columnselector="disable" aria-disabled="true">Record Status</th>
		            	<th class="{sorter: false} tablesorter-header sorter-false" data-column="1" data-columnselector="disable" aria-disabled="true">Actions</th>
		                </tr>
               		</thead>
               		<tfoot></tfoot>
		
					<tbody aria-live="polite" aria-relevant="all"> 
					<g:each in="${groupMasterInstance.premiumMasters}" status="i" var="premiumMasterVar">
					<input type="hidden" name="seq_prem_id_${i}" value="${premiumMasterVar.seqPremId }">
					<input type="hidden" name="detail.${i}.iterationCount" value="${i}">
					
					<tr id="Row2" role="row" class="tablesorter-hasChildRow" style="">
					
					<td>${'P'.equals(premiumMasterVar.recordType) ? 'Plan' : 'Rider'}</td>
					<td>${premiumMasterVar.planRiderCode}</td>
					<td><g:formatDate format="yyyy-MM-dd" date="${premiumMasterVar.effectiveDate}" /></td>
					<td><g:formatDate format="yyyy-MM-dd" date="${premiumMasterVar.endDate}" /></td>
					<td>${premiumMasterVar.benefitPackageId}</td>
					<td>${premiumMasterVar.lineOfBusiness}</td>
					<td>${premiumMasterVar.recordStatus}</td>
					<td>
						<button class="btn fms_btn_icon btn-sm BtnEditRow" type="button" title="Click to edit or view this row."><span class="glyphicon glyphicon-pencil"></span></button>
                        <button class="btn fms_btn_icon btn-sm BtnCollapseRow hidden" type="button" title="Click to collapse this row."><span class="glyphicon glyphicon-collapse-up"></span></button>
					</td>
					</tr>
					
					<tr id="Row2Child" class="tablesorter-childRow" role="row">
					<td colspan="8" id="detail.${i}.iterationCount".toggleFields" class="" style="display:none;">
						<!-- START - WIDGET: General Information -->
						<div class="fms_widget">        
								<fieldset>
									<legend><h3>Specifications</h3></legend>
									<div class="fms_form_layout_2column">                  
										<div class="fms_form_column fms_long_labels">							
							
											<label for="rcdType" class="control-label fms_required" id="rcdType_label"> 
												<g:message code="premiumMaster.recordType.label" default="Record Type :" />
											</label>
											<div class="fms_form_input">
											 		<g:secureDiamondDataWindowDetail columnName="record_type"
														tableName="PREMIUM_MASTER" attributeName="recordType"
														dwName="dw_grupd_de" languageId="0"
														htmlElelmentId="detail.${ i }.recordType"
														defaultValue="${premiumMasterVar?.recordType}"
														blankValue="Record Type"
														value ="${premiumMasterVar?.recordType}"
														disable="true"
														onchange="toggleDIV(${i})"
														cssClass="form-control"
														aria-labelledby="rcdType_label" 
														aria-describedby="rcdType_error" 
														aria-required="false"/>
													<div class="fms_form_error" id="rcdType_error"></div>
											</div> 
											
											<label for="planRiderCode" class="control-label fms_required" id="planRiderCode_label"> 
												<g:message	code="premiumMaster.planRiderCode.label" default="Plan/Rider Code :" />
											</label>	
											<div class="fms_form_input fms_has_feedback">
											<input type="hidden" name="${ i }.recordType" id="det${ i }.recordType" value="${premiumMasterVar?.recordType}"/>
													<g:secureTextField
														name="detail.${ i }.planRiderCode" 
														tableName="PREMIUM_MASTER" attributeName="planRiderCode"
														value="${premiumMasterVar?.planRiderCode}" maxlength="50"
														onchange="upperMe(${i}), populateProductType(${i})" onblur = "populateProductType(${i})"
														class="form-control" aria-labelledby="planRiderCode_label" 
														aria-describedby="planRiderCode_error" aria-required="false">
													</g:secureTextField>
													<div id="planCodeDiv${i}">
							                      	 <fmsui:cdoLookup lookupElementId="detail.${ i }.planRiderCode"
							                                       lookupElementName="detail.${ i }.planRiderCode" 
							                                       lookupElementValue="${premiumMasterVar?.planRiderCode}"
							                                       lookupCDOClassName="com.perotsystems.diamond.dao.cdo.PlanMaster" 
							                                       lookupCDOClassAttribute="planCode"
							                                       onclick="findPlanRider(${i})"/>
							                         </div>
							                         <div id="riderCodeDiv${i}" >
							                         <fmsui:cdoLookup lookupElementId="detail.${ i }.planRiderCode"
							                                       lookupElementName="detail.${ i }.planRiderCode" 
							                                       lookupElementValue="${premiumMasterVar?.planRiderCode}"
							                                       lookupCDOClassName="com.perotsystems.diamond.dao.cdo.RiderMaster" 
							                                       lookupCDOClassAttribute="riderCode"
							                                       onclick="findPlanRider(${i})"/>
							                         </div>
													 <div class="fms_form_error" id="planRiderCode_error"></div>
											  </div> 
												
											<label for="lineOfBusiness" class="control-label fms_required" id="lineOfBusiness_label">
												<g:message code="premiumMaster.lineOfBusiness.label" default="Line Of Business :" /> 
											</label>
											<div class="fms_form_input fms_has_feedback">
													<g:secureTextField 
														name="detail.${ i }.lineOfBusiness" 
														tableName="PREMIUM_MASTER" attributeName="lineOfBusiness"
														value="${premiumMasterVar?.lineOfBusiness}"
														onchange="upperMe(${i}), isMultiPlanEnabled(${i})" onblur = "isMultiPlanEnabled(${i})"
														class="form-control" aria-labelledby="lineOfBusiness_label" 
														aria-describedby="lineOfBusiness_error" aria-required="false">
													</g:secureTextField>
										           <fmsui:cdoLookup lookupElementId="detail.${ i }.lineOfBusiness"
										                            lookupElementName="detail.${ i }.lineOfBusiness"
										                            lookupElementValue="${premiumMasterVar?.lineOfBusiness}"
										                            lookupCDOClassName="com.perotsystems.diamond.dao.cdo.LineOfBusinessMaster"
										                            lookupCDOClassAttribute="lineOfBusiness"/>
													<div class="fms_form_error" id="lineOfBusiness_error"></div>
													
												</div>
										
											<label for="effectiveDate" class="control-label fms_required" id="effectiveDate_label"> 
												<g:message code="premiumMaster.effectiveDate.label"	default="Effective Date :" /> 
											</label> 
											<div class="fms_form_input">
											<g:securejqDatePickerUIUX
													tableName="PREMIUM_MASTER" attributeName="effectiveDate" 
													dateElementId="detail.${ i }.effectiveDate"
													dateElementName="detail.${ i }.effectiveDate" mandatory="mandatory"
													datePickerOptions="changeMonth: true, changeYear: true, yearRange: '${((premiumMasterVar?.effectiveDate != null ? premiumMasterVar?.effectiveDate.get(Calendar.YEAR):Calendar.getInstance().get(Calendar.YEAR)) - 100)} : ${((premiumMasterVar?.effectiveDate != null ? premiumMasterVar?.effectiveDate.get(Calendar.YEAR):Calendar.getInstance().get(Calendar.YEAR)) + 100)}', numberOfMonths: 1"
													dateElementValue="${formatDate(format:'MM/dd/yyyy',date: premiumMasterVar?.effectiveDate)}" 
													ariaAttributes="aria-labelledby='effectiveDate_label' aria-describedby='effectiveDate_error' aria-required='false'" 
							                        classAttributes ="class='form-control fms_date_mask fms_small_input onDelete hasDatepicker' "
													showIconDefault="${isShowCalendarIcon}"/>                                   
							                        <div class="fms_form_error" id="effectiveDate_error"></div>
											</div>
											
											<label for="endDate" class="control-label" id="endDate_label"> 
												<g:message code="premiumMaster.endDate.label" default="Term Date :" />
											</label>
											
											<div class="fms_form_input">
											<g:securejqDatePickerUIUX
													tableName="PREMIUM_MASTER" attributeName="endDate"
													dateElementId="detail.${ i }.endDate"
													dateElementName="detail.${ i }.endDate" mandatory="mandatory"
													datePickerOptions="changeMonth: true, changeYear: true, yearRange: '${((premiumMasterVar?.endDate != null ? premiumMasterVar?.endDate.get(Calendar.YEAR):Calendar.getInstance().get(Calendar.YEAR)) - 100)} : ${((premiumMasterVar?.endDate != null ? premiumMasterVar?.endDate.get(Calendar.YEAR):Calendar.getInstance().get(Calendar.YEAR)) + 100)}', numberOfMonths: 1"
													dateElementValue="${formatDate(format:'MM/dd/yyyy',date: premiumMasterVar?.endDate)}" 
													ariaAttributes="aria-labelledby='endDate_label' aria-describedby='endDate_error' aria-required='false'" 
							                        classAttributes ="class='form-control fms_date_mask fms_small_input onDelete hasDatepicker' "
							                        showIconDefault="${isShowCalendarIcon}"/>	                                  
							                        <div class="fms_form_error" id="endDate_error"></div>
											</div>
											
											<label for="termReason" class="control-label" id="termReason_label">
												<g:message code="premiumMaster.termReason.label" default="Term Reason :" />
											</label>
											
											<div class="fms_form_input fms_has_feedback">
												<input type="hidden" name="TermReasonType" id="TermReasonType" value="TM"/>
												<g:secureTextField 
													name="detail.${ i }.termReason"
													tableName="PREMIUM_MASTER" attributeName="termReason"
													value="${premiumMasterVar?.termReason}" maxlength="5"
													class="form-control" aria-labelledby="termReason_label" 
													aria-describedby="termReason_error" aria-required="false">
												</g:secureTextField>
													<fmsui:cdoLookup lookupElementId="detail.${ i }.termReason"
							                                         lookupElementName="detail.${ i }.termReason"
							                                         lookupElementValue="${premiumMasterVar?.termReason}"
							                                         lookupCDOClassName="com.perotsystems.diamond.dao.cdo.ReasonCodeMaster"
							                                         lookupCDOClassAttribute="reasonCode"
							                                         htmlElementsToAddToQuery="TermReasonType"
																	 htmlElementsToAddToQueryCDOProperty="reasonCodeType"/>	
													<div class="fms_form_error" id="termReason_error"></div>
											</div> 
											
											<label for="glRefCode" class="control-label " id="glRefCode_label">
												<g:message code="premiumMaster.glRefCode.label"	default="G/L Ref Code  :" />
											</label>
											
											<div class="fms_form_input fms_has_feedback">
												<g:secureTextField name="detail.${ i }.glRefCode" 
									 								tableName="PREMIUM_MASTER" attributeName="glRefCode" 
									 								onchange="upperMe(${i}), populateCompanyCode(${i})" 
									 								onblur = "populateCompanyCode(${i})" value="${premiumMasterVar?.glRefCode}" 
																	class="form-control" aria-labelledby="glRefCode_label" 
																	aria-describedby="glRefCode_error" aria-required="false">
												</g:secureTextField>
													<fmsui:cdoLookup lookupElementId="detail.${ i }.glRefCode"
							                                         lookupElementName="detail.${ i }.glRefCode"
							                                         lookupElementValue="${premiumMasterVar?.glRefCode}"
							                                         lookupCDOClassName="com.perotsystems.diamond.dao.cdo.GeneralLedgerReference"
							                                         lookupCDOClassAttribute="glRefCode"/>	
													<div class="fms_form_error" id="glRefCode_error"></div>
											</div> 
											
											<label for="companyCode" class="control-label " id="companyCode_label">
												<g:message code="premiumMaster.companyCode.label"	default="Company Code  :" />
										</label>
										<div class="fms_form_input fms_has_feedback">
												<g:secureTextField name="detail.${ i }.companyCode" readOnly="true" style="color: #48802C"
									 								tableName="PREMIUM_MASTER" attributeName="companyCode"
									 								value="${premiumMasterVar?.companyCode}"  
																	class="form-control" aria-labelledby="companyCode_label" 
																	aria-describedby="companyCode_error" aria-required="false">
												</g:secureTextField>
													<fmsui:cdoLookup lookupElementId="detail.${ i }.companyCode"
							                                         lookupElementName="detail.${ i }.companyCode"
							                                         lookupElementValue="${premiumMasterVar?.companyCode}"
							                                         lookupCDOClassName="com.perotsystems.diamond.dao.cdo.CompanyMaster"
							                                         lookupCDOClassAttribute="companyCode"/>	
													<div class="fms_form_error" id="companyCode_error"></div>
											</div> 
											
										</div>
										<div class="fms_form_column fms_long_labels">
											
											<label for="renewalDate" class="control-label" id="renewalDate_label">
												<g:message code="premiumMaster.renewalDate.label" default="Renew Date :" />
											</label>
											
											<div class="fms_form_input">
											<g:securejqDatePickerUIUX
													tableName="PREMIUM_MASTER" attributeName="renewalDate"
													dateElementId="detail.${ i }.renewalDate"
													dateElementName="detail.${ i }.renewalDate" mandatory="mandatory"
													datePickerOptions="changeMonth: true, changeYear: true, yearRange: '${((premiumMasterVar?.renewalDate != null ? premiumMasterVar?.renewalDate.get(Calendar.YEAR):Calendar.getInstance().get(Calendar.YEAR)) - 100)} : ${((premiumMasterVar?.renewalDate != null ? premiumMasterVar?.renewalDate.get(Calendar.YEAR):Calendar.getInstance().get(Calendar.YEAR)) + 100)}', numberOfMonths: 1"
													dateElementValue="${formatDate(format:'MM/dd/yyyy',date: premiumMasterVar?.renewalDate)}" 
													ariaAttributes="aria-labelledby='renewalDate_label' aria-describedby='renewalDate_error' aria-required='false'" 
							                        classAttributes ="class='form-control fms_date_mask fms_small_input onDelete hasDatepicker' "
							                        showIconDefault="${isShowCalendarIcon}"/>	                                  
							                        <div class="fms_form_error" id="renewalDate_error"></div>
											</div>
											
											<label for="productType${ i }" class="control-label" id="productType_label"> 
												<g:message code="planMaster.productType.label" default="Product Type :" />
											</label>
											<div class="fms_form_input">
												<g:textField  
													class="form-control"
													readOnly="true"
													name="productType${ i }"  
													value="${productTypesMap?.get(premiumMasterVar?.planRiderCode)}" />
												<div class="fms_form_error" id="productType_error"></div>
											</div>
											
											<label for="multiPlanEnroll" class="control-label fms_required" id="multiPlanEnroll_label">
												<g:message code="premiumMaster.multiPlanEnroll.label" default="Multi Plan Enroll :" />
											</label>
											<div class="fms_form_input">
												<g:secureTextField 
													class="form-control"
													maxlength="1" name="detail.${ i }.multiPlanEnroll"
													tableName="PREMIUM_MASTER" attributeName="multiPlanEnroll"
													value="${premiumMasterVar?.multiPlanEnroll}" 
													title = "Enter N to prevent enrollment in multiple plans with the same product type; or Y to allow">
												</g:secureTextField>
												<div class="fms_form_error" id="multiPlanEnroll_error"></div>
												
											</div> 
											<script type="text/javascript">isMultiPlanEnabled(${i})</script>
											<label for="recordStatus" class="control-label" id="recordStatus_label"> 
												<g:message code="premiumMaster.recordStatus.label" default="Record Status :" />
											</label>
										<div class="fms_form_input">
											<g:secureTextField 
													class="form-control" maxlength="15" 
													name="detail.${ i }.recordStatus"
													tableName="PREMIUM_MASTER" attributeName="recordStatus"
													value="${premiumMasterVar?.recordStatus}" >
											</g:secureTextField>
											<div class="fms_form_error" id="recordStatus_error"></div>
										</div>
										
										<label for="giaAmount" class="control-label" id="giaAmount_label"> 
											<g:message code="premiumMaster.giaAmount.label" default="GIA Amount :" />
										</label>
										<div class="fms_form_input fms_has_feedback_money">
							            <span class="fms_form_control_dollar"></span>
											<g:secureTextField 
													name="detail.${ i }.giaAmount" disabled = "disabled" class="form-control fms_small_input fms_mask_money" maxlength="21"
													tableName="PREMIUM_MASTER" attributeName="giaAmount"
													value="${formatNumber(number: premiumMasterVar?.giaAmount, format: '#####0.00')}" 
													title = "Enter GIA amount for life insurance policies"
													aria-labelledby="giaAmount_r1_label" aria-describedby="giaAmount_r1_error" aria-required="false" placeholder="0.00" ></g:secureTextField>
												<div class="fms_form_error" id="giaAmount_error"></div>
										</div>
									
										<label for="convYearStartDate" class="control-label" id="convYearStartDate_label"> 
											<g:message code="premiumMaster.convYearStartDate.label"	default="Cont Yr Start Date :" /> 
										</label>
										<div class="fms_form_input">	
											<g:securejqDatePickerUIUX
												tableName="PREMIUM_MASTER" attributeName="convYearStartDate"
												dateElementId="detail.${ i }.convYearStartDate"
												dateElementName="detail.${ i }.convYearStartDate"
												datePickerOptions="changeMonth: true, changeYear: true, yearRange: '${((premiumMasterVar?.convYearStartDate != null ? premiumMasterVar?.convYearStartDate.get(Calendar.YEAR):Calendar.getInstance().get(Calendar.YEAR)) - 100)} : ${((premiumMasterVar?.convYearStartDate != null ? premiumMasterVar?.convYearStartDate.get(Calendar.YEAR):Calendar.getInstance().get(Calendar.YEAR)) + 100)}', numberOfMonths: 1"
												dateElementValue="${formatDate(format:'MM/dd/yyyy',date: premiumMasterVar?.convYearStartDate)}"
												ariaAttributes="aria-labelledby='convYearStartDate_label' aria-describedby='convYearStartDate_error' aria-required='false'" 
								                classAttributes ="class='form-control fms_date_mask fms_small_input onDelete hasDatepicker' "
								                showIconDefault="${isShowCalendarIcon}"/>	                                  
								                <div class="fms_form_error" id="convYearStartDate_error"></div>
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
	
		<div id=addDetailPlaceHolder></div>
 </div>