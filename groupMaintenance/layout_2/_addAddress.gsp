<%@ page import="com.perotsystems.diamond.bom.GroupEx"%>
<!DOCTYPE html>
<html>
<head>
<meta name="layout" content="main_2">
			<style type="text/css">

TD
{
	line-height: 1.4em;
	padding: 0em 0em;
	text-align: left;
	vertical-align: middle;
}
.fieldcontain {
	margin-top: 0.1em;
}
.fieldcontain LABEL, .fieldcontain .property-label {
color: #666666;
text-align: left;
width: 40%;
font-size: 0.8em;
font-weight: bold;
}
.fieldcontain span {
	color: #0066CC;
}
</style>


<g:set var="entityName"
	value="${message(code: 'groupMaster.label', default: 'GroupMaster')}" />
	
<g:set var="appContext" bean="grailsApplication"/>
	
<title><g:message code="default.edit.label" args="[entityName]" /></title>
<script type="text/javascript" src="${resource(dir: 'js', file: 'jquery-1.3.2.js')}"></script>
<script type="text/javascript" src="${resource(dir: 'js', file: 'jquery-ui-1.7.2.js')}"></script>
<script type="text/javascript" src="${resource(dir: 'js', file: 'jquery.window.js')}"></script>
<script type="text/javascript" src="${resource(dir: 'js', file: 'jquery.validate.js')}"></script>
<script type="text/javascript" src="${resource(dir: 'js', file: 'jquery.maskedinput.js')}"></script>
<script type="text/javascript" src="${resource(dir: 'js', file: 'additional-methods.js')}"></script>
<script>
	$(function($){
		   $(".maskZip").mask("99999?-9999");
		})
	</script>
<script type="text/javascript">
$(document).ready(function(){
jQuery.validator.setDefaults({
	ignore: [],
	  debug: true,
	  success: "valid"
	});


$(function() {		
		$("#editForm").validate({
			submitHandler: function (form) {
				  if ($(form).valid()) 
                      form.submit(); 
                  return false; // prevent normal form posting
	        },
			errorLabelContainer: "#errorDisplay", 
			 wrapper: "li",		
							
			rules : {
				'address.0.effectiveDate_day' : {
					required : true
				},
			    'address.0.effectiveDate_month' : {
					required : true
				},
	
			    'address.0.effectiveDate_year' : {
					required : true
				},
				'address.0.addressType' : {
					required : true
				}
				,'address.0.address1' : {
					required : true
				}
				,'address.0.city' : {
					required : true		
				},
				'address.0.state' : {
					required : true		
				},
				'address.0.zip' : {
					required : true,
					zipcodeUS : true	
				},
				'address.0.homePhone' : {
					digits : true	
				},'address.0.mobilePhone': {
					digits : true	
				}
				,'address.0.beeperNumber': {
					digits : true	
				}
				,'address.0.alternatePhone': {
					digits : true	
				}
				,'address.0.faxNumber': {
					digits : true	
				}
				,'address.0.telephoneNumber': {
					digits : true	
				}
				,'address.0.telephoneNumberEx': {
					digits : true	
				},'address.0.socialSecurityNumber': {
					digits : true	
				}
				,'address.0.businessPhone': {
					digits : true	
				},
				'address.0.termReason' :  {
					required : function(element){														
						return $.trim($("#address\\.0\\.termDate_year").val()).length > 0 ||
						$.trim($("#address\\.0\\.termDate_month").val()).length > 0 ||
						$.trim($("#address\\.0\\.termDate_day").val()).length > 0;						
					}
				},
				'address.0.termDate_year' :  {
					required : function(element){														
						return $.trim($("#address\\.0\\.termReason").val()).length > 0 	;						
					},
					greaterThan:[ "#address\\.0\\.effectiveDate","#address\\.0\\.termDate","Effective Date","Term Date"]
				},
				'address.0.termDate_month' :  {
					required : function(element){														
						return $.trim($("#address\\.0\\.termReason").val()).length > 0 	;						
					}
				},
				'address.0.termDate_day' :  {
					required : function(element){														
						return $.trim($("#address\\.0\\.termReason").val()).length > 0 	;						
					}
				}	
				
			},
			messages : {
				'address.0.effectiveDate_day' : {
					required : "Please enter the Effective Date."
				},
				'address.0.effectiveDate_month' : {
					required : "Please enter the Effective Month."
				}
				,'address.0.effectiveDate_year' : {
					required : "Please enter the Effective Year."
				}
				,'address.0.addressType': {
					required : "Please Select a Address Type"						
				}
				,'address.0.address1' : {
					required : "Please enter the Address 1"						
				}
				,'address.0.city' : {
					required : "Please enter the City"					
				}
				,'address.0.state' : {
					required : "Please select a value for State"					
				}
				,'address.0.zip' : {
					required : "Please enter the Zip Code"	,
					zipcodeUS : "Zip Code must be 5 or 9 digits" 
				},
				'address.0.homePhone' : {
					digits : "Please enter only numbers for Home Phone"
				},'address.0.mobilePhone': {
					digits : "Please enter only numbers for Mobile Phone"	
				}
				,'address.0.beeperNumber': {
					digits : "Please enter only numbers for Beeper Number"	
				}
				,'address.0.alternatePhone': {
					digits : "Please enter only numbers for Alternate Phone"	
				}
				,'address.0.faxNumber': {
					digits : "Please enter only numbers for Fax Number"	
				}
				,'address.0.telephoneNumber': {
					digits : "Please enter only numbers for Telephone Number"	
				}
				,'address.0.telephoneNumberEx': {
					digits : "Please enter only numbers for Telephone Ext"
				},'address.0.socialSecurityNumber': {
					digits : "Please enter only numbers for Social Security Number"	
				}
				,'address.0.businessPhone': {
					digits : "Please enter only numbers for Business Phone"	
				},
				'address.0.termReason' :  {
					required : "Term Reason is a mandatory field if Term Date is entered, please input the value for Term Reason"
				},
				'address.0.termDate_year' :  {
					required : "Term Date Year is a mandatory field if Term reason is entered, please input the value for Term Date Year"
				},
				'address.0.termDate_month' :  {
					required : "Term Date Month is a mandatory field if Term reason is entered, please input the value for Term Date Month"
				},
				'address.0.termDate_day' :  {
					required : "Term Date Day is a mandatory field if Term reason is entered, please input the value for Term Date Day"
				}		
			
			} 
			
		})
	});



//add extra validations for effective and term date
//New validation method to compare date fields.

jQuery.validator.addMethod("greaterThan",
function(value, element, params) {
//params[0]-start date field id
//params[1]-end date field id
//params[2]-start date field Name in error message
//params[3]-end date field Name in error message
//params[4]-form or tab name used to identify the date field id


	var startYear = params[0]+ "_year";
	var startMonth = params[0]+ "_month";
	var startDay = params[0]+ "_day";

	var endYear = params[1]+ "_year";
	var endMonth = params[1]+ "_month";
	var endDay = params[1]+ "_day";

	var startDate= new  Date($(startYear).val(),$(startMonth).val(), $(startDay).val());
			var endDate = new Date($(endYear).val(),$(endMonth).val(), $(endDay).val()) ;

	return this.optional(element) ||( $(startYear).val().length > 0 && $(startMonth).val().length > 0
				&& $(startDay).val().length > 0 && startDate < endDate) ;

}, jQuery.format("{3} Must be greater than {2}") );



}); 

</script>


<link rel="stylesheet"
	href="${resource(dir: 'css', file: 'jquery.window.css')}"
	type="text/css">

<style type="text/css">
#report changed {
	color: blue;
}

#report {
	border-collapse: collapse;
}

#report div {
	background: #C7DDEE
}

#report h4 {
	margin: 0px;
	padding: 0px;
}

#report img {
	float: right;
}

#report ul {
	margin: 10px 0 10px 40px;
	padding: 0px;
}

#report td {none repeat-x scroll center left;
	color: #000;
	padding: 2px 15px;
}

#report tr.hideme {
	background: #C7DDEE none repeat-x scroll center left;
	color: #000;
	padding: 7px 15px;
}

#report td.clickme td {
	background: #fffff repeat-x scroll center left;
	cursor: pointer;
}

#report div.arrow {
	background: transparent url(arrows.png) no-repeat scroll 0px -16px;
	width: 16px;
	height: 16px;
	display: block;
}

#report div.up {
	background-position: 0px 0px;
}

.showme Label {
	width: 240px;
	text-align: left;
	padding-bottom: 5px;
	padding-top: 10px;
}

.showme Input {
	width: 200px;
	text-align: left;
}

#editFields span {
	color: #0066CC;
}
</style>

<g:javascript>
	function closeForm() {
		var appName = "${appContext.metadata['app.name']}";
		window.location.assign("/"+appName+"/groupMaintenance/list")
	}
	
		
</g:javascript>


<script type="text/javascript">
var grpInnerWindow 
var innerWindowClosed = true;
function closeAllIFrames() {
	if(grpInnerWindow) {
		grpInnerWindow.close()
	}
}

function lookup(idName, cdoClassName, cdoClassAttributeName, assocFieldIds, assocFieldCdoName, updateFields, updateFieldsCdoName) {
	var htmlElementValue 
	var assocHTMLElementsValue= ""
	htmlElementValue = document.getElementById(idName).value
	//alert (assocFieldIds)
	if (assocFieldIds) {
		if(assocFieldIds.indexOf('|') == -1){			
			if (document.getElementById(assocFieldIds) && document.getElementById(assocFieldIds).value != "undefined") {
				assocHTMLElementsValue = document.getElementById(assocFieldIds).value
			}
		} else {
			var nameArray = assocFieldIds.split("|")
			for (var i =0;i<nameArray.length;i++) {			
				if (document.getElementById(nameArray[i]) && document.getElementById(nameArray[i]).value != "undefined") {
			//		alert (document.getElementById(nameArray[i]).value)
					assocHTMLElementsValue += document.getElementById(nameArray[i]).value+"|"
				}
			}
		}
	}
	//alert("assocHTMLElementsValue = "+assocHTMLElementsValue )
	var appName = "${appContext.metadata['app.name']}";
	var urlValue = "/"+appName+"/lookUp/lookUp?htmlElementIdName=" + idName
			+ "&htmlElementValue="+ htmlElementValue 
			+ "&cdoClassName="+ cdoClassName 
			+ "&cdoClassAttributeName="+ cdoClassAttributeName 
			+ (assocFieldIds?"&assocFields="+assocFieldIds :"")			
			+ (assocFieldCdoName?"&assocFieldCdoName="+assocFieldCdoName :"")
			+ (assocHTMLElementsValue? "&assocFieldValue="+ assocHTMLElementsValue : "") 
			+ (updateFieldsCdoName?  "&updateFieldsCdoName=" + updateFieldsCdoName : "")
			+ (updateFields? "&updateFields="+updateFields : "")
			+ "&offset=0"
	if (!innerWindowClosed) {
		grpInnerWindow.setUrl(urlValue)
	} else {
		innerWindowClosed = false;
		grpInnerWindow = $.window({
			showModal : true,
			title : "Lookup",
			bookmarkable : false,
			minimizable : false,
			maximizable : false,
			width : 900,
			height : 350,
			scrollable: false,
			url : urlValue, 
		 onClose: function(wnd) { // a callback function while user click close button
			 innerWindowClosed = true;
		  }
		});
	}
}

</script>
<script type="text/javascript">
function displayCountryChangeMessage(){
	alert ("Only USA is allowed at this time. You many not change this value.");
}
</script>
<style>
	div.right-corner {
	    position: absolute;
	    top: 0px;
	    right: 0;
	    margin-right: 40px;
	    font:normal normal 21pt / 1 Tahoma;
	    color: #48802C;
	}
</style>
</head>
<body>
	<a href="#edit-groupMaster" class="skip" tabindex="-1"><g:message
			code="default.link.skip.label" default="Skip to content&hellip;" /></a>
	<div class="nav" role="navigation">
		<ul>
			<li><g:link class="list" action="edit"
					params="${[groupId: request.getParameter('groupId'), groupDBId : request.getParameter("groupDBId"), groupEditType :'MASTER']}">Master Record</g:link></li>
			<li><g:link class="list" action="edit"
					params="${[groupId: request.getParameter('groupId'), groupDBId : request.getParameter("groupDBId"), groupEditType :'CONTRACT']}">Group Contracts</g:link></li>
			<li><g:link class="list" action="edit"
					params="${[groupId: request.getParameter('groupId'), groupDBId : request.getParameter("groupDBId"), groupEditType :'DETAIL']}">Detail Records</g:link></li>
			<li><g:link class="list" action="edit"
					params="${[groupId: request.getParameter('groupId'), groupDBId : request.getParameter("groupDBId"), groupEditType :'ADDRESS']}">Group Addresses</g:link></li>
		</ul>
	</div>
	<div id="edit-groupMaster" class="content scaffold-edit" role="main">
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

		<g:form action="saveAddress" id="editForm" name="editForm">
			<div id="errorDisplay" style="display: none;" class="errors"
				style="float:left; margin: -5px 10px 0px 0px; "></div>
			<g:hiddenField name="id" value="${groupMasterInstance?.groupId}" />
			<g:hiddenField name="groupId" value="${groupMasterInstance?.groupId}" />
			<g:hiddenField name="groupDBId"
				value="${groupMasterInstance?.groupDBId}" />
			<h1 style="color: #48802C">
				Add Address to Group with GroupId -
				${groupMasterInstance?.groupId}
			</h1>
			<div class="right-corner" align="center">GRUPA</div>
			<fieldset >
			<table class="report1" id="editFields" border="0">
							<tr>
							<td style="white-space:nowrap" >
									<div
										class="fieldcontain ${hasErrors(bean: address, field: 'address.addressType', 'error')} ">
										<label for="addressType"> <g:message
												code="groupMaster.addressType.label" default="Address Type :" /><span class="required-indicator">*</span>
										</label>
										<g:getSystemCodeToken
											systemCodeType="ADDRESSTYPE" languageId="0"
											htmlElelmentId="address.0.addressType"
											blankValue="Address Type" 
											defaultValue="${address?.addressType}" 
											style="width:175px"/>
									</div>
									</td>
								<td style="white-space:nowrap" >
									<div
										class="fieldcontain ${hasErrors(bean: address, field: 'address.effectiveDate', 'error')} ">
										<label for="effectiveDate"> <g:message
												code="groupMaster.effectiveDate.label" default="Effective Date :" />
											<span class="required-indicator">*</span>
										</label>
										<g:datePicker name="address.0.effectiveDate" precision="day" noSelection="['':'']"
										value="${address?.effectiveDate}" default="none" />									
										
									</div>
								</td>
								</tr>
								<tr>
								<td>
									<div
										class="fieldcontain ${hasErrors(bean: address, field: 'address.termDate', 'error')} ">
										<label for="termDate"> <g:message
												code="groupMaster.termDate.label" default="Term Date :" />
						
										</label>
										<g:datePicker name="address.0.termDate" precision="day" noSelection="['':'']"
										value="${address?.termDate}" default="none"/>												
								</div>
								</td>
								<td>
									<div
										class="fieldcontain ${hasErrors(bean: address, field: 'address.termReason', 'error')} ">
										<label for="termReason"> <g:message
												code="groupMaster.termReason.label" default="Term Reason :" />
						
										</label>
										<input type="hidden" name="TermReasonType" id="TermReasonType" value="TM"/>									
										<g:textField name="address.0.termReason"
											value="${address?.termReason}" style="width:175px"/>
										<img width="25" height="25"
											style="float: none; vertical-align: bottom"
											class="magnifying" src="${resource(dir: 'images', file: 'Search-icon.png')}"
											onclick="lookup('address.0.termReason', 'com.perotsystems.diamond.dao.cdo.ReasonCodeMaster','reasonCode', 'TermReasonType', 'reasonCodeType', null, null)">												
									
									</div>
								</td>
							</tr>
							<tr>								
									<td>
										<div
											class="fieldcontain ${hasErrors(bean: address, field: 'address.isPrimaryAddress', 'error')} ">
											<label for="isPrimaryAddress"> <g:message
													code="groupMaster.isPrimaryAddress.label" default="Primary Address:" />
							
											</label>
											<select name="address.0.isPrimaryAddress" style="width:175px">
												<option value=""></option>
												<option value="true"
													${ address?.isPrimaryAddress ? 'selected' : '' }>Yes</option>
												<option value="false"
													${!address?.isPrimaryAddress ? 'selected' : '' }>No</option>
											</select>														
										</div>
									</td>
									<td style="white-space:nowrap">
										<div
											class="fieldcontain ${hasErrors(bean: address, field: 'address.isBillingAddress', 'error')} ">
											<label for="isBillingAddress"> <g:message
													code="groupMaster.isBillingAddress.label" default="Billing Address :" />
							
											</label>
											<select name="address.0.isBillingAddress" style="width:175px">
												<option value=""></option>
												<option value="true"
													${ address?.isBillingAddress ? 'selected' : '' }>Yes</option>
												<option value="false"
													${!address?.isBillingAddress ? 'selected' : '' }>No</option>
											</select>										
										</div>
									</td>
									</tr>	
									<tr>
									<td>
										<div
											class="fieldcontain ${hasErrors(bean: address, field: 'address.isInactive', 'error')} ">
											<label for="isInactive"> <g:message
													code="groupMaster.isInactive.label" default="Inactive :" />
							
											</label>
											<select name="address.0.isInactive" style="width:175px">
												<option value=""></option>
												<option value="true"
													${ address?.isInactive ? 'selected' : '' }>Yes</option>
												<option value="false"
													${!address?.isInactive ? 'selected' : '' }>No</option>
											</select>											
										</div>
									</td>
								<td>
									<div
										class="fieldcontain ${hasErrors(bean: address, field: 'address.address1', 'error')} ">
										<label for="address1"> <g:message
												code="groupMaster.address1.label" default="Address1 :" /><span class="required-indicator">*</span>
						
										</label>
										<g:textField name="address.0.address1"
											value="${address?.address1}" style="width:175px"/>
									</div>
								</td>
									</tr><tr>						
								<td>
									<div
										class="fieldcontain ${hasErrors(bean: address, field: 'address.address2', 'error')} ">
										<label for="address2"> <g:message
												code="groupMaster.address2.label" default="Address2 :" />
						
										</label>
										<g:textField name="address.0.address2"
											value="${address?.address2}" style="width:175px"/>
									</div>
								</td>
								<td>
									<div
										class="fieldcontain ${hasErrors(bean: address, field: 'address.city', 'error')} ">
										<label for="city"> <g:message code="groupMaster.city.label"
												default="City :" /><span class="required-indicator">*</span>
						
										</label>
										<g:textField name="address.0.city"
											value="${address?.city}" style="width:175px"/>
									</div>
								</td>
							</tr>
							<tr>
								<td>
									<div
										class="fieldcontain ${hasErrors(bean: address, field: 'address.state', 'error')} ">
										<label for="groupState"> <g:message
												code="groupMaster.groupState.label" default="State :" />
						<span class="required-indicator">*</span>
										</label>
										<g:select
									        name="address.0.state" optionKey="stateCode" optionValue="stateName" value="${address?.state}" from="${states}" noSelection="['':'-- Select a State --']" style="width:175px"></g:select>
									</div>
								</td>
								<td>
									<div
										class="fieldcontain ${hasErrors(bean: address, field: 'address.zip', 'error')} ">
										<label for="zipCode"> <g:message
												code="groupMaster.zipCode.label" default="Zip Code :" /><span class="required-indicator">*</span>
						
										</label>
										<g:textField name="address.0.zip" maxlength="10" class="maskZip"
											value="${address?.zip}" style="width:175px"/>
									</div>
								</td>
								</tr>
								<tr>
									<td>
									<div
										class="fieldcontain ${hasErrors(bean: address, field: 'address.county', 'error')} ">
										<label for="county"> <g:message
												code="groupMaster.county.label" default="County :" />
						
										</label>
										<g:textField name="address.0.county"
											value="${address?.county}" style="width:175px"/>
									</div>
								</td>
								<td>
									<div
										class="fieldcontain ${hasErrors(bean: address, field: 'address.country', 'error')} ">
										<label for="country"> <g:message
												code="groupMaster.country.label" default="Country :" />
						
										</label>
										<g:select name="address.0.country" optionKey="countryCode" optionValue="country" value="${address?.country}" from="${countries}" noSelection="['USA':'USA']" style="width:175px"></g:select>
									</div>
								</td>
							</tr>
							
							<tr>
							 	<td style="white-space:nowrap" colspan="2">&nbsp;</td>
							</tr>
							
							<tr>
							 	<td style="white-space:nowrap" colspan="2">
									User Defined Fields
								</td>
							</tr>
								 
							<tr>
							 	<td style="white-space:nowrap" colspan="2">
									<hr>
								</td>
							</tr>
								
							<tr>
								<td style="white-space:nowrap">
									<div
										class="fieldcontain ${hasErrors(bean: address, field: 'address.userDefined1', 'error')} ">
										<label for="userDef1"> 
												<g:userDefinedFieldLabel winId="GRUPA" datawindowId ="dw_grupa_de" userDefineTextName="USER_DEF_1_t"
													defaultText="User Defined 1"   />
						
										</label>
										<g:textField name="address.0.userDefined1"
											value="${address?.userDefined1}" style="width:175px" />
									</div>
								</td>
								<td style="white-space:nowrap">
									<div
										class="fieldcontain ${hasErrors(bean: address, field: 'address.userDate1', 'error')} ">
										<label for="userDate1"> 
												<g:userDefinedFieldLabel winId="GRUPA" datawindowId ="dw_grupa_de" userDefineTextName="user_date_1_t"
													defaultText="User Date 1"   />	
						
										</label>
										<g:datePicker name="address.0.userDate1" precision="day" noSelection="['':'']"
										value="${address?.userDate1}" default="none"/>	
									</div>
								</td>
							</tr>
							<tr>
								<td style="white-space:nowrap">
									<div
										class="fieldcontain ${hasErrors(bean: address, field: 'address.userDefined2', 'error')} ">
										<label for="userDef2"> 
										<g:userDefinedFieldLabel winId="GRUPA" datawindowId ="dw_grupa_de" userDefineTextName="USER_DEF_2_t"
													defaultText="User Defined 2"/>		
						
										</label>
										<g:textField name="address.0.userDefined2"
											value="${address?.userDefined2}" style="width:175px"/>
									</div>
								</td>
								<td style="white-space:nowrap">
									<div
										class="fieldcontain ${hasErrors(bean: address, field: 'address.userDate2', 'error')} ">
										<label for="userDate2"> 
											<g:userDefinedFieldLabel winId="GRUPA" datawindowId ="dw_grupa_de" userDefineTextName="user_date_2_t"
													defaultText="User Date 2"   />	
										</label>
										<g:datePicker name="address.0.userDate2" precision="day" noSelection="['':'']"
										value="${address?.userDate2}" default="none" />	
									</div>
								</td>
							</tr>
							<tr>
								<td style="white-space:nowrap">
									<div
										class="fieldcontain ${hasErrors(bean: address, field: 'address.userDefined3', 'error')} ">
										<label for="userDef3"> 
												<g:userDefinedFieldLabel winId="GRUPA" datawindowId ="dw_grupa_de" userDefineTextName="USER_DEF_3_t"
													defaultText="User Defined 3"   />
						
										</label>
										<g:textField name="address.0.userDefined3"
											value="${address?.userDefined3}" style="width:175px"/>
									</div>
								</td>
								<td style="white-space:nowrap">
									<div
										class="fieldcontain ${hasErrors(bean: address, field: 'address.userDate3', 'error')} ">
										<label for="userDate3">	<g:userDefinedFieldLabel winId="GRUPA" datawindowId ="dw_grupa_de" userDefineTextName="user_date_3_t"
													defaultText="User Date 3"   /> 
						
										</label>
										<g:datePicker name="address.0.userDate3" precision="day" noSelection="['':'']"
										value="${address?.userDate3}" default="none" />	
									</div>
								</td>
							</tr>
							<tr>
								<td style="white-space:nowrap">
									<div
										class="fieldcontain ${hasErrors(bean: address, field: 'address.userDefined4', 'error')} ">
										<label for="userDef4"> 
												<g:userDefinedFieldLabel winId="GRUPA" datawindowId ="dw_grupa_de" userDefineTextName="USER_DEF_4_t"
													defaultText="User Defined 4"   />
						
										</label>
										<g:textField name="address.0.userDefined4"
											value="${address?.userDefined4}" style="width:175px"/>
									</div>
								</td>
								<td style="white-space:nowrap">
									<div
										class="fieldcontain ${hasErrors(bean: address, field: 'address.userDate4', 'error')} ">
										<label for="userDate4"> 	<g:userDefinedFieldLabel winId="GRUPA" datawindowId ="dw_grupa_de" userDefineTextName="user_date_4_t"
													defaultText="User Date 4"   />						
										</label>
										<g:datePicker name="address.0.userDate4" precision="day" noSelection="['':'']"
										value="${address?.userDate4}" default="none" />	
									</div>
								</td>
							</tr>
							<tr>
								<td style="white-space:nowrap">
									<div
										class="fieldcontain ${hasErrors(bean: address, field: 'address.userDefined5', 'error')} ">
										<label for="address.0.userDefined5"> 
												<g:userDefinedFieldLabel winId="GRUPA" datawindowId ="dw_grupa_de" userDefineTextName="USER_DEF_5_t"
													defaultText="User Defined 5"   />
						
										</label>
										<g:textField name="address.0.userDefined5"
											value="${address?.userDefined5}" style="width:175px"/>
									</div>
								</td>
								<td style="white-space:nowrap">
									<div
										class="fieldcontain ${hasErrors(bean: address, field: 'address.userDate5', 'error')} ">
										<label for="address.0.userDate5">	<g:userDefinedFieldLabel winId="GRUPA" datawindowId ="dw_grupa_de" userDefineTextName="user_date_5_t"
													defaultText="User Date 5"   />
						
										</label>
										<g:datePicker name="address.0.userDate5" precision="day" noSelection="['':'']"
										value="${address?.userDate5}" default="none" />	
									</div>
								</td>
							</tr>
						</table>
					</td>
				</tr>
			</table>

</fieldset>
			<fieldset class="buttons">
				<g:actionSubmit class="save" action="saveAddress"
					value="${message(code: 'default.button.update.label', default: 'Update')}" />
				<input class="reset" type="reset"> <input type="button"
					name="close" class="close" value="Close" onClick="closeForm()">
			</fieldset>
			<input type="hidden" name="dirtyFields" value="">
			
			
		</g:form>
		<%--				used by lookup window--%>
		<div style="display: none">
			<input type="button" onClick="closeAllIFrames()" id="closeIframes">
		</div>
</body>


</html>
