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
using System.Security.Principal;
using System.Text;
using System.Threading.Tasks;
using Testcontainers.PostgreSql;
using Xunit;
using Xunit.Abstractions;
using static System.Net.Mime.MediaTypeNames;

namespace NppDB.PostgreSQL.Tests
{
    public class UnitTest2
    {
        private readonly ITestOutputHelper output;

        public UnitTest2(ITestOutputHelper output)
        {
            this.output = output;
        }

        [Fact]
        public void Test2()
        {
            PostgreSQLExecutor postgreSQLExecutor = new PostgreSQLExecutor(null);
            List<string> sqlQueries = new List<string>();
            using (var sr = new StreamReader("Resources/queries.sql"))
            {
                String line;
                while ((line = sr.ReadLine()) != null)
                {
                    if (!String.IsNullOrEmpty(line))
                    {
                        output.WriteLine(line);
                        Comm.ParserResult parserResult = postgreSQLExecutor.Parse(line, new Comm.CaretPosition { Line = 0, Column = 0, Offset = 0 });
                        output.WriteLine(parserResult.Errors.Count.ToString());
                    }
                }
            }
            
        }
    }
}