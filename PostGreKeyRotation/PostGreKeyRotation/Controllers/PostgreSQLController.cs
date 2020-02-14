using Microsoft.AspNetCore.Mvc;
using Microsoft.Extensions.Logging;
using Microsoft.Extensions.Options;
using Npgsql;
using PostGreKeyRotation.Models;
using System;
using System.Collections.Generic;
using System.IO;
using System.Threading.Tasks;

namespace PostGreKeyRotation.Controllers
{
    [ApiController]
    [Route("[controller]")]
    public class PostgreSQLController
        : ControllerBase
    {
        private readonly ILogger<PostgreSQLController> logger;
        private readonly PostgreSQLControllerConfig postgreSQLControllerConfig;
        private string pwd;
        private string connectionString;

        public PostgreSQLController(ILogger<PostgreSQLController> logger,
            IOptions<PostgreSQLControllerConfig> options)
        {
            _ = options ?? throw new ArgumentNullException(nameof(options));

            this.logger = logger;
            this.postgreSQLControllerConfig = options.Value;
        }

        private async Task<string> GetConnectionStringAsync()
        {
            if (connectionString == null)
            {
                var mountFileInfo = new FileInfo(postgreSQLControllerConfig.ConnectionStringPwdMountPoint);
                if (mountFileInfo.Exists)
                {
                    using var textReader = mountFileInfo.OpenText();
                    pwd = await textReader.ReadToEndAsync();
                    connectionString = postgreSQLControllerConfig.ConnectionStringTemplate
                        .Replace("{RoleName}", postgreSQLControllerConfig.ConnectionStringRoleName)
                        .Replace("{Pwd}", pwd);
                }
                else
                {
                    throw new InvalidOperationException($"Environment Variables are not set for PostgreSQLController.");
                }
            }

            return connectionString;
        }

        [HttpGet]
        public async Task<PostgreSQLConnectResult> Get()
        {
            try
            {

                var result = new PostgreSQLConnectResult
                {
                    SecretMountPoint = postgreSQLControllerConfig.ConnectionStringPwdMountPoint
                };

                using (var conn = new NpgsqlConnection(await GetConnectionStringAsync()))
                {
                    result.SecretValue = $"FOR DEMO PURPOSES ONLY, NEVER DO THIS IN PRODUCTION!:  {pwd}";

                    conn.Open();
                    using var cmd = new NpgsqlCommand("select * from testdata", conn);
                    using var dr = cmd.ExecuteReader();
                    var users = new List<SimpleUser>();

                    while (dr.Read())
                    {
                        users.Add(new SimpleUser()
                        {
                            Id = dr.GetInt32(0),
                            FirstName = dr.GetString(1),
                            LastName = dr.GetString(2)
                        });
                    }
                    result.Users = users;
                }

                return result;
            }
            catch (Exception ex)
            {
                logger.LogError($"Exception getting data from Postgre: {ex}");
                throw;
            }
        }
    }
}
