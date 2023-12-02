using Newtonsoft.Json;
using System;
using System.Collections.Generic;
using System.IO;
using System.Linq;
using Xunit;
using Xunit.Abstractions;

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
            PostgreSQLExecutor executor = new PostgreSQLExecutor(null);
            List<string> sqlQueries = new List<string>();

            using (var sr = new StreamReader("Resources/postgreSQLQueriesAndErrors.json"))
            {
                String jsonString;
                while ((jsonString = sr.ReadToEnd()) != "")
                {
                    List<QueryAndErrors> queriesAndErrors = JsonConvert.DeserializeObject<List<QueryAndErrors>>(jsonString);
                    foreach (QueryAndErrors queryAndErrors in queriesAndErrors)
                    {
                        output.WriteLine(queryAndErrors.ToString());
                        Comm.ParserResult parserResult = executor.Parse(queryAndErrors.Query, new Comm.CaretPosition { Line = 0, Column = 0, Offset = 0 });
                        List<Comm.ParserWarning> warnings = new List<Comm.ParserWarning>();
                        foreach (var command in parserResult.Commands)
                        {
                            warnings.AddRange(command.Warnings);
                        }
                        output.WriteLine("Errors present: " + String.Join(", ", warnings.Select(c => c.Type.ToString()).ToArray()));
                        foreach (var error in queryAndErrors.Errors)
                        {
                            Assert.Contains(warnings, warning => warning.Type.ToString().Equals(error));
                        }
                        output.WriteLine("");
                    }
                }
            }
            
        }
    }
}