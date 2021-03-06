<%@ page import="com.dell.diamond.fms.AgentMasterCommand" %>
<!DOCTYPE html>
<html>
	<head>
		<meta name="layout" content="main_2">
		<g:set var="entityName" value="${message(code: 'agentMaster.label', default: 'Agent/Broker')}" />
		<title><g:message code="default.edit.label" args="[entityName]" /></title>
		<style>
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
		.fieldcontain LABEL, .fieldcontain .property-label
		{
			width: 25%;
			font-size: 0.8em;
			font-weight:bold;
		}
		
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
		<script>
		function closeForm() {
			window.location.assign('<g:createLinkTo dir="/agentMaster/list"/>')			
		}
		</script>
		
		<link rel="stylesheet" href="${resource(dir: 'css', file: 'jquery.window.css')}" type="text/css">
		
		<meta name="layout" content="main_2">
        <g:set var="appContext" bean="grailsApplication"/>	
		<script type="text/javascript" src="${resource(dir: 'js', file: 'jquery-1.3.2.js')}"></script>
		<script type="text/javascript" src="${resource(dir: 'js', file: 'jquery-ui-1.7.2.js')}"></script>
		<script type="text/javascript" src="${resource(dir: 'js', file: 'jquery.window.js')}"></script>
		
		<script type="text/javascript" src="http://ajax.aspnetcdn.com/ajax/jquery.validate/1.11.1/jquery.validate.js"></script>
		<script type="text/javascript" src="${resource(dir: 'js', file: 'additional-methods.js')}"></script>	
		<script type="text/javascript" src="${resource(dir: 'js', file: 'jquery.maskedinput.js')}"></script>
		<script type="text/javascript" src="${resource(dir: 'js', file: 'jquery.alphanum.js')}"></script>
		<script type="text/javascript" src="${resource(dir: 'js', file: 'jquery.validate.js')}"></script>

<script>

var grpInnerWindow 
var innerWindowClosed = true;
function closeAllIFrames() {
	if(grpInnerWindow) {
		grpInnerWindow.close()
	}
}

function lookup(idName, cdoClassName, cdoClassAttributeName, assocFieldIds, assocFieldCdoName, updateFields, updateFieldsCdoName) {

	if(${'I'.equals(params.agentType)} && ${'MASTER'.equals(params.editType)})	    {
      	return false;	    
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
	var urlValue = "<g:createLinkTo dir="/lookUp/lookUp?htmlElementIdName="/>" + idName
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
function changeAgentIdMessage(){
	alert ("Changing Agent ID is not allowed.");
}


$(document).ready(function() {
	
	<g:if test="${'ADDRESS'.equals(params.editType) || 'CONTACT'.equals(params.editType) || 'CONTRACTS'.equals(params.editType) ||'BANKING'.equals(params.editType) ||'MASTER'.equals(params.editType) || 'LICENSE'.equals(params.editType)}">
	
		$(".maskZip").mask("99999?-9999");

		$(".maskPhoneNumber").mask("?999-999-9999");
		
		$(".maskExtension").mask("?999999");

		$(".pinTid").mask("?99-9999999");

		$(".maskTaxID").mask("?99-9999999");

		$.validator.addMethod("phoneValidation", function(value, element) {
			return this.optional(element) || /\d{3}-\d{3}-\d{4}$/.test(value) || /\d{10}$/.test(value)
		}, "Phone Number must be 10 digits");

		$.validator.addMethod("zipcodeUS", function(value, element) {
			return this.optional(element) || /\d{5}-\d{4}$|^\d{5}$/.test(value) || /\d{5}-____$/.test(value)
		}, "Zip Code must be 5 or 9 digits");

		$.validator.addMethod("customValidation1", function(value, element) {
			return this.optional(element) || /^[a-zA-Z0-9-. ]+$/i.test(value);
		}, "Please enter letters, numbers, hyphen, period and space only");

		$.validator.addMethod("customValidation2", function(value, element) {
			return this.optional(element) || /^[a-zA-Z. ]+$/i.test(value);
		}, "Please enter letters, period and space only");

		$.validator.addMethod("customValidation3", function(value, element) {
			return this.optional(element) || /^[a-zA-Z- ]+$/i.test(value);
		}, "Please enter letters and hyphen only");

		$.validator.addMethod("customValidation4", function(value, element) {
			return this.optional(element) || /^[a-zA-Z]+$/i.test(value);
		}, "Please enter letters only");

		$.validator.addMethod("zipcodeUS", function(value, element) {
			return this.optional(element) || /\d{5}-\d{4}$|^\d{5}$/.test(value) || /\d{5}-____$/.test(value)
		}, "Zip Code must be 5 or 9 digits");

		$.validator.addMethod("numberValidation", function(value, element) {
			return this.optional(element) || /^[0-9]+$/.test(value);				
		}, "Please enter only numbers 0 through 9");

		jQuery.validator.addMethod("alphaspecialchar", function(value, element) {
			return this.optional(element) || /^[a-zA-Z0-9-,_. ]+$/i.test(value);
			//return this.optional(element) || /^[a-zA-Z0-9_ ]+$/i.test(value);			
		}, "Please enter only Letters A through Z and characters dash, comma, hyphen, period.");
		
		
		jQuery.validator.addMethod("pinIdDigits", function(value, element) {
			return this.optional(element) || /\d{2}-\d{7}$/.test(value) || /\d{9}$/.test(value)
		}, "Pin Tin must be 9 digits");	

		<g:if test="${'LICENSE'.equals(params.editType)}">
		
			//Allow tabbing but prevent postback to previous page if user presses backspace since these fields are readonly
			$('#agentIdReadonly, #agentNameReadonlyFirstName, #agentNameReadonlyMiddleInitial, #agentNameReadonlyLastName, #pinTidReadonly, #agencyLicense\\.0\\.licenseNumber').live('keydown', function(e) {
					if (e.keyCode != 9) {
						e.preventDefault();
					}
			});

			$('#agencyLicense\\.agencyLicenceDtls\\.0\\.status').change(function(){
				toggleStatusDateField();
			});	

			//When page loads show current status date to be required based on the status field
			toggleStatusDateField();
			
			//Enable and Disable Current Status Date field based on Status field
			function toggleStatusDateField() {
				if($("#agencyLicense\\.agencyLicenceDtls\\.0\\.status").val() == 'AC') {
					//If status is Active(AC) then Current Status date is not required and needs to be disabled 
					$('#agencyLicense\\.agencyLicenceDtls\\.0\\.currentStatusDate_day').attr('disabled', 'disabled');
					$('#agencyLicense\\.agencyLicenceDtls\\.0\\.currentStatusDate_month').attr('disabled', 'disabled');
					$('#agencyLicense\\.agencyLicenceDtls\\.0\\.currentStatusDate_year').attr('disabled', 'disabled');
					$('#agencyLicense\\.agencyLicenceDtls\\.0\\.currentStatusDate_day').val('');
					$('#agencyLicense\\.agencyLicenceDtls\\.0\\.currentStatusDate_month').val('');
					$('#agencyLicense\\.agencyLicenceDtls\\.0\\.currentStatusDate_year').val('');
					
					$('#reqdCurrentStatusDate').hide()
				}
				else {
					//If status is not equal to Active(AC) then Current Status date is required and needs to be enabled 
					$('#agencyLicense\\.agencyLicenceDtls\\.0\\.currentStatusDate_day').removeAttr('disabled');
					$('#agencyLicense\\.agencyLicenceDtls\\.0\\.currentStatusDate_month').removeAttr('disabled');
					$('#agencyLicense\\.agencyLicenceDtls\\.0\\.currentStatusDate_year').removeAttr('disabled');
					$('#reqdCurrentStatusDate').show()
				}
			}

			//When page loads if there is certificate (Not just empty rows) then mark the completion date to be required
			if ($(".courseGroup,.descriptionGroup").filter(function() { return $(this).val(); }).length > 0) {
					$('#reqdCompletionDate').show()
			}
				else {
					$('#reqdCompletionDate').hide()
			}

			//If there is a value within the course or description field (during one of the user interaction) mark the completion date mandatory
			$(".courseGroup,.descriptionGroup").bind("change paste keyup", function() {
				if ($(".courseGroup,.descriptionGroup").filter(function() { return $(this).val(); }).length > 0) {
					$('#reqdCompletionDate').show()
				}
				else {
					$('#reqdCompletionDate').hide()
				}
			});

			$.validator.addMethod("alphanumeric", function(value, element) {
				return this.optional(element) || /^[a-zA-Z0-9 ]+$/i.test(value);
			}, "Please enter letters or numbers only");

			 //Alias required to add rules and message so these can be used for fields with the same classname
			$.validator.addMethod("courseAlphanumeric", $.validator.methods.alphanumeric, "Please enter letters or numbers only for Certification Course");
			$.validator.addMethod("descriptionAlphanumeric", $.validator.methods.alphanumeric, "Please enter letters or numbers only for Certification Description");
			
			$.validator.addClassRules("courseGroup", {courseAlphanumeric : true });
			$.validator.addClassRules("descriptionGroup", {descriptionAlphanumeric : true });

			$.validator.addMethod("dateCompareGreaterThan", function(value, element, params) {
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
				
				var startDate
				var endDate
				
				if ( $(startYear).val().length > 0 && $(startMonth).val().length > 0 && $(startDay).val().length > 0 && 
					 $(endYear).val().length > 0 &&  $(endMonth).val().length > 0 && $(endDay).val().length > 0) {
					 
					startDate= new  Date($(startYear).val(),$(startMonth).val(), $(startDay).val());
					endDate = new Date($(endYear).val(),$(endMonth).val(), $(endDay).val()) ;
	
					return this.optional(element) ||( $(startYear).val().length > 0 && $(startMonth).val().length > 0
								&& $(startDay).val().length > 0 && startDate < endDate) ;
				}
				else {
					return true;
				}
			});

			$.validator.addMethod("dateCompareGreaterThanOrEqual", function(value, element, params) {
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
				
				var startDate
				var endDate

				//if the first date being compared is optional and was disabled then the field wont have any dates in them - hence just return true
				if ($(startYear).val().length == 0 && $(startMonth).val().length == 0 && $(startDay).val().length == 0) {
					return true;
				}
				else if ($(startYear).val().length > 0 && $(startMonth).val().length > 0 && $(startDay).val().length > 0 &&
						$(endYear).val().length > 0 && $(endMonth).val().length > 0 && $(endDay).val().length > 0) {
					
					startDate= new  Date($(startYear).val(),$(startMonth).val(), $(startDay).val());
					endDate = new Date($(endYear).val(),$(endMonth).val(), $(endDay).val()) ;
					
					return this.optional(element) ||( $(startYear).val().length > 0 && $(startMonth).val().length > 0
							&& $(startDay).val().length > 0 && startDate <= endDate) ;	
				}
				else {
					return true;
				}
			});
			
			$.validator.addMethod("dateCompareGreaterThanOrEqual2", function(value, element, params) {
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
				
				var startDate
				var endDate

				//if the first date being compared is optional and was disabled then the field wont have any dates in them - hence just return true
				if ($(startYear).val().length == 0 && $(startMonth).val().length == 0 && $(startDay).val().length == 0) {
					return true;
				}
				else if ($(startYear).val().length > 0 && $(startMonth).val().length > 0 && $(startDay).val().length > 0 &&
						$(endYear).val().length > 0 && $(endMonth).val().length > 0 && $(endDay).val().length > 0) {
					
					startDate= new  Date($(startYear).val(),$(startMonth).val(), $(startDay).val());
					endDate = new Date($(endYear).val(),$(endMonth).val(), $(endDay).val()) ;
					
					return this.optional(element) ||( $(startYear).val().length > 0 && $(startMonth).val().length > 0
							&& $(startDay).val().length > 0 && startDate <= endDate) ;	
				}
				else {
					return true;
				}
			});
			
			
			//No future dates allowed
			$.validator.addMethod("noFutureDates", function(value, element, params) { 
				var enteredYear = params[0]+ "_year";
				var enteredMonth = params[0]+ "_month";
				var enteredDay = params[0]+ "_day"; 
				var enteredDate;
				var now;
				
				//Date entered needs to be compared with the current date to check if its in the future.
				//Grails date picker month has it set to Jan=1, Feb=1 and so on and Date objects have Jan=0, Feb=1
				//To compare we need to make the date entered equal. 
				//For eg: Date entered comes in as 1 for Jan from grails date picker but to compare with the current date object enteredMonth = enteredMonth - 1

				if ($(enteredYear).val().length > 0 && $(enteredMonth).val().length > 0 && $(enteredDay).val().length > 0) {
					enteredDate = new  Date($(enteredYear).val(), $(enteredMonth).val()-1, $(enteredDay).val());
					now = new Date();
					return this.optional(element) ||( $(enteredYear).val().length > 0 && $(enteredMonth).val().length > 0
						&& $(enteredDay).val().length > 0 && enteredDate <= now) ;
				}
				else {
					return true;
				}
			
			}, "No Future dates allowed");

			//Fire Description rule so the errors dont get left behind if Course has data
			$("input[name$='course']").bind("change keyup", function() {
				var errors = validator.numberOfInvalids();
				if (errors) { 
					var id = $(this).attr("id").replace("agencyLicenseCertificate.", "").replace(".course", "")
					$("#editForm").validate().element("#agencyLicenseCertificate\\." + id + "\\.description");
				}
			});
				
			//Fire Course rule so the errors dont get left behind if description has data
			$("input[name$='description']").bind("change keyup", function() {
				var errors = validator.numberOfInvalids();
				if (errors) { 
					var id = $(this).attr("id").replace("agencyLicenseCertificate.", "").replace(".description", "")
					$("#editForm").validate().element("#agencyLicenseCertificate\\." + id + "\\.course");
				}
			});
				
			
		</g:if>

		//Add extra validations for effective and term date.
		//New validation method to compare date fields.
		$.validator.addMethod("greaterThan", function(value, element, params) {
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
						&& $(startDay).val().length > 0 && startDate.getTime() <= endDate.getTime()) ;

		}, $.format("{3} must be greater than {2}") );

		
	    
		jQuery.validator.setDefaults({
			  debug: true,
				ignore: []
			});

		$(function() {	
			validator = $('#editForm').validate({
				//Added ignoreTitle=true so it does not pick up the default title as the validation message
				//for fields for which the validation is set through their class name
				ignoreTitle: true,
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
		    <g:if test="${'MASTER'.equals(params.editType)}">
					    'agentId' : {
							 alphaspecialchar  : true,
							 required:true	
						}, 'firstName' : {
							 alphaspecialchar  : true,
							 required:true		
						}, 'middleInitial' : {
							 alphaspecialchar  : true
						}, 'lastName' : {
							 alphaspecialchar  : true,
							 required:true		
						}, 'shortName' : {
							 alphaspecialchar  : true
						}, 'agentType' : {
							 required:true		
						}		
						, 'agencys.agencyId' : {
							 alphaspecialchar  : true,
							 required: {
								 depends: 	function (){
									 var agentTypeId = document.getElementById('agentTypeValue').value;
									 if(agentTypeId=="C"){
												return true;
											} else {
												return false;
									}
								}
						   	}	
						}
						, 'agencys.agencyName' : {
							 alphaspecialchar  : true,
							 required: {
								 depends: 	function (){
									 var agentTypeId = document.getElementById('agentTypeValue').value;
									 if(agentTypeId=="C"){
												return true;
											} else {
												return false;
									}
								}
						   	}	
							 
						},'effectiveDate_day' : {
							required: {
							 depends: 	function (){
								 var agentTypeId = document.getElementById('agentTypeValue').value;
								 if(agentTypeId=="C"){
											return true;
										} else {
											return false;
								}
							}
					   	}		
						},'effectiveDate_month' : {
							required: {
							 depends: 	function (){
								 var agentTypeId = document.getElementById('agentTypeValue').value;
								 if(agentTypeId=="C"){
											return true;
										} else {
											return false;
								}
							}
					   	}		
						},'effectiveDate_year' : {
							required: {
							 depends: 	function (){
								 var agentTypeId = document.getElementById('agentTypeValue').value;
								 if(agentTypeId=="C"){
											return true;
										} else {
											return false;
								}
							}
					   	},greaterThan:[ "#dateOfBirth","#effectiveDate","Date of Birth","Effective Date"]
						},'dateOfBirth_day' :  {
							required : true
						},'dateOfBirth_month' :  {
							required : true
						},'dateOfBirth_year' :  {
							required : true
						},'status' : {
							 alphaspecialchar  : true,
							 required:true		
						},'termDate_year' :  {
						    greaterThan:[ "#effectiveDate","#termDate","Effective Date","Term Date"]							
						},'pinTid' : {
							pinIdDigits : true,
							required: true
				 		},'payType' : {
							required: true
				 		}
			</g:if>	 		
			<g:if test="${'ADDRESS'.equals(params.editType)}">
				<g:each in="${agentMasterInstance?.agentAddresses}" var="agentAddress" status="i">
						 'agentAddress.${i}.addressLine1' : {
								required : true,
								customValidation1 : true
						},
						'agentAddress.${i}.addressLine2' : {
							customValidation1 : true
						},
						'agentAddress.${i}.city' : {
							required : true,
							customValidation2 : true
						},
						'agentAddress.${i}.state' : {
							required : true
						},
						'agentAddress.${i}.county' : {
							customValidation3 : true
						},
						'agentAddress.${i}.country' : {
							customValidation4 : true
						},
						'agentAddress.${i}.zipCode' : {
							required : true,
							zipcodeUS : true
						},
						'agentAddress.${i}.addressType' : {
							required : true
						},
						'agentAddress.${i}.effectiveDate_day' : {
							required : true
						},
						'agentAddress.${i}.effectiveDate_month' : {
							required : true
						},
						'agentAddress.${i}.effectiveDate_year' : {
							required : true
						},
						'agentAddress.${i}.termReason' :  {
							required : function(element){														
								return $.trim($("#agentAddress\\.${i}\\.termDate_year").val()).length > 0 ||
								$.trim($("#agentAddress\\.${i}\\.termDate_month").val()).length > 0 ||
								$.trim($("#agentAddress\\.${i}\\.termDate_day").val()).length > 0;						
							}
						},
						'agentAddress.${i}.termDate_year' :  {
							required : function(element){														
								return $.trim($("#agentAddress\\.${i}\\.termReason").val()).length > 0 	;						
							},
							greaterThan:[ "#agentAddress\\.${i}\\.effectiveDate","#agentAddress\\.${i}\\.termDate","Effective Date","Term Date"]
						},
						'agentAddress.${i}.termDate_month' :  {
							required : function(element){														
								return $.trim($("#agentAddress\\.${i}\\.termReason").val()).length > 0 	;						
							}
						},
						'agentAddress.${i}.termDate_day' :  {
							required : function(element){														
								return $.trim($("#agentAddress\\.${i}\\.termReason").val()).length > 0 	;						
							}
						},	
					</g:each>
			</g:if>
			<g:if test="${'CONTACT'.equals(params.editType)}">
					<g:each in="${agentMasterInstance?.agentContacts}" var="agentContact" status="i">
							'agentContact.${i}.contactName' : {
								required : true,
								customValidation1 : true
							},
							'agentContact.${i}.phoneNumber' : {
								required : true,
								phoneValidation: true
							},
							'agentContact.${i}.emailAddress': {
								email : true
							},
							'agentContact.${i}.faxNumber' : {
								phoneValidation: true
							},
							'agentContact.${i}.mobilePhone' : {
								phoneValidation: true
							},
							'agentContact.${i}.businessPhone' : {
								phoneValidation: true
							},
					</g:each>
			</g:if>	

			<g:if test="${'CONTRACTS'.equals(params.editType)}">
				<g:each in="${agentMasterInstance?.agentGroupContracts}" var="agentContract" status="i">
					'agentContract.${i}.seqGroupId' : {
						required : function(element){														
							return $.trim($("#${i}\\.groupId").val()).length > 0 &&	
								   $("#agentContract\\.${i}\\.seqGroupId").val() != null;						
						},
					},
					'${i}.groupId' : {
						required : true
					},
					'${i}.planRiderCode' : {
						required : true
					},
				</g:each>
			</g:if>
			
			<g:if test="${'BANKING'.equals(params.editType)}">
			 	 <g:each in="${agentMasterInstance?.agentEFTs}" var="agentEFT" status="i">	
					 	'agentEFT.${i}.accountNumber' : {
							required : true,
							numberValidation : true
						},
						'agentEFT.${i}.nameOnAccount' : {
							required : true,
							customValidation1 : true
						},
						'agentEFT.${i}.bankName' : {
							required : true,
							customValidation1 : true
						},
						'agentEFT.${i}.routingNumber' : {
							required : true,
							numberValidation:true
						},
						'agentEFT.${i}.description' : {
							customValidation1 : true
						},
						'agentEFT.${i}.statusFlag' : {
							required : true
						},
						'agentEFT.${i}.effectiveDate_day' : {
							required : true
						},
						'agentEFT.${i}.effectiveDate_month' : {
							required : true
						},
						'agentEFT.${i}.effectiveDate_year' : {
							required : true
						},
						'agentEFT.${i}.termReason' :  {
							required : function(element){														
								return $.trim($("#agentEFT\\.${i}\\.termDate_year").val()).length > 0 ||
								$.trim($("#agentEFT\\.${i}\\.termDate_month").val()).length > 0 ||
								$.trim($("#agentEFT\\.${i}\\.termDate_day").val()).length > 0;						
							}
						},
						'agentEFT.${i}.termDate_year' :  {
							required : function(element){														
								return $.trim($("#agentEFT\\.${i}\\.termReason").val()).length > 0 	;						
							},
							greaterThan:[ "#agentEFT\\.${i}\\.effectiveDate","#agentEFT\\.${i}\\.termDate","Effective Date","Term Date"]
						},
						'agentEFT.${i}.termDate_month' :  {
							required : function(element){														
								return $.trim($("#agentEFT\\.${i}\\.termReason").val()).length > 0 	;						
							}
						},
						'agentEFT.${i}.termDate_day' :  {
							required : function(element){														
								return $.trim($("#agentEFT\\.${i}\\.termReason").val()).length > 0 	;						
							}
						},'agentEFT.${i}.accountType' : {
							required : true
						},	
				 </g:each>
			</g:if>	
			<g:if test="${'LICENSE'.equals(params.editType) && 'UPDATE'.equals(params.editSubType)}">
				<g:each in="${agencyLicenseHdrInstance}" var="agencyLicense" status="i">
					'agencyLicense.0.licenseLoa' : {
						required : true
					},
				  	'agencyLicense.0.state' : {
						required : true
					},
					'agencyLicense.agencyLicenceDtls.0.effectiveDate_day' : {
						required : true
					},
					'agencyLicense.agencyLicenceDtls.0.effectiveDate_month' : {
						required : true
					},
					'agencyLicense.agencyLicenceDtls.0.effectiveDate_year' : {
						required : true
					},
					'agencyLicense.agencyLicenceDtls.0.expirationDate_day' : {
						required : true
					},
					'agencyLicense.agencyLicenceDtls.0.expirationDate_month' : {
						required : true
					},
					'agencyLicense.agencyLicenceDtls.0.expirationDate_year' : {
						required : true,
						dateCompareGreaterThan:["#agencyLicense\\.agencyLicenceDtls\\.0\\.effectiveDate","#agencyLicense\\.agencyLicenceDtls\\.0\\.expirationDate","Effective Date","Expiration Date"]
					},
				  	'agencyLicense.agencyLicenceDtls.0.status' : {
						required : true
					},
					'agencyLicense.agencyLicenceDtls.0.currentStatusDate_day' : {
						required : {
									depends: function(){	
										return 	($('#agencyLicense\\.agencyLicenceDtls\\.0\\.status').val() != 'AC'	&&  $('#agencyLicense\\.agencyLicenceDtls\\.0\\.status').val() != '')												
									}
						}
					},
					'agencyLicense.agencyLicenceDtls.0.currentStatusDate_month' : {
						required : {
									depends: function(){	
										return 	($('#agencyLicense\\.agencyLicenceDtls\\.0\\.status').val() != 'AC'	&&  $('#agencyLicense\\.agencyLicenceDtls\\.0\\.status').val() != '')												
									}
						}
					},
					'agencyLicense.agencyLicenceDtls.0.currentStatusDate_year' : {
						required : {
									depends: function(){	
										return 	($('#agencyLicense\\.agencyLicenceDtls\\.0\\.status').val() != 'AC'	&&  $('#agencyLicense\\.agencyLicenceDtls\\.0\\.status').val() != '')												
									}
						}
					},
							<g:each in="${agencyLicenseHdrInstance?.agencyLicenseCertificates}" var="agencyLicenseCertificate" status="j">
									'agencyLicenseCertificate.${j}.course' : {
										required : {
											depends: function(){
												return ($("#agencyLicenseCertificate\\.${j}\\.completionDate_day").val().length > 0 ||
												$("#agencyLicenseCertificate\\.${j}\\.completionDate_month").val().length > 0 ||
												$("#agencyLicenseCertificate\\.${j}\\.completionDate_year").val().length > 0) &&
												$.trim($("#agencyLicenseCertificate\\.${j}\\.description").val()) == 0;				
											}
										}
									},
									'agencyLicenseCertificate.${j}.description' : {
										required : {
											depends: function(){
												return ($("#agencyLicenseCertificate\\.${j}\\.completionDate_day").val().length > 0 ||
												$("#agencyLicenseCertificate\\.${j}\\.completionDate_month").val().length > 0 ||
												$("#agencyLicenseCertificate\\.${j}\\.completionDate_year").val().length > 0) &&
												$.trim($("#agencyLicenseCertificate\\.${j}\\.course").val()) == 0;			
											}
										}
									},
									'agencyLicenseCertificate.${j}.completionDate_day' : {
										required : function(element){														
											return $.trim($("#agencyLicenseCertificate\\.${j}\\.course").val()).length > 0 ||
											$.trim($("#agencyLicenseCertificate\\.${j}\\.description").val()).length > 0;						
										}
									},
									'agencyLicenseCertificate.${j}.completionDate_month' : {
										required : function(element){														
											return $.trim($("#agencyLicenseCertificate\\.${j}\\.course").val()).length > 0 ||
											$.trim($("#agencyLicenseCertificate\\.${j}\\.description").val()).length > 0;						
										}
									},
									'agencyLicenseCertificate.${j}.completionDate_year' : {
										noFutureDates: ["#agencyLicenseCertificate\\.${j}\\.completionDate"],
										required : function(element){														
											return $.trim($("#agencyLicenseCertificate\\.${j}\\.course").val()).length > 0 ||
											$.trim($("#agencyLicenseCertificate\\.${j}\\.description").val()).length > 0;						
										}
									},
									'agencyLicenseCertificate.${j}.expirationDate_year' : {
										dateCompareGreaterThanOrEqual2:["#agencyLicenseCertificate\\.${j}\\.completionDate","#agencyLicenseCertificate\\.${j}\\.expirationDate","Completion Date","Expiration Date"],
										dateCompareGreaterThanOrEqual:["#agencyLicense\\.agencyLicenceDtls\\.0\\.currentStatusDate","#agencyLicenseCertificate\\.${j}\\.expirationDate","Status Date","Expiration Date"]						
									},
								</g:each>
				</g:each>
			</g:if>	
			},
			messages : {
				<g:if test="${'MASTER'.equals(params.editType)}">
								 'agentId' : {
									alphaspecialchar : "Please enter a valid Agent/Broker ID. Letters, Numbers, hyphen and underscore are allowed.",	
								    required : "Agent/Broker ID  is a mandatory field, please input the value for Agent/Broker ID."
								},'firstName' : {
									alphaspecialchar : "Invalid Format. Only letters, numbers, hyphen, spaces are allowed.",
									required : "First Name  is a mandatory field, please input the value for First Name."
								},'middleInitial' : {
									alphaspecialchar : "Invalid Format. Only letters, numbers, hyphen, spaces are allowed."
								},'lastName' : {
									alphaspecialchar : "Invalid Format. Only letters, numbers, hyphen, spaces are allowed.",
									required : "Last Name  is a mandatory field, please input the value for Last Name."
								},'shortName' : {
									alphaspecialchar : "Invalid Format. Only letters, numbers, hyphen, spaces are allowed."
								},'agentType' : {
									required : "Agent /Broker Type   is a mandatory field, please input the value for Agent /Broker Type."
								},'agencyId' : {
									alphaspecialchar : "Invalid Format. Only letters, numbers, hyphen, spaces are allowed.",
									required : "Agency ID  is a mandatory field, please input the value for Agency ID."
								},'agencys.agencyName' : {
									alphaspecialchar : "Invalid Format. Only letters, numbers, hyphen, spaces are allowed.",
									required : "Agency Name  is a mandatory field, please input the value for Agency Name."
								},
								'effectiveDate_day' : {
									required : "Effective Date  is a mandatory field, Please enter the Effective Date"
								},
								'effectiveDate_month' : {
									required : "Effective Date  is a mandatory field, Please enter the Effective Month"
								},
								'effectiveDate_year' : {
									required : "Effective Date  is a mandatory field, Please enter the Effective Year",
									greaterThan: "Effective Date must be greater than Date of Birth"	
								},
								'dateOfBirth_day' :  {
									required : "Please enter the Date Of Birth Day"
								},
								'dateOfBirth_month' :  {
									required : "Please enter the Date Of Birth Month"
								},
								'dateOfBirth_year' :  {
									required : "Please enter the Date Of Birth Year"
								},'status' : {
									alphaspecialchar : "Please enter a valid Status. Letters, Numbers, hyphen and underscore are allowed.",	
								    required : "Status is a mandatory field, please input the value for Status."
								},
								'termDate_year' :  {
									greaterThan: "Term Date must be greater than Effective Date."
								},'pinTid' : {
							 	    pinIdDigits : "Pin Tin must be 9 digits.",
							 	    required : "Pin Tin is a mandatory field, please input the value for Pin Tin."
							 	},'payType' : {
							 		required : "Pay Type is a mandatory field, please input the value for Pay Type."
						 		},	    
				     </g:if>
				<g:if test="${'ADDRESS'.equals(params.editType)}">
						<g:each in="${agentMasterInstance?.agentAddresses}" var="agentAddress" status="i">
							'agentAddress.${i}.addressLine1' : {
									required : "Please enter the Address Line 1",
									customValidation1 : "Please enter letters, numbers, hyphen, space and period only for Address Line 1"
							},
							'agentAddress.${i}.addressLine2' : {
								customValidation1 : "Please enter letters, numbers, hyphen, space and period only for Address Line 2"
							},
							'agentAddress.${i}.city' : {
								required : "Please enter the City",
								customValidation2 : "Please enter letters, period and space only for City"
							},
							'agentAddress.${i}.state' : {
								required : "Please select a State"
							},
							'agentAddress.${i}.county' : {
								customValidation3 : "Please enter letters, space and hyphen only for County"
							},
							'agentAddress.${i}.country' : {
								customValidation4 : "Please enter letters only for Country"
							},
							'agentAddress.${i}.zipCode' : {
								required : "Please enter the Zip Code",
								zipcodeUS : "Zip Code must be 5 or 9 digits"
							},
							'agentAddress.${i}.addressType' : {
								required : "Please select an Address Type"
							},
							'agentAddress.${i}.effectiveDate_day' : {
								required : "Please enter the Effective Date"
							},
							'agentAddress.${i}.effectiveDate_month' : {
								required : "Please enter the Effective Month"
							},
							'agentAddress.${i}.effectiveDate_year' : {
								required : "Please enter the Effective Year"
							},
							'agentAddress.${i}.termReason' :  {
								required : "Term Reason is a mandatory field if Term Date is entered, please enter the Term Reason"
							},
							'agentAddress.${i}.termDate_year' :  {
								required : "Term Date is a mandatory field if Term Reason is entered, please enter the Term Year"
							},
							'agentAddress.${i}.termDate_month' :  {
								required : "Term Date is a mandatory field if Term Reason is entered, please enter the Term Month"
							},
							'agentAddress.${i}.termDate_day' :  {
								required : "Term Date is a mandatory field if Term Reason is entered, please enter the Term Date"
							},
						</g:each>	
					</g:if>	
					<g:if test="${'CONTACT'.equals(params.editType)}">
						<g:each in="${agentMasterInstance?.agentContacts}" var="agentContact" status="i">
							'agentContact.${i}.contactName' : {
								required : "Please enter the Name of the Contact",
								customValidation1 : "Please enter letters, numbers, hyphen, space and period only for Name of the Contact"
							},
							'agentContact.${i}.phoneNumber' : {
								required : "Please enter the Phone Number",
								phoneValidation: "Phone Number must be 10 digits"
							},
							'agentContact.${i}.emailAddress': {
								email : "Please enter a valid Email Address"
							},
							'agentContact.${i}.faxNumber' : {
								phoneValidation: "Fax Number must be 10 digits"
							},
							'agentContact.${i}.mobilePhone' : {
								phoneValidation: "Mobile Phone must be 10 digits"
							},
							'agentContact.${i}.businessPhone' : {
								phoneValidation: "Business Phone must be 10 digits"
							},
						</g:each>
				</g:if>
				
				<g:if test="${'CONTRACTS'.equals(params.editType)}">
						<g:each in="${agentMasterInstance?.agentGroupContracts}" var="agentContract" status="i">
							'agentContract.${i}.seqGroupId' : {
								required : "Please enter a valid Group Id"
							},
							'${i}.groupId' : {
								required : "Please enter a Group Id"
							},
							'${i}.planRiderCode' : {
								required : "Please enter a Plan/Rider Code"
							},
						</g:each>
				</g:if>
				
				 <g:if test="${'BANKING'.equals(params.editType)}">
				 <g:each in="${agentMasterInstance?.agentEFTs}" var="agentEFT" status="i">
							'agentEFT.${i}.accountNumber' : {
								required : "Please enter the Account Number",
								numberValidation : "Please enter numbers only for Bank Account No."
							},
							'agentEFT.${i}.nameOnAccount' : {
								required : "Please enter the Name on Account",
								customValidation1 : "Please enter letters, numbers, hyphen, space and period only for Name on Account"
							},
							'agentEFT.${i}.bankName' : {
								required : "Please enter the Bank Name",
								customValidation1 : "Please enter letters, numbers, hyphen, spaces and period only for Bank Name"
							},
							'agentEFT.${i}.routingNumber' : {
								required : "Please enter the ABA Routing No.",
								numberValidation : "Please enter numbers only for ABA Routing No."
							},
							'agentEFT.${i}.description' : {
								customValidation1 : "Please enter letters, numbers, hyphen, spaces and period only for Account Description."
							},
							'agentEFT.${i}.statusFlag' : {
								required : "Please select a Status",
							},
							'agentEFT.${i}.effectiveDate_day' : {
								required : "Please enter the Effective Date"
							},
							'agentEFT.${i}.effectiveDate_month' : {
								required : "Please enter the Effective Month"
							},
							'agentEFT.${i}.effectiveDate_year' : {
								required : "Please enter the Effective Year"
							},
							'agentEFT.${i}.termReason' :  {
								required : "Term Reason is a mandatory field if Term Date is entered, please enter the Term Reason"
							},
							'agentEFT.${i}.termDate_year' :  {
								required : "Term Date is a mandatory field if Term Reason is entered, please enter the Term Year"
							},
							'agentEFT.${i}.termDate_month' :  {
								required : "Term Date is a mandatory field if Term Reason is entered, please enter the Term Month"
							},
							'agentEFT.${i}.termDate_day' :  {
								required : "Term Date is a mandatory field if Term Reason is entered, please enter the Term Date"
							},'agentEFT.${i}.accountType' : {
							required : "Please select an Account Type"
						},	
				</g:each>
				</g:if>	
				
				<g:if test="${'LICENSE'.equals(params.editType) && 'UPDATE'.equals(params.editSubType)}">
						<g:each in="${agencyLicenseHdrInstance}" var="agencyLicense" status="i">
							'agencyLicense.0.licenseLoa' : {
								required : "Please select a LOA"
							},
						  	'agencyLicense.0.state' : {
								required : "Please select a State"
							},
							'agencyLicense.agencyLicenceDtls.0.effectiveDate_day' : {
								required : "Please enter the Effective Date"
							},
							'agencyLicense.agencyLicenceDtls.0.effectiveDate_month' : {
								required : "Please enter the Effective Month"
							},
							'agencyLicense.agencyLicenceDtls.0.effectiveDate_year' : {
								required : "Please enter the Effective Year"
							},
							'agencyLicense.agencyLicenceDtls.0.expirationDate_day' : {
								required : "Please enter the Expiration Date"
							},
							'agencyLicense.agencyLicenceDtls.0.expirationDate_month' : {
								required : "Please enter the Expiration Month"
							},
							'agencyLicense.agencyLicenceDtls.0.expirationDate_year' : {
								required : "Please enter the Expiration Year",
								dateCompareGreaterThan: "Expiration Date must be after the Effective Date"
							},
						  	'agencyLicense.agencyLicenceDtls.0.status' : {
								required : "Please select a Status"
							},
							'agencyLicense.agencyLicenceDtls.0.currentStatusDate_day' : {
								required : "Current Status Date is required for the current License Status. Please enter the Status Date"
							},
							'agencyLicense.agencyLicenceDtls.0.currentStatusDate_month' : {
								required : "Current Status Date is required for the current License Status. Please enter the Status Month"
							},
							'agencyLicense.agencyLicenceDtls.0.currentStatusDate_year' : {
								required : "Current Status Date is required for the current License Status. Please enter the Status Year"
							},
							
								<g:each in="${agencyLicenseHdrInstance?.agencyLicenseCertificates}" var="agencyLicenseCertificate" status="j">
									'agencyLicenseCertificate.${j}.course' : {
										required : "Either the Course ID or Description must be entered. Both cannot be blank"
									},
									'agencyLicenseCertificate.${j}.description' : {
										required : "Either the Course ID or Description must be entered. Both cannot be blank"
									},
									'agencyLicenseCertificate.${j}.completionDate_day' : {
										required : "Completion Date is required if Certification Course or Description is entered. Please enter Completion Date"					
									},
									'agencyLicenseCertificate.${j}.completionDate_month' : {
										required : "Completion Date is required if Certification Course or Description is entered. Please enter Completion Month"
									},
									'agencyLicenseCertificate.${j}.completionDate_year' : {
										noFutureDates:  "Completion Date cannot be in the future",
										required : "Completion Date is required if Certification Course or Description is entered. Please enter Completion Year"
									},
									'agencyLicenseCertificate.${j}.expirationDate_year' : {
										dateCompareGreaterThanOrEqual2: "Certificate Expiration Date cannot be before Completion Date",
										dateCompareGreaterThanOrEqual: "Certificate Expiration Date cannot be before Current Status Date"
									},
								</g:each>
						</g:each>
					</g:if>				
			} 

			}) //validate End Tag
			
		}); //Function End Tag
		
	</g:if>
  <g:if test="${'MASTER'.equals(params.editType)}">
	var agcyId = "${agentMasterInstance.agencys?.agencyId}";
		agcyId = agcyId.replace(/[\])}[{(]/g, ''); 
		document.getElementById('agencyId').value = agcyId;
	
		var agcyName = "${agentMasterInstance.agencys?.agencyName}";
		agcyName = agcyName.replace(/[\])}[{(]/g, ''); 
		document.getElementById('idAgencyName').value = agcyName;
		
	$("#agencyId").live("keydown" , function (e) {
      if (e.which == 9)
    	    getAgentName()		
     });	
     
     $('#agentType').change(function () {
		  getAgentType();
       });
       
       //Disable and enable the agency id, agency name, effective date on the bases of agent type value
    var agentTypeId = document.getElementById('agentType');
	agentTypeIdValue = agentTypeId.options[agentTypeId.selectedIndex].value; 
	if(agentTypeIdValue=='I' || agentTypeIdValue==""){
	   document.getElementById("agencyId").disabled = true
	     document.getElementById("idAgencyName").readOnly = true
	     if(document.getElementById("effectiveDate")!=null){	
			document.getElementById("effectiveDate").disabled = true 
			}    	
	}
	else{
	           if(document.getElementById("effectiveDate")!=null){	  
		       document.getElementById("effectiveDate").disabled = false
		       }          
	 } 
</g:if>	
	
}); 


function getAgentName() {
		var appName = "${appContext.metadata['app.name']}";		
		var agentTypeId = document.getElementById('agentType');
		agentTypeIdValue = agentTypeId.options[agentTypeId.selectedIndex].value;
		
		var agencyId = document.getElementById('agencyId').value;			        
        var agentId = document.getElementById('agentId').value;		 
			  if(agentTypeIdValue=="C"){
				  	var appName = "${appContext.metadata['app.name']}";
				    		        
					var loggedInUser;
					var loginRequest = jQuery.ajax({
					url : "/"+appName+"/agentMaster/getValidationOnAgentType?agentType="+agentTypeIdValue+"&agencyId="+agencyId+"&agentId="+agentId,
					type : "POST",
					success : function(result) {
						var index = result.indexOf("-")
						var length = result.length
						var idAgencyName = result.substr(0 , index).trim()
						var agencyId = result.substr(index+1 , length).trim()
						document.getElementById("idAgencyName").value = idAgencyName;
						document.getElementById("agencyId").value = agencyId;
								
					}				
			});
		} 
   }
	     function getAgentType() {
	    	 var appName = "${appContext.metadata['app.name']}";		
	 		 var agentTypeId = document.getElementById('agentType');
	 		 agentTypeIdValue = agentTypeId.options[agentTypeId.selectedIndex].value;
			 if(agentTypeIdValue=='C'){
				  		document.getElementById("agencyId").value = "";
			            document.getElementById("idAgencyName").value = "";
				            
		            	var loggedInUser;
						var loginRequest = jQuery.ajax({
						url : "/"+appName+"/agentMaster/getValidationOnAgentType?agentType="+agentTypeIdValue+"&agentId="+agentId,
						type : "POST",
						success : function(result) {							
							document.getElementById("agentTypeValue").value = result;
							document.getElementById("agencyId").disabled = false;
			             	document.getElementById("idAgencyName").disabled = false;
			             	if(document.getElementById("effectiveDate")!=null){	
			            	document.getElementById("effectiveDate").disabled = false;
			            	}
											
						}				
				});  
		 }
			  else{
				 		document.getElementById("agencyId").value = "";
			            document.getElementById("idAgencyName").value = "";
	        			var loggedInUser;
						var loginRequest = jQuery.ajax({
						url : "/"+appName+"/agentMaster/getValidationOnAgentType?agentType="+agentTypeIdValue+"&agentId="+agentId,
						type : "POST",
						success : function(result) {
							var agentTypeValue=result;
							document.getElementById("agencyId").disabled = true;
				        	document.getElementById("idAgencyName").disabled = true;
				        	if(document.getElementById("effectiveDate")!=null){	
				        	document.getElementById("effectiveDate").disabled = true;
				        	}
										
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
		<a href="#edit-agentMaster" class="skip" tabindex="-1"><g:message code="default.link.skip.label" default="Skip to content&hellip;"/></a>
				<div class="nav" role="navigation">
			<ul>
				<li><g:link class="list" action="edit" params="${[seqAgentId: agentMasterInstance?.seqAgentId, agentId: agentMasterInstance?.agentId, agentType: agentMasterInstance?.agentType, editType :'MASTER', creationDate:params.creationDate]}">Master Record</g:link></li>
				<li><g:link class="list" action="edit" params="${[seqAgentId: agentMasterInstance?.seqAgentId, agentId: agentMasterInstance?.agentId, agentType: agentMasterInstance?.agentType, editType :'ADDRESS', creationDate:params.creationDate]}">Addresses</g:link></li>
				<li><g:link class="list" action="edit" params="${[seqAgentId: agentMasterInstance?.seqAgentId, agentId: agentMasterInstance?.agentId, agentType: agentMasterInstance?.agentType, editType :'CONTACT', creationDate:params.creationDate]}">Contacts</g:link></li>
				<li><g:link class="list" action="edit" params="${[seqAgentId: agentMasterInstance?.seqAgentId, agentId: agentMasterInstance?.agentId, agentType: agentMasterInstance?.agentType, editType :'TXN', creationDate:params.creationDate]}">Transactions</g:link></li>
				<li><g:link class="list" action="edit" params="${[seqAgentId: agentMasterInstance?.seqAgentId, agentId: agentMasterInstance?.agentId, agentType: agentMasterInstance?.agentType, editType :'COMMISSION', creationDate:params.creationDate]}">Broker Commissions</g:link></li>
				<li><g:link class="list" action="edit" params="${[seqAgentId: agentMasterInstance?.seqAgentId, agentId: agentMasterInstance?.agentId, agentType: agentMasterInstance?.agentType, editType :'CONTRACTS', creationDate:params.creationDate]}">Contracts</g:link></li>
			    <li><g:link class="list" action="edit" params="${[seqAgentId: agentMasterInstance?.seqAgentId, agentId: agentMasterInstance?.agentId, agentType: agentMasterInstance?.agentType, editType :'BANKING', creationDate:params.creationDate]}">Banking</g:link></li>
			    <li><g:link class="list" action="edit" params="${[seqAgentId: agentMasterInstance?.seqAgentId, agentId: agentMasterInstance?.agentId, agentType: agentMasterInstance?.agentType, editType :'LICENSE', callingPage: 'AGENT']}">License and Certification</g:link></li>   
			</ul>
		</div>
		<div id="edit-agentMaster" class="content scaffold-edit" role="main">
			<g:if test="${params.editType?.equals("MASTER") || params.editType?.equals("ADDRESS") || params.editType?.equals("CONTRACTS") || params.editType?.equals("CONTACT")|| params.editType?.equals("TXN") ||params.editType?.equals("BANKING")}">
				<h1 style="color: #48802C"><g:message code="default.edit.label" args="[entityName]" /> - ${ params.editType}</h1>
			</g:if>
			<g:elseif test="${params.editType?.equals("LICENSE") && params.editSubType?.equals("UPDATE") }">
				<h1 style="color: #48802C"><g:message code="default.edit.label" args="[entityName]" /> - LICENSE AND CERTIFICATION</h1>
			</g:elseif>
			<div class="right-corner" align="center">
				<g:if test="${("MASTER".equals(request.getParameter('editType')))}">AGNTM</g:if>
				<g:if test="${("ADDRESS".equals(request.getParameter('editType')))}">AGNTA</g:if>
				<g:if test="${("CONTACT".equals(request.getParameter('editType')))}">AGNTC</g:if>
				<g:if test="${("CONTRACTS".equals(request.getParameter('editType')))}">COMMC</g:if>
				<g:if test="${("BANKING".equals(request.getParameter('editType')))}">BRBNK</g:if>
				<g:if test="${("LICENSE".equals(request.getParameter('editType')))}">
					<g:if test= "${("UPDATE".equals(request.getParameter('editSubType'))) && ("AGENCY".equals(request.getParameter('callingPage')))}">
						AGNCL					
					</g:if>
					<g:elseif test= "${("UPDATE".equals(request.getParameter('editSubType'))) && ("AGENT".equals(request.getParameter('callingPage')))}">
						AGNTL					
					</g:elseif>
				</g:if>
			</div>
			<g:if test="${(flash.message)}">
				<g:if test="${("LICENSE".equals(request.getParameter('editType')))}">
					<g:if test="${("UPDATE".equals(request.getParameter('editSubType')))}">
						<div class="message" role="status">${flash.message}</div>
					</g:if>
				</g:if>
				<g:else>
						<div class="message" role="status">${flash.message}</div>
				</g:else>
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
			<g:hasErrors bean="${agentMasterInstance}">
			<ul class="errors" role="alert">
				<g:eachError bean="${agentMasterInstance}" var="error">
				<li <g:if test="${error in org.springframework.validation.FieldError}">data-field-id="${error.field}"</g:if>><g:message error="${error}"/></li>
				</g:eachError>
			</ul>
			</g:hasErrors>
			<g:hasErrors bean="${agentAddress}">
			<ul class="errors" role="alert">
				<g:eachError bean="${agentAddress}" var="error">
				<li <g:if test="${error in org.springframework.validation.FieldError}">data-field-id="${error.field}"</g:if>><g:message error="${error}"/></li>
				</g:eachError>
			</ul>
			</g:hasErrors>
			<div id="errorDisplay" style="display: none;" class="errors"
				style="float:left; margin: -5px 10px 0px 0px; "></div>
					<g:if test="${params.editType?.equals("TXN")}">
						<g:form method="post" >
							<g:render template="/FMSInterfaces/finTransResult" model="${[finResponse: searchResultCommand.financialTransactionResponse]}"/>
						</g:form>
					</g:if>
					<g:elseif test="${params.editType?.equals("MASTER")}">
					<input type="hidden" id="agentTypeValue" value="${agentTypeValue}" />
							<g:form method="post" name="editForm" id="editForm">
								<fieldset class="form">
									<g:render template="form"/>
								</fieldset>
								<fieldset class="buttons">
									<div style="align:left;display:inline">
									<g:actionSubmit class="save" action="update" value="${message(code: 'default.button.update.label', default: 'Update')}" />
									</div> 
									<div style="align:right;display:inline" >
									<input type="Reset" class="reset" value="Reset" />
									<input type="button" class="close" value="Close" onClick="closeForm()"/>
									</div>
								</fieldset>
							</g:form>
					</g:elseif>
					<g:elseif test="${params.editType?.equals("COMMISSION")}">
							<g:form method="post" >
								<g:if test="${params.creationDate}">
									<fieldset class="form">
										<g:render template="agentCommissionForm"/>
									</fieldset>
								</g:if>
								<g:else>
									<fieldset class="form">
										<g:render template="agentCommissionMultipleStmtForm"/>
									</fieldset>
								</g:else>
							</g:form>
					</g:elseif>
					<g:elseif test="${params.editType?.equals("ADDRESS")}">
								<g:form action="update" id="editForm" name="editForm">
									<fieldset class="form">
										<g:render template="agentAddressForm"/>
									</fieldset>
									<fieldset class="buttons">
										<div style="align:left;display:inline">
											<g:actionSubmit class="save" action="update" value="${message(code: 'default.button.update.label', default: 'Update')}" />
										</div> 
										<div style="align:right;display:inline" >
										<input type="Reset" class="reset" value="Reset" />
										<input type="button" class="close" value="Close" onClick="closeForm()"/>
										</div>
									</fieldset>
								</g:form>
				</g:elseif>
				<g:elseif test="${params.editType?.equals("CONTACT")}">
								<g:form action="update" id="editForm" name="editForm">
									<fieldset class="form">
										<g:render template="agentContactForm"/>
									</fieldset>
									<fieldset class="buttons">
										<div style="align:left;display:inline">
											<g:actionSubmit class="save" action="update" value="${message(code: 'default.button.update.label', default: 'Update')}" />
										</div> 
										<div style="align:right;display:inline" >
										<input type="Reset" class="reset" value="Reset" />
										<input type="button" class="close" value="Close" onClick="closeForm()"/>
										</div>
									</fieldset>
								</g:form>
				</g:elseif>
					<g:elseif test="${params.editType?.equals("CONTRACTS")}">
								<g:form action="update" id="editForm" name="editForm">
									<fieldset class="form">
										<g:render template="agentContractsForm"/>
									</fieldset>
									<fieldset class="buttons">
										<div style="align:left;display:inline">
											<g:actionSubmit class="save" action="update" value="${message(code: 'default.button.update.label', default: 'Update')}" />
										</div> 
										<div style="align:right;display:inline" >
										<input type="Reset" class="reset" value="Reset" />
										<input type="button" class="close" value="Close" onClick="closeForm()"/>
										</div>
									</fieldset>
								</g:form>
					</g:elseif>
						<g:elseif test="${params.editType?.equals("BANKING")}">
								<g:form action="update" id="editForm" name="editForm">
									<fieldset class="form">
										<g:render template="agentBankingForm"/>
									</fieldset>
									<fieldset class="buttons">
										<div style="align:left;display:inline">
											<g:actionSubmit class="save" action="update" value="${message(code: 'default.button.update.label', default: 'Update')}" />
										</div>									
										<div style="align:right;display:inline" >
										<input type="button" class="reset" value="Reset" onclick="location.reload();"/>
										<input type="button" class="close" value="Close" onClick="closeForm()"/>
										</div>
									</fieldset>
								</g:form>
					</g:elseif>
					<g:elseif test="${params.editType?.equals("LICENSE")}">
						<g:if test="${params.editSubType?.equals("UPDATE")}">
								<g:form url="[action:'update', controller:'agency']" id="editForm" name="editForm">
								<div id="errorDisplay" style="display: none;" class="errors"
									style="float:left; margin: -5px 10px 0px 0px; "></div>
									<fieldset class="form">
											<g:render template="/agency/licenseCertificationForm"/>
									</fieldset>
									<fieldset class="buttons">
											<div style="align:left;display:inline">
												<g:actionSubmit class="save" action="update" value="${message(code: 'default.button.update.label', default: 'Update')}" />
											</div> 
											<div style="align:right;display:inline" >
												<input type="Reset" class="reset" value="Reset" onClick="resetForm()"/>
												<input type="button" class="close" value="Close" onClick="closeForm()"/>
											</div>
									</fieldset>
								</g:form>
						</g:if>
						<g:else>
								<g:render template="/agency/searchLicense"/>
						</g:else>
					</g:elseif>
		</div>
	<div style="display:none">
	<input type="button" onClick="closeAllIFrames()" id="closeIframes" name="closeIframes">
	</div>
	</body>
</html>