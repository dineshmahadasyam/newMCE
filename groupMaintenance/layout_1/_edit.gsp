<%@ page import="com.perotsystems.diamond.bom.GroupEx" %>

<!DOCTYPE html>
<html>
	<head>
		<meta name="layout" content="main">
		<g:set var="entityName" value="${message(code: 'groupMaster.label', default: 'GroupMaster')}" />
		<title><g:message code="default.list.label" args="[entityName]" /></title>
		<g:set var="appContext" bean="grailsApplication"/>
		<!-- Main menu select -->
		<meta name="navSelector" content="maint"/>
		<!-- Child menu select -->
		<meta name="navChildSelector" content="groupMaintenance"/>
		
<script type="text/javascript" src="${resource(dir: 'js', file: 'jquery.validate.js')}"></script>
<script type="text/javascript" src="${resource(dir: 'js', file: 'jquery.maskedinput.js')}"></script>
<script type="text/javascript" src="${resource(dir: 'js', file: 'commonfunctions.js')}"></script>
<script type="text/javascript" src="${resource(dir: 'js', file: 'jquery.alphanum.js')}"></script>

<script>
	$(function($){
	   $(".taxId").mask("?99-9999999");
	})
</script>
<script type="text/javascript">

$(document).ready(function(){
	
	jQuery.validator.addMethod("taxidmaxdigits", function(value, element) {
		if(element.value=="__-_______"){element.value="";}
		return this.optional(element) || /\d{2}-\d{7}$/.test(value)
	}, "Federal Tax ID must be of 9 digits.");

	jQuery.validator.addMethod("zipcodeUS", function(value, element) {
		value = value.replace(/\s+/g, ""); 
		return this.optional(element) || /\d{5}-\d{4}$|^\d{5}$/.test(value) || /\d{5}-____$/.test(value) || /\d{9}$/.test(value)
	}, "Zip Code must be 5 or 9 digits.");

	jQuery.validator.setDefaults({
		ignore: [],
		debug: true
	});

	$(".amtNumeric").numeric({});
	
		$("#editForm").validate({
			onfocusout: false,
			submitHandler: function (form) {
				  isInvalidForm = 'false';
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
	            }
	        },
	        
			errorLabelContainer: "#errorDisplay", 
			 wrapper: "li",		
							
			rules : {
				<g:if test="${("MASTER".equals(request.getParameter('groupEditType')))}">
					'groupId' : {
						required : true
					},
					'shortName': {
						required : true
					},
					'levelCode' : {
						required : true
					},
					'groupType' : {
						required : true
					},
					'taxId' : {
						taxidmaxdigits : true
					}
								
					</g:if>
				<g:if test="${("DETAIL".equals(request.getParameter('groupEditType')))}">
						<g:each in="${groupMasterInstance.premiumMasters}" status="i" var="contract">
							'detail.${ i }.effectiveDate' :  {
								required : true
							},
							'detail.${i}.recordType' : {
								required : true
							},							
							'detail.${i}.priceOrAdjudicate' :  {
								required : true
							},
							'detail.${i}.planRiderCode' :  {
								required : true
							},
							'detail.${i}.multiPlanEnroll' :  {
								required : true
							},
							'detail.${i}.seqGroupId' :  {
								required : true
							},
							'detail.${i}.lineOfBusiness' :  {
								required : true
							},
							'detail.${i}.instCobCalcMethod' :  {
								required : true
							},
							'detail.${i}.cobCalcMethod'  : {
								required : true
							},
							'detail.${i}.depDetermRuleCode'  : {
								required : true
							},
							'detail.${i}.cobPolicyFlag' :  {
								required : true
							},
							'detail.${i}.cobExcludeCapClaimCode'  : {
								required : true
							},
							'detail.${i}.claimFilingIndicator' :  {
								required : true
							},
							'detail.${i}.termReason' :  {
								required : function(element){														
									return $.trim($("#detail\\.${i}\\.endDate").val()).length > 0
						
								}
							},
							'detail.${ i }.endDate' :  {
								required : function(element){														
									return $.trim($("#detail\\.${i}\\.termReason").val()).length > 0 	;						
								},
								greaterThan:[ "#detail\\.${i}\\.effectiveDate","#detail\\.${i}\\.endDate","Effective Date","Term Date"]
							}
																			
						<g:if test="${i < groupMasterInstance.premiumMasters.size()-1}"> 
						,
						</g:if>
					</g:each>
				</g:if>
				<g:if test="${("CONTRACT".equals(request.getParameter('groupEditType')))}">
					<g:each in="${groupMasterInstance.contracts}" status="i" var="contract">
						'contract.${i}.effectiveDate' : {
							required :true
						},
						'contract.${i}.termReason' :  {
							required : function(element){														
								return $.trim($("#contract\\.${i}\\.termDate").val()).length > 0					
							}
						},
						'contract.${i}.termDate' :  {
							required : function(element){														
								return $.trim($("#contract\\.${i}\\.termReason").val()).length > 0 	;						
							},
							greaterThan:[ "#contract\\.${i}\\.effectiveDate","#contract\\.${i}\\.termDate","Effective Date","Term Date"]
						},
						'contract.${i}.claimActionCode' :  {
							required : function(element){														
								return $.trim($("#contract\\.${i}\\.claimGraceDays").val()).length > 0  ;						
							}
						},
						'contract.${i}.claimReason' :  {
							required : function(element){														
								return $.trim($("#contract\\.${i}\\.claimGraceDays").val()).length > 0 &&  
								$.trim($("#contract\\.${i}\\.claimActionCode").val()).length > 0 ;						
							}
						}
						
						<g:if test="${i < groupMasterInstance.contracts.size()-1}"> 
						,
						</g:if>
					</g:each>
				</g:if>
				<g:if test="${("ADDRESS".equals(request.getParameter('groupEditType')))}">
					<g:each in="${groupMasterInstance.addresses}" status="i" var="contract">
								'address.${ i }.effectiveDate' : {
									required : true
								},
								'address.${i}.addressType' : {
									required : true
								}
								,'address.${i}.address1' : {
									required : true
								}
								,'address.${i}.city' : {
									required : true		
								},
								'address.${i}.state' : {
									required : true		
								},
								'address.${i}.zip' : {
									required : true,
									zipcodeUS : true									
								},
								'address.${i}.homePhone' : {
									digits : true	
								},'address.${i}.mobilePhone': {
									digits : true	
								}
								,'address.${i}.beeperNumber': {
									digits : true	
								}
								,'address.${i}.alternatePhone': {
									digits : true	
								}
								,'address.${i}.faxNumber': {
									digits : true	
								}
								,'address.${i}.telephoneNumber': {
									digits : true	
								}
								,'address.${i}.telephoneNumberEx': {
									digits : true	
								},'address.${i}.socialSecurityNumber': {
									digits : true	
								}
								,'address.${i}.businessPhone': {
									digits : true	
								},
								'address.${i}.termReason' :  {
									required : function(element){														
										return $.trim($("#address\\.${i}\\.termDate").val()).length > 0					
									}
								},
								'address.${ i }.termDate' :  {
									required : function(element){														
										return $.trim($("#address\\.${i}\\.termReason").val()).length > 0 	;						
									},
									greaterThan:[ "#address\\.${i}\\.effectiveDate","#address\\.${i}\\.termDate","Effective Date","Term Date"]
								}	
							<g:if test="${i < groupMasterInstance.addresses.size()-1}"> 
							,
							</g:if>
						</g:each>
				</g:if>

				<g:if test="${("CONTACT".equals(request.getParameter('groupEditType')))}">
				<g:each in="${groupMasterInstance.contacts}" status="i" var="contact">
					'contact.${i}.contactName' : {
						required :true
					},
					'contact.${i}.phoneNumber' : {
						required :true
					},
					'contact.${i}.emailId': {
								email : true
					}
					<g:if test="${i < groupMasterInstance.contacts.size()-1}"> 
					,
					</g:if>
				</g:each>
			</g:if>
				
			},
			messages : {
				<g:if test="${("MASTER".equals(request.getParameter('groupEditType')))}">
					'groupId' : {
						required : "Group Id is a mandatory field, please input the value for Group Id"
					},
					'shortName': {
						required : "Short Name is a mandatory field, please input the value for Short Name"
					},
					'levelCode' : {
						required : "Level Code is a mandatory field, please input the value for Level Code"
					},
					'groupType' : {
						required : "Group Type is a mandatory field, please input the value for Group Type"
					},
					'taxId' :{
						required : "tax is mandatory"
						}
				</g:if>
				<g:if test="${("DETAIL".equals(request.getParameter('groupEditType')))}">
						<g:each in="${groupMasterInstance.premiumMasters}" status="i" var="contract">
							'detail.${ i }.effectiveDate' :  {
								required : "Effective Date is a mandatory field, please input the value for Effective Date."						
							},
							'detail.${i}.recordType' : {
								required : "Record Type is a mandatory field, please input the value for Record Type"
							},							
							'detail.${i}.priceOrAdjudicate' : {
								required : "Processing is a mandatory field, please input the value for Processing"
							},	
							'detail.${i}.planRiderCode' : {
								required : "Plan/Rider Code is a mandatory field, please input the value for Plan/Rider Code"
							},
							'detail.${i}.multiPlanEnroll' : {
								required : "Multi Plan Enroll is a mandatory field, please input the value for Multi Plan Enroll Code"
							},
							'detail.${i}.seqGroupId'  : {
								required : "GroupID is a mandatory field, please input the value for GroupId"
							},
							'detail.${i}.lineOfBusiness'  : {
								required : "Line of Business is a mandatory field, please input the value for Line of Business"
							},
							'detail.${i}.instCobCalcMethod'  : {
								required : "Institutional Claim COB Calculation Method is a mandatory field, please input the value for Institutional Claim COB Calculation Method"
							},
							'detail.${i}.cobCalcMethod'  : {
								required : "Professional Claim COB Calculation Method is a mandatory field, please input the value for Professional Claim COB Calculation Method"
							},
							'detail.${i}.depDetermRuleCode' :  {
								required : "Dependant Determination Rule Code Method is a mandatory field, please input the value for Dependant Determination Rule Code"
							},
							'detail.${i}.cobPolicyFlag' :  {
								required : "CoB Policy Flag Method is a mandatory field, please input the value for CoB Policy Flag"
							},
							'detail.${i}.cobExcludeCapClaimCode' :  {
								required : "CoB Eclude Capitated Claim Code Method is a mandatory field, please input the value for CoB Eclude Capitated Claim Code"
							},
							'detail.${i}.claimFilingIndicator' :  {
								required : "Claim Filing Indicator is a mandatory field, please input the value for Claim Filing Indicator"
							},
							'detail.${i}.termReason' :  {
								required : "Term Reason is a mandatory field if Term Date is entered, please input the value for Term Reason"
							},
							'detail.${ i }.endDate' :  {
								required : "Term Date is a mandatory field if Term reason is entered, please input the value for Term Date"
							}
						<g:if test="${i < groupMasterInstance.premiumMasters.size()-1}"> 
						,
						</g:if>
					</g:each>
				</g:if>
				<g:if test="${("CONTRACT".equals(request.getParameter('groupEditType')))}">
					<g:each in="${groupMasterInstance.contracts}" status="i" var="contract">
							'contract.${i}.effectiveDate' :  {
								required : "Effective Date is a mandatory field, please input the value for Effective Date."						
							},
							'contract.${i}.termReason' :  {
								required : "Term Reason is a mandatory field if Term Date is entered, please input the value for Term Reason"
							},
							'contract.${i}.termDate' :  {
								required : "Term Date is a mandatory field if Term reason is entered, please input the value for Term Date"
							},
							'contract.${i}.claimActionCode' :  {
								required : "claimActionCode is a mandatory field if claimGraceDays is entered, please input the value for claimActionCode"
							},
							'contract.${i}.claimReason' :  {
								required : "claimReason is a mandatory field if claimGraceDays and claimActionCode is entered, please input the value for claimReason"
							}							
						<g:if test="${i < groupMasterInstance.contracts.size()-1}"> 
						,
						</g:if>
					</g:each>
				</g:if>
			
				<g:if test="${("ADDRESS".equals(request.getParameter('groupEditType')))}">
					<g:each in="${groupMasterInstance.addresses}" status="i" var="contract">
							'address.${ i }.effectiveDate' : {
								required : "Please enter the Effective Date."
							}
							,'address.${i}.addressType': {
								required : "Please Select an Address Type"						
							}
							,'address.${i}.address1' : {
								required : "Please enter the Address 1"						
							}
							,'address.${i}.city' : {
								required : "Please enter the City"					
							}
							,'address.${i}.state' : {
								required : "Please select a value for State"					
							}
							,'address.${i}.zip' : {
								required : "Please enter the Zip Code"	, 
								zipcodeUS : "Zip Code must be 5 or 9 digits"										
							},
							'address.${i}.homePhone' : {
								digits : "Please enter only numbers for Home Phone"
							},'address.${i}.mobilePhone': {
								digits : "Please enter only numbers for Mobile Phone"	
							}
							,'address.${i}.beeperNumber': {
								digits : "Please enter only numbers for Beeper Number"	
							}
							,'address.${i}.alternatePhone': {
								digits : "Please enter only numbers for Alternate Phone"	
							}
							,'address.${i}.faxNumber': {
								digits : "Please enter only numbers for Fax Number"	
							}
							,'address.${i}.telephoneNumber': {
								digits : "Please enter only numbers for Telephone Number"	
							}
							,'address.${i}.telephoneNumberEx': {
								digits : "Please enter only numbers for Telephone Ext"
							},'address.${i}.socialSecurityNumber': {
								digits : "Please enter only numbers for Social Security Number"	
							}
							,'address.${i}.businessPhone': {
								digits : "Please enter only numbers for Business Phone"	
							},
							'address.${i}.termReason' :  {
								required : "Term Reason is a mandatory field if Term Date is entered, please input the value for Term Reason"
							},
							'address.${ i }.termDate' :  {
								required : "Term Date is a mandatory field if Term reason is entered, please input the value for Term Date"
							}
						<g:if test="${i < groupMasterInstance.addresses.size()-1}"> 
						,
						</g:if>
					</g:each>
				</g:if>
				
				<g:if test="${("CONTACT".equals(request.getParameter('groupEditType')))}">
					<g:each in="${groupMasterInstance.contacts}" status="i" var="contact">
							'contact.${i}.contactName' :  {
								required : "Contact Name is a mandatory field, please input the value for Contact Name"						
							},
							'contact.${i}.phoneNumber' :  {
								required : "Phone Number is a mandatory field, please input the value for Phone Number"
							},
							'contact.${i}.emailId': {
								email : "Please enter a valid Email Address"
							}		
						<g:if test="${i < groupMasterInstance.contacts.size()-1}"> 
						,
						</g:if>
					</g:each>
				</g:if>
			} 
			
		})




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
	
<script type="text/javascript" src="${resource(dir: 'js', file: 'jquery.dirtyform.js')}"></script>
<g:javascript>
	$(function(){
	  $("form")	   
	    .dirty_form({changedClass: "forever_changes"})
	    .dirty(function(event, data){
	      var label = $(event.target).parents("li").find("label");
	      //alert("<p> event target size= '"+event.target.length+ "' field name='" + $(event.target)[0].name  +"' type='"+$(event.target)[0].type + "' value='"+$(event.target)[0].value + "' Changed from " + data.from + " to: " + data.to+ "</p>")
	    })
	});
	
	function closeForm() {
		var appName = "${appContext.metadata['app.name']}"
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
	
	if(assocFieldCdoName != null && document.getElementById(assocFieldCdoName) != null){	
	var htmlElementLevelCode=document.getElementById(assocFieldCdoName).value
	if(assocFieldCdoName == 'levelCode' && htmlElementLevelCode.trim() == 3){								
		
					return false;
				}
				}
			
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
	var appName = "${appContext.metadata['app.name']}"
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

<div id="fms_content">  		
		<g:form action="update" id="editForm" name="editForm">
				<g:hiddenField name="id" value="${groupMasterInstance?.groupId}" />
				<%--
				<g:hiddenField name="shortName" value="${groupMasterInstance?.shortName}" />
				<g:hiddenField name="levelCode" value="${groupMasterInstance.levelCode}" />
				
				--%>
				
				<g:if test="${request.getParameter('groupEditType') && 'MASTER'.equals(request.getParameter('groupEditType'))}">
					<fieldset class="groupMasterForm">
						<g:hiddenField name="groupEditType" value="MASTER" />					
						
						<div id="fms_content_header">
				        <div class="fms_content_header_note">
				          <a href="${createLink(uri: '/groupMaintenance/list')}">Group Maintenance</a> / Master Record for Group ID ${groupMasterInstance?.groupId}
				        </div>
				        <div class="fms_content_title">
				          <h1>Master Record</h1>
				        </div>
				      </div>
				      
				      <%-- START - Tabs --%>
				        <div id="fms_content_tabs">
				          <ul>
				            <li><g:link class="active" action="edit" params="${[groupId: request.getParameter('groupId'), groupDBId : request.getParameter("groupDBId"), groupEditType :'MASTER']}">Master Records</g:link></li>
							<li><g:link class="list" action="edit" params="${[groupId: request.getParameter('groupId'), groupDBId : request.getParameter("groupDBId"), groupEditType :'CONTRACT']}">Contracts</g:link></li>
							<li><g:link class="list" action="edit" params="${[groupId: request.getParameter('groupId'), groupDBId : request.getParameter("groupDBId"), groupEditType :'DETAIL']}">Detail Records</g:link></li>
							<li><g:link class="list" action="edit" params="${[groupId: request.getParameter('groupId'), groupDBId : request.getParameter("groupDBId"), groupEditType :'ADDRESS']}">Addresses</g:link></li>
							<li><g:link class="list" action="edit" params="${[groupId: request.getParameter('groupId'), groupDBId : request.getParameter("groupDBId"), groupEditType :'CONTACT']}">Contacts</g:link></li>
							<li><g:link class="list" action="edit" params="${[groupId: request.getParameter('groupId'), groupDBId : request.getParameter("groupDBId"), groupEditType :'COMMRATES']}">Group Rates</g:link></li>
				          </ul>
				          <div id="mobile_tabs_select"></div>
				        </div>
				      <%-- END - Tabs --%>
				      
				      		      
				      <g:render template="groupMasterForm"/>
					</fieldset>					
				</g:if>
				<g:if test="${request.getParameter('groupEditType') && 'DETAIL'.equals(request.getParameter('groupEditType'))}">
					<fieldset class="premiumMasterForm">
						<g:hiddenField name="groupEditType" value="DETAIL" />
						<div id="fms_content_header">
				        <div class="fms_content_header_note">
				          <a href="${createLink(uri: '/groupMaintenance/list')}">Group Maintenance</a> / Detail Records for Group ID ${groupMasterInstance?.groupId}
				        </div>
				        <div class="fms_content_title">
				          <h1>Detail Records</h1>
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
						<g:render template="premiumMasterForm"/>
					</fieldset>					
				</g:if>
				<g:if test="${request.getParameter('groupEditType') && 'CONTRACT'.equals(request.getParameter('groupEditType'))}">
					<fieldset class="groupContractForm">
						<g:hiddenField name="groupEditType" value="CONTRACT" />
						<div id="fms_content_header">
				        <div class="fms_content_header_note">
				          <a href="${createLink(uri: '/groupMaintenance/list')}">Group Maintenance</a> / Contracts for Group ID ${groupMasterInstance?.groupId}
				        </div>
				        <div class="fms_content_title">
				          <h1>Contracts</h1>
				        </div>
				      </div>
				      
				      <%-- START - Tabs --%>
				        <div id="fms_content_tabs">
				          <ul>
				            <li><g:link class="list" action="edit" params="${[groupId: request.getParameter('groupId'), groupDBId : request.getParameter("groupDBId"), groupEditType :'MASTER']}">Master Records</g:link></li>
				            <li><g:link class="active" action="edit" params="${[groupId: request.getParameter('groupId'), groupDBId : request.getParameter("groupDBId"), groupEditType :'CONTRACT']}">Contracts</g:link></li>
							<li><g:link class="list" action="edit" params="${[groupId: request.getParameter('groupId'), groupDBId : request.getParameter("groupDBId"), groupEditType :'DETAIL']}">Detail Records</g:link></li>
							<li><g:link class="list" action="edit" params="${[groupId: request.getParameter('groupId'), groupDBId : request.getParameter("groupDBId"), groupEditType :'ADDRESS']}">Addresses</g:link></li>
							<li><g:link class="list" action="edit" params="${[groupId: request.getParameter('groupId'), groupDBId : request.getParameter("groupDBId"), groupEditType :'CONTACT']}">Contacts</g:link></li>
							<li><g:link class="list" action="edit" params="${[groupId: request.getParameter('groupId'), groupDBId : request.getParameter("groupDBId"), groupEditType :'COMMRATES']}">Group Rates</g:link></li>
				          </ul>
				          <div id="mobile_tabs_select"></div>
				        </div>
				      <%-- END - Tabs --%>
						<g:render template="groupContractForm"/>
					</fieldset>					
				</g:if>
				<g:if test="${request.getParameter('groupEditType') && 'ADDRESS'.equals(request.getParameter('groupEditType'))}">
					<fieldset class="groupAddressForm">
						<g:hiddenField name="groupEditType" value="ADDRESS" />
						<div id="fms_content_header">
							<div class="fms_content_header_note">
							  <a href="${createLink(uri: '/groupMaintenance/list')}">Group Maintenance</a> / Addresses for Group ID ${groupMasterInstance?.groupId}
							</div>
							<div class="fms_content_title">
							  <h1>Addresses</h1> 
							</div>
						</div>
						
				      <%-- START - Tabs --%>
				        <div id="fms_content_tabs">
				          <ul>
				            <li><g:link class="list" action="edit" params="${[groupId: request.getParameter('groupId'), groupDBId : request.getParameter("groupDBId"), groupEditType :'MASTER']}">Master Records</g:link></li>
				            <li><g:link class="list" action="edit" params="${[groupId: request.getParameter('groupId'), groupDBId : request.getParameter("groupDBId"), groupEditType :'CONTRACT']}">Contracts</g:link></li>
							<li><g:link class="list" action="edit" params="${[groupId: request.getParameter('groupId'), groupDBId : request.getParameter("groupDBId"), groupEditType :'DETAIL']}">Detail Records</g:link></li>
							<li><g:link class="active" action="edit" params="${[groupId: request.getParameter('groupId'), groupDBId : request.getParameter("groupDBId"), groupEditType :'ADDRESS']}">Addresses</g:link></li>
							<li><g:link class="list" action="edit" params="${[groupId: request.getParameter('groupId'), groupDBId : request.getParameter("groupDBId"), groupEditType :'CONTACT']}">Contacts</g:link></li>
							<li><g:link class="list" action="edit" params="${[groupId: request.getParameter('groupId'), groupDBId : request.getParameter("groupDBId"), groupEditType :'COMMRATES']}">Group Rates</g:link></li>
				          </ul>
				          <div id="mobile_tabs_select"></div>
				        </div>
				      <%-- END - Tabs --%>
				      
						<g:render template="groupAddressForm"/>
					</fieldset>					
				</g:if>
				<g:if test="${request.getParameter('groupEditType') && 'CONTACT'.equals(request.getParameter('groupEditType'))}">
					<fieldset class="groupContactForm">
						<g:hiddenField name="groupEditType" value="CONTACT" />
						<div id="fms_content_header">
				        <div class="fms_content_header_note">
				          <a href="${createLink(uri: '/groupMaintenance/list')}">Group Maintenance</a> / Contacts for Group ID ${groupMasterInstance?.groupId}
				        </div>
				        <div class="fms_content_title">
				          <h1>Contacts</h1>
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
						<g:render template="groupContactForm"/>
					</fieldset>					
				</g:if>
				
				<g:if test="${request.getParameter('groupEditType') && 'COMMRATES'.equals(request.getParameter('groupEditType'))}">
					<fieldset class="groupCommissionRatesForm">
						<g:hiddenField name="groupEditType" value="COMMRATES" />
						<div id="fms_content_header">
							<div class="fms_content_header_note">
							  <a href="${createLink(uri: '/groupMaintenance/list')}">Group Maintenance</a> /Group Rates for Group ID ${groupMasterInstance?.groupId}
							</div>
							<div class="fms_content_title">
							  <h1>Group Rates</h1> 
							</div>
						</div>
						
				      <%-- START - Tabs --%>
				        <div id="fms_content_tabs">
				          <ul>
				            <li><g:link class="list" action="edit" params="${[groupId: request.getParameter('groupId'), groupDBId : request.getParameter("groupDBId"), groupEditType :'MASTER']}">Master Records</g:link></li>
				            <li><g:link class="list" action="edit" params="${[groupId: request.getParameter('groupId'), groupDBId : request.getParameter("groupDBId"), groupEditType :'CONTRACT']}">Contracts</g:link></li>
							<li><g:link class="list" action="edit" params="${[groupId: request.getParameter('groupId'), groupDBId : request.getParameter("groupDBId"), groupEditType :'DETAIL']}">Detail Records</g:link></li>
							<li><g:link class="list" action="edit" params="${[groupId: request.getParameter('groupId'), groupDBId : request.getParameter("groupDBId"), groupEditType :'ADDRESS']}">Addresses</g:link></li>
							<li><g:link class="list" action="edit" params="${[groupId: request.getParameter('groupId'), groupDBId : request.getParameter("groupDBId"), groupEditType :'CONTACT']}">Contacts</g:link></li>
							<li><g:link class="active" action="edit" params="${[groupId: request.getParameter('groupId'), groupDBId : request.getParameter("groupDBId"), groupEditType :'COMMRATES']}">Group Rates</g:link></li>
				          </ul>
				          <div id="mobile_tabs_select"></div>
				        </div>
				      <%-- END - Tabs --%>
				      
						<g:render template="groupCommissionRatesForm"/>
					</fieldset>					
				</g:if>
					
				<input type="hidden" name="dirtyFields" value="">
			</g:form>
		
	</div> 

</html>	