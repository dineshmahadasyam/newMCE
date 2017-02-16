<%@ page import="com.perotsystems.diamond.bom.GroupEx"%>
<%@ page import="com.dell.diamond.fms.enums.PageNameEnum" %>
<!DOCTYPE html>
<html>
<head>
<meta name="layout" content="main">
			
<g:set var="entityName" value="${message(code: 'groupMaster.label', default: 'GroupMaster')}" />
<g:set var="appContext" bean="grailsApplication"/>
<g:set var="isShowCalendarIcon" value="${PageNameEnum.GROUP_ADD_DETAIL.equals(currentPage)?true:false}" />	
<title><g:message code="default.edit.label" args="[entityName]" /></title>

<!-- Main menu select -->
<meta name="navSelector" content="maint"/>
<!-- Child menu select -->
<meta name="navChildSelector" content="groupMaintenance"/>

<!-- <script type="text/javascript" src="${resource(dir: 'js', file: 'jquery-ui-1.7.2.js')}"></script> -->
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
	ignore: ":hidden",	
	debug: true			 
	});
$(function() {		
		$("#editForm").validate({
			submitHandler: function (form) {
				  isInvalidForm = 'false';
				  if ($(form).valid()) 
                      form.submit(); 
                  return false; // prevent normal form posting
	        },
	        invalidHandler: function(event, validator) {            
	            isInvalidForm = 'true';     	
	        },	        
			errorLabelContainer: "#errorDisplay", 
			 wrapper: "li",		
							
			rules : {
				'detail.0.effectiveDate' :  {
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
						return $.trim($("#detail\\.0\\.endDate").val()).length > 0 
					}
				},
				'detail.0.endDate' :  {
					required : function(element){														
						return $.trim($("#detail\\.0\\.termReason").val()).length > 0 	;						
					},
					greaterThan:[ "#detail\\.0\\.effectiveDate","#detail\\.0\\.endDate","Effective Date","Term Date"]
				},
			},
			messages : {
				'detail.0.effectiveDate' :  {
					required : "Effective Date is a mandatory field, please input the value for Effective date"						
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
				'detail.0.endDate' :  {
					required : "Term Date is a mandatory field if Term reason is entered, please input the value for Term Date"
				},
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
	
	/* DIA00059413 Dasari: 10th March, 2016 Enable below code once it is fixed in old UI and then in UIUX.
	
	var tempProductType = productType.value;
	if(tempProductType != null){
	  	var index = tempProductType.indexOf("-");
			var prodType = tempProductType.substr(0 , index).trim();
			if(prodType != null && prodType == 'SPLSL' || prodType == 'LIFE' || prodType == 'BETL' || prodType == 'SPLDL' || prodType == 'SPLEL'){
				document.getElementById("detail.0.giaAmount").disabled="";
			}
	    }*/
	 
});

function upperMe(value) { 
	document.getElementById(value).value = document.getElementById(value).value.toUpperCase(); 
}
function toggleDIV(countt){
	 var recordType = document.getElementById("detail.0.recordType").value;
		 	 
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

function isMultiPlanEnabled() {
	 var lob = document.getElementById("detail.0.lineOfBusiness").value;
	 
	 if(lob != null) {
	 
			var multiplan = jQuery.ajax({
			url : '<g:createLinkTo dir="/groupMaintenance/ajaxGetMultiplanValue"/>',				
			type : "POST",
			data : {lob:lob},
			success : function(result) {
				if(result != null && (result == "" || result == "N")){
					document.getElementById("detail.0.multiPlanEnroll").value="N"
					document.getElementById("detail.0.multiPlanEnroll").setAttribute("readonly", true);
					}
				else if(result != null && result == "Y"){
					document.getElementById("detail.0.multiPlanEnroll").removeAttribute("readonly");
					}
			}
		});
	}
	 else{
		 document.getElementById("detail.0.multiPlanEnroll").value="N"
		 document.getElementById("detail.0.multiPlanEnroll").setAttribute("readonly", true);
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

<g:javascript>
	function closeForm() {
		var groupDBId = "${params.groupDBId}";
		var groupId = "${groupMasterInstance.groupId}";
		var appName = "${appContext.metadata['app.name']}";
		window.location.assign("/"+appName+"/groupMaintenance/edit/" + groupId +
		"?groupId=" + groupId + "&groupDBId=" + groupDBId + "&groupEditType=DETAIL");
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
</script>
<script type="text/javascript">

	$(document).ready(function() {

		var prmastersSize = ${groupMasterInstance?.premiumMasters?.size()};	
		for (var i = 0; i < prmastersSize; i++) { 			
			toggleDIV(i);
		}
	});
</script>
</head>

<!-- START - FMS Content -->
	<div id="fms_content">
		<div id="fms_content_header">
	    	<div class="fms_content_header_note">
	      		<a href="${createLink(uri: '/groupMaintenance/list')}">group Maintenance</a> / 
	      		<g:link class="list" action="edit" params="${[groupId: request.getParameter('groupId'), groupDBId : request.getParameter("groupDBId"), groupEditType :'DETAIL']}">Detail Records</g:link>
	      			/ Add detail to Group with GroupId - ${groupMasterInstance?.groupId}
	  		</div>
		  	<div class="fms_content_title">
	          	<h1>Add New Detail</h1>
	        </div>
		</div> 
		<%-- START - Tabs --%>
			<div id="fms_content_tabs">
				<ul>
					<li><g:link class="list" action="edit" params="${[groupId: request.getParameter('groupId'), groupDBId : request.getParameter("groupDBId"), groupEditType :'MASTER']}">Master Records</g:link></li>
				 	<li><g:link class="list" action="edit" params="${[groupId: request.getParameter('groupId'), groupDBId : request.getParameter("groupDBId"), groupEditType :'CONTRACT']}">Contracts</g:link></li>
					<li><g:link class="active" action="edit" params="${[groupId: request.getParameter('groupId'), groupDBId : request.getParameter("groupDBId"), groupEditType :'DETAIL']}">Detail Records</g:link></li>
					<li><g:link class="list" action="edit" params="${[groupId: request.getParameter('groupId'), groupDBId : request.getParameter("groupDBId"), groupEditType :'ADDRESS']}">Addresses</g:link></li>
					<li><g:link class="list" action="edit" params="${[groupId: request.getParameter('groupId'), groupDBId : request.getParameter("groupDBId"), groupEditType :'CONTACT']}">Contacts</g:link></li>
					<li><g:link class="list" action="edit" params="${[groupId: request.getParameter('groupId'), groupDBId : request.getParameter("groupDBId"), groupEditType :'COMMRATES']}">Group Rates</g:link></li>
				</ul>
			<div id="mobile_tabs_select"></div>
		</div>
		<%-- END - Tabs --%>
		<!-- START - FMS Content Body -->
		<div id="fms_content_body">
		<div class="right-corner" align="right">GRUPD</div>
		<div class="fms_required_legend fms_required">= required</div> 
	 	  	<div class="fms_form_border">
	    		<div class="fms_form_body fms_form_border">
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
					<div id="show-memberMaster" class="content scaffold-show" role="main">
					&nbsp;
					<g:form action="savePremiumMaster" id="editForm" name="editForm">
					<ul id="errorDisplay" style="display: none;" class="errors" role="alert" style="float:left; margin: -5px 10px 0px 0px; "></ul>
					<g:hiddenField name="id" value="${groupMasterInstance?.groupId}" />
					<g:hiddenField name="groupId" value="${groupMasterInstance?.groupId}" />
					<g:hiddenField name="groupDBId" value="${groupMasterInstance?.groupDBId}" />
					<!-- START - WIDGET: General Information -->
		    			<div id="widgetGeneral" class="fms_widget">
				 			<fieldset class="no_border">
								<legend><h2>Add New Detail</h2></legend>
		                  		<div class="fms_form_layout_2column">                  
		                    	<div class="fms_form_column fms_long_labels">
			                    	<label for="rcdType" class="control-label fms_required" id="rcdType_label"> 
			                    		<g:message code="premiumMaster.recordType.label" default="Record Type :" />
									</label>
									<div class="fms_form_input">
									<g:getDiamondDataWindowDetail 
												columnName="record_type"
												dwName="dw_grupd_de" languageId="0"
												htmlElelmentId="detail.0.recordType"
												defaultValue="${premiumMasterVar?.recordType}"
												blankValue="Record Type"
												disable="true"
												onchange="toggleDIV(${0})" 
			                    				cssClass="form-control"
												aria-labelledby="rcdType_label" 
												aria-describedby="rcdType_error" 
												aria-required="false"/>
										<div class="fms_form_error" id="rcdType_error"></div>
									</div> 
									
									<label for="planRiderCode" class="control-label fms_required" id="planRiderCode_label"> 
										<g:message code="premiumMaster.planRiderCode.label" default="Plan/Rider Code :" />
									</label>
								<div class="fms_form_input fms_has_feedback">
									<g:secureTextField
										name="detail.0.planRiderCode"
										tableName="PREMIUM_MASTER" attributeName="planRiderCode"
										value="${premiumMasterVar?.planRiderCode}" maxlength="50"
										onchange="upperMe('detail.0.planRiderCode'), populateProductType()"  
										onblur = "populateProductType()"
										class="form-control" aria-labelledby="planRiderCode_label" 
										aria-describedby="planRiderCode_error" aria-required="false">
									</g:secureTextField>
									<div id="planCodeDiv${0}">
			                      	 <fmsui:cdoLookup lookupElementId="detail.0.planRiderCode"
			                                     	  lookupElementName="detail.0.planRiderCode" 
			                                      	  lookupElementValue="${premiumMasterVar?.planRiderCode}"
			                                       	  lookupCDOClassName="com.perotsystems.diamond.dao.cdo.PlanMaster" 
			                                       	  lookupCDOClassAttribute="planCode"
			                                       	  onclick="findPlanRider()"/>
			                          </div>
							         <div id="riderCodeDiv${0}" >
			                         <fmsui:cdoLookup lookupElementId="detail.0.planRiderCode"
				                                      lookupElementName="detail.0.planRiderCode" 
				                                      lookupElementValue="${premiumMasterVar?.planRiderCode}"
				                                      lookupCDOClassName="com.perotsystems.diamond.dao.cdo.RiderMaster" 
				                                      lookupCDOClassAttribute="riderCode"
				                                      onclick="findPlanRider()"/>
                         			  </div>
										<div class="fms_form_error" id="planRiderCode_error"></div>
								</div> 	
								<label for="lineOfBusiness" class="control-label fms_required" id="lineOfBusiness_label"> 
									<g:message code="premiumMaster.lineOfBusiness.label" default="Line Of Business :" /> 
								</label>
								<div class="fms_form_input fms_has_feedback">
								<g:secureTextField 
									name="detail.0.lineOfBusiness" 
									tableName="PREMIUM_MASTER" attributeName="lineOfBusiness"
									value="${premiumMasterVar?.lineOfBusiness}"
									onchange="upperMe('detail.0.lineOfBusiness'), isMultiPlanEnabled()" onblur = "isMultiPlanEnabled()"
									class="form-control" aria-labelledby="lineOfBusiness_label" 
									aria-describedby="lineOfBusiness_error" aria-required="false">
								</g:secureTextField>
									<fmsui:cdoLookup lookupElementId="detail.0.lineOfBusiness"
	                                                 lookupElementName="detail.0.lineOfBusiness"
	                                                 lookupElementValue="${premiumMasterVar?.lineOfBusiness}"
	                                                 lookupCDOClassName="com.perotsystems.diamond.dao.cdo.LineOfBusinessMaster"
	                                                 lookupCDOClassAttribute="lineOfBusiness"/>
								<div class="fms_form_error" id="lineOfBusiness_error"></div>
								</div>
										
								<label for="effectiveDate" class="control-label fms_required" id="effectiveDate_label"> 
									<g:message code="premiumMaster.effectiveDate.label"	default="Effective Date :" /> 
								</label>			
								<div class="fms_form_input">
								<fmsui:jqDatePickerUIUX
									datePickerOptions="changeMonth:true, changeYear:true, yearRange:'-100:+100', numberOfMonths: 1"
		                            dateElementId="detail.0.effectiveDate"
									dateElementName="detail.0.effectiveDate" mandatory="mandatory"
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
								<fmsui:jqDatePickerUIUX 
									datePickerOptions="changeMonth:true, changeYear:true, yearRange:'-100:+100', numberOfMonths: 1"
									dateElementId="detail.0.endDate"
									dateElementName="detail.0.endDate" mandatory="mandatory"
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
		                    	<input type="hidden" name="TermReasonType" id="TermReasonType" value="TM" />
									<g:secureTextField 
										name="detail.0.termReason"
										tableName="PREMIUM_MASTER" attributeName="termReason"
										value="${premiumMasterVar?.termReason}" maxlength="5"
										class="form-control" aria-labelledby="termReason_label" 
										aria-describedby="termReason_error" aria-required="false">
									</g:secureTextField>
									<fmsui:cdoLookup lookupElementId="detail.0.termReason"
                                                 lookupElementName="detail.0.termReason" 
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
									<g:secureTextField name="detail.0.glRefCode" onchange="upperMe('detail.0.companyCode'), populateCompanyCode()"
														onblur = "populateCompanyCode()"
						 								tableName="PREMIUM_MASTER" attributeName="glRefCode"
						 								value="${premiumMasterVar?.glRefCode}" 
														class="form-control" aria-labelledby="glRefCode_label" 
														aria-describedby="glRefCode_error" aria-required="false">
									</g:secureTextField>
										<fmsui:cdoLookup lookupElementId="detail.0.glRefCode"
				                                         lookupElementName="detail.0.glRefCode"
				                                         lookupElementValue="${premiumMasterVar?.glRefCode}"
				                                         lookupCDOClassName="com.perotsystems.diamond.dao.cdo.GeneralLedgerReference"
				                                         lookupCDOClassAttribute="glRefCode"/>	
										<div class="fms_form_error" id="glRefCode_error"></div>
									</div> 
									
									<label for="companyCode" class="control-label " id="companyCode_label">
									<g:message code="premiumMaster.companyCode.label" default="Company Code  :"  />
							</label>
							<div class="fms_form_input fms_has_feedback">
									<g:secureTextField name="detail.0.companyCode" readOnly="true" style="color: #48802C" 
						 								tableName="PREMIUM_MASTER" attributeName="companyCode"
						 								value="${premiumMasterVar?.companyCode}"  
														class="form-control" aria-labelledby="companyCode_label" 
														aria-describedby="companyCode_error" aria-required="false">
									</g:secureTextField>
										<fmsui:cdoLookup lookupElementId="detail.0.companyCode"
				                                         lookupElementName="detail.0.companyCode"
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
								<fmsui:jqDatePickerUIUX 
										datePickerOptions="changeMonth:true, changeYear:true, yearRange:'-100:+100', numberOfMonths: 1"
										dateElementId="detail.0.renewalDate"
										dateElementName="detail.0.renewalDate" mandatory="mandatory"
										dateElementValue="${formatDate(format:'MM/dd/yyyy',date: premiumMasterVar?.renewalDate)}" 
										ariaAttributes="aria-labelledby='renewalDate_label' aria-describedby='renewalDate_error' aria-required='false'" 
				                        classAttributes ="class='form-control fms_date_mask fms_small_input onDelete hasDatepicker' "
				                        showIconDefault="${isShowCalendarIcon}"/>	                                  
				                        <div class="fms_form_error" id="renewalDate_error"></div>
								</div>	
								<label for="productType" class="control-label" id="productType_label"> 
									<g:message code="planMaster.productType.label" default="Product Type :" />
								</label>
								<div class="fms_form_input">
								<g:textField 
									class="form-control"
									readOnly="true" 
									name="productType" 
									value="${productType}"/>
									<div class="fms_form_error" id="productType_error"></div>
								</div>
		                    										
								<label for="multiPlanEnroll" class="control-label fms_required" id="multiPlanEnroll_label">
									<g:message code="premiumMaster.multiPlanEnroll.label" default="Multi Plan Enroll :" />
								</label>
								<div class="fms_form_input">
									<g:textField maxlength="1" class="form-control"
										name="detail.0.multiPlanEnroll" 
										readonly= "true" 
										value="${premiumMasterVar?.multiPlanEnroll}"
										onchange="upperMe('detail.0.multiPlanEnroll')"
										title = "Enter N to prevent enrollment in multiple plans with the same product type; or Y to allow"/>
									<div class="fms_form_error" id="multiPlanEnroll_error"></div>
								</div> 
								<label for="recordStatus" class="control-label" id="recordStatus_label"> 
		                    		<g:message code="premiumMaster.recordStatus.label" default="Record Status :" />
								</label>
		                    	<div class="fms_form_input">
		                    	<g:textField
		                    				class="form-control" maxlength="15"
		                    				name="detail.0.recordStatus"
											value="${premiumMasterVar?.recordStatus}" />
		                    	<div class="fms_form_error" id="recordStatus_error"></div>
								</div>	
								<label for="giaAmount" class="control-label" id="giaAmount_label" > 
									<g:message code="premiumMaster.giaAmount.label"	default="GIA Amount :" />
								</label>
							<div class="fms_form_input fms_has_feedback_money">
            					<span class="fms_form_control_dollar"></span>
								<g:textField 
											class="form-control fms_small_input fms_mask_money"
											name="detail.0.giaAmount" disabled ="disabled" 
											maxlength="21"
											value="${formatNumber(number: premiumMasterVar?.giaAmount, format: '#####0.00')}"
											title = "Enter GIA amount for life insurance policies"
											aria-labelledby="giaAmount_r1_label" aria-describedby="giaAmount_r1_error" aria-required="false" placeholder="0.00" />
								<div class="fms_form_error" id="giaAmount_error"></div>
							</div>
							
							<label for="convYearStartDate" class="control-label" id="convYearStartDate_label"> 
								<g:message code="premiumMaster.convYearStartDate.label"	default="Cont Yr Start Date :" /> 
							</label>
							<div class="fms_form_input">	
								<fmsui:jqDatePickerUIUX
									datePickerOptions="changeMonth:true, changeYear:true, yearRange:'-100:+100', numberOfMonths: 1" 
									dateElementId="detail.0.convYearStartDate"
									dateElementName="detail.0.convYearStartDate" mandatory="mandatory"
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
		           <div class="fms_form_button">
				 	<g:actionSubmit class="btn btn-primary" action="savePremiumMaster" value="${message(code: 'default.button.save.label', default: 'Save')}" />
				 	<input type="Reset" class="btn btn-default" value="Reset" id="resetButton" />
					<input type="button" class="btn btn-default" name="close" value="${message(code: 'default.button.cancel.label', default: 'Cancel')}" onClick="closeForm()"/>
      			</div>		
			</g:form>
			</div>
		</div>
	 </div>
   </div>
 </html>