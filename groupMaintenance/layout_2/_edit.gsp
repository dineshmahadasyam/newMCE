<%@ page import="com.perotsystems.diamond.bom.GroupEx" %>
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
</style>
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

<g:set var="entityName" value="${message(code: 'groupMaster.label', default: 'Group Master')}" />

<g:set var="appContext" bean="grailsApplication"/>

<title><g:message code="default.edit.label" args="[entityName]" /></title>
<script type="text/javascript" src="${resource(dir: 'js', file: 'jquery-1.3.2.js')}"></script>
<script type="text/javascript" src="${resource(dir: 'js', file: 'jquery-ui-1.7.2.js')}"></script>
<script type="text/javascript" src="${resource(dir: 'js', file: 'jquery.window.js')}"></script>
<script type="text/javascript" src="${resource(dir: 'js', file: 'jquery.validate.js')}"></script>
<script type="text/javascript" src="${resource(dir: 'js', file: 'additional-methods.js')}"></script>
<script type="text/javascript" src="${resource(dir: 'js', file: 'jquery.maskedinput.js')}"></script>

<script>
	$(function($){
	   $(".taxId").mask("?99-9999999");
	})
</script>
<script type="text/javascript">
$(document).ready(function(){
	jQuery.validator.addMethod("taxidmaxdigits", function(value, element) {
		return this.optional(element) || /\d{2}-\d{7}$/.test(value)
	}, "Federal Tax ID must be 9 digits");
jQuery.validator.setDefaults({
	ignore: [],
	debug: true
	});

$(function() {		
		$("#editForm").validate({
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
							'detail.${i}.effectiveDate_day' :  {
								required : true
							},
							'detail.${i}.effectiveDate_month' :  {
								required : true
							},
							'detail.${i}.effectiveDate_year' :  {
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
									return $.trim($("#detail\\.${i}\\.endDate_year").val()).length > 0 ||
									$.trim($("#detail\\.${i}\\.endDate_month").val()).length > 0 ||
									$.trim($("#detail\\.${i}\\.endDate_day").val()).length > 0;						
								}
							},
							'detail.${i}.endDate_year' :  {
								required : function(element){														
									return $.trim($("#detail\\.${i}\\.termReason").val()).length > 0 	;						
								},
								greaterThan:[ "#detail\\.${i}\\.effectiveDate","#detail\\.${i}\\.endDate","Effective Date","Term Date"]
							},
							'detail.${i}.endDate_month' :  {
								required : function(element){														
									return $.trim($("#detail\\.${i}\\.termReason").val()).length > 0 	;						
								}
							},
							'detail.${i}.endDate_day' :  {
								required : function(element){														
									return $.trim($("#detail\\.${i}\\.termReason").val()).length > 0 	;						
								}
							}														
						<g:if test="${i < groupMasterInstance.premiumMasters.size()-1}"> 
						,
						</g:if>
					</g:each>
				</g:if>
				<g:if test="${("CONTRACT".equals(request.getParameter('groupEditType')))}">
					<g:each in="${groupMasterInstance.contracts}" status="i" var="contract">
						'contract.${i}.effectiveDate_day' : {
							required :true
						},
						'contract.${i}.effectiveDate_month' : {
							required :true
						},
						'contract.${i}.effectiveDate_year' : {
							required :true
						},
						'contract.${i}.numberOfEmployees' :{
							digits : true	
						},
						'contract.${i}.newbornAgeDays' : {
							digits : true	
						},							
						'contract.${i}.termReason' :  {
							required : function(element){														
								return $.trim($("#contract\\.${i}\\.termDate_year").val()).length > 0 ||
								$.trim($("#contract\\.${i}\\.termDate_month").val()).length > 0 ||
								$.trim($("#contract\\.${i}\\.termDate_day").val()).length > 0;						
							}
						},
						'contract.${i}.termDate_year' :  {
							required : function(element){														
								return $.trim($("#contract\\.${i}\\.termReason").val()).length > 0 	;						
							},
							greaterThan:[ "#contract\\.${i}\\.effectiveDate","#contract\\.${i}\\.termDate","Effective Date","Term Date"]
						},
						'contract.${i}.termDate_month' :  {
							required : function(element){														
								return $.trim($("#contract\\.${i}\\.termReason").val()).length > 0 	;						
							}
						},
						'contract.${i}.termDate_day' :  {
							required : function(element){														
								return $.trim($("#contract\\.${i}\\.termReason").val()).length > 0 	;						
							}
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
								'address.${i}.effectiveDate_day' : {
									required : true
								},
							    'address.${i}.effectiveDate_month' : {
									required : true
								},
					
							    'address.${i}.effectiveDate_year' : {
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
									//digits : true,
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
										return $.trim($("#address\\.${i}\\.termDate_year").val()).length > 0 ||
										$.trim($("#address\\.${i}\\.termDate_month").val()).length > 0 ||
										$.trim($("#address\\.${i}\\.termDate_day").val()).length > 0;						
									}
								},
								'address.${i}.termDate_year' :  {
									required : function(element){														
										return $.trim($("#address\\.${i}\\.termReason").val()).length > 0 	;						
									},
									greaterThan:[ "#address\\.${i}\\.effectiveDate","#address\\.${i}\\.termDate","Effective Date","Term Date"]
								},
								'address.${i}.termDate_month' :  {
									required : function(element){														
										return $.trim($("#address\\.${i}\\.termReason").val()).length > 0 	;						
									}
								},
								'address.${i}.termDate_day' :  {
									required : function(element){														
										return $.trim($("#address\\.${i}\\.termReason").val()).length > 0 	;						
									}
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
							'detail.${i}.effectiveDate_day' :  {
								required : "Effective Date - Day is a mandatory field, please input the value for Effective date - Day"						
							},
							'detail.${i}.effectiveDate_month' :  {
								required : "Effective Date - Month is a mandatory field, please input the value for Effective date - Month"
							},
							'detail.${i}.effectiveDate_year' :  {
								required : "Effective Date - Year is a mandatory field, please input the value for Effective date - Year"
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
							'detail.${i}.endDate_year' :  {
								required : "Term Date Year is a mandatory field if Term reason is entered, please input the value for Term Date Year"
							},
							'detail.${i}.endDate_month' :  {
								required : "Term Date Month is a mandatory field if Term reason is entered, please input the value for Term Date Month"
							},
							'detail.${i}.endDate_day' :  {
								required : "Term Date Day is a mandatory field if Term reason is entered, please input the value for Term Date Day"
							}																					
						<g:if test="${i < groupMasterInstance.premiumMasters.size()-1}"> 
						,
						</g:if>
					</g:each>
				</g:if>
				<g:if test="${("CONTRACT".equals(request.getParameter('groupEditType')))}">
					<g:each in="${groupMasterInstance.contracts}" status="i" var="contract">
							'contract.${i}.effectiveDate_day' :  {
								required : "Effective Date - Day is a mandatory field, please input the value for Effective date - Day"						
							},
							'contract.${i}.effectiveDate_month' :  {
								required : "Effective Date - Month is a mandatory field, please input the value for Effective date - Month"
							},
							'contract.${i}.effectiveDate_year' :  {
								required : "Effective Date - Year is a mandatory field, please input the value for Effective date - Year"
							},
							'contract.${i}.termReason' :  {
								required : "Term Reason is a mandatory field if Term Date is entered, please input the value for Term Reason"
							},
							'contract.${i}.termDate_year' :  {
								required : "Term Date Year is a mandatory field if Term reason is entered, please input the value for Term Date Year"
							},
							'contract.${i}.termDate_month' :  {
								required : "Term Date Month is a mandatory field if Term reason is entered, please input the value for Term Date Month"
							},
							'contract.${i}.termDate_day' :  {
								required : "Term Date Day is a mandatory field if Term reason is entered, please input the value for Term Date Day"
							},
							'contract.${i}.claimActionCode' :  {
								required : "claimActionCode is a mandatory field if claimGraceDays is entered, please input the value for claimActionCode"
							},
							'contract.${i}.claimReason' :  {
								required : "claimReason is a mandatory field if claimGraceDays and claimActionCode is entered, please input the value for claimReason"
							},	
							'contract.${i}.numberOfEmployees' :{
								digits : "Please enter only numbers for employees"
							},
							'contract.${i}.newbornAgeDays' : {
								digits : "Please enter only numbers for NB Age in Days"
							}													
						<g:if test="${i < groupMasterInstance.contracts.size()-1}"> 
						,
						</g:if>
					</g:each>
				</g:if>
				<g:if test="${("ADDRESS".equals(request.getParameter('groupEditType')))}">
					<g:each in="${groupMasterInstance.addresses}" status="i" var="contract">
							'address.${i}.effectiveDate_day' : {
								required : "Please enter the Effective Date."
							},
							'address.${i}.effectiveDate_month' : {
								required : "Please enter the Effective Month."
							}
							,'address.${i}.effectiveDate_year' : {
								required : "Please enter the Effective Year."
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
								//digits : "Please enter only numbers for Zip Code",	
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
							'address.${i}.termDate_year' :  {
								required : "Term Date Year is a mandatory field if Term reason is entered, please input the value for Term Date Year"
							},
							'address.${i}.termDate_month' :  {
								required : "Term Date Month is a mandatory field if Term reason is entered, please input the value for Term Date Month"
							},
							'address.${i}.termDate_day' :  {
								required : "Term Date Day is a mandatory field if Term reason is entered, please input the value for Term Date Day"
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
							}						
						<g:if test="${i < groupMasterInstance.contacts.size()-1}"> 
						,
						</g:if>
					</g:each>
				</g:if>
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




//end document load

}); 

</script>

				
	<link rel="stylesheet" href="${resource(dir: 'css', file: 'jquery.window.css')}" type="text/css">
	
	<style type="text/css">
		#report changed {color:blue;}
        #report { border-collapse:collapse;}
        #report div {background:#C7DDEE}
        #report h4 { margin:0px; padding:0px;}
        #report img { float:right;}
        #report ul { margin:10px 0 10px 40px; padding:0px;}
        #report td { none repeat-x scroll center left; color:#000; padding:2px 15px; }
        #report tr.hideme { background:#C7DDEE none repeat-x scroll center left; color:#000; padding:7px 15px; }
        #report td.clickme td { background:#fffff repeat-x scroll center left; cursor:pointer; }
        #report div.arrow { background:transparent url(arrows.png) no-repeat scroll 0px -16px; width:16px; height:16px; display:block;}
        #report div.up { background-position:0px 0px;}
        
.showme Label{
	width:240px;
	text-align:left;
	padding-bottom:5px;
	padding-top:10px;
}
.showme Input{
	width:200px;
	text-align:left;
}
#editFields span{
	color:#0066CC;
}

    </style>

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
	<body>
		<a href="#edit-groupMaster" class="skip" tabindex="-1"><g:message code="default.link.skip.label" default="Skip to content&hellip;"/></a>
		<div class="nav" role="navigation">
			<ul>
				<li><g:link class="list" action="edit" params="${[groupId: request.getParameter('groupId'), groupDBId : request.getParameter("groupDBId"), groupEditType :'MASTER']}">Master Record</g:link></li>
				<li><g:link class="list" action="edit" params="${[groupId: request.getParameter('groupId'), groupDBId : request.getParameter("groupDBId"), groupEditType :'CONTRACT']}">Group Contracts</g:link></li>
				<li><g:link class="list" action="edit" params="${[groupId: request.getParameter('groupId'), groupDBId : request.getParameter("groupDBId"), groupEditType :'DETAIL']}">Detail Records</g:link></li>				
				<li><g:link class="list" action="edit" params="${[groupId: request.getParameter('groupId'), groupDBId : request.getParameter("groupDBId"), groupEditType :'ADDRESS']}">Group Addresses</g:link></li>
				<li><g:link class="list" action="edit" params="${[groupId: request.getParameter('groupId'), groupDBId : request.getParameter("groupDBId"), groupEditType :'CONTACT']}">Group Contacts</g:link></li>
			</ul>
			<ul>
				<li><g:link class="list" action="edit" params="${[groupId: request.getParameter('groupId'), groupDBId : request.getParameter("groupDBId"), groupEditType :'COMMRATES']}">Group Rates</g:link></li>
			</ul>
			
		</div>
		<div id="edit-groupMaster" class="content scaffold-edit" role="main">
					
			<h1  style="color: #48802C">
				<g:if test="${("MASTER".equals(request.getParameter('groupEditType')))}">Edit Group Master</g:if>
				<g:if test="${("DETAIL".equals(request.getParameter('groupEditType')))}">Edit Group Detail</g:if>
				<g:if test="${("ADDRESS".equals(request.getParameter('groupEditType')))}">Edit Group Address</g:if>
				<g:if test="${("CONTACT".equals(request.getParameter('groupEditType')))}">Edit Group Contact</g:if>
				<g:if test="${("CONTRACT".equals(request.getParameter('groupEditType')))}">Edit Group Contract</g:if>
				<g:if test="${("COMMRATES".equals(request.getParameter('groupEditType')))}">Edit Group Rate</g:if>				
			</h1>
			<div class="right-corner" align="center">
				<g:if test="${("MASTER".equals(request.getParameter('groupEditType')))}">GROUP</g:if>
				<g:if test="${("DETAIL".equals(request.getParameter('groupEditType')))}">GRUPD</g:if>
				<g:if test="${("ADDRESS".equals(request.getParameter('groupEditType')))}">GRUPA</g:if>
				<g:if test="${("CONTACT".equals(request.getParameter('groupEditType')))}">GROUP</g:if>
				<g:if test="${("CONTRACT".equals(request.getParameter('groupEditType')))}">GRUPC</g:if>
				<g:if test="${("COMMRATES".equals(request.getParameter('groupEditType')))}">COMMG</g:if>
			</div>
			<g:if test="${flash.message}">
			<div class="message" role="status">${flash.message}</div>
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
	
			<g:form action="update" id="editForm" name="editForm">
			<div id="errorDisplay" style="display: none;" class="errors"
				style="float:left; margin: -5px 10px 0px 0px; "></div>

				<g:hiddenField name="id" value="${groupMasterInstance?.groupId}" />
				<%--
				<g:hiddenField name="shortName" value="${groupMasterInstance?.shortName}" />
				<g:hiddenField name="levelCode" value="${groupMasterInstance.levelCode}" />
				
				--%>
				<g:if test="${request.getParameter('groupEditType') && 'MASTER'.equals(request.getParameter('groupEditType'))}">
					<fieldset class="groupMasterForm">
						<g:hiddenField name="groupEditType" value="MASTER" />					
						<g:render template="groupMasterForm"/>
					</fieldset>	
					<fieldset class="buttons">
					<g:actionSubmit class="save" action="update" value="${message(code: 'default.button.update.label', default: 'Update')}" />
					<input class="reset" type="reset">
					<input type="button" class="close" name="close" value="Close" onClick="closeForm()">
				</fieldset>				
				</g:if>
				<g:if test="${request.getParameter('groupEditType') && 'DETAIL'.equals(request.getParameter('groupEditType'))}">
					<fieldset class="premiumMasterForm">
						<g:hiddenField name="groupEditType" value="DETAIL" />
						<g:render template="premiumMasterForm"/>
					</fieldset>	
					<fieldset class="buttons">
					<g:actionSubmit class="save" action="update" value="${message(code: 'default.button.update.label', default: 'Update')}" />
					<input class="reset" type="reset">
					<input type="button" class="close" name="close" value="Close" onClick="closeForm()">
				</fieldset>				
				</g:if>
				<g:if test="${request.getParameter('groupEditType') && 'CONTRACT'.equals(request.getParameter('groupEditType'))}">
					<fieldset class="groupContractForm">
						<g:hiddenField name="groupEditType" value="CONTRACT" />
						<g:render template="groupContractForm"/>
					</fieldset>	
					<fieldset class="buttons">
					<g:actionSubmit class="save" action="update" value="${message(code: 'default.button.update.label', default: 'Update')}" />
					<input class="reset" type="reset">
					<input type="button" class="close" name="close" value="Close" onClick="closeForm()">
				</fieldset>				
				</g:if>
				<g:if test="${request.getParameter('groupEditType') && 'ADDRESS'.equals(request.getParameter('groupEditType'))}">
					<fieldset class="groupAddressForm">
						<g:hiddenField name="groupEditType" value="ADDRESS" />
						<g:render template="groupAddressForm"/>
					</fieldset>	
					<fieldset class="buttons">
					<g:actionSubmit class="save" action="update" value="${message(code: 'default.button.update.label', default: 'Update')}" />
					<input class="reset" type="reset">
					<input type="button" class="close" name="close" value="Close" onClick="closeForm()">
				</fieldset>				
				</g:if>
				<g:if test="${request.getParameter('groupEditType') && 'CONTACT'.equals(request.getParameter('groupEditType'))}">
					<fieldset class="groupContactForm">
						<g:hiddenField name="groupEditType" value="CONTACT" />
						<g:render template="groupContactForm"/>
					</fieldset>	
					<fieldset class="buttons">
					<g:actionSubmit class="save" action="update" value="${message(code: 'default.button.update.label', default: 'Update')}" />
					<input class="reset" type="reset">
					<input type="button" class="close" name="close" value="Close" onClick="closeForm()">
				</fieldset>
									
				</g:if>
				<g:if test="${request.getParameter('groupEditType') && 'COMMRATES'.equals(request.getParameter('groupEditType'))}">
						<div id="errorDisplay" style="display: none;" class="errors"
							style="float:left; margin: -5px 10px 0px 0px; "></div>
						<fieldset class="groupCommissionRatesForm">
							<g:hiddenField name="groupEditType" value="COMMRATES" />
							<g:render template="groupCommissionRatesForm"/>
						</fieldset>
					<fieldset class="buttons">
					<g:actionSubmit class="save" action="update" value="${message(code: 'default.button.update.label', default: 'Update')}" />
					<input type="button" class="close" name="close" value="Close" onClick="closeForm()">
				</fieldset>			
				</g:if>
				
							
				<input type="hidden" name="dirtyFields" value="">
			</g:form>
		</div>
		
					<%--				used by lookup window--%>
			<div style="display: none">
				<input type="button" onClick="closeAllIFrames()" id="closeIframes">
			</div>
			
	</body>
	
	
</html>
