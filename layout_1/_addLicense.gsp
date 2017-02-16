<!DOCTYPE html>
<html>
	<head>
		<%@ page import="com.dell.diamond.fms.enums.PageNameEnum" %>
		<g:set var="isShowCalendarIcon" value="${PageNameEnum.AGENCY_ADDLIC.equals(currentPage)?true:false}" />
		<meta name="layout" content="main">
		<g:set var="entityName" value="${message(code: 'agentMaster.label', default: 'AgentMaster')}" />
		<g:set var="appContext" bean="grailsApplication"/>
		<title><g:message code="default.edit.label" args="[entityName]" /></title>
		
		<script type="text/javascript" src="${resource(dir: 'js', file: 'jquery.validate.js')}"></script>
		<script type="text/javascript" src="${resource(dir: 'js', file: 'additional-methods.js')}"></script>	
		<script type="text/javascript" src="${resource(dir: 'js', file: 'jquery.maskedinput.js')}"></script>
		<script type="text/javascript" src="${resource(dir: 'js', file: 'jquery.alphanum.js')}"></script>
		
		<script type="text/javascript">

		function onPageLoad(){
			
			if($("#agencyLicense\\.agencyLicenceDtls\\.0\\.status").val() == 'AC') {
				//If status is Active(AC) then Current Status date is not required and needs to be disabled 
				
				STATUSDATE = false;
				$('input[id="agencyLicense.agencyLicenceDtls.0.currentStatusDate"]').attr('disabled', 'disabled');
				$('button[id="_calendar_button_agencyLicense.agencyLicenceDtls.0.currentStatusDate"]').hide();
				$('#reqdCurrentStatusDate').hide()
			}
			else {
				
				STATUSDATE = true;
				$('input[id="agencyLicense.agencyLicenceDtls.0.currentStatusDate"]').removeAttr('disabled', 'disabled');
				$('#reqdCurrentStatusDate').show();
				//$('.ui-datepicker-trigger').show()
				$('button[id="_calendar_button_agencyLicense.agencyLicenceDtls.0.currentStatusDate"]').show();
			}
		}
		
		window.onload = onPageLoad;

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

			$('#agencyLicenseDtl\\.0\\.status').change( function() {
				if($("#agencyLicenseDtl\\.0\\.status").val() == 'AC') {
					//If status is Active(AC) then Current Status date is not required and needs to be disabled 
					$('input[id="agencyLicenseDtl.0.currentStatusDate"]').attr('disabled', 'disabled');
					$('button[id="_calendar_button_agencyLicenseDtl.0.currentStatusDate"]').hide();
					$('#reqdCurrentStatusDate').hide()
				} else {
						$('input[id="agencyLicenseDtl.0.currentStatusDate"]').removeAttr('disabled', 'disabled');
						$('button[id="_calendar_button_agencyLicenseDtl.0.currentStatusDate"]').show();
						$('#reqdCurrentStatusDate').show();
				}	
					
				});	


			$(".maskTaxID").mask("?99-9999999");

			//When page loads do not show current status date to be required
			$('#reqdCurrentStatusDate').hide()
			
			//When page loads do not show certificate completion date to be required
			$('#reqdCompletionDate').hide()
			
			//Allow tabbing but prevent postback to previous page if user presses backspace since these fields are readonly
			$('#agencyId, #agentId, #agencyName, #agentName, #tin, #pinTid, #agencyLicenseHdr\\.0\\.licenseNumber').on('keydown', function(e) {
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
			 $('.deleteThisRow').on('click',function(){

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
							'agencyLicenseDtl.0.effectiveDate' : {
								required : true
							},
							'agencyLicenseDtl.0.expirationDate' : {
								required : true,
								dateCompareGreaterThan:["#agencyLicenseDtl\\.0\\.effectiveDate","#agencyLicenseDtl\\.0\\.expirationDate","Effective Date","Expiration Date"]
							},
						  	'agencyLicenseDtl.0.status' : {
								required : true
							},
							'agencyLicenseDtl.0.currentStatusDate' : {
								required : {
									depends: function(){	
										return 	($('#agencyLicenseDtl\\.0\\.status').val() != 'AC'	&&  $('#agencyLicenseDtl\\.0\\.status').val() != '')												
									}
								}
							},
							'agencyLicenseCertificate.1.course' : {
								required : {
									depends: function(){
										return ($.trim($("#agencyLicenseCertificate\\.1\\.completionDate").val()).length > 0  ) &&
										$.trim($("#agencyLicenseCertificate\\.1\\.description").val()) == 0;		
									}
								}
							},
							'agencyLicenseCertificate.1.description' : {
								required : {
									depends: function(){												
											return ($.trim($("#agencyLicenseCertificate\\.1\\.completionDate").val()).length > 0 ) &&
											$.trim($("#agencyLicenseCertificate\\.1\\.course").val()) == 0;			
									}
								}
							},
							'agencyLicenseCertificate.1.completionDate' : {
								noFutureDates: ["#agencyLicenseCertificate\\.1\\.completionDate"],
								required : function(element){														
									return $.trim($("#agencyLicenseCertificate\\.1\\.course").val()).length > 0 ||
									$.trim($("#agencyLicenseCertificate\\.1\\.description").val()).length > 0;						
								}
							},
							'agencyLicenseCertificate.1.expirationDate' : {
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
							'agencyLicenseDtl.0.effectiveDate' : {
								required : "Please enter the Effective Date"
							},
							'agencyLicenseDtl.0.expirationDate' : {
								required : "Please enter the Expiration Year",
								dateCompareGreaterThan: "Expiration Date must be after the Effective Date"
							},
						  	'agencyLicenseDtl.0.status' : {
								required : "Please select a Status"
							},
							'agencyLicenseDtl.0.currentStatusDate' : {
								required : "Current Status Date is required for the current License Status. Please enter the Status Date"
							},
							'agencyLicenseCertificate.1.course' : {
								required : "Either the Course ID or Description must be entered. Both cannot be blank"
							},
							'agencyLicenseCertificate.1.description' : {
								required :  "Either the Course ID or Description must be entered. Both cannot be blank"	
							},
							'agencyLicenseCertificate.1.completionDate' : {
								noFutureDates: "Completion Date cannot be in the future",
								required : "Completion Date is required if Certification Course or Description is entered. Please enter Completion Date"
							},
							'agencyLicenseCertificate.1.expirationDate' : {
								dateCompareGreaterThanOrEqual2: "Certificate Expiration Date cannot be before Completion Date",
								dateCompareGreaterThanOrEqual: "Certificate Expiration Date cannot be before Current Status Date"
							}
					} 
				 
			})
		});
	}); 
				
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
						    $("#agencyLicenseCertificate\\." + id + "\\.completionDate").rules("add", { 
						    	required : function(element){														
									return $.trim($("#agencyLicenseCertificate\\." + id + "\\.course").val()).length > 0 ||
									$.trim($("#agencyLicenseCertificate\\." + id + "\\.description").val()).length > 0;						
								},
								messages: {
								    required : "Completion Date is required if Certification Course or Description is entered. Please enter Completion Date"
								}
						    });
						    
						     $("#agencyLicenseCertificate\\." + id + "\\.course").rules("add", { 
						     	required : {
									depends: function(){
										return ($.trim($("#agencyLicenseCertificate\\." + id + "\\.completionDate").val()).length > 0 ) &&
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
										return ($.trim($("#agencyLicenseCertificate\\." + id + "\\.completionDate").val()).length > 0 ) &&
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
						    
						    $("#agencyLicenseCertificate\\." + id + "\\.completionDate").rules("add", { 
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
		
		

		</head>
		
		
		
		
		<!-- START - FMS Content -->
	<div id="fms_content">
		<div id="fms_content_header">
		  <div class="fms_content_header_note">
		  <g:if test = "${params.callingPage == 'AGENCY'}">
			<a href="${createLink(uri: '/agency/list')}">Agency</a> / Add License and Certification to Agency : ${agencyInstance?.agencyId }</h1>
		  </g:if>
		  <g:elseif test = "${params.callingPage == 'AGENT'}">
			<a href="${createLink(uri: '/agentMaster/list')}">Agent</a> / Add License and Certification to Agent : ${agentMasterInstance?.agentId }</h1>
		  </g:elseif>
		  </div>
		  <div class="fms_content_title">
		    <h1>Add License and Certification to Agent</h1>
		  </div>
		</div> 
		<%-- START - Tabs --%>
		<div id="fms_content_tabs">
			<ul>
				<li><g:link class="list" action="edit" params="${[seqAgencyId: agencyInstance?.seqAgencyId, agencyId: agencyInstance?.agencyId, agencyType: agentMasterInstance?.agentType, editType :'MASTER', creationDate:params.creationDate]}">Master Record</g:link></li>
				<li><g:link class="list" action="edit" params="${[seqAgencyId: agencyInstance?.seqAgencyId, agencyId: agencyInstance?.agencyId, agencyType: agentMasterInstance?.agentType, editType :'ADDRESS', creationDate:params.creationDate]}">Addresses</g:link></li>
				<li><g:link class="list" action="edit" params="${[seqAgencyId: agencyInstance?.seqAgencyId, agencyId: agencyInstance?.agencyId, agencyType: agentMasterInstance?.agentType, editType :'CONTACT', creationDate:params.creationDate]}">Contacts</g:link></li>
				<li><g:link class="list" action="edit" params="${[seqAgencyId: agencyInstance?.seqAgencyId, agencyId: agencyInstance?.agencyId, agencyType: agentMasterInstance?.agentType, editType :'CONTRACTS', creationDate:params.creationDate]}">Contracts</g:link></li>
			    <li><g:link class="list" action="edit" params="${[seqAgencyId: agencyInstance?.seqAgencyId, agencyId: agencyInstance?.agencyId, agencyType: agentMasterInstance?.agentType, editType :'BANKING', creationDate:params.creationDate]}">Banking</g:link></li>
			    <li><g:link class="active" action="edit" params="${[seqAgencyId: agencyInstance?.seqAgencyId, agencyId: agencyInstance?.agencyId, agencyType: agentMasterInstance?.agentType, editType :'LICENSE', , callingPage: 'AGENCY']}">License and Certification</g:link></li>
			</ul>
			<div id="mobile_tabs_select"></div>
		</div>
		<%-- END - Tabs --%>
	
		<!-- START - FMS Content Body -->
		<div id="fms_content_body">
		<g:if test = "${params.callingPage == 'AGENCY'}">
			<div class="right-corner" align="right">AGNCL</div>
		</g:if>
		<g:elseif test = "${params.callingPage == 'AGENT'}">
			<div class="right-corner" align="right">AGNTL</div>
		</g:elseif>
	
					<%-- Error messages start--%>
					<g:if test="${flash.message}">
						<div class="message" role="status">
							${flash.message}
						</div>
					</g:if>
					<g:if test="${fieldErrors}">
						<ul class="errors" role="alert">
							<g:each in="${fieldErrors}" var="error">
								<li>${error}</li>
							</g:each>
						</ul>
					</g:if>
					<ul id="errorDisplay" style="display: none;" class="errors" role="alert" style="float:left; margin: -5px 10px 0px 0px; "></ul>
					<%-- Error messages end--%>
					
					<div id="show-agency" class="content scaffold-show" role="main">
					&nbsp;
					
					<div class="fms_required_legend fms_required">= required</div> 

					<g:form action="saveLicense" id="editForm" name="editForm">
						<input type="hidden" name="editType" value="LICENSE" />
						<input type="hidden" name="rowCount" value="${i}" />
						<input type="hidden" name="createLicenseNumber"
							value="${createLicenseNumber}" />
						<g:if test="${params.callingPage == 'AGENCY'}">
							<input type="hidden" name="seqAgencyId"
								value="${agencyInstance?.seqAgencyId}" />
							<input type="hidden" name="callingPage" value="AGENCY" />
						</g:if>
						<g:elseif test="${params.callingPage == 'AGENT'}">
							<input type="hidden" name="seqAgentId"
								value="${agentMasterInstance?.seqAgentId}" />
							<input type="hidden" name="callingPage" value="AGENT" />
						</g:elseif>


						<!-- START - WIDGET: General Information -->
						<div id="AddNewDataSection" class="fms_form_border">
							<div class="fms_widget_border fms_widget_bgnd-color">
								<fieldset class="no_border">
									<legend>
										<h2>General Information</h2>
									</legend>
									<div class="fms_form_layout_2column">
										<div class="fms_form_column fms_very_long_labels">

											<g:if test="${params.callingPage == 'AGENCY'}">
												<label class="control-label fms_required"
													id="agencyId_label" for="agencyId"> <g:message
														code="agency.agencyId.label" default="Agency ID :" />
												</label>
												<div class="fms_form_input">
													<g:textField class="form-control" name="agencyId"
														id="agencyId" readonly="true"
														value="${agencyInstance?.agencyId}" />
													<div class="fms_form_error" id="agencyId_error"></div>
												</div>
											</g:if>
											<g:elseif test="${params.callingPage == 'AGENT'}">
												<label class="control-label" id="agentId_label"
													for="agentId"> <g:message
														code="agent.agentId.label" default="Agent/Broker ID :" />
												</label>
												<div class="fms_form_input">
													<g:textField class="form-control" name="agentId"
														id="agentId" readonly="true"
														value="${agentMasterInstance?.agentId}" />
													<div class="fms_form_error" id="agentId_error"></div>
												</div>
											</g:elseif>

											<g:if test="${params.callingPage == 'AGENCY'}">
												<label class="control-label" id="tin_label"
													for="tin"> <g:message code="agency.tin.label"
														default="Tax ID :" />
												</label>
												<div class="fms_form_input">
													<g:textField class="form-control" name="tin"
														id="tin" readonly="true" value="${agencyInstance?.tin}" />
													<div class="fms_form_error" id="tin_error"></div>
												</div>
											</g:if>
											<g:elseif test="${params.callingPage == 'AGENT'}">
												<label class="control-label" id="pinTid_label" for="pinTid">
													<g:message code="agent.pinTid.label" default="Tax ID :" />
												</label>
												<div class="fms_form_input">
													<g:textField class="form-control" name="pinTid" id="pinTid"
														readonly="true" value="${agentMasterInstance?.pinTid}" />
													<div class="fms_form_error" id="tin_error"></div>
												</div>
											</g:elseif>

											<label class="control-label fms_required"
												id="licenseLoa_label" for="licenseLoa"> <g:message
													code="agencyLicense.licenseLoa.label" default="LOA :" />
											</label>
											<div class="fms_form_input">
												<g:getSystemCodes cssClass="form-control"
													autofocus="autofocus" systemCodeType="COMMIS_LOA"
													systemCodeActive="Y"
													htmlElelmentId="agencyLicenseHdr.0.licenseLoa"
													blankValue="Line Of Authority"
													defaultValue="${agencyLicenseHdr?.licenseLoa}"/>
												<div class="fms_form_error" id="licenseLoa_error"></div>
											</div>

											<label class="control-label fms_required"
												id="effectiveDate_label" for="effectiveDate"> <g:message
													code="agencyLicense.effectiveDate.label"
													default="Effective Date :" />
											</label>
											<div class="fms_form_input">

												<fmsui:jqDatePickerUIUX 
													attributeName="effectiveDate"
													dateElementId="agencyLicenseDtl.0.effectiveDate"
													title="The Expiration Date of the License"
													dateElementName="agencyLicenseDtl.0.effectiveDate"
													datePickerOptions="changeMonth: true, changeYear: true, yearRange: '${((agencyLicenseDtl?.effectiveDate != null ? agencyLicenseDtl?.effectiveDate.get(Calendar.YEAR):Calendar.getInstance().get(Calendar.YEAR)) - 100)} : ${((agencyLicenseDtl?.effectiveDate != null ? agencyLicenseDtl?.effectiveDate.get(Calendar.YEAR):Calendar.getInstance().get(Calendar.YEAR)) + 100)}', numberOfMonths: 1"
													dateElementValue="${formatDate(format:'MM/dd/yyyy',date: agencyLicenseDtl?.effectiveDate)}"
													ariaAttributes="aria-labelledby='effectiveDate_label' aria-describedby='effectiveDate_error' aria-required='false'"
													classAttributes="class='form-control fms_date_mask fms_small_input onDelete hasDatepicker' "
													showIconDefault="${isShowCalendarIcon}" />

												<div class="fms_form_error" id="effectiveDate_error"></div>
											</div>

											<label class="control-label fms_required" id="status_label"
												for="status"> <g:message
													code="agencyLicense.status.label" default="Status :" />
											</label>
											<div class="fms_form_input">
												<g:getSystemCodes cssClass="form-control"
													systemCodeType="LICENSE_STATUS" systemCodeActive="Y"
													htmlElelmentId="agencyLicenseDtl.0.status"
													blankValue="Status"
													defaultValue="${agencyLicenseDtl?.status}" />
												<div class="fms_form_error" id="status_error"></div>
											</div>
										</div>

										<div class="fms_form_column fms_very_long_labels">

											<g:if test="${params.callingPage == 'AGENCY'}">
												<label class="control-label fms_required"
													id="agencyName_label" for="agencyName"> <g:message
														code="agency.agencyName.label" default="Name :" />
												</label>
												<div class="fms_form_input">
													<g:textField class="form-control" name="agencyName"
														id="agencyName" readonly="true"
														value="${agencyInstance?.agencyName}" />
													<div class="fms_form_error" id="status_error"></div>
												</div>
											</g:if>
											<g:elseif test="${params.callingPage == 'AGENT'}">
												<label class="control-label fms_required"
													id="agentName_label" for="agentName"> <g:message
														code="agent.agentName.label" default="Name :" />
												</label>
												<div class="fms_form_input">
													<g:if test="${agentMasterInstance?.middleInitial}">
														<g:textField class="form-control" name="agentName"
															id="agentName" readonly="true"
															value="${agentMasterInstance?.firstName} ${' '} ${agentMasterInstance?.middleInitial} ${' '} ${agentMasterInstance?.lastName}" />
														<div class="fms_form_error" id="agentName_error"></div>
													</g:if>
													<g:else>
														<g:textField class="form-control" name="agentName"
															id="agentName" readonly="true"
															value="${agentMasterInstance?.firstName} ${' '} ${agentMasterInstance?.lastName}" />
														<div class="fms_form_error" id="agentName_error"></div>
													</g:else>
												</div>
											</g:elseif>

											<label class="control-label fms_required"
												id="licenseNumber_label" for="licenseNumber"> <g:message
													code="agencyLicense.licenseNumber.label"
													default="License No :" />
											</label>
											<div class="fms_form_input">
												<g:textField class="form-control"
													name="agencyLicenseHdr.0.licenseNumber" readonly="true"
													value="${createLicenseNumber}" title="The License No."
													maxlength="11" />
												<div class="fms_form_error" id="licenseNumber_error"></div>
											</div>

											<label class="control-label fms_required"
												id="licenseNumber_label" for="state"> <g:message
													code="agencyLicense.state.label" default="State :" />
											</label>
											<div class="fms_form_input">
												<g:select class="form-control"
													name="agencyLicenseHdr.0.state" optionKey="stateCode"
													optionValue="stateName" id="agencyLicense.0.state"
													from="${states}"
													noSelection="['':'-- State in which License is valid --']"
													value="${agencyLicenseHdr?.state}"></g:select>
												<div class="fms_form_error" id="state_error"></div>
											</div>

											<label class="control-label fms_required"
												id="expirationDate_label" for="expirationDate"> <g:message
													code="agencyLicense.expirationDate.label"
													default="Expiration Date :" />
											</label>
											<div class="fms_form_input">
												<fmsui:jqDatePickerUIUX 
													attributeName="expirationDate"
													dateElementId="agencyLicenseDtl.0.expirationDate"
													title="The Expiration Date of the License"
													dateElementName="agencyLicenseDtl.0.expirationDate"
													datePickerOptions="changeMonth: true, changeYear: true, yearRange: '${((agencyLicenseDtl?.expirationDate != null ? agencyLicenseDtl?.expirationDate.get(Calendar.YEAR):Calendar.getInstance().get(Calendar.YEAR)) - 100)} : ${((agencyLicenseDtl?.expirationDate != null ? agencyLicenseDtl?.expirationDate.get(Calendar.YEAR):Calendar.getInstance().get(Calendar.YEAR)) + 100)}', numberOfMonths: 1"
													dateElementValue="${formatDate(format:'MM/dd/yyyy',date: agencyLicenseDtl?.expirationDate)}"
													ariaAttributes="aria-labelledby='expirationDate_label' aria-describedby='expirationDate_error' aria-required='false'"
													classAttributes="class='form-control fms_date_mask fms_small_input onDelete hasDatepicker' "
													showIconDefault="${isShowCalendarIcon}" />

												<div class="fms_form_error" id="expirationDate_error"></div>
											</div>

											<label class="control-label" id="currentStatusDate_label" for="currentStatusDate">
												<span class="fms_required" id="reqdCurrentStatusDate"></span>
												<g:message code="agencyLicense.currentStatusDate.label" default="Current Status Date :" />
											</label>
											<div class="fms_form_input">
												<fmsui:jqDatePickerUIUX 
													attributeName="currentStatusDate"
													dateElementId="agencyLicenseDtl.0.currentStatusDate"
													title ="The date the License acquired the Status i.e. the Date the License status changed."
													dateElementName="agencyLicenseDtl.0.currentStatusDate"
													datePickerOptions="changeMonth: true, changeYear: true, yearRange: '${((agenagencyLicenseDtl?.currentStatusDate != null ? agencyLicenseDtl?.currentStatusDate.get(Calendar.YEAR):Calendar.getInstance().get(Calendar.YEAR)) - 100)} : ${((agencyLicenseDtl?.currentStatusDate != null ? agencyLicenseDtl?.currentStatusDate.get(Calendar.YEAR):Calendar.getInstance().get(Calendar.YEAR)) + 100)}', numberOfMonths: 1"
													dateElementValue="${formatDate(format:'MM/dd/yyyy',date: agencyLicenseDtl?.currentStatusDate)}"
													ariaAttributes="aria-labelledby='currentStatusDate_label' aria-describedby='currentStatusDate_error' aria-required='false'"
													classAttributes="class='form-control fms_date_mask fms_small_input onDelete hasDatepicker' "
													showIconDefault="${isShowCalendarIcon}" />

												<div class="fms_form_error" id="currentStatusDate_error"></div>
											</div>

										</div>
									</div>
								</fieldset>

								<div id="AddNewDataSection1" class="fms_widget">
								<fieldset class="no_border">
										<legend>
											<h3>Certifications</h3>
										</legend>

										<input type="button" class="btnAddRow btn btn-primary btn-sm" id="btnAddRow" name="btnAddRow" value="Add Row" />
										<br></br>
											<table id="tblCertificate" class="tblCertificate tablesorter tablesorter-fms tablesorterdf6319efcolumnselector">
												<tr>
													<th
														class="{sorter: false} tablesorter-header sorter-false"
														data-column="0" data-columnselector="disable"
														aria-disabled="true">Course</th>
													<th
														class="{sorter: false} tablesorter-header sorter-false"
														data-column="1" data-columnselector="disable"
														aria-disabled="true">Description</th>
													<th
														class="{sorter: false} tablesorter-header sorter-false "
														data-column="2" data-columnselector="disable"
														aria-disabled="true">Completion Date<span id="reqdCompletionDate" class="required-indicator">*</span> </th>
													<th
														class="{sorter: false} tablesorter-header sorter-false "
														data-column="3" data-columnselector="disable"
														aria-disabled="true">Expiration Date</th>
													<th class="{sorter: false} tablesorter-header sorter-false" data-column="4" data-columnselector="disable" aria-disabled="true">Actions</th>
												</tr>
												<tr id="newRow_1" class="toggleDisplay">
													<td><input type="hidden"
														id="agencyLicenseCertificate.1.iterationCount"
														name="agencyLicenseCertificate.1.iterationCount"
														value="1"> <g:textField class="form-control courseGroup"
															name="agencyLicenseCertificate.1.course" maxlength="20"
															value="${agencyLicenseCertificate?.course}"
															title="The Name of the Course that was taken to achieve the license" />
													</td>
													<td><g:textField class="form-control descriptionGroup"
															name="agencyLicenseCertificate.1.description"
															maxlength="60"
															value="${agencyLicenseCertificate?.description}"
															title="The description of the Course that was taken to achieve the license" />
													</td>
													<td>
													<fmsui:jqDatePickerUIUX
															dateElementName="agencyLicenseCertificate.1.completionDate"
															datePickerOptions="changeMonth:true, changeYear:true, yearRange:'-100:+100', numberOfMonths: 1"
															dateElementId="agencyLicenseCertificate.1.completionDate"
															dateElementValue="${formatDate(format:'MM/dd/yyyy',date: agencyLicenseCertificate?.completionDate)}"
															ariaAttributes="aria-labelledby='completionDate_label' aria-describedby='completionDate_error' aria-required='false'"
															classAttributes="class='form-control fms_date_mask fms_small_input onDelete hasDatepicker' "
															showIconDefault="${isShowCalendarIcon}"/>
													</td>
													<td>
													
													<fmsui:jqDatePickerUIUX
															dateElementName="agencyLicenseCertificate.1.expirationDate"
															datePickerOptions="changeMonth:true, changeYear:true, yearRange:'-100:+100', numberOfMonths: 1"
															dateElementId="agencyLicenseCertificate.1.expirationDate"
															dateElementValue="${formatDate(format:'MM/dd/yyyy',date: agencyLicenseCertificate?.completionDate)}"
															ariaAttributes="aria-labelledby='expirationDate_label' aria-describedby='expirationDate_error' aria-required='false'"
															classAttributes="class='form-control fms_date_mask fms_small_input onDelete hasDatepicker' "
															showIconDefault="${isShowCalendarIcon}"/>
													</td>
													<td style="float: none; vertical-align: top">
													<button  type="button" class="btn fms_btn_icon btn-sm BtnDeleteRow deleteThisRow load" id="agencyLicenseCertificate.1.delete" name= "agencyLicenseCertificate.1.delete"><i class="fa fa-trash"></i></button>
													<!-- <button  type="button" class="btn fms_btn_icon btn-sm BtnDeleteRow" id="agencyLicenseCertificate.1.delete" name= "agencyLicenseCertificate.1.delete"><i class="fa fa-trash"></i></button>-->
												</tr>
											</table>
									</fieldset>
								</div>
								<div class="fms_form_button">
									<g:actionSubmit class="btn btn-primary create" action="saveLicense" value="${message(code: 'default.button.create.label', default: 'Create')}" />
									<input type="Reset" class="btn btn-default" value="Reset" /> 
									<input type="button" class="btn btn-default" value="Cancel" name="Close" onClick="closeForm()" />
								</div>
							</div>
						</div>
					</g:form></div></div></div>
								      			
<html>		
