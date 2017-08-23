public class When_invoked_with_a_given_state : Scenario 
{
    public override Given()
    {
        //Setup dependencies to simulate a given state (Arrange)
    }

    public override When()
    {
        //Call method, pass event etc. (Act)
    }

    [Then]
    public void Should_publish_a_given_event()
    {
        //Assert that an event of correct type is published (Assert)
    }

    [Then]
    public void Should_update_state()
    {
        //Assert some repository is updated (Assert)
    }
}


