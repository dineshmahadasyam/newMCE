<%@ page import="com.dell.diamond.fms.AgentMasterCommand"%>
<g:set var="appContext" bean="grailsApplication"/>

<link rel="stylesheet" href="${resource(dir: 'css', file: 'member_pages.css')}" type="text/css">

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

	function addAddress() {		
		window.location.assign('<g:createLinkTo dir="/agentMaster/addAgentAddress"/>?seqAgentId=${agentMasterInstance?.seqAgentId }&agentId=${agentMasterInstance?.agentId }&agentType=${agentMasterInstance?.agentType}');
	}
	
</script>

<input type="hidden" name="editType" value="ADDRESS" />
<input type="hidden" name="seqAgentId" value="${agentMasterInstance?.seqAgentId}" />
<input type="hidden" name="agentId" value="${agentMasterInstance?.agentId}" />
<input type="hidden" name="agentType" value="${agentMasterInstance?.agentType}" />
<div id="${agentMasterInstance?.seqAgentId}">
	<br/>
	<div id="addAddressDiv" style="padding-bottom:10px;">
			<input type="button" name="addAddressButton" class="load" value="Add Address"  onClick="addAddress()">
	</div>
	Agent/Broker Address Records for Agent Id (${agentMasterInstance?.agentId}) 
	<br/>
	<br/>
	<table border="1" id="report">
		<tr class="head">
			<th>&nbsp;&nbsp;Select</th>
			<th>Effective Date</th>
			<th>Term Date</th>
			<th>Address Type</th>
			<th>Address Line 1</th>
			<th>City</th>
			<th>County</th>
			<th>State</th>
			<th>Zip Code</th>
			<th>Country</th>
		</tr>
		<g:each in="${agentMasterInstance?.agentAddresses }" var="agentAddress" status="i">
			<input type="hidden" name="seq_address_id_${i}" value="${agentAddress?.seqAgentAddress }">
			<input type="hidden" name="agentAddress.${i}.iterationCount" value="${i}">
			<tr class="${(i % 2) == 0 ? 'even' : 'odd'}">
				<td>
					<input type="radio" name="addressId" class="selectradio" value="${agentAddress?.seqAgentAddress}">
				</td>
				<td class="clickme">
					<g:formatDate format="yyyy-MM-dd" date="${agentAddress.effectiveDate}" />
				</td>
				<td class="clickme">
					<g:formatDate format="yyyy-MM-dd" date="${agentAddress.termDate}" />
				</td>
				<td class="clickme">
					${agentAddress?.addressType}
				</td>
				<td class="clickme">
					${agentAddress?.addressLine1}
				</td>
				<td class="clickme">
					${agentAddress?.city}
				</td>
				<td class="clickme">
					${agentAddress?.county}
				</td>
				<td class="clickme">
					${agentAddress?.state}
				</td>
				<td class="clickme"><g:if
						test="${agentAddress?.zipCode?.length() > 5}">
						${agentAddress?.zipCode?.with {length()? getAt(0..4):''}}-${agentAddress?.zipCode?.with {length()? getAt(5..length()-1):''}}
					</g:if> <g:elseif test="${agentAddress?.zipCode?.length() == 5}">
						${agentAddress?.zipCode?.with {length()? getAt(0..4):''}}
					</g:elseif> <g:else></g:else>
				</td>
				<td class="clickme">
					${agentAddress?.country}
				</td>
			</tr>

			<tr class="hideme" id="rowToClone2">
				<td colspan="13">
					<div class="divContent" id="${agentAddress?.seqAgentAddress}">
						<table class="report1" border="0" style="table-layout: fixed;">
							<tr>
								<td class="tdnoWrap" style="white-space: nowrap">
									<div class="fieldcontain ${hasErrors(bean: agentAddress, field: 'addressLine1', 'error')} ">
										<label for="addressLine1"> 
											<g:message code="agentAddress.addressLine1.label" default="Address Line 1 :" />
											<span class="required-indicator">*</span>
										</label>
										<g:secureTextField name="agentAddress.${i}.addressLine1" title="The first Address line" maxlength="60" 
											value="${agentAddress?.addressLine1}" tableName="AGENT_ADDRESS" attributeName="addressLine1"></g:secureTextField>
									</div>
								</td>							
								<td class="tdnoWrap" style="white-space: nowrap">
									<div class="fieldcontain ${hasErrors(bean: agentAddress, field: 'addressLine2', 'error')} ">
										<label for="addressLine2"> 
											<g:message code="agentAddress.addressLine2.label" default="Address Line 2 :" />
										</label>
										<g:secureTextField name="agentAddress.${i}.addressLine2" title="The 2nd Address line" maxlength="60" 
											value="${agentAddress?.addressLine2}" tableName="AGENT_ADDRESS" attributeName="addressLine2"></g:secureTextField>
									</div>
								</td>
							</tr>
							<tr>
								<td class="tdnoWrap" style="white-space: nowrap">
									<div class="fieldcontain ${hasErrors(bean: agentAddress, field: 'city', 'error')} ">
										<label for="lastName"> 
											<g:message code="agentAddress.city.label" default="City :" />
											<span class="required-indicator">*</span>
										</label>
											<g:secureTextField name="agentAddress.${i}.city" value="${agentAddress?.city}" title="The City" maxlength="30" 
											tableName="AGENT_ADDRESS" attributeName="city"></g:secureTextField>
									</div>
								</td>	
								<td class="tdnoWrap" style="white-space: nowrap">
									<div class="fieldcontain ${hasErrors(bean: agentAddress, field: 'state', 'error')} ">
										<label for="state"> 
											<g:message code="agentAddress.state.label" default="State :" />
											<span class="required-indicator">*</span> 
										</label>
										<g:secureComboBox name="agentAddress.${i}.state"  optionKey="stateCode"
												tableName="AGENT_ADDRESS" attributeName="state" 
												optionValue="stateName" id="agentAddress.${i}.state" from="${states}"
												noSelection="['':'-- Select a State --']"
												value="${agentAddress?.state}">
										</g:secureComboBox>
									</div>
								</td>								
							</tr>
							<tr>
								<td class="tdnoWrap" style="white-space: nowrap">
									<div class="fieldcontain ${hasErrors(bean: agentAddress, field: 'county', 'error')} ">
										<label for="county"> 
											<g:message code="agentAddress.county.label" default="County :" />
										</label>
										<g:secureTextField name="agentAddress.${i}.county" maxlength="30" 
											value="${agentAddress?.county}" tableName="AGENT_ADDRESS" title="The County"
											attributeName="county"></g:secureTextField>
									</div>
								</td>
								<td class="tdnoWrap" style="white-space: nowrap">
									<div class="fieldcontain ${hasErrors(bean: agentAddress, field: 'country', 'error')} ">
										<label for="country"> 
											<g:message code="agentAddress.country.label" default="Country :" />
										</label>
										<g:secureTextField name="agentAddress.${i}.country" maxlength="30" 
												value="${agentAddress?.country}" tableName="AGENT_ADDRESS" title="The Country"
												attributeName="country"></g:secureTextField>
									</div>
								</td>					
							</tr>
							<tr>	
								<td class="tdnoWrap" style="white-space: nowrap">
									<div class="fieldcontain ${hasErrors(bean: agentAddress, field: 'zipCode', 'error')} ">
										<label for="zipCode"> 
											<g:message code="agentAddress.zipCode.label" default="Zip Code :" />
											<span class="required-indicator">*</span>
										</label>
										<g:secureTextField name="agentAddress.${i}.zipCode"  title="5 or 9 digit Zip Code. Enter numbers only" 
										value="${agentAddress?.zipCode}" tableName="AGENT_ADDRESS" class="maskZip"
										attributeName="zipCode"></g:secureTextField>
									</div>
								</td>					
								<td class="tdnoWrap" style="white-space: nowrap">
									<div class="fieldcontain ${hasErrors(bean: agentAddress, field: 'addressType', 'error')} ">
										<label for="addressType"> 
											<g:message code="agentAddress.addressType.label" default="Address Type :" />
											<span class="required-indicator">*</span>
										</label>
										<g:secureSystemCodeToken
													tableName="AGENT_ADDRESS" attributeName="addressType"
													systemCodeType="AGENTAGENCYADDR" languageId="0"
													htmlElelmentId="agentAddress.${i}.addressType"
													blankValue="Address Type" 
													defaultValue="${agentAddress?.addressType}" 
													value="${agentAddress?.addressType}"
													width="135px">
										</g:secureSystemCodeToken>
									</div>
								</td>	
							</tr>  
							<tr>
								<td class="tdnoWrap" style="white-space: nowrap">
									<div class="fieldcontain ${hasErrors(bean: agentAddress, field: 'effectiveDate', 'error')} ">
										<label for="effectiveDate"> 
											<g:message code="agentAddress.effectiveDate.label" default="Effective Date :" />
											<span class="required-indicator">*</span>
										</label>
										<g:secureGrailsDatePicker
										name="agentAddress.${i}.effectiveDate" 
										title ="The Effective date of the Address"
										tableName="AGENT_ADDRESS" attributeName="effectiveDate" precision="day" noSelection="['':'']"
										value="${agentAddress?.effectiveDate}" default="none"></g:secureGrailsDatePicker>
									</div>
								</td>						
								<td class="tdnoWrap" style="white-space: nowrap">
									<div class="fieldcontain ${hasErrors(bean: agentAddress, field: 'termDate', 'error')} ">
										<label for="termDate"> 
											<g:message code="agentAddress.termDate.label" default="Term Date :" />
										</label>
										<g:secureGrailsDatePicker
										name="agentAddress.${i}.termDate" 
										title ="The Termination date of the Address"
										tableName="AGENT_ADDRESS" attributeName="termDate" precision="day" noSelection="['':'']"
										value="${agentAddress?.termDate}" default="none"></g:secureGrailsDatePicker>
									</div>
								</td>
							</tr>
							<tr>
								<td class="tdnoWrap" style="white-space: nowrap">
									<div class="fieldcontain ${hasErrors(bean: agentAddress, field: 'termReason', 'error')} ">
										<label for="termReason"> 
											<g:message code="agentAddress.termReason.label" default="Term Reason :" />
										</label>
										<g:secureTextField maxlength="5" title="The Termination Reason of the Address"
											name="agentAddress.${i}.termReason" 
											tableName="AGENT_ADDRESS" attributeName="termReason" 
											value="${agentAddress?.termReason}"></g:secureTextField>
											<input type="hidden" id="reasonCodeTypeHidden" name ="reasonCodeTypeHidden" value="TM" />
											<img width="25" height="25" style="float:none;vertical-align:bottom" class="magnifying"
											src="${resource(dir: 'images', file: 'Search-icon.png')}"
											onclick="lookup('agentAddress.${i}.termReason', 'com.perotsystems.diamond.dao.cdo.ReasonCodeMaster','reasonCode','reasonCodeTypeHidden','reasonCodeType')">
									</div>
								</td>
							</tr>
							<tr>
								<td>&nbsp;</td>
								<td>&nbsp;</td>
							</tr>
							<tr>
								<td class="tdnoWrap" style="white-space: nowrap" colspan="2">
									User Defined Information: <hr>
								</td>
							</tr>
							<tr>
								<td class="tdnoWrap" style="white-space: nowrap">
									<div class="fieldcontain ${hasErrors(bean: agentAddress, field: 'userDefined1', 'error')} ">
										<label for="userDefined1"> 
											<g:userDefinedFieldLabel winId="AGNTA" datawindowId ="AGNTA" userDefineTextName="user_defined_1_t" defaultText="User Defined 1 "/>
										</label>
										<g:secureTextField name="agentAddress.${i}.userDefined1" maxlength="60" 
											value="${agentAddress?.userDefined1}" tableName="AGENT_ADDRESS" 
											attributeName="userDefined1"></g:secureTextField>
									</div>
								</td>							
								<td class="tdnoWrap" style="white-space: nowrap">
									<div class="fieldcontain ${hasErrors(bean: agentAddress, field: 'userDefined2', 'error')} ">
										<label for="userDefined2"> 
											<g:userDefinedFieldLabel winId="AGNTA" datawindowId ="AGNTA" userDefineTextName="user_defined_2_t" defaultText="User Defined 2 "/>
										</label>
										<g:secureTextField name="agentAddress.${i}.userDefined2" maxlength="60" 
											value="${agentAddress?.userDefined2}" tableName="AGENT_ADDRESS" attributeName="userDefined2"></g:secureTextField>
									</div>
								</td>
							</tr>
							<tr>				
								<td class="tdnoWrap" style="white-space: nowrap">
									<div class="fieldcontain ${hasErrors(bean: agentAddress, field: 'userDate1', 'error')} ">
										<label for="userDate1"> 
											<g:userDefinedFieldLabel winId="AGNTA" datawindowId ="AGNTA" userDefineTextName="user_date_1_t" defaultText="User Date 1 "/>
										</label>
										<g:secureGrailsDatePicker
										name="agentAddress.${i}.userDate1" 
										tableName="AGENT_ADDRESS" attributeName="userDate1" precision="day" noSelection="['':'']"
										value="${agentAddress?.userDate1}" default="none"></g:secureGrailsDatePicker>
									</div>
								</td>
								<td class="tdnoWrap" style="white-space: nowrap">
									<div class="fieldcontain ${hasErrors(bean: agentAddress, field: 'userDate2', 'error')} ">
										<label for="userDate2"> 
											<g:userDefinedFieldLabel winId="AGNTA" datawindowId ="AGNTA" userDefineTextName="user_date_2_t" defaultText="User Date 2 "/>
										</label>
										<g:secureGrailsDatePicker
											name="agentAddress.${i}.userDate2" 
											tableName="AGENT_ADDRESS" attributeName="userDate2" precision="day" noSelection="['':'']"
											value="${agentAddress?.userDate2}" default="none"></g:secureGrailsDatePicker>
									</div>
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