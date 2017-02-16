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
<script type="text/javascript" src="${resource(dir: 'js', file: 'jquery.alphanum.js')}"></script>
<script>
$(function(){

    $(".amtNumeric").numeric({});
	
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
				'detail.0.effectiveDate_day' :  {
					required : true
				},
				'detail.0.effectiveDate_month' :  {
					required : true
				},
				'detail.0.effectiveDate_year' :  {
					required : true
				},
				'detail.0.recordType' : {
					required : true
				},
				'detail.0.priceOrAdjudicate' : {
					required : true
				},
				'detail.0.planRiderCode' :  {
					required : true
				},
				'detail.0.multiPlanEnroll' :  {
					required : true
				},
				'detail.0.seqGroupId' :  {
					required : true
				},
				'detail.0.lineOfBusiness' :  {
					required : true
				},
				'detail.0.cobExcludeCapClaimCode'  : {
					required : true
				},
				'detail.0.termReason' :  {
					required : function(element){														
						return $.trim($("#detail\\.0\\.endDate_year").val()).length > 0 ||
						$.trim($("#detail\\.0\\.endDate_month").val()).length > 0 ||
						$.trim($("#detail\\.0\\.endDate_day").val()).length > 0;						
					}
				},
				'detail.0.endDate_year' :  {
					required : function(element){														
						return $.trim($("#detail\\.0\\.termReason").val()).length > 0 	;						
					},
					greaterThan:[ "#detail\\.0\\.effectiveDate","#detail\\.0\\.endDate","Effective Date","Term Date"]
				},
				'detail.0.endDate_month' :  {
					required : function(element){														
						return $.trim($("#detail\\.0\\.termReason").val()).length > 0 	;						
					}
				},
				'detail.0.endDate_day' :  {
					required : function(element){														
						return $.trim($("#detail\\.0\\.termReason").val()).length > 0 	;						
					}
				}
	
			},
			messages : {
				'detail.0.effectiveDate_day' :  {
					required : "Effective Date - Day is a mandatory field, please input the value for Effective date - Day"						
				},
				'detail.0.effectiveDate_month' :  {
					required : "Effective Date - Month is a mandatory field, please input the value for Effective date - Month"
				},
				'detail.0.effectiveDate_year' :  {
					required : "Effective Date - Year is a mandatory field, please input the value for Effective date - Year"
				},
				'detail.0.recordType' : {
					required : "Record Type is a mandatory field, please input the value for Record Type"
				},
				'detail.0.priceOrAdjudicate' : {
					required : "Processing is a mandatory field, please input the value for Processing"
				},
				'detail.0.planRiderCode' : {
					required : "Plan/Rider Code is a mandatory field, please input the value for Plan/Rider Code"
				},
				'detail.0.seqGroupId'  : {
					required : "GroupID is a mandatory field, please input the value for GroupId"
				},
				'detail.0.lineOfBusiness'  : {
					required : "Line of Business is a mandatory field, please input the value for Line of Business"
				},
				'detail.0.termReason' :  {
					required : "Term Reason is a mandatory field if Term Date is entered, please input the value for Term Reason"
				},
				'detail.0.endDate_year' :  {
					required : "Term Date Year is a mandatory field if Term reason is entered, please input the value for Term Date Year"
				},
				'detail.0.endDate_month' :  {
					required : "Term Date Month is a mandatory field if Term reason is entered, please input the value for Term Date Month"
				},
				'detail.0.endDate_day' :  {
					required : "Term Date Day is a mandatory field if Term reason is entered, please input the value for Term Date Day"
				}
				'detail.0.multiPlanEnroll' :  {
					required : "Multi Plan Enroll is a mandatory field, please input the value for Multi Plan Enroll Code"
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
<script>

$( document ).ready(function() {
	if(document.getElementById("detail.0.giaAmount").value == ""){
		document.getElementById("detail.0.giaAmount").value="0.00";
	}
	
	var tempProductType = productType.value;
	if(tempProductType != null){
	  	var index = tempProductType.indexOf("-");
			var prodType = tempProductType.substr(0 , index).trim();
			if(prodType != null && prodType == 'SPLSL' || prodType == 'LIFE' || prodType == 'BETL' || prodType == 'SPLDL' || prodType == 'SPLEL'){
				document.getElementById("detail.0.giaAmount").disabled="";
			}
	    }
	 
});

function upperMe(value) { 
	document.getElementById(value).value = document.getElementById(value).value.toUpperCase(); 
}

function populateProductType() {
	 var planCode = document.getElementById("detail.0.planRiderCode").value;
	 var recordType = document.getElementById("detail.0.recordType").value;
	 if(recordType == 'P') {
		 var productType = jQuery.ajax({
			url : '<g:createLinkTo dir="/groupMaintenance/ajaxPopulateProductType"/>',				
			type : "POST",
			data : {planRiderCode:planCode},
			success : function(result) {
				document.getElementById("productType").value=result
				var index = result.indexOf("-")
				var prodType = result.substr(0 , index).trim()
				if(prodType != null && (prodType == 'SPLSL' || prodType == 'LIFE' || prodType == 'BETL' || prodType == 'SPLDL' || prodType == 'SPLEL')){
					document.getElementById("detail.0.giaAmount").disabled="";
				}
				else{
					document.getElementById("detail.0.giaAmount").value="0.00";
					document.getElementById("detail.0.giaAmount").disabled="disabled";
					}
			}
		});
	}
}

function populateCompanyCode(count) {
	 var glRefCode = document.getElementById("detail.0.glRefCode").value;
	 if(glRefCode) {		
		 var companyCode = jQuery.ajax({
			url : '<g:createLinkTo dir="/groupMaintenance/ajaxPopulateCompanyCode"/>',				
			type : "POST",
			data : {glRefCode:glRefCode},
			success : function(result) {
				document.getElementById("detail.0.companyCode").value=result
				if(result != null){
					document.getElementById("detail.0.companyCode").disabled="";
				}
				else{
					document.getElementById("detail.0.companyCode").disabled="disabled";
					}
			}
		});
	}
}
function findPlanRider() {
	var recordTypeObj = document.getElementById("detail.0.recordType");
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
	lookup("detail.0.planRiderCode", planCdoClass ,planCdoColumnName, null, null, null, null);
}
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
				//alert (assocHTMLElementsValue )
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
					<li>
						${error}
					</li>
				</g:each>
			</ul>
		</g:if>
		<g:form action="savePremiumMaster" id="editForm" name="editForm">
			<div id="errorDisplay" style="display: none;" class="errors"
				style="float:left; margin: -5px 10px 0px 0px; "></div>
			<g:hiddenField name="id" value="${groupMasterInstance?.groupId}" />
			<g:hiddenField name="groupId" value="${groupMasterInstance?.groupId}" />
			<g:hiddenField name="groupDBId"
				value="${groupMasterInstance?.groupDBId}" />
			<h1 style="color: #48802C">
				Add Plan/Rider to Group with GroupId -
				${groupMasterInstance?.groupId}
			</h1>
			<table>
				<tr>
					<td>
						<table border="0">
							<tr>
								<td >
									<div
										class="fieldcontain ${hasErrors(bean: premiumMasterVar, field: 'recordType', 'error')} ">
										<label for="rcdType"> <g:message
												code="premiumMaster.recordType.label"
												default="Record Type :" /><span class="required-indicator">*</span>

										</label>
										<g:getDiamondDataWindowDetail columnName="record_type"
											dwName="dw_grupd_de" languageId="0"
											htmlElelmentId="detail.0.recordType"
											defaultValue="${premiumMasterVar?.recordType}"
											blankValue="Record Type" width="150px" />
									</div>
								</td>
								<td >
									<div
										class="fieldcontain ${hasErrors(bean: premiumMasterVar, field: 'planRiderCode', 'error')} ">
										<label for="planRiderCode"> <g:message
												code="premiumMaster.planRiderCode.label"
												default="Plan/Rider Code :" /><span class="required-indicator">*</span>

										</label> <input type="hidden" name="0.recordType"
											id="det0.recordType"
											value="${premiumMasterVar?.recordType}" />
										<g:textField name="detail.0.planRiderCode"  maxlength="50" class="RemoveSpecialChars"
											value="${premiumMasterVar?.planRiderCode}" onchange="upperMe('detail.0.planRiderCode'), populateProductType()"  onblur = "populateProductType()"/>
										<img width="25" height="25"
											style="float: none; vertical-align: bottom"
											class="magnifying" src="${resource(dir: 'images', file: 'Search-icon.png')}"
											onclick="findPlanRider()">
									</div>
								</td>
								<td   style="white-space:nowrap">
									<div
										class="fieldcontain ${hasErrors(bean: premiumMasterVar, field: 'lineOfBusiness', 'error')} ">
										<label for="lineOfBusiness"> <g:message
												code="premiumMaster.lineOfBusiness.label"
												default="Line Of Business :" /> <span
											class="required-indicator">*</span>

										</label>
										<g:textField name="detail.0.lineOfBusiness"
											value="${premiumMasterVar?.lineOfBusiness}" />
										<img width="25" height="25"
											style="float: none; vertical-align: bottom"
											class="magnifying" src="${resource(dir: 'images', file: 'Search-icon.png')}"
											onclick="lookup('detail.0.lineOfBusiness', 'com.perotsystems.diamond.dao.cdo.LineOfBusinessMaster','lineOfBusiness')">

									</div>
								</td>
							</tr>
							<tr>
								<td >
									<div
										class="fieldcontain ${hasErrors(bean: premiumMasterVar, field: 'effectiveDate', 'error')} required">
										<label for="effectiveDate"> <g:message
												code="premiumMaster.effectiveDate.label"
												default="Effective Date :" /> <span
											class="required-indicator">*</span>
										</label>
										<g:datePicker name="detail.0.effectiveDate"
											precision="day" noSelection="['':'']"
											value="${premiumMasterVar?.effectiveDate}" default="none" />
									</div>
								</td>

								<td>
									<div
										class="fieldcontain ${hasErrors(bean: premiumMasterVar, field: 'endDate', 'error')} required">
										<label for="endDate"> <g:message
												code="premiumMaster.endDate.label" default="Term Date :" />
										</label>
										<g:datePicker name="detail.0.endDate" precision="day"
											noSelection="['':'']" value="${premiumMasterVar?.endDate}"
											default="none" />
									</div>
								</td>
								<td>
									<div
											class="fieldcontain ${hasErrors(bean: plan, field: 'plan.productType', 'error')} required" 
											style="display: inline">
											<label for="productType"> <g:message
													code="planMaster.productType.label" default="Product Type :" />
											</label>
											<g:textField readOnly="true" style="color: #48802C" name="productType" value="${productType }" />
									</div>					
								</td>	
							</tr>
							<tr>
							</tr>
							<tr>
							</tr>
							<tr>
								<td>
									<div
										class="fieldcontain ${hasErrors(bean: premiumMasterVar, field: 'renewalDate', 'error')} required">
										<label for="renewalDate"> <g:message
												code="premiumMaster.renewalDate.label"
												default="Renew Date :" />
										</label>
										<g:datePicker name="detail.0.renewalDate" precision="day"
											noSelection="['':'']"
											value="${premiumMasterVar?.renewalDate}" default="none" />
									</div>
								</td>
								<td  >
									<div
										class="fieldcontain ${hasErrors(bean: premiumMasterVar, field: 'termReason', 'error')} ">
										<label for="termReason"> <g:message
												code="premiumMaster.termReason.label"
												default="Term Reason :" />

										</label> <input type="hidden" name="TermReasonType"
											id="TermReasonType" value="TM" />
										<g:textField name="detail.0.termReason" maxlength="5" class="RemoveSpecialChars"
											value="${premiumMasterVar?.termReason}" />
										<img width="25" height="25"
											style="float: none; vertical-align: bottom"
											class="magnifying" src="${resource(dir: 'images', file: 'Search-icon.png')}"
											onclick="lookup('detail.0.termReason', 'com.perotsystems.diamond.dao.cdo.ReasonCodeMaster','reasonCode', 'TermReasonType', 'reasonCodeType', null, null)">
									</div>
								</td>
								<td  style="white-space:nowrap">
									<div
										class="fieldcontain ${hasErrors(bean: premiumMasterVar, field: 'multiPlanEnroll', 'error')} ">
										<label for="multiPlanEnroll"> <g:message
												code="premiumMaster.multiPlanEnroll.label"
												default="Multi Plan Enroll :" />
										<span class="required-indicator">*</span>	</label>
										<g:textField maxlength="1" name="detail.0.multiPlanEnroll" disabled="${multiPlanEnabled ? 'false'  : 'disabled'}" 
											value="${multiPlanEnabled ? premiumMasterVar?.multiPlanEnroll : "N"}" onchange="upperMe('detail.0.multiPlanEnroll')"
											title = "Enter N to prevent enrollment in multiple plans with the same product type; or Y to allow"/>	
									</div>
								</td>			
							</tr>
							<tr>
								<td>
									<div
										class="fieldcontain ${hasErrors(bean: premiumMasterVar, field: 'recordStatus', 'error')} ">
										<label for="recordStatus"> <g:message
												code="premiumMaster.recordStatus.label"
												default="Record Status :" />

										</label>
										<g:textField name="detail.0.recordStatus"  maxlength="15" class="RemoveSpecialChars"
											value="${premiumMasterVar?.recordStatus}" />
									</div>
								</td>
								<td>
								</td>
								<td class="tdFormElement" style="white-space: nowrap">
									<div class="fieldcontain" ${hasErrors(bean: premiumMasterVar, field: 'giaAmount', 'error')} ">
										<label for="giaAmount"> <g:message
												code="premiumMaster.giaAmount.label"
												default="GIA Amount :" />
										</label>
										<span class="currencyinput">$
										<g:textField name="detail.0.giaAmount" disabled ="disabled" class="amtNumeric" maxlength="21"
											value="${formatNumber(number: premiumMasterVar?.giaAmount, format: '#####0.00')}"
											title = "Enter GIA amount for life insurance policies"/>
										</span>
									</div>
								</td>
							</tr>
							<tr>
								<td style="white-space:nowrap">
									<div
										class="fieldcontain ${hasErrors(bean: premiumMasterVar, field: 'convYearStartDate', 'error')} required">
										<label for="convYearStartDate"> <g:message
												code="premiumMaster.convYearStartDate.label"
												default="Cont Yr Start Date :" />
										</label>
										<g:datePicker name="detail.0.convYearStartDate"
											precision="day" noSelection="['':'']"
											value="${premiumMasterVar?.convYearStartDate}" default="none" />
									</div>
								</td>
								<td style="white-space:nowrap">
									<div
										class="fieldcontain ${hasErrors(bean: premiumMasterVar, field: 'glRefCode', 'error')} required">
										<label for="glRefCode"> <g:message
												code="premiumMaster.glRefCode.label"
												default="G/L Ref Code  :" /> 
										</label>
										<g:secureTextField name="detail.0.glRefCode" onchange="upperMe('detail.0.companyCode'), populateCompanyCode()" onblur = "populateCompanyCode()"
		 								tableName="PREMIUM_MASTER" attributeName="glRefCode"
		 								value="${premiumMasterVar?.glRefCode}" ></g:secureTextField>
		 								<img width="25" height="25"
											style="float: none; vertical-align: bottom"
											class="magnifying" src="${resource(dir: 'images', file: 'Search-icon.png')}"
											onclick="lookup('detail.0.glRefCode', 'com.perotsystems.diamond.dao.cdo.GeneralLedgerReference','glRefCode', null, null, null, null)">
											
									</div>
								</td>	
								<td style="white-space:nowrap">
									<div
										class="fieldcontain ${hasErrors(bean: premiumMasterVar, field: 'companyCode', 'error')} required">
										<label for="companyCode"> <g:message
												code="premiumMaster.companyCode.label"
												default="Company Code  :" /> 
										</label>
										<g:secureTextField name="detail.0.companyCode" readOnly="true" style="color: #48802C" 
		 								tableName="PREMIUM_MASTER" attributeName="companyCode"
		 								value="${premiumMasterVar?.companyCode}" ></g:secureTextField>
		 								<img width="25" height="25"
											style="float: none; vertical-align: bottom"
											class="magnifying" src="${resource(dir: 'images', file: 'Search-icon.png')}"
											onclick="lookup('detail.0.companyCode', 'com.perotsystems.diamond.dao.cdo.CompanyMaster','companyCode', null, null, null, null)">
									</div>
								</td>	
							</tr>
							<tr>
							</tr>
						</table> 
					</td>
				</tr>
			</table>


			<fieldset class="buttons">
				<g:actionSubmit class="save" action="savePremiumMaster"
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
