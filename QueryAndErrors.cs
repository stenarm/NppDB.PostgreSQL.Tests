using System;
using System.Collections.Generic;
using static System.Windows.Forms.VisualStyles.VisualStyleElement;

namespace NppDB.PostgreSQL.Tests
{
    public class QueryAndErrors
    {
        public String Query { get; set; }
        public List<String> Errors { get; set; }

        public override string ToString()
        {
            return "Query: " + Query + ".\nExpected errors: " + String.Join(", ", Errors.ToArray()); ;
        }
    }
}
