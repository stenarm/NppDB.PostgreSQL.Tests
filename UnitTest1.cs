using System;
using System.IO;
using System.Linq;
using System.Threading.Tasks;
using NppDB.Comm;
using Testcontainers.PostgreSql;
using Xunit;
using Xunit.Abstractions;

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
            PostgreSqlConnect connect = new PostgreSqlConnect
            {
                Account = "sa",
                Password = "sa",
                Database = "db",
                ServerAddress = "127.0.0.1",
                Port = _postgreSqlContainer.GetMappedPublicPort("5432").ToString()
            };
            ISqlExecutor executor = connect.CreateSqlExecutor();
            using (var sr = new StreamReader("Resources/queries.sql"))
            {
                String line;
                while ((line = sr.ReadToEnd()) != "")
                {
                    if (!String.IsNullOrEmpty(line))
                    {
                        ParserResult parserResult = executor.Parse(line, new CaretPosition { Line = 0, Column = 0, Offset = 0 });
                        output.WriteLine(parserResult.Commands.Count.ToString());
                        var commands = parserResult.Commands.Select(c => c.Text).ToList();
                        executor.Execute(commands, results =>
                        {
                            foreach (var result in results)
                            {
                                output.WriteLine(result.CommandText);
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