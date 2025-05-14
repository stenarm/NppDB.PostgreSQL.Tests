using System;
using System.Collections.Generic;
using System.IO;
using System.Linq;
using Newtonsoft.Json;
using NppDB.Comm;
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
            PostgreSqlExecutor executor = new PostgreSqlExecutor(null);
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
                        ParserResult parserResult = executor.Parse(queryAndErrors.Query, new CaretPosition { Line = 0, Column = 0, Offset = 0 });
                        List<String> warnings = new List<String>();
                        foreach (var command in parserResult.Commands)
                        {
                            foreach (var warning in command.Warnings)
                            {
                                warnings.Add(warning.Type.ToString());
                            }
                        }
                        warnings = warnings.OrderBy(w => w).ToList();
                        output.WriteLine("Errors present: " + String.Join(", ", warnings)); 
                        Assert.True(warnings.SequenceEqual(queryAndErrors.Errors.OrderBy(e => e).ToList()));
                        output.WriteLine("");
                    }
                }
            }
            
        }
    }
}