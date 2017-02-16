<%@ page import="com.perotsystems.diamond.bom.AgencyRateScheduleDtl"%>
<g:set var="appContext" bean="grailsApplication"/>

<link rel="stylesheet" href="${resource(dir: 'css', file: 'member_pages.css')}" type="text/css">



<script type="text/javascript" src="${resource(dir: 'js', file: 'jquery.maskedinput.js')}"></script>
<script type="text/javascript" src="${resource(dir: 'js', file: 'commonfunctions.js')}"></script>
<script type="text/javascript" src="${resource(dir: 'js', file: 'jquery.alphanum.js')}"></script>
<script type="text/javascript" src="${resource(dir: 'js', file: 'jquery.validate.js')}"></script>

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

		
	});

	//]]>

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
	var appName = "${appContext.metadata['app.name']}";
	var myFm = document.getElementById("agencyRateSchDetailForm") ; 		
	myFm.action = "/"+appName+"/rateSchedule/deleteRateSchDtlRec";     	
	myFm.submit();
	
}

function addRateSchDtlRecord(){
	var appName = "${appContext.metadata['app.name']}";
	var myFm = document.getElementById("agencyRateSchDetailForm") ; 		
	myFm.action = "/"+appName+"/rateSchedule/addRateSchDtlRec";     	
	myFm.submit();
	
}

function isNumberKey(evt) {
    var charCode = (evt.which) ? evt.which : event.keyCode
    if (charCode > 31 && (charCode < 48 || charCode > 57)) {
        alert("Please Enter Only Numeric Value");
        return false;
    }

    return true;
} 

function isNumberKeyforRateAmount(evt) {
	var charCode = (evt.which) ? evt.which : event.keyCode;
    if (charCode == 46 && evt.srcElement.value.split('.').length>1) {
    	alert("Please enter numbers and decimal only for Rate Amount");
        return false;
    }
    if (charCode != 46 && charCode > 31 && (charCode < 48 || charCode > 57)){
    	alert("Please enter numbers and decimal only for Rate Amount");
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

</script>


<input type="hidden" name="editType" value="DETAIL" />
<input type="hidden" name="seqRateId" value="${rateSchHdrInstance?.seqRateId }" />
<input type="hidden" name="detailRecordCount" value = "${detailRecordCount}"/>
<g:hiddenField name="deleteThisDtlRecord" value=""/>
<div>
<table>
	<tr>
		<td  class="tdnoWrap" style="white-space: nowrap">
			<div
				class="fieldcontain ${hasErrors(bean: rateSchHdrInstance, field: 'rateId', 'error')} ">
				<label for="rateId"> 
					<g:message code="agency.rateId.label" default="Rate ID :" />
				</label>
				<g:secureTextField name="rateId" value="${rateSchHdrInstance?.rateId}" readonly="readonly" style="margin-right: 5px;border: none"
				maxlength="50" tableName="AGENCY_RATE_SCHEDULE_HDR" attributeName="rateId" id= "idrateId" title="The unique Rate ID for the rate schedule">
				</g:secureTextField>
			</div>
		</td>
		<td  class="tdnoWrap" style="white-space: nowrap">
			<div
				class="fieldcontain ${hasErrors(bean: rateSchHdrInstance, field: 'description', 'error')} ">
				<label for="description"> 
					<g:message code="agency.description.label" default="Description :" />
				</label>&nbsp;&nbsp;&nbsp;
				<g:secureTextField name="description" value="${rateSchHdrInstance?.description}" readonly="readonly" style="border: none"
				maxlength="60" tableName="AGENCY_RATE_SCHEDULE_HDR" attributeName="description" id = "idDescription" class="idDescription"
				title="The Description of the Rate schedule"></g:secureTextField>
			</div>
		</td>
		<td  class="tdnoWrap" style="white-space: nowrap">
			<div
				class="fieldcontain ${hasErrors(bean: rateSchHdrInstance, field: 'retentionPeriod', 'error')} ">
				<label for="description"> 
					<g:message code="agency.retentionPeriod.label" default="Retention Period:" />
				</label>&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;
				<g:secureTextField name="retentionPeriod" value="${rateSchHdrInstance?.retentionPeriod}" readonly="readonly" style="border: none"
					maxlength="2" tableName="AGENCY_RATE_SCHEDULE_HDR" attributeName="description" id = "idRetentionPeriod" class="numeric"
					title = "The Retention Period in days"></g:secureTextField>
			</div>
		</td>
	</tr>
</table>
</div>
<div id="${rateSchHdrInstance?.seqRateId}">
<input type="hidden" name="seqRateId" value="${rateSchHdrInstance?.seqRateId}">
	<div id="addRateSchDiv" style="padding-bottom:10px;">
	<table>
	<tr>
	<g:if test="${isEditable}">
	<td id="addDependentTdId" colspan="3"><BR>
		<%--<button type="button" class= "load" name="cancel" onclick="addRateSchDtlRecord()" >Add Row</button>
		--%><g:actionSubmit class="load" action="addRateSchDtlRec" value="${message(code: 'Add Row', default: 'Add Row')}" />
	</td>
	</g:if>
			</tr>
	</table>
	</div>
	<br/>
	<table border="1" id="report" >
		<tr class="head">
			<th>&nbsp;&nbsp;&nbsp;Rate Type *</th>
			<th>Rate Amount *</th>
			<th>Threshold From *</th>
			<th>Threshold Thru</th>
			<g:if test="${isEditable}">
			<th></th>
			</g:if>
			
		</tr>
		<tbody>
		<g:each in="${rateSchHdrInstance?.agencyRateSchDtls }" var="agencyRateSchDtl" status="i">
			<input type="hidden" name="seq_Rate_Sch_Dtl_Id_${i}" value="${agencyRateSchDtl?.seqRateSchDtlId }">
			<input type="hidden" name="agencyRateSchDtl.${i}.iterationCount" value="${i}">
			
			<%--<input type="hidden" name="agencyRateSchDtl.${i}.seqRateSchDtlId"  value="${agencyRateSchDtl?.seqRateSchDtlId }">
			
			--%><tr class="${(i % 2) == 0 ? 'even' : 'odd'}">
				<td>
					<g:secureSystemCodes  onchange="displaySymbol(${i})" onselect="displaySymbol(${i})"
						systemCodeType="COMMIS_RATETYPE" languageId="0"
						tableName="AGENCY_RATE_SCHEDULE_DTL" attributeName="rateType" 
						htmlElelmentId="agencyRateSchDtl.${i}.rateType"
						blankValue="Rate Type" 
						defaultValue="${agencyRateSchDtl?.rateType}" 
						width="250px" disable="${isEditable ? ''  : 'disabled'}">
					</g:secureSystemCodes>
					</td>
				<td>
					<g:textField name="${i}.currSymbol" id="${i}.currSymbol" value=" "	maxlength="1" readonly="readonly" style="width:15px;border: none;background:none"/>
					<script type="text/javascript">
						displaySymbol(${i});
					</script>
					<g:secureTextField name="agencyRateSchDtl.${i}.rateAmount" maxlength="16" title = "The rate amount" class="amtNumeric" onkeypress="return isNumberKeyforRateAmount(event)"
							value="${agencyRateSchDtl?.rateAmount}" tableName="AGENCY_RATE_SCHEDULE_DTL" attributeName="rateAmount"
							disabled="${isEditable ? 'false'  : 'disabled'}"></g:secureTextField>
				</td>
				<td>
					<g:secureTextField name="agencyRateSchDtl.${i}.thresholdRangeFrom" value="${agencyRateSchDtl?.thresholdRangeFrom}" maxlength="30" 
							tableName="AGENCY_RATE_SCHEDULE_DTL" attributeName="thresholdRangeFrom" class="amtNumeric" onkeypress="return isNumberKey(event)"
							title= "The Member Threshold from value" disabled="${isEditable ? 'false'  : 'disabled'}"></g:secureTextField>
				</td>
				<td>				
					<g:secureTextField name="agencyRateSchDtl.${i}.thresholdRangeThru" value="${agencyRateSchDtl?.thresholdRangeThru}" maxlength="30" 
							tableName="AGENCY_RATE_SCHEDULE_DTL" attributeName="thresholdRangeThru" class="amtNumeric" onkeypress="return isNumberKey(event)"
							title= "The Member Threshold thru value" disabled="${isEditable ? 'false'  : 'disabled'}"></g:secureTextField>
				</td>
				<g:if test="${isEditable}">
				<td>
					<button type="button" class= "load" name="cancel" value="Delete" onclick="deleteAllocation(${i})" >Delete</button>
				</td>
				</g:if>
			</tr>
			
		</g:each>
		</tbody>
		
	</table>
</div>