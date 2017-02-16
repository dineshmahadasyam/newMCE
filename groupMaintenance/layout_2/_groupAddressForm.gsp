<%@ page import="com.perotsystems.diamond.bom.GroupEx" %>
<%@ page import="com.perotsystems.diamond.bom.Group" %>
<%@ page import="com.perotsystems.diamond.bom.Address" %>
<%@ page import="com.perotsystems.diamond.bom.GroupAddress" %>
    
<style type='text/css' media='screen'>	
.addButton {
	-moz-box-shadow:inset -1px 1px 7px 0px #ffffff;
	-webkit-box-shadow:inset -1px 1px 7px 0px #ffffff;
	box-shadow:inset -1px 1px 7px 0px #ffffff;
	background-color:#ededed;
	-moz-border-radius:15px;
	-webkit-border-radius:15px;
	border-radius:10px;
	border:1px solid #999999;
	display:inline-block;
	color:#404040;
	font-family:arial;
	font-size:16px;
	font-weight:normal;
	padding:5px 24px;
	text-decoration:none;
	text-shadow:1px 0px 13px #ffffff;
}.addButton:hover {
	background-color:#dfdfdf;
}.addButton:active {
	position:relative;
	top:1px;
}
.hideme Label{
	width:120px;
	text-align:left;
	padding-bottom:5px;
}
.hideme Input{
	width:100px;
	text-align:left;
	padding-bottom:5px;
}

.fieldcontain span {
	color: #0066CC;
}
</style>

<g:set var="appContext" bean="grailsApplication"/>

	<script type="text/javascript">
	//<![CDATA[ 
	$(window).load(function() {
		$('.hideme').find('div').hide();
		$('.clickme').click(function() {
			//CQ 56593 fix started
		   
			if($(this).parent().next('.hideme').find('div').is(":visible")){
				$(this).parent().children().children().get(0).checked = false;
			}else{
				$(this).parent().children().children().get(0).checked = true;
			}
			$(this).parent().next('.hideme').find('div').slideToggle(500);
			return false;
		});		
		
		$(".selectradio").click(function(){
			if($(this).parent().parent().next('.hideme').find('div').is(":visible")){
				$(this).parent().children().get(0).checked = false;
			}else{
				$(this).parent().children().get(0).checked = true;
			}
			$(this).parent().parent().next('.hideme').find('div').slideToggle(500);
		});
		//CQ 56593 fix fixed


	});//]]>  	
	</script>
	
	<script>
	function cloneRow()
	{

		var divObjSrc = document.getElementById('newGroupAddress')
		var divObjDest = document.getElementById('addGroupPlaceHolder')
		divObjDest.innerHTML = divObjSrc.innerHTML
		var divObj = document.getElementById('addAddressDiv')
		divObj.style.display = "none"	
	}

	function addGroupAddress() {
		var groupId = "${groupMasterInstance?.groupId}";
		var groupDBId = "${groupMasterInstance?.groupDBId}";
		var appName = "${appContext.metadata['app.name']}";
		
		window.location.assign("/"+appName+"/groupMaintenance/addAddress?groupId="
				+ groupId + "&grouEditType=ADDRESS&groupDBId="+groupDBId);
	}
	$(function($){
		   $(".maskZip").mask("99999?-9999");
		})
	</script>

	<g:hiddenField name="groupId" value="${groupMasterInstance?.groupId}" />
	<g:hiddenField name="groupDBId" value="${groupMasterInstance?.groupDBId}" />
     
<div id="addAddressDiv" style="display:block">
	<input class="addButton" type="button" value="Add Address" onClick="addGroupAddress()">
	<br></br>
</div>	   
Group Addresses Records for Group ID: ${groupMasterInstance.getGroupId()}
<br></br>
<table border="1" id="report">
	<tr class="head">
		<th>Select</th>
		<th>Effective Date</th>
		<th>Term Date</th>
		<th>Term Reason</th>
		<th>Address Type</th>
		<th>Primary</th>
		<th>Billing</th>
		<th>In Active</th>
		<th>
			<g:userDefinedFieldLabel winId="GRUPA" datawindowId ="dw_grupa_de" userDefineTextName="USER_DEF_1_t"
													defaultText="User Defined 1" isHeader="true"  />			
		</th>
		<th>
			<g:userDefinedFieldLabel winId="GRUPA" datawindowId ="dw_grupa_de" userDefineTextName="USER_DEF_2_t"
													defaultText="User Defined 2" isHeader="true"  /> 
		</th>
		<th>
			<g:userDefinedFieldLabel winId="GRUPA" datawindowId ="dw_grupa_de" userDefineTextName="USER_DEF_3_t"
													defaultText="User Defined 3" isHeader="true" />
		</th>
		<th>
			<g:userDefinedFieldLabel winId="GRUPA" datawindowId ="dw_grupa_de" userDefineTextName="USER_DEF_4_t"
													defaultText="User Defined 4" isHeader="true" />
		</th>
		<th>
			<g:userDefinedFieldLabel winId="GRUPA" datawindowId ="dw_grupa_de" userDefineTextName="USER_DEF_5_t"
													defaultText="User Defined 5" isHeader="true"  />
		</th>
		
	</tr>
	<g:each in="${groupMasterInstance.addresses}" status="i" var="address">
		<input type="hidden" name="seq_address_id_${i}" value="${address.groupAddressDBId }">
		<input type="hidden" name="address.${i}.iterationCount" value="${i}">
	
		<tr id="rowToClone1">
			
			<td>
				<input type="radio" name="addressId" class="selectradio" value="${address.groupAddressDBId}"> 
			</td>
			<td>
				<g:formatDate  format="yyyy-MM-dd"  date="${address.effectiveDate}" />
			</td>
			<td>
				<g:formatDate  format="yyyy-MM-dd"  date="${address.termDate}" />
			</td>
			<td>
				${address.termReason}
			</td>
			<td>
				${address.addressType}
			</td>
			<td>
				<input type="checkbox" name="isPrimary" ${ address.isPrimaryAddress ? 'checked' : ''}>
			</td>
			<td>
				<input type="checkbox" name="isPrimary" ${ address.isBillingAddress ? 'checked' : ''}>
			</td>
			<td>
				<input type="checkbox" name="isPrimary" ${ address.isInactive ? 'checked' : ''}>
			</td>
			<td>
				${address.userDefined1}
			</td>
			<td>
				${address.userDefined2}
			</td>
			<td>
				${address.userDefined3}
			</td>
			<td>
				${address.userDefined4}
			</td>
			<td>
				${address.userDefined5}
			</td>
		</tr>	
		<tr class="hideme" id="rowToClone2">
			<td colspan="13">
				<div class="divContent">
						<table class="report1" id="editFields" border="0">
							<tr>
							<td style="white-space:nowrap">
									<div
										class="fieldcontain ${hasErrors(bean: address, field: 'address.addressType', 'error')} ">
										<label for="addressType"> <g:message
												code="groupMaster.addressType.label" default="Address Type :" />
											<span class="required-indicator">*</span>
										</label>
										<g:secureSystemCodeToken
											tableName="GROUP_ADDRESS" attributeName="addressType"
											systemCodeType="ADDRESSTYPE" languageId="0"
											htmlElelmentId="address.${i}.addressType"
											blankValue="Address Type" 
											defaultValue="${address?.addressType}" 
											value="${address?.addressType}"
											style="width:150px">
											</g:secureSystemCodeToken>
											
											
									</div>
									</td>
								<td style="white-space:nowrap">
									<div
										class="fieldcontain ${hasErrors(bean: address, field: 'address.effectiveDate', 'error')} ">
										<label for="effectiveDate"> <g:message
												code="groupMaster.effectiveDate.label" default="Effective Date :" />
											<span class="required-indicator">*</span>
										</label>
										<g:secureGrailsDatePicker
											name="address.${ i }.effectiveDate" precision="day" 
											tableName="GROUP_ADDRESS" attributeName="effectiveDate" precision="day" noSelection="['':'']"
											value="${address?.effectiveDate}" default="none"></g:secureGrailsDatePicker>									
										
									</div>
								</td>
								</tr>
								<tr>
								<td>
									<div
										class="fieldcontain ${hasErrors(bean: address, field: 'address.termDate', 'error')} ">
										<label for="termDate"> <g:message
												code="groupMaster.termDate.label" default="Term Date :" />
						
										</label>									
										<g:secureGrailsDatePicker
											name="address.${ i }.termDate" precision="day" 
											tableName="GROUP_ADDRESS" attributeName="termDate" precision="day" noSelection="['':'']"
											value="${address?.termDate}" default="none"></g:secureGrailsDatePicker>
																					
								</div>
								</td>
								<td>
									<div
										class="fieldcontain ${hasErrors(bean: address, field: 'address.termReason', 'error')} ">
										<label for="termReason"> <g:message
												code="groupMaster.termReason.label" default="Term Reason :" />
						
										</label>
										<input type="hidden" name="TermReasonType" id="TermReasonType" value="TM"/>													
											<g:secureTextField maxlength="5"
											name="address.${i}.termReason" 
											tableName="GROUP_ADDRESS" attributeName="termReason" 
											value="${address?.termReason}" style="width:150px"></g:secureTextField>
											
										<img width="25" height="25"
											style="float: none; vertical-align: bottom"
											class="magnifying" src="${resource(dir: 'images', file: 'Search-icon.png')}"
											onclick="lookup('address.${ i }.termReason', 'com.perotsystems.diamond.dao.cdo.ReasonCodeMaster','reasonCode', 'TermReasonType', 'reasonCodeType', null, null)">												
									
									</div>
								</td>
							</tr>
							<tr>								
									<td style="white-space:nowrap">
										<div
											class="fieldcontain ${hasErrors(bean: address, field: 'address.isPrimaryAddress', 'error')} ">
											<label for="isPrimaryAddress"> <g:message
													code="groupMaster.isPrimaryAddress.label" default="Primary Address :" />
							
											</label>
											<g:secureComboBox name="address.${i}.isPrimaryAddress" style="width: 150px"
												tableName="GROUP_ADDRESS" attributeName="primAddress" value="${address?.isPrimaryAddress}"
												from="${['' : '', 'true': 'Yes' , 'false': 'No']}" optionValue="value" optionKey="key"></g:secureComboBox>						
										</div>
									</td>
									<td style="white-space:nowrap">
										<div
											class="fieldcontain ${hasErrors(bean: address, field: 'address.isBillingAddress', 'error')} ">
											<label for="isBillingAddress"> <g:message
													code="groupMaster.isBillingAddress.label" default="Billing Address :" />
							
											</label>			
											
											<g:secureComboBox name="address.${i}.isBillingAddress" style="width: 150px"
												tableName="GROUP_ADDRESS" attributeName="billAddress" value="${address?.isBillingAddress}"
												from="${['' : '', 'true': 'Yes' , 'false': 'No']}" optionValue="value" optionKey="key"></g:secureComboBox>										
										</div>
									</td>	
									<td style="white-space:nowrap">
										<div
											class="fieldcontain ${hasErrors(bean: address, field: 'address.isInactive', 'error')} ">
											<label for="isInactive"> <g:message
													code="groupMaster.isInactive.label" default="Inactive :" />
							
											</label>											
											<g:secureComboBox name="address.${i}.isInactive" style="width: 150px"
												tableName="GROUP_ADDRESS" attributeName="inactive" value="${address?.isInactive}"
												from="${['' : '', 'true': 'Yes' , 'false': 'No']}" optionValue="value" optionKey="key">
										</g:secureComboBox>											
										</div>
									</td>
							</tr>
							<tr>
								<td style="white-space:nowrap">
									<div
										class="fieldcontain ${hasErrors(bean: address, field: 'address.address1', 'error')} ">
										<label for="address1"> <g:message
												code="groupMaster.address1.label" default="Address1 :" /><span class="required-indicator">*</span>
						
										</label>											
											<g:secureTextField maxlength="60"
											name="address.${i}.address1"
											tableName="GROUP_ADDRESS" attributeName="addressLine1" 
											value="${address?.address1}" style="width:150px"></g:secureTextField>
									</div>
								</td>
								<td style="white-space:nowrap">
									<div
										class="fieldcontain ${hasErrors(bean: address, field: 'address.address2', 'error')} ">
										<label for="address2"> <g:message
												code="groupMaster.address2.label" default="Address2 :" />
						
										</label>
											<g:secureTextField maxlength="60"
											name="address.${i}.address2"
											tableName="GROUP_ADDRESS" attributeName="addressLine2" 
											value="${address?.address1}" style="width:150px"></g:secureTextField>
									</div>
								</td>
								<td style="white-space:nowrap">
									<div
										class="fieldcontain ${hasErrors(bean: address, field: 'address.city', 'error')} ">
										<label for="city"> <g:message code="groupMaster.city.label"
												default="City :" /><span class="required-indicator">*</span>
						
										</label>
											<g:secureTextField maxlength="30"
											name="address.${i}.city"
											tableName="GROUP_ADDRESS" attributeName="city" 
											value="${address?.city}" class="RemoveSpecialChars" style="width:150px"></g:secureTextField>
									</div>
								</td>
							</tr>
							<tr>
								<td style="white-space:nowrap">
									<div
										class="fieldcontain ${hasErrors(bean: address, field: 'address.state', 'error')} ">
										<label for="groupState"> <g:message
												code="groupMaster.groupState.label" default="State :" />
						<span class="required-indicator">*</span>
										</label> 
									        <g:secureComboBox
											name="address.${i}.state" optionKey="stateCode"
											tableName="GROUP_ADDRESS" attributeName="state" 
											optionValue="stateName" id="state.name" from="${states}"
											noSelection="['':'-- Select a State --']"
											value="${address?.state}">
										</g:secureComboBox>
									</div>
								</td>
								<td style="white-space:nowrap">
									<div
										class="fieldcontain ${hasErrors(bean: address, field: 'address.zip', 'error')} ">
										<label for="zipCode"> <g:message
												code="groupMaster.zipCode.label" default="Zip Code :" /><span class="required-indicator">*</span>
						
										</label>
											<g:secureTextField maxlength="10"
											name="address.${i}.zip"
											tableName="GROUP_ADDRESS" attributeName="zipCode" class="maskZip"
											value="${address?.zip}" style="width:150px"></g:secureTextField>
									</div>
								</td>
								<td style="white-space:nowrap">
									<div
										class="fieldcontain ${hasErrors(bean: address, field: 'address.county', 'error')} ">
										<label for="county"> <g:message
												code="groupMaster.county.label" default="County :" />
						
										</label>
										<g:secureTextField maxlength="30"
											name="address.${i}.county"
											tableName="GROUP_ADDRESS" attributeName="county" 
											value="${address?.county}"></g:secureTextField>
									</div>
								</td>
							</tr>
							<tr>
								<td>
									<div
										class="fieldcontain ${hasErrors(bean: address, field: 'address.country', 'error')} ">
										<label for="country"> <g:message code="groupMaster.country.label" default="Country :" />
						
										</label>										
										<g:secureTextField maxlength="30"
											name="address.${i}.country"
											tableName="GROUP_ADDRESS" attributeName="country" 
											value="${address?.country}" style="width:150px"></g:secureTextField>
									</div>
								</td>
							</tr>
							
							<tr>
								<td style="white-space:nowrap">
									<div
										class="fieldcontain ${hasErrors(bean: address, field: 'address.userDefined1', 'error')} ">
										<label for="userDef1"> 
										<g:userDefinedFieldLabel winId="GRUPA" datawindowId ="dw_grupa_de" userDefineTextName="USER_DEF_1_t"
													defaultText="User Defined 1"   />
										
						
										</label>										
										<g:secureTextField maxlength="30"
											name="address.${i}.userDefined1" 
											tableName="GROUP_ADDRESS" attributeName="userDef1" 
											value="${address?.userDefined1}" style="width:150px">
											</g:secureTextField>
											</div>
								</td>
								<td style="white-space:nowrap">
									<div
										class="fieldcontain ${hasErrors(bean: address, field: 'address.userDate1', 'error')} ">
										<label for="userDate1"> 
									<g:userDefinedFieldLabel winId="GRUPA" datawindowId ="dw_grupa_de" userDefineTextName="user_date_1_t"
													defaultText="User Date 1"   />
														
										</label>
										<g:secureGrailsDatePicker
											name="address.${ i }.userDate1"
											tableName="GROUP_ADDRESS" attributeName="userDate1" precision="day" noSelection="['':'']"
											value="${address?.userDate1}" default="none">
										</g:secureGrailsDatePicker>
									</div>
								</td>
							</tr>
							<tr>
								<td style="white-space:nowrap">
									<div
										class="fieldcontain ${hasErrors(bean: address, field: 'address.userDefined2', 'error')} ">
										<label for="userDef2"> 
										<g:userDefinedFieldLabel winId="GRUPA" datawindowId ="dw_grupa_de" userDefineTextName="USER_DEF_2_t"
													defaultText="User Defined 2"   />
									
						
										</label>											
											<g:secureTextField maxlength="30"
											name="address.${i}.userDefined2"
											tableName="GROUP_ADDRESS" attributeName="userDef2" 
											value="${address?.userDefined2}" style="width:150px">
											</g:secureTextField>
									</div>
								</td>
								<td style="white-space:nowrap">
									<div
										class="fieldcontain ${hasErrors(bean: address, field: 'address.userDate2', 'error')} ">
										<label for="userDate2"> <g:userDefinedFieldLabel winId="GRUPA" datawindowId ="dw_grupa_de" userDefineTextName="user_date_2_t"
													defaultText="User Date 2"   />										
										</label>										
										<g:secureGrailsDatePicker
											name="address.${ i }.userDate2"
											tableName="GROUP_ADDRESS" attributeName="userDate2" precision="day" noSelection="['':'']"
											value="${address?.userDate2}" default="none">
										</g:secureGrailsDatePicker>
									</div>
								</td>
							</tr>
							<tr>
								<td style="white-space:nowrap">
									<div
										class="fieldcontain ${hasErrors(bean: address, field: 'address.userDefined3', 'error')} ">
										<label for="userDef3"> 
										<g:userDefinedFieldLabel winId="GRUPA" datawindowId ="dw_grupa_de" userDefineTextName="USER_DEF_3_t"
													defaultText="User Defined 3"   />
										</label>
										<g:secureTextField maxlength="30"
											name="address.${i}.userDefined3"
											tableName="GROUP_ADDRESS" attributeName="userDef3" 
											value="${address?.userDefined3}" style="width:150px">
											</g:secureTextField>
									</div>
								</td>
								<td style="white-space:nowrap">
									<div
										class="fieldcontain ${hasErrors(bean: address, field: 'address.userDate3', 'error')} ">
										<label for="userDate3"> <g:userDefinedFieldLabel winId="GRUPA" datawindowId ="dw_grupa_de" userDefineTextName="user_date_3_t"
													defaultText="User Date 3"   />
						
										</label>
										<g:secureGrailsDatePicker
											name="address.${ i }.userDate3"
											tableName="GROUP_ADDRESS" attributeName="userDate3" precision="day" noSelection="['':'']"
											value="${address?.userDate3}" default="none">
										</g:secureGrailsDatePicker>
									</div>
								</td>
							</tr>
							<tr>
								<td style="white-space:nowrap">
									<div
										class="fieldcontain ${hasErrors(bean: address, field: 'address.userDefined4', 'error')} ">
										<label for="userDef4"> <g:userDefinedFieldLabel winId="GRUPA" datawindowId ="dw_grupa_de" userDefineTextName="USER_DEF_4_t"
													defaultText="User Defined 4"   />
						
										</label>											
										<g:secureTextField maxlength="30"
											name="address.${i}.userDefined4"
											tableName="GROUP_ADDRESS" attributeName="userDef4" 
											value="${address?.userDefined4}" style="width:150px">
											</g:secureTextField>
									</div>
								</td>
								<td style="white-space:nowrap">
									<div
										class="fieldcontain ${hasErrors(bean: address, field: 'address.userDate4', 'error')} ">
										<label for="userDate4"> <g:userDefinedFieldLabel winId="GRUPA" datawindowId ="dw_grupa_de" userDefineTextName="user_date_4_t"
													defaultText="User Date 4"   />
										</label>
										<g:secureGrailsDatePicker
											name="address.${ i }.userDate4"
											tableName="GROUP_ADDRESS" attributeName="userDate4" precision="day" noSelection="['':'']"
											value="${address?.userDate4}" default="none">
										</g:secureGrailsDatePicker>
									</div>
								</td>
							</tr>
							<tr>
								<td style="white-space:nowrap">
									<div
										class="fieldcontain ${hasErrors(bean: address, field: 'address.userDefined5', 'error')} ">
										<label for="userDef5"> <g:userDefinedFieldLabel winId="GRUPA" datawindowId ="dw_grupa_de" userDefineTextName="USER_DEF_5_t"
													defaultText="User Defined 5"   />
						
										</label>
										<g:secureTextField maxlength="30"
											name="address.${i}.userDefined5"
											tableName="GROUP_ADDRESS" attributeName="userDef5" 
											value="${address?.userDefined5}" style="width:150px">
											</g:secureTextField>
									</div>
								</td>
								<td style="white-space:nowrap">
									<div
										class="fieldcontain ${hasErrors(bean: address, field: 'address.userDate5', 'error')} ">
										<label for="userDate5"> <g:message
												code="GRUPA.user_date_5_t" default="User Date 5 :" />
						
										</label>
										<g:secureGrailsDatePicker
											name="address.${ i }.userDate5"
											tableName="GROUP_ADDRESS" attributeName="userDate5" precision="day" noSelection="['':'']"
											value="${address?.userDate5}" default="none">
										</g:secureGrailsDatePicker>
									</div>
								</td>
							</tr>
						</table>
				</div>
			</td>
		</tr>	
	</g:each>
</table>
<div id="addGroupPlaceHolder">
</div>