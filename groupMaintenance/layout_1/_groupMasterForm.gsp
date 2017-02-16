
<%@ page import="com.perotsystems.diamond.bom.GroupEx"%>
<%@ page import="com.perotsystems.diamond.bom.GroupType"%>
<%@ page import="com.perotsystems.diamond.dao.cdo.States"%>
<%@ page import="com.perotsystems.diamond.bom.Country"%>
<%@ page import="com.dell.diamond.fms.enums.PageNameEnum" %>
<head>
<script type="text/javascript" src="${resource(dir: 'js', file: 'jquery.maskedinput.js')}"></script>
	<script type="text/javascript" src="${resource(dir: 'js', file: 'commonfunctions.js')}"></script>
	<link rel="stylesheet" href="${resource(dir: 'css', file: 'member_pages.css')}" type="text/css">
	<g:set var="isShowCalendarIcon" value="${PageNameEnum.GROUP_EDIT.equals(currentPage)?false:true}" />

<script type="text/javascript">
$(document).ready(function() { 
          
          $( "#BtnGeneralEdit" ).click(function(e) {
            $('#BtnGeneralEdit').hide();
            $('.ui-datepicker-trigger').show();
            $('#BtnGeneralSave, #BtnGeneralReset').show();
            $('#widgetGeneral  input, #widgetGeneral  select, #widgetGeneral .fms_btn_icon').removeAttr('disabled');
            $('#widgetGroup  input, #widgetGroup  select, #widgetGroup .fms_btn_icon').removeAttr('disabled');           
            $('#widgetUserDefined  input, #widgetUserDefined  select, #widgetUserDefined .fms_btn_icon').removeAttr('disabled');
          });

          
            $('#BtnGeneralReset').click(function(e){ 
              	this.form.reset();
              	if (pageId == 'edit') {
					$('#BtnGeneralEdit').show();
					$('#BtnGeneralSave').hide();
					$('#BtnGeneralReset').hide();
					$('#widgetGeneral  input, #widgetGeneral select, #widgetGeneral .fms_btn_icon').attr('disabled', 'disabled');
			        $('#widgetGroup  input, #widgetGroup select, #widgetGroup .fms_btn_icon').attr('disabled', 'disabled');
			        $('#widgetAddress  input, #widgetAddress  select, #widgetGeneral .fms_btn_icon').attr('disabled', 'disabled');
			        $('#widgetUserDefined  input, #widgetUserDefined  select, #widgetGeneral .fms_btn_icon').attr('disabled', 'disabled');
			        $('.ui-datepicker-trigger').hide();

				}
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
			if (pageId == 'edit' && !(document.getElementById("error"))) {

		          // Make all the inputs disabled
		          $('#widgetGeneral  input, #widgetGeneral select, #widgetGeneral .fms_btn_icon').attr('disabled', 'disabled');
		          $('#widgetGroup  input, #widgetGroup select, #widgetGroup .fms_btn_icon').attr('disabled', 'disabled');
		          $('#widgetAddress  input, #widgetAddress  select, #widgetGeneral .fms_btn_icon').attr('disabled', 'disabled');
		          $('#widgetUserDefined  input, #widgetUserDefined  select, #widgetGeneral .fms_btn_icon').attr('disabled', 'disabled');
		          // Hide the "Save and Reset" buttons by the form titles
		          $('#BtnGeneralSave, #BtnGeneralReset').hide();
		          
				
			} else {// Treating this is a create action
				$('button[id^="_calendar_button_address"]').show()
				$('#BtnGeneralEdit').hide();
		          // Hide the "Save and Reset" buttons by the form titles
		          

				}
			
       });

   </script>


<g:javascript>

	$(document).ready(function(){
		$( "#holdDate" ).rules( "add", {  
				required: function(element){
							return $.trim($("#holdReason").val()).length >0;						
						},								
				messages: {  
							required: "Hold Date is required if Hold Reason is entered."    
						}
			}); 

		$( "#holdReason" ).rules( "add", {  
				required: function(element){								
							return $.trim($("#holdDate").val()).length >0;						
						 },								
				messages: {  
							required: "Hold Reason is required if Hold Date is entered."    
						  }
			});	
	});	
</g:javascript>

<script type="text/javascript">
function displayAddressMessage(){
	$("#BtnInfoAlertId").removeAttr('disabled')	
	document.getElementById('BtnInfoAlertId').click();
}
</script>


</head>


		<!-- START - Jump To: -->
        <div id="jumpto">
          <div class="jumpto_inner">
            <ul>
              <li><a href="#widgetGeneral">General Information</a></li>
              <li><a href="#widgetGroup">Group Information</a></li>
              <li><a href="#widgetAddress">Primary Address</a></li>
              <li><a href="#widgetUserDefined">User Defined Fields</a></li>
            </ul>
            </div>
        </div>      
		<!-- END - Jump To: -->
		

<div class="right-corner" align="right">GROUP</div>  
<div id="fms_content_body" style="visibility: hidden">

		<!-- START - Error Messages: -->
		<g:if test="${flash.message}">
			<div class="message" role="status">
				${flash.message}
			</div>
		</g:if>
		<g:if test="${fieldErrors}">
			<ul id="error" class="errors" role="alert">
				<g:each in="${fieldErrors}" var="error">
					<li>
						${error}
					</li>
				</g:each>
			</ul>
		</g:if>
		<ul id="errorDisplay" style="display: none;" class="errors" role="alert" style="float:left; margin: -5px 10px 0px 0px; "></ul>
		<!-- End - Error Messages: -->


<g:hiddenField name="groupDBId" value="${groupMasterInstance?.groupDBId}" />
<div class="fms_required_legend fms_required">= required</div>
	<!-- START - WIDGET: General Information -->
	<div id="widgetGeneral" class="fms_widget">
		<fieldset>
			<legend>
				<h2>General Information</h2>
				<button type="button" id="BtnGeneralEdit" class="btn btn-default btn-xs"><span class="glyphicon glyphicon-pencil"></span> Edit</button>
				<button id="BtnGeneralSave"	class="btn btn-primary btn-xs"><span class="fa fa-floppy-o"></span> Save</button>
				<button type="button" id="BtnGeneralReset" class="btn btn-default btn-xs"><span class="glyphicon glyphicon-repeat"></span> Reset</button>
			</legend>

			<div class="fms_form_layout_2column">
				<div class="fms_form_column">

					<label class="control-label  fms_required" id="groupId_label" for="groupId">
						<g:message code="groupMaster.groupId.label" default="Group Id :" />
					</label>
					<div class="fms_form_input">
						<g:if test="${request.getParameter("groupId")}">
							<p name="cgpid" readOnly="true"
							tableName="GROUP_MASTER" attributeName="groupId"  value="${request.getParameter("groupId")}"
							aria-labelledby="groupId_label" class="form-control-static">${request.getParameter("groupId")}</p>								
							<g:hiddenField name="groupId"
								value="${groupMasterInstance?.groupId}"
								aria-labelledby="groupId_label" class="form-control" />
						</g:if>
						<g:else>
							<g:secureTextField class="form-control" name="groupId"
								tableName="GROUP_MASTER" attributeName="groupId" value=""
								aria-labelledby="groupId_label" aria-describedby="groupId_error" aria-required="false"></g:secureTextField>
						</g:else>						
					</div>

					<label class="control-label fms_required" id="groupLevel_label" for="groupLevel">
						<g:message code="groupMaster.groupLevel.label" default="Group Level :" />
					</label>
					<div class="fms_form_input">
						<g:secureComboBox class="form-control" id="levelCode"
							name="levelCode" tableName="GROUP_MASTER"
							attributeName="levelCode"
							value="${groupMasterInstance?.levelCode?.toString()}"
							from="${['' : '-- Select Level Code --', '1': 'Group' , '2': 'Super Group' , '3': 'Administrator Group']}"
							optionValue="value" optionKey="key"
							aria-labelledby="GroupLevel_label"
							aria-describedby="GroupLevel_error" aria-required="false">
						</g:secureComboBox>
						<div class="fms_form_error" id="GroupLevel_error"></div>
					</div>

					<label class="control-label" id="federalTaxId_label" for="federalTaxId">
						<g:message code="groupMaster.federalTaxId.label" default="Federal Tax Id :" />
					</label>
					<div class="fms_form_input">
						<g:secureTextField class="form-control taxId" name="taxId" id="taxId"
							tableName="GROUP_MASTER" attributeName="taxId"
							value="${groupMasterInstance?.taxId}" maxlength="10"
							aria-labelledby="FederalTaxID_label" placeholder="00-0000000"
							aria-describedby="FederalTaxID_error" aria-required="false">
						</g:secureTextField>
						<div class="fms_form_error" id="FederalTaxID_error"></div>
					</div>
				</div>


				<div class="fms_form_column">


					<label class="control-label" id="nationalEmployerId_label" for="nationalEmployerId">
						<g:message code="groupMaster.nationalEmployerId.label" default="Natl Employer Id :" />
					</label>
					<div class="fms_form_input">
						<g:secureTextField class="form-control" name="nationalEmployerId"
							id="nationalEmployerId" tableName="GROUP_MASTER"
							attributeName="nationalEmployerId"
							value="${groupMasterInstance?.nationalEmployerId}" maxlength="9"
							aria-labelledby="EmployerID_label"
							aria-describedby="EmployerID_error" aria-required="false">
						</g:secureTextField>
						<div class="fms_form_error" id="EmployerID_error"></div>
					</div>

					<label class="control-label" id="parent_label" for="parent">
						<g:message code="groupMaster.parent.label" default="Parent :" />
					</label>
					<div class="fms_form_input fms_has_feedback">
						<input type="hidden" name="parentLevelHidden" id="parentLevelHidden" value="2" />
						<input type="hidden" name="seqParentId" id="seqParentId" value="${groupMasterInstance?.seqParentId}" />				
						<g:secureTextField class="form-control" name="parentGroupId" id="parentGroupId" tableName="GROUP_MASTER" attributeName="seqParentId" 
								value="${groupMasterInstance?.parentGroupId != 0 ? groupMasterInstance?.parentGroupId : ""}"
								aria-labelledby="parent_label" aria-describedby="parent_error" aria-required="false"></g:secureTextField>
						<fmsui:cdoLookup lookupElementId="parentGroupId"
									   lookupElementName="parentGroupId" 
									   lookupElementValue="${groupMasterInstance?.parentGroupId != 0 ? groupMasterInstance?.parentGroupId : ""}"
									   lookupCDOClassName="com.perotsystems.diamond.dao.cdo.GroupMaster"
									   lookupCDOClassAttribute="groupId"
									   htmlElementsToUpdate="seqParentId"
									   htmlElementsToUpdateCDOProperty="seqGroupId"
									   htmlElementsToAddToQuery=""
									   htmlElementsToAddToQueryCDOProperty=""/>
						<div class="fms_form_error" id="parent_error"></div>
					</div>


				</div>
			</div>
		</fieldset>
	</div>

	<!-- END - WIDGET: General Information -->

	<!-- START - WIDGET: Group Information -->
	<div id="widgetGroup" class="fms_widget">

		<fieldset>
			<legend><h2>Group Information</h2></legend>


			<div class="fms_form_layout_2column">
			
				<div class="fms_form_column">

			 		<label class="control-label" id="holdReason_label" for="holdReason">
						<g:message code="premiumMaster.effectiveDate.label" default="Hold Reason :" />
					</label>
					<div class="fms_form_input fms_has_feedback">
						<input type="hidden" name="reasonCodeTypeHidden" id="reasonCodeTypeHidden" value="HD" />
						<g:secureTextField class="form-control"  name="holdReason" id="holdReason" tableName="GROUP_MASTER" attributeName="holdReason" maxlength="5"
											value="${groupMasterInstance?.holdReason}" aria-labelledby="holdReason_label" aria-describedby="holdReason_error" 
											aria-required="false"></g:secureTextField>
						<fmsui:cdoLookup lookupElementId="holdReason"
							   lookupElementName="holdReason" 
							   lookupElementValue="${groupMasterInstance?.holdReason}"
							   lookupCDOClassName="com.perotsystems.diamond.dao.cdo.ReasonCodeMaster"
							   lookupCDOClassAttribute="reasonCode"
							   htmlElementsToAddToQuery="reasonCodeTypeHidden"
						   	   htmlElementsToAddToQueryCDOProperty="reasonCodeType"/>
						<div class="fms_form_error" id="holdReason_error"></div>
					</div>
					
			 		<label class="control-label" id="accountType_label" for="accountType">
						<g:message code="groupMaster.accountType.label" default="Account Type :" />
					</label>
					<div class="fms_form_input fms_has_feedback">
						<input type="hidden" name="systemCodeTypeHidden" id="systemCodeTypeHidden" value="GROUPACCTT"/>
						<g:secureTextField class="form-control"  name="accountType" id="accountType" tableName="GROUP_MASTER" attributeName="accountType" maxlength="2"
											value="${groupMasterInstance?.accountType}" aria-labelledby="accountType_label" aria-describedby="accountType_error" 
											aria-required="false"></g:secureTextField>
						<fmsui:cdoLookup lookupElementId="accountType"
							   lookupElementName="accountType" 
							   lookupElementValue="${groupMasterInstance?.accountType}"
							   lookupCDOClassName="com.perotsystems.diamond.dao.cdo.SystemCodes"
							   lookupCDOClassAttribute="systemCode"
							   htmlElementsToAddToQuery="systemCodeTypeHidden"
						   	   htmlElementsToAddToQueryCDOProperty="systemCodeType"/>
						<div class="fms_form_error" id="accountType_error"></div>
					</div>
	
					<label class="control-label" id="asoIndicator_label" for="asoIndicator">
						<g:message code="groupMaster.asoIndicator.label" default="Aso Indicator :" />
					</label>
					<div class="fms_form_input">
						<g:secureComboBox class="form-control" name="asoIndicator"
							tableName="GROUP_MASTER" attributeName="asoIndicator"
							value="${groupMasterInstance?.asoIndicator}"
							from="${['' : '', '1': 'Yes' , '2': 'No']}" optionValue="value"
							optionKey="key">
						</g:secureComboBox>
					</div>
					
					<label class="control-label" id="holdDate_label" for="holdDate">
						<g:message code="groupMasterInstance?.holdDate.label" default="Hold Date :" />
					</label>
					<div class="fms_form_input">
						<g:securejqDatePickerUIUX tableName="GROUP_MASTER" attributeName="holdDate"
							dateElementId="holdDate"
							dateElementName="holdDate"
							datePickerOptions="changeMonth:true, changeYear:true, yearRange: 'c-100:c+100', maxDate:'+10y'"
							dateElementValue="${formatDate(format:'MM/dd/yyyy',date: groupMasterInstance?.holdDate)}"
							ariaAttributes="aria-labelledby='holdDate_label' aria-describedby='holdDate_error' aria-required='false'"
							classAttributes="class='form-control fms_date_mask fms_small_input onDelete hasDatepicker' " 
							showIconDefault="${isShowCalendarIcon}"/>
					</div>
				
				</div>

				<div class="fms_form_column">


					<label class="control-label fms_required" id="groupType_label" for="groupType">
						<g:message code="groupMaster.groupType.label" default="Group Type :" />
					</label>
					<div class="fms_form_input">
						<g:secureComboBox class="form-control" id="groupType"
							name="groupType" tableName="GROUP_MASTER"
							attributeName="groupType"
							value="${groupMasterInstance?.groupType}"
							from="${['' : '-- Select Group Type --', '1': 'Commercial' , '2': 'Individual' , '3': 'Combined', '4': 'Medicaid', '5': 'Medicare']}"
							optionValue="value" optionKey="key">
						</g:secureComboBox>
					</div>
					

					<label class="control-label fms_required" id="shortName_label" for="shortName">
						<g:message code="groupMaster.shortName.label" default="Short Name :" />
					</label>
					<div class="fms_form_input">
						<g:secureTextField class="form-control" name="shortName"
							tableName="GROUP_MASTER" attributeName="shortName"
							value="${groupMasterInstance?.shortName}" maxlength="15"
							id="shortName" aria-labelledby="ShortName_label"
							aria-describedby="ShortName_error" aria-required="true">
						</g:secureTextField>
						<div class="fms_form_error" id="ShortName_error"></div>
					</div>
					
					
					<label class="control-label" id="name1_label" for="name1">
						<g:message code="groupMaster.name1.label" default="Name1 :" />
					</label>
					<div class="fms_form_input">
						<g:secureTextField class="form-control" name="name1"
							tableName="GROUP_MASTER" attributeName="groupName1"
							value="${groupMasterInstance?.name1}" maxlength="40">
						</g:secureTextField>
					</div>


					<label class="control-label" id="name2_label" for="name2">
						<g:message code="groupMaster.name2.label" default="Name2 :" />
					</label>
					<div class="fms_form_input">
						<g:secureTextField class="form-control" name="name2"
							tableName="GROUP_MASTER" attributeName="groupName2"
							value="${groupMasterInstance?.name2}" maxlength="40">
						</g:secureTextField>
					</div>


				</div>
			</div>
		</fieldset>
	</div>
	<!-- END - WIDGET: Group Information -->


	<!-- START - WIDGET: Primary Address -->

	<div id="widgetAddress" class="fms_widget">

		<fieldset>
			<legend>
				<h2>Group Primary Address</h2>
				<g:if test="${groupMasterInstance?.groupDBId}">
					<button type="button" class="btn btn-default btn-xs"
						onclick="location.href='/FMSAdminConsole/groupMaintenance/edit/${groupMasterInstance?.groupId}?groupId=${groupMasterInstance?.groupId}&groupDBId=${groupMasterInstance?.groupDBId}&groupEditType=ADDRESS'">
						<span class="glyphicon glyphicon-pencil"></span> Edit
					</button>
				</g:if>
				<g:else>
					<button type="button" class="btn btn-default btn-xs" onClick="displayAddressMessage()">
						<span class="glyphicon glyphicon-pencil"></span> Edit
					</button>
				</g:else>
				<button id="BtnInfoAlertId" type="button" class="btn fms_btn_icon btn-sm btnInfoAlert" title="Click to reset address form." data-target="#InfoAlert"><span class="glyphicon glyphicon-repeat"></span></button>				
			</legend>

			<div class="fms_form_layout_2column">
				<div class="fms_form_column">

					<label class="control-label" id="address1_label" for="address1">
						<g:message code="groupMaster.address1.label" default="Address1 :" />
					</label>
					<div class="fms_form_input">
						<g:secureTextField class="form-control"
							name="address.primary.1.address1"
							value="${groupMasterInstance?.address?.address1}"
							tableName="GROUP_MASTER" attributeName="addressLine1"
							disabled="disabled">
						</g:secureTextField>
					</div>

					<label class="control-label" id="groupState_label" for="groupState">
						<g:message code="groupMaster.groupState.label" default="State :" disabled="disabled" />
					</label>
					<div class="fms_form_input">
						<g:secureTextField class="form-control" name="state"
							tableName="GROUP_MASTER" attributeName="state"
							value="${groupMasterInstance?.address?.state}"
							noSelection="['':'-- Select a State --']"
							onchange="${remoteFunction(controller:'groupMaintenance',action:'ajaxGetCities', params:'\'state=\' + escape(this.value)', onComplete:'updateCity(e)')}"
							from="${states}" optionValue="stateCode" optionKey="stateName" disabled="disabled">
						</g:secureTextField>
					</div>


					<label class="control-label" id="country_label" for="country">
						<g:message code="groupMaster.country.label" default="Country :" />
					</label>
					<div class="fms_form_input">
						<g:secureTextField class="form-control" name="country"
							tableName="GROUP_MASTER" attributeName="country"
							value="${groupMasterInstance?.address?.country}"
							onchange="${remoteFunction(controller:'groupMaintenance',action:'ajaxGetCities', params:'\'state=\' + escape(this.value)', onComplete:'updateCity(e)')}"
							from="${countries}" optionValue="countryCode" optionKey="country"
							noSelection="['':'']" disabled="disabled">
						</g:secureTextField>
					</div>

				</div>

				<div class="fms_form_column">


					<label class="control-label" id="address2_label" for="address2">
						<g:message code="groupMaster.address2.label" default="Address2 :" />
					</label>
					<div class="fms_form_input">
						<g:secureTextField class="form-control"
							name="address.primary.1.address2" tableName="GROUP_MASTER"
							attributeName="addressLine2"
							value="${groupMasterInstance?.address?.address2}"
							disabled="disabled">
						</g:secureTextField>
					</div>

					<label class="control-label" id="zipCode_label" for="zipCode">
						<g:message code="groupMaster.zipCode.label" default="Zip Code :" />
					</label>
					<div class="fms_form_input">
						<g:secureTextField class="form-control"
							name="address.primary.1.zip" tableName="GROUP_MASTER"
							attributeName="zipCode"
							value="${groupMasterInstance?.address?.zip}" disabled="disabled">
						</g:secureTextField>
					</div>


					<label class="control-label" id="city_label" for="city">
						<g:message code="groupMaster.city.label" default="City :" disabled="disabled" />
					</label>
					<div class="fms_form_input">
						<g:secureTextField class="form-control"
							name="address.primary.1.city" tableName="GROUP_MASTER"
							attributeName="city"
							value="${groupMasterInstance?.address?.city}" disabled="disabled">
						</g:secureTextField>
					</div>

				</div>
			</div>
		</fieldset>
	</div>
	<!-- END - WIDGET: Primary Address -->



	<!-- START - WIDGET: User Defined Fields -->
	<div id="widgetUserDefined" class="fms_widget">

		<fieldset>
			<legend>
				<h2>User Defined Fields</h2>
			</legend>

			<div class="fms_form_layout_2column">
				<div class="fms_form_column">

					<label class="control-label" id="userDefined1_label" for="userDefined1">
						<g:userDefinedFieldLabel winId="GROUP"
							datawindowId="dw_group_de" userDefineTextName="user_defined_1_t"
							defaultText="User Defined 1" />
					</label>
					<div class="fms_form_input">
						<g:secureTextField class="form-control" name="userDefined1"
							tableName="GROUP_MASTER" attributeName="userDefined1"
							value="${groupMasterInstance?.userDefined1}">
						</g:secureTextField>
					</div>

					<label class="control-label" id="userDefined2_label" for="userDefined2">
						<g:userDefinedFieldLabel winId="GROUP"
							datawindowId="dw_group_de" userDefineTextName="user_defined_2_t"
							defaultText="User Defined 2" />
					</label>
					<div class="fms_form_input">
						<g:secureTextField class="form-control" name="userDefined2"
							tableName="GROUP_MASTER" attributeName="userDefined2"
							value="${groupMasterInstance?.userDefined2}">
						</g:secureTextField>
					</div>

					<label class="control-label" id="userDefined3_label" for="userDefined3">
						<g:userDefinedFieldLabel winId="GROUP"
							datawindowId="dw_group_de" userDefineTextName="user_defined_3_t"
							defaultText="User Defined 3" />
					</label>
					<div class="fms_form_input">
						<g:secureTextField class="form-control" name="userDefined3"
							tableName="GROUP_MASTER" attributeName="userDefined3"
							value="${groupMasterInstance?.userDefined3}">
						</g:secureTextField>
					</div>

				</div>

				<div class="fms_form_column">

					<label class="control-label" id="userDefined4_label" for="userDefined4">
						<g:userDefinedFieldLabel winId="GROUP"
							datawindowId="dw_group_de" userDefineTextName="user_defined_4_t"
							defaultText="User Defined 4" />
					</label>
					<div class="fms_form_input">
						<g:secureTextField class="form-control" name="userDefined4"
							tableName="GROUP_MASTER" attributeName="userDefined4"
							value="${groupMasterInstance?.userDefined4}">
						</g:secureTextField>
					</div>

					<label class="control-label" id="userDefined5_label" for="userDefined5">
						<g:userDefinedFieldLabel winId="GROUP"
							datawindowId="dw_group_de" userDefineTextName="user_defined_5_t"
							defaultText="User Defined 5" />
					</label>
					<div class="fms_form_input">
						<g:secureTextField class="form-control" name="userDefined5"
							tableName="GROUP_MASTER" attributeName="userDefined5"
							value="${groupMasterInstance?.userDefined5}">
						</g:secureTextField>
					</div>

				</div>

			</div>
		</fieldset>
	</div>



</div>

	<div class="modal fade" id="InfoAlert" tabindex="-1" role="dialog" aria-labelledby="myModalLabel">        
	  	<div class="modal-dialog">
	       	<div class="modal-content fms_modal_info">
	           	<div class="modal-body">
	           		<button type="button" class="close" data-dismiss="modal" aria-label="Close"><span aria-hidden="true">&times;</span></button>
	           		<h4>To populate address fields, complete and save this group master page. Then under the 'Addresses' tab, add address details.</h4>
	            </div>
	            <div class="modal-footer">
	            	<button type="button" class="btn btn-default" data-dismiss="modal">Ok</button>
	          	</div>
	      	</div>
	  	</div>
	</div>	