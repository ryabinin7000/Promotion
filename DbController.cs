using System;
using System.Collections.Generic;
using System.Data;
using System.Data.SqlClient;
using System.Windows.Forms;

namespace Promotion
{
    public class DbController
    {
        private string ConnectionString;
        public DbController(string connectString)
        {
            ConnectionString = connectString;
        }

        //Получение данных о бойцах из БД
        public List<Fighter> GetFighters()
        {
            string procName = "FightersInfo";
            List<Fighter> fighters = new List<Fighter>();
            SqlConnection sqlConnection = new SqlConnection(ConnectionString);
            SqlCommand command = sqlConnection.CreateCommand();
            command.CommandText = procName;
            command.CommandType = CommandType.StoredProcedure;
            sqlConnection.Open();
            SqlDataReader reader = command.ExecuteReader();
            while (reader.Read())
            {
                    fighters.Add(new Fighter((int)reader[0], reader[1].ToString(), 
                        string.IsNullOrEmpty(reader[2].ToString())? reader[2].ToString():
                            reader[2].ToString().Substring(0, reader[2].ToString().Length - 8),
                        reader[3].ToString(), reader[4].ToString(), (byte)reader[5],
                        string.IsNullOrEmpty(reader[6].ToString()) ? reader[6].ToString() :
                            reader[6].ToString().Substring(0, reader[6].ToString().Length - 8),
                        string.IsNullOrEmpty(reader[7].ToString()) ? reader[7].ToString() :
                            reader[7].ToString().Substring(0, reader[7].ToString().Length - 8),
                        reader[8].ToString(), reader[9].ToString(), reader[10].ToString(),
                        reader[11].ToString(), (int)reader[12], (int)reader[13], (double)reader[14],
                        (double)reader[15], (double)reader[16]));             
            }
            reader.Close();
            sqlConnection.Close();
            return fighters;
        }
        //Добавление данных о бойцах в БД
        public void InsertFighter(string fio, string bdate, string country, string citizen,
            byte seniority, string phone, string email, string pass, string address,
            float weight, float height, float reach)
        {
            string procName = "FightersInsert";
            SqlConnection sqlConnection = new SqlConnection(ConnectionString);
            SqlCommand command = sqlConnection.CreateCommand();
            command.CommandText = procName;
            command.CommandType = CommandType.StoredProcedure;
            command.Parameters.Add("@seniority", SqlDbType.TinyInt).Value = seniority;
            command.Parameters.Add("@fio", SqlDbType.VarChar).Value = fio;
            command.Parameters.Add("@bdate", SqlDbType.VarChar).Value = bdate;
            command.Parameters.Add("@country", SqlDbType.VarChar).Value = country;
            command.Parameters.Add("@weight", SqlDbType.Float).Value = weight;
            command.Parameters.Add("@height", SqlDbType.Float).Value = height;
            command.Parameters.Add("@reach", SqlDbType.Float).Value = reach;
            command.Parameters.Add("@citizen", SqlDbType.VarChar).Value = citizen;
            command.Parameters.Add("@pass", SqlDbType.VarChar).Value = pass;
            command.Parameters.Add("@phone", SqlDbType.VarChar).Value = phone;
            command.Parameters.Add("@email", SqlDbType.VarChar).Value = email;
            command.Parameters.Add("@address", SqlDbType.VarChar).Value = address;
            sqlConnection.Open();
            int counter = command.ExecuteNonQuery();
            if (counter == 0)
                MessageBox.Show("Ошибка вставки в таблицу \"Боец\". +" +
                    "Проверьте корректность введенных данных.",
                    "Ошибка", MessageBoxButtons.OK, MessageBoxIcon.Error);
            else
                MessageBox.Show("Запись добавлена", "Добавление записи", 
                    MessageBoxButtons.OK, MessageBoxIcon.Information);
            sqlConnection.Close();
        }
        //Обновление данных о бойце в БД
        public void UpdateFighter(int code, string fio, string bdate, string country, 
            string citizen, byte seniority, string phone, string email, string pass, 
            string address, float weight, float height, float reach)
        {
            string procName = "FightersUpdate";
            SqlConnection sqlConnection = new SqlConnection(ConnectionString);
            SqlCommand command = sqlConnection.CreateCommand();
            command.CommandText = procName;
            command.CommandType = CommandType.StoredProcedure;
            command.Parameters.Add("@code", SqlDbType.Int).Value = code;
            command.Parameters.Add("@seniority", SqlDbType.TinyInt).Value = seniority;
            command.Parameters.Add("@fio", SqlDbType.VarChar).Value = fio;
            command.Parameters.Add("@bdate", SqlDbType.VarChar).Value = bdate;
            command.Parameters.Add("@country", SqlDbType.VarChar).Value = country;
            command.Parameters.Add("@weight", SqlDbType.Float).Value = weight;
            command.Parameters.Add("@height", SqlDbType.Float).Value = height;
            command.Parameters.Add("@reach", SqlDbType.Float).Value = reach;
            command.Parameters.Add("@citizen", SqlDbType.VarChar).Value = citizen;
            command.Parameters.Add("@pass", SqlDbType.VarChar).Value = pass;
            command.Parameters.Add("@phone", SqlDbType.VarChar).Value = phone;
            command.Parameters.Add("@email", SqlDbType.VarChar).Value = email;
            command.Parameters.Add("@address", SqlDbType.VarChar).Value = address;
            sqlConnection.Open();
            int counter = command.ExecuteNonQuery();
            if (counter == 0)
                MessageBox.Show("Ошибка обновления таблицы \"Боец\". " +
                    "Проверьте корректность введенных данных.",
                    "Ошибка", MessageBoxButtons.OK, MessageBoxIcon.Error);
            else
                MessageBox.Show("Запись обновлена", "Обновление записи", 
                    MessageBoxButtons.OK, MessageBoxIcon.Information);
            sqlConnection.Close();
        }
        //Удаление данных о бойце из БД
        public void DeleteFighter(int code)
        {
            string procName = "FightersDelete";
            SqlConnection sqlConnection = new SqlConnection(ConnectionString);
            SqlCommand command = sqlConnection.CreateCommand();
            command.CommandText = procName;
            command.CommandType = CommandType.StoredProcedure;
            command.Parameters.Add("@code", SqlDbType.Int).Value = code;
            sqlConnection.Open();
            command.ExecuteNonQuery();
            sqlConnection.Close();
        }

        //Поединки
        public List<Fight> GetFights()
        {
            string procName = "FightsInfo";
            List<Fight> fights = new List<Fight>();
            SqlConnection sqlConnection = new SqlConnection(ConnectionString);
            SqlCommand command = sqlConnection.CreateCommand();
            command.CommandText = procName;
            command.CommandType = CommandType.StoredProcedure;
            sqlConnection.Open();
            SqlDataReader reader = command.ExecuteReader();
            while (reader.Read())
            {
                fights.Add(new Fight((int)reader[0], reader[1].ToString(), 
                    reader[2].ToString(), reader[3].ToString(),
                    string.IsNullOrEmpty(reader[4].ToString()) ? reader[4].ToString() :
                            reader[4].ToString().Substring(0, reader[4].ToString().Length - 8),
                    reader[5].ToString(), reader[6].ToString(),
                    reader[7].ToString(), !reader.IsDBNull(8) ? (byte?)reader[8] : null,
                    string.IsNullOrEmpty(reader[9].ToString()) ? reader[9].ToString() :
                            reader[9].ToString().Substring(4, reader[9].ToString().Length - 4),
                    reader[10].ToString(), !reader.IsDBNull(11) ? (byte?)reader[11] : null));
            }
            reader.Close();
            sqlConnection.Close();
            return fights;
        }
        public void InsertFight(string fio1, string fio2, string tour, string weight,
             string winner, string result, byte? round, string time, char status, byte? number)
        {
            TimeSpan timeSpan = string.IsNullOrEmpty(time) ? TimeSpan.Zero :
                TimeSpan.TryParseExact(time, new[] { "hh':'mm':'ss", "h':'mm':'ss", "mm':'ss",
                    "m':'ss", "mm':'ss\\.fffffff", "m':'ss\\.fffffff", "hh':'mm':'ss\\.fffffff",
                    "h':'mm':'ss\\.fffffff", "hh' 'mm' 'ss", "h' 'mm' 'ss", "mm' 'ss",
                    "m' 'ss", "mm' 'ss\\.fffffff", "m' 'ss\\.fffffff", "hh' 'mm' 'ss\\.fffffff",
                    "h' 'mm' 'ss\\.fffffff", "hh'-'mm'-'ss", "h'-'mm'-'ss", "mm'-'ss",
                    "m'-'ss", "mm'-'ss\\.fffffff", "m'-'ss\\.fffffff", "hh'-'mm'-'ss\\.fffffff",
                    "h'-'mm'-'ss\\.fffffff" },
                null, out timeSpan) ? timeSpan : TimeSpan.Zero;
            string procName = "FightsInsert";
            SqlConnection sqlConnection = new SqlConnection(ConnectionString);
            SqlCommand command = sqlConnection.CreateCommand();
            command.CommandText = procName;
            command.CommandType = CommandType.StoredProcedure;
            command.Parameters.Add("@fio1", SqlDbType.VarChar).Value = fio1;
            command.Parameters.Add("@fio2", SqlDbType.VarChar).Value = fio2;
            command.Parameters.Add("@event", SqlDbType.VarChar).Value = tour;
            command.Parameters.Add("@weight", SqlDbType.VarChar).Value = weight;
            command.Parameters.Add("@winner", SqlDbType.Bit).Value =
                (winner != fio1 && winner != fio2) ? (object)DBNull.Value : (winner == fio1 ? 0 : 1);
            command.Parameters.Add("@result", SqlDbType.VarChar).Value = result == null ? 
                (object)DBNull.Value : result;
            command.Parameters.Add("@round", SqlDbType.TinyInt).Value = round==0? 
                (object)DBNull.Value : round;
            command.Parameters.Add("@time", SqlDbType.Time).Value = timeSpan == TimeSpan.Zero? 
                (object)DBNull.Value : timeSpan;
            command.Parameters.Add("@status", SqlDbType.Char).Value = status;
            command.Parameters.Add("@number", SqlDbType.TinyInt).Value = number == null ? 
                (object)DBNull.Value : number;
            sqlConnection.Open();
            int counter = command.ExecuteNonQuery();
            if (counter == 0)
                MessageBox.Show("Ошибка вставки в таблицу \"Поединок\". " +
                    "Проверьте корректность введенных данных.",
                    "Ошибка", MessageBoxButtons.OK, MessageBoxIcon.Error);
            else
                MessageBox.Show("Запись добавлена", "Добавление записи", 
                    MessageBoxButtons.OK, MessageBoxIcon.Information);
            sqlConnection.Close();
        }
        public void UpdateFight(int code, string fio1, string fio2, string tour, string weight,
             string winner, string result, byte? round, string time, char status, byte? number)
        {
            TimeSpan timeSpan = string.IsNullOrEmpty(time) ? TimeSpan.Zero :
                TimeSpan.TryParseExact(time, new[] { "hh':'mm':'ss", "h':'mm':'ss", "mm':'ss", 
                    "m':'ss", "mm':'ss\\.fffffff", "m':'ss\\.fffffff", "hh':'mm':'ss\\.fffffff", 
                    "h':'mm':'ss\\.fffffff", "hh' 'mm' 'ss", "h' 'mm' 'ss", "mm' 'ss",
                    "m' 'ss", "mm' 'ss\\.fffffff", "m' 'ss\\.fffffff", "hh' 'mm' 'ss\\.fffffff",
                    "h' 'mm' 'ss\\.fffffff", "hh'-'mm'-'ss", "h'-'mm'-'ss", "mm'-'ss",
                    "m'-'ss", "mm'-'ss\\.fffffff", "m'-'ss\\.fffffff", "hh'-'mm'-'ss\\.fffffff",
                    "h'-'mm'-'ss\\.fffffff" },
                null, out timeSpan) ? timeSpan : TimeSpan.Zero;
            string procName = "FightsUpdate";
            SqlConnection sqlConnection = new SqlConnection(ConnectionString);
            SqlCommand command = sqlConnection.CreateCommand();
            command.CommandText = procName;
            command.CommandType = CommandType.StoredProcedure;
            command.Parameters.Add("@code", SqlDbType.Int).Value = code;
            command.Parameters.Add("@fio1", SqlDbType.VarChar).Value = fio1;
            command.Parameters.Add("@fio2", SqlDbType.VarChar).Value = fio2;
            command.Parameters.Add("@event", SqlDbType.VarChar).Value = tour;
            command.Parameters.Add("@weight", SqlDbType.VarChar).Value = weight;
            command.Parameters.Add("@winner", SqlDbType.Bit).Value =
                (winner != fio1 && winner != fio2) ? (object)DBNull.Value : (winner == fio1 ? 0 : 1);
            command.Parameters.Add("@result", SqlDbType.VarChar).Value = result == null ? 
                (object)DBNull.Value : result;
            command.Parameters.Add("@round", SqlDbType.TinyInt).Value = round == 0 ? 
                (object)DBNull.Value : round;
            command.Parameters.Add("@time", SqlDbType.Time).Value = timeSpan == TimeSpan.Zero ?
                (object)DBNull.Value : timeSpan;
            command.Parameters.Add("@status", SqlDbType.Char).Value = status;
            command.Parameters.Add("@number", SqlDbType.TinyInt).Value = number == null ? 
                (object)DBNull.Value : number;
            sqlConnection.Open();
            int counter = command.ExecuteNonQuery();
            if (counter == 0)
                MessageBox.Show("Ошибка обновления таблицы \"Боец\". " +
                    "Проверьте корректность введенных данных.", "Ошибка", 
                    MessageBoxButtons.OK, MessageBoxIcon.Information);
            else
                MessageBox.Show("Запись обновлена", "Обновление записи", 
                    MessageBoxButtons.OK, MessageBoxIcon.Information);
            sqlConnection.Close();
        }
        public void DeleteFight(int code)
        {
            string procName = "FightsDelete";
            SqlConnection sqlConnection = new SqlConnection(ConnectionString);
            SqlCommand command = sqlConnection.CreateCommand();
            command.CommandText = procName;
            command.CommandType = CommandType.StoredProcedure;
            command.Parameters.Add("@code", SqlDbType.Int).Value = code;
            sqlConnection.Open();
            int counter = command.ExecuteNonQuery();
            sqlConnection.Close();
        }

        //Турниры
        public List<Tournament> GetEvents()
        {
            string procName = "EventsInfo";
            List<Tournament> events = new List<Tournament>();
            SqlConnection sqlConnection = new SqlConnection(ConnectionString);
            SqlCommand command = sqlConnection.CreateCommand();
            command.CommandText = procName;
            command.CommandType = CommandType.StoredProcedure;
            sqlConnection.Open();
            SqlDataReader reader = command.ExecuteReader();
            while (reader.Read())
            {
                events.Add(new Tournament(reader[0].ToString(), reader[1].ToString(), 
                    reader[2].ToString().Substring(0, reader[2].ToString().Length -8),
                    !reader.IsDBNull(3) ? (int?)reader[3] : null, !reader.IsDBNull(4)?(int?)reader[4]:null,
                    !reader.IsDBNull(5) ? decimal.Round((decimal)reader[5], 2) : (decimal?)null, 
                    !reader.IsDBNull(6) ? decimal.Round((decimal)reader[6], 2) : (decimal?)null,
                    !reader.IsDBNull(7) ? decimal.Round((decimal)reader[7], 2) : (decimal?)null, 
                    !reader.IsDBNull(8) ? decimal.Round((decimal)reader[8], 2) : (decimal?)null));
            }
            reader.Close();
            sqlConnection.Close();
            return events;
        }
        public void InsertEvent(string name, string arena, 
            string date, int attend, decimal revenue, decimal costs)
        {
            string procName = "EventsInsert";
            SqlConnection sqlConnection = new SqlConnection(ConnectionString);
            SqlCommand command = sqlConnection.CreateCommand();
            command.CommandText = procName;
            command.CommandType = CommandType.StoredProcedure;
            command.Parameters.Add("@name", SqlDbType.VarChar).Value = name;
            command.Parameters.Add("@place", SqlDbType.VarChar).Value = arena;
            command.Parameters.Add("@date", SqlDbType.Date).Value = date;
            command.Parameters.Add("@attend", SqlDbType.Int).Value = attend == 0 ?
                (object)DBNull.Value : attend;
            command.Parameters.Add("@revenue", SqlDbType.Money).Value = revenue == 0 ?
                (object)DBNull.Value : revenue;
            command.Parameters.Add("@costs", SqlDbType.Money).Value = costs == 0 ? 
                (object)DBNull.Value : costs;
            sqlConnection.Open();
            int counter = command.ExecuteNonQuery();
            if (counter != 1)
                MessageBox.Show("Ошибка вставки в таблицу \"Турнир\". " +
                    "Проверьте корректность введенных данных.",
                    "Ошибка", MessageBoxButtons.OK, MessageBoxIcon.Error);
            else
                MessageBox.Show("Запись добавлена", "Добавление записи", 
                    MessageBoxButtons.OK, MessageBoxIcon.Information);
            sqlConnection.Close();
        }
        public void UpdateEvent(string name, string arena,
            string date, int attend, decimal revenue, decimal costs)
        {
            string procName = "EventsUpdate";
            SqlConnection sqlConnection = new SqlConnection(ConnectionString);
            SqlCommand command = sqlConnection.CreateCommand();
            command.CommandText = procName;
            command.CommandType = CommandType.StoredProcedure;
            command.Parameters.Add("@name", SqlDbType.VarChar).Value = name;
            command.Parameters.Add("@place", SqlDbType.VarChar).Value = arena;
            command.Parameters.Add("@date", SqlDbType.Date).Value = date;
            command.Parameters.Add("@attend", SqlDbType.Int).Value = attend == 0 ? 
                (object)DBNull.Value : attend;
            command.Parameters.Add("@revenue", SqlDbType.Money).Value = revenue == 0 ? 
                (object)DBNull.Value : revenue;
            command.Parameters.Add("@costs", SqlDbType.Money).Value = costs == 0 ? 
                (object)DBNull.Value : costs;
            sqlConnection.Open();
            int counter = command.ExecuteNonQuery();
            if (counter != 1)
                MessageBox.Show("Ошибка обновления таблицы \"Турниры\". " +
                    "Проверьте корректность введенных данных.",
                    "Ошибка", MessageBoxButtons.OK, MessageBoxIcon.Error);
            else
                MessageBox.Show("Запись обновлена", "Обновление записи", 
                    MessageBoxButtons.OK, MessageBoxIcon.Information);
            sqlConnection.Close();
        }
        public void DeleteEvent(string name)
        {
            string procName = "EventsDelete";
            SqlConnection sqlConnection = new SqlConnection(ConnectionString);
            SqlCommand command = sqlConnection.CreateCommand();
            command.CommandText = procName;
            command.CommandType = CommandType.StoredProcedure;
            command.Parameters.Add("@name", SqlDbType.VarChar).Value = name;
            sqlConnection.Open();
            command.ExecuteNonQuery();
            sqlConnection.Close();
        }

        //Для ComboBox
        public List<string> GetArenas()
        {
            string query = "SELECT Название FROM Арена";
            List<string> arenas = new List<string>();
            SqlConnection sqlConnection = new SqlConnection(ConnectionString);
            SqlCommand command = sqlConnection.CreateCommand();
            command.CommandText = query;
            command.CommandType = CommandType.Text;
            sqlConnection.Open();
            SqlDataReader reader = command.ExecuteReader();
            while (reader.Read())
                arenas.Add((string)reader[0]);
            reader.Close();
            sqlConnection.Close();
            return arenas;
        }
        public List<string> GetWeights()
        {
            string query = "SELECT [Весовая категория] FROM ВесоваяКатегория";
            List<string> weights = new List<string>();
            SqlConnection sqlConnection = new SqlConnection(ConnectionString);
            SqlCommand command = sqlConnection.CreateCommand();
            command.CommandText = query;
            command.CommandType = CommandType.Text;
            sqlConnection.Open();
            SqlDataReader reader = command.ExecuteReader();
            while (reader.Read())
                weights.Add((string)reader[0]);
            reader.Close();
            sqlConnection.Close();
            return weights;
        }

        public List<string> GetResults()
        {
            string query = "SELECT Результат FROM Результат";
            List<string> results = new List<string>();
            SqlConnection sqlConnection = new SqlConnection(ConnectionString);
            SqlCommand command = sqlConnection.CreateCommand();
            command.CommandText = query;
            command.CommandType = CommandType.Text;
            sqlConnection.Open();
            SqlDataReader reader = command.ExecuteReader();
            while (reader.Read())
                results.Add((string)reader[0]);
            reader.Close();
            sqlConnection.Close();
            return results;
        }

        //Для представлений
        public List<Champion> GetChamps()
        {
            string query = "SELECT * FROM V_Champs";
            List<Champion> champions = new List<Champion>();
            SqlConnection sqlConnection = new SqlConnection(ConnectionString);
            SqlCommand command = sqlConnection.CreateCommand();
            command.CommandText = query;
            command.CommandType = CommandType.Text;
            sqlConnection.Open();
            SqlDataReader reader = command.ExecuteReader();
            while (reader.Read())
                champions.Add(new Champion((int)reader[0], reader[1].ToString(),
                    reader[2].ToString(), string.IsNullOrEmpty(reader[3].ToString()) ?
                    reader[3].ToString() :
                    reader[3].ToString().Substring(0, reader[3].ToString().Length - 8)));
            reader.Close();
            sqlConnection.Close();
            return champions;
        }
        public List<Contract> GetContracts()
        {
            string query = "SELECT * FROM V_Contracts";
            List<Contract> contracts = new List<Contract>();
            SqlConnection sqlConnection = new SqlConnection(ConnectionString);
            SqlCommand command = sqlConnection.CreateCommand();
            command.CommandText = query;
            command.CommandType = CommandType.Text;
            sqlConnection.Open();
            SqlDataReader reader = command.ExecuteReader();
            while (reader.Read())
                contracts.Add(new Contract(reader[0].ToString(), (int)reader[1],
                    reader[2].ToString(), (byte)reader[3], (byte)reader[4],
                    decimal.Round((decimal)reader[5], 2),
                    decimal.Round((decimal)reader[6], 2),
                    decimal.Round((decimal)reader[7], 2),
                    (double)reader[8],
                    string.IsNullOrEmpty(reader[9].ToString()) ?
                        reader[9].ToString() :
                            reader[9].ToString().Substring(0,
                                reader[9].ToString().Length - 8),
                    string.IsNullOrEmpty(reader[10].ToString()) ?
                        reader[10].ToString() :
                            reader[10].ToString().Substring(0,
                                reader[10].ToString().Length - 8)));
            reader.Close();
            sqlConnection.Close();
            return contracts;
        }
        public List<Award> GetAwards()
        {
            string query = "SELECT * FROM V_Awards";
            List<Award> awards = new List<Award>();
            SqlConnection sqlConnection = new SqlConnection(ConnectionString);
            SqlCommand command = sqlConnection.CreateCommand();
            command.CommandText = query;
            command.CommandType = CommandType.Text;
            sqlConnection.Open();
            SqlDataReader reader = command.ExecuteReader();
            while (reader.Read())
                awards.Add(new Award((int)reader[0], reader[1].ToString(),
                    reader[2].ToString(), reader[3].ToString(), 
                    string.IsNullOrEmpty(reader[4].ToString()) ? reader[4].ToString() :
                        reader[4].ToString().Substring(0, 
                            reader[4].ToString().Length - 8), 
                    reader[5].ToString(), reader[6].ToString(), 
                        decimal.Round((decimal)reader[7], 2)));
            reader.Close();
            sqlConnection.Close();
            return awards;
        }
    }
}
