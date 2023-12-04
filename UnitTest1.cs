using Docker.DotNet.Models;
using DotNet.Testcontainers.Builders;
using DotNet.Testcontainers.Configurations;
using System;
using System.Collections;
using System.Collections.Generic;
using System.Data;
using System.Data.Odbc;
using System.Diagnostics;
using System.IO;
using System.Linq;
using System.Security.Principal;
using System.Text;
using System.Threading.Tasks;
using Testcontainers.PostgreSql;
using Xunit;
using Xunit.Abstractions;
using static System.Net.Mime.MediaTypeNames;

namespace NppDB.PostgreSQL.Tests
{
    public class UnitTest1 : IAsyncLifetime
    {
        private readonly ITestOutputHelper output;

        public UnitTest1(ITestOutputHelper output)
        {
            this.output = output;
        }

        private readonly PostgreSqlContainer _postgreSqlContainer = new PostgreSqlBuilder()
            .WithImage("postgres:16")
            .WithDatabase("db")
            .WithUsername("sa")
            .WithPassword("sa")
            .WithResourceMapping(new FileInfo("Resources/PostgreSQL_Scott_json.sql"), "/docker-entrypoint-initdb.d/")
            .WithCleanUp(true)
            .Build();

        public async Task InitializeAsync()
        {
            await _postgreSqlContainer.StartAsync();
        }

        [Fact]
        public async Task Test1()
        {
            PostgreSQLConnect connect = new PostgreSQLConnect
            {
                Account = "sa",
                Password = "sa",
                Database = "db",
                ServerAddress = "127.0.0.1",
                Port = _postgreSqlContainer.GetMappedPublicPort("5432").ToString()
            };
            Comm.ISQLExecutor executor = connect.CreateSQLExecutor();
            using (var sr = new StreamReader("Resources/queries.sql"))
            {
                String line;
                while ((line = sr.ReadToEnd()) != "")
                {
                    if (!String.IsNullOrEmpty(line))
                    {
                        Comm.ParserResult parserResult = executor.Parse(line, new Comm.CaretPosition { Line = 0, Column = 0, Offset = 0 });
                        output.WriteLine(parserResult.Commands.Count.ToString());
                        var commands = parserResult.Commands.Select(c => c.Text).ToList();
                        executor.Execute(commands, (results) =>
                        {
                            foreach (var result in results)
                            {
                                output.WriteLine(result.CommandText.ToString());
                                Assert.Null(result.Error);
                            }
                        });
                    }
                }
            }
        }

        public Task DisposeAsync()
        {
            // When using this method to stop the container like shown in documentation, the container would die while test was still running
            return Task.Delay(10000);
        }
    }
}