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
<g:set var="entityName"
	value="${message(code: 'groupMaster.label', default: 'GroupMaster')}" />

<g:set var="appContext" bean="grailsApplication"/>	
	
<title><g:message code="default.create.label"
		args="[entityName]" /></title>
<script type="text/javascript" src="${resource(dir: 'js', file: 'jquery-1.3.2.js')}"></script>
<script type="text/javascript" src="${resource(dir: 'js', file: 'jquery-ui-1.7.2.js')}"></script>
<script type="text/javascript" src="${resource(dir: 'js', file: 'jquery.window.js')}"></script>
	
	
<script type="text/javascript" src="${resource(dir: 'js', file: 'jquery.validate.js')}"></script>
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
	}, "Federal Tax ID must be 9 digits.");
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
			
		})
	});

	}); 

</script>
<script type="text/javascript" src="${resource(dir: 'js', file: 'jquery.dirtyform.js')}"></script>
<link rel="stylesheet"
	href="${resource(dir: 'css', file: 'jquery.window.css')}"
	type="text/css">

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

function closeForm() {
	var appName = "${appContext.metadata['app.name']}";
	window.location.assign("/"+appName+"/groupMaintenance/list")
}

</script>

</head>
<body>
	<a href="#create-groupMaster" class="skip" tabindex="-1"><g:message
			code="default.link.skip.label" default="Skip to content&hellip;" /></a>
	<div class="nav" role="navigation">
		<ul>
			<li><a class="list" href="#">Master Record</a></li>
		</ul>
	</div>
	<div id="create-groupMaster" class="content scaffold-create"
		role="main">
		<h1 style="color: #48802C">Create Group</h1>
		<div class="right-corner" align="center">GROUP</div>
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

		<g:form action="save" name="editForm" id="editForm" method="post">
			<div id="errorDisplay" style="display: none;" class="errors"
				style="float:left; margin: -5px 10px 0px 0px; "></div>

			<input type="hidden" name="groupEditType"
				value="${request.getParameter("editType")}">
<%--			<g:hiddenField name="groupId" value="${groupMasterInstance?.groupId}" />			--%>
			<fieldset class="groupMasterForm">
				<g:render template="groupMasterForm" />
			</fieldset>
			<fieldset class="buttons">
				<g:actionSubmit class="save" action="save"
					value="${message(code: 'default.button.create.label', default: 'Create')}" />
				<input type="Reset" class="reset" value="Reset" id="resetButton" />
				<input type="button" class="close" name="close" value="Close"
					onClick="closeForm()">
			</fieldset>
		</g:form>

		<%--				used by lookup window--%>
		<div style="display: none">
			<input type="button" onClick="closeAllIFrames()" id="closeIframes">
		</div>

	</div>
</body>
</html>
