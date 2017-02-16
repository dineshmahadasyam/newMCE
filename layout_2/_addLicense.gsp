<!DOCTYPE html>
<html>
	<head>
		<meta name="layout" content="main_2">
		<g:set var="entityName" value="${message(code: 'agentMaster.label', default: 'AgentMaster')}" />
		<g:set var="appContext" bean="grailsApplication"/>
		<title><g:message code="default.edit.label" args="[entityName]" /></title>
			
		<link rel="stylesheet" href="${resource(dir: 'css', file: 'jquery.window.css')}" type="text/css">
		<link rel="stylesheet" href="${resource(dir: 'css', file: 'member_pages.css')}" type="text/css">
		
		<script type="text/javascript" src="${resource(dir: 'js', file: 'jquery-1.3.2.js')}"></script>
		<script type="text/javascript" src="${resource(dir: 'js', file: 'jquery-ui-1.7.2.js')}"></script>
		<script type="text/javascript" src="${resource(dir: 'js', file: 'jquery.window.js')}"></script>
		
		<script type="text/javascript" src="http://ajax.aspnetcdn.com/ajax/jquery.validate/1.11.1/jquery.validate.js"></script>
		<script type="text/javascript" src="${resource(dir: 'js', file: 'additional-methods.js')}"></script>	
		<script type="text/javascript" src="${resource(dir: 'js', file: 'jquery.maskedinput.js')}"></script>
		<script type="text/javascript" src="${resource(dir: 'js', file: 'jquery.alphanum.js')}"></script>
		
		
		<script type="text/javascript">

		function resetForm() {
			document.forms['editForm'].reset();
			//After the form has been reset check the status field and set the status date field appropriately
			if($("#agencyLicenseDtl\\.0\\.status").val() == 'AC') {
				//If Status is Active(AC) then Current Status date is not required and needs to be disabled 
				$('#agencyLicenseDtl\\.0\\.currentStatusDate_day').attr('disabled', 'disabled');
				$('#agencyLicenseDtl\\.0\\.currentStatusDate_month').attr('disabled', 'disabled');
				$('#agencyLicenseDtl\\.0\\.currentStatusDate_year').attr('disabled', 'disabled');
				$('#agencyLicenseDtl\\.0\\.currentStatusDate_day').val('');
				$('#agencyLicenseDtl\\.0\\.currentStatusDate_month').val('');
				$('#agencyLicenseDtl\\.0\\.currentStatusDate_year').val('');
				
				$('#reqdCurrentStatusDate').hide()
			}
			else if($("#agencyLicenseDtl\\.0\\.status").val() == '') {
				//If Status is empty then Current Status date is enabled but not marked required
				$('#agencyLicenseDtl\\.0\\.currentStatusDate_day').removeAttr('disabled');
				$('#agencyLicenseDtl\\.0\\.currentStatusDate_month').removeAttr('disabled');
				$('#agencyLicenseDtl\\.0\\.currentStatusDate_year').removeAttr('disabled');
				
				$('#reqdCurrentStatusDate').hide()
			}
			else {
				//If Status is not equal to Active(AC) and not empty then Current Status date is required and needs to be enabled 
				$('#agencyLicenseDtl\\.0\\.currentStatusDate_day').removeAttr('disabled');
				$('#agencyLicenseDtl\\.0\\.currentStatusDate_month').removeAttr('disabled');
				$('#agencyLicenseDtl\\.0\\.currentStatusDate_year').removeAttr('disabled');
				$('#reqdCurrentStatusDate').show()
			}
		}

		$(document).ready(function() {

			$(".maskTaxID").mask("?99-9999999");

			//When page loads do not show current status date to be required
			$('#reqdCurrentStatusDate').hide()
			
			//When page loads do not show certificate completion date to be required
			$('#reqdCompletionDate').hide()
			
			//Allow tabbing but prevent postback to previous page if user presses backspace since these fields are readonly
			$('#agencyId, #agentId, #agencyName, #agentName, #tin, #pinTid, #agencyLicenseHdr\\.0\\.licenseNumber').live('keydown', function(e) {
					if (e.keyCode != 9) {
						e.preventDefault();
					}
			});
			
			//If there is a value within the course or description field mark the completion date mandatory
			$(".courseGroup,.descriptionGroup").bind("change paste keyup", function() {
				if ($(".courseGroup,.descriptionGroup").filter(function() { return $(this).val(); }).length > 0) {
					$('#reqdCompletionDate').show()
				}
				else {
					$('#reqdCompletionDate').hide()
				}
			});
			
			//Enable and Disable Current Status Date field based on Status field
			$('#agencyLicenseDtl\\.0\\.status').change(function(){
				if($("#agencyLicenseDtl\\.0\\.status").val() == 'AC') {
					//If status is Active(AC) then Current Status date is not required and needs to be disabled 
					$('#agencyLicenseDtl\\.0\\.currentStatusDate_day').attr('disabled', 'disabled');
					$('#agencyLicenseDtl\\.0\\.currentStatusDate_month').attr('disabled', 'disabled');
					$('#agencyLicenseDtl\\.0\\.currentStatusDate_year').attr('disabled', 'disabled');
					$('#agencyLicenseDtl\\.0\\.currentStatusDate_day').val('');
					$('#agencyLicenseDtl\\.0\\.currentStatusDate_month').val('');
					$('#agencyLicenseDtl\\.0\\.currentStatusDate_year').val('');
					
					$('#reqdCurrentStatusDate').hide()
				}
				else {
					//If status is not equal to Active(AC) then Current Status date is required and needs to be enabled 
					$('#agencyLicenseDtl\\.0\\.currentStatusDate_day').removeAttr('disabled');
					$('#agencyLicenseDtl\\.0\\.currentStatusDate_month').removeAttr('disabled');
					$('#agencyLicenseDtl\\.0\\.currentStatusDate_year').removeAttr('disabled');
					$('#reqdCurrentStatusDate').show()
				}
			});	

			//Add certificate row
			$("#btnAddRow").click(function () {
				
				//Get the number of rows from the table. Since the first row is a header consider one less for real number of rows
				var iRows = document.getElementById("tblCertificate").rows.length -1;
				
				//Show the first row if all the rows were deleted earlier
				if (iRows == 1) {
					if ($('.toggleDisplay').is(':hidden')) {
						$('.toggleDisplay').show();
					}
					else {
						addAnotherRow();
					}
				}
				else {
					addAnotherRow();
				}
		    });

			//delete certificate row
			 $('.deleteThisRow').live('click',function(){

				//Get the number of rows from the table. Since the first row is a header consider one less for real number of rows
				var iRows = document.getElementById("tblCertificate").rows.length -1;
				
				//Just hide the row and dont delete the last row so there will always be a row to be cloned from.
				//Empty the input fields in case user just clicks on delete after entering some data before hidding. emptying is done
				//or else when the row is cloned it will get cloned with previous data
				if (iRows == 1) {
					
					$('#reqdCompletionDate').hide()
					
					$('.courseGroup').val('')
					$('.descriptionGroup').val('')
					
					$("select[name*='\\.completionDate']" ).val("");
					
					//Empty Expiration Date of the certification table field only
					$("select[name*='\\.expirationDate'][name ^='agencyLicenseCertificate']").val("");
					
					$('.toggleDisplay').hide();
				}
				else {
					$(this).closest("tr").remove();
				}
				
				var errors = validator.numberOfInvalids();
			    if (errors) {  
					//Re-validate the form to update the errors after deleting the certificate row
					$("#editForm").valid();
				}
				
		    });
			
			$.validator.addMethod("alphanumeric", function(value, element) {
				return this.optional(element) || /^[a-zA-Z0-9 ]+$/i.test(value);
			}, "Please enter letters or numbers only");


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
						
			jQuery.validator.setDefaults({
				  debug: true,
					ignore: []
				});

			 //Alias required to add rules and message so these can be used to dynamically added fields with the same classname
			$.validator.addMethod("courseAlphanumeric", $.validator.methods.alphanumeric, "Please enter letters or numbers only for Certification Course");
			$.validator.addMethod("descriptionAlphanumeric", $.validator.methods.alphanumeric, "Please enter letters or numbers only for Certification Description");
			
			$.validator.addClassRules("courseGroup", {courseAlphanumeric : true });
			$.validator.addClassRules("descriptionGroup", {descriptionAlphanumeric : true });
			
			//Fire Description rule so the errors dont get left behind if Course has data
			$(".courseGroup").bind("change keyup", function() {
				var errors = validator.numberOfInvalids();
	            if (errors) { 
					$("#editForm").validate().element(".descriptionGroup");
	            }
			});
			
			//Fire Course rule so the errors dont get left behind if Description has data
			$(".descriptionGroup").bind("change keyup", function() {
				var errors = validator.numberOfInvalids();
	            if (errors) { 
					$("#editForm").validate().element(".courseGroup");
	            }
			});
			
			
			$(function() {		
				validator = $("#editForm").validate({
					//Added ignoreTitle=true so it does not pick up the default title as the validation message
					//for dynamically added fields through their class name
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
						 	'agencyLicenseHdr.0.licenseLoa' : {
								required : true
							},
						  	'agencyLicenseHdr.0.state' : {
								required : true
							},
							'agencyLicenseDtl.0.effectiveDate_day' : {
								required : true
							},
							'agencyLicenseDtl.0.effectiveDate_month' : {
								required : true
							},
							'agencyLicenseDtl.0.effectiveDate_year' : {
								required : true
							},
							'agencyLicenseDtl.0.expirationDate_day' : {
								required : true
							},
							'agencyLicenseDtl.0.expirationDate_month' : {
								required : true
							},
							'agencyLicenseDtl.0.expirationDate_year' : {
								required : true,
								dateCompareGreaterThan:["#agencyLicenseDtl\\.0\\.effectiveDate","#agencyLicenseDtl\\.0\\.expirationDate","Effective Date","Expiration Date"]
							},
						  	'agencyLicenseDtl.0.status' : {
								required : true
							},
							'agencyLicenseDtl.0.currentStatusDate_day' : {
								required : {
									depends: function(){	
										return 	($('#agencyLicenseDtl\\.0\\.status').val() != 'AC'	&&  $('#agencyLicenseDtl\\.0\\.status').val() != '')												
									}
								}
							},
							'agencyLicenseDtl.0.currentStatusDate_month' : {
								required : {
									depends: function(){		
										return 	($('#agencyLicenseDtl\\.0\\.status').val() != 'AC'	&&  $('#agencyLicenseDtl\\.0\\.status').val() != '')															
									}
								}
							},
							'agencyLicenseDtl.0.currentStatusDate_year' : {
								required : {
									depends: function(){		
										return 	($('#agencyLicenseDtl\\.0\\.status').val() != 'AC'	&&  $('#agencyLicenseDtl\\.0\\.status').val() != '')														
									}
								}
							},
							'agencyLicenseCertificate.1.course' : {
								required : {
									depends: function(){
										return ($.trim($("#agencyLicenseCertificate\\.1\\.completionDate_day").val()).length > 0 ||
										$.trim($("#agencyLicenseCertificate\\.1\\.completionDate_month").val()).length > 0 ||
										$.trim($("#agencyLicenseCertificate\\.1\\.completionDate_year").val()).length > 0) &&
										$.trim($("#agencyLicenseCertificate\\.1\\.description").val()) == 0;		
									}
								}
							},
							'agencyLicenseCertificate.1.description' : {
								required : {
									depends: function(){												
											return ($.trim($("#agencyLicenseCertificate\\.1\\.completionDate_day").val()).length > 0 ||
											$.trim($("#agencyLicenseCertificate\\.1\\.completionDate_month").val()).length > 0 ||
											$.trim($("#agencyLicenseCertificate\\.1\\.completionDate_year").val()).length > 0) &&
											$.trim($("#agencyLicenseCertificate\\.1\\.course").val()) == 0;			
									}
								}
							},
							'agencyLicenseCertificate.1.completionDate_day' : {
								required : function(element){														
									return $.trim($("#agencyLicenseCertificate\\.1\\.course").val()).length > 0 ||
									$.trim($("#agencyLicenseCertificate\\.1\\.description").val()).length > 0;						
								}
							},
							'agencyLicenseCertificate.1.completionDate_month' : {
								required : function(element){														
									return $.trim($("#agencyLicenseCertificate\\.1\\.course").val()).length > 0 ||
									$.trim($("#agencyLicenseCertificate\\.1\\.description").val()).length > 0;						
								}
							},
							'agencyLicenseCertificate.1.completionDate_year' : {
								noFutureDates: ["#agencyLicenseCertificate\\.1\\.completionDate"],
								required : function(element){														
									return $.trim($("#agencyLicenseCertificate\\.1\\.course").val()).length > 0 ||
									$.trim($("#agencyLicenseCertificate\\.1\\.description").val()).length > 0;						
								}
							},
							'agencyLicenseCertificate.1.expirationDate_year' : {
								dateCompareGreaterThanOrEqual2:["#agencyLicenseCertificate\\.1\\.completionDate","#agencyLicenseCertificate\\.1\\.expirationDate","Completion Date","Expiration Date"],
								dateCompareGreaterThanOrEqual:["#agencyLicenseDtl\\.0\\.currentStatusDate","#agencyLicenseCertificate\\.1\\.expirationDate","Status Date","Expiration Date"]						
							},
							
					},
				messages : {
							'agencyLicenseHdr.0.licenseLoa' : {
								required : "Please select a LOA"
							},
							'agencyLicenseHdr.0.state' : {
								required : "Please select a State"
							},
							'agencyLicenseDtl.0.effectiveDate_day' : {
								required : "Please enter the Effective Date"
							},
							'agencyLicenseDtl.0.effectiveDate_month' : {
								required : "Please enter the Effective Month"
							},
							'agencyLicenseDtl.0.effectiveDate_year' : {
								required : "Please enter the Effective Year"
							},
							'agencyLicenseDtl.0.expirationDate_day' : {
								required : "Please enter the Expiration Date"
							},
							'agencyLicenseDtl.0.expirationDate_month' : {
								required : "Please enter the Expiration Month"
							},
							'agencyLicenseDtl.0.expirationDate_year' : {
								required : "Please enter the Expiration Year",
								dateCompareGreaterThan: "Expiration Date must be after the Effective Date"
							},
						  	'agencyLicenseDtl.0.status' : {
								required : "Please select a Status"
							},
							'agencyLicenseDtl.0.currentStatusDate_day' : {
								required : "Current Status Date is required for the current License Status. Please enter the Status Date"
							},
							'agencyLicenseDtl.0.currentStatusDate_month' : {
								required : "Current Status Date is required for the current License Status. Please enter the Status Month"
							},
							'agencyLicenseDtl.0.currentStatusDate_year' : {
								required : "Current Status Date is required for the current License Status. Please enter the Status Year"
							},
							'agencyLicenseCertificate.1.course' : {
								required : "Either the Course ID or Description must be entered. Both cannot be blank"
							},
							'agencyLicenseCertificate.1.description' : {
								required :  "Either the Course ID or Description must be entered. Both cannot be blank"	
							},
							'agencyLicenseCertificate.1.completionDate_day' : {
								required : "Completion Date is required if Certification Course or Description is entered. Please enter Completion Date"					
							},
							'agencyLicenseCertificate.1.completionDate_month' : {
								required : "Completion Date is required if Certification Course or Description is entered. Please enter Completion Month"
							},
							'agencyLicenseCertificate.1.completionDate_year' : {
								noFutureDates: "Completion Date cannot be in the future",
								required : "Completion Date is required if Certification Course or Description is entered. Please enter Completion Year"
							},
							'agencyLicenseCertificate.1.expirationDate_year' : {
								dateCompareGreaterThanOrEqual2: "Certificate Expiration Date cannot be before Completion Date",
								dateCompareGreaterThanOrEqual: "Certificate Expiration Date cannot be before Current Status Date"
							}
					} 
				 
			})
		});
	}); 
				
				var grpInnerWindow
				var innerWindowClosed = true;
			
				function closeAllIFrames() {
					if (grpInnerWindow) {
						grpInnerWindow.close()
					}
				}

				function closeForm() {

					var callingPage ="${params.callingPage}";
					var seqID
					
					if (callingPage == 'AGENCY') {	
						seqID = "${params.seqAgencyId}";
						window.location.assign('<g:createLinkTo dir="/agency/edit?seqAgencyId="/>' 
								+ seqID + '&editType=LICENSE&callingPage=' + callingPage);
					}
					else if (callingPage == 'AGENT') {
						seqID = "${params.seqAgentId}";
						window.location.assign('<g:createLinkTo dir="/agentMaster/edit?seqAgentId="/>' 
								+ seqID + '&editType=LICENSE&callingPage=' + callingPage);
					}
							
				}

				function addAnotherRow() {

					//Get the number of rows from the table. Since the first row is a header consider one less for real number of rows
					var iRows = document.getElementById("tblCertificate").rows.length -1;

					//Allow maximum of 20 certificates to be added at a time. Currently the maximum number is set on the controller
					if (iRows < ${i})
						{
					        var row = $('.tblCertificate tr:last').clone();
					        var oldId = Number(row.attr('id').substring(row.attr('id').lastIndexOf("_") + 1));
						    var id = 1 + oldId;
			
							//Change id and name for each of the newly added row
						    row.attr('id', 'newRow_' + id );
						    row.find("#agencyLicenseCertificate\\." + oldId + "\\.iterationCount").attr("id", "agencyLicenseCertificate." + id + ".iterationCount").attr("name", "agencyLicenseCertificate." + id + ".iterationCount").attr("value", id);
						    row.find("#agencyLicenseCertificate\\." + oldId + "\\.course").attr("id", "agencyLicenseCertificate." + id + ".course").attr("name", "agencyLicenseCertificate." + id + ".course").attr("value", "");
						    row.find("#agencyLicenseCertificate\\." + oldId + "\\.description").attr("id", "agencyLicenseCertificate." + id + ".description").attr("name", "agencyLicenseCertificate." + id + ".description").attr("value", "");
						    row.find("#agencyLicenseCertificate\\." + oldId + "\\.completionDate_day").attr("id", "agencyLicenseCertificate." + id +  ".completionDate_day").attr("name", "agencyLicenseCertificate." + id +  ".completionDate_day");
						    row.find("#agencyLicenseCertificate\\." + oldId + "\\.completionDate_month").attr("id", "agencyLicenseCertificate." + id + ".completionDate_month").attr("name", "agencyLicenseCertificate." + id + ".completionDate_month");
						    row.find("#agencyLicenseCertificate\\." + oldId + "\\.completionDate_year").attr("id", "agencyLicenseCertificate." + id + ".completionDate_year").attr("name", "agencyLicenseCertificate." + id + ".completionDate_year");
						    row.find("#agencyLicenseCertificate\\." + oldId + "\\.expirationDate_day").attr("id", "agencyLicenseCertificate." + id +  ".expirationDate_day").attr("name", "agencyLicenseCertificate." + id +  ".expirationDate_day");
						    row.find("#agencyLicenseCertificate\\." + oldId + "\\.expirationDate_month").attr("id", "agencyLicenseCertificate." + id + ".expirationDate_month").attr("name", "agencyLicenseCertificate." + id + ".expirationDate_month");
						    row.find("#agencyLicenseCertificate\\." + oldId + "\\.expirationDate_year").attr("id", "agencyLicenseCertificate." + id + ".expirationDate_year").attr("name", "agencyLicenseCertificate." + id + ".expirationDate_year");
						    row.find("#agencyLicenseCertificate\\." + oldId + "\\.delete").attr("id", "agencyLicenseCertificate." + id + ".delete").attr("name", "agencyLicenseCertificate." + id + ".delete");
						    $('#tblCertificate').append(row);

						    //Add  JQuery Validation rules for the newly added fields here
						    $("#agencyLicenseCertificate\\." + id + "\\.completionDate_day").rules("add", { 
						    	required : function(element){														
									return $.trim($("#agencyLicenseCertificate\\." + id + "\\.course").val()).length > 0 ||
									$.trim($("#agencyLicenseCertificate\\." + id + "\\.description").val()).length > 0;						
								},
								messages: {
								    required : "Completion Date is required if Certification Course or Description is entered. Please enter Completion Date"
								}
						    });
						    

						    $("#agencyLicenseCertificate\\." + id + "\\.completionDate_month").rules("add", { 
						    	required : function(element){														
									return $.trim($("#agencyLicenseCertificate\\." + id + "\\.course").val()).length > 0 ||
									$.trim($("#agencyLicenseCertificate\\." + id + "\\.description").val()).length > 0;						
								},
								messages: {
								    required : "Completion Date is required if Certification Course or Description is entered. Please enter Completion Month"
								}
						    });
						    

						    $("#agencyLicenseCertificate\\." + id + "\\.completionDate_year").rules("add", { 
						    	required : function(element){														
									return $.trim($("#agencyLicenseCertificate\\." + id + "\\.course").val()).length > 0 ||
									$.trim($("#agencyLicenseCertificate\\." + id + "\\.description").val()).length > 0;						
								},
								messages: {
								    required : "Completion Date is required if Certification Course or Description is entered. Please enter Completion Year"
								}
						    });
						    
						     $("#agencyLicenseCertificate\\." + id + "\\.course").rules("add", { 
						     	required : {
									depends: function(){
										return ($.trim($("#agencyLicenseCertificate\\." + id + "\\.completionDate_day").val()).length > 0 ||
										$.trim($("#agencyLicenseCertificate\\." + id + "\\.completionDate_month").val()).length > 0 ||
										$.trim($("#agencyLicenseCertificate\\." + id + "\\.completionDate_year").val()).length > 0 ) &&
										$.trim($("#agencyLicenseCertificate\\." + id + "\\.description").val()).length == 0	;			
									}
								},
								messages: {
								    required : "Either the Course ID or Description must be entered. Both cannot be blank"
								}
						    });
						    
						    $("#agencyLicenseCertificate\\." + id + "\\.course").bind("change keyup", function() {
								var errors = validator.numberOfInvalids();
					            if (errors) { 
									$("#editForm").validate().element("#agencyLicenseCertificate\\." + id + "\\.description");
					            }
							});
						    
						    
						    $("#agencyLicenseCertificate\\." + id + "\\.description").rules("add", { 
						    	required : {
									depends: function(){
										return ($.trim($("#agencyLicenseCertificate\\." + id + "\\.completionDate_day").val()).length > 0 ||
										$.trim($("#agencyLicenseCertificate\\." + id + "\\.completionDate_month").val()).length > 0 ||
										$.trim($("#agencyLicenseCertificate\\." + id + "\\.completionDate_year").val()).length > 0 ) &&
										$.trim($("#agencyLicenseCertificate\\." + id + "\\.course").val()).length == 0	;			
									}
								},
								messages: {
								    required : "Either the Course ID or Description must be entered. Both cannot be blank"
								}
						    });
						    
						    $("#agencyLicenseCertificate\\." + id + "\\.description").bind("change keyup", function() {
								var errors = validator.numberOfInvalids();
					            if (errors) { 
									$("#editForm").validate().element("#agencyLicenseCertificate\\." + id + "\\.course");
					            }
							});
						    
						    $("#agencyLicenseCertificate\\." + id + "\\.completionDate_year").rules("add", { 
						    	noFutureDates: ["#agencyLicenseCertificate\\." + id + "\\.completionDate"],
								messages: {
								    noFutureDates: "Completion Date cannot be in the future"
								}
						    });
						    
						     $("#agencyLicenseCertificate\\." + id + "\\.expirationDate_year").rules("add", { 
						    	dateCompareGreaterThanOrEqual2: ["#agencyLicenseCertificate\\." + id + "\\.completionDate","#agencyLicenseCertificate\\." + id + "\\.expirationDate", "Completion Date","Expiration Date"],
						    	dateCompareGreaterThanOrEqual: ["#agencyLicenseDtl\\.0\\.currentStatusDate","#agencyLicenseCertificate\\." + id + "\\.expirationDate", "Status Date","Expiration Date"],
								messages: {
								    dateCompareGreaterThanOrEqual2: "Certificate Expiration Date cannot be before Completion Date",
								    dateCompareGreaterThanOrEqual: "Certificate Expiration Date cannot be before Current Status Date"
								}
						    });

						}
			    }

		</script>
		
		<style type="text/css">
		
			#report {
				border-collapse: collapse;
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
			
			#tdFormElement td {
				align: left
			}
			
			#tdnoWrap td {
				white-space: nowrap
			}
			
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

	<div id="show-agency" class="content scaffold-show" role="main">
		<g:if test = "${params.callingPage == 'AGENCY'}">
			<h1 style="color: #48802C">Add License and Certification to Agency : ${agencyInstance?.agencyId }</h1>
			<div class="right-corner" align="center">AGNCL</div>
		</g:if>
		<g:elseif test = "${params.callingPage == 'AGENT'}">
			<h1 style="color: #48802C">Add License and Certification to Agent : ${agentMasterInstance?.agentId }</h1>
			<div class="right-corner" align="center">AGNTL</div>
		</g:elseif>
		
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
		<div id="errorDisplay" style="display: none;" class="errors"
			style="float:left; margin: -5px 10px 0px 0px; "></div>

		<g:form action="saveLicense" id="editForm" name="editForm">
			<input type="hidden" name="editType" value="LICENSE" />
			<input type="hidden" name="rowCount" value="${i}" />
			<input type="hidden" name="createLicenseNumber" value="${createLicenseNumber}"/>
			<g:if test="${params.callingPage == 'AGENCY'}">
				<input type="hidden" name="seqAgencyId" value="${agencyInstance?.seqAgencyId}" />
				<input type="hidden" name="callingPage" value="AGENCY" />
			</g:if>
			<g:elseif test="${params.callingPage == 'AGENT'}">
				<input type="hidden" name="seqAgentId" value="${agentMasterInstance?.seqAgentId}" />
				<input type="hidden" name="callingPage" value="AGENT" />
			</g:elseif>
	
		<table>
			<tr>
				<td>
					<table class="report" border="0" style="table-layout: fixed;" id="report">
						<tr>
							<td class="tdnoWrap">
								<div class="fieldcontain ${hasErrors(bean: agencyInstance, field: 'agencyId', 'error')} ">
									<g:if test="${params.callingPage == 'AGENCY'}">
										<label for="agencyId"> 
											<g:message code="agency.agencyId.label" default="Agency ID :" />
										</label>
										<g:textField name="agencyId" id="agencyId" readonly="true" style="background:#CCC;" 
											 value="${agencyInstance?.agencyId}" />
									</g:if>
									<g:elseif test="${params.callingPage == 'AGENT'}">
										<label for="agentId"> 
											<g:message code="agent.agentId.label" default="Agent/Broker ID :" />
										</label>
										<g:textField name="agentId" id="agentId" readonly="true" style="background:#CCC;" 
											 value="${agentMasterInstance?.agentId}" />
									</g:elseif>
									
								</div>
							</td>
							<td class="tdnoWrap">
								<div class="fieldcontain ${hasErrors(bean: agencyInstance, field: 'agencyName', 'error')} ">
								   <g:if test="${params.callingPage == 'AGENCY'}">
										<label for="agencyName"> 
											<g:message code="agency.agencyName.label" default="Name :" />
										</label>
										<g:textField name="agencyName" id="agencyName" readonly="true" style="background:#CCC;"  
											 value="${agencyInstance?.agencyName}" />
									</g:if>
									<g:elseif test="${params.callingPage == 'AGENT'}">
										<label for="agentName"> 
											<g:message code="agent.agentName.label" default="Name :" />
										</label>
										<g:if test="${agentMasterInstance?.middleInitial}">
											<g:textField name="agentName" id="agentName" readonly="true" style="background:#CCC;"  
												 value="${agentMasterInstance?.firstName} ${' '} ${agentMasterInstance?.middleInitial} ${' '} ${agentMasterInstance?.lastName}" />
										</g:if>
										<g:else>
											<g:textField name="agentName" id="agentName" readonly="true" style="background:#CCC;"  
												 value="${agentMasterInstance?.firstName} ${' '} ${agentMasterInstance?.lastName}" />
										</g:else>
									</g:elseif>
								</div>
							</td>
						</tr>
						<tr>
							<td class="tdnoWrap">
								<div class="fieldcontain ${hasErrors(bean: agencyInstance, field: 'tin', 'error')} ">
								<g:if test="${params.callingPage == 'AGENCY'}">
									<label for="tin"> 
										<g:message code="agency.tin.label" default="Tax ID :" />
									</label>
									<g:textField name="tin" id="tin" readonly="true" style="background:#CCC;" class="maskTaxID" 
										 value="${agencyInstance?.tin}" />
								</g:if>
								<g:elseif test="${params.callingPage == 'AGENT'}">
									<label for="pinTid"> 
										<g:message code="agent.pinTid.label" default="Tax ID :" />
									</label>
									<g:textField name="pinTid" id="pinTid" readonly="true" style="background:#CCC;" class="maskTaxID" 
										 value="${agentMasterInstance?.pinTid}" />
								</g:elseif>
								</div>
							</td>
							<td class="tdnoWrap">
								<div class="fieldcontain ${hasErrors(bean: agencyLicenseHdr, field: 'licenseNumber', 'error')} ">
									<label for="licenseNumber"> 
										<g:message code="agencyLicense.licenseNumber.label" default="License No :" />
											<span class="required-indicator">*</span>
									</label>
									<g:textField name="agencyLicenseHdr.0.licenseNumber" readonly="true" style="background:#CCC;"  
										  value="${createLicenseNumber}" title="The License No." maxlength="11" />
								</div>
							</td>
						</tr>
						<tr>
							<td class="tdnoWrap">
								<div class="fieldcontain ${hasErrors(bean: agencyLicenseHdr, field: 'licenseLoa', 'error')} ">
									<label for="licenseLoa"> 
										<g:message code="agencyLicense.licenseLoa.label" default="LOA :" />
											<span class="required-indicator">*</span>
									</label>
									<g:getSystemCodes
										autofocus = "autofocus"
										systemCodeType="COMMIS_LOA" 
										systemCodeActive = "Y"
										htmlElelmentId="agencyLicenseHdr.0.licenseLoa"
										blankValue="Line Of Authority"
										defaultValue="${agencyLicenseHdr?.licenseLoa}" 
										width="200px"/>
								</div>
							</td>
							<td class="tdnoWrap">
								<div class="fieldcontain ${hasErrors(bean: agencyLicenseHdr, field: 'state', 'error')} ">
									<label for="state"> 
										<g:message code="agencyLicense.state.label" default="State :" /> 
										<span class="required-indicator">*</span>
									</label>
									<g:select name="agencyLicenseHdr.0.state" optionKey="stateCode" optionValue="stateName"
									 id="agencyLicense.0.state" from="${states}" noSelection="['':'-- State in which License is valid --']"
									  value="${agencyLicenseHdr?.state}"></g:select>
								</div>
							</td>
						</tr>
						<tr>
							<td class="tdnoWrap" style="white-space: nowrap">
									<div class="fieldcontain ${hasErrors(bean: agencyLicenseDtl, field: 'effectiveDate', 'error')} ">
										<label for="effectiveDate"> 
											<g:message code="agencyLicense.effectiveDate.label" default="Effective Date :" />
												<span class="required-indicator">*</span>
										</label>
										<g:datePicker name="agencyLicenseDtl.0.effectiveDate" precision="day" noSelection="['':'']" 
											title ="The Effective Date of the License"
											value="${agencyLicenseDtl?.effectiveDate}" default="none" />		
									</div>
							</td>						
							<td class="tdnoWrap" style="white-space: nowrap">
									<div class="fieldcontain ${hasErrors(bean: agencyLicenseDtl, field: 'expirationDate', 'error')} ">
										<label for="termDate"> 
											<g:message code="agencyLicense.expirationDate.label" default="Expiration Date :" />
												<span class="required-indicator">*</span>
										</label>
										<g:datePicker name="agencyLicenseDtl.0.expirationDate" precision="day" noSelection="['':'']" 
											title ="The Expiration Date of the License"
											value="${agencyLicenseDtl?.expirationDate}" default="none" />
									</div>
							</td>
						</tr>
						<tr>
							<td class="tdnoWrap" style="white-space: nowrap">
									<div class="fieldcontain ${hasErrors(bean: agencyLicenseDtl, field: 'status', 'error')} ">
											<label for="status"> 
												<g:message code="agencyLicense.status.label" default="Status :" />
													<span class="required-indicator">*</span>
											</label>
											<g:getSystemCodes
													systemCodeType="LICENSE_STATUS" 
													systemCodeActive = "Y"
													htmlElelmentId="agencyLicenseDtl.0.status"
													blankValue="Status"
													defaultValue="${agencyLicenseDtl?.status}" 
													width="200px"/>	
									</div>
							</td>						
							<td class="tdnoWrap" style="white-space: nowrap">
									<div class="fieldcontain ${hasErrors(bean: agencyLicenseDtl, field: 'currentStatusDate', 'error')} ">
										<label for="currentStatusDate"> 
											<g:message code="agencyLicense.currentStatusDate.label" default="Current Status Date :" />
												<span class="required-indicator" id="reqdCurrentStatusDate">*</span>
										</label>
											<g:datePicker name="agencyLicenseDtl.0.currentStatusDate" precision="day" noSelection="['':'']" 
												title ="The date the License acquired the Status i.e. the Date the License status changed."
												value="${agencyLicenseDtl?.currentStatusDate}" default="none" />
									</div>
							</td>		
						</tr>
					</table>
					<table>
						<tr><td class="tdnoWrap" colspan="2">Certifications<hr></td></tr>
						<tr><td><input type="button" class="load" id="btnAddRow" name="btnAddRow" value="Add Row"/></td></tr>
					</table>
					
					<table>
						<tr>
							<td>
								<table id="tblCertificate" class="tblCertificate" border="1" style="font-size:15px;">
									<tr>
										<th>&nbsp;&nbsp;Course</th>
										<th>Description</th>
										<th>Completion Date <span id="reqdCompletionDate" class="required-indicator">*</span></th>
										<th>Expiration Date</th>
										<th></th>
									</tr>
									<tr id="newRow_1" class="toggleDisplay">
										<td>
											<input type="hidden" id="agencyLicenseCertificate.1.iterationCount" name="agencyLicenseCertificate.1.iterationCount" value="1">
											<g:textField class="courseGroup" name="agencyLicenseCertificate.1.course" maxlength="20" value="${agencyLicenseCertificate?.course}"
											title ="The Name of the Course that was taken to achieve the license" 
											 />
										</td>
										<td>
											<g:textField class="descriptionGroup" name="agencyLicenseCertificate.1.description" maxlength="60" value="${agencyLicenseCertificate?.description}" 
											title = "The description of the Course that was taken to achieve the license"
											/>
										</td>
										<td>
											<g:datePicker name="agencyLicenseCertificate.1.completionDate" precision="day" noSelection="['':'']" 
														title ="The date the Agent/Broker achieved the certification" 
														value="${agencyLicenseCertificate?.completionDate}" default="none" />
										</td>
										<td>
											<g:datePicker name="agencyLicenseCertificate.1.expirationDate" precision="day" noSelection="['':'']" 
														title ="The date the certification expires"  
														value="${agencyLicenseCertificate?.expirationDate}" default="none" />
										</td>
										<td style="float:none;vertical-align:top"><input  type="button" class="deleteThisRow load" id="agencyLicenseCertificate.1.delete" name= "agencyLicenseCertificate.1.delete" value="Delete"/></td>
									</tr>
								</table>
							</td>
						</tr>
					</table>
				</td>
			</tr>
		</table>
			<fieldset class="buttons">
				<g:actionSubmit class="save" action="saveLicense" value="${message(code: 'default.button.create.label', default: 'Create')}" />
				<input type="Reset" class="reset" value="Reset" onClick="resetForm()" />
				<input type="button" class="close" value="Close" onClick="closeForm()"/>
			</fieldset>
		</g:form>
	</div>
	<div style="display: none">
		<input type="button" onClick="closeAllIFrames()" id="closeIframes">
	</div>
</body>
</html>
