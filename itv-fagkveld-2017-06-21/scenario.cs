[TestFixture]
public abstract class Scenario
{
    [SetUp]
    public void SetUp()
    {
        Given();
        When();
    }

    protected abstract void Given();
    protected abstract void When();
}

public class ThenAttribute : TestAttribute
{
}
