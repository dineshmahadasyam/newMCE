<%@ page import="com.perotsystems.diamond.dao.cdo.AgentMaster"%>
<%@ page import="com.perotsystems.diamond.dao.cdo.GroupMaster"%>

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

		 $(".amtNumeric").numeric({});

	});//]]>

	function addContract() {		
		window.location.assign('<g:createLinkTo dir="/agentMaster/addAgentContract"/>?seqAgentId=${agentMasterInstance?.seqAgentId}');
	}

	function resetPlanCode(count) {
		document.getElementById("agentContract."+count+".seqPremId").value = "";
		document.getElementById(count+".planRiderCode").value = "";
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

	function lookupplanId(idName, cdoClassName, cdoClassAttributeName, setToIdName, setToIdName1) {
		var groupId = document.getElementById(idName).value
		if(groupId == null || groupId == "") {
			alert ("Please enter Group Id");
			return false;
		}
		
		var htmlElementValue 
		var assocHTMLElementsValue
		if(idName.indexOf('|') == -1){			
			htmlElementValue = document.getElementById(idName).value
			assocHTMLElementsValue = htmlElementValue
		} else {
			var nameArray = idName.split("|")
			for (var i =0;i<nameArray.length;i++) {
				if(i == 0) {
					htmlElementValue = document.getElementById(nameArray[i]).value					
				}
				assocHTMLElementsValue += document.getElementById(nameArray[i]).value+"|"
			}
		}
		//alert("htmlElementValue = "+htmlElementValue )
		var appName = "${appContext.metadata['app.name']}";
		var urlValue = "/"+appName+"/lookUp/lookUpPlanId?htmlElementIdName=" + idName
				+ "&htmlElementValue=" + htmlElementValue 
				+ "&cdoClassName="+ cdoClassName 
				+ "&cdoClassAttributeName="+ cdoClassAttributeName 
				+ "&assocHTMLElementsValue="+ assocHTMLElementsValue 
				+ "&setToIdName=" + setToIdName
				+ "&setToIdName1=" + setToIdName1
				+ "&offset=0"
		//alert (urlValue )
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
				url : urlValue, 
			 onClose: function(wnd) { // a callback function while user click close button
				 innerWindowClosed = true;
			  }
			});
		}
	}

	function populateDescription(id) {
		 var groupId = document.getElementById(id+".groupId").value;

		
		 if(groupId != null && groupId != ""){
			 var descr = jQuery.ajax({
					url : '<g:createLinkTo dir="/agency/ajaxPopulateDescription"/>',
									
					type : "GET",
					data : {groupId:groupId},
					success : function(result) {
						var index = result.indexOf("-")
						
						if(index != null && index > 0){
							var seqDBId = result.substr(0 , index).trim()
							var desc = result.substr(index+1 , result.length)
							if(seqDBId != null && seqDBId != ""){
								document.getElementById("agentContract."+ id + ".seqGroupId").value = seqDBId
								}
							else{
								document.getElementById("agentContract."+ id + ".seqGroupId").value = null
								}

							if(desc != null){
								document.getElementById(id + ".description").value = desc
								}
							else{
								document.getElementById(id + ".description").value = ""
								}
						}
						else{
							document.getElementById("agentContract."+ id + ".seqGroupId").value = null
							document.getElementById(id + ".description").value = ""
							}
					}
				});
		}
		 else{
			 document.getElementById(id +".description").value=""
			 document.getElementById("agentContract."+ id + ".seqGroupId").value = null
			 }
	}

	function upperMe(id) { 
		document.getElementById(id+ ".groupId").value = document.getElementById(id+".groupId").value.toUpperCase(); 
	}

	function deleteContract(seqId)
	{
		document.getElementById('seqAgencyGroupContractId').value = seqId
		
	    	if (confirm("Are you sure you want to delete this Contract?") == true) 
			 {
		    	return true;
		     } 
		    else 
			{
		    	return false;
		    }
	}

	function isNumberKey(evt) {
		var charCode = (evt.which) ? evt.which : event.keyCode;
	    if (charCode == 46 && evt.srcElement.value.split('.').length>1) {
	    	alert("Please enter numbers and decimal only for Rate Amount");
	        return false;
	    }
	    if (charCode != 46 && charCode > 31 && (charCode < 48 || charCode > 57)){
	    	alert("Please enter numbers and decimal only for Rate Amount");
	    	return false;
	        }
	        
	    return true;
	}
</script>

<input type="hidden" name="editType" value="CONTRACTS" />
<input type="hidden" name="seqAgentId" value="${agentMasterInstance?.seqAgentId }" />
<input type="hidden" name="seqAgencyGroupContractId" id="seqAgencyGroupContractId" value="" />

<div id="${agentMasterInstance?.seqAgentId}">
	<br/>
	<div id="contractsDiv" style="padding-bottom:10px;">
			<input type="button" name="addContractButton" class="load" value="Add Contract"  onClick="addContract()">
	</div>
	Agent/Broker Contract Records for Agent Id (${agentMasterInstance?.agentId}) 
	<br/>
	<br/>
	<table border="1" id="report">
		<tr class="head">
			<th>&nbsp;&nbsp;Select</th>
			<th>Group Id</th>
			<th>Plan/Rider Code</th>
		</tr>
		<g:each in="${agentMasterInstance?.agentGroupContracts }" var="agentContract" status="i">
			<input type="hidden" name="seq_contract_id_${i}" value="${agentContract?.seqAgencyGroupContractId }">
			<input type="hidden" name="agentContract.${i}.iterationCount" value="${i}">
			<input type="hidden" name="agentContract.${i}.seqAgencyGroupContractId" value="${agentContract?.seqAgencyGroupContractId }">
			<tr class="${(i % 2) == 0 ? 'even' : 'odd'}">
				<td>
					<input type="radio" name="contractId" class="selectradio" value="${agentContract?.seqAgencyGroupContractId}">
				</td>
				<td class="clickme">
					${groupMasterMap?.get(agentContract.seqGroupId).getGroupId()}
				</td>
				<td class="clickme">
					${premMasterMap?.get(agentContract.seqPremId)}
				</td>
			</tr>

			<tr class="hideme" id="rowToClone2">
				<td colspan="13">
					<div class="divContent" id="${agentContract?.seqAgencyGroupContractId}">
						<table class="report1" border="0" style="table-layout: fixed;">
							<tr>
								<td class="tdFormElement" style="white-space: nowrap">
									<div
										class="fieldcontain ${hasErrors(bean: agentContract, field: 'groupId', 'error')} ">
										<label for="groupId"> <g:message
												code="agentContract.groupId.label" default="Group Id :" />
											<span class="required-indicator">*</span>

										</label>
										
										<input type="hidden" id="agentContract.${i}.seqGroupId" name="agentContract.${i}.seqGroupId" value="${agentContract.seqGroupId}" onchange="resetPlanCode(${i})"
										onblur="resetPlanCode(${i})"/>
																									
										<g:secureTextField name="${i}.groupId" maxlength="30" id = "${i}.groupId" 
											value="${groupMasterMap?.get(agentContract.seqGroupId).getGroupId()}" tableName="AGENCY_GROUP_CONTRACT"
											attributeName="seqGroupId" title="The Group ID" onblur = "populateDescription(${i})" onchange="upperMe(${i});populateDescription(${i})"></g:secureTextField>
												
										<img width="25" height="25" style="float:none;vertical-align:bottom" class="magnifying"
											src="${resource(dir: 'images', file: 'Search-icon.png')}"
											onclick="lookup('${i}.groupId', 'com.perotsystems.diamond.dao.cdo.GroupMaster','groupId',null, null, 'agentContract.${i}.seqGroupId', 'seqGroupId' )">
									</div>
								</td>
								<td>
									<div class="fieldcontain">
										<label for="description"> 
											<g:message code="description.label" default="Description :" />
										</label>
										<g:textField name="${i}.description" id="${i}.description" value="${groupMasterMap?.get(agentContract.seqGroupId).getGroupName1()}" readonly="readonly" style="margin-right: 5px;border: none"/>
									</div>
								</td>
								
								
							</tr>
							<tr>
								<td class="tdFormElement" style="white-space: nowrap">
									<div class="fieldcontain ${hasErrors(bean: premiumMaster, field: 'tdFormElement', 'error')} ">
										<label for="tdFormElement"> 
											<g:message code="premiumMaster.planRiderCode.label" default="Plan/Rider Code :" />
											<span class="required-indicator">*</span>
										</label>
									
										<input type="hidden" id="agentContract.${i}.seqPremId" name="agentContract.${i}.seqPremId" value="${agentContract.seqPremId}"/>
										
										<g:secureTextField name="${i}.planRiderCode" value="${premMasterMap?.get(agentContract.seqPremId)}" maxlength="30" readonly="readonly"
											tableName="AGENCY_GROUP_CONTRACT" attributeName="seqPremId"></g:secureTextField>
										
										<img class="magnifying" width="25" height="25" src="${resource(dir: 'images', file: 'Search-icon.png')}"  style="float:none;vertical-align:bottom"
											onclick="lookupplanId('${i}.groupId', 'com.perotsystems.diamond.dao.cdo.PremiumMaster','seqGroupId', '${i}.planRiderCode','agentContract.${i}.seqPremId')">
										
									</div>
								</td>
								<td>
									<div class="fieldcontain ${hasErrors(bean: premiumMaster, field: 'overrideAmount', 'error')} ">
										<label for="lastName"> 
											<g:message code="agentContract.overrideAmount.label" default="Override Amt :" />
										</label>
										
										<g:secureTextField name="agentContract.${i}.overrideAmount" value="${agentContract.overrideAmount}" maxlength="30" onkeypress="return isNumberKey(event)"
										tableName="AGENCY_GROUP_CONTRACT" attributeName="overrideAmount" class="amtNumeric"></g:secureTextField>
									</div>
								</td>	
														
							</tr>
							<tr>
								<td class="tdnoWrap" style="white-space: nowrap">
								</td>
							</tr>
							<tr>
								<td class="tdnoWrap" style="white-space: nowrap">
								</td>
							</tr>
							<tr>
								<td class="tdnoWrap" style="white-space: nowrap"></td>
							</tr>
							<tr>
								<td colspan="2"><g:actionSubmit class="load" action="deleteContract" value="Delete" onclick="return deleteContract(${agentContract?.seqAgencyGroupContractId});" />
								</td>
							</tr>
						</table>
			
					</div>
				</td>
			</tr>
		</g:each>
	</table>
</div>