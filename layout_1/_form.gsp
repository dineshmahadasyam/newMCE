<%@ page import="com.perotsystems.diamond.bom.fms.Agency"%>
<g:set var="appContext" bean="grailsApplication"/>	
<link rel="stylesheet" 	href="${resource(dir: 'css', file: 'jquery.window.css')}" type="text/css">
<script type="text/javascript" src="${resource(dir: 'js', file: 'jquery.validate.js')}"></script>
<script type="text/javascript" src="${resource(dir: 'js', file: 'additional-methods.js')}"></script>	
<script type="text/javascript" src="${resource(dir: 'js', file: 'jquery.dirtyform.js')}"></script>
<script type="text/javascript" src="${resource(dir: 'js', file: 'jquery.maskedinput.js')}"></script>
<script type="text/javascript" src="${resource(dir: 'js', file: 'jquery.alphanum.js')}"></script>

<script type="text/javascript">

$(function($){
	   
	   $("#idagencyId").alphanum({
			allow 		: '-',
			allowSpace  : false
		});

	   $("#idAgencyName").alphanum({
			allow 		: '-&',
			required	: true,
			allowSpace  : true
		});
		
	   $("#idtin").mask("?99-9999999");
	});



jQuery.validator.setDefaults({
	  ignore: ":hidden",
	  debug: true,
	});
	

$(document).ready(function(){

	jQuery.validator.addMethod("taxIdDigits", function(value, element) {
		return this.optional(element) || /\d{2}-\d{7}$/.test(value) || /\d{9}$/.test(value)
	}, "Tax ID must be 9 digits");


	
	$(function() {	
	$( "#agencyForm" ).validate({
		onfocusout: false,
		submitHandler: function (form) {
			  if ($(form).valid()) 
	              form.submit(); 
	          return false; // prevent normal form posting
	    },
	  	
	    	invalidHandler: function(form, validator) {
	        var errors = validator.numberOfInvalids();
	        if (errors) {      
	        	$(".message").hide();              
	            validator.errorList[0].element.focus();
	        }
	    },
	    
		errorLabelContainer: "#errorDisplay", 
		 wrapper: "li",	

		rules : {
			 	'agencyName' : {
					required : true
			 	},
	 			'tin' : {
	 				required : true,
	 				taxIdDigits : true
		 		}
		},
	    messages : {
		 	'agencyName' : {
				required : "Please enter Agency Name"
		 	},
		 	'tin' : {
		 		required : "Please enter Tax ID",
		 		taxIdDigits : "Tax ID must be 9 digits"
		 	}
		}
	})
	});

	});

</script>

<script type="text/javascript">
$(document).ready(function() { 

		  var serializedForm = $('#editForm').serialize();
	
          $( "#BtnGeneralEdit" ).click(function(e) {
            $('#BtnGeneralEdit').hide();
            $('.ui-datepicker-trigger').show();
            $('#BtnGeneralSave, #BtnGeneralReset, #BtnGeneralDelete').show();
            $('#widgetUserDefined  input, #widgetUserDefined  select, #widgetUserDefined .fms_btn_icon').removeAttr('disabled');
            $('#idAgencyName, #idtin').removeAttr('disabled');
            
          });

          
			$('.btnInfoAlert').hide();
			$('.btnInfoAlert').click(function(e) {
				$('#InfoAlert').modal('show');
			});
			$('#InfoAlert').modal({
				backdrop : 'static',
				show : false
			});            

			$('#fms_content_body').removeAttr('style');
			var pageId = ${currentPage?.pageName? '"'+currentPage?.pageName+'"':'""' }	


			if (pageId == 'create') {

					$('#BtnGeneralEdit, #BtnGeneralDelete').hide();
					$('button[id^="_calendar_button"]').show();
			}else {
		          // Make all the inputs disabled
		          $('#widgetGeneral  input, #widgetGeneral select, #widgetGeneral .fms_btn_icon').attr('disabled', 'disabled');
		          $('#widgetUserDefined  input, #widgetUserDefined  select, #widgetGeneral .fms_btn_icon').attr('disabled', 'disabled');
		          
		          // Hide the "Save and Reset" buttons by the form titles
		          $('#BtnGeneralSave, #BtnGeneralReset, #BtnGeneralDelete').hide();
		          $('.ui-datepicker-trigger').hide();
			}


			$( ".btnResetddress" ).click(function() { 
				if (pageId != 'create'){
					$('#BtnGeneralEdit').show();
					$('#BtnGeneralSave').hide();
					$('#BtnGeneralReset').hide();
					$('#BtnGeneralDelete').hide();
					$('#widgetGeneral  input, #widgetGeneral select, #widgetGeneral .fms_btn_icon').attr('disabled', 'disabled');
			        $('#widgetUserDefined  input, #widgetUserDefined  select, #widgetGeneral .fms_btn_icon').attr('disabled', 'disabled');
			        $('.ui-datepicker-trigger').hide();
				} else {
					 var formFields = decodeURIComponent(serializedForm).split('&'); //split up the serialized form into variable pairs

					    //put it into an associative array
					    var splitFields = new Array();
					    for(i in formFields){
					        vals= formFields[i].split('=');
					        splitFields[vals[0]] = vals[1];
					    }
					    $('#editForm').find('input[type=hidden]').each(function(){   // reset the value of hidden field. 
					        this.value = splitFields[this.name];

					}
			 });					
			
       });

   </script>
   
  	 <script type="text/javascript">
	
			$(document).ready(function() {
	
			      $('.BtnDeleteRow').click(function(e){
		              $('#DeleteAlertModal').modal('show');
		          });
			      $('#DeleteAlertModal').modal( {
				      backdrop: 'static',
				       show: false 
				  });
			      $("#BtnDeleteRowYes").click(function(e){	  		         
			               var appName = "${appContext.metadata['app.name']}";
			               var myFm = document.getElementById("agencyForm") ; 			
			               myFm.action = "/"+appName+"/agency/delete";     	
			               myFm.submit();
			           
			  		});
			});
		
		</script>
   
	
	
<input type="hidden" name="editType" value="MASTER" />
<input type="hidden" name="seqAgencyId" value="${agencyInstance?.seqAgencyId }" />
<input type="hidden" name="agencyId" value="${agencyInstance?.agencyId}" />

<!-- START - FMS Content Body -->
<div id="fms_content_body">
	
<%-- Error messages start--%>
<g:if test="${flash.message}">
	<div class="message" role="status">${flash.message}</div>
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
				
<div class="fms_required_legend fms_required">= required</div>
	<!-- START - WIDGET: General Information -->
	<div id="widgetGeneral" class="fms_widget">
		<fieldset>
			<legend>
				<h2>General Information</h2>
				<button type="button" id="BtnGeneralEdit" class="btn btn-default btn-xs"><span class="glyphicon glyphicon-pencil"></span> Edit</button>
				<button id="BtnGeneralSave"	class="btn btn-primary btn-xs"><span class="fa fa-floppy-o"></span> Save</button>
				
				
				<button type="button" id="BtnGeneralDelete" class="btn btn-default btn-xs BtnDeleteRow" data-target="#DeleteAlertModal"><span class="fa fa-trash"></span> Delete</button>
				<button type="button" id="BtnGeneralReset" class="btn btn-default btn-xs btnResetddress" onclick="this.form.reset();"><span class="glyphicon glyphicon-repeat"></span> Reset</button>
			</legend>

			<div class="fms_form_layout_2column">
				<div class="fms_form_column fms_very_long_labels">


					<label class="control-label fms_required" id="agencyId_label" for="agencyId"> 
						<g:message code="agency.agencyId.label" default="Agency ID" />:
					</label>
					<div class="fms_form_input">
						<g:secureTextField name="agencyId"
							value="${agencyInstance?.agencyId}" disabled="disabled"
							maxlength="50" tableName="AGENCY" attributeName="agencyId" id="idagencyId" 
							title="The unique Agency ID of the Agency" class="form-control">
						</g:secureTextField>
						<div class="fms_form_error" id="agencyId_error"></div>
					</div>


					<label class="control-label fms_required" id="agencyType_label" for="agencyType"> 
						<g:message code="agency.agencyType.label" default="Agency Type" />:
					</label>
					<div class="fms_form_input">
						<g:secureTextField name="agencyType" tableName="AGENCY"
							attributeName="agencyType" value="${agencyInstance?.agencyType}"
							readonly="true" class="form-control"
							aria-labelledby="agencyType_label" aria-describedby="agencyType_error"
							aria-required="false">
						</g:secureTextField>
					<div class="fms_form_error" id="agencyType_error"></div>
				</div>
			</div>

			<div class="fms_form_column fms_very_long_labels">

				<label class="control-label fms_required" id="agencyName_label" for="agencyName">
					<g:message code="agency.agencyName.label" default="Agency Name" />:
				</label>
				<div class="fms_form_input">
					<g:secureTextField name="agencyName"
						value="${agencyInstance?.agencyName}" maxlength="60"
						tableName="AGENCY" attributeName="agencyName" id="idAgencyName"
						title="The Name of the Agency"
						class="form-control" aria-labelledby="agencyName_label"
						aria-describedby="agencyName_error" aria-required="false">
					</g:secureTextField>
					<div class="fms_form_error" id="agencyName_error"></div>
				</div>

				<label class="control-label fms_required" id="tin_label" for="tin"> 
					<g:message code="agency.tin.label" default="Tax ID" />:
				</label>
				<div class="fms_form_input">
				<g:secureTextField name="tin" value="${agencyInstance?.tin}"
					maxlength="30" tableName="AGENCY" attributeName="tin"
					title="The 9 digit Tax ID Number of the Agency" id="idtin"
					class="form-control" aria-labelledby="tin_label"
					aria-describedby="tin_error" aria-required="false">
				</g:secureTextField>
				<div class="fms_form_error" id="tin_error"></div>

			</div>
		  </div>
		</div>			
	</fieldset>
</div>

<!-- END - WIDGET: General Information -->

<!-- Start - WIDGET: User Defined Information -->
<div id="widgetUserDefined" class="fms_widget">
	<fieldset>
		<legend>
			<h2>User Defined Information</h2>
		</legend>
		<div class="fms_form_layout_2column">
			<div class="fms_form_column fms_very_long_labels">
                 <label class="control-label" id="userDefined1_label" for="userDefined1">
                 	<g:userDefinedFieldLabel winId="AGNCM" datawindowId ="AGNCM" userDefineTextName="user_defined_1_t" defaultText="User Defined1"/>
                 </label>
                 <div class="fms_form_input">
                 
                    <g:secureTextField name="userDefined1"
									value="${agencyInstance?.userDefined1}"  
									maxlength="60" 
									tableName="AGENCY" 
									attributeName="userDefined1"
									class="form-control"
									aria-labelledby="userDefined1_label" 
						            aria-describedby="userDefined1_error" 
						            aria-required="false">
					</g:secureTextField>
                    <div class="fms_form_error" id="userDefined1_error"></div>
                 </div> 

                 <label class="control-label" id="userDate1_label" for="userDate1">
                 	<g:userDefinedFieldLabel winId="AGNCM" datawindowId ="AGNCM" userDefineTextName="user_date_1_t" defaultText="User Defined Date1"/>
                 </label>
                 <div class="fms_form_input">
                      <g:securejqDatePickerUIUX 
									tableName="AGENCY" attributeName="userDate1" 
									dateElementId="userDate1" 
									dateElementName="userDate1" 
									dateElementValue="${formatDate(format:'MM/dd/yyyy',date: agencyInstance?.userDate1)}"
									datePickerOptions="changeMonth:true, changeYear:true, yearRange:'${((agencyInstance?.userDate2 != null ? agencyInstance?.userDate2.get(Calendar.YEAR):Calendar.getInstance().get(Calendar.YEAR)) - 100)}:${((agencyInstance?.userDate2 != null ? agencyInstance?.userDate2.get(Calendar.YEAR):Calendar.getInstance().get(Calendar.YEAR)) + 100)}', numberOfMonths: 1"
									default="none"
									ariaAttributes="aria-labelledby='userDate1_label' aria-describedby='userDate1_error' aria-required='false'" 
									classAttributes ="class='form-control fms_date_mask fms_small_input onDelete hasDatepicker' "
									showIconDefault="${isShowCalendarIcon}"/> 
	
		
                    <div class="fms_form_error" id="userDate1_error"></div>
                 </div>			
			</div>
		<div class="fms_form_column fms_very_long_labels">


                  <label class="control-label" id="userDefined2_label" for="userDefined2">
                  		<g:userDefinedFieldLabel winId="AGNCM" datawindowId ="AGNCM" userDefineTextName="user_defined_2_t" defaultText="User Defined2"/>
                  </label>
                  <div class="fms_form_input">
                     <g:secureTextField name="userDefined2"
						value="${agencyInstance?.userDefined2}"  maxlength="60" tableName="AGENT_MASTER" attributeName="userDefined2"
						class="form-control" aria-labelledby="userDefined2_label" aria-describedby="userDefined2_error" aria-required="false">
					</g:secureTextField>
                     <div class="fms_form_error" id="userDefined2_error"></div>
                  </div> 

                  <label class="control-label" id="userDate2_label" for="userDate2">
                  	<g:userDefinedFieldLabel winId="AGNCM" datawindowId ="AGNCM" userDefineTextName="user_date_2_t" defaultText="User Defined Date2"/>
                  </label>
                  <div class="fms_form_input">
                      <g:securejqDatePickerUIUX 
									tableName="AGENT_MASTER" attributeName="userDate2" 
									dateElementId="userDate2" 
									dateElementName="userDate2" 
									dateElementValue="${formatDate(format:'MM/dd/yyyy',date: agencyInstance?.userDate2)}"
									datePickerOptions="changeMonth:true, changeYear:true, yearRange:'${((agencyInstance?.userDate2 != null ? agencyInstance?.userDate2.get(Calendar.YEAR):Calendar.getInstance().get(Calendar.YEAR)) - 100)}:${((agencyInstance?.userDate2 != null ? agencyInstance?.userDate2.get(Calendar.YEAR):Calendar.getInstance().get(Calendar.YEAR)) + 100)}', numberOfMonths: 1"
									default="none"
									ariaAttributes="aria-labelledby='userDate2_label' aria-describedby='userDate2_error' aria-required='false'" 
									classAttributes ="class='form-control fms_date_mask fms_small_input onDelete hasDatepicker' "
									showIconDefault="${isShowCalendarIcon}"/> 
															
                     <div class="fms_form_error" id="userDate2_error"></div>
                  </div>			
			</div>
		</div>									

	</fieldset>			
</div>
<!-- END - WIDGET: User Defined Information -->

	<!-- START - Delete Notice Modal -->
	<div class="modal fade" id="DeleteAlertModal" tabindex="-1" role="dialog" aria-labelledby="myModalLabel">        
		<div class="modal-dialog">
			<div class="modal-content fms_modal_error">
				<div class="modal-body">
					<button type="button" class="close" data-dismiss="modal" aria-label="Close"><span aria-hidden="true">&times;</span></button>
					<h4>Are you sure you want to delete this record?</h4>            
				</div>
				<div class="modal-footer">
					<button type="button" class="btn btn-default" data-dismiss="modal">Cancel</button>
					<button id="BtnDeleteRowYes" type="button" class="btn btn-primary" data-dismiss="modal">Yes, Delete</button>
				</div>
			</div>
		</div>
	</div>
	<!-- END - Delete Notice Modal -->

</div>