using System.Data.SqlClient;

namespace Activity7.Database
{
    public class DatabaseConnection
    {
        private string connectionString =
            "Server=localhost;Database=activity7;Trusted_Connection=True;TrustServerCertificate=True;";

        public SqlConnection GetConnection()
        {
            return new SqlConnection(connectionString);
        }
    }
}