<%@ page import="com.perotsystems.diamond.bom.GroupEx"%>
<!DOCTYPE html>
<html>
<head>
<meta name="layout" content="main_2">
<style type="text/css">
TD {
	line-height: 1.4em;
	padding: 0em 0em;
	text-align: left;
	vertical-align: middle;
}

.fieldcontain {
	margin-top: 0.1em;
}

.fieldcontain LABEL,.fieldcontain .property-label {
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

<g:set var="appContext" bean="grailsApplication" />

<title><g:message code="default.edit.label" args="[entityName]" /></title>
<script type="text/javascript"
	src="${resource(dir: 'js', file: 'jquery-1.3.2.js')}"></script>
<script type="text/javascript"
	src="${resource(dir: 'js', file: 'jquery-ui-1.7.2.js')}"></script>
<script type="text/javascript"
	src="${resource(dir: 'js', file: 'jquery.window.js')}"></script>
		<script type="text/javascript" src="${resource(dir: 'js', file: 'jquery.alphanum.js')}"></script>
		
		<script type="text/javascript" src="${resource(dir: 'js', file: 'commonfunctions.js')}"></script>
		<script type="text/javascript" src="${resource(dir: 'js', file: 'jquery.validate.js')}"></script>


<script type="text/javascript"
	src="${resource(dir: 'js', file: 'jquery.validate.js')}"></script>
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
				'contract.0.effectiveDate_day' :  {
					required : true
				},
				'contract.0.effectiveDate_month' :  {
					required : true
				},
				'contract.0.effectiveDate_year' :  {
					required : true
				},
				'contract.0.numberOfEmployees' :{
					digits : true
				},
				'contract.0.newbornAgeDays'	: {
					digits : true
				},
				'contract.0.termReason' :  {
					required : function(element){														
						return $.trim($("#contract\\.0\\.termDate_year").val()).length > 0 ||
						$.trim($("#contract\\.0\\.termDate_month").val()).length > 0 ||
						$.trim($("#contract\\.0\\.termDate_day").val()).length > 0;						
					}
				},
				'contract.0.termDate_year' :  {
					required : function(element){														
						return $.trim($("#contract\\.0\\.termReason").val()).length > 0 	;						
					},
					greaterThan:[ "#contract\\.0\\.effectiveDate","#contract\\.0\\.termDate","Effective Date","Term Date"]
				},
				'contract.0.termDate_month' :  {
					required : function(element){														
						return $.trim($("#contract\\.0\\.termReason").val()).length > 0 	;						
					}
				},
				'contract.0.termDate_day' :  {
					required : function(element){														
						return $.trim($("#contract\\.0\\.termReason").val()).length > 0 	;						
					}
				},

				'contract.0.claimActionCode' :  {
					required : function(element){														
						return $.trim($("#contract\\.0\\.claimGraceDays").val()).length > 0  ;						
					}
				},
				'contract.0.claimReason' :  {
					required : function(element){														
						return $.trim($("#contract\\.0\\.claimGraceDays").val()).length > 0 &&  
						$.trim($("#contract\\.0\\.claimActionCode").val()).length > 0 ;						
					}
				}
			},
			messages : {
				'contract.0.effectiveDate_day' :  {
					required : "Effective Date - Day is a mandatory field, please input the value for Effective date - Day"						
				},
				'contract.0.effectiveDate_month' :  {
					required : "Effective Date - Month is a mandatory field, please input the value for Effective date - Month"
				},
				'contract.0.effectiveDate_year' :  {
					required : "Effective Date - Year is a mandatory field, please input the value for Effective date - Year"
				},
				'contract.0.termDate_year' :  {
					required : "Term Date Year is a mandatory field if Term reason is entered, please input the value for Term Date Year"
				},
				'contract.0.termDate_month' :  {
					required : "Term Date Month is a mandatory field if Term reason is entered, please input the value for Term Date Month"
				},
				'contract.0.termDate_day' :  {
					required : "Term Date Day is a mandatory field if Term reason is entered, please input the value for Term Date Day"
				},
				'contract.0.claimActionCode' :  {
					required : "claimActionCode is a mandatory field if claimGraceDays is entered, please input the value for claimActionCode"
				},
				'contract.0.claimReason' :  {
					required : "claimReason is a mandatory field if claimGraceDays and claimActionCode is entered, please input the value for claimReason"
				},
				'contract.0.numberOfEmployees' :{
					digits : "Please enter only number for employees"
				},	
				'contract.0.newbornAgeDays'	: {
					digits : "Please enter only numbers for NB Age in Days"
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
function claimActionCodeDisabled(){		
	
	var claimGraceDays = document.getElementById('contract.0.claimGraceDays').value.trim()	
	if(claimGraceDays.trim() !=""  && isNaN(claimGraceDays.trim())==false){
		document.getElementById('contract.0.claimActionCode').disabled = false   
	}else{		
		document.getElementById('contract.0.claimActionCode').selectedIndex =0; 
		document.getElementById('contract.0.claimReason').value=""	
        document.getElementById('contract.0.claimActionCode').disabled = true
        document.getElementById('contract.0.claimReason').disabled = true              
        
		}
	
}

function claimReasonDisabled()
{
	var claimActionCode = document.getElementById('contract.0.claimActionCode').value.trim()
	if(claimActionCode!=null){			
		if(claimActionCode.trim()=='D' || claimActionCode.trim()=='H'){	
		 document.getElementById('contract.0.claimReason').disabled = false
	}else{		
       
		document.getElementById('contract.0.claimReason').disabled = true
		}
		}	
}

 function isNumberKey(evt) {
	var charCode = (evt.which) ? evt.which : event.keyCode
	         if ((charCode > 47 && charCode < 58) || (charCode > 64 && charCode < 91) || (charCode > 96 && charCode < 123))
	            return true;

	         return false;
		}

</script>

<script type="text/javascript">
$(function($){
	   $("#termReason").alphanum({
		    allow 		: '-_',
		    allowSpace  : false
		});
	   
	   $("#salespersonName").alphanum({
		    allow 		: '-_',
		    allowSpace  : false
		});
	   
	   $("#newbornProcRsn").alphanum({
		    allow 		: '-_',
		    allowSpace  : false
		});

	   $("#newbornOthContRsn").alphanum({
		    allow 		: '-_',
		    allowSpace  : false
		});
	})
	
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
					<li>
						${error}
					</li>
				</g:each>
			</ul>
		</g:if>
		<g:form action="saveContract" id="editForm" name="editForm">
			<div id="errorDisplay" style="display: none;" class="errors"
				style="float:left; margin: -5px 10px 0px 0px; "></div>
			<g:hiddenField name="id" value="${groupMasterInstance?.groupId}" />
			<g:hiddenField name="groupId" value="${groupMasterInstance?.groupId}" />
			<g:hiddenField name="groupDBId"	value="${groupMasterInstance?.groupDBId}" />

			<h1 style="color: #48802C">
				Add Contract to Group with GroupId -
				${groupMasterInstance?.groupId}
			</h1>
			<div class="right-corner" align="center">GRUPC</div>			
			<table>
				<tr>
					<td>
						<table class="report1" border="0">
							<tr>
								<td style="white-space: nowrap">
									<div class="fieldcontain ${hasErrors(bean: contract, field: 'contract.effectiveDate', 'error')} ">
										<label for="effectiveDate"> <g:message
												code="groupMaster.effectiveDate.label"
												default="Effective Date:" /> <span
											class="required-indicator">*</span>

										</label>
										<g:datePicker name="contract.0.effectiveDate" precision="day"
											noSelection="['':'']" value="${contract?.effectiveDate}"
											default="none" />
									</div>
								</td>
								<td style="white-space: nowrap"><label> </label> <input
									type="hidden" /></td>
							</tr>
							<tr>
								<td style="white-space: nowrap">
									<div class="fieldcontain ${hasErrors(bean: contract, field: 'contract.termDate', 'error')} ">
										<label for="termDate"> <g:message
												code="groupMaster.termDate.label" default="Term Date:" />
										</label>
										<g:datePicker name="contract.0.termDate" precision="day"
											noSelection="['':'']" value="${contract?.termDate}"
											default="none" />
									</div>
								</td>
								<td style="white-space: nowrap">
									<div class="fieldcontain ${hasErrors(bean: contract, field: 'contract.termReason', 'error')} ">
										<label for="termReason"> <g:message
												code="groupMaster.termReason.label" default="Term Reason:" />
										</label> <input type="hidden" name="TermReasonType"
											id="TermReasonType" value="TM" />
										<g:textField name="contract.0.termReason" maxlength="5" 
											value="${contract?.termReason}" class="RemoveSpecialChars"/>
										<img width="25" height="25"
											style="float: none; vertical-align: bottom"
											class="magnifying"
											src="${resource(dir: 'images', file: 'Search-icon.png')}"
											onclick="lookup('contract.0.termReason', 'com.perotsystems.diamond.dao.cdo.ReasonCodeMaster','reasonCode', 'TermReasonType', 'reasonCodeType', null, null)">
									</div>
								</td>
							</tr>
							<tr>
								<td style="white-space: nowrap">
									<div class="fieldcontain ${hasErrors(bean: contract, field: 'contract.openEnrollStart', 'error')} ">
										<label for="openEnrollStart"> <g:message
												code="groupMaster.openEnrollStart.label"
												default="Open Enroll Start:" />
										</label>
										<g:datePicker name="contract.0.openEnrollStart"
											precision="day" noSelection="['':'']"
											value="${contract?.openEnrollStart}" default="none" />
									</div>
								</td>
								<td>
									<div class="fieldcontain ${hasErrors(bean: contract, field: 'contract.openEnrollEnd', 'error')} ">
										<label for="openEnrollEnd"> <g:message
												code="groupMaster.openEnrollEnd.label"
												default="Open Enroll End:" />
										</label>
										<g:datePicker name="contract.0.openEnrollEnd" precision="day"
											noSelection="['':'']" value="${contract?.openEnrollEnd}"
											default="none" />

									</div>
								</td>
							</tr>
							<tr>
								<td>
									<div class="fieldcontain ${hasErrors(bean: contract, field: 'contract.numberOfEmployees', 'error')} ">
										<label for="numberOfEmployees"> <g:message
												code="groupMaster.numberOfEmployees.label"
												default="No. of Employees:" />
										</label>
										<g:textField name="contract.0.numberOfEmployees" maxlength="6"
											value="${contract?.numberOfEmployees}" />
									</div>
								</td>
								<td>
									<div class="fieldcontain ${hasErrors(bean: contract, field: 'contract.waitingPeriod', 'error')} ">
										<label for="waitingPeriod"> <g:message
												code="groupMaster.waitingPeriod.label"
												default="Waiting period: " />
										</label>
										<g:textField name="contract.0.waitingPeriod"
											value="${contract?.waitingPeriod}" />
									</div>
								</td>
							</tr>
							<tr>
								<td>
									<div class="fieldcontain ${hasErrors(bean: contract, field: 'contract.contractType', 'error')} ">
										<label for="contractType"> <g:message
												code="groupMaster.contractType.label"
												default="Contract Type: " />
										</label>
										<g:textField name="contract.0.contractType" onkeypress="return isNumberKey(event)"
											value="${contract?.contractType}" maxlength="1"/>
									</div>
								</td>
								<td>
									<div class="fieldcontain ${hasErrors(bean: contract, field: 'contract.recordStatus', 'error')} ">
										<label for="recordStatus"> <g:message
												code="groupMaster.recordStatus.label"
												default="Record Status: " />
										</label>
										<g:textField name="contract.0.recordStatus"
											value="${contract?.recordStatus}" />
									</div>
								</td>
							</tr>
							<!--<tr>
								<td>
									<div
										class="fieldcontain ${hasErrors(bean: contract, field: 'contract.claimGraceDays', 'error')} ">
										<label for="claimGraceDays"> <g:message
												code="groupMaster.claimGraceDays.label"
												default="Claim Grace Days:" />
										</label>
										<g:textField name="contract.0.claimGraceDays"
											value="${contract?.claimGraceDays}"  onkeyup="claimActionCodeDisabled(this)" />
									</div>
								</td>
								<td>
									<div class="fieldcontain ${hasErrors(bean: contract, field: 'contract.claimActionCode', 'error')} ">
										<label for="claimActionCode"> <g:message
												code="groupMaster.claimActionCode.label"
												default="Claim Action: " />
										</label>
										<g:getDiamondDataWindowDetail columnName="claim_action_code"
												dwName="dw_group_contract_de" languageId="0"
												htmlElelmentId="contract.0.claimActionCode"
												defaultValue="${contract?.claimActionCode}"
												blankValue="claimActionCode" width="150px"  disable="disabled" onchange="claimReasonDisabled()" />		
									</div>
								</td>
							</tr>-->
							<tr>
								<!-- <td>
									<div
										class="fieldcontain ${hasErrors(bean: contract, field: 'contract.claimReason', 'error')} ">
										<label for="claimReason"> <g:message
												code="groupMaster.claimReason.label"
												default="Claim Reason: " />
										</label>
										<g:textField name="contract.0.claimReason"
											value="${contract?.claimReason}" disabled="true" />
											 <img width="25" height="25" id="claimReasonimg" disabled
									style="float: none; vertical-align: bottom"
									class="magnifying" src="${resource(dir: 'images', file: 'Search-icon.png')}"
									onclick="lookup('contract.0.claimReason', 'com.perotsystems.diamond.dao.cdo.ReasonCodeMaster','reasonCode', 'holdReasonType', 'reasonCodeType', null, null)">																							
									</div>
								</td> -->
								<td>
									<div class="fieldcontain ${hasErrors(bean: contract, field: 'contract.salespersonName', 'error')} ">
										<label for="salespersonName"> <g:message
												code="groupMaster.salespersonName.label"
												default="Sales Rep.: " />
										</label>
										<g:textField name="contract.0.salespersonName" maxlength="30"
											value="${contract?.salespersonName}" class="RemoveSpecialChars"/>
									</div>
								</td>
								<td>
									<div class="fieldcontain ${hasErrors(bean: contract, field: 'contract.brokerName', 'error')} ">
										<label for="brokerName"> <g:message
												code="groupMaster.brokerName.label" default="Broker: " />
										</label>
										<g:textField name="contract.0.brokerName"
											value="${contract?.brokerName}" />
									</div>
								</td>
								<!-- <td style="white-space: nowrap">
										<label>
										</label>
										<input type="hidden"/>
								</td> -->
							</tr>
							<tr><td colspan="2">&nbsp;</td>	</tr>
							<tr><td colspan="2">On Enrolled New Born Processing</td></tr>
							<tr><td colspan="2"><hr></td></tr>
							<tr>
								<td>
									<div class="fieldcontain ${hasErrors(bean: contract, field: 'contract.newbornAgeDays', 'error')} ">
										<label for="newbornAgeDays"> <g:message
												code="groupMaster.newbornAgeDays.label"
												default="NB Age in Days:" />
										</label>
										<g:textField name="contract.0.newbornAgeDays" maxlength="3"
											value="${contract?.newbornAgeDays}" />
									</div>
								</td>
								<!-- <td style="white-space: nowrap">
										<label>
										</label>
										<input type="hidden"/>
								</td>	
							 <td>
								<div class="fieldcontain ${hasErrors(bean: contract, field: 'contract.newbornProcMthd', 'error')} ">
										<label for="newbornProcMthd"> <g:message
												code="groupMaster.newbornProcMthd.label"
												default="New Born Proc Method:" />

										</label>
										<g:textField name="contract.0.newbornProcMthd"
											value="${contract?.newbornProcMthd}" />
									</div>
								</td>-->
								<td>
									<div class="fieldcontain ${hasErrors(bean: contract, field: 'contract.newbornProcRsn', 'error')} ">
										<label for="newbornProcRsn"> <g:message
												code="groupMaster.newbornProcRsn.label"
												default="New Born Proc Reason:" />
										</label>
										<g:textField name="contract.0.newbornProcRsn" maxlength="5"
											value="${contract?.newbornProcRsn}" class="RemoveSpecialChars"/>
									</div>
								</td>
							</tr>
							<tr>
								<td>
									<div class="fieldcontain ${hasErrors(bean: contract, field: 'contract.newbornAutoAdd', 'error')} ">
										<label for="newbornAutoAdd"> <g:message
												code="groupMaster.newbornAutoAdd.label"
												default="NewBorn Auto Add:" />
										</label>
										<g:textField name="contract.0.newbornAutoAdd" maxlength="1"
											value="${contract?.newbornAutoAdd}" class="RemoveSpecialChars"/>
									</div>
								</td>
								<!--<td style="white-space: nowrap">
										<label>
										</label>
										<input type="hidden"/>
								</td>
						 <td>
							<div class="fieldcontain ${hasErrors(bean: contract, field: 'contract.newbornOthContMthd', 'error')} ">
										<label for="newbornOthContMthd"> <g:message
												code="groupMaster.newbornOthContMthd.label"
												default="Other Contract Method:" />

										</label>
										<g:textField name="contract.0.newbornOthContMthd"
											value="${contract?.newbornOthContMthd}" />
									</div>
								</td> -->
								<td>
									<div class="fieldcontain ${hasErrors(bean: contract, field: 'contract.newbornOthContRsn', 'error')} ">
										<label for="newbornOthContRsn"> <g:message
												code="groupMaster.newbornOthContRsn.label"
												default="Other Contract Reason:" />

										</label>
										<g:textField name="contract.0.newbornOthContRsn" maxlength="5"
											value="${contract?.newbornOthContRsn}" class="RemoveSpecialChars"/>
									</div>
								</td>
							</tr>
							<tr>
								<td colspan="2">&nbsp;</td>
							</tr>
							<tr>
								<td colspan="2">Claim Dependent/Student Age Information</td>
							</tr>
							<tr>
								<td colspan="2"><hr></td>
							</tr>
							<!-- <tr>
								<td>
									<div class="fieldcontain ${hasErrors(bean: contract, field: 'depAgeLimit', 'error')} ">
										<label for="depAgeLimit"> <g:message
												code="premiumMaster.depAgeLimit.label"
												default="Depnt Age Limit:" />
										</label>
										<g:textField name="contract.0.depAgeLimit" />
									</div>
								</td>
								 <td style="white-space: nowrap">
										<label>
										</label>
										<input type="hidden"/>
								</td>
								<td>
									<div class="fieldcontain ${hasErrors(bean: contract, field: 'stuAgeLimit', 'error')} ">
										<label for="stuAgeLimit"> <g:message
												code="premiumMaster.stuAgeLimit.label"
												default="Stdnt Age Limit:" />
										</label>
										<g:textField name="contract.0.stuAgeLimit" />
									</div>
								</td>
							</tr>
							<tr>
							<td>
								<div class="fieldcontain ${hasErrors(bean: contract, field: 'depAgeLimitAction', 'error')} ">
									<label for="depAgeLimitAction"> <g:message
												code="premiumMaster.depAgeLimitAction.label"
												default="Depnt Age Limit Action:" />
										</label>
										<g:getDiamondDataWindowDetail
											columnName="dep_age_limit_action" dwName="dw_grupd_de"
											languageId="0"
											htmlElelmentId="contract.0.depAgeLimitAction"
											defaultValue="${contract?.depAgeLimitAction}"
											blankValue="Depnt Age Limit Action" width="150px" />
									</div>
								</td>	
								<td>
									<div class="fieldcontain ${hasErrors(bean: contract, field: 'depAgeLimitReason', 'error')} ">
										<label for="depAgeLimitReason"> <g:message
												code="premiumMaster.depAgeLimitReason.label"
												default="Depnt Age Reason:" />
										</label> <input type="hidden" name="holdReasonType"
											id="holdReasonType" value="HD" />
										<g:textField name="contract.0.depAgeLimitReason"
											value="${contract?.depAgeLimitReason}" />
										<img width="25" height="25"
											style="float: none; vertical-align: bottom"
											class="magnifying" src="${resource(dir: 'images', file: 'Search-icon.png')}"
											onclick="lookup('contract.0.depAgeLimitReason', 'com.perotsystems.diamond.dao.cdo.ReasonCodeMaster','reasonCode', 'holdReasonType', 'reasonCodeType', null, null)">
									</div>
								</td>
							</tr>-->
							<tr>
								<td>
									<div class="fieldcontain ${hasErrors(bean: contract, field: 'depConvOption', 'error')} ">
										<label for="depConvOption"> <g:message
												code="premiumMaster.depConvOption.label"
												default="Depnt Conversion Option:" />
										</label>
										<g:getSystemCodeToken systemCodeType="STDEPCNVOPT"
											languageId="0" htmlElelmentId="contract.0.depConvOption"
											blankValue="Depnt Conv Option"
											defaultValue="${contract?.depConvOption}" width="150px" />
									</div>
								</td>
								<td>
									<div class="fieldcontain ${hasErrors(bean: contract, field: 'depConvAction', 'error')} ">
										<label for="depConvAction"> <g:message
												code="premiumMaster.depConvAction.label"
												default="Depnt Conversion Action:" />
										</label>
										<g:getSystemCodeToken systemCodeType="STDEPCNVACT"
											languageId="0" htmlElelmentId="contract.0.depConvAction"
											blankValue="Depnt Conv Action"
											defaultValue="${contract?.depConvAction}" width="150px" />
									</div>
								</td>
							</tr>
							<tr>
								<!-- <td style="white-space: nowrap">
										<label>
										</label>
										<input type="hidden"/>
								</td> -->
								<td>
									<div class="fieldcontain ${hasErrors(bean: contract, field: 'stuAgeLimitAction', 'error')} ">
										<label for="stuAgeLimitAction"> <g:message
												code="premiumMaster.stuAgeLimitAction.label"
												default="Stdnt Age Limit Action:" />
										</label>
										<g:getDiamondDataWindowDetail
											columnName="stu_age_limit_action" dwName="dw_grupd_de"
											languageId="0" htmlElelmentId="contract.0.stuAgeLimitAction"
											defaultValue="${contract?.stuAgeLimitAction}"
											blankValue="Stdnt Age Limit Action" width="150px" />
									</div>
								</td>
								<!--  <td>
									<div class="fieldcontain ${hasErrors(bean: contract, field: 'stuAgeLimitReason', 'error')} ">
										<label for="stuAgeLimitReason"> <g:message
												code="premiumMaster.stuAgeLimitReason.label"
												default="Stdnt Age Reason:" />
										</label>
										<g:textField name="contract.0.stuAgeLimitReason"
											value="${contract?.stuNoVerificationReason}" />
										<img width="25" height="25"
											style="float: none; vertical-align: bottom"
											class="magnifying" src="${resource(dir: 'images', file: 'Search-icon.png')}"
											onclick="lookup('contract.0.stuAgeLimitReason', 'com.perotsystems.diamond.dao.cdo.ReasonCodeMaster','reasonCode', 'holdReasonType', 'reasonCodeType', null, null)">
									</div>
								</td>-->
								<td>
									<div class="fieldcontain ${hasErrors(bean: contract, field: 'stuConvOption', 'error')} ">
										<label for="stuConvOption"> <g:message
												code="premiumMaster.stuConvOption.label"
												default="Stdnt Conversion Option:" />
										</label>
										<g:getSystemCodeToken systemCodeType="STDEPCNVOPT"
											languageId="0" htmlElelmentId="contract.0.stuConvOption"
											blankValue="Stdnt Conv Option"
											defaultValue="${contract?.stuConvOption}" width="150px" />
									</div>
								</td>
							</tr>
							<tr>
								<td>
									<div class="fieldcontain ${hasErrors(bean: contract, field: 'stuConvAction', 'error')} ">
										<label for="stuConvAction"> <g:message
												code="premiumMaster.stuConvAction.label"
												default="Stdnt Conversion Action:" />
										</label>
										<g:getSystemCodeToken systemCodeType="STDEPCNVACT"
											languageId="0" htmlElelmentId="contract.0.stuConvAction"
											blankValue="Stdnt Conv Action"
											defaultValue="${contract?.stuConvAction}" width="150px" />
									</div>
								</td>
								<td></td>
							</tr>
							<!-- <tr>
								 <td>
									<div class="fieldcontain ${hasErrors(bean: contract, field: 'stuAgeLimitAction', 'error')} ">
										<label for="stuNoVerificationAction"> <g:message
												code="premiumMaster.stuNoVerificationAction.label"
												default="Stdnt No Verif Age Action:" />
										</label>
										<g:getDiamondDataWindowDetail
											columnName="stu_age_limit_action" dwName="dw_grupd_de"
											languageId="0"
											htmlElelmentId="contract.0.stuNoVerificationAction"
											defaultValue="${contract?.stuNoVerificationAction}"
											blankValue="Stdnt No Verif Age Action" width="150px" />
									</div>
								</td>
								<td>
									<div class="fieldcontain ${hasErrors(bean: contract, field: 'stuNoVerificationReason', 'error')} ">
										<label for="stuNoVerificationReason"> <g:message
												code="premiumMaster.stuNoVerificationReason.label"
												default="Stdnt No Verif Age Reason:" />
										</label>
										<g:textField name="contract.0.stuNoVerificationReason"
											value="${contract?.stuNoVerificationReason}" />
										<img width="25" height="25"
											style="float: none; vertical-align: bottom"
											class="magnifying" src="${resource(dir: 'images', file: 'Search-icon.png')}"
											onclick="lookup('detail.0.stuNoVerificationReason', 'com.perotsystems.diamond.dao.cdo.ReasonCodeMaster','reasonCode', 'holdReasonType', 'reasonCodeType', null, null)">
									</div>
								</td>
							</tr>
							<tr>
							 <td>
								<div class="fieldcontain ${hasErrors(bean: contract, field: 'handcapNoVerfcnAgeAction', 'error')} ">
										<label for="handcapNoVerfcnAgeAction"> <g:message
												code="premiumMaster.handcapNoVerfcnAgeAction.label"
												default="Handicap No Verif Age Action:" />
										</label>
										<g:getDiamondDataWindowDetail
											columnName="stu_age_limit_action" dwName="dw_grupd_de"
											languageId="0"
											htmlElelmentId="contract.0.handcapNoVerfcnAgeAction"
											defaultValue="${contract?.handcapNoVerfcnAgeAction}"
											blankValue="Handicap no verif Action" width="150px" />
									</div>
								</td>	
								<td>
									<div class="fieldcontain ${hasErrors(bean: contract, field: 'handcapNoVerfcnAgeReason', 'error')} ">
										<label for="handcapNoVerfcnAgeReason"> <g:message
												code="premiumMaster.handcapNoVerfcnAgeReason.label"
												default="Handicap No Verif Age Reason:" />
										</label>
										<g:textField name="contract.0.handcapNoVerfcnAgeReason"
											value="${contract?.stuNoVerificationReason}" />
										<img width="25" height="25"
											style="float: none; vertical-align: bottom"
											class="magnifying" src="${resource(dir: 'images', file: 'Search-icon.png')}"
											onclick="lookup('contract.0.handcapNoVerfcnAgeReason', 'com.perotsystems.diamond.dao.cdo.ReasonCodeMaster','reasonCode', 'holdReasonType', 'reasonCodeType', null, null)">
									</div>
								</td>
							</tr>-->
							<tr>
								<td colspan="2">&nbsp;</td>
							</tr>
							<tr>
								<td colspan="2">User Defined Fields</td>
							</tr>
							<tr>
								<td colspan="2"><hr></td>
							</tr>
							<tr>
								<td>
									<div class="fieldcontain ${hasErrors(bean: contract, field: 'userDefined1', 'error')} ">
										<label for="userDefined1"> 
												<g:userDefinedFieldLabel winId="GRUPC" datawindowId ="dw_group_contract_de" userDefineTextName="user_defined_1_t"
													defaultText="User Defined 1"   />
										</label>
										<g:textField name="contract.0.userDefined1"
											value="${contract?.userDefined1}" />

									</div>
								</td>
								<td>
									<div class="fieldcontain ${hasErrors(bean: contract, field: 'userDate1', 'error')} ">
										<label for="userDefined2"><g:userDefinedFieldLabel winId="GRUPC" datawindowId ="dw_group_contract_de" userDefineTextName="user_date_1_t"
													defaultText="User Date 1"   />	
										</label>
										<g:datePicker name="contract.0.userDate1" precision="day"
											noSelection="['':'']" value="${contract?.userDate1}"
											default="none" />
									</div>
								</td>
							</tr>
							<tr>
								<td>
									<div class="fieldcontain ${hasErrors(bean: contract, field: 'userDefined2', 'error')} ">
										<label for="userDefined2"><g:userDefinedFieldLabel winId="GRUPC" datawindowId ="dw_group_contract_de" userDefineTextName="user_defined_2_t"
													defaultText="User Defined 2"   /> 
										</label>
										<g:textField name="contract.0.userDefined2"
											value="${contract?.userDefined2}" />

									</div>
								</td>
								<td>
									<div class="fieldcontain ${hasErrors(bean: contract, field: 'userDate2', 'error')} ">
										<label for="userDefined2"> <g:userDefinedFieldLabel winId="GRUPC" datawindowId ="dw_group_contract_de" userDefineTextName="user_date_2_t"
													defaultText="User Date 2"   />	
										</label>
										<g:datePicker name="contract.0.userDate2" precision="day"
											noSelection="['':'']" value="${contract?.userDate2}"
											default="none" />
									</div>
								</td>
							</tr>
							<tr>
								<td>
									<div class="fieldcontain ${hasErrors(bean: contract, field: 'userDefined3', 'error')} ">
										<label for="userDefined3"> <g:userDefinedFieldLabel winId="GRUPC" datawindowId ="dw_group_contract_de" userDefineTextName="user_defined_3_t"
													defaultText="User Defined 3"   />
										</label>
										<g:textField name="contract.0.userDefined3"
											value="${contract?.userDefined3}" />

									</div>
								</td>
								<td>
									<div class="fieldcontain ${hasErrors(bean: contract, field: 'userDate3', 'error')} ">
										<label for="userDefined2"><g:userDefinedFieldLabel winId="GRUPC" datawindowId ="dw_group_contract_de" userDefineTextName="user_date_3_t"
													defaultText="User Date 3"   />	 
										</label>
										<g:datePicker name="contract.0.userDate3" precision="day"
											noSelection="['':'']" value="${contract?.userDate3}"
											default="none" />
									</div>
								</td>
							</tr>
							<tr>
								<td>
									<div class="fieldcontain ${hasErrors(bean: contract, field: 'userDefined4', 'error')} ">
										<label for="userDefined4"> <g:userDefinedFieldLabel winId="GRUPC" datawindowId ="dw_group_contract_de" userDefineTextName="user_defined_4_t"
													defaultText="User Defined 4"   />
										</label>
										<g:textField name="contract.0.userDefined4"
											value="${contract?.userDefined4}" />
									</div>
								</td>
								<td>
									<div class="fieldcontain ${hasErrors(bean: contract, field: 'userDate4', 'error')} ">
										<label for="userDefined2"> <g:userDefinedFieldLabel winId="GRUPC" datawindowId ="dw_group_contract_de" userDefineTextName="user_date_4_t"
													defaultText="User Date 4"   />	
										</label>
										<g:datePicker name="contract.0.userDate4" precision="day"
											noSelection="['':'']" value="${contract?.userDate4}"
											default="none" />
									</div>
								</td>
							</tr>
							<tr>
								<td>
									<div class="fieldcontain ${hasErrors(bean: contract, field: 'userDefined5', 'error')} ">
										<label for="userDefined5"> <g:userDefinedFieldLabel winId="GRUPC" datawindowId ="dw_group_contract_de" userDefineTextName="user_defined_5_t"
													defaultText="User Defined 5"   />
										</label>
										<g:textField name="contract.0.userDefined5"
											value="${contract?.userDefined5}" />
									</div>
								</td>
								<td>
									<div class="fieldcontain ${hasErrors(bean: contract, field: 'userDate5', 'error')} ">
										<label for="userDefined2"><g:userDefinedFieldLabel winId="GRUPC" datawindowId ="dw_group_contract_de" userDefineTextName="user_date_5_t"
													defaultText="User Date 5"   />	 
										</label>
										<g:datePicker name="contract.0.userDate5" precision="day"
											noSelection="['':'']" value="${contract?.userDate5}"
											default="none" />
									</div>
								</td>
							</tr>
							<tr>
								<td>
									<div class="fieldcontain ${hasErrors(bean: contract, field: 'userDefined6', 'error')} ">
										<label for="userDefined6"><g:userDefinedFieldLabel winId="GRUPC" datawindowId ="dw_group_contract_de" userDefineTextName="user_defined_6_t"
													defaultText="User Defined 6"   /> 
										</label>
										<g:textField name="contract.0.userDefined6"
											value="${contract?.userDefined6}" />
									</div>
								</td>
								<td>
									<div class="fieldcontain ${hasErrors(bean: contract, field: 'userDate6', 'error')} ">
										<label for="userDefined2"> <g:userDefinedFieldLabel winId="GRUPC" datawindowId ="dw_group_contract_de" userDefineTextName="user_date_6_t"
													defaultText="User Date 6"   />	
										</label>
										<g:datePicker name="contract.0.userDate6" precision="day"
											noSelection="['':'']" value="${contract?.userDate6}"
											default="none" />
									</div>
								</td>
							</tr>
							<tr>
								<td>
									<div class="fieldcontain ${hasErrors(bean: contract, field: 'userDefined7', 'error')} ">
										<label for="userDefined7"> <g:userDefinedFieldLabel winId="GRUPC" datawindowId ="dw_group_contract_de" userDefineTextName="user_defined_7_t"
													defaultText="User Defined 7"   /> 
										</label>
										<g:textField name="contract.0.userDefined7"
											value="${contract?.userDefined7}" />
									</div>
								</td>
								<td>
									<div class="fieldcontain ${hasErrors(bean: contract, field: 'userDate7', 'error')} ">
										<label for="userDefined2"> <g:userDefinedFieldLabel winId="GRUPC" datawindowId ="dw_group_contract_de" userDefineTextName="user_date_7_t"
													defaultText="User Date 7"   />																						
										</label>
										<g:datePicker name="contract.0.userDate7" precision="day"
											noSelection="['':'']" value="${contract?.userDate7}"
											default="none" />
									</div>
								</td>
							</tr>
							<tr>
								<td>
									<div
										class="fieldcontain ${hasErrors(bean: contract, field: 'userDefined8', 'error')} ">
										<label for="userDefined8"> <g:userDefinedFieldLabel winId="GRUPC" datawindowId ="dw_groupc_user_fields_de" userDefineTextName="user_defined_8_t"
													defaultText="User Defined 8"   /> 
										</label>
										<g:textField name="contract.0.userDefined8"
											value="${contract?.userDefined8}" />
									</div>
								</td>
								<td>
									<div class="fieldcontain ${hasErrors(bean: contract, field: 'userDefined9', 'error')} ">
										<label for="userDefined9"> <g:userDefinedFieldLabel winId="GRUPC" datawindowId ="dw_groupc_user_fields_de" userDefineTextName="user_defined_9_t"
													defaultText="User Defined 9"   /> 
										</label>
										<g:textField name="contract.0.userDefined9"
											value="${contract?.userDefined9}" />
									</div>
								</td>
							</tr>
							<tr>
								<td>
									<div class="fieldcontain ${hasErrors(bean: contract, field: 'userDefined10', 'error')} ">
										<label for="userDefined10"> <g:userDefinedFieldLabel winId="GRUPC" datawindowId ="dw_groupc_user_fields_de" userDefineTextName="user_defined_10_t"
													defaultText="User Defined 10"   /> 
										</label>
										<g:textField name="contract.0.userDefined10"
											value="${contract?.userDefined10}" />
									</div>
								</td>
								<td>
									<div></div>
								</td>
							</tr>
						</table>

					</td>
				</tr>
			</table>
			<fieldset class="buttons">
				<g:actionSubmit class="save" action="saveContract"
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
