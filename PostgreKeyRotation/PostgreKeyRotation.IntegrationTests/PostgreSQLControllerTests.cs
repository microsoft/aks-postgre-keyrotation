using FluentAssertions;
using PostgreKeyRotation.Models;
using Refit;
using System.Collections.Generic;
using System.Threading.Tasks;
using Xunit;

namespace PostgreKeyRotation.IntegrationTests
{
    public class PostgreSQLControllerTests
    {
        [Fact]
        public async Task CanCallGetWithoutIssue()
        {
            var PostgreSqlService = RestService.For<IPostgreKeyRotationService>("http://stage-rotate.contoso.com/");
            var PostgreSqlConnectResult = await PostgreSqlService.GetResultAsync();

            var listOfUsers = new List<SimpleUser>()
            {
                new SimpleUser() { Id = 1, FirstName = "John", LastName = "Doe" },
                new SimpleUser() { Id = 2, FirstName = "Jane", LastName = "Doe" },
            };

            PostgreSqlConnectResult.SecretMountPoint.Should().NotBeNullOrEmpty();
            PostgreSqlConnectResult.Users.Should().BeEquivalentTo(listOfUsers);
        }
    }
}
