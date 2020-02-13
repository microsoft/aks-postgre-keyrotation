using FluentAssertions;
using PostGreKeyRotation.Models;
using Refit;
using System.Collections.Generic;
using System.Threading.Tasks;
using Xunit;

namespace PostGreKeyRotation.IntegrationTests
{
    public class PostgreSQLControllerTests
    {
        [Fact]
        public async Task CanCallGetWithoutIssue()
        {
            var postgreSqlService = RestService.For<IPostGreKeyRotationService>("http://stage-rotate.contoso.com/");
            var postgreSqlConnectResult = await postgreSqlService.GetResultAsync();

            var listOfUsers = new List<SimpleUser>()
            {
                new SimpleUser() { Id = 1, FirstName = "John", LastName = "Doe" },
                new SimpleUser() { Id = 2, FirstName = "Jane", LastName = "Doe" },
            };

            postgreSqlConnectResult.SecretMountPoint.Should().NotBeNullOrEmpty();
            postgreSqlConnectResult.Users.Should().BeEquivalentTo(listOfUsers);
        }
    }
}
