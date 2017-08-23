[TestFixture]
public class When_started: SagaScenario<CommissionMultiplePolicyPeriodsSaga, CommissionSagaData, DecomissionVehicleCommand>
{
    private string _policyNumber = "policynumber";
    private string _inforcePolicyId = "SP001.3.1";
    private string _historicPolicyId2 = "SP001.2.1";
    private string _historicPolicyId = "SP001.1.1";
    private readonly DateTime _cancellationDate = new DateTime(1992, 5, 5);
    private readonly Guid _correlationId = Guid.NewGuid();

    public override void Given()
    {
        A.CallTo(() => Dependency<IPolicyConseilService>().GetMultiplePolicyVersionsPerPeriod(_policyNumber))
            .Returns(new MultiplePolicyPeriodResponse
            {
                InforcePolicy = new PolicyWithPeriod { PolicyId = _inforcePolicyId , PeriodStart = new DateTime(1993, 1, 3), PeriodEnd = new DateTime(1994, 1, 3)},
                PolicyDraftIds = new List<PolicyDraft>(),
                HistoricPolicies = new List<PolicyWithPeriod>
                {
                    new PolicyWithPeriod { PolicyId = _historicPolicyId2 , PeriodStart = new DateTime(1992, 1, 2), PeriodEnd = new DateTime(1993, 1, 2)},
                    new PolicyWithPeriod { PolicyId = _historicPolicyId , PeriodStart = new DateTime(1991, 1, 1), PeriodEnd = new DateTime(1992, 1, 1)}
                },
            });
    }
    public override DecomissionVehicleCommand When()
    {
        return new DecomissionVehicleCommand { CorrelationId = _correlationId, PolicyNumber = _policyNumber , DateOfChange = _cancellationDate};
    }

    [Then]
    public void Decomission_both_policies()
    {
        SentMessages<CommissionMultipleExposuresCommand>().Count(p => p.Commissionings.First().CommissionType == CommissionType.Decommissioning &&
            p.PolicyId == _inforcePolicyId).Should().Be(1);
        SentMessages<CommissionMultipleExposuresCommand>().Count(p => p.Commissionings.First().CommissionType == CommissionType.Decommissioning &&
            p.PolicyId == _historicPolicyId2).Should().Be(1);
    }

    [Then]
    public void Specify_correlation_id()
    {
        SentMessages<CommissionMultipleExposuresCommand>().All(x => x.CorrelationId == _correlationId).Should().Be(true);
    }

    [Then]
    public void Do_not_complete_saga()
    {
        SagaCompleted().Should().BeFalse();
    }
}
