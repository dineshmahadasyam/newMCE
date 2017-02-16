<%@ page import="com.dell.diamond.fms.AgentMasterCommand"%>
<!DOCTYPE html>
<html>
	<head>
		<script>
			function closeForm() {
				window.location.assign('<g:createLinkTo dir="/agentMaster/list"/>')			
			}
		</script>
	</head>
	<body>
		<g:if test="${(agentMasterInstance?.agentCommissions)}">
			<table id="rptHeading" style="width:100%; font-family:Calibri,sans-serif;">
				<tr>
					<td>${agentMasterInstance?.firstName} ${agentMasterInstance?.middleInitial} ${agentMasterInstance?.lastName}</td>
				</tr>
				<tr>
					<td>${agentMasterInstance?.agentAddresses?.addressLine1[0]} ${agentMasterInstance?.agentAddresses?.addressLine2[0]}</td>
				</tr>
				<tr>
					<td>${agentMasterInstance?.agentAddresses?.city[0]}, ${agentMasterInstance?.agentAddresses?.state[0]}  
						<g:if test="${agentMasterInstance?.agentAddresses?.zipCode[0]?.length() > 5}">
							${agentMasterInstance?.agentAddresses?.zipCode[0]?.with {length()? getAt(0..4):''}}-${agentMasterInstance?.agentAddresses?.zipCode[0]?.with {length()? getAt(5..length()-1):''}}
						</g:if> 
						<g:elseif test="${agentMasterInstance?.agentAddresses?.zipCode[0]?.length() == 5}">
								${agentMasterInstance?.agentAddresses?.zipCode[0]?.with {length()? getAt(0..4):''}}
						</g:elseif> 
						<g:else>
						</g:else>
					</td>
				</tr>
			</table>
			<table id="commissionStatement" style="width:100%; font-family:Calibri,sans-serif;">
				<tr>
					<td style="text-align:center; font-size:20px; font-weight: bold;" colspan="7">COMMISSION STATEMENT</td>
				</tr>
				<tr>
					<td>&nbsp;</td>
				</tr>
				<tr>
					<td style="text-align:left; vertical-align: top;font-weight: bold;">GROUP #/<br/>NAME</td>
					<td style="text-align:left; vertical-align: top;font-weight: bold;">PRODUCT</td>
					<td style="text-align:left; vertical-align: top;font-weight: bold;">FINANCIAL<br/>PERIOD</td>
					<td style="text-align:left; vertical-align: top;font-weight: bold;">SUBS</td>
					<td style="text-align:left; vertical-align: top;font-weight: bold;">PREMIUM <br/>COMMISSION</td>
					<td style="text-align:left; vertical-align: top;font-weight: bold;">PSPM</td>
					<td style="text-align:left; vertical-align: top;font-weight: bold;">PAID</td>
				</tr>
				
				<g:set var="totalSubs" value="${0}"></g:set>
				<g:set var="totalPremComm" value="${0.00}"></g:set>
				<g:set var="totalPaid" value="${0.00}"></g:set>
				
				<g:each in="${agentMasterInstance?.agentCommissions}" var="agentCommission" status="i">
					<tr>
						<td style="text-align:left; vertical-align: top;">${agentCommission?.groupId}<br/>${agentCommission?.groupName}</td>
						<td style="text-align:left; vertical-align: top;">${agentCommission?.policyType}</td>
						 <td style="text-align:left; vertical-align: top;"><g:formatDate format="yyyyMMdd" date="${agentCommission?.creationDate}"  /></td>
						<td style="text-align:left; vertical-align: top;">${agentCommission?.groupCount}</td>
						<td style="text-align:left; vertical-align: top;"><g:formatNumber number="${agentCommission?.baseAmount}" format="###,##0.00"/></td>
						<td style="text-align:left; vertical-align: top;"><g:formatNumber number="${agentCommission?.commissionRate}" format="###,##0.00"/></td>
						<td style="text-align:left; vertical-align: top;"><g:formatNumber number="${agentCommission?.commissionPaid}" format="###,##0.00"/></td>
						<g:if test = "${agentCommission?.groupCount}">
							<g:set var="totalSubs" value="${totalSubs + agentCommission?.groupCount}" ></g:set>
						</g:if>
						<g:if test = "${agentCommission?.baseAmount}">
							<g:set var="totalPremComm" value="${totalPremComm + agentCommission?.baseAmount}"></g:set>
						</g:if>
						<g:if test = "${agentCommission?.commissionPaid}">
							<g:set var="totalPaid" value="${totalPaid + agentCommission?.commissionPaid}"></g:set>
						</g:if>
					</tr>
				</g:each>
				<tr>
					<td colspan="6">&nbsp;</td>
					<td>
						<div style="width: 35%; height: 2px; background: black; overflow: hidden; align:top"></div>
					</td>
				</tr>
				<tr>
					<td>&nbsp;</td>
					<td>&nbsp;</td>
					<td style="text-align:left; vertical-align: top; font-weight: bold;">TOTAL</td>
					<td style="text-align:left; vertical-align: top; font-weight: bold;">${totalSubs}</td>
					<td style="text-align:left; vertical-align: top; font-weight: bold;">${totalPremComm}</td>
					<td>&nbsp;</td>
					<td style="text-align:left; vertical-align: top; font-weight: bold;">${totalPaid}</td>	
				</tr>
			</table>
			<br/><br/>
			
			<table id="agentStatement" style="width:100%;font-family:Calibri,sans-serif;">
				<tr>
					<td style="text-align:center; font-size:20px; font-weight: bold;" colspan="5">AGENT SUMMARY</td>
				</tr>
				<tr>
					<td>&nbsp;</td>
				</tr>
				<tr>
					<td style="text-align:left; vertical-align: top; font-weight: bold;">PRODUCT</td>
					<td style="text-align:left; vertical-align: top; font-weight: bold;">INCOME <br/>COMMISSIONABLE</td>
					<td style="text-align:left; vertical-align: top; font-weight: bold;">EARNED <br/>COMMISSION</td>
					<td style="text-align:left; vertical-align: top; font-weight: bold;">PAID</td>
					<td style="text-align:left; vertical-align: top; font-weight: bold;">ENDING <br/>BALANCE</td>
				</tr>
				
				<g:set var="totalIncomeCommissionable" value="${0.00}"></g:set>
				<g:set var="totalEarnedCommission" value="${0.00}"></g:set>
				<g:set var="totalPaid" value="${0.00}"></g:set>
				<g:set var="totalEndingBalance1" value="${0.00}"></g:set>
				
				
				<g:set var="totalBalanceForward" value="${0.00}"></g:set>
				<g:set var="totalCurrentEarnedCommission" value="${0.00}"></g:set>
				<g:set var="totalPaidToAgent" value="${0.00}"></g:set>
				<g:set var="totalEndingBalance2" value="${0.00}"></g:set>
				
				<g:each in="${agentMasterInstance?.agentCommissions}" var="agentCommission" status="j">				
				
				<g:if test = "${agentCommission?.baseAmount}">
					<g:set var="totalIncomeCommissionable" value="${agentCommission?.baseAmount + totalIncomeCommissionable}"></g:set>
				</g:if>
				<g:if test = "${agentCommission?.earnedCommission}">
					<g:set var="totalEarnedCommission" value="${agentCommission?.earnedCommission + totalEarnedCommission}"></g:set>
				</g:if>
				<g:if test = "${agentCommission?.commissionPaid}">
					<g:set var="totalPaid" value="${agentCommission?.commissionPaid + totalPaid}"></g:set>
				</g:if>
					
				<g:if test = "${agentCommission?.balanceForward}">
					<g:set var="totalBalanceForward" value="${agentCommission?.balanceForward + totalBalanceForward}"></g:set>
				</g:if>
				<g:if test = "${agentCommission?.earnedCommission}">
					<g:set var="totalCurrentEarnedCommission" value="${agentCommission?.earnedCommission + totalCurrentEarnedCommission}"></g:set>
				</g:if>
				<g:if test = "${agentCommission?.commissionPaid}">
					<g:set var="totalPaidToAgent" value="${agentCommission?.commissionPaid + totalPaidToAgent}"></g:set>
				</g:if>
					
				</g:each>
				
					<g:set var="totalEndingBalance1" value="${totalEarnedCommission - totalPaid}"></g:set>
				
					<tr>
						<td style="font-weight: bold;">${agentMasterInstance?.agentCommissions?.policyType[0]}</td>
						<td style="font-weight: bold;">${totalIncomeCommissionable}</td>
						<td style="font-weight: bold;">${totalEarnedCommission}</td>
						<td style="font-weight: bold;">-${totalPaid}</td>
						<td style="font-weight: bold;">${totalEndingBalance1}</td>
					</tr>
				
				<g:set var="totalEndingBalance2" value="${totalCurrentEarnedCommission - totalPaidToAgent}"></g:set>
				
			</table>
			<br/><br/>
			<table id="agentStatementSummary" style="width:50%;font-family:Calibri,sans-serif; " >
				<tr>
					<td style="text-align:left; vertical-align: top; font-weight: bold;">BALANCE FORWARD</td>
					<td style="text-align:right; vertical-align: top; font-weight: bold;">${totalBalanceForward}</td>
				</tr>
				<tr>
					<td style="text-align:left; vertical-align: top; font-weight: bold;">CURRENT EARNED COMMISSIONS</td>
					<td style="text-align:right; vertical-align: top; font-weight: bold;">${totalCurrentEarnedCommission}</td>
				</tr>
				<tr>
					<td style="text-align:left; vertical-align: top; font-weight: bold;">PAID TO AGENT</td>
					<td style="text-align:right; vertical-align: top; font-weight: bold;">-${totalPaidToAgent}</td>
				</tr>
				<tr>
					<td style="text-align:left; vertical-align: top; font-weight: bold;">ENDING BALANCE</td>
					<td style="text-align:right; vertical-align: top; font-weight: bold;">${totalEndingBalance2}</td>
				</tr>
			</table>
			
			<br/><br/>
			
			<table id="groupRecap" style="width:100%;font-family:Calibri,sans-serif;">
				<tr>
					<td style="text-align:center; font-size:20px; font-weight: bold;" colspan="3">GROUP RECAP</td>
				</tr>
				<tr>
					<td>&nbsp;</td>
				</tr>
				<tr>
					<td style="text-align:left; vertical-align: top; font-weight: bold;">GROUP NAME</td>
					<td style="text-align:left; vertical-align: top; font-weight: bold;">GROUP NUMBER</td>
					<td style="text-align:left; vertical-align: top; font-weight: bold;">DENTAL</td>
				</tr>
				
				<g:set var="totalCommissionPaid" value="${0.00}"></g:set>
				<g:each in="${agentMasterInstance?.agentCommissions}" var="agentCommission" status="k">
					<tr>
						<td style="text-align:left; vertical-align: top;">${agentCommission?.groupName}</td>
						<td style="text-align:left; vertical-align: top;">${agentCommission?.groupId}</td>
						<td style="text-align:left; vertical-align: top;"><g:formatNumber number="${agentCommission?.commissionPaid}" format="###,##0.00"/></td>
					</tr>
					<g:if test = "${agentCommission?.commissionPaid}">
						<g:set var="totalCommissionPaid" value="${agentCommission?.commissionPaid + totalCommissionPaid}"></g:set>
					</g:if>
				</g:each>
				
				<tr><td colspan="2">&nbsp;</td>
					<td><div style="width: 25%; height: 2px; background: black; overflow: hidden;"></div></td>
				</tr>
				<tr>
					<td>&nbsp;</td>
					<td style="text-align:right; font-size:20px; font-weight: bold;">TOTAL COMMISSIONS&nbsp;&nbsp;&nbsp;</td>
					<td style="text-align:left; font-size:20px; font-weight: bold;">${totalCommissionPaid}</td>
						
				</tr>							
			</table>
		</g:if>
		<g:else>
				NO STATEMENT AVAILABLE
	    </g:else>
	    <br/><br/>
	    <g:form>
			<fieldset class="buttons">
				<input type="button" class="close" value="Close" onClick="closeForm()"/>				
			</fieldset>
		</g:form>
	</body>
</html>