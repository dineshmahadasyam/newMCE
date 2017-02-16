<%@ page import="com.perotsystems.diamond.bom.PremiumMaster"%>

<style type='text/css' media='screen'>	

.fieldcontain LABEL, .fieldcontain .property-label {
	color: #666666;
	text-align: left;
	width: 40%;
	font-size: 0.8em;
	font-weight: bold
}
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
	text-align:left;
	padding-bottom:5px;
}
.fieldcontain span {
	color: #0066CC;
}
</style>



<g:set var="appContext" bean="grailsApplication"/>

<script type="text/javascript" src="${resource(dir: 'js', file: 'jquery.alphanum.js')}"></script>
<script type="text/javascript" src="${resource(dir: 'js', file: 'jquery.maskedinput.js')}"></script>
<script type="text/javascript" src="${resource(dir: 'js', file: 'commonfunctions.js')}"></script>
<script>

$(function(){

    $(".amtNumeric").numeric({});
	
})
</script>

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
	function upperMe(count) { 
		document.getElementById("detail."+count+".planRiderCode").value = document.getElementById("detail."+count+".planRiderCode").value.toUpperCase(); 
	} 

	function cloneRow()
	{
		var divObjSrc = document.getElementById('newDetailDiv')
		var divObjDest = document.getElementById('addDetailPlaceHolder')
		divObjDest.innerHTML = divObjSrc.innerHTML
		var divObj = document.getElementById('addDetailButton')
		divObj.style.display = "none"	
	}

	function addPremiumMaster() {
		var groupId = "${groupMasterInstance?.groupId}";
		var groupDBId = "${groupMasterInstance?.groupDBId}";
		var appName = "${appContext.metadata['app.name']}";
		
		window.location.assign("/"+appName+"/groupMaintenance/addPremiumMaster?groupId="
				+ groupId + "&grouEditType=DETAIL&groupDBId="+groupDBId);
	}

	function findPlanRider(count) {
		var recordTypeObj = document.getElementById("detail."+count+".recordType");
		recordType = recordTypeObj.value;
		//alert ("recordType " + recordType )
		var planCdoClass;
		var planCdoColumnName;
		
		if(recordType == 'P') {
			planCdoClass = 'com.perotsystems.diamond.dao.cdo.PlanMaster';
			planCdoColumnName =  'planCode';
		} else {
			planCdoClass = 'com.perotsystems.diamond.dao.cdo.RiderMaster';
			planCdoColumnName =  'riderCode';				
		}		
		//alert (" planCdoClass" +planCdoClass +" planCdoColumnName = "+planCdoColumnName)
		lookup("detail."+count+".planRiderCode", planCdoClass ,planCdoColumnName, null, null, null, null);
	}

	function populateProductType(count) {
		 var planCode = document.getElementById("detail."+count+".planRiderCode").value;
		 var recordTypeObj = document.getElementById("detail."+count+".recordType");
		 recordType = recordTypeObj.value;
		 
		 if(recordType == 'P') {
		
			 var productType = jQuery.ajax({
				url : '<g:createLinkTo dir="/groupMaintenance/ajaxPopulateProductType"/>',				
				type : "POST",
				data : {planRiderCode:planCode},
				success : function(result) {
					document.getElementById("productType" + count).value=result
					var index = result.indexOf("-")
					var prodType = result.substr(0 , index).trim()
					if(prodType != null && (prodType == 'SPLSL' || prodType == 'LIFE' || prodType == 'BETL' || prodType == 'SPLDL' || prodType == 'SPLEL')){
						document.getElementById("detail."+count+".giaAmount").disabled="";
					}
					else{
						document.getElementById("detail."+count+".giaAmount").disabled="disabled";
						}
				}
			});
		}
	}

	function populateCompanyCode(count) {
		 var glRefCode = document.getElementById("detail."+count+".glRefCode").value;
		 if(glRefCode) {		
			 var companyCode = jQuery.ajax({
				url : '<g:createLinkTo dir="/groupMaintenance/ajaxPopulateCompanyCode"/>',				
				type : "POST",
				data : {glRefCode:glRefCode},
				success : function(result) {
					document.getElementById("detail."+count+".companyCode").value=result
					if(result != null){
						document.getElementById("detail."+count+".companyCode").disabled="";
					}
					else{
						document.getElementById("detail."+count+".companyCode").disabled="disabled";
						}
				}
			});
		}
	}

	function enableGIAAmount(count){
		var productType = document.getElementById("productType"+count).value;
		if(productType != null){
			var index = productType.indexOf("-")
			productType = productType.substr(0 , index).trim()
			}
		if(productType != null && (productType == 'SPLSL' || productType == 'LIFE' || productType == 'BETL' || productType == 'SPLDL' || productType == 'SPLEL')){
			document.getElementById("detail."+count+".giaAmount").disabled="";
		}
		else{
			document.getElementById("detail."+count+".giaAmount").disabled="disabled";
			}
		}
	</script> 
<g:hiddenField name="groupId" value="${groupMasterInstance?.groupId}" />
<g:hiddenField name="groupDBId" value="${groupMasterInstance?.groupDBId}" />

<div id="addDetailButton" style="display:block">
	<input class="addButton" type="button" value="Add Plan/Rider" onClick="addPremiumMaster()">
	<br></br>
</div>
Group Detail Records for Group Id (${groupMasterInstance.getGroupId()})
<br></br>
<table border="1" id="report">
	<tr class="head">
		<th>Select</th>
		<th>Type</th>
		<th>Plan/Rider Code</th>
		<th>Effective Date</th>
		<th>End Date</th>
		<th>Benefit Package</th>
		<th>Line of Business</th>
		<th>Record Status</th>
	</tr>
	<g:each in="${groupMasterInstance.premiumMasters}" status="i"
		var="premiumMasterVar">
		
		<input type="hidden" name="seq_prem_id_${i}" value="${premiumMasterVar.seqPremId }">
		<input type="hidden" name="detail.${i}.iterationCount" value="${i}">
		<tr class="${(i % 2) == 0 ? 'even' : 'odd'}">		
			<td onclick="enableGIAAmount(${ i })"><input type="radio"
				name="premiumMasterRadio" class="selectradio"></td>
			<td class="clickme" onclick="enableGIAAmount(${ i })">
				${'P'.equals(premiumMasterVar.recordType) ? 'Plan' : 'Rider'}
			</td>

			<td class="clickme" onclick="enableGIAAmount(${ i })">
				${premiumMasterVar.planRiderCode}
			</td>
			<td class="clickme" onclick="enableGIAAmount(${ i })"><g:formatDate format="yyyy-MM-dd"
					date="${premiumMasterVar.effectiveDate}" /></td>
			<td class="clickme" onclick="enableGIAAmount(${ i })"><g:formatDate format="yyyy-MM-dd"
					date="${premiumMasterVar.endDate}" /></td>
			<td class="clickme" onclick="enableGIAAmount(${ i })">
				${premiumMasterVar.benefitPackageId}
			</td>
			<td class="clickme" onclick="enableGIAAmount(${ i })">
				${premiumMasterVar.lineOfBusiness}
			</td>
			<td class="clickme" onclick="enableGIAAmount(${ i })">
				${premiumMasterVar.recordStatus}
			</td>
		</tr>
		<tr class="hideme">
			<td colspan="8">
				<div class="divContent">
				Specifications  <br>
				<hr></hr>
				<table border="0">
					<tr>
						<td style="white-space:nowrap">
							<div
								class="fieldcontain ${hasErrors(bean: premiumMasterVar, field: 'recordType', 'error')} ">
								<label for="rcdType"> <g:message
										code="premiumMaster.recordType.label" default="Record Type :" /><span class="required-indicator">*</span>

								</label>
								<g:secureDiamondDataWindowDetail columnName="record_type"
												tableName="PREMIUM_MASTER" attributeName="recordType"
												dwName="dw_grupd_de" languageId="0"
												htmlElelmentId="detail.${ i }.recordType"
												defaultValue="${premiumMasterVar?.recordType}"
												blankValue="Record Type" width="150px"
												value ="${premiumMasterVar?.recordType}"></g:secureDiamondDataWindowDetail>							
							</div>
						</td>
						<td style="white-space:nowrap">
							<div
								class="fieldcontain ${hasErrors(bean: premiumMasterVar, field: 'planRiderCode', 'error')} ">
								<label for="planRiderCode"> <g:message
										code="premiumMaster.planRiderCode.label" default="Plan/Rider Code :" /><span class="required-indicator">*</span>

								</label>
								
								<input type="hidden" name="${ i }.recordType" id="det${ i }.recordType" value="${premiumMasterVar?.recordType}"/>
 								<g:secureTextField name="detail.${ i }.planRiderCode" 
 								tableName="PREMIUM_MASTER" attributeName="planRiderCode" maxlength="50"
 								value="${premiumMasterVar?.planRiderCode}" class="RemoveSpecialChars"
 								onchange="upperMe(${i}), populateProductType(${i})" onblur = "populateProductType(${i})"></g:secureTextField>
								<img width="25" height="25"
									style="float: none; vertical-align: bottom"
									class="magnifying" src="${resource(dir: 'images', file: 'Search-icon.png')}"
									onclick="findPlanRider(${i})">																					
							</div>
						</td>
				
						<td style="white-space:nowrap">
							<div
								class="fieldcontain ${hasErrors(bean: premiumMasterVar, field: 'lineOfBusiness', 'error')} ">
								<label for="lineOfBusiness"> <g:message
										code="premiumMaster.lineOfBusiness.label" default="Line Of Business :" /> <span class="required-indicator">*</span>
	
								</label>
								<g:secureTextField name="detail.${ i }.lineOfBusiness" 
								tableName="PREMIUM_MASTER" attributeName="lineOfBusiness"
								value="${premiumMasterVar?.lineOfBusiness}"></g:secureTextField>
								<img width="25" height="25"
										style="float: none; vertical-align: bottom"
										class="magnifying" src="${resource(dir: 'images', file: 'Search-icon.png')}"
										onclick="lookup('detail.${ i }.lineOfBusiness', 'com.perotsystems.diamond.dao.cdo.LineOfBusinessMaster','lineOfBusiness')">
	
							</div>
						</td>
						</tr>
						<tr>
							<td style="white-space:nowrap">
							<div
								class="fieldcontain ${hasErrors(bean: premiumMasterVar, field: 'effectiveDate', 'error')} required">
								<label for="effectiveDate"> <g:message
										code="premiumMaster.effectiveDate.label"
										default="Effective Date :" /> <span class="required-indicator">*</span>
								</label>
								<g:secureGrailsDatePicker name="detail.${ i }.effectiveDate" precision="day" noSelection="['':'']"
								tableName="PREMIUM_MASTER" attributeName="effectiveDate"
									value="${premiumMasterVar?.effectiveDate}" default="none" ></g:secureGrailsDatePicker>
							</div>
							</td>
							<td style="white-space:nowrap">
							<div
								class="fieldcontain ${hasErrors(bean: premiumMasterVar, field: 'endDate', 'error')} required">
								<label for="endDate"> <g:message
										code="premiumMaster.endDate.label" default="Term Date :" />
								</label>
								<g:secureGrailsDatePicker name="detail.${ i }.endDate" precision="day" noSelection="['':'']"
									tableName="PREMIUM_MASTER" attributeName="endDate"
									value="${premiumMasterVar?.endDate}" default="none" ></g:secureGrailsDatePicker>
							</div>
						</td>
						<td>
						<div
							class="fieldcontain ${hasErrors(bean: plan, field: 'plan.productType', 'error')} required" 
							style="display: inline">
							<label for="productType${ i }"> <g:message
									code="planMaster.productType.label" default="Product Type :" />
							</label>
							<g:textField readOnly="true" style="color: #48802C" name="productType${ i }" value="${productTypesMap?.get(premiumMasterVar?.planRiderCode)}" />
						</div>
						</td>	
						
						</tr>
						<tr>
						<td style="white-space:nowrap">
							<div
								class="fieldcontain ${hasErrors(bean: premiumMasterVar, field: 'renewalDate', 'error')} required">
								<label for="renewalDate"> <g:message
										code="premiumMaster.renewalDate.label" default="Renew Date :" />
								</label>
								<g:secureGrailsDatePicker name="detail.${ i }.renewalDate" precision="day" noSelection="['':'']"
								tableName="PREMIUM_MASTER" attributeName="renewalDate"
									value="${premiumMasterVar?.renewalDate}" default="none"  ></g:secureGrailsDatePicker>
							</div>
						</td>	
						<td style="white-space:nowrap">
							<div
								class="fieldcontain ${hasErrors(bean: premiumMasterVar, field: 'termReason', 'error')} ">
								<label for="termReason"> <g:message
										code="premiumMaster.termReason.label" default="Term Reason :" />

								</label>
								<input type="hidden" name="TermReasonType" id="TermReasonType" value="TM"/>
								<g:secureTextField name="detail.${ i }.termReason"
									tableName="PREMIUM_MASTER" attributeName="termReason" maxlength="5" class="RemoveSpecialChars"
									value="${premiumMasterVar?.termReason}" ></g:secureTextField>
								<img width="25" height="25"
									style="float: none; vertical-align: bottom"
									class="magnifying" src="${resource(dir: 'images', file: 'Search-icon.png')}"
									onclick="lookup('detail.${ i }.termReason', 'com.perotsystems.diamond.dao.cdo.ReasonCodeMaster','reasonCode', 'TermReasonType', 'reasonCodeType', null, null)">
							</div>
						</td>
						<td  style="white-space:nowrap">
							<div
								class="fieldcontain ${hasErrors(bean: premiumMasterVar, field: 'multiPlanEnroll', 'error')} ">
								<label for="multiPlanEnroll"> <g:message
										code="premiumMaster.multiPlanEnroll.label"
										default="Multi Plan Enroll :" />
								<span class="required-indicator">*</span>
								</label>
								<g:secureTextField readonly="true" style="width:20px" maxlength="1" name="detail.${ i }.multiPlanEnroll"
									tableName="PREMIUM_MASTER" attributeName="multiPlanEnroll"
									value="${premiumMasterVar?.multiPlanEnroll}" 
									title = "Enter N to prevent enrollment in multiple plans with the same product type; or Y to allow"></g:secureTextField>
							</div>
						</td>					
						</tr>
						<tr>
						<td  style="white-space:nowrap">
							<div
								class="fieldcontain ${hasErrors(bean: premiumMasterVar, field: 'recordStatus', 'error')} ">
								<label for="recordStatus"> <g:message
										code="premiumMaster.recordStatus.label"
										default="Record Status :" />

								</label>
								<g:secureTextField name="detail.${ i }.recordStatus" maxlength="15"
									tableName="PREMIUM_MASTER" attributeName="recordStatus" class="RemoveSpecialChars"
									value="${premiumMasterVar?.recordStatus}" ></g:secureTextField>
							</div>
						</td>
						<td>
						</td>
						<td  style="white-space:nowrap">
							<div
								class="fieldcontain ${hasErrors(bean: premiumMasterVar, field: 'giaAmount', 'error')} ">
								<label for="giaAmount"> <g:message
										code="premiumMaster.giaAmount.label"
										default="GIA Amount :" />

								</label>
								<span class="currencyinput">$
								<g:secureTextField name="detail.${ i }.giaAmount" disabled = "disabled" class="amtNumeric" maxlength="21"
									tableName="PREMIUM_MASTER" attributeName="giaAmount"
									value="${formatNumber(number: premiumMasterVar?.giaAmount, format: '#####0.00')}" 
									title = "Enter GIA amount for life insurance policies"></g:secureTextField>
								</span>
							</div>
						</td>
						</tr>
						<tr>
						<td style="white-space:nowrap">
							<div
								class="fieldcontain ${hasErrors(bean: premiumMasterVar, field: 'convYearStartDate', 'error')} required">
								<label for="convYearStartDate"> <g:message
										code="premiumMaster.convYearStartDate.label"
										default="Cont Yr Start Date :" /> 
								</label>
								<g:datePicker name="detail.${ i }.convYearStartDate" precision="day" noSelection="['':'']"
									value="${premiumMasterVar?.convYearStartDate}"  default="none" />
							</div>
						</td>	
						<td style="white-space:nowrap">
									<div
										class="fieldcontain ${hasErrors(bean: premiumMasterVar, field: 'glRefCode', 'error')} required">
										<label for="glRefCode"> <g:message
												code="premiumMaster.glRefCode.label"
												default="G/L Ref Code  :" /> 
										</label>
										<g:secureTextField name="detail.${ i }.glRefCode" 
		 								tableName="PREMIUM_MASTER" attributeName="glRefCode" onchange="upperMe(${i}), populateCompanyCode(${i})" onblur = "populateCompanyCode(${i})"
		 								value="${premiumMasterVar?.glRefCode}" ></g:secureTextField>
		 								<img width="25" height="25"
											style="float: none; vertical-align: bottom"
											class="magnifying" src="${resource(dir: 'images', file: 'Search-icon.png')}"
											onclick="lookup('detail.${ i }.glRefCode', 'com.perotsystems.diamond.dao.cdo.GeneralLedgerReference','glRefCode', null, null, null, null)">
											
									</div>
								</td>	
								<td style="white-space:nowrap">
									<div
										class="fieldcontain ${hasErrors(bean: premiumMasterVar, field: 'companyCode', 'error')} required">
										<label for="companyCode"> <g:message
												code="premiumMaster.companyCode.label"
												default="Company Code  :" /> 
										</label>
										<g:secureTextField name="detail.${ i }.companyCode" readOnly="true" style="color: #48802C"
		 								tableName="PREMIUM_MASTER" attributeName="companyCode"
		 								value="${premiumMasterVar?.companyCode}" ></g:secureTextField>
		 								<img width="25" height="25" 
											style="float: none; vertical-align: bottom"
											class="magnifying" src="${resource(dir: 'images', file: 'Search-icon.png')}"
											onclick="lookup('detail.${ i }.companyCode', 'com.perotsystems.diamond.dao.cdo.CompanyMaster','companyCode', null, null, null, null)">
									</div>
								</td>							
						</tr>
						<tr>						
						
					</tr>
					
				</table>
				
				</div>
			</td>
		</tr>
	</g:each>
	
</table>
<div id=addDetailPlaceHolder>
</div>



