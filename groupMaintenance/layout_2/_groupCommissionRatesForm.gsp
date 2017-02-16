<%@ page import="com.perotsystems.diamond.bom.PremiumMaster"%>

<meta name="layout" content="main_2">
<g:set var="appContext" bean="grailsApplication"/>
<script type="text/javascript" src="${resource(dir: 'js', file: 'jquery.alphanum.js')}"></script>

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
		$(".alphaNumOnly").alphanum({
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
</script>
<script>
	var addRowClicked = false
	function cloneRow() {
		var divObjSrc = document.getElementById('newMemberEligibility')
		var divObjDest = document.getElementById('addGroupPlaceHolder')
		divObjDest.innerHTML = divObjSrc.innerHTML
		var divObj = document.getElementById('addAddressDiv')
		divObj.style.display = "none"
		var selectObj = document.getElementById("memberIdSelectList")
		selectObj.disabled = true;
		var divObjSrc = document.getElementById('releaseSelect')
		divObjSrc.style.display = "block"
		addRowClicked = true
	}
	var previousDivObj
	function releaseMemberSelection() {

		var result = confirm(
				"Navigating to a new Member would result in the loss of data of the newly added member, Please confirm ",
				"Yes - Change Member ", "No - Stay on this page")
		if (result) {
			addRowClicked = false;
			var selectObj = document.getElementById("memberIdSelectList")
			selectObj.disabled = false;
			var divObjSrc = document.getElementById('releaseSelect')
			divObjSrc.style.display = "none"
			var divObjDest = document.getElementById('addGroupPlaceHolder')
			divObjDest.innerHTML = "&nbsp;"
			var divObj = document.getElementById('addAddressDiv')
			divObj.style.display = "block"
			var resetButton = document.getElementById("resetButton")
			resetButton.click()
		}
	}
	function showAddress(selectedObj) {
		var hiddenObj = document.getElementById("editMemberDBID")
		if (!addRowClicked) {
			
			var selectedValue = selectedObj.options[selectedObj.selectedIndex].value
			var addressDivObj = document.getElementById(selectedValue)
			var addAddressDivObj = document.getElementById("addAddressDiv")
			hiddenObj.value = selectedValue
			if (addressDivObj != null) {
				if (previousDivObj != null) {
					previousDivObj.style.display = "none"
				}
				addressDivObj.style.display = "block"
				addAddressDivObj.style.display = "block"
				previousDivObj = addressDivObj
			} else {
				addAddressDivObj.style.display = "none"
			}
		} else {
			var result = confirm(
					"Navigating to a new Member would result in the loss of data of the newly added member, Please confirm ",
					"Yes - Change Member ", "No - Stay on this page")
			if (result) {
				addRowClicked = false;
				showAddress(selectedObj)
			} else {

			}
		}
	}

	function addGroupRate(){
		var seqPremId = document.getElementById("seqPremId").value
		var seqGroupId = document.getElementById("seqGroupId").value
		var groupId = "${groupMasterInstance?.groupId}";
		var groupDBId = "${groupMasterInstance?.groupDBId}";
		if(seqPremId == "dummy"){
			alert("Please select a Detail Record")
			return false
			}
		
		window.location.assign('<g:createLinkTo dir="/groupMaintenance/addGroupCommRate"/>?seqPremId='+seqPremId+'&seqGroupId='+seqGroupId+
				'&groupId='+groupId+'&groupDBId='+groupDBId);
	}

	function populateseqPremId(seqPremId, seqGroupId){
		document.getElementById("seqPremId").value = seqPremId;   
		document.getElementById("seqGroupId").value = seqGroupId;
		}
	
</script>

<br></br>
<g:hiddenField name="groupDBId" value="${groupMasterInstance?.groupDBId}" />
<g:hiddenField name="groupId" value="${groupMasterInstance?.groupId}" />
<input type="hidden" name="editType" value="COMMRATES" />
<input type="hidden" name="seqGroupId" id ="seqGroupId" value="" />
<input type="hidden" id="editMemberDBID" name="editMemberDBID" value="0" />
<input type="hidden" id="seqPremId" name="seqPremId" value="" />
<input type="hidden" id="isFirst" value="true">
<table>
	<tr>
		<td><select id="memberIdSelectList" name="memberIdlist"
			onChange="showAddress(this)"
			size="${ premiumMasterMap?.keySet()?.size() +2}" style="width: 100%;;background-color: #C7DDEE;">
				<option value="dummy" onclick="populateseqPremId('dummy')">-- Select a Detail --</option>
				<g:each in="${premiumMasterMap?.keySet() }" status="idCount"
					var="seqPremId">
					<% PremiumMaster premMaster = premiumMasterMap.get(seqPremId) %>
					<% seqGroupId =  premMaster.getSeqGroupId()%>
					<option value="${seqPremId }"  
					${"0".equals(""+ idCount)?'selected':'' }
					onclick="populateseqPremId('${ premMaster.seqPremId}', '${ premMaster.seqGroupId}')">
						<g:if test="${"0".equals(""+ idCount) }">
							<script type="text/javascript">
								document.getElementById("seqPremId").value = ${ premMaster.seqPremId};   
								document.getElementById("seqGroupId").value = ${ premMaster.seqGroupId};
							</script>
						</g:if>
						<g:if test="${premMaster.seqPremId }">
							${'P'.equals(premMaster.recordType) ? 'Plan' : 'Rider'}
						</g:if>
						-
						<g:if test="${premMaster.seqPremId }">
							${premMaster.planRiderCode }
						</g:if>
						-
						<g:if test="${premMaster.seqPremId }">
							${premMaster.lineOfBusiness}
						</g:if>
					</option>
				</g:each>
		</select>	
		
		</td>
	</tr>
</table>
<table>
	<tr>
		<td>
			<div id="addAddressDiv" style="display: none">
				<input type="button" value="Add Row" name="addGroupCommsRateRecord"
					class="load" onClick="addGroupRate()">
			</div>
		</td>
		<td>
			<div id="releaseSelect" style="display: none">
				<input type="button" value="Enable Group Rate Selection"
					class="load" name="enableGroupRateSelection" onClick="releaseMemberSelection()">
			</div>
		</td>
	</tr>
</table>
<br />
<div id="dummy">&nbsp;</div>
<g:each in="${agencyGrpCommRatesMap.keySet() }" status="idCount" var="seqPremId">

	<div id="${seqPremId}" style="display: none">
		<table border="1" id="report">
			<tr class="head">
				<th>&nbsp;&nbsp;Effective Date</th>
				<th>Term Date</th>
				<th>Rate Schedule</th>
				<th>Calc Type</th>
				<th>Amount Type</th>
				<th>Override Amount</th>
			</tr>
			
			<g:each in="${agencyGrpCommRatesMap.get(seqPremId)}" status="i" var="agencyGrpCommsRate">
			
				<input type="hidden" name="seq_prem_id_${i}"
					value="${agencyGrpCommsRate.seqGrpCommsnId }">
				
				<input type="hidden"
					name="agencyGrpCommsRate.${i}.iterationCount"
					value="${i}">
				
				<input type="hidden"
					name="agencyGrpCommsRate.${i}.seqPremId"
					value="${agencyGrpCommsRate.seqPremId }">
					
				<input type="hidden"
					name="agencyGrpCommsRate.${i}.seqGrpCommsnId"
					value="${agencyGrpCommsRate.seqGrpCommsnId }">
				
				
				<tr class="${(i % 2) == 0 ? 'even' : 'odd'}">
					<td>
						<g:secureGrailsDatePicker 
							name="agencyGrpCommsRate.${i}.effectiveDate" disabled="disabled"
							tableName="AGENCY_GROUP_COMMS_RATES" attributeName="effectiveDate" precision="day" noSelection="['':'']"
							value="${agencyGrpCommsRate?.effectiveDate}" default="none"></g:secureGrailsDatePicker>
					</td>
					<td>
						<g:secureGrailsDatePicker
							name="agencyGrpCommsRate.${i}.termDate" 
							tableName="AGENCY_GROUP_COMMS_RATES" attributeName="termDate" precision="day" noSelection="['':'']"
							value="${agencyGrpCommsRate?.termDate}" default="none"></g:secureGrailsDatePicker>
							<input type="hidden" name="agencyGrpCommsRate.${i}.termDate" value="${agencyGrpCommsRate?.termDate}"></input>
						
					</td>
					<td style="white-space: nowrap">
						<g:secureTextField maxlength="15" readonly="${agencyGrpCommsRate.seqGrpCommsnId? "readonly":""}" 
							name="agencyGrpCommsRate.${i}.seqRateId" 
							tableName="AGENCY_GROUP_COMMS_RATES" attributeName="seqRateId" 
							value="${rateIdsMap?.get(agencyGrpCommsRate?.seqRateId).rateId}" ></g:secureTextField>
					</td>
					<td style="white-space: nowrap">
						<g:secureComboBox name="${i}.calcType" style="width: 150px" disabled="disabled" style="width:120px"
								tableName="AGENCY_GROUP_COMMS_RATES" attributeName="calcType" value="${agencyGrpCommsRate?.calcType}" disabled="disabled"
								from="${['' : '', 'I': 'I - Incentive' , 'C': 'C - Commission']}" optionValue="value" optionKey="key"></g:secureComboBox>
					</td>
					<td style="white-space: nowrap">
							<g:secureComboBox name="agencyGrpCommsRate.${i}.overrideAmtType" style="width:100px" disabled="disabled"
								tableName="AGENCY_GROUP_COMMS_RATES" attributeName="overrideAmtType" value="${agencyGrpCommsRate?.overrideAmtType}" disabled="disabled"
								from="${['' : '', 'A': 'A - Amount' , 'P': 'P - Percent']}" optionValue="value" optionKey="key"></g:secureComboBox>
							<input type="hidden" name="agencyGrpCommsRate.${i}.overrideAmtType" value="${agencyGrpCommsRate?.overrideAmtType }"></input>
						
					</td>
					
					<g:if test="${agencyGrpCommsRate?.seqGrpCommsnId}">
					   <g:if test="${(agencyGrpCommsRate?.overrideAmtType?.equalsIgnoreCase("A"))}">
					   <td style="white-space: nowrap;padding-left:15px;"> 
					     <span class="currencyinput" id="dollarSymbol">$
						   <g:secureTextField maxlength="30" disabled="disabled"
							name="agencyGrpCommsRate.${i}.overrideAmt" readonly = "readonly"
							tableName="AGENCY_GROUP_COMMS_RATES" attributeName="overrideAmt" 
							value="${agencyGrpCommsRate?.overrideAmt}" title="The Override Amount"></g:secureTextField>
						  </span>
						</td>  
					   </g:if>
					   <g:if test="${(agencyGrpCommsRate?.overrideAmtType?.equalsIgnoreCase("P"))}"> 
					    <td style="white-space: nowrap;padding-left:15px;">
					     <span class="currencyinput" id="dollarSymbol">%
						   <g:secureTextField maxlength="5" disabled="disabled"
							name="agencyGrpCommsRate.${i}.overrideAmt" readonly = "readonly"
							tableName="AGENCY_GROUP_COMMS_RATES" attributeName="overrideAmt" 
							value="${agencyGrpCommsRate?.overrideAmt}" title="The Override Amount"></g:secureTextField>
						  </span>
						  </td>
					   </g:if>
					   <g:if test="${(agencyGrpCommsRate?.overrideAmtType == null) || (agencyGrpCommsRate?.overrideAmtType.trim().length() == 0)}"> 
					    <td style="white-space: nowrap;padding-left:30px;">
					      <g:secureTextField maxlength="30" disabled="disabled"
							name="agencyGrpCommsRate.${i}.overrideAmt" readonly = "readonly"
							tableName="AGENCY_GROUP_COMMS_RATES" attributeName="overrideAmt" 
							value="${agencyGrpCommsRate?.overrideAmt}" title="The Override Amount"></g:secureTextField>
						</td>	
						</g:if>
					</g:if>						
					<g:else>
					  <td style="white-space: nowrap;padding-left:30px;">
						<g:secureTextField maxlength="30" 
							name="agencyGrpCommsRate.${i}.overrideAmt" 
							tableName="AGENCY_GROUP_COMMS_RATES" attributeName="overrideAmt" 
							value="${agencyGrpCommsRate?.overrideAmt}" title="The Override Amount"></g:secureTextField>
					  </td>		
					</g:else>
				
					</td>
				</tr>
			</g:each>
		</table>
	</div>
</g:each>


<script>
	var memberSelectObject = document.getElementById('memberIdSelectList')
	showAddress(memberSelectObject)
</script>