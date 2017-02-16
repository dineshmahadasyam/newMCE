<%@ page import="com.perotsystems.diamond.bom.GroupEx"%>
<!DOCTYPE html>
<html>
<head>
<meta name="layout" content="main">

<g:set var="entityName" value="${message(code: 'groupMaster.label', default: 'GroupMaster')}" />
<g:set var="appContext" bean="grailsApplication"/>
	
<title><g:message code="default.edit.label" args="[entityName]" /></title>

<!-- Main menu select -->
<meta name="navSelector" content="maint"/>
<!-- Child menu select -->
<meta name="navChildSelector" content="groupMaintenance"/>

<script type="text/javascript" src="${resource(dir: 'js', file: 'jquery.window.js')}"></script>
<script type="text/javascript" src="${resource(dir: 'js', file: 'jquery.validate.js')}"></script>
<script type="text/javascript" src="${resource(dir: 'js', file: 'jquery.alphanum.js')}"></script>

<script type="text/javascript">
$(document).ready(function(){
jQuery.validator.setDefaults({
	ignore: ":hidden",
	debug: true			 
});

		$(function() {		
				$("#editForm").validate({
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
				},
				'contact.0.emailId': {
								email : true
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
				},
				'contact.0.emailId': {
							email : "Please enter a valid Email Address"
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

<g:javascript>
	function closeForm() {
		var groupDBId = "${params.groupDBId}";
		var groupId = "${groupMasterInstance.groupId}";
		var appName = "${appContext.metadata['app.name']}";
		window.location.assign("/"+appName+"/groupMaintenance/edit/" + groupId +
		"?groupId=" + groupId + "&groupDBId=" + groupDBId + "&groupEditType=CONTACT");
	}
	
		$(function($){
			   $(".maskPhone").mask("?999-999-9999");
			})
			
			$(function($){
			   $(".maskExtension").mask("?999999");
			})
			
			$(function($){
			   $(".maskFax").mask("?999-999-9999");
			})
		
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
</head>
<!-- START - FMS Content -->
<div id="fms_content">
      <div id="fms_content_header">
        <div class="fms_content_header_note">
	      		<a href="${createLink(uri: '/memberMaintenance/list')}">Member Maintenance</a> / 
	      		<g:link class="list" action="edit"
					params="${[groupId: request.getParameter('groupId'), groupDBId : request.getParameter("groupDBId"), groupEditType :'CONTACT']}">Group Contact</g:link>
	      		
	      			/Add Contact to Group with GroupId -${groupMasterInstance?.groupId}
	  		</div>
 		<div class="fms_content_title">
    		<h1>Add Contact</h1>
  		</div>
	</div>
		<%-- START - Tabs --%>
			<div id="fms_content_tabs">
				<ul>
					<li><g:link class="list" action="edit" params="${[groupId: request.getParameter('groupId'), groupDBId : request.getParameter("groupDBId"), groupEditType :'MASTER']}">Master Records</g:link></li>
				 	<li><g:link class="list" action="edit" params="${[groupId: request.getParameter('groupId'), groupDBId : request.getParameter("groupDBId"), groupEditType :'CONTRACT']}">Contracts</g:link></li>
					<li><g:link class="list" action="edit" params="${[groupId: request.getParameter('groupId'), groupDBId : request.getParameter("groupDBId"), groupEditType :'DETAIL']}">Detail Records</g:link></li>
					<li><g:link class="list" action="edit" params="${[groupId: request.getParameter('groupId'), groupDBId : request.getParameter("groupDBId"), groupEditType :'ADDRESS']}">Addresses</g:link></li>
					<li><g:link class="active" action="edit" params="${[groupId: request.getParameter('groupId'), groupDBId : request.getParameter("groupDBId"), groupEditType :'CONTACT']}">Contacts</g:link></li>
					<li><g:link class="list" action="edit" params="${[groupId: request.getParameter('groupId'), groupDBId : request.getParameter("groupDBId"), groupEditType :'COMMRATES']}">Group Rates</g:link></li>
				</ul>
			<div id="mobile_tabs_select"></div>
		</div>
		<%-- END - Tabs --%>
	<!-- START - FMS Content Body -->
	<div id="fms_content_body">
		<div class="right-corner" align="right">GROUP</div>
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
		<g:form action="saveContact" id="editForm" name="editForm">
			<ul id="errorDisplay" style="display: none;" class="errors" role="alert" style="float:left; margin: -5px 10px 0px 0px; "></ul>
			<input type="hidden" name="id" value="${groupMasterInstance?.groupId}" />
			<input type="hidden" name="groupId" value="${groupMasterInstance?.groupId}" />
			<input type="hidden" name="groupDBId" value="${groupMasterInstance?.groupDBId}" />
			
			
              <!-- START - WIDGET: General Information -->
      			<div id="widgetGeneral" class="fms_widget">       
                  <fieldset class="no_border">
                       <legend><h2>Add Contact</h2></legend>
                 <div class="fms_form_layout_2column">                  
		            <div class="fms_form_column fms_long_labels">
					<label class="control-label fms_required" id="contactName_label" for="contactName">
						<g:message code="groupMaster.contactName.label" default="Contact Name :" />
					</label>
					<div class="fms_form_input">
						<g:textField 
							name="contact.0.contactName" 
							maxlength="40"
							Class="form-control"
							value="${contact?.contactName}" />
						<div class="fms_form_error" id="contactName_error"></div>
					</div>

					<label class="control-label" id="contactTitle_label" for="contactTitle">
						<g:message code="groupMaster.contactTitle.label" default="Title :" />
					</label>
					<div class="fms_form_input fms_has_feedback">
						<g:textField name="contact.0.contactTitle"Class="form-control"
											value="${contact?.contactTitle}" />
						<fmsui:cdoLookup 
							lookupElementId="contact.0.contactTitle"
			                lookupElementName="contact.0.contactTitle" 
			                lookupElementValue="${contact?.contactTitle}"
			                lookupCDOClassName="com.perotsystems.diamond.dao.cdo.ContactTitleMaster"
			                lookupCDOClassAttribute="contactTitle"/>
						
							<div class="fms_form_error" id="contactTitle_error"></div>
					</div> 
					
					<label class="control-label" id="emailId_label" for="emailId">
						<g:message code="groupMaster.emailId.label" default="Email Id :" />
					</label>
					<div class="fms_form_input">
						<g:textField 
							name="contact.0.emailId" 
							maxlength="80"
							Class="form-control"
							value="${contact?.emailId}" />
						<div class="fms_form_error" id="emailId_error"></div>
					</div>
				</div>
				<div class="fms_form_column fms_long_labels">	
                    
					<label class="control-label fms_required" id="phoneNumber_label" for="phoneNumber">
						<g:message code="groupMaster.phoneNumber.label" default="Phone Number :" />
					</label>
					<div class="fms_form_input">
						<g:textField 
							name="contact.0.phoneNumber" 
							maxlength="40"
							Class="maskPhone form-control"
							value="${contact?.phoneNumber}" />
						<div class="fms_form_error" id="phoneNumber_error"></div>
					</div>

					<label class="control-label" id="extension_label" for="extension">
						<g:message code="groupMaster.contactName.label" default="Phone Extension :" />
					</label>
					<div class="fms_form_input">
						<g:textField 
							name="contact.0.extension" 
							maxlength="6"
							Class="maskExtension form-control"
							value="${contact?.extension}" />
						<div class="fms_form_error" id="extension_error"></div>
					</div>

					<label class="control-label" id="faxNumber_label" for="faxNumber">
						<g:message code="groupMaster.faxNumber.label" default="Fax Number :" />
					</label>
					 <div class="fms_form_input">
						<g:textField 
							name="contact.0.faxNumber" 
							maxlength="20"
							Class="maskFax form-control"
							value="${contact?.faxNumber}" />
						<div class="fms_form_error" id="faxNumber_error"></div>
					</div>  
					</div>
					</div>
					</fieldset>
					</div>
            <div class="fms_form_button">
              	<g:actionSubmit  class="btn btn-primary" action="saveContact" 	value="${message(code: 'default.button.save.label', default: 'Save')}" />
				<input class="btn btn-default" name="Reset" type="reset">
				<input type="button" class="btn btn-default" name="close" value="${message(code: 'default.button.cancel.label', default: 'Cancel')}" onClick="closeForm()"/>
           </div></g:form>
           </div>
           </div>
           </div>
           </div>
</html>
