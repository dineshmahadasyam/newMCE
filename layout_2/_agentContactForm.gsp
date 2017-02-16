<%@ page import="com.dell.diamond.fms.AgentMasterCommand"%>
<g:set var="appContext" bean="grailsApplication"/>

<link rel="stylesheet" href="${resource(dir: 'css', file: 'member_pages.css')}" type="text/css">

<style type="text/css">
	.deleteButton {
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
	}.deleteButton:hover {
		background-color:#dfdfdf;
	}.deleteButton:active {
		position:relative;
		top:1px;
	}
</style>

<script type="text/javascript" src="${resource(dir: 'js', file: 'jquery.maskedinput.js')}"></script>
<script type="text/javascript" src="${resource(dir: 'js', file: 'commonfunctions.js')}"></script>
<script type="text/javascript" src="${resource(dir: 'js', file: 'jquery.alphanum.js')}"></script>
<script type="text/javascript" src="${resource(dir: 'js', file: 'jquery.validate.js')}"></script>
<script type="text/javascript">

	//<![CDATA[ 
	$(window).load(function() {
		
		$('.hideme').find('div').hide();
		
		$('.clickme').click(function() {

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
		

	});//]]>

	function addContact() {		
		window.location.assign('<g:createLinkTo dir="/agentMaster/addAgentContact"/>?seqAgentId=${agentMasterInstance?.seqAgentId}&agentId=${agentMasterInstance?.agentId}&agentType=${agentMasterInstance?.agentType}');
}

	function deleteContact(seqId)
	{
		document.getElementById('seqContactId').value = seqId
		
	    	if (confirm("Are you sure you want to delete this Contact?") == true) 
			 {
		    	return true;
		     } 
		    else 
			{
		    	return false;
		    }
	}
	
</script>

<input type="hidden" name="editType" value="CONTACT" />
<input type="hidden" name="seqAgentId" value="${agentMasterInstance?.seqAgentId }" />
<input type="hidden" name="agentId" value="${agentMasterInstance?.agentId}" />
<input type="hidden" name="agentType" value="${agentMasterInstance?.agentType}" />
<input type="hidden" name="seqContactId" id="seqContactId" value="" />

<div id="${agentMasterInstance?.seqAgentId}">
	<br/>
	<div id="addContactDiv" style="padding-bottom:10px;">
			<input type="button" name="addContactButton" class="load" value="Add Contact"  onClick="addContact()">
	</div>
	Agent/Broker Contact Records for Agent Id (${agentMasterInstance?.agentId}) 
	<br/>
	<br/>
	<table border="1" id="report">
		<tr class="head">
			<th>&nbsp;&nbsp;Select</th>
			<th>Contact Name</th>
			<th>Contact Title</th>
			<th>Phone Number</th>
			<th>Extension</th>
			<th>Email</th>
		</tr>
		<g:each in="${agentMasterInstance?.agentContacts }" var="agentContact" status="i">
			<input type="hidden" name="seq_contact_id_${i}" value="${agentContact?.seqAgentContact }">
			<input type="hidden" name="agentContact.${i}.iterationCount" value="${i}">
			<tr class="${(i % 2) == 0 ? 'even' : 'odd'}">
				<td>
					<input type="radio" name="contactId"  class="selectradio" value="${agentContact?.seqAgentContact}">
				</td>
				<td class="clickme">
					${agentContact?.contactName}
				</td>
				<td class="clickme">
					${agentContact?.contactTitle}
				</td>
				<td class="clickme">
					<g:if test="${agentContact?.phoneNumber?.length() == 10}">${agentContact?.phoneNumber.with {length()? getAt(0..2):''}}-${agentContact?.phoneNumber.with {length()? getAt(3..5):''}}-${agentContact?.phoneNumber.with {length()? getAt(6..length()-1):''}}</g:if>
					<g:else>${agentContact?.phoneNumber}</g:else>
				</td>
				<td class="clickme">
					${agentContact?.extension}
				</td>
				<td class="clickme">
					${agentContact?.emailAddress}
				</td>
			</tr>

			<tr class="hideme" id="rowToClone2">
				<td colspan="13">
					<div class="divContent" id="${agentContact?.seqAgentContact}">
						<table class="report1" border="0" style="table-layout: fixed;">
							<tr>
								<td class="tdnoWrap" style="white-space: nowrap">
									<div class="fieldcontain ${hasErrors(bean: agentContact, field: 'contactName', 'error')} ">
										<label for="contactName"> 
											<g:message code="agentContact.contactName.label" default="Name :" />
											<span class="required-indicator">*</span>
										</label>
										<g:secureTextField name="agentContact.${i}.contactName" title="The Contact Name" maxlength="40" 
											value="${agentContact?.contactName}" tableName="AGENT_CONTACT" attributeName="contactName"></g:secureTextField>
									</div>
								</td>							
								<td class="tdnoWrap" style="white-space: nowrap">
									<div class="fieldcontain ${hasErrors(bean: agentContact, field: 'contactTitle', 'error')} ">
										<label for="contactTitle"> 
											<g:message code="agentContact.contactTitle.label" default="Title :" />
										</label>
										<g:secureCdoSelectBox 
											cdoClassName="com.perotsystems.diamond.dao.cdo.ContactTitleMaster"
											tableName="AGENT_CONTACT" 
											attributeName="contactTitle"
											cdoAttributeWhereValue="S"
											cdoAttributeWhere="titleType"
											cdoAttributeSelect="contactTitle"
											cdoAttributeSelectDesc="description"
											languageId="0"
											htmlElelmentId="agentContact.${i}.contactTitle"
											defaultValue="${agentContact?.contactTitle}"
											value="${agentContact?.contactTitle}"
											blankValue="Title" 
											width="150px">
										</g:secureCdoSelectBox>
									</div>
								</td>
							</tr>
							<tr>
							<td class="tdnoWrap">
								<div class="fieldcontain ${hasErrors(bean: agentContact, field: 'phoneNumber', 'error')} ">
									<label for="phoneNumber"> 
										<g:message code="agentContact.phoneNumber.label" default="Phone Number :" />
											<span class="required-indicator">*</span>
									</label>
									<g:secureTextField name="agentContact.${i}.phoneNumber" value="${agentContact?.phoneNumber}"  class="maskPhoneNumber"
										 tableName="AGENT_CONTACT" attributeName="phoneNumber" title="The Primary Phone Number" maxlength="40" />
									
								</div>
							</td>
							<td class="tdnoWrap">
								<div class="fieldcontain ${hasErrors(bean: agentContact, field: 'extension', 'error')} ">
									<label for="extension"> 
										<g:message code="agentContact.extension.label" default="Extension :" />
									</label>
									<g:secureTextField name="agentContact.${i}.extension" value="${agentContact?.extension}" class="maskExtension"  
										  tableName="AGENT_CONTACT" attributeName="extension" title="The Extension for the Phone Number" maxlength="6" />
								</div>
							</td>
						</tr>
						<tr>
							<td class="tdnoWrap">
								<div class="fieldcontain ${hasErrors(bean: agentContact, field: 'emailAddress', 'error')} ">
									<label for="emailAddress"> 
										<g:message code="agentContact.emailAddress.label" default="Email Address :" />
									</label>
									<g:secureTextField name="agentContact.${i}.emailAddress" value="${agentContact?.emailAddress}"  
										  tableName="AGENT_CONTACT" attributeName="emailAddress" title="The Email Address" maxlength="100" />
								</div>
							</td>
							<td class="tdnoWrap">
								<div class="fieldcontain ${hasErrors(bean: agentContact, field: 'faxNumber', 'error')} ">
									<label for="faxNumber"> 
										<g:message code="agentContact.faxNumber.label" default="Fax Number :" />
									</label>
									<g:secureTextField name="agentContact.${i}.faxNumber" value="${agentContact?.faxNumber}"  class="maskPhoneNumber"
										  tableName="AGENT_CONTACT" attributeName="faxNumber" title="The Fax Number" maxlength="40" />
								</div>
							</td>
						</tr>
						<tr>
							<td class="tdnoWrap">
								<div class="fieldcontain ${hasErrors(bean: agentContact, field: 'businessPhone', 'error')} ">
									<label for="businessPhone"> 
										<g:message code="agentContact.businessPhone.label" default="Business Phone :" />
									</label>
									<g:secureTextField name="agentContact.${i}.businessPhone" value="${agentContact?.businessPhone}" class="maskPhoneNumber" 
										  tableName="AGENT_CONTACT" attributeName="businessPhone" title="The Business Phone Number" maxlength="40" />
								</div>
							</td>
							<td class="tdnoWrap">
								<div class="fieldcontain ${hasErrors(bean: agentContact, field: 'mobilePhone', 'error')} ">
									<label for="mobilePhone"> 
										<g:message code="agentContact.mobilePhone.label" default="Mobile Phone :" />
									</label>
									<g:secureTextField name="agentContact.${i}.mobilePhone" value="${agentContact?.mobilePhone}"  class="maskPhoneNumber" 
										  tableName="AGENT_CONTACT" attributeName="mobilePhone" title="The Mobile Phone Number" maxlength="40" />
								</div>
							</td>
						</tr>
						<tr><td>&nbsp;</td></tr>
						<tr>
							<td class="tdnoWrap" colspan="2">User Defined Information :
								<hr>
							</td>
						</tr>
						<tr>
							<td class="tdnoWrap">
								<div
									class="fieldcontain ${hasErrors(bean: agentContact, field: 'userDefined1', 'error')} ">
									<label for="userDefined1">
										<g:userDefinedFieldLabel winId="AGNTC" datawindowId ="AGNTC" userDefineTextName="user_defined_1_t" defaultText="User Defined 1 "/>
									</label>
									<g:secureTextField name="agentContact.${i}.userDefined1" tableName="AGENT_CONTACT" attributeName="userDefined1"
									maxlength="60"  value="${agentContact?.userDefined1}" />
								</div>
							</td>
							<td class="tdnoWrap">
								<div
									class="fieldcontain ${hasErrors(bean: agentContact, field: 'userDefined2', 'error')} ">
									<label for="userDefined2">
										<g:userDefinedFieldLabel winId="AGNTC" datawindowId ="AGNTC" userDefineTextName="user_defined_2_t" defaultText="User Defined 2 "/> 
									</label>
									<g:secureTextField name="agentContact.${i}.userDefined2" tableName="AGENT_CONTACT" attributeName="userDefined2"
									maxlength="60"  value="${agentContact?.userDefined2}" />
								</div>
							</td>
						</tr>
						<tr>
							<td class="tdnoWrap">
								<div
									class="fieldcontain ${hasErrors(bean: agentContact, field: 'userDefinedDate1', 'error')} ">
									<label for="userDefinedDate"> 
										<g:userDefinedFieldLabel winId="AGNTC" datawindowId ="AGNTC" userDefineTextName="user_date_1_t" defaultText="User Date 1 "/>
									</label>
									<g:secureGrailsDatePicker
											name="agentContact.${i}.userDate1" 
											tableName="AGENT_CONTACT" attributeName="userDate1" precision="day" noSelection="['':'']"
											value="${agentContact?.userDate1}" default="none"></g:secureGrailsDatePicker>
								</div>
							</td>
							<td class="tdnoWrap">
								<div
									class="fieldcontain ${hasErrors(bean: agentContact, field: 'userDefinedDate2', 'error')} ">
									<label for="userDefinedDate"> 
										<g:userDefinedFieldLabel winId="AGNTC" datawindowId ="AGNTC" userDefineTextName="user_date_2_t" defaultText="User Date 2 "/>
									</label>
									<g:secureGrailsDatePicker
											name="agentContact.${i}.userDate2" 
											tableName="AGENT_CONTACT" attributeName="userDate2" precision="day" noSelection="['':'']"
											value="${agentContact?.userDate2}" default="none"></g:secureGrailsDatePicker>
								</div>
							</td>
						</tr>
						<tr>
							<td class="tdnoWrap" style="white-space: nowrap"></td>
						</tr>
						<tr>
							<td class="tdnoWrap" style="white-space: nowrap"></td>
						</tr>
						<tr>
								<td colspan="2"><g:actionSubmit class="deleteButton" action="deleteContact" value="Delete" onclick="return deleteContact(${agentContact?.seqAgentContact});" />
								</td>
						</tr>
							<tr>
								<td class="tdnoWrap" style="white-space: nowrap">
								</td>
							</tr>
						</table>
			
					</div>
				</td>
			</tr>
		</g:each>
	</table>
</div>