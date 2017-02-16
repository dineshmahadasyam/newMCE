<%@ page import="com.perotsystems.diamond.bom.AgencyRateScheduleHdr"%>

<script type="text/javascript" src="${resource(dir: 'js', file: 'jquery.validate.js')}"></script>
<script type="text/javascript" src="${resource(dir: 'js', file: 'additional-methods.js')}"></script>	
<script type="text/javascript" src="${resource(dir: 'js', file: 'jquery.alphanum.js')}"></script>

<script type="text/javascript">

	$(function($){
		   
		   $("#idRateId").alphanum({
				allow 		: '-_',
				allowSpace  : false
			});
	
		   $("#idDescription").alphanum({
				allow 		: '-.',
				allowSpace  : true
			});
	
		});
	
	function isNumberKey(evt)
	{
		var charCode = (evt.which) ? evt.which : event.keyCode
	        if (charCode > 31 && (charCode < 48 || charCode > 57))
	           return false;
	        return true;
	}
	function closeForm() {
		window.location.assign('<g:createLinkTo dir="/rateSchedule/list"/>')		
	}

</script>

<script type="text/javascript">

	$(document).ready(function() {
	
		 
			jQuery.validator.setDefaults({
				  debug: true,
					ignore: []
				});
	
			$(function() {	
				$('#agencyRateScheduleForm').validate({
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
	
					 'calcType' : {
							required : true,
					}
								
				},
				messages : {
					'calcType' : {
						required : "Please enter Calc Type",
					}
				} 
	
				}) //validate End Tag
				
			}); //Function End Tag
			
			
	}); //document ready end tag
</script>
<script type="text/javascript">

	$(document).ready(function() {
	
		$('.BtnDeleteRow').click(function(e){
	             $('#DeleteAlertModal').modal('show');
	         });
	      $('#DeleteAlertModal').modal( {
		      backdrop: 'static',
		       show: false 
		  });
	      $("#BtnDeleteRowYes").click(function(e){		         
	               var appName = "${appContext.metadata['app.name']}";
	               var myFm = document.getElementById("agencyRateScheduleForm") ; 			
	               myFm.action = "/"+appName+"/rateSchedule/delete"; 
	               myFm.submit();
	           
	  		});
	});

</script>

<!-- START - FMS Content Body -->
<input type="hidden" name="editType" value="MASTER" />
<input type="hidden" name="seqRateId" value="${rateSchHdrInstance?.seqRateId }" />
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
	<div class="fms_required_legend fms_required">= required</div>           
	<div id="AddNewDataSection" class="fms_form_border" style="display: block;">
    	<div class="fms_form_body fms_widget_border fms_widget_bgnd-color">
			<div class="fms_widget">
				<fieldset class="no_border">
					<div class="fms_form_layout_2column">                  
						<div class="fms_form_column fms_long_labels">
							<label class="control-label fms_required" for="rateId" id="rateId_label"> 
								<g:message code="rateSchHdrInstance.rateId.label" default="Rate ID :" />
							</label>
							<div class="fms_form_input">
								<g:secureTextField class="form-control" name="rateId" value="${rateSchHdrInstance?.rateId}" readonly="readonly"
									maxlength="50" tableName="AGENCY_RATE_SCHEDULE_HDR" attributeName="rateId" id= "rateId" title="The unique Rate ID for the rate schedule"
									aria-labelledby="rateId_label" aria-describedby="rateId_error" aria-required="false">
								</g:secureTextField>
								<div class="fms_form_error" id="rateId_error"></div>
	    				    </div>
	    				    <label class="control-label" id="retentionPeriod_label" for="retentionPeriod"> 
								<g:message code="rateSchHdrInstance.retentionPeriod.label" default="Retention Period :" />
							</label>
							<div class="fms_form_input">
								<g:secureTextField class="form-control" id="retentionPeriod" name="retentionPeriod" value="${rateSchHdrInstance?.retentionPeriod}" title= "The Retention Period in Months" 
									 disabled="${isEditable ? 'false'  : 'disabled'}" maxlength="2" tableName="AGENCY_RATE_SCHEDULE_HDR" attributeName="retentionPeriod" onkeypress="return isNumberKey(event)"
									 aria-labelledby="retentionPeriod_label" aria-describedby="retentionPeriod_error" aria-required="false">
								</g:secureTextField>
								<div class="fms_form_error" id="retentionPeriod_error"></div>
							</div>
						</div>
						<div class="fms_form_column fms_long_labels">
							<label class="control-label" id="description_label" for="description"> 
								<g:message code="rateSchHdrInstance.description.label" default="Description :" />
							</label>
							<div class="fms_form_input">
								<g:secureTextField class="form-control" name="description" value="${rateSchHdrInstance?.description}" 
									maxlength="60" tableName="AGENCY_RATE_SCHEDULE_HDR" attributeName="description" id="description" 
									title="The Description of the Rate schedule" 
									aria-labelledby="description_label" aria-describedby="description_error" aria-required="false">
								</g:secureTextField>
								<div class="fms_form_error" id="description_error"></div>
							</div>
							<label class="control-label fms_required" id="calcType_label" for="calcType"> 
								<g:message code="rateSchHdrInstance.calcType.label" default="Calc Type :" />
							</label>
							<div class="fms_form_input">
								<g:secureComboBox class="form-control" id="calcType" name="calcType" disabled="${params.editType != null ? "disabled" : "false"}"
									tableName="AGENCY_RATE_SCHEDULE_HDR" attributeName="calcType" value="${rateSchHdrInstance?.calcType}" 
									aria-labelledby="calcType_label" aria-describedby="calcType_error" aria-required="false"
									from="${['' : '', 'I': 'I - Incentive' , 'C': 'C - Commission']}" optionValue="value" optionKey="key">
								</g:secureComboBox>
								<div class="fms_form_error" id="calcType_error"></div>
							</div>
						</div>
					</div>
				</fieldset>
			</div>
			<g:if test="${params.editType?.equals("MASTER")}">
				<div class="fms_form_button">
 					<g:actionSubmit class="btn btn-primary" action="update" value="${message(code: 'default.button.save.label', default: 'Save')}" />
 					<g:if test="${isEditable}">
						<input id="BtnAddressDelete2" type="button" class="btn btn-default BtnDeleteRow" formnovalidate="" value="${message(code: 'default.button.delete.label', default: 'Delete')}" data-target="#DeleteAlertModal" />
					</g:if>
   					<input type="Reset" class="btn btn-default" value="Reset" />
					<input type="button" class="btn btn-default" value="Close" onClick="closeForm()"/>
				</div>
			</g:if>
			<g:else>
				<div class="fms_form_button">
				  <g:submitButton name="create" class="btn btn-primary" value="${message(code: 'default.button.create.label', default: 'Create')}" />
			      <input type="Reset" class="btn btn-default" value="Reset" />
			      <input type="button" class="btn btn-default" name="close" value="${message(code: 'default.button.cancel.label', default: 'Cancel')}" onClick="closeForm()"/>
   	        	</div> 
			</g:else>
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
