namespace Promotion
{
    public class Fight
    {
        public int Code { get; set; }
        public string FIO1 { get; set; }
        public string FIO2 { get; set; }
        public string Tournament { get; set; }
        public string Date { get; set; }
        public string Weight { get; set; }
        public string Winner { get; set; }
        public string Result { get; set; }
        public byte? Round { get; set; }
        public string Time { get; set; }
        public string Status { get; set; }
        public byte? Number { get; set; }

        public Fight(int code, string fio1, string fio2, string tour, string date, string weight,
            string winner, string result, byte? round, string time, string status, byte? number)
        {
            Code = code; FIO1 = fio1; FIO2 = fio2; Tournament = tour; Date = date; Weight = weight;
            Winner = winner; Result = result; Round = round; Time = time; Status = status; Number = number;
        }
        public Fight() { }
    }
}
