<%@ page import="com.perotsystems.diamond.bom.AgencyRateScheduleHdr"%>

<g:set var="appContext" bean="grailsApplication"/>	
<link rel="stylesheet"
	href="${resource(dir: 'css', file: 'jquery.window.css')}"
type="text/css">

<script  type="text/javascript" src="${resource(dir: 'js', file: 'datetimepicker_css.js')}"></script>

<script type="text/javascript" src="${resource(dir: 'js', file: 'jquery-1.3.2.js')}"></script>
<script type="text/javascript" src="${resource(dir: 'js', file: 'jquery-ui-1.7.2.js')}"></script>
<script type="text/javascript" src="${resource(dir: 'js', file: 'jquery.window.js')}"></script>
<script type="text/javascript" src="${resource(dir: 'js', file: 'jquery.validate.js')}"></script>
<script type="text/javascript" src="${resource(dir: 'js', file: 'additional-methods.js')}"></script>	
<script type="text/javascript" src="${resource(dir: 'js', file: 'jquery.dirtyform.js')}"></script>

<script type="text/javascript" src="${resource(dir: 'js', file: 'jquery.maskedinput.js')}"></script>
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

<style>
.fieldcontain LABEL, .fieldcontain .property-label {
	width : 40%
}
</style>
<input type="hidden" name="editType" value="MASTER" />
<input type="hidden" name="seqRateId"
	value="${rateSchHdrInstance?.seqRateId }" />
<table>
	<tr>
		<td  class="tdnoWrap" style="white-space: nowrap">
			<div
				class="fieldcontain ${hasErrors(bean: rateSchHdrInstance, field: 'rateId', 'error')} ">
				<label for="rateId"> 
					<g:message code="rateSchHdrInstance.rateId.label" default="Rate ID :" />
						<span class="required-indicator">*</span>
				</label>
				<g:secureTextField name="rateId" value="${rateSchHdrInstance?.rateId}" readonly="readonly" style="margin-right: 5px;"
					maxlength="50" tableName="AGENCY_RATE_SCHEDULE_HDR" attributeName="rateId" id= "idrateId" title="The unique Rate ID for the rate schedule">
				</g:secureTextField>
			</div>
		</td>
		<td  class="tdnoWrap" style="white-space: nowrap">
			<div
				class="fieldcontain ${hasErrors(bean: rateSchHdrInstance, field: 'description', 'error')} ">
				<label for="description"> 
					<g:message code="rateSchHdrInstance.description.label" default="Description :" />
				</label>
				<g:secureTextField name="description" value="${rateSchHdrInstance?.description}" 
				maxlength="60" tableName="AGENCY_RATE_SCHEDULE_HDR" attributeName="description" id = "idDescription" class="idDescription"
				title="The Description of the Rate schedule"></g:secureTextField>
			</div>
		</td>
	</tr>
	<tr>
		<td  class="tdnoWrap" style="white-space: nowrap">
			<div
				class="fieldcontain ${hasErrors(bean: rateSchHdrInstance, field: 'retentionPeriod', 'error')} ">
				<label for="description"> 
					<g:message code="rateSchHdrInstance.retentionPeriod.label" default="Retention Period :" />
				</label>
				<g:secureTextField name="retentionPeriod" value="${rateSchHdrInstance?.retentionPeriod}" title= "The Retention Period in Months" 
				 disabled="${isEditable ? 'false'  : 'disabled'}"
				maxlength="2" tableName="AGENCY_RATE_SCHEDULE_HDR" attributeName="retentionPeriod" onkeypress="return isNumberKey(event)"
				></g:secureTextField>
			</div>
		</td>
		
		<td  class="tdnoWrap" style="white-space: nowrap">
			<div
				class="fieldcontain ${hasErrors(bean: rateSchHdrInstance, field: 'calcType', 'error')} ">
				<label for="calcType"> 
					<g:message code="rateSchHdrInstance.calcType.label" default="Calc Type :" />
					<span class="required-indicator">*</span>
				</label>
				<g:secureComboBox name="calcType" style="width: 150px" disabled="${params.editType != null ? "disabled" : "false"}"
					tableName="AGENCY_RATE_SCHEDULE_HDR" attributeName="calcType" value="${rateSchHdrInstance?.calcType}" 
					from="${['' : '', 'I': 'I - Incentive' , 'C': 'C - Commission']}" optionValue="value" optionKey="key"></g:secureComboBox>
			</div>
		</td>
		
	</tr>
	
	
</table>