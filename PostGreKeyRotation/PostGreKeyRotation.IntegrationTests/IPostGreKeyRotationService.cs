using PostGreKeyRotation.Models;
using Refit;
using System.Threading.Tasks;

namespace PostGreKeyRotation.IntegrationTests
{
    public interface IPostGreKeyRotationService
    {
        [Get("/postgresql/")]
        Task<PostgreSQLConnectResult> GetResultAsync();
    }
}
