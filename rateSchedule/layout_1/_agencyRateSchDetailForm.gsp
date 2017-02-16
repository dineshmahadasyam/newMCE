<%@ page import="com.perotsystems.diamond.bom.AgencyRateScheduleDtl"%>

<g:set var="appContext" bean="grailsApplication"/>

<script type="text/javascript" src="${resource(dir: 'js', file: 'jquery.alphanum.js')}"></script>
<script type="text/javascript" src="${resource(dir: 'js', file: 'jquery.validate.js')}"></script>
<script type="text/javascript" src="${resource(dir: 'js', file: 'commonfunctions.js')}"></script>
<script src="${resource(dir: '/js/layout_1_scripts', file: 'jquery.maskMoney.js')}" ></script>

<script type="text/javascript">

	function isNumberKey(evt)
    {
		var charCode = (evt.which) ? evt.which : event.keyCode
		         if (charCode > 31 && (charCode < 48 || charCode > 57))
		            return false;

		         return true;
    }
	
</script>

<script type="text/javascript">

	$(document).ready(function() {
	
		<g:if test="${'DETAIL'.equals(params.editType)}">
		jQuery.validator.addMethod("thresholdRangeFrom", function(value, element) {
			return this.optional(element) || /^[0-9 ]+$/i.test(value);
		}, "Please enter whole numbers only for member from threshold");
		
		jQuery.validator.addMethod("thresholdRangeThru", function(value, element) {
			return this.optional(element) || /^[0-9 ]+$/i.test(value);
		}, "Please enter whole numbers only for member thru threshold");
	
		 $(".amtNumeric").numeric({});
		 
			jQuery.validator.setDefaults({
				  debug: true,
					ignore: []
				});
	
			$(function() {	
				$('#agencyRateSchDetailForm').validate({
					onfocusout: false,
					submitHandler: function (form) {
						  if ($(form).valid()) 
		                      form.submit(); 
		                  return false; // prevent normal form posting
			    },
	
			  	//jQuery validate selects the first invalid element or the last focused invalid element
		        //The code below will set focus to first element that fails
		        invalidHandler: function(form, validator) {
		            var errors = validator.numberOfInvalids();
		            if (errors) {   
		            	 //Hide any previous message from the server when the client validation is occuring
		            	$(".message").hide();                 
		                validator.errorList[0].element.focus();
		            }
		        },
	
			    errorLabelContainer: "#errorDisplay", 
				wrapper: "li",		
				rules : {
	
					<g:each in="${rateSchHdrInstance?.agencyRateSchDtls}" var="agencyRateSchDtl" status="i">
							 'agencyRateSchDtl.${i}.rateType' : {
									required : true,
							},
							'agencyRateSchDtl.${i}.rateAmount' : {
								required : true,
							},
							'agencyRateSchDtl.${i}.thresholdRangeFrom' : {
								required : true,
								thresholdRangeFrom : true,
								number:true,
							},
							'agencyRateSchDtl.${i}.thresholdRangeThru' : {
								thresholdRangeThru : true,
								number:true,
							},
								
					</g:each>
				},
					messages : {
					<g:each in="${rateSchHdrInstance?.agencyRateSchDtls}" var="agencyRateSchDtl" status="i">
							'agencyRateSchDtl.${i}.rateType' : {
								required : "Please enter Rate Type",
						},
						'agencyRateSchDtl.${i}.rateAmount' : {
							required : "Please enter Rate Amount",
						},
						'agencyRateSchDtl.${i}.thresholdRangeFrom' : {
							required : "Please enter Threshold From",
							thresholdRangeFrom : "Please enter whole numbers only for member from threshold",
						},
						'agencyAddress.${i}.thresholdRangeThru' : {
							thresholdRangeThru : "Please enter whole numbers only for member Thru threshold"
						},
					</g:each>				
				} 
	
				}) //validate End Tag
				
			}); //Function End Tag
			
		</g:if>
			
	}); //document ready end tag

</script>

<script type="text/javascript">
	function deleteAllocation(seqId){
		document.getElementById('deleteThisDtlRecord').value = seqId
		document.getElementById('BtnInfoAlertId5').click();
		
		
	}
	function gotoSearch() {
		var appName = "${appContext.metadata['app.name']}";
		window.location.assign("/"+appName+"/rateSchedule/list");
	}
	
	function addRateSchDtlRecord(){
		var appName = "${appContext.metadata['app.name']}";
		var myFm = document.getElementById("agencyRateSchDetailForm") ; 		
		myFm.action = "/"+appName+"/rateSchedule/addRateSchDtlRec";     	
		$('#agencyRateSchDetailForm').submit();
		
	}
	
	function isNumberKey(evt) {
	    var charCode = (evt.which) ? evt.which : event.keyCode
	    if (charCode > 31 && (charCode < 48 || charCode > 57)) {
	       // alert("Please Enter Only Numeric Value");
	       	document.getElementById('BtnInfoAlertADD1').click();
	        return false;
	    }
	
	    return true;
	} 
	
	function isNumberKeyforRateAmount(evt) {
		var charCode = (evt.which) ? evt.which : event.keyCode;
	    if (charCode == 46 && evt.srcElement.value.split('.').length>1) {
	    	//alert("Please enter numbers and decimal only for Rate Amount");
	    	document.getElementById('BtnInfoAlertADD').click();
	        return false;
	    }
	    if (charCode != 46 && charCode > 31 && (charCode < 48 || charCode > 57)){
	    	//alert("Please enter numbers and decimal only for Rate Amount");
	    	document.getElementById('BtnInfoAlertADD').click();
	    	return false;
	        }
	        
	    return true;
	} 
	
	function displaySymbol(count){
		var overrideAmtTypeId = document.getElementById("agencyRateSchDtl."+ count +".rateType").value;
		
		if(overrideAmtTypeId != null){
			if(overrideAmtTypeId == "%PREM"){
				document.getElementById(count+".currSymbol").value = "%"
				}
			else if(overrideAmtTypeId == ""){
				document.getElementById(count+".currSymbol").value = ""
			}
			else {
				document.getElementById(count+".currSymbol").value = "$"
			}
			
		}
	}
	$(".fms_mask_money").maskMoney({prefix:'', allowNegative: true, thousands:'', decimal:'.', affixesStay: false});
	$(".fms_mask_money").css('text-align', 'right');
</script>

<script type="text/javascript">

	$(document).ready(function() {

		// If all rows are deleted show message
        if ($('#DataTable td').length <= 0) {
            $('#BtnSaveModal').attr('disabled', 'disabled');
            $('#BtnUndoModal').attr('disabled', 'disabled');
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

        
	
		$('.btnInfoAlertADD').hide();  
		$('.btnInfoAlertADD').click(function(e){ 
	    	$('#InfoAlertADD').modal('show');
	    });
	 	$('#InfoAlertADD').modal({
	    	backdrop: 'static',
	       show: false
	   	});
	
	 	$('.btnInfoAlertADD1').hide();  
		$('.btnInfoAlertADD1').click(function(e){ 
	    	$('#InfoAlertADD1').modal('show');
	    });
	 	$('#InfoAlertADD1').modal({
	    	backdrop: 'static',
	       show: false
	   	});
		
		$('.BtnDeleteRow').hide();  
		
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
              var myFm = document.getElementById("agencyRateSchDetailForm") ; 		
	           myFm.action = "/"+appName+"/rateSchedule/deleteRateSchDtlRec";     	
	           myFm.submit();
	       });
	   // Save button 
          
	      // Save Modal
	      $('#BtnSaveModal').click(function(e){
	        var appName = "${appContext.metadata['app.name']}";
            var myFm = document.getElementById("agencyRateSchDetailForm") ; 			
            myFm.action = "/"+appName+"/rateSchedule/update";     	
            $('#agencyRateSchDetailForm').submit();

            
	      });

	      // Undo button
	     
	      $('.BtnUndoModal').click(function(e){
	        //e.preventDefault(); 
	        this.form.reset();
	        resetForm();           
	      });
	      		      
	 });

</script>

<style>

      #rateScheduleSearch .table-responsive {padding-bottom: 10px; margin-bottom: 10px; border: 0 !important;}
      #rateSchedule {width: 100%; margin-bottom: 2%;}         
      #rateSchedule td {padding: 0px 6px 16px 6px; display: block; text-align: left;}
      #rateSchedule label.control-label {display: block; width: 128px; text-align: left;}
      #rateSchedule .form-control {display: block; min-width: 200px; width: 100%; padding-left: 8px; padding-right: 8px;}  
      #rateSchedule select.form-control {min-width: auto; width: auto;}    

    @media only screen and (min-width : 800px) {
      #rateSchedule {width: 100%;}      
      #rateSchedule td {width: 100%;}
      #rateSchedule label.control-label {display: inline-block; width: 128px; text-align: left;}
      #rateSchedule .form-control {display: inline-block; min-width: 120px; width: 60%;}      
    }


    @media only screen and (min-width : 1079px) {
      #rateSchedule {min-width: 800px;}      
      #rateSchedule td {width: 33%; display: inline-block; clear: both;}
      #rateSchedule label.control-label {float: left; width: 38%; margin-right: 2%; padding-top: 7px; text-align: right;}
      #rateSchedule .form-control {display: inline-block; float: left; width: 60%; }      
    }

</style>

<input type="hidden" name="editType" value="DETAIL" />
<input type="hidden" name="seqRateId" value="${rateSchHdrInstance?.seqRateId }" />
<input type="hidden" name="detailRecordCount" value = "${detailRecordCount}"/>

<g:hiddenField name="deleteThisDtlRecord" value=""/>

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
	<div class="right-corner" align="right">COMMR</div>
    <table id="rateSchedule">
        <tbody>
          <tr>
          	<td>
             	<label id="rateId_label" for="rateId" class="control-label"> 
             		<g:message code="agency.rateId.label" default="Rate ID :" />
				</label> 
				<g:secureTextField name="rateId" value="${rateSchHdrInstance?.rateId}" readonly="readonly"
									maxlength="50" tableName="AGENCY_RATE_SCHEDULE_HDR"
									attributeName="rateId" id="rateId"
									title="The unique Rate ID for the rate schedule"
									class="form-control" aria-labelledby="rateId_label" aria-describedby="rateId_error" aria-required="false">
				</g:secureTextField>
				<div class="fms_form_error" id="rateId_error"></div>
			</td>
            <td>
            	<label id="description_label" for="description" class="control-label"> 
            		<g:message code="agency.description.label" default="Description :" />
				</label> 
				<g:secureTextField name="description" value="${rateSchHdrInstance?.description}" readonly="readonly" 
								   maxlength="60" tableName="AGENCY_RATE_SCHEDULE_HDR" attributeName="description" id="description" 
								   title="The Description of the Rate schedule"
								   class="idDescription form-control" aria-labelledby="description_label" aria-describedby="description_error" aria-required="false">
				</g:secureTextField>
				<div class="fms_form_error" id="description_error"></div>
			</td>
            <td>
            	<label id="retentionPeriod_label" for="retentionPeriod" class="control-label"> 
                	<g:message code="agency.retentionPeriod.label" default="Retention Period:" />
				</label> 
				<g:secureTextField name="retentionPeriod" value="${rateSchHdrInstance?.retentionPeriod}" readonly="readonly"
									maxlength="2" tableName="AGENCY_RATE_SCHEDULE_HDR" attributeName="description" id="retentionPeriod" 
									title = "The Retention Period in days"
								   class="numeric form-control" aria-labelledby="retentionPeriod_label" aria-describedby="retentionPeriod_error" aria-required="false">
				</g:secureTextField>
				<div class="fms_form_error" id="retentionPeriod_error"></div>
            </td> 
            <td></td>   
          </tr>
      	</tbody>
    </table>
	<div id="${rateSchHdrInstance?.seqRateId}">
		<input type="hidden" name="seqRateId" value="${rateSchHdrInstance?.seqRateId}">
		<div id="addRateSchDiv" style="padding-bottom:10px;">
			<table>
				<tr>
					<g:if test="${isEditable}">
						<td id="addDependentTdId" colspan="3"><BR>
							<button class="btn btn-primary btn-sm" onclick="addRateSchDtlRecord()" >Add Row</button> 
						</td>
					</g:if>
				</tr>
			</table>
		</div>
		<div class="fms_required_legend fms_required">= required</div> 
		<div class="row bottom-margin-sm">
			<div class="col-xs-6">
				<button class="btn btn-sm btn-primary" type="button" onclick='gotoSearch()' title="Click to perform a new search.">New Search</button>
			</div>
			<div class="col-xs-6 text-right">
				<button id="BtnSaveModal" class="btn btn-primary btn-sm BtnSaveModal" type="button" title="Click to save all changes."><span class="fa fa-floppy-o"></span> Save All Changes</button>
				<button id="BtnUndoModal" class="btn btn-default btn-sm BtnUndoModal" type="button" title="Click to clear all changes."><span class="glyphicon glyphicon-repeat"></span> Undo All Changes</button>
			</div>
		</div>
		<div class="fms_table_wrapper">
			<table id="DataTable" class="tablesorter tablesorter-fms tablesorterdf6319efcolumnselector" role="grid" aria-describedby="DataTable_pager_info">
              	<thead>
                	<tr role="row" class="tablesorter-headerRow">
                		<th class="{sorter: false} tablesorter-header sorter-false fms_required" data-column="1" data-columnselector="disable" aria-disabled="true">Rate Type</th>
		            	<th class="{sorter: false} tablesorter-header sorter-false fms_required" data-column="2" data-columnselector="disable" aria-disabled="true">Rate Amount </th>
		           		<th class="{sorter: false} tablesorter-header sorter-false fms_required" data-column="3" data-columnselector="disable" aria-disabled="true">Threshold From </th>
		            	<th class="{sorter: false} tablesorter-header sorter-false" data-column="4" data-columnselector="disable" aria-disabled="true">Threshold Thru</th>
		            	<g:if test="${isEditable}">
							<th class="{sorter: false} tablesorter-header sorter-false" data-column="5" data-columnselector="disable" aria-disabled="true">Actions</th>
						</g:if>
	                </tr>
              	</thead>
               	<tfoot></tfoot>
               	<tbody>
					<g:each in="${rateSchHdrInstance?.agencyRateSchDtls }" var="agencyRateSchDtl" status="i">
						<input type="hidden" name="seq_Rate_Sch_Dtl_Id_${i}" value="${agencyRateSchDtl?.seqRateSchDtlId }">
						<input type="hidden" name="agencyRateSchDtl.${i}.iterationCount" value="${i}">
						
						<tr class="${(i % 2) == 0 ? 'even' : 'odd'}">
							<td>
								<div class="fms_form_input">
									<g:secureSystemCodes  onchange="displaySymbol(${i})" onselect="displaySymbol(${i})"
										cssClass="form-control"
										systemCodeType="COMMIS_RATETYPE" languageId="0"
										tableName="AGENCY_RATE_SCHEDULE_DTL" attributeName="rateType" 
										htmlElelmentId="agencyRateSchDtl.${i}.rateType"
										blankValue="Rate Type" 
										defaultValue="${agencyRateSchDtl?.rateType}" 
										width="250px" disable="${isEditable ? ''  : 'disabled'}">
									</g:secureSystemCodes>
								</div>
							</td>
							<td>
								<g:textField name="${i}.currSymbol" id="${i}.currSymbol" value=" "	maxlength="1" readonly="readonly" style="width:15px;border: none;background:none"/>
								<script type="text/javascript">
									displaySymbol(${i});
								</script>
								<g:secureTextField name="agencyRateSchDtl.${i}.rateAmount" maxlength="16" title = "The rate amount" class="form-control fms_small_input fms_mask_money" onkeypress="return isNumberKeyforRateAmount(event)"
										value="${agencyRateSchDtl?.rateAmount}" tableName="AGENCY_RATE_SCHEDULE_DTL" attributeName="rateAmount"
										disabled="${isEditable ? 'false'  : 'disabled'}">
								</g:secureTextField>
							</td>
							<td>
								<g:secureTextField name="agencyRateSchDtl.${i}.thresholdRangeFrom" value="${agencyRateSchDtl?.thresholdRangeFrom}" maxlength="30" 
									tableName="AGENCY_RATE_SCHEDULE_DTL" attributeName="thresholdRangeFrom" class="form-control fms_small_input fms_mask_money" onkeypress="return isNumberKey(event)"
									title= "The Member Threshold from value" disabled="${isEditable ? 'false'  : 'disabled'}">
								</g:secureTextField>
							</td>
							<td>				
								<g:secureTextField name="agencyRateSchDtl.${i}.thresholdRangeThru" value="${agencyRateSchDtl?.thresholdRangeThru}" maxlength="30" 
										tableName="AGENCY_RATE_SCHEDULE_DTL" attributeName="thresholdRangeThru" class="form-control fms_small_input fms_mask_money" onkeypress="return isNumberKey(event)"
										title= "The Member Threshold thru value" disabled="${isEditable ? 'false'  : 'disabled'}"></g:secureTextField>
							</td>
							<g:if test="${isEditable}">
								<td>
									<button id="BtnAddressDelete2" type="button" class="btn fms_btn_icon btn-sm"  title="Click to delete Rate Schedule Detail Record." data-target="#DeleteAlertModal" onclick="deleteAllocation(${i})"><i class="fa fa-trash"></i></button>
									<button id="BtnInfoAlertId5" type="button" class="btn fms_btn_icon btn-sm BtnDeleteRow" data-target="#InfoAlertModal"></button>
									<button id="BtnInfoAlertADD" type="button" class="btn fms_btn_icon btn-sm btnInfoAlertADD" data-target="#InfoAlertADD"><span class="glyphicon glyphicon-repeat"></span></button>
									<button id="BtnInfoAlertADD1" type="button" class="btn fms_btn_icon btn-sm btnInfoAlertADD1" data-target="#InfoAlertADD1"><span class="glyphicon glyphicon-repeat"></span></button>
								</td>
							</g:if>
						</tr>
					</g:each>
				</tbody>
			</table>
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
				<button id="BtnDeleteRowYes" type="button" class="btn btn-primary" data-dismiss="modal">Yes, Delete</button>
			</div>
		</div>
	</div>
</div>
<!-- END - Delete Notice Modal -->

<div class="modal fade" id="InfoAlertADD" tabindex="-1" role="dialog" aria-labelledby="myModalLabel">        
  	<div class="modal-dialog">
       	<div class="modal-content fms_modal_info">
           	<div class="modal-body">
           		<button type="button" class="close" data-dismiss="modal" aria-label="Close"><span aria-hidden="true">&times;</span></button>
           		<h4>Please enter numbers and decimal only for Rate Amount</h4>
            </div>
            <div class="modal-footer">
            	<button type="button" class="btn btn-default" data-dismiss="modal">Ok</button>
          	</div>
      	</div>
  	</div>
</div>

<div class="modal fade" id="InfoAlertADD1" tabindex="-1" role="dialog" aria-labelledby="myModalLabel">        
  	<div class="modal-dialog">
       	<div class="modal-content fms_modal_info">
           	<div class="modal-body">
           		<button type="button" class="close" data-dismiss="modal" aria-label="Close"><span aria-hidden="true">&times;</span></button>
           		<h4>Please Enter Only Numeric Value</h4>
            </div>
            <div class="modal-footer">
            	<button type="button" class="btn btn-default" data-dismiss="modal">Ok</button>
          	</div>
      	</div>
  	</div>
</div>