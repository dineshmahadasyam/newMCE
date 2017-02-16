<%@ page import="com.dell.diamond.fms.AgentMasterCommand"%>
<!DOCTYPE html>
<html>
<head>
<meta name="layout" content="main">

<title><g:message code="default.list.label" args="[entityName]" /></title>
<g:set var="appContext" bean="grailsApplication" />
<meta name="navSelector" content="maint" />
<meta name="navChildSelector" content="agentMaster" />
<script>
	function closeForm() {
		window.location.assign('<g:createLinkTo dir="/agentMaster/list"/>')
	}
</script>
</head>

	<div id="fms_content_body">
	<g:if test="${(agentMasterInstance?.agentCommissions)}">
	  <div class="fms_widget">
	  	
          <h2>
         		 ${agentMasterInstance?.firstName} ${agentMasterInstance?.middleInitial}
						${agentMasterInstance?.lastName}
          </h2>
          <p>${agentMasterInstance?.agentAddresses?.addressLine1[0]} ${agentMasterInstance?.agentAddresses?.addressLine2[0]} <br/>
          	${agentMasterInstance?.agentAddresses?.city[0]}, ${agentMasterInstance?.agentAddresses?.state[0]}
						<g:if test="${agentMasterInstance?.agentAddresses?.zipCode[0]?.length() > 5}">
							${agentMasterInstance?.agentAddresses?.zipCode[0]?.with {length()? getAt(0..4):''}}-${agentMasterInstance?.agentAddresses?.zipCode[0]?.with {length()? getAt(5..length()-1):''}}
						</g:if> 
						<g:elseif test="${agentMasterInstance?.agentAddresses?.zipCode[0]?.length() == 5}">
							${agentMasterInstance?.agentAddresses?.zipCode[0]?.with {length()? getAt(0..4):''}}
						</g:elseif>
						 <g:else>
						</g:else>	
          </p>
          </div>

		<div class="fms_widget">
          <h3>Commission Statement</h3>
          <div class="table-responsive fms_table_wrapper">
            <table class="table table-bordered tablesorter-fms">
              <thead>                        
                <tr>
                  <th>Group #/Name</th>
                  <th>Product</th>
                  <th>Financial Period</th>
                  <th class="text-right">SUBS</th>
                  <th class="text-right">Premium Commission</th>
                  <th class="text-right">PSPM</th>
                  <th class="text-right">PAID</th>
                </tr>
              </thead>
              <tbody>
              	
				<g:set var="totalSubs" value="${0}"></g:set>
				<g:set var="totalPremComm" value="${0.00}"></g:set>
				<g:set var="totalPaid" value="${0.00}"></g:set>
				
				<g:each in="${agentMasterInstance?.agentCommissions}" var="agentCommission" status="i">
                <tr>
                 <td>${agentCommission?.groupId}<br/>${agentCommission?.groupName}</td>
						<td>${agentCommission?.policyType}</td>
						<td><g:formatDate format="yyyyMMdd" date="${agentCommission?.creationDate}"  /></td>
						<td>${agentCommission?.groupCount}</td>
						<td class="text-right"><g:formatNumber number="${agentCommission?.baseAmount}" format="###,##0.00"/></td>
						<td class="text-right"><g:formatNumber number="${agentCommission?.commissionRate}" format="###,##0.00"/></td>
						<td class="text-right"><g:formatNumber number="${agentCommission?.commissionPaid}" format="###,##0.00"/></td>
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
              </tbody>
              <tfoot>
                <tr>
                  <td colspan="3" class="text-right bold">Total</td>
                  <td class="text-right bold">${totalSubs}</td>
                  <td class="text-right bold">${totalPremComm}</td>
                  <td></td>
                  <td class="text-right bold">${totalPaid}</td>
                </tr>
              </tfoot>
            </table>
          </div>
        </div>

		<div class="fms_widget">
          <h3>Agent Summary</h3>
          <div class="table-responsive fms_table_wrapper">
            <table class="table table-condensed table-bordered tablesorter-fms" style="margin-bottom: 2%;">
              <thead>                        
                <tr>
                  <th>PRODUCT</th>
                  <th class="text-right">Income Commissionable</th>
                  <th class="text-right">Earned Commission</th>
                  <th class="text-right">PAID</th>
                  <th class="text-right">Ending Balance</th>
                </tr>
              </thead>
              <tbody>
              <g:set var="totalIncomeCommissionable" value="${0.00}"></g:set>
						<g:set var="totalEarnedCommission" value="${0.00}"></g:set>
						<g:set var="totalPaid" value="${0.00}"></g:set>
						<g:set var="totalEndingBalance1" value="${0.00}"></g:set>


						<g:set var="totalBalanceForward" value="${0.00}"></g:set>
						<g:set var="totalCurrentEarnedCommission" value="${0.00}"></g:set>
						<g:set var="totalPaidToAgent" value="${0.00}"></g:set>
						<g:set var="totalEndingBalance2" value="${0.00}"></g:set>

						<g:each in="${agentMasterInstance?.agentCommissions}" var="agentCommission" status="j">

							<g:if test="${agentCommission?.baseAmount}">
								<g:set var="totalIncomeCommissionable" value="${agentCommission?.baseAmount + totalIncomeCommissionable}"></g:set>
							</g:if>
							<g:if test="${agentCommission?.earnedCommission}">
								<g:set var="totalEarnedCommission" value="${agentCommission?.earnedCommission + totalEarnedCommission}"></g:set>
							</g:if>
							<g:if test="${agentCommission?.commissionPaid}">
								<g:set var="totalPaid" value="${agentCommission?.commissionPaid + totalPaid}"></g:set>
							</g:if>

							<g:if test="${agentCommission?.balanceForward}">
								<g:set var="totalBalanceForward" value="${agentCommission?.balanceForward + totalBalanceForward}"></g:set>
							</g:if>
							<g:if test="${agentCommission?.earnedCommission}">
								<g:set var="totalCurrentEarnedCommission" value="${agentCommission?.earnedCommission + totalCurrentEarnedCommission}"></g:set>
							</g:if>
							<g:if test="${agentCommission?.commissionPaid}">
								<g:set var="totalPaidToAgent" value="${agentCommission?.commissionPaid + totalPaidToAgent}"></g:set>
							</g:if>

						</g:each>

						<g:set var="totalEndingBalance1" value="${totalEarnedCommission - totalPaid}"></g:set>
              
                <tr>
                  <td>${agentMasterInstance?.agentCommissions?.policyType[0]}</td>
                  <td class="text-right">${totalIncomeCommissionable}</td>
                  <td class="text-right">${totalEarnedCommission}</td>
                  <td class="text-right">-${totalPaid}</td>
                  <td class="text-right">${totalEndingBalance1}</td>                
                </tr> 
              </tbody>
            </table>

            <table class="table table-bordered table-striped table-condensed">
              <tbody>
                <tr>
                  <td class="bold text-right">Balance Forward</td>
                  <td class="text-right">${totalBalanceForward}</td>
                </tr>
                <tr>
                  <td class="bold text-right">Current Earned Commissions</td>
                  <td class="text-right">${totalCurrentEarnedCommission}</td>
                </tr>
                <tr>
                  <td class="bold text-right">Paid To Agent</td>
                  <td class="text-right">-${totalPaidToAgent}</td>
                </tr>
                <tr>
                  <td class="bold text-right">Ending Balance</td>
                  <td class="text-right">${totalEndingBalance2}</td>
                </tr>                                               
              </tbody>
            </table>
          </div>
        </div>

		 <div class="fms_widget">
          <h3>Group Recap</h3>
          <div class="table-responsive fms_table_wrapper">
            <table class="table table-bordered tablesorter-fms table-condensed">
              <thead>                        
                <tr>
                  <th>Group Name</th>
                  <th>Group Number</th>
                  <th class="text-right">Dental</th>
                </tr>
              </thead>
              <tbody>
              <g:set var="totalCommissionPaid" value="${0.00}"></g:set>
			  <g:each in="${agentMasterInstance?.agentCommissions}" var="agentCommission" status="k">
                <tr>
                  <td>${agentCommission?.groupName}</td>
                  <td>${agentCommission?.groupId}</td>
                  <td class="text-right"><g:formatNumber	number="${agentCommission?.commissionPaid}"	format="###,##0.00" /></td>
                </tr>
               <g:if test="${agentCommission?.commissionPaid}">
								<g:set var="totalCommissionPaid" value="${agentCommission?.commissionPaid + totalCommissionPaid}"></g:set>
							</g:if>
				</g:each>
              </tbody>
              <tfoot>
                <tr>
                  <td colspan="2" class="text-right bold"> Total Commissions</td>
                  <td class="text-right bold">${totalCommissionPaid}</td>
                </tr>
              </tfoot>
            </table>
          </div>
        </div>
          
          </g:if>
          <g:else>
				NO STATEMENT AVAILABLE
				
	    </g:else>
      </div>
      <br />
		<br />
		<g:form>
			<div class="fms_form_button">
				<input type="button" class="btn btn-default" value="Close" onClick="closeForm()" />
			</div>
		</g:form>
	

</html>

    