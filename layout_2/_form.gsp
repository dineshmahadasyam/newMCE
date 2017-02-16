<%@ page import="com.perotsystems.diamond.bom.fms.Agency"%>

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
	   
	   $("#idagencyId").alphanum({
			allow 		: '-',
			allowSpace  : false
		});

	   $("#idAgencyName").alphanum({
			allow 		: '-&',
			required	: true,
			allowSpace  : true
		});
		
	   $("#idtin").mask("?99-9999999");
	});



jQuery.validator.setDefaults({
	ignore: [],
	  debug: true,
	  success: "valid"
	});

$(document).ready(function(){

	jQuery.validator.addMethod("taxIdDigits", function(value, element) {
		return this.optional(element) || /\d{2}-\d{7}$/.test(value) || /\d{9}$/.test(value)
	}, "Tax ID must be 9 digits");


	
	$(function() {	
	$( "#agencyForm" ).validate({
		onfocusout: false,
		submitHandler: function (form) {
			  if ($(form).valid()) 
	              form.submit(); 
	          return false; // prevent normal form posting
	    },
	  	
	    	invalidHandler: function(form, validator) {
	        var errors = validator.numberOfInvalids();
	        if (errors) {      
	        	$(".message").hide();              
	            validator.errorList[0].element.focus();
	        }
	    },
	    
		errorLabelContainer: "#errorDisplay", 
		 wrapper: "li",	

		rules : {
			 	'agencyName' : {
					required : true
			 	},
	 			'tin' : {
	 				required : true,
	 				taxIdDigits : true
		 		}
		},
	    messages : {
		 	'agencyName' : {
				required : "Please enter Agency Name"
		 	},
		 	'tin' : {
		 		required : "Please enter Tax ID",
		 		taxIdDigits : "Tax ID must be 9 digits"
		 	}
		}
	})
	});

	});

</script>

<style>
.fieldcontain LABEL, .fieldcontain .property-label {
	width : 40%
}
</style>
<input type="hidden" name="editType" value="MASTER" />
<input type="hidden" name="seqAgencyId"
	value="${agencyInstance?.seqAgencyId }" />
<table>
	<tr>
		<td  class="tdnoWrap" style="white-space: nowrap">
			<div
				class="fieldcontain ${hasErrors(bean: agencyInstance, field: 'agencyId', 'error')} ">
				<label for="agencyId"> 
					<g:message code="agency.agencyId.label" default="Agency ID" />
						<span class="required-indicator">*</span> : 
				</label>
				<input type="hidden" name="agencyId" value="${agencyInstance?.agencyId}" />
				<g:secureTextField name="agencyId" value="${agencyInstance?.agencyId}" disabled="disabled" style="margin-right: 5px;"
				maxlength="50" tableName="AGENCY" attributeName="agencyId" id= "idagencyId"
				title="The unique Agency ID of the Agency"></g:secureTextField>
			</div>
		</td>
		<td  class="tdnoWrap" style="white-space: nowrap">
			<div
				class="fieldcontain ${hasErrors(bean: agencyInstance, field: 'agencyName', 'error')} ">
				<label for="agencyName"> 
					<g:message code="agency.agencyName.label" default="Agency Name" />
						<span class="required-indicator">*</span> : 
				</label>
				<g:secureTextField name="agencyName" value="${agencyInstance?.agencyName}" 
				maxlength="60" tableName="AGENCY" attributeName="agencyName" id = "idAgencyName" class="idAgencyName"
				title="The Name of the Agency"></g:secureTextField>
			</div>
		</td>
	</tr>

	<tr>
		<td  class="tdnoWrap" style="white-space: nowrap">
			<div
				class="fieldcontain ${hasErrors(bean: agencyInstance, field: 'agencyType', 'error')} required">
				<label for="agencyType"> 
					<g:message code="agency.agencyType.label" default="Agency Type" /> 
						<span class="required-indicator">*</span> : 
				</label>
				<g:secureTextField 
					name="agencyType" 
					tableName="AGENCY" attributeName="agencyType"
					value="${agencyInstance?.agencyType}" readonly="true"></g:secureTextField>
				</div>
		</td>
	
		<td  class="tdnoWrap" style="white-space: nowrap">
			<div
				class="fieldcontain ${hasErrors(bean: agencyInstance, field: 'tin', 'error')} ">
				<label for="tin"> 
					<g:message code="agency.tin.label" default="Tax ID" />
						<span class="required-indicator">*</span> : 
				</label>
				<g:secureTextField name="tin" value="${agencyInstance?.tin}"  maxlength="30" tableName="AGENCY" 
				attributeName="tin" title= "The 9 digit Tax ID Number of the Agency" id="idtin"></g:secureTextField>
			</div>
		</td>
	</tr>
	<tr>
		<td>&nbsp;</td>
		<td>&nbsp;</td>
	</tr>
	<tr>
		<td colspan="3">User Defined Information</td>
	</tr>
	<tr>
		<td colspan="3"><hr></td>
	</tr>
	<tr>
		<td  class="tdnoWrap" style="white-space: nowrap">
			<div
				class="fieldcontain ${hasErrors(bean: agencyInstance, field: 'userDefined1', 'error')} ">
				<label for="userDefined1">
					<g:userDefinedFieldLabel winId="AGNCM" datawindowId ="AGNCM" userDefineTextName="user_defined_1_t" defaultText="User Defined1"/> 
				</label>
				<g:secureTextField name="userDefined1"
					value="${agencyInstance?.userDefined1}"  maxlength="60" tableName="AGENCY" attributeName="userDefined1"></g:secureTextField>
			</div>
		</td>
		<td  class="tdnoWrap" style="white-space: nowrap">
			<div
				class="fieldcontain ${hasErrors(bean: agencyInstance, field: 'userDefined2', 'error')} ">
				<label for="userDefined2"> 
					<g:userDefinedFieldLabel winId="AGNCM" datawindowId ="AGNCM" userDefineTextName="user_defined_2_t" defaultText="User Defined2"/>
				</label>
				<g:secureTextField name="userDefined2"
					value="${agencyInstance?.userDefined2}"  maxlength="60" tableName="AGENCY" attributeName="userDefined2"></g:secureTextField>
			</div>
		</td>
		<td class="tdnoWrap" style="white-space: nowrap">&nbsp;</td>
	</tr>
	<tr>
		<td  class="tdnoWrap" style="white-space: nowrap">
			<div
				class="fieldcontain ${hasErrors(bean: agencyInstance, field: 'userDate1', 'error')} required">
				<label for="userDate1">
					<g:userDefinedFieldLabel winId="AGNCM" datawindowId ="AGNCM" userDefineTextName="user_date_1_t" defaultText="User Defined Date1"/> 
				</label>
				
				<g:secureGrailsDatePicker 
					name="userDate1" 
					tableName="AGENCY" attributeName="userDate1" precision="day" noSelection="['':'']"
					value="${agencyInstance?.userDate1}" default="none"></g:secureGrailsDatePicker>
			</div>
		</td>
		
		<td  class="tdnoWrap" style="white-space: nowrap">
			<div
				class="fieldcontain ${hasErrors(bean: agencyInstance, field: 'userDate2', 'error')} required">
				<label for="userDate2"> 
					<g:userDefinedFieldLabel winId="AGNCM" datawindowId ="AGNCM" userDefineTextName="user_date_2_t" defaultText="User Defined Date2"/> 
				</label>
				
				<g:secureGrailsDatePicker 
					name="userDate2" 
					tableName="AGENCY" attributeName="userDate2" precision="day" noSelection="['':'']"
					value="${agencyInstance?.userDate2}" default="none"></g:secureGrailsDatePicker>
			</div>
		</td>
		
		<td colspan="2" class="tdnoWrap" style="white-space: nowrap">&nbsp;</td>
	</tr>
</table>