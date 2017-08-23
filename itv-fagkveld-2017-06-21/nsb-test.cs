[TestFixture]
public class When_started : SagaScenario<CommissionMultiplePolicyPeriodsSaga, CommissionSagaData, DecomissionVehicleCommand>
{
    // ... 

    public override void Given()
    {
        A.CallTo(() => Dependency<IPolicyConseilService>().GetMultiplePolicyVersionsPerPeriod(_policyNumber))
            .Returns(ResponseWithOneDraft());
    }

    public override DecomissionVehicleCommand When()
    {
        return new DecomissionVehicleCommand { CorrelationId = _correlationId, PolicyNumber = _policyNumber, DateOfChange = _cancellationDate };
    }

    [Then]
    public void Delete_policy_draft()
    {
        SentMessages<DeletePolicyDraftCommand>().Count(p => p.PolicyId == _draftId).Should().Be(1);
    }

    [Then]
    public void Specify_correlation_id()
    {
        SentMessages<DeletePolicyDraftCommand>().All(x => x.CorrelationId == _correlationId).Should().Be(true);
    }

    [Then]
    public void Do_not_complete_saga()
    {
        SagaCompleted().Should().BeFalse();
    }
}


