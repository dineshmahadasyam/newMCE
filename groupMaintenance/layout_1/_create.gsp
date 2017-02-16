<%@ page import="com.perotsystems.diamond.bom.GroupEx"%>
<!DOCTYPE html>
<html>
	<head>
		<meta name="layout" content="main">
		<g:set var="entityName" value="${message(code: 'groupMaster.label', default: 'GroupMaster')}" />
		<title><g:message code="default.list.label" args="[entityName]" /></title>
		<script type="text/javascript">var selectedMenuID = "fms_menu_system";   </script>
		<!-- Main menu select -->
		<meta name="navSelector" content="maint"/>
		<!-- Child menu select -->
		<meta name="navChildSelector" content="groupMaintenance"/>
		<g:set var="appContext" bean="grailsApplication"/>

<script>

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
	if (assocFieldIds) {
		if(assocFieldIds.indexOf('|') == -1){			
			if (document.getElementById(assocFieldIds) && document.getElementById(assocFieldIds).value != "undefined") {
				assocHTMLElementsValue = document.getElementById(assocFieldIds).value
			}
		} else {
			var nameArray = assocFieldIds.split("|")
			for (var i =0;i<nameArray.length;i++) {			
				if (document.getElementById(nameArray[i]) && document.getElementById(nameArray[i]).value != "undefined") {
					assocHTMLElementsValue += document.getElementById(nameArray[i]).value+"|"
				}
			}
		}
	}
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

function closeForm() {
	var appName = "${appContext.metadata['app.name']}";
	window.location.assign("/"+appName+"/groupMaintenance/list")
}

</script>
	<script type="text/javascript" src="${resource(dir: 'js', file: 'jquery.validate.js')}"></script> 
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
	jQuery.validator.setDefaults({
		ignore: ":hidden",
		debug: true			 
	});

		$("#editForm").validate({
			submitHandler: function (form) {
				  if ($(form).valid()) 
                      form.submit(); 
                  return false; // prevent normal form posting
	        },
			errorLabelContainer: "#errorDisplay", 
			 wrapper: "li",		
							
			rules : {
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
					},'address.primary.1.effectiveDate_day' : {
									required : true
								},
							    'address.primary.1.effectiveDate_month' : {
									required : true
								},
					
							    'address.primary.1.effectiveDate_year' : {
									required : true
								},
								'address.primary.1.addressType' : {
									required : true
								}
								,'address.primary.1.address1' : {
									required : true
								}
								,'address.primary.1.city' : {
									required : true		
								},
								'address.primary.1.state' : {
									required : true		
								},
								'address.primary.1.zip' : {
									required : true,
									digits : true		
								},
								'address.primary.1.homePhone' : {
									digits : true	
								},'address.primary.1.mobilePhone': {
									digits : true	
								}
								,'address.primary.1.beeperNumber': {
									digits : true	
								}
								,'address.primary.1.alternatePhone': {
									digits : true	
								}
								,'address.primary.1.faxNumber': {
									digits : true	
								}
								,'address.primary.1.telephoneNumber': {
									digits : true	
								}
								,'address.primary.1.telephoneNumberEx': {
									digits : true	
								},'address.primary.1.socialSecurityNumber': {
									digits : true	
								}
								,'address.primary.1.businessPhone': {
									digits : true	
								}				
			},
			messages : {				
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
							'address.primary.1.effectiveDate_day' : {
								required : "Please enter a Effective Date."
							},
							'address.primary.1.effectiveDate_month' : {
								required : "Please enter a Effective Month."
							}
							,'address.primary.1.effectiveDate_year' : {
								required : "Please enter a Effective Year."
							}
							,'address.primary.1.addressType': {
								required : "Please Select a Address Type"						
							}
							,'address.primary.1.address1' : {
								required : "Please enter a Address 1"						
							}
							,'address.primary.1.city' : {
								required : "Please select a value for City"					
							}
							,'address.primary.1.state' : {
								required : "Please select a value for State"					
							}
							,'address.primary.1.zip' : {
								required : "Please select a value for Zip Code"	, 
								digits : "Please enter only numbers for Zip Code"				
							},
							'address.primary.1.homePhone' : {
								digits : "Please enter only numbers for Home Phone"
							},'address.primary.1.mobilePhone': {
								digits : "Please enter only numbers for Mobile Phone"	
							}
							,'address.primary.1.beeperNumber': {
								digits : "Please enter only numbers for Beeper Number"	
							}
							,'address.primary.1.alternatePhone': {
								digits : "Please enter only numbers for Alternate Phone"	
							}
							,'address.primary.1.faxNumber': {
								digits : "Please enter only numbers for Fax Number"	
							}
							,'address.primary.1.telephoneNumber': {
								digits : "Please enter only numbers for Telephone Number"	
							}
							,'address.primary.1.telephoneNumberEx': {
								digits : "Please enter only numbers for Telephone Ext"
							},'address.primary.1.socialSecurityNumber': {
								digits : "Please enter only numbers for Social Security Number"	
							}
							,'address.primary.1.businessPhone': {
								digits : "Please enter only numbers for Business Phone"	
							}						
			} 
			
		});
	});

	

</script>

</head>

<g:form action="save" method="post"  id="editForm" name="editForm">
			<input type="hidden" name="groupEditType" value="${request.getParameter("editType")}">			 
				<fieldset class="groupMasterForm">
					<div id="fms_content_header">
				        <div class="fms_content_header_note">
				          <a href="${createLink(uri: '/groupMaintenance/list')}">Group Maintenance</a> / Master Record for GroupID ${groupMasterInstance.groupId}
				        </div>
				        <div class="fms_content_title">
				          <h1>Master Record</h1>
				        </div>
				      </div>
				 <g:render template="groupMasterForm" />
				</fieldset>		
</g:form>     




</html>