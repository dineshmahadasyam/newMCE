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
				},
				'contact.0.contactName' :  {
					required : true
				},
				'contact.0.phoneNumber' :  {
					required : true
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
				'contact.0.contactName' :  {
					required : "Contact Name is a mandatory field, please input the value for Contact Name"
				},
				'contact.0.phoneNumber' :  {
					required : "Phone Number is a mandatory field, please input the value for Phone Number"
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
			<li><g:link class="list" action="edit"
					params="${[groupId: request.getParameter('groupId'), groupDBId : request.getParameter("groupDBId"), groupEditType :'CONTACT']}">Group Contact</g:link></li>
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
		<g:form action="saveContact" id="editForm" name="editForm">
			<div id="errorDisplay" style="display: none;" class="errors"
				style="float:left; margin: -5px 10px 0px 0px; "></div>
			<g:hiddenField name="id" value="${groupMasterInstance?.groupId}" />
			<g:hiddenField name="groupId" value="${groupMasterInstance?.groupId}" />
			<g:hiddenField name="groupDBId"
				value="${groupMasterInstance?.groupDBId}" />

			<h1 style="color: #48802C">
				Add Contact to Group with GroupId -
				${groupMasterInstance?.groupId}
			</h1>
			<div class="right-corner" align="center">GROUP</div>
			<table>
				<tr>
					<td>
						<table class="report1" border="0">
							<tr>
								<td>
									<div
										class="fieldcontain ${hasErrors(bean: contact, field: 'contact.contactName', 'error')} ">
										<label for="contactName"> <g:message
												code="groupMaster.contactName.label"
												default="Contact Name:" /><span class="required-indicator">*</span>

										</label>
										<g:textField name="contact.0.contactName" maxlength="40"
											value="${contact?.contactName}" />
									</div>
								</td>
								<td>
									<div
										class="fieldcontain ${hasErrors(bean: contact, field: 'contact.contactTitle', 'error')} ">
										<label for="contactTitle"> <g:message
												code="groupMaster.contactTitle.label"
												default="Title:" />

										</label>
										<g:textField name="contact.0.contactTitle"
											value="${contact?.contactTitle}" />
										<img width="25" height="25"
												style="float: none; vertical-align: bottom"
												class="magnifying" src="${resource(dir: 'images', file: 'Search-icon.png')}"
												onclick="lookup('contact.0.contactTitle', 'com.perotsystems.diamond.dao.cdo.ContactTitleMaster','contactTitle', 'description', null,  null, null)">
									</div>
								</td>
							</tr>
							<tr>
								<td>
									<div
										class="fieldcontain ${hasErrors(bean: contact, field: 'contact.phoneNumber', 'error')} ">
										<label for="phoneNumber"> <g:message
												code="groupMaster.phoneNumber.label"
												default="Phone Number:" /><span class="required-indicator">*</span>

										</label>
										<g:textField name="contact.0.phoneNumber" maxlength="40"
											value="${contact?.phoneNumber}" />
									</div>
								</td>
								<td>
									<div
										class="fieldcontain ${hasErrors(bean: contact, field: 'contact.extension', 'error')} ">
										<label for="extension"> <g:message
												code="groupMaster.extension.label"
												default="Phone Extension:" />

										</label>
										<g:textField name="contact.0.extension" maxlength="6"
											value="${contact?.extension}" />
									</div>
								</td>
							</tr>
							<tr>
								<td>
									<div
										class="fieldcontain ${hasErrors(bean: contact, field: 'contact.emailId', 'error')} ">
										<label for="emailId"> <g:message
												code="groupMaster.emailId.label"
												default="Email Id:" />

										</label>
										<g:textField name="contact.0.emailId" maxlength="80"
											value="${contact?.emailId}" />
									</div>								
									
								</td>
								<td>
									<div
										class="fieldcontain ${hasErrors(bean: contact, field: 'contact.faxNumber', 'error')} ">
										<label for="faxNumber"> <g:message
												code="groupMaster.faxNumber.label"
												default="Fax Number:" />

										</label>
										<g:textField name="contact.0.faxNumber" maxlength="20"
											value="${contact?.faxNumber}" />
									</div>
								</td>
							</tr>
						</table>

					</td>
				</tr>
			</table>


			<fieldset class="buttons">
				<g:actionSubmit class="save" action="saveContact"
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
