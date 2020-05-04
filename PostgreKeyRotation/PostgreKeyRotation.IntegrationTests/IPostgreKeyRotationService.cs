// Copyright (c) Microsoft Corporation.
// Licensed under the MIT license.

using PostgreKeyRotation.Models;
using Refit;
using System.Threading.Tasks;

namespace PostgreKeyRotation.IntegrationTests
{
    public interface IPostgreKeyRotationService
    {
        [Get("/postgresql/")]
        Task<PostgreSQLConnectResult> GetResultAsync();
    }
}
